#PS239T Final Project
## Carla de Paiva Bezerra


## 1. Short Description

This is are the results presented for the PS239T Final Project (Introduction To Computational Tools And Techniques For Social Research, at the Department of Political Science, University of California, Berkeley).

The initial proposal was to replicate and improve the model of Spada (2014), in which he aims to explain the causal mechanisms for the initial diffusion and later abandonment of the Participatory Budgeting (PB) in Brazil. 

For the project I was able to rebuild most of the dataset used (01_organize_data1.R and 02_organize_data2.R), as well as to make some basic descriptive analysis of the dataset (03_analysis_descriptive.R). For the main goal, which was to actually run some regression, I began to specify the model,
but it still need further adjustments.


## 2. Dependencies

1. R version 3.4.3 (2017-11-30) -- "Kite-Eating Tree"

## 3. Files

### 3.1. Data

A. Raw Data

1. Spada, P. 2012. "Brazilian Participatory Budgeting Census: 1989-2012." Available at: http://participedia.net/en/content/brazilian-participatory-budgeting-census / Access date: April 20, 2018. (licensed under CC BY-NC-SA 3.0).
00_Spada_05112017_PB CENSUS 2016.xlsx
01_Participedia_Spada_PBcensus1989-2012.xlsx

2. IPEADATA: 
http://www.ipeadata.gov.br
A portal of the Brazilian Government Institute for Applied Economics Research, that puts together several data sources of the Brazilian Governement. The data is downloaded. We accessed the following sources:
- TSE: organized and documented access to the Brazilian Electoral Superior Court data on elections in Brazil from 1998 to 2016.
- MPF/STN: Offical Accounting Data for Brazilian Municipalities (1989-2012). Downloaded anually. Accesse files were convereted to csv.
- IBGE: Brazilian Institute of Geography and Statistics. For demographic variables.
02_IPEA_IBGE_ latitude_longitude1998.xls
03_IPEA_IBGE_PopulacaoMunic_1992-2017.xls
04_IPEA_IBGE_PIBMunic_1996-2017.xls
05_IPEA_TSE_Mayor1996.xls
06_IPEA_TSE_Mayor2000.xls
07_IPEA_TSE_Mayor2004.xls
08_IPEA_TSE_Mayor2008.xls
09_IPEA_STN_expenditures1995.xls
10_IPEA_STN_expenditures1996.xls
11_IPEA_STN_expenditures1999.xls
12_IPEA_STN_expenditures2000.xls
13_IPEA_STN_expenditures2003.xls
14_IPEA_STN_expenditures2004.xls
15_IPEA_STN_expenditures2007.xls
16_ IPEA_STN_expenditures2008.xls
17_IPEA_STN_expenditures2011.xls
18_IPEA_STN_revenues1995.xls
19_IPEA_STN_revenues1996.xls
20_IPEA_STN_revenues1999.xls
21_IPEA_STN_revenues2003.xls
22_IPEA_STN_revenues2004.xls
23_IPEA_STN_revenues2007.xls
24_IPEA_STN_revenues2008.xls
25_IPEA_STN_revenues2011.xls


3. SHAPE FILES:
Brazilian States, Municipalities and Macroregions shape files. From Diogo Ferrari personal website: https://dioferrari.com/2014/11/27/plotting-maps-using-r-example-with-brazilian-municipal-level-data/
regioes_2010.shx
estados_2010.dbf
estados_2010.prj
estados_2010.qpj
estados_2010.shp
estados_2010.shx
municipios_2010.dbf
municipios_2010.prj
municipios_2010.qpj
municipios_2010.shp
municipios_2010.shx
regioes_2010.dbf
regioes_2010.prj
regioes_2010.qpj
regioes_2010.shp


4. FINALDATASET.csv: Four final analysis dataset derived from the raw data above. It includes muncipality-year values for all Brazilian municipalities above 50.0000 inhabintants. The variables are detailes in the "variables.txt".
- 01_Mayor1996-2008.csv
- 02_Balance1995-2011.csv
- 03_PBDemographics.csv
- 04_PBfinal.csv


### 3.2. Code

- 01_organize_data1.R
- 02_organize_data2.R
- 03_analysis_descriptive.R
- 04_regression.R
- Regression_variables.txt


### 4. Results

-01PBperyear.png: Participatory Budgeting (PB) evolution in Brazil per year.
-02PBparty.jpeg: PB evolution in Brazil per party and year.
-03PBgeodistrib.jpeg: PB geodistribution in Brazil per party and year.
-04PBpop.jpeg: Population distribution of municipalities adopting PB per year. 
-05PBInvestment.jpeg: Budget Investment rateof municiplaities adopting PB per year.
-Barplotcatpop: Population distribution of whole sample (categorical). 
-hist1.jpeg: Histogram of the ratio of current over total budget expenditures (whole sample).
-hist2.jpeg: Histogram of the ratio of capital investment over total budget expenditures (whole sample).
-hist3.jpeg: Histogram of the tax share of revenues (whole sample).
-hist4.jpeg: Histogram of the transfer share of revenues (whole sample).




