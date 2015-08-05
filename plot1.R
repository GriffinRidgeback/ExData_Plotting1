conn <- file("./data/household_power_consumption.txt", open="rt")
x <- TRUE
while (x)
{
    # explain this thoroughly
    x <- !grepl("31/1/2007;23:59:00", readLines(conn, n=1))
}

ret <- read.table(conn, header = F, na.strings = "?", sep = ";", nrows = 2880) 

close(conn)

a  <- read.table("./data/household_power_consumption.txt", header = T, nrows = 1, sep = ";")
colnames(ret) <- colnames(a)

with(ret, hist(Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)"))

# have to add the write statements?

# Plot 2
# need to get the xlabel correct
with(ret, plot(Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)"))



