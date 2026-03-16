
# Load in the data
insurance_data <- read.csv(file.choose())

# Exploratory Data Analysis

#----relationship between each numeric value
num_cols <- unlist(lapply(insurance_data, is.numeric))
plot(insurance_data[,num_cols])


# ----the co-relations
round(cor(insurance_data[,num_cols]),2)

# ----box plot
smoker <- as.factor(insurance_data$smoker)
sex <- as.factor(insurance_data$sex)
region <- as.factor(insurance_data$region)

boxplot(insurance_data$charges ~ smoker, main = "smoker" )
boxplot(insurance_data$charges ~ sex, main = "sex" )
boxplot(insurance_data$charges ~ region, main = "region" )


# Linear Regression Model

model1 <- lm(charges ~. , data = insurance_data)
summary(model1)
