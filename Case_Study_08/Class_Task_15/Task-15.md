---
title: "Task 15: Functions"
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




#### Function 1


```r
function.every1700 <- function(data, split, sequence)
{
random_lines <- read_lines(data)
split_lines <- random_lines  %>% 
  str_split(split) %>% 
  unlist() %>% 
  .[c(1, seq(0,str_length(random_lines), by = sequence))] %>% 
  str_c(collapse = "")

pander(split_lines)
}
```

-----

#### Function 2


```r
# Use this R-Chunk to import all your datasets!

function.findnumbers <- function(data, digit)
{
random_numbers <- read_lines(data) %>% 
  str_extract_all(digit) %>% 
  map(as.numeric) %>%
  unlist()

pander(letters[random_numbers] %>% str_c(collapse = ""))
}
```

-----

#### Function 3


```r
function.nospaces <- function(data, remove, extract)
{
no_spaces <- read_lines(data) %>% 
  str_remove_all(remove) %>%  
  str_extract_all(extract) 

pander(no_spaces)
}
```

-----

### Test the Functions

###### Printout of Function 1

```r
function.every1700("https://byuistats.github.io/M335/data/randomletters.txt", "", 1700)
```

the plural of anecdote is not data.z anfra

-----

###### Printout of Function 2


```r
function.findnumbers("https://byuistats.github.io/M335/data/randomletters_wnumbers.txt", "[:digit:]+")
```

expertsoftenpossessmoredatathanjudgment

-----

###### Printout of Function 3


```r
function.nospaces("https://byuistats.github.io/M335/data/randomletters.txt", "[:blank:]|\\.", "[aeiou]{5,}")
```



  * _eaeui_, _oaaoooo_, _iieuai_, _eeiei_, _auaea_, _iuiuie_, _auouia_, _ouuea_, _iaaia_ and _uaeii_

<!-- end of list -->

