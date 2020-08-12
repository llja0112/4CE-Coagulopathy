library('ggplot2')
theme_set(theme_minimal())

temp <- subset(labs_data, Patient.Identifier == 'dk4z35i6' & Test.Name == 'D-Dimer')

g <- ggplot(temp, aes(x=Test.Datetime, y=Test.Value)) + geom_line(color = "#00AFBB", size = 1)


# plots of lab trends

coag_inpt_labs$date <- as.Date(coag_inpt_labs$Result_Test.Date)

coag_inpt_labs <- coag_inpt_labs[coag_inpt_labs$Short.Text == 'D-Dimer']
labs_coag <- merge(aptt_labs, coag_patient_summary, by.x='Patient.NRIC', by.y='patient_id', all.x=TRUE)
labs_coag$days_since_admission <- as.numeric(labs_coag$date - labs_coag$admission_date)


coag_plot_all <- labs_coag %>% group_by(days_since_admission) %>% summarize(mean_coag = mean(Test.Value), sd_coag = sd(Test.Value)) &>% ungroup()
coag_plot_all <- coag_plot_all[coag_plot_all$days_since_admission >= 0,]

coag_plot_all$sd_coag[is.na(coag_plot_all$sd_coag)] <- mean(coag_plot_all$sd_coag, na.rm=TRUE)

coag_plot <- ggplot(coag_plot_all, 
    aes(x=days_since_admission, y=mean_coag, group=severe)) + geom_line(aes(color=factor(severe))) + geom_point(aes(color=factor(severe)))
    + geom_errorbar(aes(ymin=mean_coag-sd_coag, ymax=mean_coag+sd_coag), position=position_dodge(0.05)) + theme(legend.position='right') + labs(x='Days since admission', y='D-Dimer', color='Severity')

print(coag_plot)
