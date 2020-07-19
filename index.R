library('dplyr')

data <- read.csv('sample/data.csv')
labs_data <- read.csv('sample/labs_data.csv')

# Create 
PT_summary_data <- labs_data %>%
	filter(Test.Name == 'Prothrombin Time') %>%
	group_by(Patient.Identifier) %>%
	summarise(mean_PT = mean(Test.Value), min_PT = min(Test.Value), max_PT = max(Test.Value))

APTT_summary_data <- labs_data %>%
	filter(Test.Name == 'Activated Partial Thromboplastin Time') %>%
	group_by(Patient.Identifier) %>%
	summarise(mean_APTT = mean(Test.Value), min_APTT = min(Test.Value), max_APTT = max(Test.Value))

DDimer_summary_data <- labs_data %>%
	filter(Test.Name == 'D-Dimer') %>%
	group_by(Patient.Identifier) %>%
	summarise(mean_DDimer = mean(Test.Value), min_DDimer = min(Test.Value), max_DDimer = max(Test.Value))

fibrinogen_summary_data <- labs_data %>%
	filter(Test.Name == 'Fibrinogen') %>%
	group_by(Patient.Identifier) %>%
	summarise(mean_fibrinogen = mean(Test.Value), min_fibrinogen = min(Test.Value), max_fibrinogen = max(Test.Value))

data = merge(data, PT_summary_data, by='Patient.Identifier')
data = merge(data, APTT_summary_data, by='Patient.Identifier')
data = merge(data, DDimer_summary_data, by='Patient.Identifier')
data = merge(data, fibrinogen_summary_data, by='Patient.Identifier')

