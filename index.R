library('dplyr')

data <- read.csv('sample/data.csv')
labs_data <- read.csv('sample/labs_data.csv')

labs_data <- subset(labs_data, Short.Text == 'Prothrombin Time' | Short.Text == 'Activated Partial Thromboplastin Time' | Short.Text == 'D-Dimer' | Short.Text == 'Fibrinogen')

# ---
# Comment out this section of the code if your test value is
# already cleaned and in the double format.
# ---

process_data <- function(x){
	x <- gsub(' ', '', x)
	x <- gsub('>', '', x)
	if(substring(x, 0, 1) == '<'){
		x <- 0
	}
	x <- as.numeric(x)
	if(is.na(x)){
		return(0)
	}else{
		return(x)
	}
}

temp <- lapply(labs_data$Test.Value, process_data)
temp <- as.numeric(paste(temp))
labs_data$Test.Value = temp

# ---
# End of code section
# ---

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

coag_patient_summary = patient_summary[patient_summary$patient_id %in% unique(labs_data$Patient.Identifier)]

data <- merge(coag_patient_summary, PT_summary_data, by.x='patient_id', by.y='Patient.Identifier', all.x=TRUE)
data <- merge(data, APTT_summary_data, by.x='patient_id', by.y='Patient.Identifier', all.x=TRUE)
data <- merge(data, DDimer_summary_data, by.x='patient_id', by.y='Patient.Identifier', all.x=TRUE)
data <- merge(data, fibrinogen_summary_data, by.x='patient_id', by.y='Patient.Identifier', all.x=TRUE)
