#comparing correlations practice 

library(tidyverse)

#load data
bfi <- read_csv("bfi.csv")

#determine variables by "glimpsing"
glimpse(bfi)

#quickly see correlations using apaTables
library(apaTables)
apa.cor.table(bfi)

#compare two non-overlapping correlations in the same data set-(A1,C1) and (E1,O1)
#will give us results of a comparison between two non-overlapping correlations
library(cocor)
cocor(~A1+C1|E1+O1, data=as.data.frame(bfi))

#compare tow overlapping correlations in this data set
#saying, does C1 predict A1 better than E1 predicts A1
library(cocor)
cocor(~C1+A1|E1+A1, data=as.data.frame(bfi))

#compare correlations across different data sets - e.g we have GENDER in this data set, so men and women
#create seperate data files for men and women (if needed)
bfi_men <- bfi %>% filter(gender==1) %>% select(-gender)
bfi_women <- bfi %>% filter(gender==2) %>% select(-gender)
glimpse(bfi_men)
glimpse(bfi_women)
#look at subgroup correlations
apa.cor.table(bfi_men)
apa.cor.table(bfi_women)

#compating (A1,E1) correltion for men to (A1,E1) correlation for women
library(cocor)
bfi_men_dataframe <- as.data.frame(bfi_men)
bfi_women_dataframe <- as.data.frame(bfi_women)
cocor(~A1+E1|A1+E1, data=list(bfi_men_dataframe, bfi_women_dataframe))
