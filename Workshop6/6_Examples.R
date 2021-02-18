# Examples for workshop 6
library(tidyverse)


#### Fibonacci Numbers ####
fibonacci <- function(n, v1=1, v2=1){
  f_0 <- v1
  f_1 <- v2
  f_o <- 0
  for (i in c(1:(n-2))){
    f_o <- f_0 + f_1
    f_1 <- f_0
    f_0 <- f_o
  }
  return(f_o)
}

#### Fn formula####
phi <- (1 + 5 ^ 0.5) / 2
psi <- (1 - 5 ^ 0.5) / 2
# Fn = phi^n - psi^n / sqrt(5)
# make a function as practice!

#### Fibonacci-esque Sequence ####
find_n_seq1 <- function(n, v1=1, v2=1, v3=1){
  f_0 <- v1
  f_1 <- v2
  f_2 <- v3
  f_o <- 0
  for (i in c(1:(n-2))){
    rand <- runif(1)
    if (rand < 0.5){
      f_o <- f_1 + f_2
    } else {
      f_o <- f_0 + f_1 + f_2
    }
    f_0 <- f_1
    f_1 <- f_2
    f_2 <- f_o
  }
  return(f_o)
}


#### Random Harmonic Sums ####
rand_harm_one_val <- function(x){
  rand <- runif(1)
  if (rand < 0.5){
    y <- x
  } else {
    y <- x * (-1)
  }
  return(1/y)
}

rand_harm <- function(n){
  to_sum <- c(1:n)
  vec <- sapply(to_sum, rand_harm_one_val)
  return(sum(vec))
}


#### Find Minimum Power ####





#### Extended Random Typewriter Example ####

#### Simplest Random Creation ####
alphabet <- c("a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", 
              "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z")
# Function that creates a random string of length n

# Function that creates m random strings of length n

# Function that creates a random string of text with m "words" of length n 


#### Another Layer of Randomization ####
# Function that creates n random strings of random length

# Function that creates a random string of text with n "words"

# Function that creates m random strings of text with random n "words"

#### Adding Some Punctuation/Regularity ####
# Making the "words" more structured
vowels <- c("a", "e", "i", "o", "u")
consonants <- alphabet[!(alphabet %in% vowels)]
# Adding some basic punctuation



