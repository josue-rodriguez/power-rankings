library(tidyverse)
library(readxl)
library(directlabels)

path <- '~/Documents/GitHub/power-rankings/power-rankings.xlsx'

import_rankings <- map(excel_sheets(path),
                         read_excel,
                         path = path)

power_rankings <- map(import_rankings, gather, key = ranker, value = team, -ranking)

df_names <- paste0('week', 1:length(power_rankings))
names(power_rankings) <- df_names

list2env(power_rankings, .GlobalEnv)

all_weeks <- cbind(week1[3], week2[3], week3[3], week4[3], week5[3]) 
colnames(all_weeks) <- df_names

all_weeks <- cbind(week1[1], all_weeks)

#all_weeks <- unclass(all_weeks) %>% as.data.frame()

all_gathered <- na.omit(all_weeks) %>% gather(key = week, value = team, -ranking)
all_gathered$week <- as.factor(all_gathered$week)
all_gathered$team <- as.factor(all_gathered$team)







#####
  # path <- "urbanpop.xls"
  # urban_sheet1 <- read.xls(path, sheet = 1, stringsAsFactors = FALSE)
  # urban_sheet2 <- read.xls(path, sheet = 2, stringsAsFactors = FALSE)
  # urban_sheet3 <- read.xls(path, sheet = 3 , stringsAsFactors = FALSE)
  # 
  #   # Extend the cbind() call to include urban_sheet3: urban
  # urban <- cbind(urban_sheet1, urban_sheet2[-1], urban_sheet3[-1])
  
