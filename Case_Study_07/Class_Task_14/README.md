 ```
Chapter 15: Factors

month_levels = c("Jan", "Feb", "Mar")

factor(x, levels = month_levels)
sort()

mutate(fct_reorder())

fct_infreq()

fct_rev()

fct_recode- change values of levels

fct_collapse(  

mutate(partyid = fct_collapse(partyid,
    other = c("No answer", "Don't know", "Other party"),
    rep = c("Strong republican", "Not str republican"),
    ind = c("Ind,near rep", "Independent", "Ind,near dem"),    dem = c("Not str democrat", "Strong democrat")))

fct_lump(data), n = #
(how many groups excluding other.)