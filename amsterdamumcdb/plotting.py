import matplotlib.pyplot as plt
import matplotlib.ticker as ticker
import numpy as np

def outliers_histogram(data, z_threshold=4.0, lower=None, upper=None, bins=None, binwidth=None, maxbins=None, **kwargs):
    """Return a pyplot histogram, where the upper and/or lower outliers are
    binned together for a more even distribution plot. By default, the histogram will be created with bins that are on
    boundaries aligned with the pyplot axis ticks.

    Arguments:
        data -- dataframe to create the histogram for.
        z_threshold (Optional) -- number of standard deviations from the median to determine outliers
        lower (Optional) -- lower threshold for binning lower outliers together
        upper (Optional) -- upper threshold for binning higher outliers together
        bins (Optional) -- int or sequence or str, allows specifying the number of bins, the actual bins or a binning strategy
            (see: https://matplotlib.org/stable/api/_as_gen/matplotlib.pyplot.hist.html)
        binwidth (Optional) -- forces a specified size of the equally sized bins between the lower and upper threshold
        maxbins -- the maximum number of equally sized bins to create
    """
    if (not lower) & (not upper):
        lower, upper = z_range(data, z_threshold)

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

    if not bins:
        # if bins not defined, calculate number of bins

        if not binwidth:
            # if binwidth not defined, determine the bindwith based on
            # the ticks pyplot will generate
            count = len(data)
            binwidth = pretty_binwidth(lower, upper, len(data), maxbins)
            bins = np.arange(round_base(lower, base=binwidth), round_base(upper + binwidth, base=binwidth), binwidth)
        else:
            bins = np.arange(round_base(lower, base=binwidth), round_base(upper + binwidth, base=binwidth), binwidth)

    n, bins, patches = plt.hist(data, range=(lower, upper), bins=bins, **kwargs)
    cm = plt.cm.get_cmap('magma')

    # To normalize the values
    col = (n - n.min()) / (n.max() - n.min())
    for c, p in zip(col, patches):
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
    """Return the median absolute deviation for the dataset.

    Arguments:
        data -- the dataframe to calculate the median absolute deviation for.
    """
    median = np.median(data)
    diff = np.abs(data - median)
    MAD = np.median(diff)
    return MAD


def z_range(data, z_thresh=4):
    """Calculate the range for the dataset based on the specified Z threshold: the number of standard
    deviations from the median.

    Arguments:
        data -- the dataframe to calculate the Z range for.
        z_thresh -- the Z threshold.
    """
    MAD = mad(data)
    median = np.median(data)
    const = z_thresh * MAD / 0.6745  # sd = 0.6745*MAD
    return (median - const, median + const)


def round_base(x, base=.05):
    """"rounds the value up to the nearest base"""
    return base * round(float(x) / base)


def pretty_binwidth(lower, upper, count, maxbins=None):
    """uses the matplotlib.ticker.AutoLocator (for generating the ticks in the
    plot), to determine the bins to use. By default, ticks will be placed on
    positions that are multiples of the following sequence: [1, 2, 2.5, 5, 10].
    Equally, for a nice display, the five bins will be generated between these
    ticks.

    Arguments:
        lower -- the lower boundary of the dataset
        upper -- the upper boundary of the dataset
        count -- number of items in the dataset
        maxbins -- the maximum number of bins to create
    """
    locator = ticker.AutoLocator()
    ticks = locator.tick_values(vmin=lower, vmax=upper)

    if maxbins:
        # determine binwidth based on maxbins
        bins_per_tick = int(maxbins / len(ticks))
        if bins_per_tick == 0:
            bins_per_tick = 1
    else:
        # default: allow maximum number of five bins between every tick
        num_ticks = len(ticks)
        bins_per_tick_strategy = [1, 2, 4, 5]

        # make sure we don't have too many bins for the amount of data
        i = 0
        bins_per_tick = bins_per_tick_strategy[0]
        while i < len(bins_per_tick_strategy):
            if (num_ticks * bins_per_tick) ** 2 < count:
                bins_per_tick = bins_per_tick_strategy[i]
            else:
                break
            i += 1

    binwidth = (ticks[1] - ticks[0]) / bins_per_tick

    return binwidth
