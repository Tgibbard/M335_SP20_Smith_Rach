---
title: "Case Study 2: Wealth and Life Expectancy (Gapminder)"
author: "Rachael Smith"
date: "5/2/2020"
output: html_document
---

```{r, message=FALSE}
library(gapminder)
library(tidyverse)
library(ggplot2)
library(dplyr)

data_no_kuwait <- gapminder %>% 
  filter(country != "Kuwait") %>% 
  group_by(year)

wa1 <- gapminder %>% 
  filter(country != "Kuwait")

wa2 <- wa1 %>% 
  group_by(continent, year) %>% 
  summarise(gdpPercap = weighted.mean(gdpPercap, pop), pop = sum(pop/100000))

```

### Background

Hans Rosling is one of the most popular data scientists on the web. His original TED talk set a new bar for data visualization. We are going to create some graphics using his formatted data as our weekly case study. 

Making these plots I learned a lot about ggplot and it's functions.  I also learned about how separating large amounts of data into smaller, easier to understand groupings can really help make the data easier to understand.   The hardest part was adding in two datasets on top of each other, and also making sure that I had all the data I needed saved prior to making the plot. 

### Images

```{r, message =FALSE}

ggplot(data = data_no_kuwait) +
      geom_point(mapping = aes(x = lifeExp, y = gdpPercap, size = pop/100000, color = continent)) +
      theme_bw() +
      labs( x = "Life Expectancy", y = "GDP per capita") +
      scale_y_continuous(trans = "sqrt", breaks = c(10000, 20000, 30000, 40000, 50000)) +
      facet_wrap(~year, nrow = 1) +
      guides(size = guide_legend("Population (100k)", order = 1),
            color = guide_legend("Continent", order = 2)) 

ggsave(
  filename = "Life Expectancy & GDP.png",
  plot = last_plot(),
  width = 15,
  dpi = 300)
```

```{r, message =FALSE}
wa1 %>%
  ggplot() +
  aes(year, gdpPercap, colour = continent) +
  geom_point(aes(size = pop/100000)) +
  geom_line(aes(group = country)) +
  geom_point(aes(size = pop), data = wa2, color = "black") +
  geom_line(data = wa2, color = "black") +
  facet_wrap(~continent, nrow = 1) +
  guides(size = guide_legend("Population (100k)", order = 1),
            color = guide_legend("Continent", order = 2))
ggsave(
  filename = "GDP & Population Growth by Continent.png",
  plot = last_plot(),
  width = 15,
  dpi = 300)
```
