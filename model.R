library('glm2')

# model <- glm(mmortality ~.,family=binomial(link='logit'),data=train)
data$outcome = data$Death | data$ICU.Stay
data$outcome = data$outcome | data$Mechanical.Ventilation
#data$outcome = data$outcome | data$Inotropic.Medications
#data$outcome = data$outcome | data$Acute.Respiratory.Distress.Syndrome


model <- glm(outcome ~ Age + min_PT + max_PT, data = data, family = "binomial")

