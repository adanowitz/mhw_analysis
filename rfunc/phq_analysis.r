analysis.phq.depr <- function(data){

                                        #Grab phq_2a-2i
    dep_headers <- grep("phq_2", names(data),value=TRUE)

    #Parse the data to replace Likert style scores with 1s if they count and 0s
    #if they don't
    data <- parse.phq.dep(data)

    data <- mutate(data,
                      dep_major = if_else(
                      (rowSums(data[dep_headers[-1:-2]])>=5) &
                       (rowSums(data[dep_headers[1:2]])>=1), 1,
                      0)
                   )

                   #if_else(
                    #   rowSums(is.na(data[dep_headers[-1:-2]]))>=2 |
                     #      rowSums(is.na(data[dep_headers[1:2]]))==2, NA, 0))
    data <- mutate(data,
                      dep_other = if_else(
                      (rowSums(data[dep_headers[-1:-2]])>=2) &
                       dep_major!=1 &
                       (rowSums(data[dep_headers[1:2]])>=1), 1 ,
                       dep_major)
                   )
    
    return(data)
}

analysis.phq.panic <- function(data){
    data <- parse.phq.panic(data)
    
    panic3_headers <- grep("phq_3", names(data),value=TRUE)
    panic4_headers <- grep("phq_4", names(data),value=TRUE)
    
    data <- data %>% mutate(
        panic = if_else(rowSums(data[panic3_headers])==4 | (data[panic3_headers[1]] & rowSums(data[panic4_headers])>=4), 1, 0)
    )
    
    return(data)
}

analysis.phq.other <- function(data){
    data <- parse.phq.other_anx(data)
    other_headers <- grep("phq_5", names(data),value=TRUE)
    
    data <- data %>% mutate(
        other_anxiety = if_else(data[other_headers[1]] & rowSums(data[other_headers[-1]])>=3, 1, 0)
    )
    
    return(data)
}