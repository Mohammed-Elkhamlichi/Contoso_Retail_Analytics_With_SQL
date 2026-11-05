# Contoso Retail Analytics With SQL:

Contoso_Retail_Analytics_With_SQL/
├── ASSETS/
│ ├── graphs/
│ │ ├── 01_yearly_performance_revenue.png
│ │ ├── 01_monthly_seasonality.png
│ │ └── 01_year_month_trend.png
│ └── ERD_Diagram.png
├── DATA/
│ ├── raw/
│ │ └── contoso_100k.sql
│ └── exports/
│ ├── phase_1_yearly_performance.csv
│ ├── phase_1_monthly_performance.csv
│ └── phase_1_year_month_performance.csv
├── SQL/
│ ├── 01_change_over_time.sql
│ ├── 02_cumulative_analysis.sql
│ ├── 03_performance_analysis.sql
│ ├── 04_part_to_whole.sql
│ ├── 05_data_segmentation.sql
│ └── 06_executive_reports.sql
├── .gitignore
└── README.md

## 📈 Phase 1: Change Over Time Analysis

### 1. Year-Month Revenue Trend

Tracks monthly financial growth and sales volume from 2015 to 2024.

- **SQL Script:** [`SQL/01_change_over_time.sql`](SQL/01_change_over_time.sql)
- **Exported Data:** [`DATA/exports/phase_1_year_month_performance.csv`](DATA/exports/phase_1_year_month_performance.csv)

![Year-Month Revenue Trend](ASSETS/graphs/01_year_month_trend.png)

#### Analytical Findings

- **Annual Peak:** 2022 generated the highest annual net revenue ($44.86M).
- **Monthly Peak:** February 2022 recorded the single highest sales month ($4.84M).
- **Seasonality:** Consistently exhibits a Q1 surge in February and a demand valley in April across fiscal years.

## 2. Cumulative Analysis

#### + Aggregating data progressively over time to track business expansion.

#### + Calculating running totals and moving averages using advanced window functions.

## 3. Performance Analysis

#### + Comparing current metric values against historical targets, averages, or previous periods.

#### + Executing Year-over-Year (YoY) and Month-over-Month (MoM) comparative evaluations with conditional status flags.

## 4. Part-to-Whole Analysis

#### + Evaluating the proportional contribution of individual categories relative to the overall global total.

#### + Identifying dominant revenue drivers versus minor or underperforming category segments.

## 5. Data Segmentation

#### + Converting continuous numerical measures into brand-new dimensional categories using conditional logic.

#### + Establishing behavioral customer tiers (VIP, Regular, New) based on historical lifespan and total spending.

#### + Grouping product items into defined cost and revenue performance ranges.

## 6. Executive Reporting Views

#### + Consolidating core metrics, key performance indicators (KPIs), and behavioral segments into unified datasets.

#### + Creating modular database views (CREATE VIEW) to streamline consumption for business stakeholders and visualization tools.

```

```
