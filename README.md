# Uncovering the Housing Market: Size, Environment, and Sale Prices
**MH3511: Data Analysis with Computer** | [cite_start]**Nanyang Technological University** [cite: 4, 5]

## 🏠 Project Overview
[cite_start]This project investigates the factors influencing residential property prices in **Ames, Iowa** during the 2010s[cite: 70, 524]. [cite_start]Using the Kaggle "House Prices" dataset originally compiled by Dean De Cock, our team conducted rigorous statistical analysis in **R** to determine how structural attributes, environmental factors, and qualitative features impact market value[cite: 80, 84, 123].

### 🔍 Research Questions
* [cite_start]To what extent does overall property quality relate to sale price? [cite: 72]
* [cite_start]What is the correlation between house size (basement area, above-ground area, floor size) and sale price? [cite: 73]
* [cite_start]Is there an association between the quality of essential features (`HeatingQC`) and non-essential features (`GarageFinish`)? [cite: 74]
* [cite_start]Does the type of alley access (gravel or paved) or roof style affect the sale price? [cite: 75, 76]
* [cite_start]Does the year the house was sold (`YrSold`) have any effect on its sale price? [cite: 77]

---

## 🛠️ Replication Guide
Follow these steps to replicate our findings using the provided R script and the original dataset.

### 1. Prerequisites
You will need **R** and **RStudio**. [cite_start]Install the required libraries for visualization and correlation analysis[cite: 828, 830]:
```R
install.packages(c("ggplot2", "ggcorrplot"))
