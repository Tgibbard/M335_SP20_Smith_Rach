# Task 3
##### Rachael Smith

\br

### Chapter 5 Notes

Tidyverse Conflicts 
x dplyr::filter() masks stats::filter()
x dplyr::lag()    masks stats::lag()

int = integer
dbl = doubles, real numbers
chr = character, vector, str
dttm = date + time
lgl = logicalcontain only  TRUE FALSE
fctr factors- fixed possible values
date = dates

-----

#### DATA MANIPULATION (dplyr)

filters() keep rows matching criteria
arrange() reorder rows
select() pick columns by name
mutate() add new variables
summarise() reduce variables to values
group_by() operates group by group not entire dataset

Verbs 
* first argument is data fram
*subsequent arguments describe what to do with the data- variable names NO QUOTES
* result is a new data frame

SQL Joins:
add new columns:
  *left join: all x + matching y
  *inner join: matching x + y
don't add new colums:
  *semi-join: all x with match in y
  *anit-join: all x W/O match in y

-----

##### filter()
-only includes TRUE, does NOT include FALSE or NA

expression to filter data:
    filter(flights, month == 1, day == 1)

saves filter as new result
    jan1 <- filter(flights, month == 1, day == 1)

use () to print out and save results to variable
  (dec25 <- filter(flights, month ==12, day == 25))

###### Comparisons
== equality
near()
    sqrt(2) ^ 2 == 2
    #> [1] FALSE

    near(sqrt(2) ^ 2,  2)
    #> [1] TRUE
& and
| or
! is not
value %in% c(value, value)

###### Excercies
Had an arrival delay of two or more hours:
#filter(flights, arr_delay >= 2)

Flew to Houston (IAH or HOU):
#filter(flights, dest == "HOU" | dest == "IAH")

Were operated by United, American, or Delta
#filter(flights, carrier == "UA" | carrier == "AA" | carrier =="DL")

Departed in summer (July, August, and September)
#filter(flights, between(month, 7, 9))

Arrived more than two hours late, but didn’t leave late
#filter(flights, arr_delay > 120 &  dep_delay <= 0)

Were delayed by at least an hour, but made up over 30 minutes in flight
#filter(flights, dep_delay >= '60' & arr_delay <= '-30')

Departed between midnight and 6am (inclusive)
#filter(flights, between(dep_time, 1, 600))

How many flights have a missing dep_time? What other variables are missing? What might these rows represent?  
# 8245 cancelled flights
# filter(flights, is.na(dep_time))

Why is NA ^ 0 not missing? Why is NA | TRUE not missing? Why is FALSE & NA not missing? Can you figure out the general rule? (NA * 0 is a tricky counterexample!)

-----

##### arrange()
similar to filter, changes order of rows
desc() descending order

How could you use arrange() to sort all missing values to the start? (Hint: use is.na()).

Sort flights to find the most delayed flights. Find the flights that left earliest.
#arrange(flights, desc(dep_delay))

Sort flights to find the fastest (highest speed) flights.
#arrange(flights, distance/air_time)

Which flights travelled the farthest? Which travelled the shortest?
#arrange(flights, distance)
#arrange(flights, desc(distance))

-----

#####select() pick variabls by names
allows you to rapidly zoom in on useful subset using variable names

by name: variable, variable, variable

between inclusive: use colon
except - 
*starts_with("")
*ends_with("")
*contains("")
*matches("(.)\\1")  repeated characters
*num_range("x", 1:3) matches x1, x2, x3
*rename(flights, tail_num = tailnum)

#select(col1, col4, everythin())

#select(flights, contains("TIME"))

-----

##### mutate() create new variables with functions of existing variables
mutate adds new colums that are functions of existing.

flights_sml <- select(flights, 
  year:day, 
  ends_with("delay"), 
  distance, 
  air_time
)
mutate(flights_sml,
  gain = dep_delay - arr_delay,
  speed = distance / air_time * 60)
  
transmute- only keep new variables.

transmute(flights,
  gain = dep_delay - arr_delay,
  hours = air_time / 60,
  gain_per_hour = gain / hours

lead()= leading values
lag() lagging values

log2() - easy to interpret
cumsum() cumulitive sum
cumprod()
cummin()
cummax()
cummean()
min_rank()
row_number()
dense_rank()
percent_rank()
cume_dist()
ntile()

Currently dep_time and sched_dep_time are convenient to look at, but hard to compute with because they’re not really continuous numbers. Convert them to a more convenient representation of number of minutes since midnight.
#transmute(flights,
#+   dep_time,
#+   hour = dep_time %/% 100,
#+   minute = dep_time %% 100)

Compare air_time with arr_time - dep_time. What do you expect to see? What do you see? What do you need to do to fix it?

#transmute(flights,
#  gain = arr_time - dep_time,
#  air_time,
#  air_hours = air_time / 60,
#  gain_hours = gain / 60,
#  gain_per_hour = gain / hours)

Compare dep_time, sched_dep_time, and dep_delay. How would you expect those three numbers to be related?

#transmute(flights,
#  loss = (dep_time - sched_dep_time),
#  dep_delay)

Find the 10 most delayed flights using a ranking function. How do you want to handle ties? Carefully read the documentation for min_rank().

#head(min_rank(desc(flights$dep_delay)),10)

-----

##### summarise() & group_by
*na.rm = TRUE
*paired w/ group_by
*Pipe Operator
%>%  "then"
- make sure output is the same as the first input.

delays <- flights %>% 
  group_by(dest) %>% 
  summarise(
    count = n(),
    dist = mean(distance, na.rm = TRUE),
    delay = mean(arr_delay, na.rm = TRUE)
  ) %>% 
  filter(count > 20, dest != "HNL")

Brainstorm at least 5 different ways to assess the typical delay characteristics of a group of flights. Consider the following scenarios:

A flight is 15 minutes early 50% of the time, and 15 minutes late 50% of the time.

A flight is always 10 minutes late.

A flight is 30 minutes early 50% of the time, and 30 minutes late 50% of the time.

99% of the time a flight is on time. 1% of the time it’s 2 hours late.

Which is more important: arrival delay or departure delay?

Come up with another approach that will give you the same output as not_cancelled %>% count(dest) and not_cancelled %>% count(tailnum, wt = distance) (without using count()).

Our definition of cancelled flights (is.na(dep_delay) | is.na(arr_delay) ) is slightly suboptimal. Why? Which is the most important column?

Look at the number of cancelled flights per day. Is there a pattern? Is the proportion of cancelled flights related to the average delay?

Which carrier has the worst delays? Challenge: can you disentangle the effects of bad airports vs. bad carriers? Why/why not? (Hint: think about flights %>% group_by(carrier, dest) %>% summarise(n()))

-----

##### filter()

*A grouped filter is a grouped mutate followed by an ungrouped filter. I generally avoid them except for quick and dirty manipulations: otherwise it’s hard to check that you’ve done the manipulation correctly.*


Refer back to the lists of useful mutate and filtering functions. Describe how each operation changes when you combine it with grouping.
```{r}
worst_tailnum <- flights %>% 
  group_by(tailnum) %>% 
  mutate(worst = mean(arr_delay)) %>% 
  summarise(sum(worst, na.rm =TRUE))

worst_tailnum

```

Which plane (tailnum) has the worst on-time record?

What time of day should you fly if you want to avoid delays as much as possible?

For each destination, compute the total minutes of delay. For each flight, compute the proportion of the total delay for its destination.

Delays are typically temporally correlated: even once the problem that caused the initial delay has been resolved, later flights are delayed to allow earlier flights to leave. Using lag(), explore how the delay of a flight is related to the delay of the immediately preceding flight.

Look at each destination. Can you find flights that are suspiciously fast? (i.e. flights that represent a potential data entry error). Compute the air time of a flight relative to the shortest flight to that destination. Which flights were most delayed in the air?

Find all destinations that are flown by at least two carriers. Use that information to rank the carriers.

For each plane, count the number of flights before the first delay of greater than 1 hour.

-----


###### Still have questions:

Brainstorm as many ways as possible to select dep_time, dep_delay, arr_time, and arr_delay from flights.

What happens if you include the name of a variable multiple times in a select() call?

What does the one_of() function do? Why might it be helpful in conjunction with this vector?

vars <- c("year", "month", "day", "dep_delay", "arr_delay")

Does the result of running the following code surprise you? How do the select helpers deal with case by default? How can you change that default?
What does 1:3 + 1:10 return? Why?

What trigonometric functions does R provide?

------

### Data Science Question

*Develop a few novel questions that data can answer*

\br

##### How do we measure Student Growth in areas of confidence, personal responsbility and love of learning?

\br

##### How do we measure the success of a business' mission statement?

\br

[ ] Get feedback from 6-8 people on their interest in your questions and summarize this feedback
[ ] Find other examples of people addressing your question
[ ] Present your question to a data scientist/data analyst to get feedback on the quality of the question and if it can be addressed in 2-months.
[ ] Create one .rmd file that has your report
[ ] Have a section for each question
[ ] Be prepared to discuss your results in the upcoming class

------

### R-Studio Practise
You will  improve the Research and Creative Works conference visulization found in this Excel file (Links to an external site.). Even if you have used R before, this will be an excellent refresher.

[ ] A 3-D column chart is a poor way to visualize data. Read in the data used to create the 3D barchart visuallization using R (see code below). Then use R to a different chart (or charts) that show the same data in a better format (remember the principles from the John Rauser video).  What is the growth over time trend by department of RC&W attendance?
[ ] Practice using the help files for geom_line and geom_col and the examples at the end of the help files (see readings)
[ ] Save your code in your R script and be prepared to share your code and image in class)



```{r}
library(tidyverse)
dat <- read_csv("https://byuistats.github.io/M335/data/rcw.csv", 
                col_types = cols(Semester_Date = col_date(format = "%m/%d/%y"), Semester = col_factor(levels = c("Winter", "Spring", "Fall"))))

```
```{r}
semester <- dat %>%
  group_by(Department)
ggplot(semester, aes(Semester_Date, Count, colour = Department)) +
         geom_line()
```