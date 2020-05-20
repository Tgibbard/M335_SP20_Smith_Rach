 ```
 Chapter 11 Data Import
 
 How to read delimited files:
         read_csv = comma
         read_csv2 = semicolon
         read_tsv = tab
         read_delim = any delimiter
 
 read fwf = fixed width files
        fwf_widths, fwf_poistions, read_table
        
read_log = apache style log files

read_csv
        - uses first line of data as column names
        skip = n to skip the first n or lines
        comment = '#' drops lines that start with #
        col_names = FALSE will NOT treat 1st row as headings
        col_names = c("type column names here")
 
PARSE:
str(parse_logical(c("TRUE", "FALSE", "NA")))
>  logi [1:3] TRUE FALSE NA
str(parse_integer(c("1", "2", "3")))
>  int [1:3] 1 2 3
str(parse_date(c("2010-01-01", "1979-10-14")))
>  Date[1:2], format: "2010-01-01" "1979-10-14"
 
parse_logical = boolean
parse_integer = int
parse_double = strict number
parse_number = flexible number
parse_character = character encodings
parse_factor = factors/variable w/fixed known values
parse_datetime
parse_date
parse_time

OTHERS:
problems() =returns tibble to manipulate in dplyr 
guess_encoding


DATE/TIME
Year
%Y (4 digits).
%y (2 digits); 00-69 -> 2000-2069, 70-99 -> 1970-1999.
Month
%m (2 digits).
%b (abbreviated name, like “Jan”).
%B (full name, “January”).
Day
%d (2 digits).
%e (optional leading space).
Time
%H 0-23 hour.
%I 0-12, must be used with %p.
%p AM/PM indicator.
%M minutes.
%S integer seconds.
%OS real seconds.
%Z Time zone (as name, e.g.
 
Non-digits
%. skips one non-digit character.
%* skips any number of non-digits.
 ```