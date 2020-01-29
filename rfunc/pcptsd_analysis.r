analysis.pcptsd <- function(data){
    data <- parse.pcptsd(data)
    ptsd_headers <- grep("pcptsd", names(data), value=TRUE)
    
    
    data <- data %>% mutate(
        ptsd = if_else(rowSums(data[ptsd_headers])>=3,1,0)
    )
    
}
