corr <- function(directory, threshold = 0) {
	## 'directory' is a character vector of length 1 indicating
	## the location of the CSV files
	
	## 'threshold' is a numeric vector of length 1 indicating the
	## number of completely observed observations (on all
	## variables) required to compute the correlation between
	## nitrate and sulfate; the default is 0
	
	## Return a numeric vector of correlations
	## NOTE: Do not round the result!
	
	if (!exists("complete", mode="function")) source("complete.R")
	
	dir <- complete(directory)
	sel <- dir[dir[,"nobs"]>threshold,]
	rpt <- vector("numeric")
	
	oldDir <- getwd()
	setwd(directory)
	if (length(sel[,"nobs"]) > 0) {	
		files <- substrRight(paste0("00", sel$ID, ".csv"), 7)
		#print(length(sel[,"nobs"]))
		for (i in files) {
			data <- read.csv(i)
			ok <- complete.cases(data)
			good <- data[ok,]
			rpt <- append(rpt, as.vector(cor(good$sulfate, good$nitrate)))
		}
	}
	setwd(oldDir)
	return(rpt)
}