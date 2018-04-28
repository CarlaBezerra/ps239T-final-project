#PS39T Final Project
# Code by Carla de Paiva Bezerra

## Data Analysis: Regression model
## INCOMPLETE: I could not correctly specify the model for it to work on 
# plm the package.

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

### 2. Regression Models

#Loading specific libraries
library(plm)
library(dplyr)
library(tidyr)
library(ggplot2)
library(ggthemes)
library(tidyverse)


# Load Final data set
PBfinal<-read.csv("C:/Users/Carla/Desktop/ps239T-final-project/Data/04_PBfinal")


#1. Creating variables for the analysis

#For the complete model specication please see: https://www.spadap.com/app/download/8877410668/The%20Diffusion%20of%20Democratic%20Innovations_2015.pdf?t=1467719346

#For explanations of how the variables were identified in the original dataset
# check the file: "Regression_variables.txt"

#h1 and h4 - Political variables

#PT presence
PBfinal$partyelected <- ifelse(!is.na(PBfinal$Party_MostVoted2r), 
                               as.character(PBfinal$Party_MostVoted2r), 
                               as.character(PBfinal$Party_MostVoted1r))

PBfinal$PTwin <- ifelse(PBfinal$partyelected == "PT", 1, 0) 

#Mayor Vulnerability
#Ratio runnerup/winner votes
PBfinal$mayorvul1r <- PBfinal$Votes_2ndVoted1r/PBfinal$Votes_MostVoted1r

PBfinal$mayorvul2r <- PBfinal$Votes_2ndVoted2r/PBfinal$Votes_MostVoted2r  

PBfinal$mayorvul <- ifelse(!is.na(PBfinal$mayorvul2r), 
                               as.numeric(PBfinal$mayorvul2r), 
                               as.numeric(PBfinal$mayorvul1r))

#Continuity of the Party
# I would have to group information by municipality, I am still working on
#how to create such variable.

#Seats on City council controlled by Mayor
# I did not collect information to calculate thepercentage of city council
#seats controlled by the mayor's party

#Continuity of the Mayor
# I did not collect information to calculate the continuity of the mayor 
#(Mayor's name)



#h2 Proximity variables
#I will not be able to analyze this group of variables.

#Euclidean distance
# A function to calculate the euclidean distance would be something like:
#eucdist <- function(x, y) {
#        distance <- sqrt(sum((x - y) ^ 2))
#        return(distance)
#        }
#But having latitude and longitude points in a curve plan, I was checking on
#how to use the McSpatial Distance and its geodistance function. In any case,
#it was not clear to me on how to generate a table in wich each municipalitie
#would have its minimal distance to each other (n=!500). That is not how the 
#dataset of spada is organized. I guess he has only the info for the closest city.

#h3 Economic variables

#Tax share of revenues
PBfinal$Taxshare.revenues <- PBfinal$TaxImposto.Revenue/PBfinal$Budget.Revenue

PBfinal$financ.viability <- PBfinal$Budget.Expenditures/PBfinal$Budget.Revenue

hist(PBfinal$financ.viability)

##My hypothesis for h3

# Capital investiment expenditures

hist(log(PBfinal$Invest.Capital.Expenditures))

# Capital investiment expenditures ratio over total expenditures
PBfinal$RatioInvestExpend <- PBfinal$Invest.Capital.Expenditures/PBfinal$Budget.Expenditures
hist(PBfinal$RatioInvestExpend)


#Creating index for plm package


####INCOMPLETE HERE#######
##I could not correctly specify the model for it to work on the package.

PLM <- pdata.frame(PBfinal, index=c("PB","year"), drop.index=TRUE, row.names=TRUE)


#### 2. Models for adoption and survival

#Model 1 (Spada econ var) Fixed effects
Model1 <- plm(formula = PB ~ PTwin + mayorvul + Taxshare.revenues + financ.viability + year,
          data = PBfinal, model = "within", index = c("PB","year"))

#Model 1 (Spada econ var) Pooled OLS
plm(formula = pb ~ PTwin + mayorvul + Taxshare.revenues + financ.viability + year,
    data = PBfinal, model = "pooled")


#Models 2 (My econ var capital)
plm(formula = pb ~ PTwin + mayorvul + Taxshare.revenues + financ.viability
    + log(Invest.Capital.Expenditures)
    , data = PBfinal, model = "within")

plm(formula = pb ~ PTwin + mayorvul + log(Invest.Capital.Expenditures)
    , data = PBfinal, model = "pooled")

#Model 3 (My econ var ratio capital)
plm(formula = pb ~ PTwin + mayorvul + Taxshare.revenues + financ.viability
    + RatioInvestExpend, data = PBfinal, model = "within")

plm(formula = pb ~ PTwin + mayorvul + RatioInvestExpend,
    data = PBfinal, model = "pooled")



