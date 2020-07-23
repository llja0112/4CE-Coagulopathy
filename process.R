# D-dimer_ratio is defined by [D-dimer (maximum-minimum)]/D-dimer minimum;
# and fibrinogen_ratio is defined by [fibrinogen (maximum - minimum)]/fibrinogen minimum.

get_ratio <- function(value_max, value_min){
    value_diff <- value_max - value_min
    if(value_min == 0){
      return(NaN)
    }else{
      return(value_diff/value_min)
    }
}

data$ddimer_ratio <- mapply(get_ratio, data$max_DDimer, data$min_DDimer)
data$fibrinogen_ratio <- mapply(get_ratio, data$max_fibrinogen, data$min_fibrinogen)

data$ddimer_ratio[is.na(data$ddimer_ratio)] <- mean(data$ddimer_ratio, na.rm=TRUE)
data$fibrinogen_ratio[is.na(data$fibrinogen_ratio)] <- mean(data$fibrinogen_ratio, na.rm=TRUE)
