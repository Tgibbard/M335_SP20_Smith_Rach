 dat <- readr::read_lines("https://byuistats.github.io/M335/data/randomletters.txt")

str_length(dat)
str_remove_all(dat, ["ae"])

str_remove_all(dat, "a|e")

str_length(dat)

dat3 <- str_extract_all(dat, "sister")

dat3

quant <- function(rx)str_view_all("aaa";rx)
dat3 <- str_extract_all(dat, "a{3}")

dat4 <- str_extract_all 

dat5 <- str.locate(dat,"aaa")
dat5

dat %>%  str_locate_all("aaa") %>% unlist()

dat %>% str_split(pattern = "[:^alpha:]") %>% str_split("")

str_count( dat, pattern =c("mom","dad","jim"))