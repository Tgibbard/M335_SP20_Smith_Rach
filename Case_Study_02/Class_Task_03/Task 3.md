---
title: "Task 3: Asking the right questions and dplyr, R&CW redo"
author: "Rachael Smith"
date: "5/2/2020"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
library(tidyverse)

dat <- read_csv("https://byuistats.github.io/M335/data/rcw.csv", 
                col_types = cols(Semester_Date = col_date(format = "%m/%d/%y"), Semester = col_factor(levels = c("Winter", "Spring", "Fall"))))
```
\br

## Part 1:

### Notes from Reading

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

-----

##### filter()

*A grouped filter is a grouped mutate followed by an ungrouped filter. I generally avoid them except for quick and dirty manipulations: otherwise it’s hard to check that you’ve done the manipulation correctly.*

------

### Data Science Questions
*Develop a few novel questions that data can answer*

[ ] Get feedback from 6-8 people on their interest in your questions and summarize this feedback

[ ] Find other examples of people addressing your question

[ ] Present your question to a data scientist/data analyst to get feedback on the quality of the question and if it can be addressed in 2-months.

[ ] Create one .rmd file that has your report

[ ] Have a section for each question

[ ] Be prepared to discuss your results in the upcoming class

-----

\br

#### Questions

-----

##### Do we see more growth in students who attend the same school for a longer period of time?

I could not find any studies on this topic.  I asked what do we know about students who attend the same school for consecutive years.  This data might be helpful for the school that I am considering working with as we measure overall school growth and then growth of students who attend the school longer to see if there is a correlation.

-----

##### Do we see a decline in student learning due to spring break or extended breaks?

I found a few articles that talked about student learning loss, specically summer learning loss.

https://www.malone.edu/files/resources/barberfinalthesis.pdf

https://www.brookings.edu/research/summer-learning-loss-what-is-it-and-what-can-we-do-about-it/

-----

##### How do we measure non-academic? growth in students

https://www.panoramaed.com/social-emotional-learning-sel

I found a tool that measures growth in self-management, social awareness, growth mindset, and self-efficacy.

-----


## Part 2: Research and Creative Works Vizualization

```{r}
RCW <- dat %>% 
  group_by(Semester_Date, Department) %>% 
  select(Count, Department, Year, Semester_Date)

ggplot(dat = RCW) +
  aes(x = Semester_Date, y = Count, colour = Department) +
  geom_point() +
  geom_line(aes(group = Department))+
  facet_wrap(~Department)

ggsave(
  filename = "Department Growth by Semester.png",
  plot = last_plot(),
  width = 10,
  dpi = 300)
```
