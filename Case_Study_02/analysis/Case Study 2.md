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
  filter(country != "Kuwait")

wa1 <- gapminder %>% 
  filter(country != "Kuwait")

wa2 <- wa1 %>%
  group_by(continent, year) %>%
  summarise(gdpPercap = weighted.mean(gdpPercap, pop), 
            pop = sum(pop/100000))

```

Hans Rosling is one of the most popular data scientists on the web. His original TED talk set a new bar for data visualization. We are going to create some graphics using his formatted data as our weekly case study. 

Making these plots I learned a lot about ggplot and it's functions.  I also learned about how separating large amounts of data into smaller, easier to understand groupings can really help make the data easier to understand.  

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
  dpi = 300)
```


```{r}
ggplot(data = wa1) +
      aes(x = year, y = gdpPercap, color = continent)
      geom_point(aes(size = pop)) +
      geom_line(aes(group = country)) +
      geom_point(aes(size = pop), data = wa2, color = "black") +
      geom_line(aes(group = country), data = wa2, color = "black") +
      theme_bw() +
      labs(x = "Year", y = "GDP per capita") +
      scale_y_continuous(breaks = c(10000, 20000, 30000, 40000, 50000)) +
      facet_wrap(~continent, nrow = 1) +
      guides(size = guide_legend("Population (100k)", order = 1), color = guide_legend("Continent", order = 2))

ggsave(
  filename = "Weighted Mean of GDP by Continent and Year.png",
  plot = last_plot(),
  width = 15,
  dpi = 300)

```