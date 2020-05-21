
######################################################
# Lab 03 Example 1: Cereal and Regression Output
######################################################

# Last week we used the cereal data set to explore multiple linear regression
# Let's revisit this model and work with the regression output

# If you installed the Stat2Data package last week, you will not have to do this again
# install.packages("Stat2Data", dep = TRUE)

# Load in the data
data(Cereal, package = "Stat2Data")

# Create the multiple linear regression model
lm.cereal <- lm(Calories ~ Sugar + Fiber, data = Cereal)

# If you run a regression model with every other variable in your dataset
# You can simply type '.' as the predictor
# This would not work here because of the variable 'Cereal', but it would look like
# lm(Calories ~ . , data = Cereal)

# Get a summary of the regression model
summary(lm.cereal)

# You can reference specific parts of the regression model/output including...

# The coefficients
summary(lm.cereal)$coefficients
lm.cereal$coefficients
lm.cereal[[1]]
lm.cereal[[1]][2]

# The residuals
lm.cereal$residuals
lm.cereal[[2]]

# The fitted/predicted values
lm.cereal$fitted.values
lm.cereal[[5]]

# The value of R-squared
summary(lm.cereal)$r.squared

# Other useful functions include
# anova() 
# vcov()
# predict.lm()

# The trickiest one which we'll break down further is predict.lm()
# We're using this function to create an interval for either...
# An individual observation or the mean response GIVEN X (the predictor values)

# So we need to create a new row of data with the given information
# Let's say we want to make predictions for a cereal that has 6g of sugar and 2g of fiber
x.new <- data.frame(Sugar = 6, Fiber = 2)
x.new

# Inputting the regression model, new data, interval type, and confidence level
# We can create either a prediction interval (for an individual observation)
predict.lm(lm.cereal, x.new, interval = "prediction", level = 0.95)

# Or a confidence interval (for the mean response)
predict.lm(lm.cereal, x.new, interval = "confidence", level = 0.95)

# Be very careful to create the variable names exactly as they appear in the data frame
x.new2 <- data.frame(sugar = 6, fiber = 2)
# The following will not run because I used sugar and fiber instead of Sugar and Fiber
predict.lm(lm.cereal, x.new2, interval = "prediction", level = 0.95)

# Be sure to know the contents of the ANOVA table and how they can be used 
# to find various values. This will be tested!
anova(lm.cereal)

# what is the value for the residual sum or squares?
# What is the value for the total sum of squares?
# How is the F test statistic calculated?
# How can we calculate R-squared from this table?
# Where can you find the mean square error (sigma.hat^2)? 





######################################################
# Lab 03 Example 2: Pokemon and Factors
######################################################

# Let's use the Pokemon data set to look for differenes between groups

# If this data set isn't in your Gloabl Environment (found to the right)
# You'll have to reload the data
pokemon <- read.csv("C:/Users/mrulkow/Documents/413SP20/Data Sets/Pokemon.csv", header = TRUE)

# This data set has a few too many groups to start out with, so let's pick four to analyze
# Create a new data set that only includes rows with Type.1 of Bug, Dragon, Fairy, or Steel
pokemon.reduced <- pokemon[pokemon$Type.1 == "Bug" | 
                             pokemon$Type.1 == "Dragon" |
                             pokemon$Type.1 == "Fairy" |
                             pokemon$Type.1 == "Steel", ]

# Because we removed some of the groups, we must re-factor the variable Type.1 
pokemon.reduced$Type.1 <- factor(pokemon.reduced$Type.1)

# Analyze the differences visually with a boxplot
boxplot(pokemon.reduced$Total ~ pokemon.reduced$Type.1,
        xlab = "Type",
        ylab = "Total Sum of Stats (points)")


# When working with categorical variables, 
# You should double check to make sure that R classifies the variable as a factor
str(pokemon.reduced)
# We see that Type.1 is a factor, great!

# If it isn't you can always use the as.factor() function to convert it

# Let's create a regression model predicting Total using Type.1
lm.type <- lm(Total ~ Type.1 , data = pokemon.reduced)
summary(lm.type)

# When looking at the output, we see coefficients for Dragon, Fairy, and Steel
# This means that Bug is our reference group

# All output will be compared to this reference group
# So the average total for Bug is 378.93, but...
# The average total for Dragon isn't 171.60, it's 378.93 + 171.60
# And the average total for Fairy isn't 34.25, it's 378.93 + 34.25
# And the average total for Steel isn't 108.78, it's 378.93 + 108.78

# We can calculate these estimated means using the emmeans() function
library(emmeans) # you'll most likely have to install this package
emmeans(lm.type, ~ Type.1)

# We can also run individual two sample t-tests to see if there are 
# statistically significant differences between any two groups using that pairs() function
# We'll feed in the emmeans function and add the argument 'adjust = "none" '
pairs(emmeans(lm.type, ~ Type.1), adjust = "none")

# This helps us test for differences that weren't in the original output

# We can also run anova, similar to what you learned in your intro stats course
anova(lm.type)
# Here, we are testing that at least one of the groups' mean differs from the rest


# Sometimes you might want a different reference group than what R chooses
# You can use the relevel() function to choose a different baseline category
pokemon.reduced$Type.1 <- relevel(pokemon.reduced$Type.1, "Dragon")

# We can see how our regression output changes.
lm.dragon <- lm(Total ~ Type.1 , data = pokemon.reduced)
summary(lm.dragon)


