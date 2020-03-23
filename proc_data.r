

mhw.results.summarize <- function(data){
  race_gender <- with(data, aggregate(list(kessler_major=kessler_major, kessler_moderate=kessler_moderate, dep_major=dep_major, dep_other=dep_other, panic=panic, other_anxiety=other_anxiety,bulimia=bulimia,bin_eat=bin_eat,ptsd=ptsd),list(race=race, gender=gender), mean, na.rm=TRUE))

  race_gender_filtered<-filter_all(.tbl=race_gender,.vars_predicate=all_vars(!is.nan(.) & .!=1))

  #write.csv(x=cp_race_gender_filtered, file="~/mhw_analysis/calpoly_data/cp_race_gender.csv", row.names=FALSE)

  gender_sex <- with(data, aggregate(list(kessler_major=kessler_major, kessler_moderate=kessler_moderate, dep_major=dep_major, dep_other=dep_other, panic=panic, other_anxiety=other_anxiety,bulimia=bulimia,bin_eat=bin_eat,ptsd=ptsd),list(gender=gender, sexuality=sexuality), mean, na.rm=TRUE))

  gender_sex_filtered <- filter_all(.tbl=gender_sex,.vars_predicate=all_vars(!is.nan(.) & .!=1))

  #write.csv(x=cp_gender_sex_filtered, file="~/mhw_analysis/calpoly_data/cp_gender_sex.csv", row.names=FALSE)
  
  return(list(rg=race_gender, rgf=race_gender_filtered, gs=gender_sex, gsf=gender_sex_filtered))
}