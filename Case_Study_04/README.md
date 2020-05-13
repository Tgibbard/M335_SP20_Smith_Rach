# all datasets are made of lists an vectors

#Vectors:
  # is a sequence of data elements
  # vectors are automic, which means all are the same type:
  # Logical, Integer, double, numeric, character, 

#list:
  # a sequence of data elements
  # they can be different data types
  # can be/are recursive.
 
#data.frame s:
  # are lists with lists and vectors
  # df constraints- can't use same column name twice
  # all elements of df are vectors
  # all elements have to be the same length
  # each column is a vector
  # each row is an item

# Access elements in list or vector:
  # []
  # [[]] = 1 and only 1 of each, and drops extra information

#Tibbles (tbl) differences from df
  # read_csv - Tidyverse = tbl
  # will not convert strings to factors
  # doesn't add row names
  # doesn't munge column names- uses backticks ``
  # only recycles length 1 inputs
  # only displays first 10 rows
  # only prints as many columns as it has room for
  # give you variable type at teh top

# read.csv - base R = data.frame
  # converts strings to factors
  # changes column names that it doesn't like

# Other
    # haven SPSS, Stata, SAS
    # readxl- .xls files .xslx
    # for others - db.rstudio.com

coronavirus_cfr <- read_csv("coronavirus-cfr.csv", 
                            col_types = cols(Date = col_date(format = "%b d%, %Y")))
View(coronavirus_cfr)
