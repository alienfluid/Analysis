# -*- coding: utf-8 -*-
# <nbformat>3.0</nbformat>

# <codecell>

import numpy as np
import matplotlib.pyplot as plt

# <codecell>

%matplotlib inline

# <codecell>

def selective_median_filter(data, kernel=31, threshold=2):
    """Return copy of data with outliers set to median of specified
        window. Outliers are values that fall out of the 'threshold'
        standard deviations of the window median"""
    if kernel % 2 == 0:
        raise Exception("Kernel needs to be odd.")
    n = len(data)
    res = list(data)
    for i in range(0, n):
        seg = res[max(0,i-(kernel/2)):min(n, i+(kernel/2)+1)]
        mn = np.median(seg)
        if abs(res[i] - mn) > threshold * np.std(seg):
            res[i] = mn
    return res

# <codecell>

# Generate random data
data = np.random.poisson(5, 100)

# Set a couple of values as 'outliers'
data[45] = 1000
data[89] = 670

# Plot the data
p = plt.scatter(range(1,101),data)
show(p)

# <codecell>

data = selective_median_filter(data, 7, 2)

# <codecell>

s = plt.scatter(range(1,101), data)
show(s)

# <codecell>

print(data[45], data[89])

