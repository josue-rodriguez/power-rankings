library(ggplot2)
library(directlabels)
library(dplyr)
library(purrr)

# create a plot for all teams
all_plot <- ggplot(all_gathered, aes(x = week, y = ranking, group = team, color = team)) +
  stat_summary(fun.y = mean, geom = 'line', size = .75) +
  labs(title = 'r/NFL Power Rankings', x = 'Week', y = 'Average Ranking', color = 'Teams') +
  scale_x_discrete(labels = paste('Week', 0:6, sep = ' ')) +
  scale_y_continuous(trans = 'reverse', breaks = seq(1, 32, 2), sec.axis = dup_axis()) +
  theme(panel.grid.minor = element_blank())

all_plot <- direct.label(all_plot, method = list('last.bumpup', dl.trans(x = x + .15), cex = .5))
all_plot <- direct.label(all_plot, method = list('first.bumpup', dl.trans(x = x - .15), cex = .5))


# function for creating plots of individual divisions
plots <- function(t1, t2, t3, t4, div) {
  
  all_gathered %>% filter(team == t1|team == t2|team == t3|team == t4) %>% 
    ggplot(aes(x = week, y = ranking, group = team, color = team)) +
    stat_summary(fun.y = mean, geom = 'line', size = 1) +
    labs(title = div, x = 'Week', y = 'Average Ranking', color = 'Teams') +
    coord_cartesian(ylim = c(1, 32))+
    scale_y_continuous(trans = 'reverse', breaks = seq(1, 32, 2)) +
    scale_x_discrete(labels = paste('Week', 0:6, sep = ' ')) +
    theme(panel.grid.minor = element_blank(),
          panel.grid.major = element_line(size = .5))
  
}

# creating division graphs
nfc_north <- plots('Packers', 'Vikings', 'Bears', 'Lions', 'NFC North')
nfc_south <- plots('Falcons', 'Saints', 'Panthers', 'Buccaneers', 'NFC South')
nfc_west <- plots('Rams', '49ers', 'Cardinals', 'Seahawks', 'NFC West')
nfc_east <- plots('Giants', 'Redskins', 'Eagles', 'Cowboys', 'NFC East')

afc_north <- plots('Ravens', 'Steelers', 'Bengals', 'Browns', 'AFC North')
afc_south <- plots('Jaguars', 'Colts', 'Texans', 'Titans', 'AFC South')
afc_west <- plots('Raiders','Chiefs', 'Broncos','Chargers', 'AFC West')
afc_east <- plots('Patriots', 'Jets', 'Bills', 'Dolphins', 'AFC East')


# graphs and graph names into lists
graphs <- list(nfc_north, nfc_south, nfc_west, nfc_east,
               afc_north, afc_south, afc_west, afc_east,
               all_plot)

filenames <- list('nfc-north.png', 'nfc-south.png', 'nfc-west.png', 'nfc-east.png',
                  'afc-north.png', 'afc-south.png', 'afc-west.png', 'afc-east.png',
                  'all-teams.png')

# function for saving graphs
save_graphs <- function(file.name, graph){
  png(filename = file.name, units = 'px', width = 1536, height = 1024, res = 200)
  
  print(graph)
  
  dev.off()
}

# save all graphs
setwd('~/Dropbox/NFL Graphs/Week 6')
map2(filenames, graphs, save_graphs)




