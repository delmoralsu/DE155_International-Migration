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

## Load the shapefile for Japan
JapanSHP <- readOGR("ShapeFiles/Japan/jpn_admbnda_adm1_2019.shp")

## Load data on distribution of migrant population
Japan <- read.csv("IntMgrntPopDatasets/Japan.csv", sep = ";")
## The dataset has many additional rows. The following code chunk gets rid of them.
Num <- seq(1, 47, by = 1)
Japan <- Japan[Num,]

## Convert the "Percentage" column to numeric and replace commas for dots.
Japan$Percentage <- as.numeric(sub(",", ".", sub(".", "", Japan$Percentage, fixed=TRUE), fixed=TRUE))

## The shapefile is tidied up so we can assign the international migrant population percentages to each canton.
JapanTidy <- tidy(JapanSHP)
JapanSHP$id <-rownames(JapanSHP)

## In this case, we can add an "id" column directly to the dataset because the prefectures are in the correct order.
Japan$id <- seq(0,46, by = 1)

## Both databases are merged by id, so now each prefecture is associated to the proportion of international migrants that live there.
JapanDos <- merge(JapanTidy, Japan, by = "id")

## Plot the map.
JapanMap <- ggplot() +
  geom_polygon(data = JapanDos, aes(fill = Percentage,
                                    x = long,
                                    y =lat,
                                    group = group)) +
  geom_path(data = JapanDos, aes (x = long,
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
       title = "Japan international migrant population in 2018", 
       subtitle = "Migrants as a percentage of the total population in each prefecture", 
       caption = "Source: Japanese Ministry of Justice 2018, own elaboration.")

## Display the map
JapanMap

## It can now be exported to an image or a pdf.
