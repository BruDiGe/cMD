
#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Jun 17 17:07:26 2022
### read the data from complex-lie.dat
@author: Brunis
"""
import seaborn as sns
import numpy as np
import pandas as pd
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


# Load the data from the CSV file , skipping the first row (header)
data = np.loadtxt("complex-lie.dat", skiprows=1)

#print(data)
# Extract the columns of interest
x_values = data[:, 1]
#print(x_values)
y_values1 = data[:, 2]
#print(y_values1)
# Extract Figure and Axes instance
fig, ax = plt.subplots()

# creating a dictionary with one specific color per group:
my_pal = {"versicolor": "g", "setosa": "b"}

# Create a plot
sns.violinplot(data=[x_values, y_values1],ax=ax, palette=['orange','cadetblue'])

# Custom Plot
plt.ylim(-1500,100)
ax.set_title('COMPLEX-NAME')
ax.set_ylabel("Binding Energies (kcal/mol)")
ax.set_xticklabels(["Electrostatic","vdW"])
fig.savefig('system-lie-energies.png')
