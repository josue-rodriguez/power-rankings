library(ggplot2)
library(directlabels)
library(dplyr)
library(purrr)

setwd('~/Documents/GitHub/power-rankings')
source('all_weeks.R')

all_colors <- c('#9B2743', '#051C2C', '#FC4C02', '#00338D', '#FC4C02', '#382F2D', '#C8102E', '#B0063A', '#0072CE', '#C8102E', '#001489', 
                '#003594', '#008E97', '#064C53', '#A6192E', '#001E62', '#006073', '#0C371D', '#0069B1', '#175E33', '#0085CA', '#0C2340',
                '#101820', '#002244', '#241773', '#862633', '#A28D5B', '#4DFF00', '#FFB81C', '#A6192E', '#4B92DB', '#512D6D')

# create a plot for all teams
all_plot <- ggplot(group_by(all_gathered, week, team), aes(x = week, y = ranking, group = team, color = team)) +
  stat_summary(fun.y = mean, geom = 'line', size = .75) +
  labs(title = 'r/NFL Power Rankings', x = 'Week', y = 'Average Ranking', color = 'Teams') +
  scale_x_discrete(labels = paste('Week', 0:(length(power_rankings) - 1), sep = ' ')) +
  scale_y_continuous(trans = 'reverse', breaks = seq(1, 32, 2), sec.axis = dup_axis()) +
  scale_color_manual(values = all_colors) +
  theme(panel.grid.minor = element_blank())

all_plot <- direct.label(all_plot, method = list('first.bumpup', dl.trans(x = x - .15), cex = .65))
all_plot <- direct.label(all_plot, method = list('last.bumpup', dl.trans(x = x + .15), cex = .65))

# function for creating plots of individual divisions
plots <- function(t1, t2, t3, t4, div, cols) {
  
  all_gathered %>% filter(team == t1|team == t2|team == t3|team == t4) %>% 
    ggplot(aes(x = week, y = ranking, group = team, color = team)) +
    stat_summary(fun.y = mean, geom = 'line', size = 1.3) +
    labs(title = div, x = 'Week', y = 'Average Ranking', color = 'Teams') +
    coord_cartesian(ylim = c(1, 32))+
    scale_x_discrete(labels = paste('Week', 0:(length(power_rankings) - 1), sep = ' ')) +
    scale_y_continuous(trans = 'reverse', breaks = seq(1, 32, 2)) +
    scale_color_manual(values = cols) +
    theme(panel.grid.major = element_line(size = .5),
          panel.grid.minor = element_blank())
  
}

# colors
nfc_north_cols <- c('#DC4405', '#0069B1', '#175E33', '#512D6D')
nfc_south_cols <- c('#C8102E', '#A6192E', '#0085CA', '#A28D5B')
nfc_west_cols <- c('#896C4C', '#9B2743', '#041E42', '#4DFF00')
nfc_east_cols <- c('#003594', '#004953', '#001E62', '#862633')

afc_north_cols <- c('#FC4C02', '#382F2D', '#241773', '#FFB81C')
afc_south_cols <- c('#001489', '#006073', '#A6192E', '#4B92DB')
afc_west_cols <- c('#FC4C02', '#0072CE', '#C8102E', '#101820')
afc_east_cols <-  c('#C8102E', '#008E97','#0C371D','#0C2340')

# creating division graphs
nfc_north <- plots('Packers', 'Vikings', 'Bears', 'Lions', 'NFC North', nfc_north_cols)
nfc_south <- plots('Falcons', 'Saints', 'Panthers', 'Buccaneers', 'NFC South', nfc_south_cols)
nfc_west <- plots('Rams', '49ers', 'Cardinals', 'Seahawks', 'NFC West', nfc_west_cols)
nfc_east <- plots('Giants', 'Redskins', 'Eagles', 'Cowboys', 'NFC East', nfc_east_cols)

afc_north <- plots('Ravens', 'Steelers', 'Bengals', 'Browns', 'AFC North', afc_north_cols)
afc_south <- plots('Jaguars', 'Colts', 'Texans', 'Titans', 'AFC South', afc_south_cols)
afc_west <- plots('Raiders','Chiefs', 'Broncos','Chargers', 'AFC West', afc_west_cols)
afc_east <- plots('Patriots', 'Jets', 'Bills', 'Dolphins', 'AFC East', afc_east_cols)


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

# set graph destination
setwd('~/Dropbox/NFL Graphs/Week 17')

# save all graphs
map2(filenames, graphs, save_graphs)



