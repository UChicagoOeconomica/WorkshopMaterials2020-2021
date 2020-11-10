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

# You can use any function that you can use on a vector!
mean(txhousing$sales)
sd(txhousing$sales)
# Be careful about NA values! Instead you may want to use 
mean(txhousing$sales, na.rm = TRUE)

# Side note on NA values:
# Removing them completely
txhousing_nonas1 <- na.omit(txhousing)
txhousing_nonas2 <- txhousing[complete.cases(txhousing),]
txhousing_nonas3 <- na.exclude(txhousing)
# Finding them
which(is.na(txhousing$volume))
sum(is.na(txhousing))
colSums(is.na(txhousing))
# Replacing NAs
txhousing_0_for_NA <- txhousing
txhousing_0_for_NA[is.na(txhousing_0_for_NA)] <- 0
txhousing_rep_NAs <- replace_na(txhousing, list(sales=0,volume=1,
                                                listings=0,inventory=1))
# Back to summary statistics
# Getting several at once
lapply(txhousing, mean, na.rm=TRUE) #Returns a list
sapply(txhousing, mean, na.rm=TRUE) #Returns a vector
summarise(cps_df, avg_wage=mean(incwage), med_age=median(age))
# What if you want summary statistics by a particular variable?
tx_housing_city_groups <- group_by(txhousing, city)
tx_housing_summ_df_by_city <- summarise(tx_housing_city_groups, 
                                        avg_volume=mean(volume), 
                                        avg_listings=mean(listings),
                                        avg_sales=mean(sales))
tx_housing_summ_df_by_city_no_NAs <- summarise(tx_housing_city_groups, 
                                        avg_volume=mean(volume,na.rm=TRUE), 
                                        avg_listings=mean(listings, na.rm=TRUE),
                                        avg_sales=mean(sales, na.rm=TRUE))
tapply(cps_df$incwage, cps_df$educ, mean)
by(txhousing$sales, txhousing$month, median, na.rm=TRUE)

# Piping %>%
city_total_volumes <- by(txhousing$volume, txhousing$city, sum, 
                         na.rm = TRUE) %>% as.table() %>% as.data.frame()

# Reordering your dataframe
city_total_volumes <- city_total_volumes[order(city_total_volumes$Freq, 
                                               decreasing = TRUE),]
txhousing_sorted_a <- arrange(txhousing, sales)
txhousing_sorted_d <- arrange(txhousing, desc(sales))


# Subsetting the Dataset
# Keeping or removing variables (2 ways):
cps_fewer_vars1 <- select(cps_df, incwage, age, sex)
cps_fewer_vars2 <- select(cps_df, -vetstat, -hispan, -ind)
cps_fewer_vars3 <- cps_df[,c(1,4,5)]
cps_fewer_vars4 <- cps_df[, -c(8, 9, 12)]
# Keeping or removing rows
txhousingfirstrows <- txhousing[c(1:100),]
txhousingnofirstrows <- txhousing[-c(1:100),]
txhousingsample <- sample_n(txhousing, 300, replace = FALSE)
# By particular conditions
cps_df_fm1 <- filter(cps_df, sex=="Female")
cps_df_fm2 <- cps_df[cps_df$sex=="Female",]
# "," represent "and", "|" represent "or"
cps_df_w_fm <- cps_df %>% filter(race=="White", sex=="Female")
cps_df_nw_or_hisp <- cps_df %>% filter(race!="White" | hispan != "Not Hispanic")

# Building New Variables 



