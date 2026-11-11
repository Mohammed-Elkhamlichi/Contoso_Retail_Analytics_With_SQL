# Developer Setup Guide & Database Documentation

Welcome to the project! This guide will help you set up your local development environment, restore the **Contoso 100K** database schema, and understand the core data model.

---

## 🛠️ Prerequisites

Before you begin, ensure you have installed:

- **Git**
- **PostgreSQL** (version 14 or higher recommended)
- **pgAdmin 4** (optional, recommended for GUI users)

---

## 🚀 Quick Start Guide

### Step 1: Download or Locate `contoso_100k.sql`

Ensure the file `contoso_100k.sql` is downloaded into your local directory (e.g., your `Downloads` folder or working directory).

---

### Step 2: Create the `contoso_100k` Database

Open your terminal (or Command Prompt) and connect to PostgreSQL:

```bash
psql -U postgres
```

Inside the `psql` interactive prompt, run:

```sql
CREATE DATABASE contoso_100k;
\q
```

---

### Step 3: Restore the Database (`contoso_100k.sql`)

Choose **Method A** (Terminal) or **Method B** (pgAdmin / `psql` Interactive):

#### Method A: Command Line (Quickest)

Run the following command from your terminal inside the folder containing `contoso_100k.sql`:

```bash
psql -U postgres -d contoso_100k -f contoso_100k.sql
```

_Or using shell input redirection:_

```bash
psql -U postgres -d contoso_100k < contoso_100k.sql
```

#### Method B: Inside pgAdmin / PSQL Console

1. Connect to the `contoso_100k` database:
    ```bash
    psql -U postgres -d contoso_100k
    ```
2. Execute the import command (`\i`) with the full path to your SQL file:
    ```sql
    \i '/path/to/your/contoso_100k.sql'
    ```
    _(On Windows, example: `\i 'C:/Users/YourName/Downloads/contoso_100k.sql'`)_

---

### Step 4: Verify the Database Setup

Check that all tables were created properly by connecting and listing the tables:

```sql
psql -U postgres -d contoso_100k
```

Run this inside `psql`:

```sql
\dt
```

You should see 6 main tables created: `sales`, `customer`, `product`, `store`, `date`, and `currencyexchange`.

---

## 📊 Database Schema Overview

The `contoso_100k` database is a standard star schema dataset for retail analytics:

| Table Name             | Description                                | Key Columns                                                      |
| :--------------------- | :----------------------------------------- | :--------------------------------------------------------------- |
| **`sales`**            | Fact table containing transaction logs     | `orderkey`, `customerkey`, `storekey`, `productkey`, `orderdate` |
| **`customer`**         | Customer demographic & profile data        | `customerkey`, `name`, `city`, `country`                         |
| **`product`**          | Catalog details, hierarchy, & prices       | `productkey`, `productname`, `category`, `subcategory`           |
| **`store`**            | Retail store metadata & locations          | `storekey`, `storename`, `country`                               |
| **`date`**             | Date dimension for time-series aggregation | `date`, `datekey`, `year`, `quarter`                             |
| **`currencyexchange`** | Daily historical currency exchange rates   | `date`, `fromcurrency`, `tocurrency`, `exchange_rate`            |

---

## 💡 Quick Query Test

Test your setup by executing this query:

```sql
SELECT
    p.categoryname,
    SUM(s.quantity * s.netprice) AS total_revenue
FROM sales s
LEFT JOIN product p ON s.productkey = p.productkey
GROUP BY p.categoryname
ORDER BY total_revenue DESC;
```
