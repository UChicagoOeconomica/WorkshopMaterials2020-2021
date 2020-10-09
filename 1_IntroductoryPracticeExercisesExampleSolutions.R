# Workshop 1 Example Solutions to Practice Exercises 
# This document contains some possible solutions to the practice exercises
# Note that while each of these are solutions, they are by no means the only
# solutions to the exercises

####### Solutions here; press the arrow or rectangle to view if hidden #######




# Find the reminder from dividing 1298460519 by 27
# running this line will find the remainder
1298460519 %% 27
# running this line will save the remainder as the variable "remainder"
remainder <- 1298460519 %% 27


# Define a string variable
str_var <- "Oeconomica"

# Define a boolean variable
bool_var <- TRUE

# Define a numeric variable 
num_var <- 2020.1014

# Turn the three variables you just created into a vector
vector1 <- c(str_var, bool_var, num_var)

# Check what kind of vector you just created
typeof(vector1)

# Write code that will randomly generate either TRUE or FALSE (50% of the time each)
x <- runif(1)
x < 0.5

# Make a vector containing the integers from one to ten inclusive
vector2 <- c(1:10)

# Look up the function rev() and write code that produces the same result using 
# the vector you just created; save that result as another vector
?rev
int_vector <- rep(11, 10)
vector3 <- int_vector - vector2
#note the last two lines can also be combined, as in:
vector3 <- rep(11, 10) - vector2

# Take the last two vectors you created and concatenate them into one longer 
# vector
vector4 <- c(vector2, vector3)

# Take the last two vectors you created and add their elements together pairwise
vector5 <- vector4 + vector3

# Make a vector that contains the even numbers from 15 to 35 two different ways
vector6 <- seq(16:34)

int_vector <- seq(15:35)
vector6 <- int_vector[int_vector %% 2 == 0]

# Write code that draws a number from a normal distribution with mean 25 and 
# standard deviation 2
x <- rnorm(1, mean = 25, sd = 2)

# Determine how likely it was that you drew that number
dnorm(x, mean = 25, sd = 2)

# Draw three random integers from 0 to 100
sample(0:100, 3)

# Use R to determine how many characters there are in 
# "Oeconomica workshops occur Wednesday evenings at 6:30pm"
s <- "Oeconomica workshops occur Wednesday evenings at 6:30pm"
nchar(s)

# Use R to turn each word in 
# "Oeconomica workshops occur Wednesday evenings at 6:30pm" into its own string
strsplit(s, " ")

