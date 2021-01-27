# Examples for Workshop 5
# Packages to load!
library(tidyverse)
library(stargazer) 
# if you do not have the stargazer package, you will need to install it



## An example
tfp_df <- read.csv("Workshop5/Data/TFP.csv")
# it's always helpful to glance over the data first:
summary(tfp_df)
# your experience plotting things from Workshop 4 can be helpful!
# for instance, we can look at the relationship between output and labor
ggplot(tfp_df, aes(x=Labor.input, y = Value.added.output)) + 
  geom_point() + 
  labs(x="Labor", y = "Output", 
       title = "Relationship Between Labor and output") + 
  theme_bw()

# note that ggplot already allows us to easily add a line to represent the most
# basic regression
ggplot(tfp_df, aes(x=Labor.input, y = Value.added.output)) + 
  geom_point() + 
  labs(x="Labor", y = "Output", 
       title = "Relationship Between Labor and output") + 
  theme_bw() + 
  geom_smooth(method = lm)
# This just represents the regression of y on x and a constant, i.e. no controls

# We can find this line via regression using the lm command
lm(formula = Value.added.output ~ Labor.input, data = tfp_df)
# or even better
lab_output_mod1 <- lm(formula = Value.added.output ~ Labor.input, data = tfp_df)
summary(lab_output_mod1)

lab_output_mod2 <- lm(formula = Value.added.output ~ Labor.input + 
                        Capital.services, data = tfp_df)
summary(lab_output_mod2)

stargazer(lab_output_mod1, lab_output_mod2,
          align=TRUE, no.space=TRUE, #omit.stat="f",
          dep.var.labels = c("Value Added Output"),
          covariate.labels = c("Labor Input",
                               "Capital Services"),
          title="Value Added Output Regressions",
          digits=4)
# the default for stagazer is to give you output in LaTeX! 

stargazer(lab_output_mod1, lab_output_mod2,
          align=TRUE, no.space=TRUE, omit.stat="f",
          dep.var.labels = c("Value Added Output"),
          covariate.labels = c("Labor Input",
                               "Capital Services"),
          title="Value Added Output Regressions",
          type = "text",
          digits=4)

# You can directly save to a file using Stargazer
stargazer(lab_output_mod1, lab_output_mod2,
          align=TRUE, no.space=TRUE, omit.stat="f",
          dep.var.labels = c("Value Added Output"),
          covariate.labels = c("Labor Input",
                               "Capital Services"),
          title="Value Added Output Regressions",
          digits=4,
          out = "Workshop5/Output/exampletable1.txt")


cd_output_mod <- lm(formula = log(Value.added.output) ~ log(Labor.input) + 
                      log(Capital.services), data = tfp_df)



## Another Example
cps_df <- read.csv("Workshop5/Data/CPS.csv")

Post_HS_degrees <- unique(cps_df$educ)[c(1, 3, 5, 7, 9, 16)]
cps_df$has_degree <- ifelse(cps_df$educ %in% Post_HS_degrees, TRUE, FALSE)

# Using linear regression we can find the difference in having a post-high
# school degree versus not having one
deg_impact_mod1 <- lm(data = cps_df, incwage ~ has_degree)

be_has_degree <- mean(cps_df$incwage[cps_df$has_degree])
be_no_degree <- mean(cps_df$incwage[!cps_df$has_degree])

lm(data = cps_df, incwage ~ has_degree, subset = (sex == "Male"))
lm(data = cps_df, incwage ~ has_degree, subset = (sex == "Female"))

deg_impact_mod2 <- lm(data = cps_df, incwage ~ has_degree + sex)

be_fm_no_degree <- mean(cps_df$incwage[(!cps_df$has_degree) & 
                                         cps_df$sex=="Female"])

mean(cps_df$incwage) - 39540.6 * mean(cps_df$has_degree) - 24141.3 * 
  (length(cps_df$incwage[cps_df$sex=="Male"])/length(cps_df$incwage))

deg_impact_mod3 <- lm(data = cps_df, incwage ~ has_degree * sex)

# lm(data = cps_df, incwage ~ has_degree:sex + has_degree + sex)

deg_impact_mod4 <- lm(data = cps_df, incwage ~ has_degree * sex + age)

deg_impact_mod5 <- lm(data = cps_df, incwage ~ has_degree + sex + age)

educ_impact_mod1 <- lm(data = cps_df, incwage ~ factor(educ))

educ_impact_mod2 <- lm(data = cps_df, incwage ~ factor(educ) + sex + age)

stargazer(deg_impact_mod1, deg_impact_mod2, deg_impact_mod3, 
          deg_impact_mod4, deg_impact_mod5,
          align=TRUE, no.space=TRUE, omit.stat="f",
          dep.var.labels = c("Value Added Output"),
          covariate.labels = c("Has Degree",
                               "Male", "Age", "Has Degree * Male"),
          title="Value Added Output Regressions",
          digits = 4, out = "Workshop5/Output/exampletable2.txt")
