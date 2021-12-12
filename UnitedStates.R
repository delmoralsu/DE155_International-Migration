## Deatch all current active packages
detachAllPackages()

## The following chunk will check if the required packages are installed and load them.
## If the required packages are not installed, they will be downloaded, installed, and loaded.

if (!require(rgeos)) {
  install.packages("rgeos", repos = "http://cran.us.r-project.org")
  require(rgeos)
}
if (!require(rgdal)) {
  install.packages("rgdal", repos = "http://cran.us.r-project.org")
  require(rgdal)
}
if (!require(broom)) {
  install.packages("broom", repos = "http://cran.us.r-project.org")
  require(broom)
}
if(!require(ggplot2)) {
  install.packages("ggplot2", repos="http://cloud.r-project.org")
  require(ggplot2)
}

if(!require(dplyr)) {
  install.packages("dplyr", repos = "https://cloud.r-project.org/")
  require(dplyr)
}

## Function for a custom theme for the map. Credits: Timo Gross Bacher, https://timogrossenbacher.ch/2016/12/beautiful-thematic-maps-with-ggplot2-only/
theme_map <- function(...) {
  theme_minimal() +
    theme(
      text = element_text(family = "Ubuntu Regular", color = "#22211d"),
      axis.line = element_blank(),
      axis.text.x = element_blank(),
      axis.text.y = element_blank(),
      axis.ticks = element_blank(),
      axis.title.x = element_blank(),
      axis.title.y = element_blank(),
      # panel.grid.minor = element_line(color = "#ebebe5", size = 0.2),
      panel.grid.major = element_line(color = "#ebebe5", size = 0.2),
      panel.grid.minor = element_blank(),
      plot.background = element_rect(fill = "#f5f5f2", color = NA), 
      panel.background = element_rect(fill = "#f5f5f2", color = NA), 
      legend.background = element_rect(fill = "#f5f5f2", color = NA),
      panel.border = element_blank(),
      ...
    )
}

## Load the geograpical data
USSHP <- readOGR("ShapeFiles/UnitedStates/cb_2018_us_state_500k.shp")

## The shapefile is tidied up so we can assign the international migrant population percentages to each region.
USTidy <- tidy(USSHP)
USSHP$id <-rownames(USSHP)

## When plotting a map of the United States, we encounter the challenges of the non-contiguous states of Alaska and Hawaii, and of the American Territories.
## Taking them into consideration distors the resulting map, so we have decided to only plot the contiguous US states.
## The following code chunks select the cartographical data for the contiguous US states and discards the rest.
data1 <- cbind(USSHP@data[["GEOID"]],USSHP@data[["STUSPS"]])
id <- seq(0, 55, by = 1)
data2 <- cbind(data1, id)
USData <- merge(USTidy, data2, by = "id")
USData$V1 <- as.numeric(USData$V1)

## Removing data from non-contiguous US states
USData <- filter(USData, V1 != 66)
USData <- filter(USData, V1 != 69)
USData <- filter(USData, V1 != 72)
USData <- filter(USData, V1 != 78)
USData <- filter(USData, V1 != 15)
USData <- filter(USData, V1 != 02)
USData <- filter(USData, lat > 0)

## Load data on distribution of migrant population
USMigrantPop <- read.csv("US.csv", sep = ";")

## Both databases are merged by id, so now each state is associated to the proportion of international migrants that live there.
## Some manipulation of the column names is needed before the merging.
colnames(USData) <- c("id", "long", "lat", "order", "hole", "piece", "group", "Code", "Name")
USDos <- merge(USData, USMigrantPop, by = "Code")

## Plot the data on the map
USMap <- ggplot() +
  geom_polygon(data = USDos, aes(fill = Percentage,
                                    x = long,
                                    y =lat,
                                    group = group)) +
  geom_path(data = USDos, aes (x = long,
                                  y = lat,
                                  group = group),
            color = "white", size = 0.1) +
  theme_map() +
  theme(
    legend.position = "right",
    legend.text.align = 0,
    legend.background = element_rect(fill = alpha('white', 0.0)),
    legend.text = element_text(size = 7, hjust = 0, color = "#4e4d47"),
    plot.title = element_text(hjust = 0.5, color = "#4e4d47"),
    plot.subtitle = element_text(hjust = 0.5, color = "#4e4d47", 
                                 margin = margin(b = -0.1, 
                                                 t = -0.1, 
                                                 l = 2, 
                                                 unit = "cm"), 
                                 debug = F),
    legend.title = element_text(size = 8),
    plot.margin = unit(c(.5,.5,.2,.5), "cm"),
    panel.spacing = unit(c(-.1,0.2,.2,0.2), "cm"),
    panel.border = element_blank(),
    plot.caption = element_text(size = 6, 
                                hjust = 0.92, 
                                margin = margin(t = 0.2, 
                                                b = 0, 
                                                unit = "cm"), 
                                color = "#939184")
  ) +
  labs(x = NULL, 
       y = NULL, 
       title = "The United States international migrant population in 2019", 
       subtitle = "Migrants as a percentage of the total population in each contiguous state", 
       caption = "Source: Statista 2021, own elaboration.")

## Display the map.
USMap

## It can now be exported to an image or a pdf.

