# D-dimer_ratio is defined by [D-dimer (maximum-minimum)]/D-dimer minimum; 
# and fibrinogen_ratio is defined by [fibrinogen (maximum - minimum)]/fibrinogen minimum.

ddimer_ratio <- function(ddimer_max, ddimer_min){
    ddimer_diff <- ddimer_max - ddimer_min
    return(ddimer_diff / ddimer_min)
}

fibrinogen_ratio <- function(fibrinogen_max, fibrinogen_min){
    fibrinogen_diff <- fibrinogen_max - fibrinogen_min
    return(fibrinogen_diff / fibrinogen_min)
}

data$fibrinogen_ratio <- mapply(fibrinogen_ratio, data$max_fibrinogen, data$min_fibrinogen)
data$ddimer_ratio <- mapply(ddimer_ratio, data$max_DDimer, data$min_DDimer)
