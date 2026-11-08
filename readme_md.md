# 📊 Contoso 100k Retail Analytics Engine (PostgreSQL)

## 📌 Executive Summary

An end-to-end relational data analytics solution built on the **Contoso 100k** dataset using **PostgreSQL**. This project transforms over 100,000 raw sales and customer transactions into structured business intelligence, automated KPI tracking, customer segmentation, and executive-level decision assets.

### 🌟 Key Highlights

* **Modular Pipeline Architecture:** Built using chained Common Table Expressions (`WITH` clauses) for maximum query readability and maintainability.

* **Dataset-Relative Recency & Lifespan:** Dynamically calculates customer recency relative to the dataset's maximum date (April 2024) rather than system time, ensuring temporal accuracy.

* **Dual-Tier Segmentation Models:** Classifies products and customers into strategic revenue and behavioral tiers (VIP, High-Value, Medium-Value, Low-Value).

* **Robust Data Sanitation:** Prevents zero-division errors, isolates zero-order prospects, handles `NULL` outer joins, and maintains currency/exchange rate normalization across 10 years of transactions.

## 📁 Repository Structure

```
Contoso_Retail_Analytics_With_SQL/
├── ASSETS/
│   └── graphs/
│       ├── 1_change_over_time_graph.png
│       ├── 2_cumulative_analysis_graph.png
│       ├── 3_product_performance_graph.png
│       ├── 4_part_to_whole_analysis_graph.png
│       ├── 5_products_segmentation_graph.png
│       ├── 6_customers_segmentation_graph.png
│       └── 7_customer_report_executive_dashboard.png
├── DATA/
│   ├── datasets/
│   │   └── contoso_100k.sql
│   └── exports/
│       ├── 1_change_over_time_output.csv
│       ├── 2_cumulative_analysis_output.csv
│       ├── 3_product_performance_output.csv
│       ├── 4_part_to_whole_output.csv
│       ├── 5_products_segmentation_output.csv
│       ├── 6_customers_segmentation_output.csv
│       └── 7_customer_report_output.csv
├── SQL/
│   ├── 1_change_over_time.sql
│   ├── 2_cumulative_analysis.sql
│   ├── 3_product_performance_analysis.sql
│   ├── 4_part_to_whole_analysis.sql
│   ├── 5_products_segmentation.sql
│   ├── 6_customers_segmentation.sql
│   └── 7_customer_report.sql
├── .gitignore
└── README.md

```

## 📈 Phase Breakdown & Analytical Insights

### 🔹 1. Change Over Time Analysis

Tracks monthly net revenue growth and order volume from 2015 to 2024 to identify macro cyclicality and seasonal trends.

* 📜 **SQL Script:** [`SQL/1_change_over_time.sql`](SQL/1_change_over_time.sql)

* 💾 **Exported Data:** [`DATA/exports/1_change_over_time_output.csv`](DATA/exports/1_change_over_time_output.csv)

#### 💡 Analytical Findings

* **Early Growth Phase (2015–2017):** Monthly net revenue climbed from under \$500K toward $1M–$1.8M, driven by strong Q4 holiday peaks in December.

* **Rapid Expansion (2018–2019):** Significant scaling pushed monthly revenues past \$2M–$3.8M, accompanied by a major jump in order volume.

* **Post-2020 Peak Performance:** Spikes throughout 2022–2023 frequently exceeded \$4M/month, with peak order volume hitting \~4,800 orders/month.

### 🔹 2. Cumulative Revenue Analysis

Evaluates overall company momentum by tracking lifetime cumulative net revenue milestones across the 10-year timeline.

* 📜 **SQL Script:** [`SQL/2_cumulative_analysis.sql`](SQL/2_cumulative_analysis.sql)

* 💾 **Exported Data:** [`DATA/exports/2_cumulative_analysis_output.csv`](DATA/exports/2_cumulative_analysis_output.csv)

#### 💡 Analytical Findings

* **\$100M Lifetime Revenue:** Reached in **February 2021** (\$100,444,683 across 88,256 total cumulative orders).

* **\$200M Lifetime Revenue:** Reached in **January 2024** (\$200,688,516 across 192,951 total cumulative orders).

* **Final Closing Base (Apr 2024):** Closed at **\$206,407,545** across 199,873 cumulative orders.

* **Expansion Velocity:** Trajectory saw rapid steady slope from 2015–2019, followed by a plateau in 2020, before accelerating from 2021 to 2023.

### 🔹 3. Product Performance Analysis

Measures multi-year product performance against historical averages to isolate top performers and lagging inventory.

* 📜 **SQL Script:** [`SQL/3_product_performance_analysis.sql`](SQL/3_product_performance_analysis.sql)

* 💾 **Exported Data:** [`DATA/exports/3_product_performance_output.csv`](DATA/exports/3_product_performance_output.csv)

#### 💡 Analytical Findings

* **Peak Revenue Year (2022):** Total net revenue reached an all-time peak of \$44.86M (21.7% of 10-year cumulative revenue), driven by 2,102 top-performing products.

* **Long-Tail Portfolio Skew:** Across all 22,052 annual product records, 59.5% scored below multi-year benchmarks, highlighting revenue concentration in elite hardware.

* **Top 10 Contribution:** The top 10 individual products generated **\$16.75M** (8.1% of total portfolio net revenue across 10 years).

### 🔹 4. Part-to-Whole Analysis

Calculates percentage contribution by product category to identify core revenue drivers versus secondary lines.

* 📜 **SQL Script:** [`SQL/4_part_to_whole_analysis.sql`](SQL/4_part_to_whole_analysis.sql)

* 💾 **Exported Data:** [`DATA/exports/4_part_to_whole_output.csv`](DATA/exports/4_part_to_whole_output.csv)

#### 💡 Analytical Findings

* **Computers Lead Sales:** The **Computers** category represents nearly half (**43.90%**) of total company net revenue.

* **Secondary Revenue Engine:** **Cell Phones** and **Home Appliances** combine for **28.70%** of total revenue.

### 🔹 5. Products Cost-Tier Segmentation

Segments products by cost tiers (High, Medium, Premium, Luxury, Low) to measure revenue yield per price bracket.

* 📜 **SQL Script:** [`SQL/5_products_segmentation.sql`](SQL/5_products_segmentation.sql)

* 💾 **Exported Data:** [`DATA/exports/5_products_segmentation_output.csv`](DATA/exports/5_products_segmentation_output.csv)

#### 💡 Analytical Findings

* **High-Cost Segment Dominance:** High cost-range items drive \$137.69M across 76,621 products.

* **Mid & Premium Tiers:** Medium cost products generated \$35.27M, followed by Premium lines at $29.47M.

### 🔹 6. Customers Demographic & Spending Segmentation

Segments customers based on spending brackets and purchase frequencies to understand cohort behaviors.

* 📜 **SQL Script:** [`SQL/6_customers_segmentation.sql`](SQL/6_customers_segmentation.sql)

* 💾 **Exported Data:** [`DATA/exports/6_customers_segmentation_output.csv`](DATA/exports/6_customers_segmentation_output.csv)

#### 💡 Analytical Findings

* **Volume vs Spend:** Low-Value customers form the majority of customer volume (72.8%), but VIP Customers achieve the highest average spend tier at **\$14,480**.

### 🔹 7. Executive Customer Report & Multi-Tier Classification

Consolidates demographics (age groups), tenure (lifespan in months), recency (relative to dataset bounds), status (Active vs. Inactive), and dynamic spending tiers into an executive-level master report.

* 📜 **SQL Script:** [`SQL/7_customer_report.sql`](SQL/7_customer_report.sql)

* 💾 **Exported Data:** [`DATA/exports/7_customer_report_output.csv`](DATA/exports/7_customer_report_output.csv)

#### 💡 Key Strategic Insights (104,990 Customers Evaluated)

* **The Power of the VIP Tier:** 10,377 VIP Customers (spend > 2.0x average & tenure ≥ 12 months) generate **over \$101.7M in total revenue**—demonstrating that \~9.9% of the customer base drives nearly half of all lifetime sales.

* **High-Value Core:** High-Value (3,915 customers) and Medium-Value (2,052 customers) account for an additional **\$14.4M combined**, representing an ultra-engaged core target for loyalty programs.

* **Re-Engagement Potential:** The **88,646 Low-Value Customers/Prospects** generate \$90.3M collectively. Safe division and zero-order checks isolate inactive buyers for targeted retention marketing.

## 🛠 Tech Stack & Methodology

* **Database Engine:** PostgreSQL

* **SQL Techniques:** Window Functions (`SUM() OVER`, `AVG() OVER`, `MAX() OVER`), Chained CTEs, Aggregation, Conditional CASE logic, Safe Division handling.

* **Data Visualization & Analytics:** Python (`pandas`, `seaborn`, `matplotlib`)

## 🚀 How to Run the Queries

1. Clone this repository:

   ```
   git clone https://github.com/YourUsername/Contoso_Retail_Analytics_With_SQL.git
   
   ```

2. Import `DATA/datasets/contoso_100k.sql` into your PostgreSQL instance:

   ```
   psql -U your_username -d contoso_db -f DATA/datasets/contoso_100k.sql
   
   ```

3. Run any analytical script from the `SQL/` directory using your favorite PostgreSQL client (DBeaver, pgAdmin, or CLI):

   ```
   psql -U your_username -d contoso_db -f SQL/7_customer_report.sql
   
   ```

*Created as part of the Contoso 100k Retail Analytics Portfolio Project.*