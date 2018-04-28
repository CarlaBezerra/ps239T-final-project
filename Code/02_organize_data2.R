#PS39T Final Project
# Code by Carla de Paiva Bezerra

#Cleaning, organizing and merging data for final dataset
#Step 2: Remaining Datasets

#Clean memory
rm(list=ls(all=TRUE))
gc()

#Working directory
#setwd("C:/Users/Carla/Desktop/ps239T-final-project/")
#I tried to set a working directory, but it read te files:
#> mayor1996 <- read_excel("~/Data/02_IPEADATA/ipeadata1996.xls")
#Error in read_fun(path = path, sheet = sheet, limits = limits, shim = shim,  : 
# Evaluation error:
# path[1]="C:/Users/Carla/Documents/Data/02_IPEADATA/ipeadata1996.xls": 
# The system cannot find the path specified.


#Packages
library(dplyr)
library(tidyr)
library(readxl)


###3. Organizing PB, Demographic and Geographic tables
GDP <- read_excel("C:/Users/Carla/Desktop/ps239T-final-project/Data/RawData/04_IPEA_IBGE_PIBMunic_1996-2017.xls")
Location <- read_excel("C:/Users/Carla/Desktop/ps239T-final-project/Data/RawData/02_IPEA_IBGE_ latitude_longitude1998.xls")
Population <- read_excel("C:/Users/Carla/Desktop/ps239T-final-project/Data/RawData/03_IPEA_IBGE_PopulacaoMunic_1992-2017.xls")
PBdata <- read_excel("C:/Users/Carla/Desktop/ps239T-final-project/Data/RawData/01_Participedia_Spada_PBcensus1989-2012.xlsx")

# Reorganizing Data

Location <- Location %>%
          rename(Latitude = "Latitude para os municípios da divisão político administrativa vigente em 2000 (1998)",
                 Longitude = "Longitude para os municípios da divisão político administrativa vigente em 2000 (1998)")%>%
          mutate("1989" = Latitude,
                 "1992" = Latitude,
                 "1996" = Latitude,
                 "2000" = Latitude,
                 "2004" = Latitude,
                 "2008" = Latitude)%>%
          select(-Latitude)%>%
          gather( year, Latitude, 5:10)%>%
          rename(codeipea = Codigo) %>%
          select(-Sigla, - Município) %>%  
          unite(code_year, codeipea, year, sep="_")

GDP <- GDP%>%
      gather(year, gdp, 4:16)%>%
      rename(codeipea = Codigo) %>%
      select(-Sigla, - Município) %>%  
      unite(code_year, codeipea, year, sep="_")

#The year 1996 is missing in population data, so to padronize the comparison, I will
# create a 1996 poplation variable, by an average of 1995 and 1997.

average1996 <- (Population$"1995" + Population$"1997")/2
                      
Population <- Population %>%
      mutate("1996" = average1996)%>%
      gather(year, population, 4:27)%>%
      rename(codeipea = Codigo) %>%
      select(-Sigla, - Município) %>%  
      unite(code_year, codeipea, year, sep="_")

PBdata <- as.data.frame (PBdata)

# Create year reference for merging datasets
# The replacement of the year value is necessary each dataset has a different
# reference. For the period 1996-2000, the mayor and party data are set by the elections
# that is, 1996. Whereas the PB data, considers the existance of PB in the 3 years before.
# It means that for the mayor elected in 1996, the PB data for 2000. 
# For avoiding incongruence, I set everything havng as a reference the begining fo the term.

PBdata <- PBdata %>%  
  mutate(year=replace(year, year==1992, 1989))%>% 
  mutate(year=replace(year, year==1996, 1992))%>%
  mutate(year=replace(year, year==2000, 1996))%>%
  mutate(year=replace(year, year==2004, 2000))%>%
  mutate(year=replace(year, year==2008, 2004))%>%  
  mutate(year=replace(year, year==2012, 2008))


PBdata <- PBdata %>%  
  select(-region, -statename) %>%
  rename(Munic="name") %>%
  unite(code_year, codeipea, year, sep="_")


##Merging Data

PBLocate <- left_join(PBdata, Location, by = "code_year") 
PopGDP <- left_join(Population, GDP, by = "code_year")
PBDemographics <- left_join(PBLocate, PopGDP, by = "code_year") 

PBDemographics<- separate(PBDemographics, code_year, c("codeipea", "year"), sep = "_")

#Free memory space
rm(GDP, Location, PBdata, PBLocate, PopGDP, Population, average1996)

#Save Daset
write.csv(PBDemographics, file = "03_PBDemographics")


#### 4. Merging subsets for final dataset

Balance <- read.csv("C:/Users/Carla/Desktop/ps239T-final-project/Data/02_Balance1995-2011")
Mayor<- read.csv("C:/Users/Carla/Desktop/ps239T-final-project/Data/01_Mayor1996-2008")
#PBDemographics <- read.csv("C:/Users/Carla/Desktop/ps239T-final-project/Data/03_PBDemographics")

#Organizing the data for merging
Mayor <- Mayor %>%
  select(-X, -Munic, -state) %>%
  unite( code_year, codeipea, year, sep="_")

Balance <- Balance %>%
  select(-X, -Munic, -state) %>%
  unite(code_year, codeipea, year, sep="_")


#Merging
PBfinal <- left_join(PBDemographics, Mayor, by = "code_year")
PBfinal <- left_join(PBfinal, Balance, by = "code_year")

#Spliting back the columns
PBfinal<- separate(PBfinal, code_year, c("codeipea", "year"), sep = "_")

#Removing any special characters and notation
library(stringi)
Mayor$Munic <- stri_trans_general(Mayor$Munic, "Latin-ASCII")

#Free Memory space
rm (Mayor, Balance, PBDemographics)

#Saving file
write.csv(PBfinal, file = "04_PBfinal")


########################END OF FILE #############################################
