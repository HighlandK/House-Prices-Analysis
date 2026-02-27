#3 Importing & Cleaning of Dataset

# Load dataset
house_data <- read.csv("train.csv")

# Convert YrSold to categorical
house_data$YrSold <- as.factor(house_data$YrSold)

# Check structure and summary
str(house_data)
summary(house_data)

# Discrete Numerical Variables :
# - OverallQual: Overall material and finish quality
# - GarageCars: Number of cars the garage can hold
# - Fireplaces: Number of fireplaces
# - KitchenAbvGr: Number of kitchens above ground
# - YrSold: Year the house was sold

# Continuous Numerical Variables :
# - SalePrice: Target variable (House price)
# - GrLivArea: Above ground living area (sqft)
# - TotalBsmtSF: Total basement area (sqft)
# - LotFrontage: Length of the street connected to the property
# - LotArea: Lot size in square feet
# - TotalFloorSF: Combined area of 1st and 2nd floor

# Categorical Variables :
# - HeatingQC: Heating quality and condition
# - RoofStyle: Type of roof
# - GarageFinish: Interior finish of the garage
# - BsmtFinType1: Rating of basement finished area
# - YearBuiltDecade: Decade the house was built
# - Alley: Type of alley

# Create working dataframe with selected variables (excluding X1stFlrSF)
df <- house_data[, c("OverallQual", "GarageCars", "Fireplaces", "LotFrontage", "YearBuilt", "YrSold", 
                     "SalePrice", "GrLivArea", "TotalBsmtSF", "KitchenAbvGr",
                     "HeatingQC", "RoofStyle", "GarageFinish", "BsmtFinType1", "Alley")]

# Add TotalFloorSF (1st Floor SF + 2nd Floor SF)
df$TotalFloorSF <- house_data$X1stFlrSF + house_data$X2ndFlrSF

# Add log(LotArea)
df$`log(LotArea)` <- log(house_data$LotArea)

#Add sqrt(SalePrice)
df$`sqrt(SalePrice)` <- sqrt(house_data$SalePrice)

# Create YearBuiltDecade as a new categorical variable
df$YearBuiltDecade <- cut(df$YearBuilt,
                          breaks = seq(1870, 2020, by = 10),
                          right = FALSE,
                          labels = paste(seq(1870, 2010, by = 10), "s", sep = ""))

# Define variable groups
all_vars <- c("OverallQual", "GarageCars", "Fireplaces", "LotFrontage", "YrSold", "SalePrice",
              "sqrt(SalePrice)", "GrLivArea", "TotalBsmtSF", "KitchenAbvGr", "log(LotArea)", "TotalFloorSF",
              "HeatingQC", "RoofStyle", "GarageFinish", "BsmtFinType1", "YearBuiltDecade", "Alley")

discrete_vars <- c("OverallQual", "GarageCars", "Fireplaces", "KitchenAbvGr", "YrSold")

continuous_vars <- c("sqrt(SalePrice)", "GrLivArea", "TotalBsmtSF", "LotFrontage", "log(LotArea)", "TotalFloorSF")

cat_vars <- c("HeatingQC", "RoofStyle", "GarageFinish", "BsmtFinType1", "YearBuiltDecade", "Alley")

#3.1 Removing incomplete data from dataset

# Replace NA in GarageFinish where NA means "No Garage"
df$GarageFinish[is.na(df$GarageFinish)] <- "NoGarage"

# Replace NA in BsmtFinType1 where NA means "No Basement"
df$BsmtFinType1[is.na(df$BsmtFinType1)] <- "NoBasement"

# Replace NA in Alley where NA means "No Alley"
df$Alley[is.na(df$Alley)] <- "NoAlley"

# Check for missing values
colSums(is.na(df))

# Remove rows with NA
df <- na.omit(df)
str(df)

# Outlier removal function
remove_outliers <- function(x) {
  q1 <- quantile(x, 0.25, na.rm = TRUE)
  q3 <- quantile(x, 0.75, na.rm = TRUE)
  iqr <- q3 - q1
  lower_bound <- q1 - 1.5 * iqr
  upper_bound <- q3 + 1.5 * iqr
  x[x < lower_bound | x > upper_bound] <- NA
  return(x)
}

#3.2 Summary statistics for the main variable of interest, SalePrice

#Histogram of SalePrice
hist(df$SalePrice, main ="Histogram of SalePrice", xlab = "SalePrice")

#Histogram of sqrt(SalePrice)
hist(df$`sqrt(SalePrice)`, main ="Histogram of sqrt(SalePrice)", xlab = "sqrt(SalePrice)")

#Boxplot of sqrt(SalePrice)
boxplot(df$`sqrt(SalePrice)`, main ="Histogram of sqrt(SalePrice)")

#Histogram of SalePrice
hist(df$SalePrice, main ="Histogram of SalePrice", xlab = "SalePrice")

#3.3 Summary statistics for continuous variables

#Histogram of GrLivArea
hist(df$GrLivArea, main ="Histogram of GrLivArea", xlab = "GrLivArea")

#Histogram of TotalBsmtSF
hist(df$TotalBsmtSF, main ="Histogram of TotalBsmtSF", xlab = "TotalBsmtSF")

#Histogram of LotFrontage
hist(df$LotFrontage, main ="Histogram of LotFrontage", xlab = "LotFrontage")

#Histogram of log(LotArea)
hist(df$`log(LotArea)`, main ="Histogram of log(LotArea)", xlab = "log(LotArea)")

#Histogram of TotalFloorSF
hist(df$TotalFloorSF, main ="Histogram of TotalFloorSF", xlab = "TotalFloorSF")

#Boxplot of SalePrice
boxplot(df$SalePrice,main ="Boxplot of SalePrice")

#Boxplot of GrLivArea
boxplot(df$GrLivArea,main ="Boxplot of GrLivArea")

#Boxplot of TotalBsmtSF
boxplot(df$TotalBsmtSF,main ="Boxplot of TotalBsmtSF")

#Boxplot of LotFrontage
boxplot(df$LotFrontage,main ="Boxplot of LotFrontage")

#Boxplot of LotArea
boxplot(df$`log(LotArea)`,main ="Boxplot of log(LotArea)")

#Boxplot of TotalFloorSF
boxplot(df$TotalFloorSF,main ="Boxplot of TotalFloorSF")

#3.4 Summary statistics for discrete variables

#Barplot of OverallQual
barplot(table(df$OverallQual), 
        main = "Barplot of OverallQual",
        xlab = "Overall Quality", 
        ylab = "Frequency")

#Barplot of GarageCars
barplot(table(df$GarageCars), 
        main = "Barplot of GarageCars",
        xlab = "Garage Cars", 
        ylab = "Frequency")

#Barplot of Fireplaces
barplot(table(df$Fireplaces), 
        main = "Barplot of Fireplaces",
        xlab = "Fireplaces", 
        ylab = "Frequency")

#Barplot of KitchenAbvGr
barplot(table(df$KitchenAbvGr), 
        main = "Barplot of KitchenAbvGr",
        xlab = "Number of Kitchen Above Grade", 
        ylab = "Frequency")

#Barplot of YrSold
barplot(table(df$YrSold), 
        main = "Barplot of YrSold",
        xlab = "Year Sold", 
        ylab = "Frequency")

#3.5 Summary statistics for the categorical variables

#Barplot of HeatingQC
barplot(table(df$HeatingQC), 
        main = "Barplot of HeatingQC",
        xlab = "HeatingQC", 
        ylab = "Frequency")

#Barplot of RoofStyle
barplot(table(df$RoofStyle), 
        main = "Barplot of RoofStyle",
        xlab = "RoofStyle", 
        ylab = "Frequency")

#Barplot of GarageFinish
barplot(table(df$GarageFinish), 
        main = "Barplot of GarageFinish",
        xlab = "GarageFinish", 
        ylab = "Frequency")

#Barplot of BsmtFinType1
barplot(table(df$BsmtFinType1), 
        main = "Barplot of BsmtFinType1",
        xlab = "BsmtFinType", 
        ylab = "Frequency")

#Barplot of YearBuiltDecade
barplot(table(df$YearBuiltDecade), 
        main = "Barplot of YearBuiltDecade",
        xlab = "YearBuiltDecade", 
        ylab = "Frequency")

#Barplot of Alley (without NoAlley)
barplot(table(df$Alley[df$Alley != "NoAlley"]), 
        main = "Barplot of Alley",
        xlab = "Alley", 
        ylab = "Frequency")

# Apply outlier removal to continuous variables
df_outlier_filtered <- df
for (col in continuous_vars) {
  df_outlier_filtered[[col]] <- remove_outliers(df_outlier_filtered[[col]])
}

#3.6 Summary statistics for all variables

# Check for number of outliers in respective columns
colSums(is.na(df_outlier_filtered))

# Remove rows with any NA (from outliers)
filtered_df <- df_outlier_filtered[complete.cases(df_outlier_filtered), ]

# Revised Histogram of sqrt(SalePrice)
hist(filtered_df$`sqrt(SalePrice)`, main ="Histogram of sqrt(SalePrice) (outliers removed)", xlab = "sqrt(SalePrice)")

# Revised Boxplot of sqrt(SalePrice)
boxplot(df$`sqrt(SalePrice)`,main ="Boxplot of sqrt(SalePrice) (outliers removed)",outline=FALSE)

# Summary for sqrt(SalePrice) after removing outliers
summary(filtered_df$`sqrt(SalePrice)`)

# Check structure and summary
str(filtered_df)
summary(filtered_df)


#4.1 Correlations between sqrt(SalePrice) and other Continuous Variables

# Load necessary libraries
library(ggplot2)
library(ggcorrplot)

# Select relevant columns
df_subset <- filtered_df[, c("sqrt(SalePrice)", "TotalBsmtSF", "log(LotArea)", "GrLivArea", "LotFrontage", "TotalFloorSF")]

# Compute correlation matrix
cor_matrix <- cor(df_subset, use = "complete.obs")

# Plot correlation heatmap
ggcorrplot(cor_matrix,
           method = "circle", 
           type = "lower", 
           lab = TRUE, 
           lab_size = 3, 
           colors = c("blue", "white", "red"),
           title = "Correlation Heatmap with sqrt(SalePrice)",
           ggtheme = theme_minimal())

#4.2.1 Relation between sqrt(SalePrice) and OverallQual
#Plotting boxplot
boxplot(filtered_df$`sqrt(SalePrice)`~filtered_df$OverallQual)

#4.2.2 Relation between HeatingQC and GarageFinish
#Plotting two-way contingency table (GarageFinish and HeatingQC)
BsmtFinType1vsHeatingQC <- table(filtered_df$GarageFinish, filtered_df$HeatingQC)

#Checking if table is generated correctly
print(BsmtFinType1vsHeatingQC)

#Removing the ‘Po’ column
BsmtFinType1vsHeatingQC_filtered <- BsmtFinType1vsHeatingQC[, colnames(BsmtFinType1vsHeatingQC) != "Po"]

#Checking if table is generated correctly
print(BsmtFinType1vsHeatingQC_filtered)

#Conducting chi-square test of independence
chisq.test(BsmtFinType1vsHeatingQC_filtered)

#Since the p-value<0.05, we conclude that there likely exists an association between the quality of the basement finished area and the quality of the garage finish

#4.2.3 Relation between sqrt(SalePrice) and Alley

df_alley <- filtered_df[filtered_df$Alley != "NoAlley", ]

#Variances are completely unknown to us so we compare using f-test! (var.test)
var.test(`sqrt(SalePrice)` ~ Alley, data = df_alley, conf.level = 0.9)

#Reject h0, take it as variances not equal
t.test(`sqrt(SalePrice)`~ Alley, data = df_alley, var.equal=FALSE)

#4.2.4 Relation between sqrt(SalePrice) and RoofStyle

#Boxplot of sqrt(SalePrice) by RoofStyle, in order of increasing sqrt(SalePrice)
reordered_roofstyle <- reorder(filtered_df$RoofStyle, filtered_df$`sqrt(SalePrice)`, FUN = median)
boxplot(filtered_df$`sqrt(SalePrice)` ~ reordered_roofstyle, main = "sqrt(SalePrice) by RoofStyle", xlab = "RoofStyle", ylab = "sqrt(SalePrice)", col = "skyblue", las = 2) 

#ANOVA for RoofStyle and sqrt(SalePrice)
roofstyle_anova <- aov(`sqrt(SalePrice)` ~ RoofStyle, data = filtered_df)
summary(roofstyle_anova)
#pvalue < 0.05, so sale price is related to roof style

#Display number of houses in each RoofStyle
table(filtered_df$RoofStyle)
#Kruskal-Willies Test
kruskal.test(`sqrt(SalePrice)` ~ RoofStyle, data = filtered_df)
#pvalue < 0.05, suggesting that sale price is related to roof style

#4.2.5 Relation between sqrt(SalePrice) and YrSold
#Plotting boxplot 
boxplot(filtered_df$`sqrt(SalePrice)`~filtered_df$YrSold)

#Plotting one-way ANOVA model
summary(aov(filtered_df$`sqrt(SalePrice)`~filtered_df$YrSold))

##pvalue>0.05 so saleprice is independent of year sold
#BUT, looking at boxplot, explain why this may be otherwise as well

#4.2.6 Linear regression of continuous variables against sqrt(SalePrice)

# Create linear regression models
model1<-lm(filtered_df$`sqrt(SalePrice)` ~ filtered_df$GrLivArea)
model2<-lm(filtered_df$`sqrt(SalePrice)` ~ filtered_df$TotalBsmtSF)
model3<-lm(filtered_df$`sqrt(SalePrice)` ~ filtered_df$LotFrontage)
model4<-lm(filtered_df$`sqrt(SalePrice)` ~ filtered_df$`log(LotArea)`)
model5<-lm(filtered_df$`sqrt(SalePrice)` ~ filtered_df$TotalFloorSF)

# Summary of models
summary(model1)
summary(model2)
summary(model3)
summary(model4)
summary(model5)

par(mfrow = c(2, 3))

# Plot sqrt(SalePrice) against GrLivArea
plot(filtered_df$GrLivArea, filtered_df$`sqrt(SalePrice)`, xlab = "GrLivArea", ylab = "sqrt(SalePrice)")
abline(model1, col = "red")

# Plot sqrt(SalePrice) against TotalBsmtSF
plot(filtered_df$TotalBsmtSF, filtered_df$`sqrt(SalePrice)`, xlab = "TotalBsmtSF", ylab = "sqrt(SalePrice)")
abline(model2, col = "blue")

# Plot sqrt(SalePrice) against LotFrontage
plot(filtered_df$LotFrontage, filtered_df$`sqrt(SalePrice)`, xlab = "LotFrontage", ylab = "sqrt(SalePrice)")
abline(model3, col = "green")

# Plot sqrt(SalePrice) against log(LotArea)
plot(filtered_df$`log(LotArea)`, filtered_df$`sqrt(SalePrice)`, xlab = "log(LotArea)", ylab = "sqrt(SalePrice)")
abline(model4, col = "purple")

# Plot sqrt(SalePrice) against TotalFloorSF
plot(filtered_df$TotalFloorSF, filtered_df$`sqrt(SalePrice)`, xlab = "TotalFloorSF", ylab = "sqrt(SalePrice)")
abline(model5, col = "orange")

par(mfrow = c(2, 3))

# qqplot of residuals
qqnorm(model1$residuals, main = "Model 1")
qqline(model1$residuals, col = "blue")
qqnorm(model2$residuals, main = "Model 2")
qqline(model2$residuals, col = "blue")
qqnorm(model3$residuals, main = "Model 3")
qqline(model3$residuals, col = "blue")
qqnorm(model4$residuals, main = "Model 4")
qqline(model4$residuals, col = "blue")
qqnorm(model5$residuals, main = "Model 5")
qqline(model5$residuals, col = "blue")

#4.3 Principal Component Analysis (PCA)
# Select relevant columns
df_subset <- filtered_df[, c("sqrt(SalePrice)", "TotalBsmtSF", "log(LotArea)", "GrLivArea", "LotFrontage", "TotalFloorSF")]

# PCA Analysis
num_scaled <- scale(df_subset)
pca_result <- prcomp(num_scaled, center = TRUE, scale. = TRUE)

# Summary of variance explained
summary(pca_result)

# Checking variable loadings
pca_result$rotation[, 1:3]
