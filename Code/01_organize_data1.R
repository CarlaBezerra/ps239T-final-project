#PS39T Final Project
# Code by Carla de Paiva Bezerra

#Cleaning, organizing and merging data for final dataset
#Step 1: Electoral and Accounting Datasets

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

## 1. Organizing the Mayor Table
#Open all xls ipea political data
mayor1996 <- read_excel("C:/Users/Carla/Desktop/ps239T-final-project/Data/RawData/05_IPEA_TSE_Mayor1996.xls")
mayor2000 <- read_excel("C:/Users/Carla/Desktop/ps239T-final-project/Data/RawData/06_IPEA_TSE_Mayor2000.xls")
mayor2004 <- read_excel("C:/Users/Carla/Desktop/ps239T-final-project/Data/RawData/07_IPEA_TSE_Mayor2004.xls")
mayor2008 <- read_excel ("C:/Users/Carla/Desktop/ps239T-final-project/Data/RawData/08_IPEA_TSE_Mayor2008.xls")

# Create year reference for merging datasets (the electoral dataset is the base line for all further data)
mayor1996 <- mutate(mayor1996, year=1996)
mayor2000 <- mutate(mayor2000, year=2000)
mayor2004 <- mutate(mayor2004, year=2004)
mayor2008 <- mutate(mayor2008, year=2008)


# Renaming columns for merging datasets
mayor1996 <- rename(mayor1996, 
                    state = "Sigla",
                    codeipea = "Codigo",
                    Munic = "Município",
                    Party_MostVoted1r = "Partido do candidato a prefeito mais votado no primeiro turno (1996)",
                    Party_2ndVoted1r = "Partido do segundo candidato a prefeito mais votado no primeiro turno (1996)",
                    Votes_MostVoted1r = "Votação do candidato a prefeito mais votado no primeiro turno (1996)",
                    Votes_2ndVoted1r = "Votação do segundo candidato a prefeito mais votado no primeiro turno (1996)",
                    Party_MostVoted2r = "Partido do candidato a prefeito mais votado no segundo turno (1996)",
                    Party_2ndVoted2r = "Partido do segundo candidato a prefeito mais votado no segundo turno (1996)",
                    Votes_MostVoted2r = "Votação do candidato a prefeito mais votado no segundo turno (1996)",
                    Votes_2ndVoted2r = "Votação do segundo candidato a prefeito mais votado no segundo turno (1996)",
                    NCandidatesMayor = "Número de candidatos votados - prefeito (1996)",
                    NPartiesMayor = "Número de partidos votados - prefeito (1996)")

                    
mayor2000 <- rename(mayor2000, 
                    state = "Sigla",
                    codeipea = "Codigo",
                    Munic = "Município",
                    Party_MostVoted1r = "Partido do candidato a prefeito mais votado no primeiro turno (2000)",
                    Party_2ndVoted1r = "Partido do segundo candidato a prefeito mais votado no primeiro turno (2000)",
                    Votes_MostVoted1r = "Votação do candidato a prefeito mais votado no primeiro turno (2000)",
                    Votes_2ndVoted1r = "Votação do segundo candidato a prefeito mais votado no primeiro turno (2000)",
                    Party_MostVoted2r = "Partido do candidato a prefeito mais votado no segundo turno (2000)",
                    Party_2ndVoted2r = "Partido do segundo candidato a prefeito mais votado no segundo turno (2000)",
                    Votes_MostVoted2r = "Votação do candidato a prefeito mais votado no segundo turno (2000)",
                    Votes_2ndVoted2r = "Votação do segundo candidato a prefeito mais votado no segundo turno (2000)",
                    NCandidatesMayor = "Número de candidatos votados - prefeito (2000)",
                    NPartiesMayor = "Número de partidos votados - prefeito (2000)")


mayor2004 <- rename(mayor2004, 
                    state = "Sigla",
                    codeipea = "Codigo",
                    Munic = "Município",
                    Party_MostVoted1r = "Partido do candidato a prefeito mais votado no primeiro turno (2004)",
                    Party_2ndVoted1r = "Partido do segundo candidato a prefeito mais votado no primeiro turno (2004)",
                    Votes_MostVoted1r = "Votação do candidato a prefeito mais votado no primeiro turno (2004)",
                    Votes_2ndVoted1r = "Votação do segundo candidato a prefeito mais votado no primeiro turno (2004)",
                    Party_MostVoted2r = "Partido do candidato a prefeito mais votado no segundo turno (2004)",
                    Party_2ndVoted2r = "Partido do segundo candidato a prefeito mais votado no segundo turno (2004)",
                    Votes_MostVoted2r = "Votação do candidato a prefeito mais votado no segundo turno (2004)",
                    Votes_2ndVoted2r = "Votação do segundo candidato a prefeito mais votado no segundo turno (2004)",
                    NCandidatesMayor = "Número de candidatos votados - prefeito (2004)",
                    NPartiesMayor = "Número de partidos votados - prefeito (2004)")


mayor2008 <- rename(mayor2008, 
                    state = "Sigla",
                    codeipea = "Codigo",
                    Munic = "Município",
                    Party_MostVoted1r = "Partido do candidato a prefeito mais votado no primeiro turno (2008)",
                    Party_2ndVoted1r = "Partido do segundo candidato a prefeito mais votado no primeiro turno (2008)",
                    Votes_MostVoted1r = "Votação do candidato a prefeito mais votado no primeiro turno (2008)",
                    Votes_2ndVoted1r = "Votação do segundo candidato a prefeito mais votado no primeiro turno (2008)",
                    Party_MostVoted2r = "Partido do candidato a prefeito mais votado no segundo turno (2008)",
                    Party_2ndVoted2r = "Partido do segundo candidato a prefeito mais votado no segundo turno (2008)",
                    Votes_MostVoted2r = "Votação do candidato a prefeito mais votado no segundo turno (2008)",
                    Votes_2ndVoted2r = "Votação do segundo candidato a prefeito mais votado no segundo turno (2008)",
                    NCandidatesMayor = "Número de candidatos votados - prefeito (2008)",
                    NPartiesMayor = "Número de partidos votados - prefeito (2008)")

#Merging datasets
Mayor1 <- union(mayor1996, mayor2000)
Mayor2 <- union(mayor2004, mayor2008)
Mayor <- union(Mayor1, Mayor2)

# Free memory space
rm(mayor1996, mayor2000, mayor2004, mayor2008, Mayor1, Mayor2)

#Saving File
write.csv(Mayor, file = "01_Mayor1996-2008")


###2. Organizing accounting tables

#Open all xls ipea accounting expenditure data

expend1995 <- read_excel ("C:/Users/Carla/Desktop/ps239T-final-project/Data/RawData/09_IPEA_STN_expenditures1995.xls")
expend1999 <- read_excel ("C:/Users/Carla/Desktop/ps239T-final-project/Data/RawData/11_IPEA_STN_expenditures1999.xls")
expend2003 <- read_excel ("C:/Users/Carla/Desktop/ps239T-final-project/Data/RawData/13_IPEA_STN_expenditures2003.xls")
expend2007 <- read_excel ("C:/Users/Carla/Desktop/ps239T-final-project/Data/RawData/15_IPEA_STN_expenditures2007.xls")
expend2011 <- read_excel ("C:/Users/Carla/Desktop/ps239T-final-project/Data/RawData/17_IPEA_STN_expenditures2011.xls")


# Create year reference for merging datasets
# I am creating two variables: refyear stands for the measured accounting year. Thea year
# variable is to adjust with the other period reference we use in our data set. For the 
#period 1996-2000, the mayor and party data are set by the elections that is, 1996. 
# For measuring his avaible budget, I am using the 3rd term year as a reference, which would
#be 1999 in the example. Such choice is justified for usually its a moment where policies such as PB
# are more consolidated in a given adminsitration and do not fall into budgetary restrictions of the
# the electoral years. A better choice would be to use all years and make an average, but I
#did not have the time for it.
# For avoiding incongruence, I set everything having as a reference the begining fo the term.

expend1995 <- mutate(expend1995, refyear = 1995, year = 1992)
expend1999 <- mutate(expend1999, refyear = 1999, year = 1996)
expend2003 <- mutate(expend2003, refyear = 2003, year = 2000)
expend2007 <- mutate(expend2007, refyear = 2007, year = 2004)
expend2011 <- mutate(expend2011, refyear = 2011, year = 2008)

#Creating a commom reference for merging

expend1995 <- unite(expend1995, mergingcolumn, Sigla, Codigo, Município, refyear, year, sep="_")
expend1999 <- unite(expend1999, mergingcolumn, Sigla, Codigo, Município, refyear, year, sep="_")
expend2003 <- unite(expend2003, mergingcolumn, Sigla, Codigo, Município, refyear, year, sep="_")
expend2007 <- unite(expend2007, mergingcolumn, Sigla, Codigo, Município, refyear, year, sep="_")
expend2011 <- unite(expend2011, mergingcolumn, Sigla, Codigo, Município, refyear, year, sep="_")


#Open all xls ipea accounting revenues data

rev1995 <- read_excel("C:/Users/Carla/Desktop/ps239T-final-project/Data/RawData/18_IPEA_STN_revenues1995.xls")
rev1999 <- read_excel("C:/Users/Carla/Desktop/ps239T-final-project/Data/RawData/20_IPEA_STN_revenues1999.xls")
rev2003 <- read_excel("C:/Users/Carla/Desktop/ps239T-final-project/Data/RawData/21_IPEA_STN_revenues2003.xls")
rev2007 <- read_excel("C:/Users/Carla/Desktop/ps239T-final-project/Data/RawData/23_IPEA_STN_revenues2007.xls")
rev2011 <- read_excel("C:/Users/Carla/Desktop/ps239T-final-project/Data/RawData/25_IPEA_STN_revenues2011.xls")

##Create year reference for merging datasets (see explanation of the two variables year and refyear above)

rev1995 <- mutate(rev1995, refyear = 1995, year = 1992)
rev1999 <- mutate(rev1999, refyear = 1999, year = 1996)
rev2003 <- mutate(rev2003, refyear = 2003, year = 2000)
rev2007 <- mutate(rev2007, refyear = 2007, year = 2004)
rev2011 <- mutate(rev2011, refyear = 2011, year = 2008)

#Creating a commom reference for merging
rev1995 <- unite(rev1995, mergingcolumn, Sigla, Codigo, Município, refyear, year, sep="_")
rev1999 <- unite(rev1999, mergingcolumn, Sigla, Codigo, Município, refyear, year, sep="_")
rev2003 <- unite(rev2003, mergingcolumn, Sigla, Codigo, Município, refyear, year, sep="_")
rev2007 <- unite(rev2007, mergingcolumn, Sigla, Codigo, Município, refyear, year, sep="_")
rev2011 <- unite(rev2011, mergingcolumn, Sigla, Codigo, Município, refyear, year, sep="_")

#Merging datasets
Balance1995 <- left_join(rev1995, expend1995, by = "mergingcolumn")
Balance1999 <- left_join(rev1999, expend1999, by = "mergingcolumn")
Balance2003 <- left_join(rev2003, expend2003, by = "mergingcolumn")
Balance2007 <- left_join(rev2007, expend2007, by = "mergingcolumn")
Balance2011 <- left_join(rev2011, expend2011, by = "mergingcolumn")

# Free memory space
rm(rev1995, expend1995, rev1999, expend1999, rev2003, expend2003,
   rev2007, expend2007, rev2011, expend2011)

#Renaming columns for merging dataset years

Balance1995 <- rename (Balance1995,
                       Budget.Revenue = "Receita orçamentária - municipal (1995)",
                       Other.Current_Revenue = "Receita corrente - outras - municipal (1995)",
                       Current.Revenue = "Receita corrente - municipal (1995)",
                       AllTax.Revenue = "Receita tributária - municipal (1995)",
                       Capital.Revenue = "Receita de capital - municipal (1995)",
                       Other.Capital.Revenue = "Receitas de capital - outros - municipal (1995)",
                       TaxImposto.Revenue = "Receita tributária - impostos - municipal (1995)",
                       CredOperation.Capital.Revenue = "Receita de capital - operações de crédito - municipal (1995)",
                       Current.Trasnfers.Revenue = "Receita - transferências correntes - municipal (1995)",
                       Capital.Trasnfers.Revenue = "Receita - transferências de capital - municipal (1995)",
                       Other.Current.Expenditures = "Despesa corrente - outras - municipal (1995)",
                       Current.Expenditures = "Despesa corrente - municipal (1995)",
                       Other.Defrayal.Current.Expenditures = "Despesa de custeio - demais - municipal (1995)",
                       Personnel.Defrayal.Current.Expenditures = "Despesa de custeio - pessoal -  municipal (1995)",
                       Defrayal.Current.EXpenditures = "Despesa de custeio - municipal (1995)",
                       Capital.Expenditures = "Despesa de capital - municipal (1995)",
                       Budget.Expenditures = "Despesa orçamentária - municipal (1995)",
                       Invest.Capital.Expenditures = "Despesa de capital - investimento - municipal (1995)",
                       Current.Trasnfers.Expenditures = "Despesa - transferências correntes - municipal (1995)",
                       Capital.Current.Trasnfers.Expenditures = "Despesa - transferências de capital - municipal (1995)")


Balance1999 <- rename (Balance1999,
                       Budget.Revenue = "Receita orçamentária - municipal (1999)",
                       Other.Current_Revenue = "Receita corrente - outras - municipal (1999)",
                       Current.Revenue = "Receita corrente - municipal (1999)",
                       AllTax.Revenue = "Receita tributária - municipal (1999)",
                       Capital.Revenue = "Receita de capital - municipal (1999)",
                       Other.Capital.Revenue = "Receitas de capital - outros - municipal (1999)",
                       TaxImposto.Revenue = "Receita tributária - impostos - municipal (1999)",
                       CredOperation.Capital.Revenue = "Receita de capital - operações de crédito - municipal (1999)",
                       Current.Trasnfers.Revenue = "Receita - transferências correntes - municipal (1999)",
                       Capital.Trasnfers.Revenue = "Receita - transferências de capital - municipal (1999)",
                       Other.Current.Expenditures = "Despesa corrente - outras - municipal (1999)",
                       Current.Expenditures = "Despesa corrente - municipal (1999)",
                       Other.Defrayal.Current.Expenditures = "Despesa de custeio - demais - municipal (1999)",
                       Personnel.Defrayal.Current.Expenditures = "Despesa de custeio - pessoal -  municipal (1999)",
                       Defrayal.Current.EXpenditures = "Despesa de custeio - municipal (1999)",
                       Capital.Expenditures = "Despesa de capital - municipal (1999)",
                       Budget.Expenditures = "Despesa orçamentária - municipal (1999)",
                       Invest.Capital.Expenditures = "Despesa de capital - investimento - municipal (1999)",
                       Current.Trasnfers.Expenditures = "Despesa - transferências correntes - municipal (1999)",
                       Capital.Current.Trasnfers.Expenditures = "Despesa - transferências de capital - municipal (1999)")

Balance2003 <- rename (Balance2003,
                       Budget.Revenue = "Receita orçamentária - municipal (2003)",
                       Other.Current_Revenue = "Receita corrente - outras - municipal (2003)",
                       Current.Revenue = "Receita corrente - municipal (2003)",
                       AllTax.Revenue = "Receita tributária - municipal (2003)",
                       Capital.Revenue = "Receita de capital - municipal (2003)",
                       Other.Capital.Revenue = "Receitas de capital - outros - municipal (2003)",
                       TaxImposto.Revenue = "Receita tributária - impostos - municipal (2003)",
                       CredOperation.Capital.Revenue = "Receita de capital - operações de crédito - municipal (2003)",
                       Current.Trasnfers.Revenue = "Receita - transferências correntes - municipal (2003)",
                       Capital.Trasnfers.Revenue = "Receita - transferências de capital - municipal (2003)",
                       Other.Current.Expenditures = "Despesa corrente - outras - municipal (2003)",
                       Current.Expenditures = "Despesa corrente - municipal (2003)",
                       Other.Defrayal.Current.Expenditures = "Despesa de custeio - demais - municipal (2003)",
                       Personnel.Defrayal.Current.Expenditures = "Despesa de custeio - pessoal -  municipal (2003)",
                       Defrayal.Current.EXpenditures = "Despesa de custeio - municipal (2003)",
                       Capital.Expenditures = "Despesa de capital - municipal (2003)",
                       Budget.Expenditures = "Despesa orçamentária - municipal (2003)",
                       Invest.Capital.Expenditures = "Despesa de capital - investimento - municipal (2003)",
                       Current.Trasnfers.Expenditures = "Despesa - transferências correntes - municipal (2003)",
                       Capital.Current.Trasnfers.Expenditures = "Despesa - transferências de capital - municipal (2003)")


Balance2007 <- rename (Balance2007,
                       Budget.Revenue = "Receita orçamentária - municipal (2007)",
                       Other.Current_Revenue = "Receita corrente - outras - municipal (2007)",
                       Current.Revenue = "Receita corrente - municipal (2007)",
                       AllTax.Revenue = "Receita tributária - municipal (2007)",
                       Capital.Revenue = "Receita de capital - municipal (2007)",
                       Other.Capital.Revenue = "Receitas de capital - outros - municipal (2007)",
                       TaxImposto.Revenue = "Receita tributária - impostos - municipal (2007)",
                       CredOperation.Capital.Revenue = "Receita de capital - operações de crédito - municipal (2007)",
                       Current.Trasnfers.Revenue = "Receita - transferências correntes - municipal (2007)",
                       Capital.Trasnfers.Revenue = "Receita - transferências de capital - municipal (2007)",
                       Other.Current.Expenditures = "Despesa corrente - outras - municipal (2007)",
                       Current.Expenditures = "Despesa corrente - municipal (2007)",
                       Other.Defrayal.Current.Expenditures = "Despesa de custeio - demais - municipal (2007)",
                       Personnel.Defrayal.Current.Expenditures = "Despesa de custeio - pessoal -  municipal (2007)",
                       Defrayal.Current.EXpenditures = "Despesa de custeio - municipal (2007)",
                       Capital.Expenditures = "Despesa de capital - municipal (2007)",
                       Budget.Expenditures = "Despesa orçamentária - municipal (2007)",
                       Invest.Capital.Expenditures = "Despesa de capital - investimento - municipal (2007)",
                       Current.Trasnfers.Expenditures = "Despesa - transferências correntes - municipal (2007)",
                       Capital.Current.Trasnfers.Expenditures = "Despesa - transferências de capital - municipal (2007)")


Balance2011 <- rename (Balance2011,
                       Budget.Revenue = "Receita orçamentária - municipal (2011)",
                       Other.Current_Revenue = "Receita corrente - outras - municipal (2011)",
                       Current.Revenue = "Receita corrente - municipal (2011)",
                       AllTax.Revenue = "Receita tributária - municipal (2011)",
                       Capital.Revenue = "Receita de capital - municipal (2011)",
                       Other.Capital.Revenue = "Receitas de capital - outros - municipal (2011)",
                       TaxImposto.Revenue = "Receita tributária - impostos - municipal (2011)",
                       CredOperation.Capital.Revenue = "Receita de capital - operações de crédito - municipal (2011)",
                       Current.Trasnfers.Revenue = "Receita - transferências correntes - municipal (2011)",
                       Capital.Trasnfers.Revenue = "Receita - transferências de capital - municipal (2011)",
                       Other.Current.Expenditures = "Despesa corrente - outras - municipal (2011)",
                       Current.Expenditures = "Despesa corrente - municipal (2011)",
                       Other.Defrayal.Current.Expenditures = "Despesa de custeio - demais - municipal (2011)",
                       Personnel.Defrayal.Current.Expenditures = "Despesa de custeio - pessoal -  municipal (2011)",
                       Defrayal.Current.EXpenditures = "Despesa de custeio - municipal (2011)",
                       Capital.Expenditures = "Despesa de capital - municipal (2011)",
                       Budget.Expenditures = "Despesa orçamentária - municipal (2011)",
                       Invest.Capital.Expenditures = "Despesa de capital - investimento - municipal (2011)",
                       Current.Trasnfers.Expenditures = "Despesa - transferências correntes - municipal (2011)",
                       Capital.Current.Trasnfers.Expenditures = "Despesa - transferências de capital - municipal (2011)")

#Merging datasets
Balance1 <- union(Balance1995, Balance1999)
Balance2 <- union(Balance2003, Balance2007)
Balance3 <- union(Balance2011, Balance1)

Balance <- union(Balance2, Balance3)

#Free memory space
rm(Balance1995, Balance1999, Balance2003, Balance2007,
   Balance2011, Balance1, Balance2, Balance3)

#Split mergingColumn
Balance<- separate(Balance, mergingcolumn, c("state", "codeipea", "Munic", "refyear", "year"), sep = "_")

#Saving File
write.csv(Balance, file = "02_Balance1995-2011")


################################END OF FILE#######################################
