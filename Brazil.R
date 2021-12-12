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
BrazilSHP <- readOGR("ShapeFiles/Brazil/bra_admbnda_adm1_ibge_2020.shp")

## The shapefile is tidied up so we can assign the international migrant population percentages to each region.
BrazilTidy <- tidy(BrazilSHP)

## Load migrant population distribution data. It has been worked on to match the regions identificators in the shape file,
## so both databases can be directly merged.
BrazilMigrantPop <- read.csv("Brazil.csv", sep = ";")

## Both databases are merged by id, so now each region is associated to the proportion of international migrants that live there.
BrazilData <- merge(BrazilTidy, BrazilMigrantPop, by = "id")

## Plot the data on the map.
BrazilMap <- ggplot() +
  geom_polygon(data = BrazilData, aes(fill = Percentage,
                                 x = long,
                                 y =lat,
                                 group = group)) +
  geom_path(data = BrazilData, aes (x = long,
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
       title = "Brazil international migrant population in 2018", 
       subtitle = "Migrant workers as a percentage of the total workforce in each region", 
       caption = "Source: Observatorio das Migracoes Internacionais 2020, 88, own elaboration.")

## Display the map.
BrazilMap

## It can now be exported to an image or a pdf.
