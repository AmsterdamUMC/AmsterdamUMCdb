import matplotlib.pyplot as plt
import numpy as np

def outliers_histogram(data, z_treshold=4.0, lower=None, upper=None, bins='auto'):
    """Return a pyplot histogram, where the upper and/or lower outliers are
    binned together for a more even distribution plot.

    Arguments:
        data -- dataframe to calculate the median absolute deviatan for
        z_treshold -- number of standard deviations from the median to determine outliers
        lower -- lower threshold for binning lower outliers together
        upper -- upper threshold for binning higer outliers together
    """
    if (not lower) & (not upper):
        lower, upper = calculate_z_range(data, z_treshold)

    if not lower or lower < data.min():
        lower = data.min()
        lower_outliers = False
    else:
        lower_outliers = True

    if not upper or upper > data.max():
        upper = data.max()
        upper_outliers = False
    else:
        upper_outliers = True

    n, bins, patches = plt.hist(data, range=(lower, upper), bins=bins)
    # cm = plt.cm.get_cmap('RdYlBu_r')
    # cm = plt.cm.get_cmap('Reds')
    # cm = plt.cm.get_cmap('RdPu')
    cm = plt.cm.get_cmap('magma')

    # To normalize your values
    col = (n - n.min()) / (n.max() - n.min())
    for c, p in zip(col, patches):
        # plt.setp(p, 'facecolor', cm(c))
        plt.setp(p, 'facecolor', cm(0.15 + 0.6 * c))

    if lower_outliers:
        n_lower_outliers = (data < lower).sum()
        patches[0].set_height(patches[0].get_height() + n_lower_outliers)
        patches[0].set_facecolor('b')
        patches[0].set_label('Lower outliers: ({:.2f}, {:.2f})'.format(data.min(), lower))

    if upper_outliers:
        n_upper_outliers = (data > upper).sum()
        patches[-1].set_height(patches[-1].get_height() + n_upper_outliers)
        patches[-1].set_facecolor('r')
        patches[-1].set_label('Upper outliers: ({:.2f}, {:.2f})'.format(upper, data.max()))

    if lower_outliers or upper_outliers:
        plt.legend()

    return plt


def mad(data):
    """Return the median absolute deviation for the data set.

    Arguments:
        data -- the dataframe to calculate the median absolute deviation for
    """
    median = np.median(data)
    diff = np.abs(data - median)
    mad = np.median(diff)
    return mad


def calculate_z_range(data, z_thresh=3.5):
    """Calculate the range for the dataset base on the specified Z threshold: the number of standard
    deviations from the median.

    Arguments:
        data -- the dataframe to calculate the median absolute deviation for.
        z_thresh -- the Z threshold.
    """
    MAD = mad(data)
    median = np.median(data)
    const = z_thresh * MAD / 0.6745  # sd = 0.6745*MAD
    return (median - const, median + const)