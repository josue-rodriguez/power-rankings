library(tidyverse)
library(readxl)
library(directlabels)

path <- '~/Documents/GitHub/power-rankings/power-rankings.xlsx'

import_rankings <- map(excel_sheets(path),
                         read_excel,
                         path = path)

power_rankings <- map(import_rankings, gather, key = ranker, value = team, -ranking)

<<<<<<< HEAD
df_names <- paste0('week', 1:length(power_rankings)) 
=======
df_names <- paste0('Week', 1:length(power_rankings)) 
>>>>>>> 6d85dd930b83ccdd95ce9987c06238b3094db9ce
names(power_rankings) <- df_names

list2env(power_rankings, .GlobalEnv)

all_weeks <- cbind(week1[3], week2[3], week3[3], week4[3], week5[3]) 
colnames(all_weeks) <- df_names

all_weeks <- cbind(week1[1], all_weeks)

#all_weeks <- unclass(all_weeks) %>% as.data.frame()

all_gathered <- na.omit(all_weeks) %>% gather(key = week, value = team, -ranking)
all_gathered$week <- as.factor(all_gathered$week)
all_gathered$team <- as.factor(all_gathered$team)

all_plot <- ggplot(all_gathered, aes(x = week, y = ranking, group = team, color = team)) +
  stat_summary(fun.y = mean, geom = 'line') +
  labs(main = 'r/NFL Power Rankings', x = 'Weeks', y = 'Average Ranking') +
  scale_y_continuous(trans = 'reverse') 


all_plot <- direct.label(all_plot, method = list('last.bumpup', dl.trans(x = x + .3), cex = .65))
all_plot <- direct.label(all_plot, method = list('first.bumpup', dl.trans(x = x - .3), cex = .65))
all_plot


nfc_west <- all_gathered %>% filter(team == 'Rams'|team == '49ers'|team == 'Cardinals'|team == 'Seahawks') %>% 
  ggplot(aes(x = week, y = ranking, group = team, color = team)) +
  stat_summary(fun.y = mean, geom = 'line') +
  labs(main = 'r/NFL Power Rankings', x = 'Weeks', y = 'Average Ranking') +
  scale_y_continuous(trans = 'reverse') 

afc_west <- all_gathered %>% filter(team == 'Raiders'|team == 'Chiefs'|team == 'Broncos'|team == 'Chargers') %>% 
  ggplot(aes(x = week, y = ranking, group = team, color = team)) +
  stat_summary(fun.y = mean, geom = 'line') +
  labs(main = 'r/NFL Power Rankings', x = 'Weeks', y = 'Average Ranking') +
  scale_y_continuous(trans = 'reverse') 

nfc_south <- all_gathered %>% filter(team == 'Falcons'|team == 'Saints'|team == 'Panthers'|team == 'Buccaneers') %>% 
  ggplot(aes(x = week, y = ranking, group = team, color = team)) +
  stat_summary(fun.y = mean, geom = 'line') +
  labs(main = 'r/NFL Power Rankings', x = 'Weeks', y = 'Average Ranking') +
  scale_y_continuous(trans = 'reverse')

afc_south <- all_gathered %>% filter(team == 'Jaguars'|team == 'Colts'|team == 'Texans'|team == 'Titans') %>% 
  ggplot(aes(x = week, y = ranking, group = team, color = team)) +
  stat_summary(fun.y = mean, geom = 'line') +
  labs(main = 'r/NFL Power Rankings', x = 'Weeks', y = 'Average Ranking') +
  scale_y_continuous(trans = 'reverse')

nfc_east <- all_gathered %>% filter(team == 'Giants'|team == 'Redskins'|team == 'Eagles'|team == 'Cowboys') %>% 
  ggplot(aes(x = week, y = ranking, group = team, color = team)) +
  stat_summary(fun.y = mean, geom = 'line') +
  labs(main = 'r/NFL Power Rankings', x = 'Weeks', y = 'Average Ranking') +
  scale_y_continuous(trans = 'reverse')

afc_east <- all_gathered %>% filter(team == 'Jets'|team == 'Patriots'|team == 'Dolphins'|team == 'Bills') %>% 
  ggplot(aes(x = week, y = ranking, group = team, color = team)) +
  stat_summary(fun.y = mean, geom = 'line') +
  labs(main = 'r/NFL Power Rankings', x = 'Weeks', y = 'Average Ranking') +
  scale_y_continuous(trans = 'reverse')

nfc_north <- all_gathered %>% filter(team == 'Packers'|team == 'Vikings'|team == 'Bears'|team == 'Lions') %>% 
  ggplot(aes(x = week, y = ranking, group = team, color = team)) +
  stat_summary(fun.y = mean, geom = 'line') +
  labs(main = 'r/NFL Power Rankings', x = 'Weeks', y = 'Average Ranking') +
  scale_y_continuous(trans = 'reverse')

afc_north <- all_gathered %>% filter(team == 'Browns'|team == 'Bengals'|team == 'Ravens'|team == 'Steelers') %>% 
  ggplot(aes(x = week, y = ranking, group = team, color = team)) +
  stat_summary(fun.y = mean, geom = 'line') +
  labs(main = 'r/NFL Power Rankings', x = 'Weeks', y = 'Average Ranking') +
  scale_y_continuous(trans = 'reverse')


#####
  # path <- "urbanpop.xls"
  # urban_sheet1 <- read.xls(path, sheet = 1, stringsAsFactors = FALSE)
  # urban_sheet2 <- read.xls(path, sheet = 2, stringsAsFactors = FALSE)
  # urban_sheet3 <- read.xls(path, sheet = 3 , stringsAsFactors = FALSE)
  # 
  #   # Extend the cbind() call to include urban_sheet3: urban
  # urban <- cbind(urban_sheet1, urban_sheet2[-1], urban_sheet3[-1])
  
