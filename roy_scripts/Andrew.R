# Read the data into R - I saved as excel file, but csv should be fine as well, just need to edit the read function accordingly
survey_data <- read_excel("Dropbox/Work related/Professional development/Consulting Spring 2020/Andrew Danowitz/survey_data.xlsx")

# attach to ease calling variables, and save in local workspace
attach(survey_data)

# the car package helps combine catergories
install.packages("car")
require("car") 

# creating a new "believe that will graduate" with 2 categories - agree/strongly agree vs. everything else; 1 = agree, else 0.
new_belief<- recode(belief_in_grad, "c('5 (strongly agree)','4')='1'; else='0'")

# Logistic regression model, modeling probability (agree will graduate in engineering)
# uses type (private vs. public) as predictor
results <- glm(new_belief~type, family = binomial(link="logit"))

# to see result summary: model and p-values
summary(results)

# because logistric regression uses a logit model to predict probability (agree will graduate in engineering)
# we interpret the coefficients of the model as exp(coef) which tells us the odds that student agrees they will graduate in eng.
# vs. not agree, comparing those in public schools to those in private schools (reference group)
# so this function calculates the odds ratio
exp(coef(results))

# for a 95% confidence interval for the odds ratio
require(MASS)
exp(cbind(coef(results), confint(results)))  

## ================================================
## adding kessler_major to model
results <- glm(new_belief~type + as.factor(kessler_major), family = binomial(link="logit"))
summary(results)
exp(cbind(coef(results), confint(results)))  
