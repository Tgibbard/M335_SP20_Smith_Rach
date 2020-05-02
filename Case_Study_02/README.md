---
title: "Case Study 2: Wealth and Life Expectancy (Gapminder)"
author: "Rachael Smith"
date: "5/2/2020"
output: html_document
---

```{r}
library(gapminder)
library(tidyverse)
library(ggplot2)
library(dplyr)

data_no_kuwait <- gapminder %>% 
  filter(country != "Kuwait") %>% 
  group_by(year)
data_no_kuwait

weighted_average <- gapminder %>% 
  filter(country != "Kuwait") %>% 
  group_by(continent)

weighted_average

```

### Background

Hans Rosling is one of the most popular data scientists on the web. His original TED talk set a new bar for data visualization. We are going to create some graphics using his formatted data as our weekly case study. 

Making these plots I learned...

### Images
```{r}

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
  path = 
  dpi = 300)
```


```{r}
ggplot(data = weighted_average) + 
  stat_summary(mapping=aes(x = year, y = gdpPercap, group = continent, color = continent)) +
      geom_line() +
      theme_bw() +
      labs( x = "Year", y = "GDP per capita") +
      scale_y_continuous(breaks = c(10000, 20000, 30000, 40000, 50000)) +
      facet_wrap(~continent, nrow = 1) +
      guides(size = guide_legend("Population (100k)", order = 1),
            color = guide_legend("Continent", order = 2))
```

```{r}
ggplot(data = weighted_average) +
  geom_line(aes(x = year, y = gdpPercap))
```

