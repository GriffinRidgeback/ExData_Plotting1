# Section One ----
dataFile <- "./data/household_power_consumption.txt"

conn <- file(dataFile, open = "rt")

x <- TRUE

while (x)
{
    # explain this thoroughly
    x <- !grepl("31/1/2007;23:59:00", readLines(conn, n=1))
}

ret <- read.table(conn, header = F, na.strings = "?", sep = ";", nrows = 2880) 

close(conn)


# Section Two ----
colnames(ret) <- colnames(read.table(dataFile, header = T, nrows = 1, sep = ";"))

# Section Three ----
results <-paste(ret$Date, ret$Time, collapse = NULL, sep = ' ')
ret$datetime <- strptime(results, format = "%d/%m/%Y  %H:%M:%S")

png("plot3.png")
with(ret, plot(Sub_metering_1, type = "n", ylab = "Energy sub metering"))
with(ret, lines(datetime, Sub_metering_1, ylab = "Energy sub metering"))
lines(ret$Sub_metering_1)
lines(ret$Sub_metering_2, col = "red")
lines(ret$Sub_metering_3, col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = names(ret)[7:9])

# have to add the write statements?
dev.off()