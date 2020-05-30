```
Chapter 13 Notes

Relational Data:


primary key- unique observations in its own table

foreign key- an observation in another table.

surrogate key- if a table doesn't have a key, add mutate and row number to add one.

mutating joins
left join- keeps everything on left table
right join- keeps everything on right table
inner join- only matching pairs of observations
full join keeps everything (end up with lots of NA values)

semi_join(x,y) KEEPS all x, that have match in y
anti_join(x,y) DROPS all x that have a match in y

intersect(x,y) return observations in BOTH x & y
union(x, y) return UNIQUE observations in x & y
setdiff(x,y) return observations in x, but not in y


TROUBLESHOOTING:

check that NONE of the PK are missing.  
check FK match PK in another table (best way = anti_join, it's common for data entry errors)


base::merge() can perform all four types of mutating join:

dplyr	merge
inner_join(x, y)	merge(x, y)
left_join(x, y)	merge(x, y, all.x = TRUE)
right_join(x, y)	merge(x, y, all.y = TRUE),
full_join(x, y)	merge(x, y, all.x = TRUE, all.y = TRUE)

dplyr	SQL
inner_join(x, y, by = "z")	SELECT * FROM x INNER JOIN y USING (z)
left_join(x, y, by = "z")	SELECT * FROM x LEFT OUTER JOIN y USING (z)
right_join(x, y, by = "z")	SELECT * FROM x RIGHT OUTER JOIN y USING (z)
full_join(x, y, by = "z")	SELECT * FROM x FULL OUTER JOIN y USING (z)
```
