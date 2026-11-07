# Contoso Retail Analytics With SQL:

<br>

**Contoso_Retail_Analytics_With_SQL/ <br>
├── .vscode/ <br>
├── ASSETS/ <br>
│ └── graphs/ <br>
│ ├── phase_1_change_over_time_analysis_graph.png <br>
│ ├── phase_2_cumulative_analysis_graph.png <br>
│ └── phase_3_product_performance_graph.png <br>
├── DATA/ <br>
│ ├── datasets/ <br>
│ │ └── contoso_100k.sql <br>
│ └── exports/ <br>
│ ├── phase_1_change_over_time_analysis_output.csv <br>
│ ├── phase_2_cumulative_analysis_output.csv <br>
│ └── phase_3_product_performance_output.csv <br>
├── SQL/ <br>
│ ├── 1_change_over_time.sql <br>
│ ├── 2_cumulative_analysis.sql <br>
│ ├── 3_product_performance_analysis.sql <br>
│ └── 4_part_to_whole_analysis.sql <br>
├── .gitignore <br>
└── README.md <br>**
<br>
<br>
<br>

## **📈 1. Change Over Time Analysis**

### Year-Month Revenue Trend

Tracks monthly financial growth and sales volume from 2015 to 2024.

- **SQL Script:** [`SQL/1_change_over_time.sql`](SQL/1_change_over_time.sql)
- **Exported Data:** [`DATA/exports/1_change_over_time_output.csv`](DATA/exports/1_change_over_time_output.csv)

![Year-Month Revenue Trend](ASSETS/graphs/1_change_over_time_graph.png)

#### Analytical Findings

- **Early Growth Phase (2015–2017):** Monthly net revenue steadily climbed from under $500K toward consistent $1M–$1.8M ranges, with strong year-end holiday peaks in December.

- **Rapid Expansion (2018–2019):** Significant scaling pushed monthly revenues past $2M–$3.8M, accompanied by a major jump in order volume.

- **Post-2020 Peak Performance:** Marked by substantial spikes throughout 2022 and 2023, where monthly net revenue frequently exceeded $4M and order volumes peaked near 4,800 orders per month.
  <br>
  <br>
  <br>

# **2. Cumulative Analysis**

Tracks monthly financial growth and sales volume from 2015 to 2024.

- **SQL Script:** [`SQL/2_cumulative_analysis.sql`](SQL/2_cumulative_analysis.sql)
- **Exported Data:** [`DATA/exports/2_cumulative_analysis_output.csv`](DATA/exports/2_cumulative_analysis_output.csv)

![Cumulative Analysis](ASSETS/graphs/2_cumulative_analysis_graph.png)

#### Analytical Findings

**Milestone Achievements ($100M & $200M Net Revenue):**

- $100M Lifetime Revenue: Reached in February 2021 ($100,444,683 across 88,256 total cumulative orders).

- $200M Lifetime Revenue: Reached in January 2024 ($200,688,516 across 192,951 total cumulative orders).

- Final Revenue Base (Apr 2024): Closed at $206,407,545 across 199,873 cumulative orders.

**Expansion Velocity Trajectory:**

- 2015 – 2019 Growth Phase: Steep constant upward slope, driving the company from $1M to $87.4M cumulative revenue in 5 years.

- 2020 Growth Plateau: The curve flattened significantly throughout 2020 due to macro contraction, taking 12 months to add under $11M in cumulative revenue.

- 2021 – 2023 Acceleration Phase: Resumed rapid upward scaling, adding over $100M in revenue in under 3 years.
  <br>
  <br>
  <br>

# **3. Product Performance Analysis**

Tracks monthly financial growth and sales volume from 2015 to 2024.

- **SQL Script:** [`SQL/3_product_performance.sql`](SQL/3_product_performance.sql)
- **Exported Data:** [`DATA/exports/3_product_performance_output.csv`](DATA/exports/3_product_performance_output.csv)

![Product Performance](ASSETS/graphs/3_product_performance_graph.png)

#### Analytical Findings

**1. Macro Revenue Expansion & Volatility Trajectory
Peak Revenue Year (2022):**

- Total net revenue reached an all-time peak of $44,864,557 in 2022 (accounting for 21.7% of the cumulative $206.4M 10-year revenue), driven by 2,102 products outperforming their multi-year historical average.

**Contraction Years (2020 & 2023–2024):**

- In 2020, revenue dropped to $11.2M, with 1,726 products (86%) experiencing a YoY revenue decline due to macroeconomic contraction.

- In 2024 (partial data), 1,875 products lagged below their multi-year benchmark.

**2. Product Performance Tiering & Portfolio Skew
Long-Tail Product Distribution:**

- Across all 22,052 annual records, 59.5% (13,127 records) were categorized as Below Average relative to their multi-year benchmark, while 40.4% (8,911 records) qualified as Above Average.

- High Concentration of Elite Performers: Top-tier revenue is heavily concentrated in high-end Desktop hardware (e.g., WWI Desktop PC2.33 X2330 Silver with $1.98M lifetime revenue).

- Top 10 Contribution: The top 10 individual products generated $16.75M, representing 8.1% of total portfolio net revenue across the 10-year window.
  <br>
  <br>
  <br>

# **4. Part-to-Whole Analysis**

Which categories contribute the most to overall revenue?.

- **SQL Script:** [`SQL/4_part_to_whole_analysis.sql`](SQL/4_part_to_whole_analysis.sql)
- **Exported Data:** [`DATA/exports/4_part_to_whole_output.csv`](DATA/exports/4_part_to_whole_output.csv)

![Part-to-Whole Analysis](ASSETS/graphs/4_part_to_whole_analysis_graph.png)

#### Analytical Findings

- Computers lead all sales categories, representing nearly half (43.90%) of total revenue.

- Cell phones and Home Appliances form the strong secondary revenue tier, combining for 28.70%.
  <br>
  <br>
  <br>

# **5. Products Segmentation**

Which categories contribute the most to overall revenue?.

- **SQL Script:** [`SQL/5_products_segmentation.sql`](SQL/5_products_segmentation.sql)
- **Exported Data:** [`DATA/exports/5_products_segmentation_output.csv`](DATA/exports/5_products_segmentation_output.csv)

![Products Segmentation](ASSETS/graphs/5_products_segmentation_graph.png)

#### Analytical Findings

- **High-Cost Dominance:** The High cost-range segment is the primary engine of revenue generation, producing $137.69M across 76,621 products.

- **Mid-Tier & Premium Performance:** Medium cost-range products generated $35.27M, closely followed by Premium products at $29.47M. Luxury ($2.81M) and Low ($1.16M) cost tiers capture smaller, highly specialized or volume-fringe segments.
  <br>
  <br>
  <br>

# **6. Customers Segmentation**

Which categories contribute the most to overall revenue?.

- **SQL Script:** [`SQL/6_customers_segmentation.sql`](SQL/6_customers_segmentation.sql)
- **Exported Data:** [`DATA/exports/6_customers_segmentation_output.csv`](DATA/exports/6_customers_segmentation_output.csv)

![Customers Segmentation](ASSETS/graphs/6_customers_segmentation_graph.png)

#### Analytical Findings

- **Volume Distribution:** The Low-Value Customer tier forms the vast majority of the customer base with 35,575 customers (approx. 72.8% of total profile volume), whereas VIP Customers (4,711), High-Value Customers (5,161), and Medium-Value Customers (4,040) represent a high-value engaged core.

- **Spend vs. Volume Trade-off:** While Low-Value customers drive sheer transaction volume, VIP Customers command the highest average spend tier at $14,480, followed by High-Value customers at $6,004, Medium-Value at $3,093, and Low-Value at $2,662.
