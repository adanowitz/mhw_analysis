# libraries needed to run the following code
library(tidyverse)
library(car)
library(dplyr)


## reading in data

# reads in the csv file
survey_data <- read.csv("C:/Users/Jeean/Documents/Jean School Work/
                        NSF Mental Health Research/survey_data_all_college.csv")
# attach to ease calling variables, and save in local workspace
attach(survey_data)

# creating a new "believe that will graduate" with 2 categories - agree/strongly agree vs. everything else; 1 = agree, else 0.
survey_data$new_belief <- recode(belief_in_grad, "c('5 (strongly agree)','4')='1'; else = '0'")


## summary statistics

#shows the number of kessler_major responses by type
survey_data %>% 
  count(kessler_major)
# shows the number of new_belief responses by type
survey_data %>% 
  count(new_belief)
# shows the number of belief_in_grad responses by type
survey_data %>% 
  count(belief_in_grad)


## Logistic regression model, modeling probability (agree will graduate in engineering)

# put in individual factors to find which were significant
results <- glm(survey_data$new_belief~type, family = binomial(link="logit"))
# to see result summary: model and p-values
summary(results)
# we interpret the coefficients of the model as exp(coef) which tells us the odds that student agrees they will graduate in eng.
# vs. not agree, comparing those in public schools to those in private schools (reference group)
# so this function calculates the odds ratio
exp(coef(results))
# for a 95% confidence interval for the odds ratio
require(MASS)
exp(cbind(coef(results), confint(results))) 

# adding kessler_major to model
# tried putting assocaited factors together in the regression to see if there was a raise in R^2 values
results <- glm(survey_data$new_belief~type + as.factor(kessler_major), family = binomial(link="logit"))
summary(results)
exp(cbind(coef(results), confint(results))) 

# finds the r^2 value for the models
with(summary(results6), 1 - deviance/null.deviance)

# regression model with all the significant predictors
sig_results <- glm(survey_data$new_belief~ kessler_major + mhw_in_treatment + dep_other + other_anxiety, family = binomial(link="logit"))
summary(sig_results)
exp(cbind(coef(sig_results), confint(sig_results)))
