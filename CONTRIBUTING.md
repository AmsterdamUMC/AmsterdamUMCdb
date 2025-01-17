# AmsterdamUMCdb CONTRIBUTING.md

## Introduction
Thanks for considering contributing to AmsterdamUMCdb. This document is currently work in progress.


## Testing


## For code contributers and maintainers

### Requirements
- (local) installation of AmsterdamUMCdb in postgres
- access to the BigQuery instance

### Testing
Tests are currently developed using the Python `unittest` Unit testing framework package. Please make sure you are able 
to run the tests succesfully before submitting a pulling request:

> python -m unittest -v

### Publishing to PyPI
1. Increase version number in `setup.cfg`
2. Update Build tools
> pip install --upgrade build
3. Build the package
> python -m build

4. Get a PyPI API token: https://test.pypi.org/manage/account/#api-tokens

5. Update Twine
> pip install --upgrade twine

5. Upload the package to TestPyPI: 
> python -m twine upload --repository testpypi dist/*
> 
6. Test the package

Since Colab is the main supported environment for the BigQuery instance, it is important to test the package from the getting_started.ipynb notebook: 

[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/AmsterdamUMC/AmsterdamUMCdb/blob/master/bigquery/getting_started.ipynb)

From the [Install the AmsterdamUMCdb package](https://colab.research.google.com/github/AmsterdamUMC/AmsterdamUMCdb/blob/master/bigquery/getting_started.ipynb#scrollTo=csx_BSWT1Uil) cell, change the cell contents to: 

```python
# get the amsterdamumcdb package from TestPyPI repository for use in Colab
!pip install --index-url https://test.pypi.org/simple/ --no-deps amsterdamumcdb
import amsterdamumcdb as adb
``` 


