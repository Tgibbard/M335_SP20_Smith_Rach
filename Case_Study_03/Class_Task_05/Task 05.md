---
title: "Task 05"
author: "Rachael Smith"
date: "5/5/2020"
output: html_document
---


```{r setup, include=FALSE}
library(tidyverse)

# installing dataset for Our World in Data
devtools::install_github("drsimonj/ourworldindata")

#preparing dataset for child mortality
world_dat <- ourworldindata::child_mortality %>% 
  filter(year >= 2000 & continent != "NA" & country != "Haiti") %>%
  group_by(continent, year) %>%
  select(year, child_mort, population, country)
world_dat

#adding dataset for coronavirus
covid_dat <- read_csv("~/Desktop/Rachael School/MATH335/M335_SP20_Smith_Rach/coronavirus-cfr.csv", 
    col_types = cols(Date = col_date(format = "%b %d, %Y")))

#fixing column name
covid_new <- covid_dat %>%
  rename(fatality = 'Case fatality rate of COVID-19 (%) (Only observations with ≥100 cases) (%)')

world_map <- covid_new %>%
  group_by(Date) %>% 
  summarise(f_mean = mean(fatality))
world_map

covid_map <- covid_new %>%
  filter(Entity == "Italy" | Entity == "Germany" | Entity == "South Korea" | Entity == "Iceland") %>%
  select(Entity, fatality, Date)

covid_map

```

Wolrdwide childhood mortality rates have been declining substantially in all countries over the past 100 years. The charts below show the mortality rate of children who died between the age of 0-5 years old from 2000 to 2015.  The first chart showcases the sheer number of data points that have been tracked, it is hard to read and overwelming, but one thing to point out is that the red color representing the African countries shows higher mortality rates than all the other countries. 

```{r message=FALSE, warning=FALSE}
dat1 <- world_dat %>% 
  ggplot(mapping = aes(x=year, y = child_mort))+
  geom_point(aes(color = continent))+
  geom_line(aes(group = country, color = continent)) +
  labs(title = "Child Mortality Rate by Country", subtitle = "Mortality Rate of 0-5 year olds, per 1000 born from 2000 to 2015", caption = "Data is a merged version of all datasets available for download at https://ourworldindata.org/child-mortality", x = "Year", y = "Number of 0-5 year-olds dying per 1,000 born") +
  guides(color = guide_legend("Continent"))
dat1
```

This second chart separates the declining mortality rate by country.  The Americas and Europe have the lowest mortality rates for children ages 0-5.  However, it is important to note the significant declines in Africa, Asia and Oceania since 2000.

```{r message=FALSE, warning=FALSE}
dat2 <- world_dat %>% 
  ggplot(mapping = aes(x=year, y = child_mort))+
  geom_point(aes(color = continent))+
  geom_line(aes(group = country, color = continent)) +
  labs(title = "Child Mortality Rate by Country", subtitle = "Mortality Rate of 0-5 year olds, per 1000 born from 2000 to 2015", caption = "Data is a merged version of all datasets available for download at https://ourworldindata.org/child-mortality", x = "Year", y = "Number of 0-5 year-olds dying per 1,000 born") +
  guides(color = guide_legend("Continent"))+ 
  facet_wrap(~continent, nrow = 1)
dat2

```

This final plot is a recreation of a chart on Our World in Data showing the fatality rate of the COVID-19 pandemic as of May 5, 2020.  This chart shows the ratio bewteen confirmed deaths and confirmed cases.  The orange line, represnts the current worldwide mean fatality rate.   It is also important to note that information about COVID-19 and the infection rate changes rapidly, this is the most up to date information to date. 

```{r message=FALSE, warning=FALSE}
dat3 <- covid_map %>% 
  ggplot() +
  geom_point(mapping = aes(x= Date, y = fatality, color = Entity)) +
  geom_line(mapping = aes(x = Date, y = fatality, group = Entity, color = Entity)) +
  geom_point(data = world_map, aes(x = Date, y = f_mean, color = "World")) +
  geom_line(data = world_map, aes(x = Date, y = f_mean, color = "World")) +
  scale_x_date(date_labels = "%b %d") +
  scale_y_continuous(breaks = c(0, 2, 4, 6, 8, 10, 12), labels = c("0%", "2%", "4%", "6%", "8%", "10%", "12%")) +
  scale_color_manual(values = c("forestgreen", "mediumblue", "blueviolet", "red", "orange")) +
  labs(title = "Case fatality rate of the ongoing COVID-19 pandemic", subtitle = "The Case Fatality Rate (CFR) is the ratio between confirmed deaths and confirmed cases.
During an outbreak of a pandemic the CFR is a poor measure of the mortality risk of the disease. We explain this
in detail at OurWorldInData.org/Coronavirus", caption = "Source: European CDC – Situation Update Worldwide – Last updated 5th May, 11:30 (London time)
Note: Only countries with more than 100 confirmed cases are included.
OurWorldInData.org/coronavirus • CC BY") +
  guides(color = guide_legend("Country")) + 
  theme_minimal() +
  theme(panel.grid.major.x = element_blank(), panel.grid.minor.x = element_blank())

dat3
```
https://ourworldindata.org/grapher/coronavirus-cfr?year=2020-05-05

