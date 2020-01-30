mhw.survey.process <- function(path){

    data <- load.raw(path)
    
    data <- analysis.kessler(data)
    data <- analysis.phq.depr(data)
    data <- analysis.phq.panic(data)
    data <- analysis.phq.other(data)
    data <- analysis.phq.eating(data)
    data <- analysis.pcptsd(data)

    return(data)
}
