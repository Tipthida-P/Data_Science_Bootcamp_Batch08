library(tidyverse)
library(RSQLite)
library(glue)

## String Template
my_name <- "Fa"
age <- 27
city <- "Lampang"

text <- glue("Hello my name is {my_name} and I'm {age} years old and I live in {city}")

## Working with Date
d <- "2023-NOV-4"
class(d)

## Lubridate
ymd(d)
d <- "4/11/2023"
dmy(d)

d <- "2023-11-4"
year(d)
month(d, label = T, abbr = F)
wday(d, label = T, abbr = F)

d <- date(d)
class(d)
d+1

# Tidyverse - dplyr
# 1.Select
# 2.Filter
# 3.Arrange
# 4.Mutate (create new column)
# 5.Summarise + group_by (aggregate in SQL)

## Select
View(mtcars)
select(mtcars, mpg, cyl, disp, hp, am)

select(mtcars, mile_per_gallon = mpg, weight = wt)

select(mtcars, starts_with("m"))
select(mtcars, ends_with("p"))
select(mtcars, contains("a"))

## Rownames to Column
row.names(mtcars)
mtcars <- rownames_to_column(mtcars, var="model")

## Filter by Condition
## Filter mtcars Dataframe for hp>100
filter(mtcars, hp > 100 & disp > 300 & mpg > 15)
filter(mtcars, model == "Mazda RX4")
## Regular Expression
filter(mtcars, grepl("^M", model))
filter(mtcars, grepl("C$", model))

## dplyr the right way %>% (PIPE)
## data pipeline in R
mtcars %>%
  select(model, mpg, am, hp) %>%
  filter(hp > 100, mpg > 15)
  
## Sort Data

arrange(mtcars, model, desc(mpg))

df1 <- mtcars %>%
  select(am, mpg) %>%
  arrange(am, desc(mpg))

## Mutate is Create new column

mtcars %>%
  select(model, mpg) %>%
  filter(mpg > 20) %>%
  mutate(model = tolower(model),
         mpg_double = mpg*2,
         mpg_add_five = mpg+5,
         mpg_log = log(mpg))

## Mutate am, 0=Auto, 1=Manual
mtcars <- mtcars %>%
  mutate(am = ifelse(am==0, "Auto", "Manual"))

## Summarise + Group_by
summarise(mtcars,sum_mpg = sum(mpg), avg_mpg = mean(mpg))
          
mtcars %>%
  group_by(am) %>%
  summarise(avg_mpg = mean(mpg),
            sum_mpg = sum(mpg),
            min_mpg = min(mpg),
            max_mpg = max(mpg),
            std_mpg = sd(mpg),
            var_mpg = var(mpg),
            med_mpg = median(mpg),
            n = n())

## Simple pipeline
mtcars %>%
  select(mpg, hp, wt, am) %>%
  filter(mpg >= 15) %>%
  group_by(am) %>%
  summarise(n= n())

## Read_csv() from internet
df <- read_csv("https://gist.githubusercontent.com/seankross/a412dfbd88b3db70b74b/raw/5f23f993cd87c283ce766e7ac6b329ee7cc2e1d1/mtcars.csv")

class(df)
## Change datatype to tibble 
tibble(mtcars)

df %>% head
head(df)
df %>% tail
tail(df)

df %>%
  select(model, milePerGallon = mpg) %>%
  arrange(milePerGallon)

## Sampling (random sample)
sample_n(df, 3)

set.seed(42)
df %>%
  select(model, hp) %>%
  filter(hp > 100) %>%
  sample_n(3) 

## Sampling %
sample_frac(df, 0.5) ## Quantity =50%

df %>%
  sample_frac(0.1) # 10%

## Count => Create frequency table
df %>%
  count(am)

## Mutate am, 0=Auto, 1=Manual
df %>%
  mutate(am = ifelse(am==0, "Auto", "Manual"))%>%
  count(am)%>%
  mutate(pct = n/sum(n))

## bind_rows()is UNION in SQL

df1 <- mtcars %>% 
  filter(hp>300)
df2 <- mtcars %>%
  filter(hp <= 80)

bind_rows(df1,df2)
full_df <- df1 %>%
  bind_rows(df2)

df3 <- mtcars %>%
  filter(am == "Auto")

df4 <- mtcars %>%
  filter(mpg >= 20)

full_df <- df1 %>%
  bind_rows(df2) %>%
  bind_rows(df3) %>%
  bind_rows(df4)

## Stack a lot of dataframe
list_df <- list(df1, df2, df3, df4)
full_df <- bind_rows(list_df)
View(full_df)

## bind_cols() vs. join()
df5 <- data.frame(id = 1:4, 
                  name = c("A","B","C","D"))

df6 <- data.frame(id = c(1:3,5),
                  country = c("US","UK","TH","JP"))

df7 <- data.frame(student_id = c(1:3,5),
                  country = c("US","UK","TH","JP"))
bind_cols(df5, df6)

## Join Type
inner_join(df5, df6, by="id")
left_join(df5, df6, by="id")
right_join(df5, df6, by="id")
full_join(df5, df6, by="id")

df5 %>%
  full_join(df6, by="id") %>%
  drop_na()

## Inner join different col names
df5 %>%
  inner_join(df7, by=c("id" = "student_id"))

## Join multiple tables
df8 <- data.frame(id = 1:4,
                  classes = c("data", "data", "ux", "business"))

df8 %>%
  inner_join(df5, by="id") %>%
  inner_join(df6, by="id")

## Clean missing values
df9 <- data.frame(id = 1:5,
                  classes = c("data", NA, 
                              "ux", "business",
                              NA),
                  score = c(2.5, 2.8, 2.9, 3, NA))

replace_na(df9$classes, "data engineer")

df9 %>% 
  mutate(classes = replace_na(classes, "woohoo!"),
         # mean imputation
         score = replace_na(score, mean(score, na.rm=T)))