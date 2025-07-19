# Retail Sales Data Analysis (SQL + Python)

This project is a complete end-to-end data analysis pipeline built using **Python** and **SQL**, focusing on sales data from a retail environment. The goal is to extract meaningful business insights such as sales trends, customer behavior, and profit analysis through data cleaning, transformation, and SQL queries.

---

## 🔧 Tools & Technologies Used

- **Python** (pandas, numpy, sqlalchemy)
- **MySQL** and **PostgreSQL** (for relational database and queries)
- **VS Code** (development environment)
- **Kaggle API** (for dataset download)

---

## 📂 Project Workflow

1. **Data Download**  
   - Downloaded sales dataset using Kaggle API

2. **Data Cleaning & Processing using python**  
   - Removed duplicates  
   - Handled missing values  
   - Converted data types  
   - Performed currency formatting  

3. **Data Loading**  
   - Loaded cleaned data into MySQL and PostgreSQL using SQLAlchemy

4. **Database Design**  
   - Normalized the main dataset into:
     - `sales` (transactions)
     - `customers` (customer type, gender)
     - `products` (product line, unit price)
     - `branches` (branch and city)
   - Created foreign key relationships between tables

5. **SQL Analysis**  
   - Wrote and executed complex SQL queries to answer business questions:
     - Sales by city, branch, and category  
     - Profit margins by product  
     - Customer behavior (ratings, payment methods)  
     - Peak sales hours and patterns

---

## 📊 Key Insights

- Identified best-performing branches and product categories  
- Analyzed revenue trends over time  
- Explored customer preferences and ratings  
- Calculated and compared profit margins across branches

---


