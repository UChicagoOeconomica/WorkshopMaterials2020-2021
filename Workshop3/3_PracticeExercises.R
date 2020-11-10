# Practice Exercises for Workshop 3

# For these exercises, there are typically  multiple ways to find a solution
# For some exercises, there is more than one right answer

####### Exercises using the storms dataset ####### 
# When answering these questions, keep in mind that there are multiple 
# observations per storm
# Also, if you are unclear about anything with regard to how the variables are 
# defined in the storms dataset, recall that you can always run ?storms to find
# out more

# Load the storms dataset (exists in R)

# Make a variable with the time in EST

# How many tropical depressions became hurricanes?

# What is the average speed of storms based on month of the year?

# What is the average speed of storms by storm category?

# Make a variable binning the pressure variable into low, medium, and high

# Make a variable binning the wind variable into low, medium, and high

# What is the average ts_diameter of low, medium, and high pressure storms?

# What is the average hu_diameter of low, medium, and high wind storms?

# On average, how long does a storm last?

# Which hurricane took the longest to be classified as a hurricane?

# Which month of the year has the most tropical depressions?

# Which month of the year has the storms with the smallest ts_diameter?

# What percentage of Saffir-Simpson Tropical Storms are not classified as a 
# Tropical Storm?

# Create a variable corresponding to the status variable but with 1, 2, and 3 as
# the different levels

# The ts_diameter and hu_diameter are in miles, use the approximation 
# ~55km = 0.5 degrees (approximation based on distance at the equator) to create
# variables for the western-most point experiencing tropical storm strength
# winds for each observation and the northern-most point experiencing hurricane
# strength winds



####### Exercises using cps.csv ####### 
# This is an extract of the Current Population Survey and is the same dataset 
# from the examples

# Load cps.csv 

# Create a variable with 10 year age groups

# Create a variable based on the quintiles of age

# Compare those two variables

# What proportion of survey takers report being single? How does this proportion
# vary by education?

# Is the average income difference between hispanic and non-hispanic survey 
# respondents smaller or larger in TX or FL?

# What proportion of respondents are from each state? (Note: DC here is included
# as a state)

# What is the average age of divorcees?

# Create a variable for region of the country (eg. Northeast, Southeast, etc.)

# What is the average non-wage income by region?

# What is the highest income for each education level?

# How does the triple ratio of 
# never married/currently married and together/separated or divorced
# change by education level?

# Find the youngest married survey respondents. How many are there? What is 
# their average wage?

# Do you see the evidence of the gender wage gap? (Without using regresssions)
# Note: You do not need to prove anything, suggestive evidence that supports 
# your answer is sufficient


####### Exercises using elections.tab ####### 
# This dataset contains two variables from elections for House races between 
# 1948 and 1998. It contains two variables "difdemshare" (which is the percentage
# of votes the Democratic candidate won minus the percentage that the Republican
# candidate won) and "demsharenext" (which is the percentage of votes that the
# Democratic candiate won in the next election)

# Load elections.tab 
# (Hint: ".tab" refers to a tab delimited file)

# Find the mean and standard deviation of both variables 

# Construct an estimate for P(Dem won next election | Dem lost)
# (Hint: the expectation of an indicator variable is the probability that the 
# variable is one)

# Find the mean, standard deviation, and quintiles of demsharenext for elections 
# where the margin of victory was within 5%

