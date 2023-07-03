#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Jun 17 17:07:26 2022
### first: add your rmsd to one file:
paste <(awk '{print $1, $2}' systems-1.rmsd) <(awk '{print $2}' systems-2.rmsd) > rmsds.dat
@author: Brunis
"""
import numpy as np
import matplotlib as mpl
import matplotlib.pyplot as plt

def general_canvas(figsize, dpi):
    """
    Customization of plots up2you
    """
    mpl.rc('figure', figsize=figsize, dpi=dpi)
    mpl.rc('xtick', direction='in', top=False)
    mpl.rc('xtick.major', top=False)
    mpl.rc('xtick.minor', top=False)
    mpl.rc('ytick', direction='in', right=True)
    mpl.rc('ytick.major', right=False)
    mpl.rc('ytick.minor', right=False)
    mpl.rc('axes', labelsize=20)
    plt.rcParams['axes.autolimit_mode'] = 'data'
    mpl.rc('lines', linewidth=2, color='k')
    mpl.rc('font', family='sans-serif', size=20)
    mpl.rc('grid', alpha=0.5, color='gray', linewidth=1, linestyle='--')

    return

# Set the desired figsize and dpi values
figsize = (8, 6)
dpi = 300

# Call the general_canvas function with the updated dpi value
general_canvas(figsize, dpi)

# load the data from the file, skipping the first row (header)
data = np.loadtxt("rmsds.dat", skiprows=1)

# extract the x and y values from the data array
x_values = data[:, 0]
y_values1 = data[:, 1]
y_values2 = data[:, 2]
y_values3 = data[:, 3]

# create the plot with increased line thickness
plt.plot(x_values, y_values1, color='orange', linewidth=2, label='System-1')
plt.plot(x_values, y_values2, color='blue', linewidth=2, label='System-2')
plt.plot(x_values, y_values3, color='red', linewidth=2, label='System-3')
plt.ylim(0,20)
plt.xlabel("Time (ns)")
plt.ylabel("RMSD (Å)")
plt.title("RMSD SYSTEM")
plt.legend()

### save figure with the updated DPI
plt.savefig("rmsd-systems.png", dpi=dpi)
