# Workshop 1 Example Code
# This document contains examples to be covered during the workshop.

# Creating Variables 
a <- 1

b <- 2 + 3

c <- TRUE 

d <- FALSE 

e = 1.879

f = "Oeconomica"

g = NA

h = NULL 

# Some basic functions
typeof(f)

is.numeric(a)

is.integer(e)

3*e

3 + e

45 %% 3

a == b 

a > b 

a <= b

c != (a <= b)

factorial(b)

# Creating vectors

x <- c(1, 2, 3)

y <- c(1:15)

z <- 12:-12

w <- seq(1, 5, by = 0.25)

v <- seq(0, 5, length.out = 6)

u <- rep(0, 25)

t <- rep(1L, 25)

s <- replicate(25, 2)

r <- c(TRUE, FALSE, TRUE)

q <- c("A", "a", "B")

p <- c(a, b, c)

# Some basic things you can do with vectors
x[1]

x[-1]

w[2:4]

z[c(1,9,4)]

v[v > 2]

y[y %% 2 == 0] <- 1

length(u)

u[15:length(u)] <- 0.5

u + t

c(x, s)

c(x, s)[1:6]

x + r

max(x)

mean(x)

table(u + t)

cumsum(y)

# Random number generations and probability distributions
runif(1)

runif(3)

runif(3, min=0, max=20)

sample(1:100, 3, replace = TRUE)

sample(q, 1)

rnorm(3)

dnorm(3)

pnorm(3)

qnorm(0.95)

# Some basic string functions 
a <- "Oeconomica"
b <- "Workshop"
ab <- paste(a, b, sep = " ")
nchar(ab)
substr(ab, 0, 5)
toupper(ab)
tolower(ab)
strsplit(ab, " ")
strsplit(ab, "o")
ac <- sub("Workshop", "Meeting", ab)


# Most important command = ?<command name>
?floor
?ceiling
?round 

