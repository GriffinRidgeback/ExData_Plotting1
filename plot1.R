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
png("plot1.png")
with(ret, hist(Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)"))
dev.off()