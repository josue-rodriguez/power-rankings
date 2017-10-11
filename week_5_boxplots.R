library(dplyr)
library(tidyr)
library(ggplot2)

week5 <- read.csv('~/Documents/GitHub/power-rankings/week_5.csv') %>% janitor::clean_names()

w5_gathered <- gather(week5, key = ranker, value = team, -ranking)

# create a key called ranker, and a value named team
# key takes ranker names as its value
# value keys each ranker's rankings to ranker name, still ordered by ranking


w5_gathered$team <- as.factor(w5_gathered$team)

w5_ordered <- w5_gathered[-c(2)] %>% arrange(ranking, team) 

ggplot(w5_ordered, aes(x = reorder(team, ranking), y = ranking, fill = team)) +
  geom_boxplot() +
  scale_y_continuous(trans = "reverse") +
  labs(title    = 'Power Rankings at r/NFL',
       subtitle = 'Week 5',
       x        = 'Team',
       y        = 'Average Ranking') +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        panel.background = element_rect(fill = "grey57",
                                        colour = "grey57",
                                        size = 0.5, linetype = "solid"),
        panel.grid.major = element_line(size = 0.5, linetype = 'solid',
                                        colour = "gray80"), 
        panel.grid.minor = element_line(size = 0.25, linetype = 'solid',
                                        colour = "gray80")) 



