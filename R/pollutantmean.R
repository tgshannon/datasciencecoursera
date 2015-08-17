pollutantmean <- function(directory = "specdata", pollutant = "sulfate", id = 1:332) {
	## 'directory' is a character vector of length 1 indicating
	## the location of the CSV files
	
	## 'pollutant' is a character vector of length 1 indicating
	## the name of the pollutant for which we will calculate the
	## mean; either "sulfate" or "nitrate"
	
	## 'id' is an integer  vectory indicating the monitor ID numbers
	## to be used
	
	## Return the mean of the pollutant across all monitors list
	## in the 'id' vector (ignoring NA values)
	## NOTE: Do not round the result!
	
	oldDirectory <- getwd()
	setwd(directory)
	files <- substrRight(paste0("00", id, ".csv"), 7)
	data <- do.call("rbind", lapply(files, read.csv, header = TRUE))
	setwd(oldDirectory)

	print(mean(data[,pollutant], na.rm = TRUE))
	
    #return(data)
}

substrRight <- function(x, n) {
	substr(x, nchar(x)-n+1, nchar(x))
}