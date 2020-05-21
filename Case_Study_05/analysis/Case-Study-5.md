---
title: "Case Study 5"
author: "Rachael Smith"
date: "May 21, 2020"
output:
  html_document:  
    keep_md: true
    toc: true
    toc_float: true
    code_folding: hide
    fig_height: 6
    fig_width: 12
    fig_align: 'center'
---



## (Heights) I Can Clean Your Data




```r
# Use this R-Chunk to import all your datasets!
```

## Background

_Place Task Background Here_

## Data Wrangling


```r
# Use this R-Chunk to clean & wrangle your data!

world_tmpx <- tempfile()

download("https://byuistats.github.io/M335/data/heights/Height.xlsx", world_tmpx, mode = "wb")

world_xlsx <- read_xlsx(world_tmpx)

View(world_xlsx)
```

## Data Visualization


```r
# Use this R-Chunk to plot & visualize your data!
```

## Conclusions
