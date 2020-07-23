library('statmod')

# Adjust the adverse outcome here
# For this study, we are defining adverse outcome as death, ICU stay, mechanical ventilation, inotropic medications or ARDS
data$outcome = data$Death | data$ICU.Stay
data$outcome = data$outcome | data$Mechanical.Ventilation
# data$outcome = data$outcome | data$Inotropic.Medications
# data$outcome = data$outcome | data$Acute.Respiratory.Distress.Syndrome

isth_model <- glm(severe ~ sex + max_PT + max_APTT + max_DDimer + min_fibrinogen + ddimer_ratio + fibrinogen_ratio, family='binomial')
general_model <- glm(severe ~ sex + mean_PT + mean_APTT + mean_DDimer + mean_fibrinogen + ddimer_ratio + fibrinogen_ratio, family='binomial')
ratio_model <- glm(severe ~ sex + ddimer_ratio + fibrinogen_ratio, family='binomial')
