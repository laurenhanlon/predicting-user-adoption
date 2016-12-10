# Load adopted users database
adopted_users <- read.csv('../data/adopted_users_extended.csv', header=TRUE)

# Exploratory Data Analysis for creation_source
library(MASS)

# Break up into adopted_users and non adopted users
adopted <- subset(adopted_users, adopted_user==1)
non_adopted <- subset(adopted_users, adopted_user==0)

source_adopted = adopted$creation_source
source_non_adopted = non_adopted$creation_source

source_adopted.freq = table(source_adopted)
source_non_adopted.freq = table(source_non_adopted)

png('../images/barplot-adopted-source.png')
barplot(source_adopted.freq, main='adopted users: source', col='cadetblue3', xlab='source', cex.names=0.50)
dev.off()

png('../images/barplot-non-adopted-source.png')
barplot(source_non_adopted.freq, main='non adopted users: source', xlab='source', col='cadetblue3', cex.names=0.50)
dev.off()

# Exploratory Data Analysis for time
columns_time <- c('creation_delta','lifespan_delta','last_login_delta')
time_adopted <- adopted[,columns_time]
time_non_adopted <- non_adopted[,columns_time]

png('../images/boxplot-adopted-time.png')
boxplot(time_adopted, main='adopted users: time', xlab='delta', ylab='time (UNIX)', col='cadetblue3', cex.names=0.50)
dev.off()

png('../images/boxplot-non-adopted-time.png')
boxplot(time_non_adopted, main='non adopted users: time', xlab='delta', ylab='time (UNIX)', col='cadetblue3', cex.names=0.50)
dev.off()
