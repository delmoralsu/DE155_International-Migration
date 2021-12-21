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

## Load the geograpical data
UAESHP <- readOGR("ShapeFiles/UAE/ARE_adm1.shp")

## The shapefile is tidied up so we can assign the international migrant population percentages to each region.
UAETidy <- tidy(UAESHP)

num <- seq(1, 7, by = 1)
ref <- cbind(UAESHP@data[["ADM1_NAME"]], num)

## Load data on distribution of migrant population
UAEData <- read.csv("IntMgrntPopDatasets/UAE.csv", sep = ";")

## Convert the "Percentage" column to numeric.
UAEData$Percentage <- as.numeric(UAEData$Percentage)

## The 'neutral zone' is removed.
UAEDos <- filter(UAETidy, id != 5)

## Both databases are merged by id, so now each Emirate is associated to the proportion of international migrants that live there.
UAEDos <- merge(UAETidy, UAEData, by = "id")

## Plot the data on the map.
UAEMap <- ggplot() +
  geom_polygon(data = UAEDos, aes(fill = Percentage,
                                    x = long,
                                    y =lat,
                                    group = group)) +
  geom_path(data = UAEDos, aes (x = long,
                                  y = lat,
                                  group = group),
color = "white", size = 0.1) + 
  coord_equal() +
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
       title = "The United Arab Emirates international migrant population in 2020", 
       subtitle = "Migrants as a percentage of the total population in each Emirate", 
       caption = "Source: Global Media Insight 2021, and De Bel-Air 2015, pp. 8-9, own elaboration.")

## Display the map.
UAEMap

## It can now be exported to an image or a pdf.
