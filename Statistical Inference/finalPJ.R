library(Rcpp)
library(dplyr)
library(data.table)
library(plyr)
library(datasets)
library(ggplot2)
library(ggpubr)
library(FactoMineR)
library(party)
library(caret)
library(readxl)
library(stringr)

#this function fixes the players names
fix_players_names = function(stats){
  names = stats[,'Player']
  names2 = strsplit(names, "\\\\")
  final_names = c(1:length(names2))
  for( i in 1:length(names2))
    final_names[i] = names2[[i]][1]
  
  stats[,'Player'] = final_names
  return(stats)
}

#this function add a plus_minus_column to the data
add_plus_minus_column = function(stats){
  dt = as.data.table(stats)
  dt [ ,plus_minus := claculate_plus_minus(dt)]
  return(dt)
  
}

#this function add a plus_minus_column of a team to the data
add_plus_minus_column_of_team = function(stats){
  dt = as.data.table(stats)
  dt [ ,plus_minus_team := mean(plus_minus), by = Tm]
  return(dt)
}

#adding Standard Deviation
add_sd_of_pm_column = function(stats){
  dt = as.data.table(stats)
  dt [ ,plus_minus_sd := sd(plus_minus), by = Tm]
  return(dt)
}

#this function calculate the plus_minus rate
claculate_plus_minus = function(ps){
  ps = data.frame(ps)
  a = (ps['PTS']+ps['TRB']+ps['AST']+ps['STL'])
  b =  (ps['FGA']-ps['FG']+ps['FTA']-ps['FT']+ps['TOV'])
  return(a-b)
}

#this function converts the full team name to the abbreviation
convert_names_to_abb = function(ranks,team_names)
{
  
  names(ranks)=ranks[1,]
  ranks=ranks[-1,]
  ranks_names = ranks %>% select (Rk,Team)

  for (i in 1:nrow(team_names))
  {
    ranks_names[ranks_names==(team_names[i,2])]<-(team_names[i,1])
  }
  return (ranks_names) #now names had changed to abb
}

#this function groups and means the data by Tm
bind_mean_data_to_sd = function(names_abb,stats_dt){
  stats_by_team = stats_dt %>% group_by(Tm) %>% summarise_each(funs(mean))
  stats_by_team[ ,'Rk']<-c(rep(0,(nrow(stats_by_team)))) #add sd column
  
  for (i in 1:nrow(names_abb)) #add sd from stats to abb_ranks col
  {
    #adding rank col to mean of all other data by team
    stats_by_team[stats_by_team[,'Tm']==(names_abb[i,'Team']),'Rk']=as.numeric(names_abb[i,'Rk'])
    
  }
  
  return (stats_by_team)
}

#this function calculating rates of all teams ans adds plus_minus columns and 
#plus_minus sd columns to the data
#returns a data with all the additional calculations
process_season=function(stats_dir,ranks_dir,names_dictionary)
{
  stats = data.frame( read_excel(stats_dir,col_names = TRUE))
  stats = fix_players_names(stats)
  ranks = data.frame(read_excel(ranks_dir,col_names = TRUE))
  names_abb = convert_names_to_abb(ranks,names_dictionary)
  
  stats2 = stats %>% select(Tm,PTS,TRB,AST,STL,FTA,FT,FGA,FG,TOV,BLK,X3PA)
  stats2 = stats2 %>% filter(!grepl('TOT',Tm)) #remove TOT rows - when player has been in several teams
  stats2 = add_plus_minus_column(stats2)
  stats2 = add_plus_minus_column_of_team(stats2)
  stats2 = data.frame(add_sd_of_pm_column(stats2))
  
  stats_by_team = bind_mean_data_to_sd(names_abb,stats2) #contains rank Team and sd
  return (stats_by_team)
}

#plot correlation of (rk,+-sd)
print_correlation = function(stats){
  
  total2 = as.data.table(stats)
  total2[ ,sd_Avg := mean(plus_minus_sd), by = Rk]
  total2 = total2 %>% select(Rk,sd_Avg)
  total2 = unique(total2)
  total2 = data.frame(total2)
  x1 = c(total2[['Rk']])
  x1 = as.numeric(x1)
  y1 = c(total2[['sd_Avg']])
  y1 = as.numeric(y1)
  
  pdf('Correlation.pdf') 
  plt = ggplot(total2,aes(Rk,sd_Avg))+geom_point()+ 
    geom_smooth(method = "lm",color='blue')+labs(x = 'Standing', y ='Level differences in the Team',
    title = "Correlation between level differences of players in\n             
               an NBA team and it's standing")
  print(plt)
  dev.off() 
  print(plt)
}

#this function plot PCA results to pdf file and to the console
PCA_func = function(stats){
  #pca for data grouped by Rank
  merged_data_by_rank=stats %>% group_by(Rk) %>% summarise_each(funs(mean)) #summarize and means the data by rank
  merged_data_by_rank = select(merged_data_by_rank,-Tm)
  Rk.pca = PCA(merged_data_by_rank[,1:ncol(merged_data_by_rank)],scale.unit = TRUE,graph = T) #pca
  pdf("PCA_Rank.pdf")
  PCA(merged_data_by_rank[,1:ncol(merged_data_by_rank)],scale.unit = TRUE,graph = T) #pca
  dev.off()
}

#----------------------------------------------------------#

#main
setwd("C:/Big_Data/final_project")

ranks_list = (list.files(paste(getwd(),"nba_ranks",sep='/')))
stats_list = (list.files(paste(getwd(),"nba_stats",sep='/')))
names_dictionary = data.frame(fread("team_names_full_updated.csv"))

total=c("Rk","Team","sdAdded")

curr_rank=paste(getwd(),"nba_ranks",ranks_list[1],sep='/')
curr_stat=paste(getwd(),"nba_stats",stats_list[1],sep='/')
total=process_season(curr_stat,curr_rank,names_dictionary)

for (i in 2:length(ranks_list))
{
  curr_rank=paste(getwd(),"nba_ranks",ranks_list[i],sep='/')
  curr_stat=paste(getwd(),"nba_stats",stats_list[i],sep='/')
  total=rbind(total,process_season(curr_stat,curr_rank,names_dictionary))
}

print_correlation(total)
PCA_func(total)




