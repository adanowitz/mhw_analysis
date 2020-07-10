library(dplyr)
library(tidyr)
Sys.setenv(MHW_HOME = "~/mhw_analysis/")
Sys.setenv(SURVEYH = "table_struct/survey_headers.csv")

mhw.survey.process <-function(path){

    data <- load.raw(path)
    
    data <- analysis.kessler(data)
    data <- analysis.phq.depr(data)
    data <- analysis.phq.panic(data)
    data <- analysis.phq.other(data)
    data <- analysis.phq.eating(data)
    data <- analysis.pcptsd(data)

    return(data)
}
