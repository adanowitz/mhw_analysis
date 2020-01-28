load.raw <- function(path){

    #grab the data file and delete SurveyMonkey extra columns
    data <- read.csv(path, header = FALSE, skip=2)
    data[c(2:9)] <- list(NULL)
    
                                        #grab the headers
    headpath <- file.path(Sys.getenv("MHW_HOME"), Sys.getenv("SURVEYH"))
    headers <- read.csv(headpath)
                        
    base::names(data) <- base::names(headers)
    
    #Check to ensure that they have a correct year in the program, consented to the survey, and at least started Kessler
    data_cleaned<-subset(data,consent=="Yes, I volunteer" & ((year_in_program == "1") | (year_in_program == "2") | (year_in_program=="Prefer not to respond")) & kessler1!="")

    return(data_cleaned)
}
    
