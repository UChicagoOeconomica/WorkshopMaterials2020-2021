# Examples for workshop 6 
#(also some additional exercises throughout; all are marked with the word 
# "Exercise")
library(tidyverse)


#### Fibonacci Numbers ####
fibonacci <- function(n, v1=1, v2=1){
  # computes the n-th Fibonacci number of the sequence beginning with V1 and V2
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
# Exercise! 
# make a function as practice! (that directly computes the n-th Fibonacci number)

#### Fibonacci-esque Sequence ####
find_n_seq1 <- function(n, v1=1, v2=1, v3=1){
  # Computes the n-th value of a Fibonacci-esque sequence that randomly
  # adds either the previous two values or the previous three values
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
  # function that returns either the negative or positive reciprocal of a number
  rand <- runif(1)
  if (rand < 0.5){
    y <- x
  } else {
    y <- x * (-1)
  }
  return(1/y)
}
# alternative using sample
rand_harm_one_val_alt <- function(x){
  # function that returns either the negative or the positive reciprocal
  # of a number
  pn <- sample(c(-1,1), 1)
  return(pn / x)
}

rand_harm <- function(n){
  # function that computes a realization of the sum to n of the random harmonic 
  # series
  to_sum <- c(1:n)
  vec <- sapply(to_sum, rand_harm_one_val)
  return(sum(vec))
}

# You can then use this to simulate resulting distributions from 
# the random harmonic series
sim_results <- replicate(500, rand_harm(10000))
# running this line may take a little time 
ggplot(as.data.frame(sim_results), aes(x=sim_results)) + 
  geom_histogram() + 
  theme_bw() +
  geom_vline(xintercept = mean(sim_results), color = "red", size = 1)
ggplot(as.data.frame(sim_results), aes(x=sim_results)) + 
  geom_density() + 
  theme_bw() 

sim_results <- replicate(500, rand_harm(100000))
# running this line will take a little time 
ggplot(as.data.frame(sim_results), aes(x=sim_results)) + 
  geom_histogram() + 
  theme_bw() +
  geom_vline(xintercept = mean(sim_results), color = "red", size = 1)
ggplot(as.data.frame(sim_results), aes(x=sim_results)) + 
  geom_density() + 
  theme_bw() 


#### Extended Random Typewriter Example ####

#### Simplest Random Creation ####
# R has built in constants including letters and LETTERS
# note that some packages also have built in constants; for instance, 
# stringr has the constant 
sentences
# you should avoid naming things the same name as built in constants

# Function that creates a random string of length n
rand_stg <- function(n){
  out <- sample(letters, n, replace = TRUE)
  out <- out %>% str_c(collapse = "")
  return(out)
}

# Function that creates m random strings of length n
m_n_stgs <- function(m, n){
  out <- replicate(m, rand_stg(n))
  return(out)
}

# Function that creates a random string of text with m "words" of length n 
sentence_m_n <- function(m, n){
  out <- replicate(m, rand_stg(n))
  out <- out %>% str_c(collapse = " ")
  return(out)
}


#### Another Layer of Randomization ####
# Function that creates n random strings of random length
n_rand_stgs <- function(n, max = 100){
  # function that generates n random strings, max string length default 100
  stg_lengths <- sample(c(1:max), n, replace = TRUE)
  out <- sapply(stg_lengths, rand_stg)
  return(out)
}

# Function that creates a random string of text with n "words"
stg_n_rand_words <- function(n, mx=100){
  # function that generates one random string with n random "words"; max 
  # word length default 100
  out <- n_rand_stgs(n, mx) %>% str_c(collapse = " ")
  return(out)
}

# Function that creates m random strings of text with random n "words"
m_rand_sentences <- function(m, max_wds=100, max_lets=100){
  # function that generates m random strings with random numbers of words, max
  # "words" default 100, max letters in "word" default 100
  stnce_lgths <- sample(c(1:max_wds), m, replace = TRUE)
  out <- sapply(stnce_lgths, stg_n_rand_words, mx = max_lets)
  return(out)
}

#### Adding Some Punctuation/Regularity ####
# Making the "words" more structured
## Exercise! consider different kinds of randomization; maybe mimic English
##           where some letters must go in certain orders & some letters (e, t, 
##           a, r, etc) are more common; maybe mimic hitting a QWERTY keyboard
##           randomly, where letters in the middle are more common; try both!
# Hint: you can separate out letters into vowels and consonants as follows:
vowels <- c("a", "e", "i", "o", "u")
consonants <- letters[!(letters %in% vowels)]

# Adding some basic punctuation
rand_sentence_n_wds <- function(n, max_wds=100){
  # makes a random sentence that starts with a capital letter and ends with a 
  # period
  sentence <- stg_n_rand_words(n, max_wds)
  first_letter <- str_sub(sentence, 1, 1)
  new_sentence <- paste(toupper(first_letter), str_sub(sentence, 2, -1), ".", 
                        sep = "")
  return(new_sentence)
}

# Exercise! Think of other ways to add punctuation


