# Uncovering the Housing Market: Size, Environment, and Sale Prices
**MH3511: Data Analysis with Computer** | [cite_start]**Nanyang Technological University** [cite: 4, 5]

## 🏠 Project Overview
[cite_start]This project investigates the factors influencing residential property prices in **Ames, Iowa** during the 2010s[cite: 70, 524]. [cite_start]Using the Kaggle "House Prices" dataset originally compiled by Dean De Cock, our team conducted rigorous statistical analysis in **R** to determine how structural attributes, environmental factors, and qualitative features impact market value[cite: 80, 84, 123].

### 🔍 Research Questions
* To what extent does overall property quality relate to sale price? 
* What is the correlation between house size (basement area, above-ground area, floor size) and sale price? 
* Is there an association between the quality of essential features (`HeatingQC`) and non-essential features (`GarageFinish`)? 
* Does the type of alley access (gravel or paved) or roof style affect the sale price? 
* Does the year the house was sold (`YrSold`) have any effect on its sale price? 

---

## 🛠️ Replication Guide
Follow these steps to replicate our findings using the provided R script and the original dataset.

### 1. Prerequisites
You will need **R** and **RStudio**. [cite_start]Install the required libraries for visualization and correlation analysis[cite: 828, 830]:
```R
install.packages(c("ggplot2", "ggcorrplot"))
```
### 2. Dataset Setup
1. Download (`train.csv`) from the [Kaggle House Prices Dataset](https://www.kaggle.com/code/mustafaoz158/house-prices-eda-prediction-with-ml/notebook)
2. Save the file in your project directory.
### 3. Execution
1. Open ('House Prices Analysis.R`).
2. Ensure your working directory is set to the folder containing (`train.csv`).
3. Run the script to generate all summary statistics, hypothesis tests, and PCA results.
---
## 📊 Methodology & Findings
### 1. Data Cleaning & Preprocessing
* **Imputation:** "NA" values in (`Alley`), (`BsmtFinType1`), and (`GarageFinish`) were replaced with "NoAlley", "NoBasement", and "NoGarage".
* **Feature Engineering:** Created TotalFloorSF (1st Floor + 2nd Floor square footage).
  * Binned (`YearBuilt`)into (`YearBuiltDecade`) (e.g., "1990s").
* **Transformations:** Applied (`sqrt(SalePrice)`) and (`log(LotArea)`) to address data skewness.
* **Outlier Removal:** Used the Interquartile Range (IQR) method to filter continuous variables, resulting in a final dataset of **1,002 observations**.
### 2. Statistical Analysis
* **Association Test:** A Chi-squared test ($p < 2.2 \times 10^{-16}$) confirmed that high-quality essential features ((`HeatingQC`)) are associated with high-quality non-essential features ((`GarageFinish`)).
* **Alley Access:** Welch Two-Sample t-test showed paved alleys command significantly higher prices (mean 404.77) than gravel alleys (mean 343.57).
* **Roof Style:** ANOVA ($p = 0.000237$) confirmed roof styles like **Hip** and **Mansard** correlate with higher sale prices due to their better performance in Iowa's heavy snow.
* **Temporal Trends:** ANOVA showed no significant difference in mean prices across years ($p = 0.811$), though 2008 showed higher volatility due to the Global Financial Crisis.
### 3. Modeling & PCA
* **Linear Regression:** (`TotalBsmtSF`) (Total Basement Area) was identified as the most reliable linear model for (`sqrt(SalePrice)`) when balancing $R^2$ (0.385) and residual normality.
* **PCA:** The first three components explain **88.5%** of the total variance. PC1 alone (56.3%) captures the primary relationship between house size and market value.
