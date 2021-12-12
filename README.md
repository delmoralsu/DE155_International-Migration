# DE155_International-Migration

### Description
In our search for information regarding the situation of international labor migrants in Brazil, Japan, the United Arab Emirates, the United States, South Africa, and Switzerland, we stumbled with challenges regarding the disparity of the data available for each country. Despite the significance of the international migrant population in some of these countries and of the high quality of government statistics in some of them, information on the distribution of migrants by administrative regions in the countries analyzed was not readily available in the form of maps. Although this is not a crucial variable of our analysis, we decided it would be worthwhile to further explore this question and to elaborate our own maps, using the available data, in order to add them to the interactive poster. In this way, they are an useful tool to further illustrate the migratory phenomenom in each country.

### Data and methodology
For each case, we sought to use the most recent data on migrants living in the largest sub-national administrative unit in each country, as a percentage of the total population living there. In the case of Brazil, the data available do not refer to the total number of international migrants, but to those that were part of the formal workforce during 2018. An important caveat in this case is that it does not include the recent migration flows from Venezuela into the northern states of Brazil, but Venezuelans would be nonetheless excluded from the dataset because they do not often find employment in the formal sector of the economy. 
The data available in the cases of Switzerland and the United Arab Emirates allowed us to map the distribution of international migrants within the countries during 2020. For the United States and South Africa, the maps illustrate the situation in 2019 and 2016, respectively. In the latter case, it appears the 2020 Census will soon be publicly available, but we used a report that draws on the 2016 Community Survey, which is carried out between the national censuses by Statistics South Africa.

Using R, for each country in our sample, we used pubicly available shapefiles detailing the cartographic boundaries of sub-national administration divisions. This allowed us to plot an empty map for each country, which we then filled using the data on the proportion of international migrant population in each administrative region. The complete R scripts are available in this repository, as well as the datasets and shapefiles we used. In the case of the datasets, data manipulation had to be carried considering the shapefiles are not uniformly organized and linkages had to established between their classification of the administrative regions and that of our initial datasets.

#### Following is the detailed list of sources for the data and the shapefiles for map elaborated:
- Brazil:
  - Data on international migrant population: Observatorio das Migracoes Internacionais, *Relatorio anual. Dimensoes da Migracao Internacional: Desigualdades, Formalzacao no Mercado de Trabalho e Status Migratòrio*, OBMigra, Brasìlia, 2020, https://portaldeimigracao.mj.gov.br/images/dados/relatorio-anual/2020/OBMigra_RELAT%C3%93RIO_ANUAL_2020.pdf.
  - Shapefile: Humanitarian Data Exchange, "Brazil - Subnational Administrative Boundaries", 2020, https://data.humdata.org/dataset/brazil-administrative-level-0-boundaries.

- Japan:
  - Data on international migrant population: Japanese Minister of Justice, "Statistics on Foreign Residents Registered", 2018, http://www.e-stat.go.jp/SG1/estat/List.do?lid=000001234467. 
  - Shapefile: Humanitarian Data Exchange, "Japan - Subnational Administrative Boundaries", 2019, https://data.humdata.org/dataset/japan-administrative-level-0-2-boundaries?. 

- United Arab Emirates:
  - Data on international migrant population: "United Arab Emirates Population Statistics 2021", Global Media Insight, July 1st, 2021, https://www.globalmediainsight.com/blog/uae-population-statistics/, and Francoise De Bel-Air, "Demography, Migration, and the Labour Market in the UAE", Gulf Research Center: Explanatory Note 7, 2015, pp. 8-9, https://gulfmigration.org/media/pubs/exno/GLMM_EN_2018_01.pdf.
  - Shapefile: Diva-GIS, https://www.diva-gis.org/gdata.

- United States: 
  - Data on international migrant population: Statista Research Department, "Percentage of foreign-born population, by state U.S. 2019", Statista, September 20th, 2021, https://www.statista.com/statistics/312701/percentage-of-population-foreign-born-in-the-us-by-state/. 
  - Shapefile: United States Census Bureau, "Cartographic Boundary Files - Shapefile", 2018, https://www.census.gov/geographies/mapping-files/time-series/geo/carto-boundary-file.html.
    - Specific folder downloaded is located under "States": cb_2018_us_state_500k.zip, https://www2.census.gov/geo/tiger/GENZ2018/shp/cb_2018_us_state_500k.zip. 

- South Africa:
  - Data on international migrant population: Africa Check, "FACTSHEET: Where do South Africa's international migrants come from?", Africa Check, August 16th, 2016, https://africacheck.org/fact-checks/factsheets/factsheet-where-do-south-africas-international-migrants-come. 
  - Shapefile: Humanitarian Data Exchange, "South Africa - Subnational Administrative Boundaries", 2020, https://data.humdata.org/dataset/south-africa-admin-level-1-boundaries.
 
- Switzerland: 
  - Data on international migrant population: Bundesamt für Statistik. ‘Karte: Ständige ausländische Wohnbevölkerung, 2020 [Politische Gemeinden]’, Bundesamt für Statistik (BFS), https://www.atlas.bfs.admin.ch/maps/13/de/16228_90_89_70/25239.html.
  - Shapefile: Database of Global Administrative Areas, https://www.gadm.org/download_country_v3.html. [Search for Switzerland, specific level downloaded was "Shapefile"]
   
