library(dplyr)
library(tidyr)
library(ggplot2)

week4 <- read.csv('~/Desktop/week_4.csv') %>% janitor::clean_names()

w4_gathered <- gather(week4, key = ranker, value = team, -ranking)

w4_gathered$team <- as.factor(w4_gathered$team)

w4_ordered <- w4_gathered[-c(2)] %>% arrange(ranking, team) 

ggplot(w4_ordered, aes(x = reorder(team, ranking), y = ranking, color = team)) +
  scale_y_continuous(trans = "reverse") +
  labs(title = 'Week 4 Power Rankings',
       x     = 'Team',
       y     = 'Ranking') +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) + 
  geom_boxplot()

?theme
