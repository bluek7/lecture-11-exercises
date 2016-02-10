### Exercise 3 ###
library(jsonlite)
library(dplyr)
library(plotly)

# Read in this police shooting JSON data 
# https://raw.githubusercontent.com/mkfreeman/police-shooting/master/data/response.json
data <- fromJSON('https://raw.githubusercontent.com/mkfreeman/police-shooting/master/data/response.json')


# Dealing with the `Shots Fired` column
# Creating a new Numeric variable with no space in the name
# Replacing NA values with the mean (that makes sense, right?)
data$shots_fired <- as.numeric(data[,'Shots Fired'])
data <- data %>%
        mutate(shots_fired = ifelse(is.na(shots_fired), mean(shots_fired, na.rm = T), shots_fired))

# Create a bubble map of the data
g <- list(
  scope = 'usa',
  projection = list(type = 'albers usa'),
  showland = TRUE,
  landcolor = toRGB("gray85"),
  subunitwidth = 1,
  countrywidth = 1,
  subunitcolor = toRGB("white"),
  countrycolor = toRGB("white")
)

plot_ly(data, lon = lng, lat = lat, type = 'scattergeo') %>% 
  layout(title = 'Crowdsource Shootings by Cops', geo = g)

### Bonus: create informative hover text ###
data$hover <- paste(data[['Victim Name']], data[['Victim\'s Age']])
plot_ly(data, 
        lon = lng, 
        lat = lat, 
        marker = list(size = shots_fired / 3 + 1, color = toRGB('red')),
        type = 'scattergeo',
      
        text = hover) %>% 
  layout(title = 'Crowdsource Shootings by Cops', geo = g)

### Bonus: Use multiple colors ###
