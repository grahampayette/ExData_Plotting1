#
# plot4.R
# Active Power, Voltage, Sub Metering and Re-active Power Consumption
#
#
# Takes an output file location and constructs a set of plots per the instructions/format of part 4 
# assignment #1 of the first week of the exploratory data analysis course.
# note - this is quick and dirty. Assumes that you have downloaded the zip file and extracted it
# to a data directory.  Please adjust the txtfile location as per your own requirements.

makePlot4 <- function(outfile) {
   png(filename = outfile, width = 480, height=480)
 
  txtFile <- "./data/household_power_consumption.txt"
  

  allData <- read.table(txtFile, header = TRUE, sep=";", na.strings="?",
                        col.names = c("Date", "Time", "GlobalActivePower",
                                      "GlobalReactivePower", "Voltage", "GlobalIntensity",
                                      "Submetering1", "Submetering2", "Submetering3"),
                        colClasses = c( "character", "character", "numeric",
                                        "numeric", "numeric", "numeric", "numeric",
                                        "numeric", "numeric"))
  wrk_data <<- with(subset(allData, Date == "1/2/2007" | Date == "2/2/2007"),
                    data.frame(Timestamp = strptime(paste(Date, Time),
                                                    format="%d/%m/%Y %H:%M:%S"),
                               GlobalActivePower, GlobalReactivePower, Voltage,
                               GlobalIntensity, Submetering1, Submetering2,
                               Submetering3)) 
  
  # set up a 2x2 grid
  par(mfcol=c(2,2))
  # just plot2 again!
  plot(wrk_data$Timestamp, wrk_data$GlobalActivePower, type="l",
       xlab="", ylab="Global Active Power")
  # and plot 3 again
  plot(wrk_data$Timestamp, wrk_data$Submetering1, type="n", xlab="",
       ylab="Energy sub metering")
  points(wrk_data$Timestamp, wrk_data$Submetering1, type="l", col="black")
  points(wrk_data$Timestamp, wrk_data$Submetering2, type="l", col="red")
  points(wrk_data$Timestamp, wrk_data$Submetering3, type="l", col="blue")
  legend("topright", col=c("black", "red", "blue"), lty=c(1,1,1), bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  

  plot(wrk_data$Timestamp, wrk_data$Voltage, type="l",
       xlab="datetime", ylab="Voltage")
  

  plot(wrk_data$Timestamp, wrk_data$GlobalReactivePower, type="l",
       xlab="datetime", ylab="Global_reactive_power")
  dev.off()
}



