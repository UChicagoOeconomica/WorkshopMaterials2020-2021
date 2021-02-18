# Practice Exercises for Workshop 6 


# Write code that determines if the rounded cube root of a number is odd


# Find the 257th triangular number (using R) in two different ways
# https://en.wikipedia.org/wiki/Triangular_number


# Write a function to capitalize the first letter of a string if it is in the
# first half of the alphabet and the last letter of a string if it is in the 
# second half of the alphabet


# Write a function that simulates flipping n coins 

# Write a function that finds the minimum power you must take a number to to be
# larger than some threshhold
# Hint: Try a while loop


# Write a function that simulates a poisson random variable without using 
# dpois, ppois, qpois, or rpois

# Write a function that finds the minimum power that a number needs to be taken
# to to exceed 100


# Make some kind of density graph of a distribution of a random variable that 
# one quarter of the time draws from the uniform distribution on [0, 3], one 
# third of the time draws from the standard normal distribution truncated to be 
# positive, one third of the time draws from the exponential distribution with 
# rate 2, and the remainder of the time returns 5

# Approximate the mean and variance of this distribution 
# Compute the mean and variance of this distribution

# Write functions to find the number of unique n-grams (strings of length n) in 
# a string of length m composed only of o, w, t, f, v, s (eg. the result of 
# rolling a die m times and recording the result as a string)


# Write functions to simulate (and graph the results of) a discrete 
#    (deterministic) SIR model. For this you may want a separate R file. 
# Hint: think one step at a time
# If you don't know what an SIR model is, this site contains an explanation:
# https://mathinsight.org/discrete_sir_infectious_disease_model
# Note: I have not seen the videos or read the whole explanation on this 
#       particular site; from skimming, this seems to give the basic rules and
#       a reasonable explanation 


# Generate a random dataframe where the first column is numeric, the second 
# column contains strings, and the third column contains booleans 
# Do not use pre-existing r distributions to make all three columns, have fun 
# coming up with weird randomness!


# Add a variable that for each observation either adds or subtracts the length
# of the string from the first column based on the third column


# Add a variable that is the integer that occurs in the fourth digit of the 
# first column (i.e. for 0.81597 this is 5, for 98.13 this is 3, for 175516 
# this is 5 etc.)

# Pretend that this newly created column is actually the number of years of 
# school excluding elementary (K-4) that someone has attended. Create a factor
# variable for education that might be useful for some kind of analysis.

# Add a new random column that takes integer values from 20 to 100

# Pretend this new column is an age column, 


# Load the txhousing data
# Add a column for the first time a city's sales exceeded 100
# Add a column for whether the pace of sales increased or decreased from the 
# previous month (note that this should be within-city)
# Write a function that makes a graph of median sale price over time for any 
# given city
# Make histograms of listings faceted by quarter for 2000, 2003, 2007, 2011, and
# 2015 (Q1 = Jan-Mar, Q2=Apr-Jun, etc.)
# For each date (month/year combo) find the city with the median inventory, 
# the city with the most inventory, and the city with the least inventory and 
# make  bar graphs showing how frequently each city is the median city, the city 
# with the most inventory, and the city with the least inventory; if there are
# multiple  cities closest to the median for a given date, make them all the 
# median (same for most & least)

