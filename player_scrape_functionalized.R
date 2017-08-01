# Load the Package
#install.packages("rvest")
library("rvest")

#Cleaning Function
clean_data_frame = function(x){
  colnames(x) <- x[2,]
  x = x[-c(1,2),]
  x = x[-c(171:177), ]
  x = x[!(x$DATE == "Monthly Totals"), ]
  x = x[!(x$DATE == "DATE"), ]
  x[ x == "Did not play" ] = NA
  colnames(x)[7] = "B2"
  colnames(x)[8] = "B3"
  x = transform(x, AB = as.numeric(AB),
                R = as.numeric(R),
                H = as.numeric(H),
                B2 = as.numeric(B2),
                B3 = as.numeric(B3),
                HR = as.numeric(HR),
                RBI = as.numeric(RBI),
                BB = as.numeric(BB),
                SO = as.numeric(SO),
                SB = as.numeric(SB),
                CS = as.numeric(CS))
  x = x[,-c(3)]
  x = x[,-c(14:17)]
  #Changes the date into a usable form for the weatherData package
  x[,1] = gsub("(Apr )", "2016-4-", x[,1])
  x[,1] = gsub("(May )", "2016-5-", x[,1])
  x[,1] = gsub("(Jun )", "2016-6-", x[,1])
  x[,1] = gsub("(Jul )", "2016-7-", x[,1])
  x[,1] = gsub("(Aug )", "2016-8-", x[,1])
  x[,1] = gsub("(Sep )", "2016-9-", x[,1])
  opp = x$OPP
  opp = gsub("(@ )", "", opp)
  opp = gsub("vs .*", "HOME", opp)
  oppid = 1:length(opp)
  for(i in 1:length(opp)){
    oppid[i] = switch(opp[i],
                      "HOME" = "KORD",
                      "ARI" = "KPHX",
                      "CIN" = "KLUK",
                      "STL" = "KSTL",
                      "PIT" = "KPIT",
                      "MIL" = "KMKE",
                      "SF" = "KSFO",
                      "PHI" = "KPHL",
                      "ATL" = "KATL",
                      "WSH" = "KDCA",
                      "CHW" = "KORD",
                      "MIA" = "KMIA",
                      "LAD" = "KSLI",
                      "SD" = "KSAN",
                      "HOU" = "HOU",
                      "COL" = "KDEN",
                      "OAK" = "KOAK",
                      "LAA" = "KSNA",
                      "NYM" = "KLGA")
  }
  x$OPPID = oppid
  return(x)
}




#KRIS BRYANT SCRAPE
# Grab a copy of the Kris Bryant's Statistics Directory
bryant_player_stats = read_html(
  "http://www.espn.com/mlb/player/gamelog/_/id/33172/year/2016")
# Retrieve Stat Table Entries
bryant_player_stats %>%
  # Uses selector given before
  html_nodes("#content > div.bg-opaque > div.span-6.last > div > div.mod-container.mod-table.mod-player-stats > div > table") %>%
  html_table() -> bryant_player_table
bryant_player_frame = data.frame(bryant_player_table[2])
bryant_player_frame = clean_data_frame(bryant_player_frame)


#ANTHONY RIZZO SCRAPE
rizzo_player_stats = read_html(
  "http://www.espn.com/mlb/player/gamelog/_/id/30782/year/2016")
# Retrieve Stat Table Entries
rizzo_player_stats %>%
  # Uses selector given before
  html_nodes("#content > div.bg-opaque > div.span-6.last > div > div.mod-container.mod-table.mod-player-stats > div > table") %>%
  html_table() -> rizzo_player_table
rizzo_player_frame = data.frame(rizzo_player_table[2])
rizzo_player_frame = clean_data_frame(rizzo_player_frame)


#BEN ZOBRIST SCRAPE
zobrist_player_stats = read_html(
  "http://www.espn.com/mlb/player/gamelog/_/id/28536/year/2016")
# Retrieve Stat Table Entries
zobrist_player_stats %>%
  # Uses selector given before
  html_nodes("#content > div.bg-opaque > div.span-6.last > div > div.mod-container.mod-table.mod-player-stats > div > table") %>%
  html_table() -> zobrist_player_table
zobrist_player_frame = data.frame(zobrist_player_table[2])
zobrist_player_frame = clean_data_frame(zobrist_player_frame)


#ADDISON RUSSELL SCRAPE
russell_player_stats = read_html(
  "http://www.espn.com/mlb/player/gamelog/_/id/32656/year/2016")
# Retrieve Stat Table Entries
russell_player_stats %>%
  # Uses selector given before
  html_nodes("#content > div.bg-opaque > div.span-6.last > div > div.mod-container.mod-table.mod-player-stats > div > table") %>%
  html_table() -> russell_player_table
russell_player_frame = data.frame(russell_player_table[2])
russell_player_frame = clean_data_frame(russell_player_frame)


#JASON HEYWARD SCRAPE
heyward_player_stats = read_html(
  "http://www.espn.com/mlb/player/gamelog/_/id/29551/year/2016")
# Retrieve Stat Table Entries
heyward_player_stats %>%
  # Uses selector given before
  html_nodes("#content > div.bg-opaque > div.span-6.last > div > div.mod-container.mod-table.mod-player-stats > div > table") %>%
  html_table() -> heyward_player_table
heyward_player_frame = data.frame(heyward_player_table[2])
heyward_player_frame = clean_data_frame(heyward_player_frame)


