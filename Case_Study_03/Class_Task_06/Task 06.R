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

'''
In this first plot, I wanted to see how delays and arrivals are aligned.  
The data appears to increase at a 45 degree angle. This is a pretty boring chart,
so I did not spend alot of time making it look pretty.  It really just led me to 
more questions.  Do flights that leave early always arrive early?  Do flights that
leave late always arrive late?  Is there an airport with a better on time record?
'''
flight_c <- nycflights13::flights

ggplot(data = flight_c, aes(x = dep_delay, y = arr_delay)) +
  geom_point()

ggsave(filename = "Flights Histogram.png",
       plot = last_plot(),
       width = 10)

#[ ] Build bivariate summaries of the relevant variables
'''
In this plot, I spent a lot of time trying to decide how best to show the data.
I wanted to know if flights that departed early always arrived early.  
 I wanted to know if flights that left late always arrived late and if flights 
 that left on time always arrived on time.  
 *The green shows us that flights that left late and arrived on time from EWR. 
 *The blue shows flights that left late and arrived on time from JFK.
 *The purple shows flights that left late and arrived on time from LGA.
 *The pink dots show flights that left early and arrived late. 
'''
flight_data_a <- (nycflights13::flights) %>%
  group_by(origin, tailnum) %>%
  filter(dep_delay != "NA" & arr_delay != "NA", tailnum != "N635AA") %>% 
  filter(dep_delay >= 0 & arr_delay <= 0) %>%
  summarise(delay_median_a = median(dep_delay), arr_median_a = median(arr_delay)) %>% 
  select(delay_median_a, arr_median_a, origin, tailnum)
flight_data_a

flight_data_b <- (nycflights13::flights) %>%
  group_by(origin, tailnum) %>%
  filter(dep_delay != "NA" & arr_delay != "NA", tailnum != "N635AA") %>% 
  filter(dep_delay <= 0 & arr_delay >= 0) %>%
  summarise(delay_median_b = median(dep_delay), arr_median_b = median(arr_delay)) %>% 
  select(delay_median_b, arr_median_b, origin, tailnum)
flight_data_b

ggplot(data = flight_data_a, aes(x = (arr_median_a), y = delay_median_a)) +
  geom_point(size = 1, alpha = 1, aes(color = origin)) +
  geom_point(data = flight_data_b, size = 1, alpha = 1, aes(x = arr_median_b, y = delay_median_b, color = "black")) +
  facet_grid(~ origin) +
  labs(title = "Comparison of Delay Median and Arrival Median at 3 Major Airports",  
       x = "Arrival Median by Airport", caption = "Pink represents the flights that left early and arrived late.\n The other three colors represent flights that left late and arrive on time. \nNegative values indicate early arrival and early departure.",
       y = "Delay Median")

ggsave(filename = "Delay_Arrival_Median.png",
       plot = last_plot(),
       width = 10
)






#[ ] Keep a record of all the code your wrote as you explored the dataset looking for an insightfull relationship

ggplot(data = flight_data3, aes(x = arr_median, y = delay_median)) +
  geom_point(size = 1, alpha = 0.25, aes(color = c("black")))+
  facet_grid(~origin) +
  labs(title = "Comparison of Delay Median and Arrival Median of Airplanes at 3 Major Airports", x = "Arrival Median by Airport", y = "Delay Median")

library(tidyverse)
library(car)
library(nycflights13::flights)
flight_data3 <- (nycflights13::flights) %>%
  filter(dep_delay != "NA" & arr_delay != "NA", tailnum != "N635AA") %>% 
  group_by(tailnum, origin) %>% 
  summarise(delay_median = median(dep_delay), arr_mean = mean(arr_delay)) %>% 
  select(tailnum, delay_mean, arr_median, origin, carrier)

View(flight_data3)
differences = flight_data3$arr_mean ~ flight_data3$delay_mean

t.test(differences, mu = 0, alternative = "two.sided", conf.level = 0.95)
qqPlot(differences)

ggplot(data = flight_data3, aes(x = arr_mean, y = delay_mean)) +
  geom_point(aes(color = origin))+
  facet_grid(~origin) +
  labes(title = "Comparison of the Man of Delayed ")

#------

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
