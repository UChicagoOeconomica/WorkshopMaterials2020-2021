# Examples for Workshop 3

# Start by installing and loading your packages!
install.packages('tidyverse')
library(tidyverse)

# R (and some of its packages) have some data already
data("txhousing")
# For a dataframe native to R, find out more about the dataset by running
?txhousing

# Most of the time, you will need to load your own data in using the correct
# command for that datatype 
cps_df <- read.csv("Workshop3/cps.csv")

# Glancing at your data 
view(txhousing)
head(cps_df)

# Finding Summary Statistics
summarise(cps_df, avg_wage=mean(incwage), med_age=median(age))
tx_housing_summ_df <- 

# Subsetting the Dataset
# Keeping or removing variables (2 ways):
cps_few_vars1 <- select(cps_df, incwage, age, sex)
cps_few_vars2 <- select(cps_df, -vetstat, -hispan, -ind)
cps_few_vars3 <- cps_df[,c(1,4,5)]
cps_few_vars4 <- cps_df[, -c(8, 9, 12)]
# Keeping or removing rows




# Building New Variables 



