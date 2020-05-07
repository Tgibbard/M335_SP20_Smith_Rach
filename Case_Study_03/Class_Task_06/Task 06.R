# Task 06 
### Visualizing Distributions of Large Data Sets

#[ ] Find an insightfull relationship between two of the variables (columns) and display that relationship in a table or graphic
# > glimpse(nycflights13::flights)
# Rows: 336,776
# Columns: 19
# $ year           <int> 2013, 2013, 2013, 2013, 20…
# $ month          <int> 1, 1, 1, 1, 1, 1, 1, 1, 1,…
# $ day            <int> 1, 1, 1, 1, 1, 1, 1, 1, 1,…
# $ dep_time       <int> 517, 533, 542, 544, 554, 5…
# $ sched_dep_time <int> 515, 529, 540, 545, 600, 5…
# $ dep_delay      <dbl> 2, 4, 2, -1, -6, -4, -5, -…
# $ arr_time       <int> 830, 850, 923, 1004, 812, …
# $ sched_arr_time <int> 819, 830, 850, 1022, 837, …
# $ arr_delay      <dbl> 11, 20, 33, -18, -25, 12, …
# $ carrier        <chr> "UA", "UA", "AA", "B6", "D…
# $ flight         <int> 1545, 1714, 1141, 725, 461…
# $ tailnum        <chr> "N14228", "N24211", "N619A…
# $ origin         <chr> "EWR", "LGA", "JFK", "JFK"…
# $ dest           <chr> "IAH", "IAH", "MIA", "BQN"…
# $ air_time       <dbl> 227, 227, 160, 183, 116, 1…
# $ distance       <dbl> 1400, 1416, 1089, 1576, 76…
# $ hour           <dbl> 5, 5, 5, 5, 6, 5, 6, 6, 6,…
# $ minute         <dbl> 15, 29, 40, 45, 0, 58, 0, …
# $ time_hour      <dttm> 2

#[ ] Provide a distributional summary of the relevant variable in nycflights13::flights
library(tidyverse)
library(nycflights13::flights)

flight_data3 <- (nycflights13::flights) %>%
  filter(dep_delay != "NA" & arr_delay != "NA", tailnum != "N635AA") %>% 
  group_by(tailnum, origin) %>% 
  summarise(delay_mean = mean(dep_delay), arr_mean = mean(arr_delay)) %>% 
  select(delay_mean, arr_mean, origin, tailnum)

ggplot(data = flight_data3, aes(x = arr_mean, y = delay_mean)) +
  geom_point(size = 1, alpha = 0.25, aes(color = origin))+
  facet_grid(~origin)

library(car)
View(flight_data3)
differences = flight_data3$arr_mean ~ flight_data3$delay_mean

t.test(differences, mu = 0, alternative = "two.sided", conf.level = 0.95)
qqPlot(differences)
#[ ] Build bivariate summaries of the relevant variables

#[ ] Keep a record of all the code your wrote as you explored the dataset looking for an insightfull relationship
library(tidyverse)
library(car)
library(nycflights13::flights)
flight_data3 <- (nycflights13::flights) %>%
  filter(dep_delay != "NA" & arr_delay != "NA", tailnum != "N635AA") %>% 
  group_by(tailnum, origin) %>% 
  summarise(delay_mean = mean(dep_delay), arr_mean = mean(arr_delay)) %>% 
  select(tailnum, delay_mean, arr_mean, origin, carrier)

View(flight_data3)
differences = flight_data3$arr_mean ~ flight_data3$delay_mean

t.test(differences, mu = 0, alternative = "two.sided", conf.level = 0.95)
qqPlot(differences)

ggplot(data = flight_data3, aes(x = arr_mean, y = delay_mean)) +
  geom_point(aes(color = origin))+
  facet_grid(~origin)

------

flight_dataa <- (nycflights13::flights) %>%
  group_by(tailnum) %>% 
  summarise(delay_mean = mean(dep_delay), arr_mean = mean(arr_delay))

glimpse(flight_data1)

flight_data2 <- (nycflights13::flights) %>%
  group_by(tailnum) %>% 
  summarise(delay_mean = mean(dep_delay), arr_mean = mean(arr_delay)) %>% 
  select(tailnum, delay_mean, sum(arr_mean<=400)

glimpse(flight_data2)


flight_data3 <- (nycflights13::flights) %>%
  filter(dep_delay != "NA" & arr_delay != "NA") %>% 
  group_by(tailnum) %>% 
  summarise(delay_mean = mean(dep_delay), arr_mean = mean(arr_delay)) %>% 
  select(tailnum, delay_mean, arr_mean)

glimpse(flight_data3)

#[ ] Create an .R script that has your data visualization development with 1-2 commented paragraphs summarizing your 2 finalized graphics and the choices you made in the data presentation
#[ ] Save your .png images using of each your final graphics and push all your work to your repository.

