coag_inpt_labs <- as.Date(coag_inpt_labs$Result.Test.Date)

lab_variable <- 'APTT'
variable_labs <- coag_inpt_labs[coag_inpt_labs$Short.Text == lab_variable,]
labs_coag <- merge(variable_labs, coag_patient_summary, by.x='Patient.NRIC', by.y='patient_id', all.x=TRUE)
labs_coag$days_since_test <- as.numeric(labs_coag$date - labs_coag$severe_date)
labs_coag$days_since_admission <- as.numeric(labs_coag$date - labs_coag$admission_date)
labs_coag <- labs_coag[labs_coag$days_since_admission >= 0,]

coag_plot_all <- labs_coag %>% group_by(days_since_test,severe) %>% summarize(mean_coag = mean(Test.Value), sd_coag=sd(Test.Value)) %>% ungroup()
coag_plot_all <- coag_plot_all[coag_plot_all$severe == 1,]

coag_plot_all$sd_coag[is.na(coag_plot_all$sd_coag)] <- mean(coag_plot_all$sd_coag, na.rm=TRUE)

coag_plot <- ggplot(coag_plot_all,
  aes(x=days_since_test, y=mean_coag)) + geom_point(), geom_smooth(method='loess'), theme(legend.position='right') + labs(x='Days from severe event', y=lab_variable)

print(coag_plot)
