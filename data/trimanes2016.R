library(tidyverse)
library(ggplot2); theme_set(theme_minimal())
library(magrittr)
library(here)
library(foreign)
library(haven)
anes2016<-read_dta("https://github.com/sdschutt13/data/raw/master/anes2016.dta")
d<-anes2016
d%<>%select(V161116, V161118, V161120)
d%<>%rename(anger=V161116, afraid=V161118, disgust=V161120)
anes2016anx<-d
save(anes2016anx, file = here("data/anes2016anx.Rdata"))