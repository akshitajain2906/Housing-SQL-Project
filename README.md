# 🏠 Nashville Housing SQL Project – Data Cleaning & Preparation

This project focuses on cleaning and transforming raw housing sales data using SQL to make it analysis-ready. The dataset contains property records from Nashville, including sale dates, addresses, prices, and ownership details.

---

## Overview

The raw dataset included inconsistent formatting, missing values, and redundant fields. The goal was to clean and structure the data using SQL techniques so it could be used for future analysis or dashboard building.

Key focus areas included:  
- Standardizing date formats  
- Filling in missing property address data  
- Splitting address columns into usable fields  
- Standardizing categorical values  
- Removing duplicates and unused fields  

---

## What I Worked On

### 1. Date Formatting
- Converted `SaleDate` from datetime to `DATE` format  
- Created a new column `SaleDateConverted` to hold the cleaned values  

### 2. Filling Missing Address Values
- Used a self `JOIN` on `ParcelID` to fill null `PropertyAddress` values  
- Ensured records with matching parcels shared the correct address  

### 3. Address Column Splits
- Split `PropertyAddress` into `Address` and `City` using `SUBSTRING()`  
- Used `PARSENAME()` to split `OwnerAddress` into `Address`, `City`, and `State`  

### 4. Data Standardization
- Replaced 'Y' and 'N' values in `SoldAsVacant` with 'Yes' and 'No'  
- Ensured consistent formatting for categorical data  

### 5. Duplicate Removal
- Identified duplicates using `ROW_NUMBER()` in a CTE  
- Deleted all but the first instance of identical records  

### 6. Column Cleanup
- Dropped unused columns: `OwnerAddress`, `TaxDistrict`, `PropertyAddress`, and original `SaleDate`  

---

## Outcome

A clean, structured dataset ready for further analysis, visualization, or integration into dashboards.
