
#install.packages(weatherData)
library(weatherData)
 
cols = c(1, 2, 4, 7)
weather_clean = data.frame(1:160,1:160,1:160,1:160,1:160)
for(i in 1:160){
n = bryant_player_frame[i,15]
x = gsub("(:[0-6][0-9]*)","", n)
weather_data = getDetailedWeather(bryant_player_frame[i,14], bryant_player_frame[i,1], opt_custom_columns = TRUE, custom_columns = cols)
weather_stored = weather_data[grep(paste0("(",x,":5)"), weather_data[,2]),]  
weather_stored = weather_stored[grep("(PM)",weather_stored[,2]),]
weather_clean[i,] = weather_stored[1,]
}
weather_clean = weather_clean[,-c(1,2)]
colnames(weather_clean) = c("Temp", "Humidity", "Wind Dir")

bryant_final = cbind(bryant_player_frame, weather_clean)
rizzo_final = cbind(rizzo_player_frame, weather_clean)
russell_final = cbind(russell_player_frame, weather_clean)
zobrist_final = cbind(zobrist_player_frame, weather_clean)
heyward_final = cbind(heyward_player_frame, weather_clean)



