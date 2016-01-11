#
# plot4.R
# Active Power, Voltage, Sub Metering and Re-active Power Consumption
#

# Takes an output file location and constructs a set of plots per the instructions/format of part 4 
# assignment #1 of the first week of the exploratory data analysis course.
# note - this is quick and dirty. Assumes that you have downloaded the zip file and extracted it
# to a data directory.  Please adjust the txtfile location as per your own requirements.

makePlot4 <- function(outfile) {
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
  
  # set the required grid for display of the four data views
  par(mfcol=c(2,2))

  #do the first graph, which is a copy of the 2nd plot
  plot(wrk_data$Timestamp, wrk_data$GlobalActivePower, type="l",
       xlab="", ylab="Global Active Power")
  
  #Do the second plot for this exercise , which is a copy of the third plot for the assignment 
  plot(wrk_data$Timestamp, wrk_data$Submetering1, type="n", xlab="",
       ylab="Energy sub metering")
  points(wrk_data$Timestamp, wrk_data$Submetering1, type="l", col="black")
  points(wrk_data$Timestamp, wrk_data$Submetering2, type="l", col="red")
  points(wrk_data$Timestamp, wrk_data$Submetering3, type="l", col="blue")
  legend("topright", col=c("black", "red", "blue"), lty=c(1,1,1), bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  

  #do the third plot for the assignment - voltage over time
  plot(wrk_data$Timestamp, wrk_data$Voltage, type="l",
       xlab="datetime", ylab="Voltage")
  
# do the fourth plot for the assignment - reactive power over time
  plot(wrk_data$Timestamp, wrk_data$GlobalReactivePower, type="l",
       xlab="datetime", ylab="Global_reactive_power")
  dev.off()
}



