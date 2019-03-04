library(tidyverse)
library(ggplot2); theme_set(theme_minimal())
library(magrittr)
library(here)
library(foreign)
library(haven)
anes2016<-read.dta("https://github.com/sdschutt13/data/raw/master/anes2016.dta")
d<-anes2016
d%<>%select(V161116, V161118, V161120, V161117, V161119, V161121, V161122, V161123, V161124, V161125, V160001, V161511, V161342,
            V161345, V161310x, V161267x, V161265x, V161270, V161274a, V161276x, V161326, V161361x, V161158x)
d%<>%rename(angerD=V161116, afraidD=V161118, disgustD=V161120, hopefulD=V161117, proudD=V161119, angerR=V161121, 
            hopefulR=V161122, afraidR=V161123, proudR=V161124, disgustR=V161125, id=V160001, sexuality=V161511, gender=V161342, 
            femin=V161345, race=V161310x, age=V161267x, relig=V161265x, educ=V161270, military=V161274a, employ=V161276x, 
            internet=V161326, income=V161361x, pid7pt=V161158x
            )

anes2016anx<-d

save(anes2016anx, file = here("data/anes2016anx.Rdata"))
