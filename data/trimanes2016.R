library(tidyverse)
library(ggplot2); theme_set(theme_minimal())
library(magrittr)
library(here)
library(foreign)
library(haven)
anes2016<-read_dta("https://github.com/sdschutt13/data/raw/master/anes2016.dta")
d<-anes2016
d%<>%select(V161116, V161118, V161120, V161117, V161119, V161121, V161122, V161123, V161124, V161125, V160001, V161511, V161342,
            V161345, V161310x, V161267x, V161265x, V161270, V161274a, V161276x, V161326, V161361x, V161158x)
d%<>%rename(angD=V161116, afrD=V161118, disD=V161120, hopeD=V161117, proD=V161119, angR=V161121, 
            hopeR=V161122, afr=V161123, pro=V161124, disR=V161125, id=V160001, sexuality=V161511, gender=V161342, 
            femin=V161345, race=V161310x, age=V161267x, relig=V161265x, educ=V161270, military=V161274a, employ=V161276x, 
            internet=V161326, income=V161361x, pid7pt=V161158x
            )
anes2016anx<-d

d$pid7pt<-as.numeric(d$pid7pt)
##Turning haven to numeric code for Democrats
d$angerD<-as.numeric(d$angD)
d$afraidD<-as.numeric(d$afrD)
d$disgustD<-as.numeric(d$disD)
d$hopefulD<-as.numeric(d$hopelD)
d$proudD<-as.numeric(d$proD)

##Turning haven to numeric code for Republicans
d$angerR<-as.numeric(d$angR)
d$afraidR<-as.numeric(d$afrR)
d$disgustR<-as.numeric(d$disR)
d$hopefulR<-as.numeric(d$hopeR)
d$proudR<-as.numeric(d$proR)

##Turning hvaen to numeric code for demographics
d$race<-as.numeric(d$race)
d$age<-as.numeric(d$age)
d$income<-as.numeric(d$income)
d$military<-as.numeric(d$military)
d$gender<-as.numeric(d$gender)
d$sexuality<-as.numeric(d$sexuality)
d$femin<-as.numeric(d$femin)
d$relig<-as.numeric(d$relig)
d$educ<-as.numeric(d$educ)
d$employ<-as.numeric(d$employ)
d$internet<-as.numeric(d$internet)


##Creating indicators for Anxiety and Enthusiasm

d<-mutate(d, anxietyD = ((angerD+ afraidD+ disgustD)/3)) #Creates Indicator for Respondent's Anxiety for the Democratic Candidate
d<-mutate(d, anxietyR = ((angerR + afraidR + disgustR)/3)) #Creates Indicator for Respondent's Anxiety for the Republican Candidate
d<-mutate(d, enthD = ((proudD + hopefulD)/2)) #Creates Indicator for Respondent's Enthusiasm for the Democratic Candidate
d<-mutate(d, enthR = ((proudR + hopefulR)/2)) #Creates Indicator for Respondent's Enthusiasm for the Republican Candidate


d%<>%filter(anxietyD>0, anxietyR>0, enthD>0, enthR>0, pid7pt>0)#clears out non-responses

d%<>%mutate(pid3pt = ifelse(d$pid7pt%in%c(1, 2, 3), "Dem", "Rep"))#creates 3 point party id variable
d%<>%mutate(pid3pt = ifelse(d$pid7pt%in%c(4),"Ind", pid3pt))#creates label for indep

d%<>%mutate(anxietyCo = ifelse(d$pid3pt=="Dem", anxietyD, anxietyR))#Set anxiety for co partisans for Dems/Reps unidimension scale (70 anxiety for Clinton by Dem=70 Anxiety for Trump by rep)
d%<>%mutate(anxietyCo = ifelse(d$pid3pt=="Ind", NA, anxietyCo))#Sets Independent anxiety NA for copartisans so na.omit rids

d%<>%mutate(anxietyAnti = ifelse(d$pid3pt=="Dem", anxietyR, anxietyD))
d%<>%mutate(anxietyAnti = ifelse(d$pid3pt=="Ind", NA, anxietyAnti))

d%<>%mutate(enthCo = ifelse(d$pid3pt=="Dem", enthD, enthR))
d%<>%mutate(enthCo = ifelse(d$pid3pt=="Ind", NA, enthCo))

d%<>%mutate(enthAnti = ifelse(d$pid3pt=="Dem", enthR, enthD))
d%<>%mutate(enthAnti = ifelse(d$pid3pt=="Ind", NA, enthAnti))

save(anes2016anx, file = here("data/anes2016anx.Rdata"))
