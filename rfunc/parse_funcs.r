parse.var.yes_no <- data.frame(likert = c("Yes", "No"),
                     value=c(1,0),stringsAsFactors=FALSE)
parse.var.not_sev_mohalf_ned <- data.frame(likert = c("Not at all", "Several days",
                                    "More than half the days",
                                    "Nearly every day"),
                                    value=c(0,0,1,1),stringsAsFactors=FALSE)
parse.var.not_sev_mohalf <- data.frame(likert = c("Not at all", "Several Days",
                                                      "More than half the days"),
                                           value=c(0,0,1),stringsAsFactors=FALSE)
parse.phq.other_anx <- function(data){
    lmap <- parse.var.not_sev_mohalf
    
    other_headers <- grep("phq_5", names(data),value=TRUE)
    
    data <- parse.likert(data=data, header_names = other_headers, likert_map = lmap)
    
    return(data)
}
parse.phq.panic <- function(data){
    
    yes_no <- parse.var.yes_no
    panic_headers <- c(grep("phq_3", names(data),value=TRUE), grep("phq_4", names(data),value=TRUE))
    
    data <- parse.likert(data=data,header_names=panic_headers, likert_map=yes_no)
    
    return(data)
}
parse.phq.dep <- function(data){
    atoh_score <- parse.var.not_sev_mohalf_ned
    
    i_score <- data.frame(likert = c("Not at all", "Several Days",
                                        "More than half the days",
                                        "Nearly every day"),
                          value=c(0,1,1,1),stringsAsFactors=FALSE)

    dep_headers <- grep("phq_2", names(data),value=TRUE)
    
    data <- parse.likert(data=data, header_names=dep_headers[1:8],
                         likert_map=atoh_score)
    data <- parse.likert(data=data, header_names=dep_headers[9],
                         likert_map=i_score)
    
    return(data)
}
parse.kessler <- function(data){

    kesscore <- data.frame(likert = c("All of the time","Most of the time","Some of the time","A little of the time","None of the time"), value=c(4,3,2,1,0),stringsAsFactors = FALSE)
    #Grab the kessler 6 headings
    kessler_headers <- kessnames <- grep("_", grep("kessler", names(data), value=TRUE), invert = TRUE, value = TRUE)

    #Copy the relevant kesler rows for manipulation
    #kesslerdata <- data[kessler_headers]

    data <- parse.likert(data=data, header_names=kessler_headers,
                         likert_map=kesscore)

    return(data)
}

parse.likert <- function(data, header_names, likert_map){
    likertdata <- data[header_names]
    
    data[header_names] <- likertdata %>%
        pivot_longer(cols = header_names,names_to = "lscale",
                     values_to="likert") %>%
        left_join(likert_map, by = "likert") %>%
        mutate(likert=value) %>%
        select(-value) %>%
        pivot_wider(names_from = "lscale", values_from="likert",
                    values_fn = list(likert = list)) %>%
        unnest(cols=header_names)
    return(data)
}
