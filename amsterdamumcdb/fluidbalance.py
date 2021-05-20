import pandas as pd
import numpy as np
import os


def get_fluidbalance(admissionid, from_date, to_date, con) -> pd.DataFrame:
    """Calculate the fluid balance (i.e. fluid input - fluid output) for a specific time interval.
    Typically this will be used to calculate daily fluid balances.

    Arguments:
        admissionid -- the admissionid of ICU admission
        from_date -- the start of the interval, expressed as the number of milliseconds from start of this ICU admission
        to_date -- the end of the interval, expressed as the number of milliseconds from start of this ICU admission
        con -- psycopg2 connection or pandas-gbq Google BigQuery config
    """

    try:
        admissionid = np.int64(admissionid)
    except ValueError:
        raise Exception("admissionid is not a number: %r" % admissionid)

    try:
        from_date = np.int64(from_date)
    except ValueError:
        raise Exception("from_date is not a number: %r" % from_date)

    try:
        to_date = np.int64(to_date)
    except ValueError:
        raise Exception("to_date is not a number: %r" % to_date)

    # gets the SQL source file
    dirname = os.path.dirname(os.path.abspath(__file__))
    filename = './sql/functions/get_fluidbalance.sql'
    sqlfile = os.path.join(dirname, filename)

    file = open(sqlfile, 'r')

    sql = file.read().format(admissionid=admissionid, msfromdate=from_date, mstodate=to_date)

    if type(con) is dict:  # BigQuery config
        result = pd.read_gbq(sql, configuration=con)
    else:
        result = pd.read_sql(sql, con)

    return result
