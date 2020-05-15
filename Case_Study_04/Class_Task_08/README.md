library(tidyverse)
```
### Notes on Chapter 7

EDA- Exploratory Data Analysis

1. Generate Questions about your data.
2. Search for answers by visualizing, transforming and modeling data
3. Use what you learn to refine questions and/or generate new ones.

*There are no reouting statistical questions- only questional statistical routines.- Sir David Cox*

1.  What variations occur within my variables
2. What covariation occurs between my variabls.

Variation: tendency of variables to change from measurement to measuremnt
- best way to understand the pattern is to visualize teh distributions

Covariation- tendency for values of 2+ variables to vary in a related way.  
- best way to see is to visualise the relationship between two variables

```

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut))

diamonds %>% 
count(cut)

ggplot(data = diamonds) +
  geom_histogram(mapping = aes(x = carat), binwidth = 0.5)
  
smaller <- diamonds %>% 
  filter(carat < 3)

ggplot(data = smaller, mapping = aes(x = carat, colour = cut)) +
  geom_freqpoly(binwidth = 0.1)
  
ggplot(diamonds) + 
  geom_histogram(mapping = aes(x = y)) +
  coord_cartesian(ylim = c(0, 5))
  
unusual <- diamonds %>% 
  filter(y < 3 | y > 20) %>% 
  select(price, x, y, z) %>%
  arrange(y)
unusual

ggplot(data = unusual) +
geom_bar(mapping = aes(x = price, binwidth = 0.25))

diamonds %>% 
count(carat == 1.00)

diamonds2 <- diamonds %>% 
  mutate(y = ifelse(y < 3 | y > 20, NA, y))

ggplot(data = diamonds2, mapping = aes(x = x, y = y)) + 
geom_point(na.rm = TRUE)

nycflights13::flights %>% 
  mutate(
    cancelled = is.na(dep_time),
    sched_hour = sched_dep_time %/% 100,
    sched_min = sched_dep_time %% 100,
    sched_dep_time = sched_hour + sched_min / 60
  ) %>% 
  ggplot(mapping = aes(sched_dep_time)) + 
    geom_freqpoly(mapping = aes(colour = cancelled), binwidth = 1/4)

diamonds %>%
count(color, cut) %>%
ggplot(mapping = aes(x = color, y = cut)) +
geom_tile(mapping = aes(fill = n), binwidth = 0.5)

ggplot(data = smaller, mapping = aes(x = carat, y = price)) + 
  geom_boxplot(mapping = aes(group = cut_width(carat, 0.1)))
------

library(tiyverse)
faithful %>%
mutate(waiting_g = case_when(waiting < 70 ~ "short", waiting >= 70 ~ "long")) %>% 
ggplot( mapping = aes(x = eruptions, fill = waiting_g)) + 
geom_histogram(color = "white") +
labs(x= "duration of eruptions in minutes", y = "number of observations", fill = "weight time in minutes")+
theme_bw()


https://www.sessions.edu/color-calculator/)This is the RGB color value picker I use to get the exact color I want)


hist(faithful$waiting)
mean(faithful$waiting)

### Notes on Devtools R Package



