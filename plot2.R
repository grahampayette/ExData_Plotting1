#
# plot2.R
# Build a histogram of Global Active Power
#

# Takes an output file location and constructs a histogram per the instructions/format of part 2 
# assignment #1 of the first week of the exploratory data analysis course.
# note - this is quick and dirty. Assumes that you have downloaded the zip file and extracted it
# to a data directory.  Please adjust the txtfile location as per your own requirements.

makePlot2 <- function(outfile) {
   png(filename = outfile, width = 480, height=480)
 
  txtFile <- "./data/household_power_consumption.txt"
 
  #read the file, wasn't sure if we were allowed to use any additional librarys so just a basic read
  #taking the "?" in to account 

  allData <- read.table(txtFile, header = TRUE, sep=";", na.strings="?",
                        col.names = c("Date", "Time", "GlobalActivePower",
                                      "GlobalReactivePower", "Voltage", "GlobalIntensity",
                                      "Submetering1", "Submetering2", "Submetering3"),
                        colClasses = c( "character", "character", "numeric",
                                        "numeric", "numeric", "numeric", "numeric",
                                        "numeric", "numeric"))
  
  #filter out the days we want
  wrk_data <<- with(subset(allData, Date == "1/2/2007" | Date == "2/2/2007"),
                    data.frame(Timestamp = strptime(paste(Date, Time),
                                                    format="%d/%m/%Y %H:%M:%S"),
                               GlobalActivePower, GlobalReactivePower, Voltage,
                               GlobalIntensity, Submetering1, Submetering2,
                               Submetering3)) 
   
  #Plot power over time using the line option to connect data points
  plot(wrk_data$Timestamp, wrk_data$GlobalActivePower, type="l",
       xlab="", ylab="Global Active Power (kilowatts)")
  dev.off()
}



