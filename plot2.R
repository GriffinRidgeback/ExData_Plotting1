#
# R code for Course Project 1 in the 
# Coursera course "Exploratory Data Analysis"
#
# This file creates plot2.png according to the plot given in the assignment

# Section One: Get the data ----
#
# set the source of the data 
dataFile <- "./data/household_power_consumption.txt"

# create a read-only connection to the text file
connection <- file(dataFile, open = "rt")

# loop control variable
x <- TRUE

# loop until we find the date of interest
while (x)
{
    # read one line at a time until we find the last entry prior
    # to 1/2/2007.  Once this is found, x becomes FALSE and the
    # loop exits.  We need to stop at the entry before the desired
    # date so that read.table will start at the correct date
    x <- !grepl("31/1/2007;23:59:00", readLines(connection, n = 1))
}

# read from the connection (2 days X 24 hours X 60 minutes) of data
# according to the instructions, NAs are represented as ?
# the data is delimited by ;
data <- read.table(connection, header = F, na.strings = "?", sep = ";", nrows = 2880) 

# cleanup
close(connection)

# Section Two: Massage the data ----
#
# read the first line of the file to get the column names for our subset
colnames(data) <- colnames(read.table(dataFile, header = T, nrows = 1, sep = ";"))

# combine the date and time fields into one time series vector
results <-paste(data$Date, data$Time, collapse = NULL, sep = ' ')

# convert the character data to POSIXct data and bind to existing data
data$datetime <- strptime(results, format = "%d/%m/%Y  %H:%M:%S")

# Section Three: Plot the data ----
#
# open the PNG device
png("plot2.png")

# plot
with(data, plot(datetime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)"))

# write
dev.off()