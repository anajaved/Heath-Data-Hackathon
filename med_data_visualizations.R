
setwd('~/Desktop/faers/ascii')
med_data <- read.csv("DRUG16Q3.txt", sep="$")
outcomes_data <-read.csv("OUTC16Q3.txt", sep="$")
react_data <- read.csv("REAC16Q3.txt", sep="$")
demo_data <- read.csv("DEMO16Q3.txt", sep="$")
library(ggplot2)
library(knitr)
library(dplyr)
library(gridExtra)
library(GGally) 
library(scales)




summary(med_data)
top_6_meds= c("XARELTO", "XYREM", "ENBREL", "REVLIMID", "ASPIRIN","HUMIRA")

#number of faers events by medication
ggplot(aes(x=drugname, fill=role_cod), 
       data=subset(med_data, drugname== c("XARELTO", 
                                          "XYREM", 
                                          "ENBREL", 
                                          "REVLIMID", 
                                          "ASPIRIN",
                                          "HUMIRA"))) +
  geom_bar(stat='count') + 
  theme(axis.text.x = element_text(margin = margin(r =10 , 
                                                   b=10, 
                                                   l=10, 
                                                   t=0), 
                                   angle=90)) +
  scale_fill_brewer(type = "seq", palette = "YlGnBu") + 
  theme_gray() +
  ggtitle("Number of FAERS Events & Role by Medication")

#merging dataframes
total <- merge(med_data, outcomes_data,by="primaryid")
total <- merge(total, react_data,by="primaryid")
total <- merge(total, demo_data, by='primaryid')


summary(subset(total, drugname=="XARELTO" & role_cod=="PS"))

#number of conditions from xarelto
ggplot(aes(x=pt, fill=age_grp), 
       data=subset(total, drugname== "XARELTO" & role_cod=="PS" & pt==c("Gastrointestinal haemorrhage", 
                                                                        "Internal haemorrhage",
                                                                        "Rectal haemorrhage",
                                                                        "Epistaxis",
                                                                        "Upper gastrointestinal haemorrhage",
                                                                        "Haematuria") & !is.na(age_grp))) +
  geom_bar(stat="count") + 
  theme(axis.text.x = element_text(margin = margin(r =10 , 
                                                   b=0, 
                                                   l=10, 
                                                   t=30), 
                                   angle=35)) +
  scale_fill_brewer(type = "seq", palette = "OrRd") + ggtitle("Number conditions caused by Xarelto in Primary Suspect Cases")


