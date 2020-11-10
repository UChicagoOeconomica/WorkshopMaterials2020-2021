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
txhousing[c(1:3),]


# Finding Summary Statistics
# You can use any function that you can use on a vector!
mean(txhousing$sales)
sd(txhousing$sales)

# Be careful about NA values! Instead you may want to use 
mean(txhousing$sales, na.rm = TRUE)
quantile(txhousing$sales, na.rm=TRUE)

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


# What about distributions of categorical variables?
obs_by_state <- as.data.frame(table("State" = cps_df$state))
obs_by_state_sex <- as.data.frame(table("State" = cps_df$state, 
                                        "Sex" = cps_df$sex))




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

# What about splitting a dataframe into smaller dataframes?
split_txh_year <- split(txhousing, txhousing$year) #output=list of tibbles 




# Building New Variables 

# Creating a variable based on other variables!
txhousing$avg_price <- txhousing$volume / txhousing$sales

# Using mutate, you can add multiple columns!
txhousing <- txhousing %>% mutate(avg_vs_median = avg_price - median,
                                  lstgs_vs_sales = listings - sales)

# Making a variable based on a specific condition
med_sales <- median(txhousing$sales, na.rm = TRUE)
txhousing$hi_lo_sales <- "high"
txhousing$hi_lo_sales[txhousing$sales < med_sales] <- "low"
# Note, if you had 1 & 0 instead of high & low, this would become an indicator 
# variable instead of a categorical variable

# What if I want a categorical variable with lots of categories and don't want
# to write a line for each one?
month_codebook <- tibble(month = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12), 
                         month_string = c("Jan", "Feb", "Mar", "Apr", "May",
                                          "Jun", "Jul", "Aug", "Sep", "Oct",
                                          "Nov", "Dec"))
txhousing <- left_join(txhousing, month_codebook, by = "month")


# What about making a variable based on the quantile of a variable?
quantiles <- quantile(txhousing$sales, na.rm = TRUE)
quant_sales_cut <- cut(txhousing$sales, c(0, quantiles), include.lowest = TRUE, 
                       labels = c("first", "second", "third", "fourth", "fifth"))
txhousing <- data.frame(txhousing, sales_quantiles = quant_sales_cut)
#You can create a similar column by using the rbin package instead

