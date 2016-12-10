# Load adopted users database
adopted_users <- read.csv('../data/adopted_users_extended.csv', header=TRUE)

# Keep only desired columns
columns <- c('adopted_user', 'creation_source', 'opted_in_to_mailing_list', 'enabled_for_marketing_drip',
             'creation_delta', 'last_login_delta')

users <- adopted_users[ ,columns]
users[is.na(users)] <- 0

###################

# Dummy out categorical variables
options(na.action=na.omit)
temp_users <- model.matrix(adopted_user ~ ., data = users)
nrow(temp_users)

# removing column of ones, and appending adopted_user
new_users <- cbind(temp_users[ ,-1], adopted_user = users$adopted_user)

# Mean Centering and Standardizing
scaled_users <- scale(new_users, center = TRUE, scale = TRUE)
scaled_users <- data.frame(scaled_users)

###################

# multi linear regression
osl_fit <- lm(adopted_user ~., data=scaled_users)
osl_summary_fit <- summary(osl_fit)

## Residual Plot
plot(osl_fit, which=1)

## Scale Location Plot
plot(osl_fit, which=3)

## Normal QQ Plot
plot(osl_fit, which=2)

###################

## Breaking down into sections to get a closer look
## Repeated same steps just only using subsets of user matrix and adopted_user indicator

## SOURCES
columns_source <- c('adopted_user', 'creation_source')
users_source <- adopted_users[,columns_source]
temp_users_source <- model.matrix(adopted_user ~ .,data=users_source)
new_users_source <- cbind(temp_users_source[,-1], adopted_user = users$adopted_user)
scaled_users_source <- scale(new_users_source, center = TRUE, scale = TRUE)
scaled_users_source <- data.frame(scaled_users_source)
osl_fit_source <- lm(adopted_user ~., data=scaled_users_source)
osl_summary_fit_source <- summary(osl_fit_source)

## EMAIL MARKETING
columns_email <- c('adopted_user', 'opted_in_to_mailing_list', 'enabled_for_marketing_drip')
users_email <- adopted_users[,columns_email]
users_email[is.na(users_email)] <- 0
scaled_users_email <- scale(users_email, center = TRUE, scale = TRUE)
scaled_users_email <- data.frame(scaled_users_email)
osl_fit_email <- lm(adopted_user ~., data=scaled_users_email)
osl_summary_fit_email <- summary(osl_fit_email)

## LOGIN TIME DELTAS
columns_time <- c('adopted_user', 'creation_delta', 'last_login_delta')
users_time <- adopted_users[,columns_time]
scaled_users_time <- scale(users_time, center = TRUE, scale = TRUE)
scaled_users_time <- data.frame(scaled_users_time)
osl_fit_time <- lm(adopted_user ~., data=scaled_users_time)
osl_summary_fit_time <- summary(osl_fit_time)

###################

# save objects to file
save(osl_fit, osl_summary_fit,osl_summary_fit_source,osl_summary_fit_email, osl_summary_fit_time, file = "../data/linear-modeling.RData")

