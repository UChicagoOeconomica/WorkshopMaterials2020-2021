# Practice Exercises for Workshop 5

# Save all your output to your output folder; data that is not native to R can 
# be found in the data folder for Workshop 5


# Using the data from cps.csv in your data folder do the following:
# (Note: you may want to spend a bit of time exploring the data to understand it
# first)

# Use linear regression to compute the binning estimator of average wage income
# for women in Florida 
# (Hint 1: the binning estimator is the sample mean of that bin)
# (Hint 2: you may want to construct indicator variables)

# Regress the log of wage income on an indicator for gender, age, age squared, 
# race, and a full set of dummy variables for reported level of education

# What is the coefficient on the gender indicator? How do you interpret this
# coefficient

# Run the same regression but with interactions between the gender indicator
# and both the race and education indicators. What do the coefficients on the 
# interaction terms between race and gender imply? Are they similar?


# Using the data from voena.csv in your data folder, do the following:
# (A note about this data: This data is from the paper "Widows Land Rights
# and Agricultural Investment" by Dillon and Voena, which explores the effect 
# of widow's inheritance rights on agricultural investment in Zambia)
# some notes on variables:
#     noninh = 1 denotes non-inheritance
#     fert = fertilization in kilograms
#     hh_couple = 1 denotes married households

# Regress fertilization on inheritance rights alone for just married households.
# How would you interpret this coefficient?

# Regress fertilization on inheritance rights controlling for district for just
# married households. 
# How would you interpret the coefficient on inheritance rights now? What is a
# reason that the coefficient has changed from your previous regression?

# How would you use the data you have to enrich the regression? 
# (Hint: This can be by running a different specification or by providing
# additional context for your results)

# Repeat both regressions for non-coupled households. Why would these results
# be useful in arguing that widow's property rights affect agricultural
# investment?

# Make a table to represent these regressions

# Using the data in txhousing (a dataset in R), use regressions to come up with
# a model that looks at the determinants of median sale price in a given month
# (Hint: Variables related to time are helpful for understanding causality)

# Using the data in CO2 (a dataset in R), find the impact of being chilled on
# CO2 uptake


# Using the data in ChickWeight (a dataset in R), figure out which diet is the 
# best for the chicks and which is the worst (assuming that "best" means that
# the chick gained weight)


# Using the storms data (a dataset in R), figure out the characteristics of a 
# storm that make them last longer



# Using the diamonds data (a dataset in R), use regression to create a model of
# diamond price