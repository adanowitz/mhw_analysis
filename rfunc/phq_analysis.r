analysis.phq.major <- function(data){

                                        #Grab phq_2a-2i
    dep_headers <- grep("phq_2", names(data),value=TRUE)

    #Parse the data to replace Likert style scores with 1s if they count and 0s
    #if they don't
    data <- parse.phqdep(data)

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
