import pandas as pd
import os
import re

import sqlalchemy

from .bigquery import pg2bq



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

    # translate INTERVAL
    re_pg_interval = r'(?P<interval>INTERVAL)\s+\'(?P<quantity>[0-9]+)\s+(?P<unit>\w+)\''
    re_bg_interval = r'\g<interval> \g<quantity> \g<unit>'
    sql_translated = re.sub(re_pg_interval, re_bg_interval, sql_translated)
    return sql_translated


def union_tables(match_object):
    """
    Replaces FROM/JOIN statement of numericitems/listitems with UNION ALL to retrieve all unvalidated records
    """
    command = match_object.group('command')
    table = match_object.group('table')
    alias = match_object.group('alias')

    if len(alias) > 0:
        return f'{command} (SELECT * FROM {table} UNION ALL SELECT * FROM {table}_unvalidated) {alias} '
    else:
        return f'{command} (SELECT * FROM {table} UNION ALL SELECT * FROM {table}_unvalidated) {table} '


def exclude_unvalidated(match_object):
    """
    Excluded unvalidated data from the numericitems and listitems table by adding `WHERE NOT registeredby IS NULL`
    to the respective FROM/JOIN table statements.
    """
    command = match_object.group('command')
    table = match_object.group('table')
    alias = match_object.group('alias')

    if len(alias) > 0:
        return f'{command} (SELECT * FROM {table} WHERE NOT registeredby IS NULL) {alias} '
    else:
        return f'{command} (SELECT * FROM {table} WHERE NOT registeredby IS NULL) {table} '


def select_validated(sql, con, include_unvalidated=False):
    """
    Translate query by either including or excluding unvalidated (high volume) data
    When using BigQuery:
    For numericitems UNION ALL numericitems_unvalidated, and
    For lisitems UNION ALL listitems_unvalidated

    Args:
        sql: SQL statement
        con: psycopg2 connection or pandas-gbq Google BigQuery config
        include_unvalidated: If True will include the unvalidated data (Default: False)

    Returns: Transformed SQL statement
    """

    re_tables = r'(?P<command>FROM|JOIN)\s*(?P<table>numericitems|listitems)\s*(?:AS\s*)?(?!RIGHT|LEFT|FULL|' \
                r'INNER|OUTER|JOIN|UNION|WHERE|GROUP|ON|ORDER|HAVING|LIMIT)(?P<alias>\S*)'

    if include_unvalidated:
        if type(con) is dict: # BigQuery config
            # UNION ALL regular and unvalidated tables
            sql_translated = re.sub(re_tables, union_tables, sql)
            return sql_translated
        else:
            # local databases already contain all values in the numericitems and listitems tables
            return sql
    else:
        if type(con) is dict: # BigQuery config
            # BigQuery already has unvalidated data removed from main tables
            return sql
        else:
            # remove unvalidated data from SQL query
            sql_translated = re.sub(re_tables, exclude_unvalidated, sql)
            return sql_translated


def read_sql(sql, con, include_unvalidated=False):
    """
    Small wrapper around Pandas read_sql and read_gbq to de-duplicate code fragments that should work both on (local)
    postgreSQL instances and Google BigQuery ofr AmsterdamUMCdb.

    Arguments:
        con -- psycopg2 connection or pandas-gbq Google BigQuery config
    """

    if type(con) is dict:  # BigQuery config
        # translate query from PostgreSQL dialect to BigQuery
        sql = pg2bq(sql)
        sql = select_validated(sql=sql, con=con, include_unvalidated=include_unvalidated)
        result = pd.read_gbq(sql, configuration=con, use_bqstorage_api=True)
    else:
        sql = select_validated(sql=sql, con=con, include_unvalidated=include_unvalidated)
        # Escape SQL for use in SQLAlchemy to prevent 'TypeError: dict is not a sequence' when using `%`
        result = pd.read_sql(sqlalchemy.text(sql), con)

    return result


def query(filename, con):
    """
    Queries using a SQL script located in the `sql` folder. Translates the SQL code as needed.

    Arguments:
        con -- psycopg2 connection or pandas-gbq Google BigQuery config
    """
    # gets the SQL source file
    dirname = os.path.dirname(os.path.abspath(__file__))
    sql_filename = os.path.join(dirname, 'sql', filename)

    print(f"Querying '{sql_filename}'...")
    with open(sql_filename, 'r') as sql_file:
        sql = sql_file.read()

    return read_sql(sql, con)
