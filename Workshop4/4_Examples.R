# Examples for Workshop 4

# Load packages and set your working directory at the top of your files
# Your working directory should automatically be the folder of your R project if
# you are working in an R project. Keeping track of file paths is very important
# when using data and producing output files
library(ggplot2) 
# You can alternatively load the tidyverse package which includes ggplot2

data("iris")

# It is not necessary to use ggplot to make plots in R, for example:
plot(iris$Petal.Length, iris$Petal.Width)
# We can add titles!
plot(iris$Petal.Length, iris$Petal.Width, xlab = "Petal Length", 
     ylab = "Petal Width")

# What about saving the graph? -You have several options

# If you already have a plot:
hist(iris$Petal.Length[iris$Species == "setosa"], 
     main = "Distribution of Petal Lengths of Setosa Irises", 
     col = "mediumorchid4", xlab = "Petal Length")
# You can find a list of colors in R at:
# http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf
dev.copy(pdf, "Workshop4/Output/example_hist.pdf")
dev.off()
# Make sure to save to your output folder!
# Make sure that your filetypes match and that your title is sufficiently 
# descriptive!
# Be aware that R will overwrite files 


# You can open a file and write to it
jpeg("Workshop4/Output/example_scatter.jpg")
plot(iris$Petal.Length, iris$Petal.Width, xlab = "Petal Length", 
     ylab = "Petal Width")
dev.off()

# You can save a graph to your environment and then add it to a file
# Although you can directly save ggplots, you need to use recordPlot for base R 
# plots
lg_iris_spec <- table(iris$Species[iris$Petal.Length > mean(iris$Petal.Length)])
barplot(lg_iris_spec, xlab = "Species", 
        main = "Bar Graph of Observations With Longer Than Average by Species",
        col = "slateblue4")
lg_spec_plot <- recordPlot()
sm_iris_spec <- table(iris$Species[iris$Petal.Length < mean(iris$Petal.Length)])
barplot(sm_iris_spec, xlab = "Species", 
        main = "Bar Graph of Observations With Shorter Than Average by Species", 
        col = "violet")
sm_spec_plot <- recordPlot()

pdf("Workshop4/Output/example_2bargraphs.pdf")
print(lg_spec_plot)
print(sm_spec_plot)
dev.off()
# This puts both plots in the same file on different pages

data("txhousing")
head(txhousing)

# ggplot has a different structure; for example
ggplot(txhousing[txhousing$city == "Abilene",], aes(x = date, y = sales)) +
  geom_line() +
  theme_classic() +
  labs(title = "Housing Sales in Abilene Over Time", x = "Date", y = "Sales")
# You can find ggplot themes here:
# https://ggplot2.tidyverse.org/reference/ggtheme.html
# You can also make your own themes

# A major benefit of ggplot is the ease of adding additional information
ggplot(txhousing, aes(x = date, y = sales, color = city)) +
  geom_line() +
  theme_classic() +
  labs(title = "Housing Sales in Abilene Over Time", x = "Date", y = "Sales")
# but you want to be careful to not add too much information!

# You can directly save a ggplot!
ggplot(txhousing, aes(x = log(sales), y = median, color = as.factor(month))) +
  geom_point() +
  theme_minimal() +
  labs(title = "Median Price Compared to Number of Sales by Month", 
       x = "Number of Sales Log Scale",
       y = "Median Price")
ggsave("Workshop4/Output/example_ggplot.png")
# Sometimes log scales are useful to better fit the data on the graph

# Note that ggplots can be saved directly to your environment, you don't need to
# to use recordPlot()

example_ggplot <- ggplot(txhousing, aes(x = listings, y = sales)) + 
  geom_point() +
  theme_light()
print(example_ggplot)





