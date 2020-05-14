
######################################################
# Lab 02 Example 1: Load Data into R
######################################################

# Data sets come in a variety of file formats and can be accessed in a variety of ways
# Here, we'll learn how to load data into R



##### Built-In Data #####

# R has some data sets already built in!
# Simply run the function data() with the data set name as the input
data(iris)

# To see all of the data sets R has to offer, click the "Global Environment" drop-down
# (in the Environment window to the right) and select "package:datasets". All of this data is
# built into R and ready to be loaded into your Gloabl Environment using the data() function.



##### Data from Packages #####

# One of the greatest benefits of R is that it is open-sourced
# We can utilize user-created functions and packages instead of coding them from scratch
# Many of these packages also contain useful data sets

# WARNING!!! 
# If you are using a package for the first time, you'll need to install the package
# first in order to access its contents

# So if you run the following code below and you get an error...
data(water, package = "alr4")
# ...it's probably because the "alr4" package is not installed on your local machine

# You must first install the package 'alr4'
# You can do this easily by running the following code
install.packages("alr4", dep = TRUE)

# You only need to do this once ever per machine (it will be stored for future use)
# Now rerun the original code above to load the 'water' data set

# If you didn't get any errors, great! The 'water' data set should be loaded in and
# accessible in your Global Environment. This data was used in Homework 1, Question 5



##### Data from CSV Files #####

# Find a cool data set online and want to load it in? No problem!
# The most common function for loading in non-R data sets is read.csv()
# You can load in comma separated files, tab-delimited files, and many more

# First, let's see all of the different inputs for this function
# Note: you can run the help function to get documentation on any R function!
help(read.csv)

# With read.csv() you'll usually only need to specify the inputs 'file' and 'header'
# but 'sep', 'row.names', 'col.names', and 'na.strings' can all be very useful too

# The argument 'file' is the file name and
# 'header' is a logical argument - TRUE if your data has a header row, FALSE if not

# The first step is determining your current working directory
getwd()
# This is where R will try and load the data from (unless specified otherwise)
# If your data file is not in this location, R will not be able to find it!
# To properly load in data, you have three options

# Option 1
# Save the data file to your working directory (in the folder listed from getwd())
# This is probably the easiest option. Then, run the following code:
fish <- read.csv(file = "fish.csv", header = TRUE)

# Option 2
# Specify the entire file path
# This is the probably the most robust option. You might want your data set saved in a 
# different folder than your working directory and this is how you can access it!
# For example, my working directory is my Documents folder, but I want the file saved
# specifically to my Stats 413 file - so I need to specify the following...
fish.data <- read.csv(file = "C:/Users/mrulkow/Documents/413SP20/fish.csv", header = TRUE)

# The above shouldn't work for you...unless your name is also Mark Rulkowski...

# Option 3
# Change your working directory (not recommended). You can relocate your working directory
# to wherever your file is saved
setwd("C:/Users/mrulkow/Desktop")
# And then load in the file
fishfile <- read.csv(file = "fish.csv", header = TRUE)








######################################################
# Lab 02 Example 2: Estimating Regression Coefficients
######################################################


# Let's use the data from the end of the Simple Linear Regression lecture notes (2)
# First we need to create the data. To do this use the c() function (combine), which 
# combines values into a vector or list
x <- c(4, 6, 8, 10)
y <- c(20, 16, 17, 11)

# If you ever want to print objects, simply type them out
# If you want to print multiple objects at once, separate them with a semicolon (;)
x; y

# We need to calculate the sum of squares for XY and XX
# Using the sum function on a vector will sum each element together
sum(x)
sum(y)

# If you sum two vectors together, it will add up the elements of both vectors
sum(x + y)

# BUT if you add two vectors, it will add element-by-element (and leave you with a vector)
# So be careful and always test your code to make sure it's doing what you expect!
x + y

# What happens if we square a vector? It squares the individual elements
x^2

# We can do multiple steps in one line of code
# If we use sum and ^2, we will square the individual elements and sum them up
sum(x^2)
# This gives us the uncentered sum of squares, which isn't exactly what we want

# For the centered sum of squares, we need to subtract the mean
# Again, we can combine the steps into one, succinct line of code
sum((x - mean(x))^2)
# Note; be careful with parentheses!

# Let's save this result for later
ssxx <- sum((x - mean(x))^2)

# Spacing can be key for having neat, understandable code
ssxy <- sum((x - mean(x)) * (y - mean(y)))

# Now we can estimate the regression coefficients!
beta.hat.1 <- ssxy / ssxx
beta.hat.0 <- mean(y) - (beta.hat.1 * mean(x))

beta.hat.0; beta.hat.1

# Let's plot our results to double check
# Use the abline function to add in the regression line
plot(x, y)
abline(a = beta.hat.0, b = beta.hat.1)



# How about for multiple linear regression?
# We learned how to solve for the coefficients using matrices

# Let's use the cereal data set for this example
# You'll have to install the following package for this to work
install.packages("Stat2Data", dep = TRUE)

# And now load in the data
data(Cereal, package = "Stat2Data")

# We will use Sugar and Fiber to predict the Calories for cereals
# First, we'll need to create our X and Y matrices
# Where X is the design matrix. We can create this using the model.matrix() function
# The input for this function is a little trickier, but your first argument will be 
# the predictor variables and the second argument is the name of your data set
X <- model.matrix( ~ Sugar + Fiber, data = Cereal)

# Let's see what we've created
class(X)
X
# We've created a matrix and it includes a column of 1's for the intercept - wonderful!

# Creating Y is even easier, as it is simply the response vector
Y <- Cereal$Calories


### Matrices ###

# Matrix Multiplication 
# To find the coefficients, we must use matrix multiplication
# In R, you must use the code %*% to run matrix multiplication
# If you simply use *, you will not get the desired result

# Transposes
# Really simple, the function is just t() with the matrix as the input
t(X)

# Inverses
# To find the inverse of a matrix, use the function solve()
solve(t(X) %*% X)

# Let's combine all of these together to get the beta estimates
beta.hat <- solve(t(X) %*% X) %*% (t(X) %*% Y)
beta.hat



# Okay, now let's find the estimates the easy way - using R's linear model function lm()
# To create a linear model, use the following template...
# lm(Y ~ X1 + X2 + X3, data = data.name)

# So for the cereal example, we would have
lm(Calories ~ Sugar + Fiber, data = Cereal)

# The numbers check out! But what if we want additional information?
# Save your model and use the summary() function
lm.cereal <- lm(Calories ~ Sugar + Fiber, data = Cereal)
summary(lm.cereal)

# You can reference specific output values as well
# We'll use these more next week, but you can take at some examples

# Reference the coefficients
summary(lm.cereal)$coefficients
lm.cereal$coefficients
lm.cereal[[1]]
lm.cereal[[1]][2]

# Reference the residuals
lm.cereal$residuals
lm.cereal[[2]]

# Reference the fitted/predicted values
lm.cereal$fitted.values
lm.cereal[[5]]

# Reference the R-squared value
summary(lm.cereal)$r.squared
  
