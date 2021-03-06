coag_inpt_labs$date <- as.Date(coag_inpt_labs$Result_Test.Date)

# Possible lab variables: APTT, PT, Fibrinogen, Platelets, D-Dimer
# Change lab variable assignment to trend different parameters according to days of admission
lab_variable <- 'APTT'
variable_labs <- coag_inpt_labs[coag_inpt_labs$Short.Text == lab_variable,]
labs_coag <- merge(variable_labs, coag_patient_summary, by.x='Patient.NRIC', by.y='patient_id', all.x=TRUE)
labs_coag$days_since_admission <- as.numeric(labs_coag$date - labs_coag$admission_date)

coag_plot_all <- labs_coag %>% group_by(days_since_admission) %>% summarize(mean_coag = mean(Test.Value), sd_coag = sd(Test.Value)) &>% ungroup()
coag_plot_all <- coag_plot_all[coag_plot_all$days_since_admission >= 0,]

coag_plot_all$sd_coag[is.na(coag_plot_all$sd_coag)] <- mean(coag_plot_all$sd_coag, na.rm=TRUE)

coag_plot <- ggplot(coag_plot_all,
    aes(x=days_since_admission, y=mean_coag, group=severe)) + geom_point(aes(color=factor(severe))) + geom_smooth(aes(color=factor(severe)), method='loess') + theme(legend.position='right') + labs(x='Days since admission', y=lab_variable, color='Severity')

print(coag_plot)
