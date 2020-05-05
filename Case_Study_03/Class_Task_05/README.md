# Task 5

### Notes on Chapter 28

*You will need to invest considerable effort in making your plots as self-explanatory as possible.*

#### Prerequisites

ggpot
dyplr
ggrepel
virdis

##### Text labels in ggplot:
labs(title = ", subtitle = "", caption = "", x = "", y = "", color = "")

###### Math labels in ggplot
labs( x = quote(put math equation here, not quotes))
```{r}
library(tidyverse)

no_big_engines <- mpg %>% 
  filter(class != "2seater")

ggplot(mpg, aes(displ, hwy))+
  geom_point(aes(color = class)) +
  geom_smooth(se = FALSE, data = no_big_engines) +
  labs(title = "Title goes here", subtitle = "Subtitle goes here", caption = "caption goes here", x = "X Label goes here", y = "Y Label goes here", color = "color goes here")
  
```

##### Annotations

tibble- provides labels.

geom_text(aes(label = variable), data = dataset)
geom_label(aes(label = variable), data = datset, nudge_y = 2, alpha = .05)

geom_smooth(

method = "lm" -  makes straight line
span = 0.3 - makes wigglier curves

### Notes on Chapter 6- Workflow Scripts

*Use the script editor not console to give you more room*

Once your code works, put it in the script editor.

### Notes on Chapter 11- Data Import

read_csv()  comma delimited files
read_csv2() semicolon separated files
red_tsv() tab delimited files
read_delim() reads in any file with any delimiter

Parsed- is how the data is brought in.

read)csv- uses first line of data for column names
use skip = n to skip the first n lines or comment = '#' to drop all lines that start with #

na = "."

##### Why NOT base R read.csv()-
* 10X faster
* product tibbles, don't covert characters to factors, use row names or munge column names
* more reproducible, base R may only work on your computer

##### Parsing a Vector
parse_*()

Problems??  problems(dataset)

parse_logical(), parse_integer()
parse_double(), parse_number()
parse_character()
parse_factor()
parse_datetime(), parse_date(), parse_time()

##### Numbers
. or ,

parse_double(, locale = locale(decimal_mark = ","))
locale( locale = grouping_mark = " ' ")

parse_character() -turns into byte

UTF-8 can encode just about every character used by humans, including emojis.

locale(encoding = "Latin1")

guess_encoding(charToRaw(x1))

parse_date expects / or -
parse_time expects : :
parse_datetime expects, YEAR, Month, Day, Hour, Minute, Second

Year:
%Y 4 digits
%y 2 digits

Month:
%m 2 digits
%b abre. name
%B full name

Day: 
%d 2 digits
%e opt. leading space

Time:
%H 0-23
%I 0-12 must be use with %p
%p am/pm
%M minutes
%S seconds
%Z time zone
%z UTC

Non-Digits
%. skips one non-digit character
%* skips any number

##### Strategy

guess_parser
srt(parse_guess)

##### Problems
read_lines
read_file
