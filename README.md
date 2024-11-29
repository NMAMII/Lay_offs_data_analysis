# Layoffs Data Analysis and Visualization

Welcome to the **Layoffs Data Analysis and Visualization** project! This project involves comprehensive data cleaning, exploratory data analysis (EDA) using SQL, and the creation of an interactive Tableau dashboard to uncover insights into global layoff trends.



## Project Overview

The goal of this project is to analyze layoff data to answer key business questions, such as:
- Which industries and countries were most affected by layoffs?
- How did layoff trends change over time?
- What insights can we derive about companies' performance based on their layoffs and funding?

### Tools and Technologies Used:
- **SQL**: For data cleaning, transformation, and exploratory analysis.
- **Tableau**: For interactive and insightful data visualization.
- **MySQL Workbench**: For executing SQL queries and managing the database.



## 📂 Steps in the Project

### 1️⃣ Data Cleaning (SQL)
- **Removed Duplicates**: Identified and removed duplicate rows using `ROW_NUMBER()`.
- **Standardized Data**: Trimmed whitespace, unified category names (e.g., "Crypto" industries), and ensured consistent country names.
- **Date Transformation**: Converted `date` fields from text to proper `DATE` format for accurate analysis.
- **Handled Null Values**: Filled missing values logically using contextual relationships within the data.

### 2️⃣ Exploratory Data Analysis (SQL)
- **Industry Trends**: Identified industries with the highest number of layoffs.
- **Country Analysis**: Ranked countries based on total layoffs and funding raised.
- **Yearly Trends**: Analyzed layoff patterns over years to identify peaks and shifts in trends.
- **Company Insights**: Highlighted top companies with the most layoffs in each year.

### 3️⃣ Data Visualization (Tableau)
- **Interactive Dashboard**: Created a Tableau dashboard to present findings visually.
  - **Layoffs by Industry**: Bar chart showing layoffs in each industry.
  - **Funds Raised by Country**: Bar chart to analyze the relationship between funds raised and layoffs.
  - **Layoffs by Year**: Time-series chart to show trends over time.
  - **Global Impact**: Map visualization highlighting the most affected countries.



## 📊 Dashboard Preview

You can interact with the full dashboard on **Tableau Public**:  
[🔗 View the Interactive Dashboard](https://public.tableau.com/views/Laidoffsvisualization/Dashboard1?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)

The interactive Tableau visualization can help stakeholders quickly understand key trends and patterns.



## 🛠️ How to Reproduce

### Prerequisites:
- **SQL environment** (e.g., MySQL Workbench, PostgreSQL, or any RDBMS of your choice).
- **Tableau Public** (or Tableau Desktop) for visualizations.

### Steps:
1. **Clone this repository**

2. Set up the database:
Import the raw dataset [layoffs.csv](https://github.com/AlexTheAnalyst/MySQL-YouTube-Series/blob/main/layoffs.csv)
Run the SQL scripts (data_cleaning.sql and eda.sql) to prepare and analyze the data.
Open the Tableau dashboard:
Download layoffs_dashboard.twb and open it in Tableau.
Explore the interactive dashboard.

## 🔑 Key Insights
Industries like Consumer, Retail, and Transportation faced the highest layoffs.
The United States was the most affected country, followed by India and Netherlands.
Layoffs peaked in 2022, with significant declines in subsequent years.
Companies in the startup and technology sectors were among the hardest hit.

## 📎 Files in the Repository
- Data Cleaning.sql: SQL script for data cleaning and transformation.
- EDA.sql: SQL script for exploratory data analysis.
- data visualization.twb: Tableau dashboard file for visualization.
- cleaned dataset.csv: The dataset after the cleaning.
