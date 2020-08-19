#Meditation Data

#needed libraries
library(tidyverse)
library(car)
library(dplyr)

#reading and adding a new variable called yoga which indicates if they practice mindfulness
post_covid <- read.csv("C:/Users/Jeean/Documents/JeanSchoolWork/NSF Mental Health Research/postCovidDataWScreenings.csv")
post_covid$yoga <- recode(post_covid$uid, "c('11655898077','11652710102','11574162829','11653277531','11574317810','11652738868',
                          '11655959116','11574243208','11680965599','11574384866','11577194338', '11585705882', '11579891465', '11580532024',
                          '11573714759', '11574727613', '11584618382', '11635457233', '11653277531', '11574130744', '11577813273',
                          '11578558666', '11574122644', '11574073090', '11574153488', '11579426192', '11579822919', '11576524437', '11574071245', '11579699563')='1'; else = '0'")

#demographics of mindfulness practice (numbers and percentages)
#students that do not practice mindfulness
post_covid_no_yoga <- post_covid %>% 
  filter(post_covid$yoga == 0)
post_covid_no_yoga %>% 
  group_by(gender) %>% 
  summarise( percent = 100 * n() / nrow(post_covid_no_yoga) )
post_covid_no_yoga %>% 
  group_by(race) %>% 
  summarise( percent = 100 * n() / nrow(post_covid_no_yoga) )
post_covid_no_yoga %>% 
  group_by(sexuality) %>% 
  summarise( percent = 100 * n() / nrow(post_covid_no_yoga) )

#students that do practice mindfulness
post_covid %>% 
  filter(post_covid$yoga == 1) %>% 
  count(gender)
post_covid_yoga <- post_covid %>% 
  filter(post_covid$yoga == 1)
post_covid_yoga %>% 
  group_by( gender ) %>% 
  summarise( percent = 100 * n() / nrow(post_covid_yoga) )

post_covid %>% 
  filter(post_covid$yoga == 1) %>% 
  count(race)
post_covid_yoga %>% 
  group_by(race) %>% 
  summarise( percent = 100 * n() / nrow(post_covid_yoga) )

post_covid %>% 
  filter(post_covid$yoga == 1) %>% 
  count(sexuality)
post_covid_yoga %>% 
  group_by(sexuality) %>% 
  summarise( percent = 100 * n() / nrow(post_covid_yoga) )

#mean and sd of kessler1 score for the meditation practice group vs no practice group
group_by(post_covid, post_covid$yoga) %>% 
  summarise(
    count = n(),
    mean = mean(kessler1, na.rm = TRUE),
    sd = sd(kessler1, na.rm = TRUE)
)

#ANOVA test for yoga groups being associated with kessler1
#H0: There is no difference between students that do meditation practices vs those that do in terms of kessler1
#Ha: There is a difference between students that do mediation practices vs those that do in terms of kessler1
# -> fail to reject H0 (p-val = 0.4)
anova_kessler1<- aov(kessler1 ~ post_covid$yoga, data = post_covid)
summary(anova_kessler1)

# -> reject H0 with a p-value of 0.0105 
anova_kessler2<- aov(kessler2 ~ post_covid$yoga, data = post_covid)
summary(anova_kessler2)

# -> reject H0 with a p-value of 0.0321
anova_kessler4<- aov(kessler4 ~ post_covid$yoga, data = post_covid)
summary(anova_kessler4)

# -> reject H0 with a p-value of 0.00563
anova_kesslertrt<- aov(kessler_treatment ~ post_covid$yoga, data = post_covid)
summary(anova_kesslertrt)

# -> reject H0 with a p-value of 0.0053
anova_phq2b<- aov(phq_2b ~ post_covid$yoga, data = post_covid)
summary(anova_phq2b)

# -> reject H0 with a p-value of 0.0247
anova_phq2h<- aov(phq_2h ~ post_covid$yoga, data = post_covid)
summary(anova_phq2h)

# -> reject H0 with a p-value of 0.0102
anova_phq2i<- aov(phq_2i ~ post_covid$yoga, data = post_covid)
summary(anova_phq2i)

# -> reject H0 with a p-value of 0.0189
anova_phq3d<- aov(phq_3d ~ post_covid$yoga, data = post_covid)
summary(anova_phq3d)

# -> reject H0 with a p-value of 0.017
anova_phq4c<- aov(phq_4c ~ post_covid$yoga, data = post_covid)
summary(anova_phq4c)

# -> reject H0 with a p-value of 0.0424
anova_phq4e<- aov(phq_4e ~ post_covid$yoga, data = post_covid)
summary(anova_phq4e)

# -> reject H0 with a p-value of 0.0221
anova_phq4f<- aov(phq_4f ~ post_covid$yoga, data = post_covid)
summary(anova_phq4f)

# -> reject H0 with a p-value of 0.00859
anova_phq4g<- aov(phq_4g ~ post_covid$yoga, data = post_covid)
summary(anova_phq4g)

# -> reject H0 with a p-value of 0.00834
anova_phq4h<- aov(phq_4h ~ post_covid$yoga, data = post_covid)
summary(anova_phq4h)

# -> reject H0 with a p-value of 0.0073
anova_phq4i<- aov(phq_4i ~ post_covid$yoga, data = post_covid)
summary(anova_phq4i)

# -> reject H0 with a p-value of 0.0309
anova_phq4j<- aov(phq_4j ~ post_covid$yoga, data = post_covid)
summary(anova_phq4j)

# -> reject H0 with a p-value of 0.0255
anova_phq4k<- aov(phq_4k ~ post_covid$yoga, data = post_covid)
summary(anova_phq4k)

# -> reject H0 with a p-value of 0.0205
anova_phq7a<- aov(phq_7a ~ post_covid$yoga, data = post_covid)
summary(anova_phq7a)

# -> reject H0 with a p-value of 0.0319
anova_phq7c<- aov(phq_7c ~ post_covid$yoga, data = post_covid)
summary(anova_phq7c)

# -> reject H0 with a p-value of 0.0428
anova_phq7d<- aov(phq_7d ~ post_covid$yoga, data = post_covid)
summary(anova_phq7d)

# -> reject H0 with a p-value of 0.0445
anova_phq8<- aov(phq_8 ~ post_covid$yoga, data = post_covid)
summary(anova_phq8)

# -> reject H0 with a p-value of 0.0213
anova_pcptsd_1<- aov(pcptsd_1 ~ post_covid$yoga, data = post_covid)
summary(anova_pcptsd_1)

# -> all ANOVA tests: those that practice meditation had lower mental health scores
