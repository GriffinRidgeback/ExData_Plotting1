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

# Section Four ----
# with(ret, plot(Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)"))
with(ret, plot(datetime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)"))

# have to add the write statements?
dev.copy(png, "plot2.png")
dev.off()