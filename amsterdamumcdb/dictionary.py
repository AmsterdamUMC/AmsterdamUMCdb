import pandas as pd
import os


def get_dictionary(legacy=False):
    """
    Gets a dictionary of all items in AmsterdamUMCdb with translated medical concepts mapped to
    [OHDSI Standardized Vocabularies](https://github.com/OHDSI/Vocabulary-v5.0/wiki)
    including LOINC, SNOMED CT and RxNorm.

    Arguments:
        legacy -- Loads the legacy version of the dictionary for AmsterdamUMCdb version 1.0.2 or earlier. Default: False.

    Returns:
        dataframe:
    """
    dirname = os.path.dirname(os.path.abspath(__file__))
    if legacy:
        filename = './dictionary/legacy/dictionary.csv'
    else:
        filename = './dictionary/dictionary.csv'

    dictfile = os.path.join(dirname, filename)

    dictionary = pd.read_csv(dictfile)
    return dictionary
