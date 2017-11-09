library(dplyr)
library(tidyr)
library(purrr)
library(readxl)

path <- '~/Documents/GitHub/power-rankings/power-rankings.xlsx'

import_rankings <- map(excel_sheets(path),
                         read_excel,
                         path = path)

power_rankings <- map(import_rankings, gather, key = ranker, value = team, -ranking)

df_names <- paste0('week', 0:(length(power_rankings) - 1))
names(power_rankings) <- df_names

list2env(power_rankings, .GlobalEnv)

all_weeks <- cbind(week0[3], week1[3], week2[3], week3[3], week4[3], week5[3], week6[3], week7[3], week8[3],
                   week9[3]) 
colnames(all_weeks) <- df_names

all_weeks <- cbind(week1[1], all_weeks)

#all_weeks <- unclass(all_weeks) %>% as.data.frame()

all_gathered <- na.omit(all_weeks) %>% gather(key = week, value = team, -ranking)
all_gathered$week <- as.factor(all_gathered$week)
all_gathered$team <- as.factor(all_gathered$team)

