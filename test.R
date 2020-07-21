library('tidyverse')

# process to clean data
process_data <- function(x){
  x <- gsub(' ', '', x)
  if(substring(x, 0, 1) == '<'){
    x <- 0
  }
  x <- gsub('>', '', x)
  x <- as.numeric(x)
  if(is.na(x)){
    return(0)
  }else{
    return(x)
  }
}

labs_data <- read.csv('sample/labs_data.csv')

# clean test value data
temp <- lapply(labs_data$Test.Value, process_data)
temp <- as.numeric(paste(temp))
labs_data$Test.Value <- temp

# clean test value date time
labs_data$Test.Datetime <- as.POSIXct(labs_data$Test.Datetime, tz='', format='%d/%m/%y %H:%M')
