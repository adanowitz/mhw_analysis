#source("./parse_funcs.r")

analysis.kessler <- function(data){
    data<-parse.kessler(data)

    #add for major mental health
    data <- mutate(data,
                   kessler_major =
                       if_else((kessler1+kessler2+kessler3+kessler4+kessler5+
                                kessler6)>=13, 1 , 0))
    data <- mutate(data,
                   kessler_moderate =
                       if_else((kessler1+kessler2+kessler3+kessler4+kessler5+
                                kessler6)>=5 & !kessler_major, 1 , 0))

    return(data)
}
