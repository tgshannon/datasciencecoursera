complete <- function(directory, id = 1:332) {
	## 'directory' is a character vector of length 1 indicating
	## the location of the CSV files
	
	## 'id' is an integer vector indicating the monitor ID numbers
	## to be used
	
	## Return a data frame of the form:
	## id nobs
	##  1 117
	##  2 1041
	## ...
	## where 'id' is the monitor ID number and 'nobs' is the
	## number of complete Cases
	
	oldDirectory <- getwd()
	setwd(directory)
	rpt <- data.frame()
	files <- substrRight(paste0("00", id, ".csv"), 7)
	for (i in files) {
		data <- read.csv(i)
		ok <- complete.cases(data)
		good <- data[ok,]
		rpt <- rbind(rpt, c(good$ID[1], length(good$ID)))
	}
	colnames(rpt) <- c("ID", "nobs")
	##rownames(rpt, prefix = "##")
    setwd(oldDirectory)
	return(rpt)
}

substrRight <- function(x, n) {
	substr(x, nchar(x)-n+1, nchar(x))
}