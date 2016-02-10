# Figure out what each line of code actually does!

library(plotly)

# I suggest you fiddle with the mapping options,
# Then come back and look at this data wrangling, if you have the time

df <- read.csv('https://raw.githubusercontent.com/plotly/datasets/master/2014_us_cities.csv')
df$hover <- paste(df$name, "Population", df$pop/1e6, " million") # what does this do?
df$q <- with(df, cut(pop, quantile(pop))) # what does this do????
levels(df$q) <- paste(c("1st", "2nd", "3rd", "4th", "5th"), "Quantile") # what does this do?
df$q <- as.ordered(df$q) # what does this do?

g <- list(
  scope = 'usa', # what does this do?
  projection = list(type = 'albers usa'), # what does this do?
  showland = TRUE, # what does this do?
  landcolor = toRGB("gray85"), # what does this do?
  subunitwidth = 1, # what does this do?
  countrywidth = 1, # what does this do?
  subunitcolor = toRGB("white"), # what does this do?
  countrycolor = toRGB("white") # what does this do?
)

plot_ly(df, 
        lon = lon, 
        lat = lat, 
        text = hover, # how does this work?
        marker = list(size = sqrt(pop/10000) + 1), # what else can you adjust?
        color = q, # what does this do?
        type = 'scattergeo', 
        locationmode = 'USA-states'
        ) %>%
  # what if you don't pass this into the layout function?
layout(title = '2014 US city populations<br>(Click legend to toggle)', geo = g)
