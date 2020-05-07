
######################################################
# Lab 01 Example: Iris
######################################################

# (This is a comment) Lab 01 Script
# Commenting code is extremely important! 
# Future you will thank past you when referring to something a few weeks later

# To run a line of code, hit "Ctrl + Enter"
# You can run multiple lines of code by highlighting them and hitting "Ctrl + Enter"

# We will cover many ways to load data into R throughout the course
# For now, we will use the data set 'iris' which is built into R
data(iris)

# View the data by clicking on the data set in the environment (in the top right window)
# Or by running the following command
View(iris)

# You can also view only the first few rows of a data set by using head()
head(iris) # The default for this function is the first 6 rows

# The columns are the variables of interest
# The rows are the individual observations (here, each observation is a flower)

# The function str() shows us the structure of the data set, including individual variable information
str(iris)
# We see that 'iris' is a data frame with 5 variables - 4 numeric (quantitative) and 1 factor (categorical)

# Calculate the mean of the variable 'Sepal.Length':
mean(iris$Sepal.Length) # We can reference a specific variable in the data set with the $

# For more information on a specific function, you can type a '?' followed by the function name
?mean 
help(mean) # Or you can type 'help(function_name)'
# This will bring up R documentation in the bottom right window

# Get summary statistics of all variables
summary(iris)
# This gives us the five number summary of each variable plus the mean
# Because Species is categorical, summary tells us how many observations fall into each group



# Graphing One Variable
# Histograms are great for univariate analysis
hist(iris$Sepal.Length)
# Boxplots are also wonderful for univariate analysis 
boxplot(iris$Sepal.Length)
# And for side-by-side comparions
boxplot(iris$Sepal.Length ~ iris$Species)



# Graphing Two Variables
# It is good practice to have neat plots with appropriate labels/titles and attribution
# The plot function has many arguments, some of the basics are: 
# plot(x, y, xlab = 'x-axis title', ylab = 'y-axis title', main = 'plot title')

# Graph the variable 'Petal.Length' as a response to the explanatory variable 'Sepal.Length'
plot(iris$Sepal.Length, iris$Petal.Length, xlab = "Sepal Length (cm)", ylab = "Petal Length (cm)",
     main = "Petal Length versus Sepal Length for 150 Iris\nby Mark Rulkowski")

# You can also add color to the plot 
plot(iris$Sepal.Length, iris$Petal.Length, 
     xlab = "Sepal Length (cm)", 
     ylab = "Petal Length (cm)",
     main = "Petal Length versus Sepal Length for 150 Iris\nby Mark Rulkowski",
     col = iris$Species)

# You are more than welcome to use other plotting packages if you feel comfortable doing so





######################################################
# Lab 01 Additional Help - swirl
######################################################

# If you're new to coding completely, it might be worthwhile to learn the basics in their entirety
# The package 'swirl' has many helpful tuturoials to get you started with R

# Note: you should run the following line of code in the Basic R Console, outside of RStudio
install.packages("swirl") # To install swirl (you will only have to do this once per machine)
# Again, if you got an error with the above line of code, try it in the Basic R Console, outside of RStudio

library(swirl) # To access swirl (you will have to do this every time you open R)

# To enter swirl
swirl()

# Navigate to Lesson 1, by selecting '1: R Programming' and '1: Basic Building Blocks'
# Once you have completed Lesson 1, keep exploring!
# To exit swirl, run the following line of code
bye()





