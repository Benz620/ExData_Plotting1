#Loading the data 
data<- read.delim("household_power_consumption.txt",sep = ";")
library(data.table)
data<-data.table(data)
data1 <- data[Date%in%c("1/2/2007","2/2/2007"),]
data1$Global_active_power<-as.numeric(data1$Global_active_power)
View(data1)



png("plot2.png",width = 480,height=480)
## This time, the strptime function was needed 

## First, im trying to assemble the Date and time column into one clolumn called datetime by using the paste function
## then, im assigning it to a new variable calle data2
data2 <- data1[,datetime:= paste(data1$Date,data1$Time)]


## Second, im converteting  the datetime column which is a caracter string into date and time format using the strptime function
data2[,datetime:=strptime(data2$datetime, format = "%d/%m/%Y %H:%M:%S")]


## Third, im plotting the graph. my x variable is datetime and my second variable Global active power
##then, im using type="l" for the line 
plot(data2$datetime, data2$Global_active_power, type="l",xlab="",ylab="Global active power(kilowatts)", xaxt="n")


## and lastly, before calling the axis function, i set the xaxt argument ="n" to delete the x axis limit for the plot function
### And then, I used the axis function to label the x axis limits.
axis(side=1,seq(min(data2$datetime),max(data2$datetime),length=3),labels = c("Thu","Fri","Sat"))
dev.off()
