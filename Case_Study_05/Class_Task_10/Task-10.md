---
title: "Task 10"
author: "Rachael Smith"
date: "May 22, 2020"
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

-----





#### Read-in the data


```r
# Use this R-Chunk to import all your datasets!

tmpx <- tempfile()

download("https://github.com/byuistats/data/blob/master/Dart_Expert_Dow_6month_anova/Dart_Expert_Dow_6month_anova.xlsx?raw=true", tmpx, mode = "wb")

xlsx_file <- read_xlsx(tmpx)

pander(head(xlsx_file, 5))
```


----------------------------------------
   contest_period      variable   value 
--------------------- ---------- -------
  January-June1990       PROS     12.7  

  February-July1990      PROS     26.4  

  March-August1990       PROS      2.5  

 April-September1990     PROS      -20  

   May-October1990       PROS     -37.8 
----------------------------------------

-----

#### Tidy the Data


```r
# Use this R-Chunk to clean & wrangle your data!

tidy_contest <- xlsx_file %>%
  separate(contest_period, into = c("start", "end"), sep = "-") %>%
  mutate(year_end = substr(end, nchar(end) - 3, nchar(end))) %>% 
  separate(end, into = "month_end", sep = -4) %>% 
  select(month_end, year_end, value, variable)
  
pander(head(tidy_contest,10))
```


-----------------------------------------
 month_end   year_end   value   variable 
----------- ---------- ------- ----------
   June        1990     12.7      PROS   

   July        1990     26.4      PROS   

  August       1990      2.5      PROS   

 September     1990      -20      PROS   

  October      1990     -37.8     PROS   

 November      1990     -33.3     PROS   

 December      1990     -10.2     PROS   

  January      1991     -20.3     PROS   

 February      1991     38.9      PROS   

   March       1991     20.2      PROS   
-----------------------------------------

```r
saveRDS(tidy_contest, file = "tidy_contest.rds")
```

## Data Visualization


```r
# Use this R-Chunk to plot & visualize your data!
```

## Conclusions
