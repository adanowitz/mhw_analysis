parse.kessler <- function(data){

    kesscore <- data.frame(likert = c("All of the time","Most of the time","Some of the time","A little of the time","None of the time"), value=c(1,2,3,4,5),stringsAsFactors = FALSE)
    #Grab the kessler 6 headings
    kessler_headers <- kessnames <- grep("_", grep("kessler", names(cpdata), value=TRUE), invert = TRUE, value = TRUE)

    #Copy the relevant kesler rows for manipulation
    #kesslerdata <- data[kessler_headers]

    data <- parse.likert(data=data, header_names=kessler_headers,
                         likert_map=kesscore)
    #data[kessler_headers] <- kesslerdata %>%
    #    pivot_longer(cols = kessler_headers,names_to = "kessler",
    #                 values_to="likert") %>%
    #    left_join(kesscore, by = "likert") %>%
    #    mutate(likert=value) %>%
    #    select(-value) %>%
    #    pivot_wider(names_from = "kessler", values_from="likert",
    #                values_fn = list(likert = list)) %>%
    #    unnest(cols=kessler_headers)

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
