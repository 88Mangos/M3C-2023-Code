# Package imports
import matplotlib.pyplot as plt
import numpy as np
import os
from adjustText import adjust_text
from textwrap import wrap

# Data
x = [2016, 2017, 2018, 2019, 2020, 2021, 2022]
y_us = [2.14, 2.42, 2.72, 2.6, 2.17, 3.01, 3.95]
y_europe = [4.96, 5.36, 5.71, 5.7, 5.2, 5.99, 7.51]

# Figure creation
fig, ax = plt.subplots(figsize=(10,5))

# Add axis labels
ax.set_xlabel("Year")
y_label = "Yearly average price of regular grade (87 octane) gasoline, USD per gallon"
ax.set_ylabel('\n'.join(wrap(y_label, 40)))

# Add data to graph
ax.plot(x, y_us, "-o", color="blue")
ax.plot(x, y_europe, "-o", color="orange")

# US regression
polyline = np.linspace(min(x), max(x), 100)
polyspace = -434.25 + (polyline * 0.2164)
ax.plot(polyline, polyspace, label="U.S.", color="blue")

# UK regression
polyline = np.linspace(min(x), max(x), 100)
polyspace = -599.92 + (polyline * 0.3)
ax.plot(polyline, polyspace, label="UK", color="orange")

# Text labels for US
point_labels = ["2016", "2017", "2018", "2019", "2020", "2021", "2022"]
text_labels = []
for x_vals, y_vals in zip(x, y_europe):
    text_labels.append(ax.annotate(point_labels[x.index(x_vals)], xy=(x_vals, y_vals)))

# Text labels for EU
point_labels = ["2016", "2017", "2018", "2019", "2020", "2021", "2022"]
text_labels = []
for x_vals, y_vals in zip(x, y_us):
    text_labels.append(ax.annotate(point_labels[x.index(x_vals)], xy=(x_vals, y_vals)))

# Correct and adjust text
adjust_text(text_labels, only_move={'points':'y', 'texts':'y'}, arrowprops=dict(arrowstyle="->", color='k', lw=1))

# Final plot configuring and saving
plt.title("Gas prices for the U.S. and UK from 2016 to 2022")
ax.legend()
currentwd = os.getcwd().replace('\\', '/')
plt.savefig(f"{currentwd}/graphs/problem1.png", dpi=200)
plt.show()

# Package imports
import matplotlib.pyplot as plt
import numpy as np
import os
from adjustText import adjust_text
from textwrap import wrap

# Data
x = [2006, 2007, 2008, 2009, 2010, 2011, 2012, 2013, 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021]
y_us = [37570, 38093, 38188, 37814, 38282, 38769, 39732, 38947, 40118, 41383, 41821, 42699, 43886, 44644, 47241, 48219]
y_europe = [31305.6, 31400.4, 30552, 29016, 29709.6, 29827.2, 29653.2, 29835.6, 30709.2, 31317.6, 31670.4, 32630.4, 32800.8, 33741.6, 28500, 31906.8]


# Figure creation
fig, ax = plt.subplots(figsize=(10,5))

# Add axis labels
ax.set_xlabel("Year")
y_label = "Per capita Disposable Personal Income in the United States in USD"
ax.set_ylabel('\n'.join(wrap(y_label, 40)))

# Add data to graph
ax.plot(x, y_us, "-o", color="red")
ax.plot(x, y_europe, "-o", color="green")

# US regression
polyline = np.linspace(min(x), max(x), 100)
polyspace = -1.311e+006 + (polyline * 671.51)
ax.plot(polyline, polyspace, label="U.S.", color="red")

# UK regression
polyline = np.linspace(min(x), max(x), 100)
polyspace = -194098 + (polyline * 111.75)
ax.plot(polyline, polyspace, label="UK", color="green")

# Text labels for US
point_labels = ["2006", "2007", "2008", "2009", "2010", "2011", "2012", "2013", "2014", "2015", "2016", "2017", "2018", "2019", "2020", "2021", "2022"]
text_labels = []
for x_vals, y_vals in zip(x, y_europe):
    text_labels.append(ax.annotate(point_labels[x.index(x_vals)], xy=(x_vals, y_vals)))

# Text labels for EU
point_labels = ["2006", "2007", "2008", "2009", "2010", "2011", "2012", "2013", "2014", "2015", "2016", "2017", "2018", "2019", "2020", "2021", "2022"]
text_labels = []
for x_vals, y_vals in zip(x, y_us):
    text_labels.append(ax.annotate(point_labels[x.index(x_vals)], xy=(x_vals, y_vals)))

# Correct and adjust text
adjust_text(text_labels, only_move={'points':'y', 'texts':'y'}, arrowprops=dict(arrowstyle="->", color='k', lw=1))

# Final plot configuring and saving
plt.title("Personal income for the U.S. and UK from 2006 to 2021")
ax.legend()
currentwd = os.getcwd().replace('\\', '/')
plt.savefig(f"{currentwd}/graphs/problem2.png", dpi=200)
plt.show()
