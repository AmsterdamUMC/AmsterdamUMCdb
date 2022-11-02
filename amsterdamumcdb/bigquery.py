import pandas as pd
import re
import os


def pg2bq(sql):
    """
    Translate a SQL query string from PostgreSQL dialect to Big Query SQL dialect
    Please note that this has only been tested with queries from this repository so your mileage may vary.

    Returns:
        dataframe:
    """

    # translate SPLIT_PART to SPLIT
    """
    PostgreSQL:
    split_part(string text, delimiter text, field int)
    Split string on delimiter and return the given field (counting from one)
    
    BigQuery: 
    SPLIT(value[, delimiter])
    Splits value using the delimiter argument. Return type: ARRAY of type STRING or ARRAY of type BYTES
    """
    re_pg_split_part = r'split_part\(\s*(.*)\s*,\s*(.*)\s*,\s*([0-9]*)\s*\)'
    re_bq_split = r'SPLIT(\1, \2)[SAFE_ORDINAL(\3)]'
    sql_translated = re.sub(re_pg_split_part, re_bq_split, sql)

    # translate ILIKE to LIKE
    """"
    PostgreSQL: 
    The key word ILIKE can be used instead of LIKE to make the match case-insensitive according to the active locale. 
    This is not in the SQL standard but is a PostgreSQL extension.
    """""
    re_pg_ilike = r'(?P<string>[^\(\s]+)\s+(?P<not>NOT\s+)?(?P<operator>ILIKE)\s+(?P<pattern>(?:(?P<quote>[\"\'])' \
                  r'(?:.)*?(?P=quote))|(?:[^\)\s]+))'
    re_bq_like = r'UPPER(\g<string>) \g<not>LIKE UPPER(\g<pattern>)'
    sql_translated = re.sub(re_pg_ilike, re_bq_like, sql_translated)

    # translate Byte to integer
    # after exporting to csv: bytes will be converted into integers
    re_pg_byte = r'(?P<column>[^\(\s]+)\s+(?P<operator>=)\s+(?P<byte>B\'(?P<value>[0-1])\')'
    re_bq_int = r'\g<column> \g<operator> \g<value>'
    sql_translated = re.sub(re_pg_byte, re_bq_int, sql_translated)
    return sql_translated

