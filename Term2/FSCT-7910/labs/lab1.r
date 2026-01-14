"Hello World!" # output text
5 + 5 #output numbers without quotes, simple calculations

plot(1:10)

# print() exist and you can use it in the functions
for (x in 1:10) {
    print(x)
}

# Variable
name <- "John"
age <- 21
name 
age

# Concat Element
paste("My name is", name, "and I am", age, "years old.")
paste(name, age)

# Same value tow multiple variables
a <- b <- c <- 10
a
b
c

# Data types
x <- 10L # integer
class(x) # check data type
y <- 3.14 # numeric
z <- TRUE # logical
complex <- 2 + 3i # complex number, i as imaginary unit
char <- "R Language" # character

# Type Conversion
a <- as.numeric(x)
b <- as.integer(y)

# build in math functions
# max, min, sqrt, abs, log, exp, round, ceiling, floor
# nchar(string) - count number of characters in a string
# grepl() - search for pattern in a string

# R arithmetic operators
# +, -, *, /, ^, %/%, %%, etc.
# R Comparison operators
# <, >, <=, >=, ==, !=
# R Logical operators
# & , &&, |, ||, !

# Nested If statements
 x <- 41

if (x > 10) {
  print("Above ten")
  if (x > 20) {
    print("and also above 20!")
  } else {
    print("but not above 20.")
  }
} else {
  print("below 10.")
} 

# While Loop
i <- 1
while (i <= 5) {
    print(i)
    i <- i + 1
    if (i == 3) {
        break
    }
    if (i == 1)
        next
}

# For Loop
fruits <- list("apple", "banana", "cherry")

for (x in fruits) {
  print(x)
} 

# Functions
my_function <- function(param1, param2) {
    result <- param1 + param2
    return(result)
}
my_function(5, 10)

# Data Structures
# Vectors
vec <- c(1, 2, 3, 4, 5)
# List
my_list <- list(name="John", age=30, city="New York")
# Matrix
my_matrix <- matrix(1:9, nrow=3, ncol=3)
# Arrays
my_array <- array(1:12, dim=c(3,4)) #dimensions 3x4
# Data Frames
my_data_frame <- data.frame(
    Name = c("John", "Jane", "Doe"),
    Age = c(28, 34, 29),
    City = c("New York", "Los Angeles", "Chicago")
)
# Vector Length
length(vec)
# Sort Vectors
sort(vec, decreasing=TRUE)

# Accessing List Elements
fruits <- c("apple", "banana", "cherry")
fruits[1] # first element
fruits[c(1,3)] # first and third elements
fruits[c(-1)] # all except first element
fruits[1] <- "orange" # modify first elements

# Plotting
plot(1,3)
plot(c(1,8), c(3,10)) 
plot(c(1, 2, 3, 4, 5), c(3, 7, 8, 9, 12)) 

x <- c(1, 2, 3, 4, 5)
y <- c(3, 7, 8, 9, 12)
plot(x, y) 

plot(1:10)
plot(1:10, type="l", lwd=3, )  

plot(1:10, main="My Graph", xlab="The x-axis", ylab="The y axis", col="blue", pch=19) 

line1 <- c(1, 3, 5, 7, 9)
line2 <- c(2, 4, 6, 8, 10)
plot(line1, type="l", col="red", lwd=2)
lines(line2, type="l", col="blue", lwd=2)

# Scatter Plot
x <- c(5,7,8,7,2,2,9,4,11,12,9,6)  
y <- c(99,86,87,88,111,103,87,94,78,77,85,86)
plot(x, y) 

# Compare plot
# day one, the age and speed of 12 cars:
x1 <- c(5,7,8,7,2,2,9,4,11,12,9,6)
y1 <- c(99,86,87,88,111,103,87,94,78,77,85,86)

# day two, the age and speed of 15 cars:
x2 <- c(2,2,8,1,15,8,12,9,7,3,11,4,7,14,12)
y2 <- c(100,105,84,105,90,99,90,95,94,100,79,112,91,80,85)

plot(x1, y1, main="Observation of Cars", xlab="Car age", ylab="Car speed", col="red", cex=2)
points(x2, y2, col="blue", cex=2) 

# Pie
x <- c(10, 20, 30, 40)
mylabels <- c("Apple", "Banana", "Cherry", "Date")
pie(x, labels = mylabels, main="My Pie Chart")

# Legends
mylabel <- c("Apple", "Banana", "Cherry", "Date")
colors <- c("red", "yellow", "pink", "brown")
pie(x, labels = mylabel, col=colors, main="My Pie Chart with Legend")
legend("bottomright", mylabel, fill=colors)

# Bar Charts
x <- c("A", "B", "C", "D")
y <- c(10, 20, 15, 25)
barplot(y, names.arg=x, horiz=TRUE)

# Data Set
mtcars
?mtcars

# Dimension
Data_Cars <- mtcars
dim(Data_Cars)
names(Data_Cars)

# Row name
rownames(Data_Cars)

# Print variable Values
Data_Cars$cyl
sort(Data_Cars$cyl) # Sort
summary(Data_Cars)
mean(Data_Cars$mpg) # Mean
median(Data_Cars$mpg) # Median
mode(Data_Cars$mpg) # Mode
var(Data_Cars$mpg) # Variance
sd(Data_Cars$mpg) # Standard Deviation
range(Data_Cars$mpg) # Range
min(Data_Cars$mpg) # Minimum
max(Data_Cars$mpg) # Maximum
quantile(Data_Cars$mpg) # Quantile


