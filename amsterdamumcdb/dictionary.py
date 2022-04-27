import pandas as pd
import os


def get_dictionary():
    """
    Gets a dictionary of all items in AmsterdamUMCdb with translated medical concepts mapped to LOINC, SNOMED CT
    or ATC (work in progress).

    Returns:
        dataframe:
    """
    dirname = os.path.dirname(os.path.abspath(__file__))
    filename = './dictionary/dictionary.csv'

    dictfile = os.path.join(dirname, filename)

    dictionary = pd.read_csv(dictfile)
    return dictionary
