## Programming concepts
## 1.Variable
## 2.Data type
## 3.Data structures
## 4.Control flow
## 5.Function 

## 1.Create Variable
my_name <- "Fa"
my_age <- 27
fav_language <- "R language"
movie_lover <- TRUE ##FALSE

#Remove Variable
rm(my_age) ## Or clear object from the workspace

## 2.Data Types
#Numeric
#Character(String,Text)
#Logical(Boolean)
#Date

x <- 100
class(x)

class(my_name)
class(movie_lover)

d <- as.Date("2023-11-3")
class(d)

## 3.Data Structures
#Vector
#Matrix
#List
#Dataframe

#let's learn vector
1:10
1:25
5:100

seq(from=1, to=30, by=2)
seq(1,30,2)

rep("Fa", 10)
rep(2, 15)

score <- c(25, 50, 66, 100, 80)
length(score)
score <- append(score, 75)

score[1]
score[1:3]
score[c(1,2,6)]

friends <- c("Lisa", "Rose", "Jennie", "Jisoo")
which(friends == "Jennie")
friends  <- append(friends, "Irine")
friends  <- append(friends, "IU")
friends[score < 75]
friends[score == 100]

new_score <- c(Lisa=55, "Wendy"=70, "CL"=65)
new_score[new_score == 70]
new_score["Wendy"]

number <- c(30, 27, 15, 26, NA, 41)
is.na(number)
!is.na(number)
number[!is.na(number)]
number <- number[!is.na(number)]
sum(number)
mean(number)

#Matrix

1:10
matrix(1:10, nrow=5, ncol=2)
x <- 1:6
matrix(x, nrow = 2)
x1 <- matrix(x, nrow = 2)
x2 <- matrix(5:12, nrow=2)
x3 <- matrix(5:12, nrow=2, byrow=TRUE)

x4 <- x1 + 100
x1+x4
x4-x1

#Data frame
id <- 1:5
friends <- friends[friends!="Irine"]
age <- c(34, 32, 28, 25, 29)
movie_lover <- c(TRUE,FALSE,FALSE,TRUE,TRUE)

df <- data.frame(id, friends, age, movie_lover)
View(df)
write.csv(df,"friends.csv")

df$id
df$movie_lover

df$city <- c(rep("Bangkok",3),rep("London",2))

df$city <- NULL
toupper(df$friends)
df$age <- df$age + 1

df[1, 1:4]
df[1:3, 1:4]
df[1:3,]
df[,1:3]
df[df$age < 30,]

install.packages("sqldf")
library(sqldf)
sqldf("SELECT COUNT(*) FROM df")
sqldf("SELECT id, friends FROM df")
sqldf("SELECT COUNT(*), SUM(age), AVG(age) FROM df")
sqldf("SELECT movie_lover, AVG(age) FROM df GROUP BY movie_lover")

#Structure
str(df)
head(df,3)
tail(df,2)

summary(df)
summary(df$age)

#List, most flexible in R

my_playlist <- list(name = "Fa",
                    age = 27,
                    city = "BKK")
my_playlist$name
cust1 <- my_playlist 
cust2 <- list(name = "Marry",
              age = 28,
              city = "CNX")

cust3 <- list(name = "Kevin",
              age = 26,
              city = "KIK")

#NO-SQL document database(JSON)
all_cust <- list(
  fa = cust1,
  marry = cust2,
  kevin = cust3
)

#Function 
print("hello")
greeting <- function(){
  print("hello")
}
greeting()

Add_n <- function(x,y){
  return(x+y)
}
Add_n(5,10)

greeting <- function(){
  name <- readline("What's you name?")
  print(paste0("Hello ", name))
}
greeting()

#Default argument
greeting <- function(name="Fa"){
  print(paste("Hello! ", name))
}
greeting("Baby")

#Control flow
#If, For , While

score <- 79
if(score >=  80){
  print("Passed")
} else {
  print("Failed")
}

grading <- function(score){
  if(score >=  80){
    print("Passed")
  } else {
    print("Failed")
  }  
}
grading(68)

grading <- function(score) {
  if (score >= 80) {
    return("A")
  } else if (score >= 70) {
    return("B")
  } else if (score >= 60) {
    return("C")
  } else if (score >= 50) {
    return("D")
  } else {
    return("Failed")
  }
}
grading(80)

#For Loop

fruits <- c("apple", "mango", 
            "orange", "durian", "grape")


for (i in fruits) {
  if (i == "orange") {
    print("Found Orange!")
  } else {
    print("Other fruits!")
  }
}

#While Loop
count <- 0
while (count < 10) {
  print("hello world")
  #counter
  count <- count + 1
}

chatbot <- function() {
  while(TRUE) {
    user_fruit = readline("Guess the fruit: ")
    if (user_fruit == "mango") {
      print("Correct!")
      break
    } else {
      print("Nope! Try again.")
    }
  }
}