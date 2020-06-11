---
title: "Task 13: Strings and Regular Expression"
author: "Rachael Smith"
date: "June 10, 2020"
output:
  html_document:  
    keep_md: true
    code_folding: hide
    fig_height: 6
    fig_width: 12
    fig_align: 'center'
---



-----




#### Every 1700th letter


```r
random_lines <- read_lines("https://byuistats.github.io/M335/data/randomletters.txt")
split_lines <- random_lines  %>% 
  str_split("") %>% 
  unlist() %>% 
  .[c(1, seq(0,str_length(random_lines), by = 1700))] %>% 
  str_c(collapse = "")

pander(split_lines)
```

the plural of anecdote is not data.z anfra

###### "the plural of anecdote is not data."

-----

#### Hidden Message


```r
# Use this R-Chunk to import all your datasets!

random_numbers <- read_lines("https://byuistats.github.io/M335/data/randomletters_wnumbers.txt")

numbers_dat <- random_numbers %>%
  str_extract_all("[:digit:]+") %>% 
  map(as.numeric) %>%
  unlist() 
  
pander(letters[numbers_dat] %>% str_c(collapse = ""))
```

expertsoftenpossessmoredatathanjudgment

###### "experts often possess more data than judgement"

-----

#### Longest Sequence of Vowels


```r
no_spaces <- read_lines("https://byuistats.github.io/M335/data/randomletters.txt") %>% 
  str_remove_all("[:blank:]|\\.") %>%  
  str_extract_all("[aeiou]{5,}") 

pander(no_spaces)
```



  * _eaeui_, _oaaoooo_, _iieuai_, _eeiei_, _auaea_, _iuiuie_, _auouia_, _ouuea_, _iaaia_ and _uaeii_

<!-- end of list -->

