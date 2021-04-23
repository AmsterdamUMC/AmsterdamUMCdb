import pandas as pd
import os


def get_dictionary():
    """
    Gets a dictionary of all items in Amsterdam UMCdb, with (work in progress) translated
    medical concepts.

    Returns:
        dataframe:
    """
    dirname = os.path.dirname(os.path.abspath(__file__))
    filename = './dictionary/dictionary.csv'

    dictfile = os.path.join(dirname, filename)

    dictionary = pd.read_csv(dictfile)
    return dictionary
