read.multi.line.header <- function(path, header.lines = 2, sep = ","){

  header <- read.csv(path, nrows = 2, header=FALSE)
  header_names <- sapply(header,paste,collapse="_")
  data <- read.table(path, skip = header.lines, header = FALSE, sep = sep)

  base::names(data) <- header_names

  return(data)
}
