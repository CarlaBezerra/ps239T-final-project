#PS39T Final Project
# Code by Carla de Paiva Bezerra

## Data Analysis: Descriptive statistics

#Clean memory
rm(list=ls(all=TRUE))
gc()

#Setting Working directory
#setwd("C:/Users/Carla/Desktop/ps239T-final-project/")
#I tried to set a working directory, but it outputs the error files:
#> mayor1996 <- read_excel("~/Data/02_IPEADATA/ipeadata1996.xls")
#Error in read_fun(path = path, sheet = sheet, limits = limits, shim = shim,  : 
# Evaluation error:
# path[1]="C:/Users/Carla/Documents/Data/02_IPEADATA/ipeadata1996.xls": 
# The system cannot find the path specified.


#. Loading libraries
library(dplyr)
library(tidyr)
library(ggplot2)
library(ggthemes)


# Load Final data set
PBfinal<-read.csv("C:/Users/Carla/Desktop/ps239T-final-project/Data/04_PBfinal")
#PBDemo <-read.csv("C:/Users/Carla/Desktop/ps239T-final-project/Data/03_PBDemographics")

#1. Descriptive Statistics

#A. PB per year

#Setting dataframe for frequency analysis
PByear <- PBfinal[c("year", "PB")] %>%
  filter (PB == 1) %>%
  group_by(year) %>%
  summarise_all(funs(n = sum(!is.na(.))))

#The dataset for 2012-2016 was in a separated set, in which I only found later.
#I will switch for using the full dataset as soon as possible.
PB2012 <- c(2012,58)
PByear <-rbind(PByear, PB2012)

##PB evolution plot

yearplot <- ggplot(data = PByear, aes(x = year, y = n)) +
  geom_line(color = "#BA4A00", size = 2) + geom_point(color = "#BA4A00") +
  theme_fivethirtyeight() + 
  labs(title = "Participatory Budgeting in Brazil 1989-2012",
       caption = "Source: Paolo Spada PB Census", 
       x = "Year", y = "Municipalities") 

print(yearplot)
  
#B. PB per year per party

#Creating Elected party variable
PBfinal$partyelected <- ifelse(!is.na(PBfinal$Party_MostVoted2r), 
                               as.character(PBfinal$Party_MostVoted2r), 
                               as.character(PBfinal$Party_MostVoted1r))

PBparty <- PBfinal[c("year", "PB", "partyelected")] %>%
  filter (PB == 1) %>%
  group_by(year, partyelected) %>%
  summarise_all(funs(n = sum(!is.na(.))))%>%
  filter(!is.na(partyelected))

#Grouping parties with low PB ocurrence for graph readability
#Totalparty <-  PBparty %>%
 # group_by(partyelected) %>% 
  #summarise(n = sum(n))  

index <- PBparty$n<5
PBparty$partyelected[index] <- "other"


PBparty <- PBparty %>%
  group_by(year, partyelected) %>% 
  summarise(n = sum(n))


##PB party evolution plot

partyplot <- ggplot(data = PBparty, aes(x = year, y = n, col= partyelected)) +
             geom_line(size = 2) + geom_point() +
             theme_fivethirtyeight()+ scale_colour_gdocs()+
             theme(legend.position="right", legend.direction = "vertical") +
             scale_colour_gdocs(breaks=c("PT","PSDB","PMDB","PSB", "PDT", "PFL", "other")) +
             labs(title = "Participatory Budgeting in Brazil 1996-2012", subtitle = "PB per party",
                   caption = "Source: IPEAdata and Spada PB Census", 
                   x = "Year", y = "Municipalities", col = "Party")

print(partyplot)

##C. PB per geographical distribution/population 

#Loading specific libraries (thought of using resquest, but was not sure)
library(ggmap)
library(raster)
library(maptools)
library(rgdal)
library(maps)
library(RgoogleMaps)
library(ggthemes)

# Adapting and correcting Latitude and Longitude variables
PBfinal$Longitude <- PBfinal$Longitude*-1
PBfinal$PBLon <- ifelse ((PBfinal$PB!=0),
                        as.numeric(PBfinal$Longitude),
                        is.na(PBfinal$PBLon))

PBfinal$PBLat <- ifelse ((PBfinal$PB!=0),
                        as.numeric(PBfinal$Latitude),
                        is.na(PBfinal$PBLat))

# For using the color as year without being a continuos scale
PBfinal$year <- as.factor(PBfinal$year)


#Ploting the map
#the code was working yesterday and today for some reason, R does not read it.
map <- borders("world", regions = "Brazil", fill = "grey70", colour = "black")

brazil <- ggplot() + mapa +  
  geom_point(data = PBfinal, aes(x = PBLon, y = PBLat, col = year)) +
  theme_minimal()+ scale_colour_gdocs()+
  #theme(panel.border = element_blank(), 
  #      panel.grid.major = element_line(colour = "grey5"), 
   #     panel.grid.minor = element_blank()) +
  labs(title = "Participatory Budgeting in Brazil 1989-2016", subtitle = "Geographical distribution",
     caption = "Source: IPEAdata and Spada PB Census", 
     x = "Longitude (decimals)", y = "Latitude (decimals)", col = "Year")


print(brazil)


## E. PB per population

summary(PBfinal$population)

hist(PBfinal$population)

PBfinal$pop1000 <- PBfinal$population/1000

PBfinal$catpop <- cut(PBfinal$pop1000, c(0,65,100,200,500,10990.249))

table(PBfinal$catpop)
barplotpop <- barplot(table(PBfinal$catpop))

PBpop<- PBfinal[c("year", "PB", "catpop")] %>%
  filter (PB == 1) %>%
  group_by(year, catpop) %>%
  summarise_all(funs(n = sum(!is.na(.))))%>%
  filter(!is.na(catpop))

PBpop$year <- as.factor(PBpop$year)

BarplotPBpop <- ggplot(data = PBpop, aes(x = year, y = n, fill= catpop)) +
               geom_bar(stat = "identity") + 
               theme_bw()+ #scale_color_discrete() +
               labs(title = "PB distribution per population",# subtitle = "PB per population",
               caption = "Source: Spada PB Census", 
               x = "Year", y = "Number of Municipalities", fill = "Population (in 1000")



##E. PB per capital investment availability (gdp, expenditures/revenues ratio,)


#Building ratios

#Current expenditures are mandatory expenditures with maintenance of local government
PBfinal$RatioCurrentExpend <- (PBfinal$Current.Expenditures)/(PBfinal$Budget.Expenditures)

hist1 <- hist(PBfinal$RatioCurrentExpend)


#Capital investmente expenditures are discretionary new investment and buildings done by local city governement.
#That is what is mainly discussed at PB meetings.

PBfinal$RatioInvestExpend <- PBfinal$Invest.Capital.Expenditures/PBfinal$Budget.Expenditures
hist2 <- hist(PBfinal$RatioInvestExpend)


# Tax share of revenues
PBfinal$Taxshare.revenues <- PBfinal$TaxImposto.Revenue/PBfinal$Budget.Revenue

hist3 <- hist(PBfinal$Taxshare.revenues)


#Transfer share of revenues

PBfinal$Transfershare.revenues <- (PBfinal$Capital.Trasnfers.Revenue+PBfinal$Current.Trasnfers.Revenue)/
                                   PBfinal$Budget.Revenue

hist4 <- hist(PBfinal$Transfershare.revenues)

#From the ratios one can see that most municipalities have as main source of income
#federal and state transfers. That is expected by how our fiscal system s designed. 
#Most transfers have compulsory pre-defined use.

#One can also notice that most of the expenditures are the ones directed at the maintenance
#of local governement (salaries, basic bills, ecc). The investment ratio is for most cases
#no more then 20% of most municipalities. 

summary(PBfinal$RatioInvestExpend)

PBfinal$catinvest <- cut(PBfinal$RatioInvestExpend, c(0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1))

barplot(table(PBfinal$catinvest))

PBcapital <- PBfinal[c("year", "PB", "catinvest")] %>%
  filter (PB == 1) %>%
  group_by(year,catinvest) %>%
  summarise_all(funs(n = sum(!is.na(.))))%>%
  filter(!is.na(catinvest))


##PB Ratio of Capital and Budget expenditures evolution plot

Barplotinvest <- ggplot(data = PBcapital, aes(x = year, y = n, fill= catinvest)) +
                 geom_bar(stat = "identity") + #geom_point() +
                 theme_bw()+ scale_colour_gdocs()+
                 scale_colour_gdocs() +
                 labs(title = "Participatory Budgeting in Brazil 1989-2016", subtitle = "Ratio of Investment Expenditures",
                 caption = "Source: Spada PB Census", 
                 x = "Year", y = "Municipalities") + 
                 scale_fill_discrete(name = "% Investment")

#The result of this graph is somewhat against our expectations, for it seems to
#show an increase the Capital Investment rate through the years. But, on the other hand
# we can see that only municipalities with an investment ratio bigger the 0.1 kept
#implementing PB after 2000-2004.


