library('ggplot2')
theme_set(theme_minimal())

temp <- subset(labs_data, Patient.Identifier == 'dk4z35i6' & Test.Name == 'D-Dimer')

g <- ggplot(temp, aes(x=Test.Datetime, y=Test.Value)) + geom_line(color = "#00AFBB", size = 1)
