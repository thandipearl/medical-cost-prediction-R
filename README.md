# Insurance Cost Prediction Using Linear Regression (R)

## Project Overview
This project demonstrates how **data science and statistical modeling** can be used to predict medical insurance costs.

Insurance companies face a critical challenge:

- If they charge **premiums that are too high**, they risk losing customers.
- If they charge **premiums that are too low**, they risk losing money and potentially going bankrupt.

To address this problem, this project builds a **linear regression model in R** that predicts an individual's **annual medical charges** using basic demographic and lifestyle variables.

The goal is to estimate how much a person might cost the healthcare system based on factors such as:

- Age  
- Sex  
- Body Mass Index (BMI)  
- Number of children  
- Smoking status  
- Geographic region  

The dataset used in this project was obtained from **Kaggle** and contains records where each row represents an individual and their medical charges for a given year.

---

# Dataset Description

Each row in the dataset represents a person, and the columns represent their characteristics.

| Variable | Description |
|--------|-------------|
| age | Age of the individual |
| sex | Gender of the individual |
| bmi | Body Mass Index |
| children | Number of dependents covered by insurance |
| smoker | Whether the individual is a smoker |
| region | Geographic region |
| charges | Medical costs billed by hospitals |

Example interpretation:

A person may be:

- 26 years old  
- Male  
- BMI of 20  
- No children  
- Non-smoker  
- Living in the Southwest  

Their total hospital charges for the year may be **$2,302**.

Our objective is to **predict these charges** using the other variables.

---

# Loading the Dataset

The first step is to load the dataset into **RStudio**.

```r
# Load in the data
insurance_data <- read.csv(file.choose())
```

This command imports the CSV dataset into a dataframe called:

```
insurance_data
```

Once the data is loaded, we can begin **Exploratory Data Analysis (EDA)** to understand patterns and relationships.

---

# Exploratory Data Analysis (EDA)

EDA helps us understand how variables interact before building a predictive model.

## Visualizing Numerical Relationships

First, we identify the numeric variables in the dataset and visualize them.

```r
num_cols <- unlist(lapply(insurance_data, is.numeric))
plot(insurance_data[,num_cols])
```

This produces scatterplots comparing all numerical variables against each other.

<img width="866" height="592" alt="DA1" src="https://github.com/user-attachments/assets/13ea2010-2faf-46b3-9f31-82152d864139" />

### Example insights from the plots

- **Age vs Charges**
  - As age increases, medical charges tend to increase.

- **BMI vs Charges**
  - Higher BMI values are associated with higher charges.

- **Children vs Charges**
  - There is no strong visual trend, but some variation exists.


------------------------------------------------------------------------------------------------------------
# Correlation Analysis

Next, we measure the strength of relationships between numerical variables using a **correlation matrix**.

```r
round(cor(insurance_data[,num_cols]),2)
```

### Correlation Results

| Variable | age | bmi | children | charges |
|------|------|------|------|------|
| age | 1.00 | 0.11 | 0.04 | 0.30 |
| bmi | 0.11 | 1.00 | 0.01 | 0.20 |
| children | 0.04 | 0.01 | 1.00 | 0.07 |
| charges | 0.30 | 0.20 | 0.07 | 1.00 |

### Interpretation

- **Age (0.30)** has a moderate relationship with charges.
- **BMI (0.20)** also shows some relationship.
- **Children (0.07)** has a very weak correlation.

Although correlations are not extremely high, they still provide useful predictive information.

---

# Analyzing Categorical Variables

Some variables are **categorical**, meaning they represent categories rather than numeric values.

These include:

- smoker  
- sex  
- region  

We convert them into **factors** in R.

```r
smoker <- as.factor(insurance_data$smoker)
sex <- as.factor(insurance_data$sex)
region <- as.factor(insurance_data$region)
```

Next, we visualize how these categories affect medical charges using **boxplots**.

```r
boxplot(insurance_data$charges ~ smoker, main = "smoker")
boxplot(insurance_data$charges ~ sex, main = "sex")
boxplot(insurance_data$charges ~ region, main = "region")
```


<img width="608" height="585" alt="plot1" src="https://github.com/user-attachments/assets/74633745-de84-4386-ba4e-5da25e706b24" />   <img width="615" height="583" alt="plot2" src="https://github.com/user-attachments/assets/ad74c9ca-462b-4dc6-8830-07f22ac30b2c" />   <img width="614" height="583" alt="plot3" src="https://github.com/user-attachments/assets/b45b7286-b7b4-4011-bf73-572bb104ad85" /> 


### Insights

**Smoking Status**

- Smokers have dramatically higher medical charges than non-smokers.
- This is one of the strongest predictors in the dataset.

**Sex**

- Charges for males and females appear similar.
- Gender may not significantly affect costs.

**Region**

- Some regions appear to have slightly higher costs than others.
- Regional healthcare costs may vary.

---

# Building the Linear Regression Model

After understanding the data, we build a **linear regression model** to predict medical charges.

```r
model1 <- lm(charges ~ ., data = insurance_data)
summary(model1)
```

This model uses **all available variables** to predict charges.

---

# Model Output

### Regression Summary

| Variable | Estimate | Significance |
|------|------|------|
| age | 256.9 | Highly significant |
| sexmale | -131.3 | Not significant |
| bmi | 339.2 | Highly significant |
| children | 475.5 | Significant |
| smokeryes | 23848.5 | Extremely significant |
| regionnorthwest | Not significant |
| regionsoutheast | Significant |
| regionsouthwest | Significant |

---

# Model Performance

### R-Squared

```
Multiple R-squared: 0.7509
Adjusted R-squared: 0.7494
```

### Interpretation

The model explains approximately **75% of the variance** in medical charges.

This means the model is able to predict healthcare costs with **reasonable accuracy**, though it is not perfect.

---

# Key Findings

The most important factors affecting medical costs are:

### Smoking Status
Smokers have significantly higher healthcare costs.

### Age
Older individuals generally have higher medical expenses.

### BMI
Higher BMI values tend to increase healthcare costs.

### Number of Children
There is some impact from dependents covered by insurance.

### Region
Regional healthcare differences slightly affect costs.

### Gender
Gender does **not appear to be a significant predictor** in this model.

---

# Real-World Application

Insurance companies could use this type of model to:

- Estimate future healthcare costs  
- Determine fair insurance premiums  
- Manage financial risk  

For example, given a person who is:

- 27 years old  
- Male  
- BMI of 26  
- Non-smoker  
- Living in the Southwest  

The model can estimate their **expected annual medical costs**.

This helps insurers balance:

- affordability for customers  
- sustainability for the company  

---

# Conclusion

This project demonstrates a complete **data science workflow**:

1. Data collection  
2. Data exploration (EDA)  
3. Correlation analysis  
4. Visualization  
5. Regression modeling  
6. Model interpretation  

Using **linear regression in R**, we built a model that explains **75% of the variation in medical charges**.

While the model is not perfect, it provides a **strong baseline for predicting healthcare costs** and demonstrates how data science can support decision-making in industries like **insurance, finance, and healthcare**.

---

# Technologies Used

- R  
- RStudio  
- Linear Regression  
- Data Visualization  
- Exploratory Data Analysis (EDA)

---

# Dataset Source

**Kaggle — Medical Cost Personal Dataset**

---

# Project Purpose

This project was created as a **portfolio project to demonstrate practical data science skills**, including:

- statistical modeling  
- data exploration  
- feature interpretation  
- predictive analytics  

It is particularly relevant for roles in:

- Data Science  
- Risk Analytics  
- Insurance Analytics  
- Financial Modeling  

---

