# Olist e-commerce analysis: SQL and pandas

SQL and pandas work on the Olist Brazilian e-commerce dataset (about 100,000 orders, 2016-2018), using PostgreSQL. It covers joins, window functions, cohort and funnel analysis, query performance and data modeling, and ends with a written analysis of delivery performance.


| Folder | Contents |
|---|---|
| sql/ | Table definitions (00_schema.sql)|
| queries/ | Numbered query files: aggregates, joins, CASE and NULLs, CTEs, window functions |

## Setup

1. Install PostgreSQL and pgAdmin, and create a database called olist.
2. Download the dataset from Kaggle (Brazilian E-Commerce Public Dataset by Olist) into data/. The data is not included in this repo.
3. Run sql/00_schema.sql, then load each CSV with the \copy commands in sql/insert.txt.
4. For the notebooks: create a virtual environment, run pip install -r requirements.txt, and copy .env.example to .env with your database password.
5. Run the tests with python -m pytest -q.

## Data model

One row in the central fact table is one item in one order. Dimensions: customers, products, sellers, date. See docs/olist_schema.png.

