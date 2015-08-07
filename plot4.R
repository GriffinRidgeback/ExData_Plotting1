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

colnames(ret) <- colnames(read.table(dataFile, header = T, nrows = 1, sep = ";"))
# Section Three ----
results <-paste(ret$Date, ret$Time, collapse = NULL, sep = ' ')
ret$datetime <- strptime(results, format = "%d/%m/%Y  %H:%M:%S")

old_par <- par(no.readonly = T)

png( "plot4.png")
par(mfcol = c(2, 2))

# r1, c1
with(ret, plot(datetime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power"))

# r2, c1
with(ret, plot(datetime, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering"))
lines(ret$datetime, ret$Sub_metering_2, col = "red")
lines(ret$datetime, ret$Sub_metering_3, col = "blue")
legend("topright", lty = 1, bty = "n", col = c("black", "red", "blue"), legend = names(ret)[7:9])

# r1, c2
with(ret, plot(datetime, Voltage, type = "l", ylab = "Voltage", xlab = "datetime"))

# r2, c2
with(ret, plot(datetime, Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime"))

# have to add the write statements?
dev.off()

# Section Six ----
par(old_par)