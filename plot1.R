ddir = 'data'

dir.create(ddir, showWarnings = FALSE, recursive = TRUE)

fileURL = 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'

zfile = 'household_power_consumption.zip'
zpath = file.path(ddir, zfile)
tfile = 'household_power_consumption.txt'
tpath = file.path(ddir, tfile)

if (!file.exists(zpath))
  download.file(fileURL, destfile = zpath)
if (!file.exists(tpath))
  unzip(zpath, exdir = ddir)

epc = read.csv(tpath, header = TRUE, sep = ';', na.strings = '?',
           colClasses = c(rep('character', 2), rep('numeric', 7)))

d1 = as.Date('2007-02-01')
d2 = as.Date('2007-02-02')

epc$Date = as.Date(epc$Date, format = '%d/%m/%Y')
epc = subset(epc, Date %in% d1:d2)
epc$Date = as.POSIXct(paste(epc$Date, epc$Time), format = '%Y-%m-%d %H:%M:%S')
epc$Time = NULL

png(file = 'plot1.png', width = 480, height = 480)
par(mfrow = c(1, 1), mar = c(5, 4, 4, 2) + 0.1)
hist(epc$Global_active_power, col = 'red', main = 'Global Active Power',
     xlab = 'Global Active Power (kilowatts)')
dev.off()

unlink(ddir, recursive = TRUE)