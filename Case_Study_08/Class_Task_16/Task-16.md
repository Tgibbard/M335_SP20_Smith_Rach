---
title: "Task 16"
author: "Rachael Smith"
date: "June 12, 2020"
output:
  html_document:  
    keep_md: true
    code_folding: hide
---









```r
# Use this R-Chunk to import all your datasets!

#download("http://scriptures.nephi.org/downloads/lds-scriptures.csv.zip", dest = "lds_scrips.zip", mode = "wb")

#unzip("lds_scrips.zip", exdir = "Case_Study_08/Class_Task_16")

scriptures <- read_csv("lds_scrips.zip")
```

1. What is the average verse length (number of words) in the New Testament compared to the Book of Mormon?


```r
bom_nt <- scriptures %>% 
  mutate(wc = str_count(scripture_text, "\\W+")) %>% 
  group_by(volume_title) %>%
  filter(volume_title == "Book of Mormon" | volume_title == "New Testament") %>% 
  summarise(mean_wc = mean(wc), tot_wc = sum(wc)) %>% pander()

  #mutate(word_count = stri_stats_latex(scripture_text)[4])

bom_nt
```


-----------------------------------
  volume_title    mean_wc   tot_wc 
---------------- --------- --------
 Book of Mormon    40.51    267520 

 New Testament     22.71    180703 
-----------------------------------


2. How often is the word Jesus in the New Testament compared to the Book of Mormon?



```r
# Use this R-Chunk to clean & wrangle your data!
Jesus_count <- scriptures %>% group_by(volume_title) %>% mutate(Jesus = str_count(scripture_text, "Jesus")) %>% summarise(sum_jesus = sum(Jesus)) %>% pander()

Jesus_count
```


------------------------------------
      volume_title        sum_jesus 
------------------------ -----------
     Book of Mormon          184    

 Doctrine and Covenants      97     

     New Testament           976    

     Old Testament            0     

  Pearl of Great Price       11     
------------------------------------

3. How does the word count distribution by verse look for each book in the Book of Mormon?


```r
verse_count <- scriptures %>% filter(volume_title == "Book of Mormon") %>% mutate(wc = str_count(scripture_text, "\\W+"))

word_count_summary <- verse_count %>% 
  group_by(book_title) %>% 
  summarise(mean_word_count = mean(wc)) %>% 
  ungroup %>% 
  mutate(book_title = factor(book_title),
  book_title = fct_reorder(book_title, mean_word_count))


book_levels <- levels(word_count_summary$book_title)

verse_count <- verse_count %>% mutate(book_title =factor(book_title, levels = book_levels))

ggplot(data =verse_count, aes(x = verse_number, y = wc)) +
  geom_hex() +
  geom_hline(data = word_count_summary, mapping = aes(yintercept = mean_word_count, color = ""), size = 1.0) +
  facet_wrap(~book_title, ncol = 1, scales = "free_y") +
  theme_classic()+
  scale_fill_viridis_c(option = "D")+
  theme(legend.position = "top")+
  scale_y_continuous(sec.axis = dup_axis())+
  labs(title = "Book of Mormon Word Count by Chapter & Book", fill = "Number of Words Per Verse", y = "Word Count per Chapter", x = "Number of Verses Per Chapter", color = "Mean Word Count Per Book")
```

![](Task-16_files/figure-html/unnamed-chunk-4-1.png)<!-- -->



```r
bom <- scriptures %>% filter(volume_title == "Book of Mormon") %>%
  mutate(wc = 0)

for(i in 1:nrow(bom)){
  bom$wc[i] = str_count(bom$scripture_text[i], "\\W+")
}

pander(mosaic::favstats(bom$wc))
```

Registered S3 method overwritten by 'mosaic':
  method                           from   
  fortify.SpatialPolygonsDataFrame ggplot2

---------------------------------------------------------------
 min   Q1   median   Q3   max   mean     sd      n     missing 
----- ---- -------- ---- ----- ------- ------- ------ ---------
  4    27     38     51   142   40.51   18.51   6604      0    
---------------------------------------------------------------

4. count the mean number of ands per verse as proxy for fun on sentences


```r
books <- levels(factor(bom$book_title)) 

output <- vector("double", length(books)) 

for(i in 1:length(books)){
  books_only <- bom %>% filter(book_title == books[i])
  narrative <- str_c(books_only$scripture_text, collapse = " ")
  sentences <- stri_split_boundaries(narrative, type = "sentence")
  
 output[i] = sentences %>% unlist() %>% tibble() %>% mutate(andnum = str_count(., "and")) %>% 
    summarise(mean_and = mean(andnum))
 }

output %>% unlist() %>% cbind(books) %>% data.frame() %>% pander()
```


------------------------------------
        .                books      
------------------ -----------------
 1.71312584573748       1 Nephi     

 1.64760914760915       2 Nephi     

 2.06666666666667       3 Nephi     

 2.66666666666667       4 Nephi     

 1.91011723838472        Alma       

 1.86111111111111        Enos       

 1.7852998065764         Ether      

 2.18566176470588       Helaman     

 1.73962264150943        Jacob      

 1.96296296296296        Jarom      

 2.07272727272727       Mormon      

 1.57386363636364       Moroni      

 2.09860788863109       Mosiah      

        2                Omni       

       2.3          Words of Mormon 
------------------------------------


###### Other options for coding:
```
script$verse_length <- sapply(script$scripture_text, function(x)
  length(unlist(strsplit(as.character(x), "\\W+"))))
  
  bomnt %>% group_by(volume_title, verse_id) %>% (  mutate(wc = stri_stats_latex(scripture_text)["Words"])
  
  scriptures$verse_length <- sapply(scriptures$scripture_text, function(x)
  length(unlist(strsplit(as.character(x), "\\W+"))))

wc = str_count(scripture_text, "\\W+"))
```