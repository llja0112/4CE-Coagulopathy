library('glm2')

# Adjust the adverse outcome here
# For this study, we are defining adverse outcome as death, ICU stay, mechanical ventilation, inotropic medications or ARDS
data$outcome = data$Death | data$ICU.Stay
data$outcome = data$outcome | data$Mechanical.Ventilation
# data$outcome = data$outcome | data$Inotropic.Medications
# data$outcome = data$outcome | data$Acute.Respiratory.Distress.Syndrome


print('Adverse event model')
model <- glm(outcome ~ Age + Gender + Thrombotic.Event + Bleeding.Event + fibrinogen_ratio + ddimer_ratio + Anticoagulation.Medications + Lopinavir.rotinavir, data = data, family = "binomial")
print(model)
print('')

print('Death model')
model <- glm(Death ~ Age + Gender + Thrombotic.Event + Bleeding.Event + fibrinogen_ratio + ddimer_ratio + Anticoagulation.Medications + Lopinavir.rotinavir, data = data, family = "binomial")
print(model)
print('')

print('Mechanical Ventilation model')
model <- glm(Mechanical.Ventilation ~ Age + Gender + Thrombotic.Event + Bleeding.Event + fibrinogen_ratio + ddimer_ratio + Anticoagulation.Medications + Lopinavir.rotinavir, data = data, family = "binomial")
print(model)
print('')

print('Inotropic Medications')
model <- glm(Inotropic.Medications ~ Age + Gender + Thrombotic.Event + Bleeding.Event + fibrinogen_ratio + ddimer_ratio + Anticoagulation.Medications + Lopinavir.rotinavir, data = data, family = "binomial")
print(model)
print('')

print('Acute Respiratory Distress Syndrome')
model <- glm(Acute.Respiratory.Distress.Syndrome ~ Age + Gender + Thrombotic.Event + Bleeding.Event + fibrinogen_ratio + ddimer_ratio + Anticoagulation.Medications + Lopinavir.rotinavir, data = data, family = "binomial")
print(model)
print('')

