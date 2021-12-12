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
  - Data on international migrant population:  
