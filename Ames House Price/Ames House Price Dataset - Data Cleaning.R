install.packages("janitor")
install.packages("fastDummies")
library(fastDummies)
library(janitor)
house.price <- read.csv("D:/DS/Dibimbing_DS/train.csv", header=FALSE, stringsAsFactors=TRUE)
house.price <- row_to_names(house.price,row_number = 1)
house.price <- clean_names(house.price)

#Missing Values Check
house.price[house.price=='NULL'] <- NA
colSums(is.na(house.price)) 
str(house.price)

#Data Cleaning, Variable = misc_feature
str(house.price$misc_feature)
levels(house.price$misc_feature)
house.price$misc_feature[is.na(house.price$misc_feature)] <- as.factor("Othr")
str(house.price$misc_feature)
house.price$misc_feature <- droplevels(house.price$misc_feature)
unique(house.price$misc_feature)
colSums(is.na(house.price))

#Standarization 
str(house.price)
house.price$lot_area <- as.numeric(as.character(house.price$lot_area))
summary(house.price$lot_area)
hist(house.price$lot_area)
shapiro.test(house.price$lot_area) #Failed normality test p<0.05
house.price$lot_area.scaled <- scale(house.price$lot_area)
str(house.price)
hist(house.price$lot_area.scaled)

#Transformation sale_price, Log Transformation
house.price$sale_price <- as.numeric(as.character(house.price$sale_price))
house.price$sale_price.scaled <- scale(house.price$sale_price)
house.price$abs_sale_price.scaled <- house.price$sale_price.scaled + abs(min(house.price$sale_price.scaled)) + 1
house.price$log_sale_price <- log(house.price$abs_sale_price.scaled)
hist(house.price$sale_price.scaled)
hist(house.price$abs_sale_price.scaled)
hist(house.price$log_sale_price)
shapiro.test(house.price$log_sale_price)#Failed normality test p<0.05
boxplot(house.price$log_sale_price)

#Outlier Handling sale_price, IQR Method
#iterasi pertama
q1 <- quantile(house.price$log_sale_price,0.25)
q3 <- quantile(house.price$log_sale_price,0.75)
iqr <- q3 - q1
upper_bound <- q3 + 1.5 * iqr
lower_bound <- q1 - 1.5 * iqr
house.price <- house.price[house.price$log_sale_price > lower_bound & house.price$log_sale_price < upper_bound,]
boxplot(house.price$log_sale_price)

#iterasi kedua
q1 <- quantile(house.price$log_sale_price,0.25)
q3 <- quantile(house.price$log_sale_price,0.75)
iqr <- q3 - q1
upper_bound <- q3 + 1.5 * iqr
lower_bound <- q1 - 1.5 * iqr
house.price <- house.price[house.price$log_sale_price > lower_bound & house.price$log_sale_price < upper_bound,]
boxplot(house.price$log_sale_price)

#Categorical Handling, One-hot encoding, Garage Type Variable
str(house.price)
colSums(is.na(house.price))
unique(house.price$garage_type)
levels(house.price$garage_type) <- c(levels(house.price$garage_type), "Othr")
house.price$garage_type[is.na(house.price$garage_type)] <- as.factor("Othr")
house.price$garage_type <- droplevels(house.price$garage_type)
unique(house.price$garage_type)
house.price <- dummy_cols(house.price, select_columns = "garage_type")

house.price <- dummy_cols(house.price, select_columns = "garage_type")
Onehot.encoding <- subset(house.price, select = garage_type_2Types:garage_type_Othr)
colSums(unique(house.price))

DataCleaned.misc_feature <- house.price$misc_feature
Standardization.lot_area <- house.price$lot_area.scaled
logtrans.scaled.no_outlier.sale_price <- house.price$log_sale_price
onehot.garage_type <- Onehot.encoding

#Making .csv
df <- data.frame(DataCleaned.misc_feature, Standardization.lot_area, logtrans.scaled.no_outlier.sale_price, onehot.garage_type)
colSums(is.na(df))
summary(df$Standardization.lot_area)
hist(df$logtrans.scaled.no_outlier.sale_price)
boxplot(df$logtrans.scaled.no_outlier.sale_price)
write.csv(df,"C:\\Users\\User\\Desktop\\Day7Task-Mohammad Erwinsyah Hartono.csv", row.names = FALSE)