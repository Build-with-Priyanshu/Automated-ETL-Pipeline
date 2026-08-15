-- Connect to the database
CREATE DATABASE IF NOT EXISTS etl_project;
USE etl_project;


-- ============================================================
-- Indexes on Transactions Table
-- ============================================================

CREATE INDEX idx_customer_id
ON transactions (CustomerID);

CREATE INDEX idx_invoice_date
ON transactions (InvoiceDate);

CREATE INDEX idx_stock_code
ON transactions (StockCode);

CREATE INDEX idx_country
ON transactions (Country);


-- ============================================================
-- Customer Summary Table
-- ============================================================

CREATE TABLE IF NOT EXISTS customer_summary (
    CustomerID INT PRIMARY KEY,
    FirstPurchaseDate DATETIME,
    LastPurchaseDate DATETIME,
    TotalPurchases INT,
    TotalAmountSpent DECIMAL(15, 2),
    AverageOrderValue DECIMAL(10, 2)
);


-- Index for faster filtering/sorting by last purchase date
CREATE INDEX idx_last_purchase
ON customer_summary (LastPurchaseDate);


-- ============================================================
-- Product Summary Table
-- ============================================================

CREATE TABLE IF NOT EXISTS product_summary (
    StockCode VARCHAR(255) PRIMARY KEY,
    TotalUnitsSold INT,
    TotalRevenue DECIMAL(15, 2),
    AveragePrice DECIMAL(10, 2)
);


-- ============================================================
-- Analytics Views
-- ============================================================

-- Customer Purchase History View
CREATE OR REPLACE VIEW customer_purchase_history AS
SELECT
    ct.CustomerID,
    ct.InvoiceNo,
    ct.StockCode,
    ct.Description,
    ct.Quantity,
    ct.UnitPrice,
    ct.InvoiceDate,
    ct.TotalPrice
FROM transactions ct;


-- Product Sales Overview View
CREATE OR REPLACE VIEW product_sales_overview AS
SELECT
    ct.StockCode,
    ct.Description,
    SUM(ct.Quantity) AS TotalUnitsSold,
    SUM(ct.TotalPrice) AS TotalRevenue,
    AVG(ct.UnitPrice) AS AveragePrice
FROM transactions ct
GROUP BY
    ct.StockCode,
    ct.Description;


-- Customer Segments View
CREATE OR REPLACE VIEW customer_segments AS
WITH CustomerPurchaseCounts AS (
    SELECT
        CustomerID,
        COUNT(DISTINCT InvoiceNo) AS PurchaseFrequency
    FROM transactions
    WHERE CustomerID IS NOT NULL
    GROUP BY CustomerID
)
SELECT
    cpc.CustomerID,
    cpc.PurchaseFrequency,
    CASE
        WHEN cpc.PurchaseFrequency > 10 THEN 'Frequent Buyer'
        WHEN cpc.PurchaseFrequency > 3 THEN 'Regular Buyer'
        ELSE 'Occasional Buyer'
    END AS CustomerSegment
FROM CustomerPurchaseCounts cpc;


-- ============================================================
-- Refresh Customer Summary Table
-- ============================================================

TRUNCATE TABLE customer_summary;

INSERT INTO customer_summary (
    CustomerID,
    FirstPurchaseDate,
    LastPurchaseDate,
    TotalPurchases,
    TotalAmountSpent,
    AverageOrderValue
)
SELECT
    CustomerID,
    MIN(InvoiceDate) AS FirstPurchaseDate,
    MAX(InvoiceDate) AS LastPurchaseDate,
    COUNT(DISTINCT InvoiceNo) AS TotalPurchases,
    SUM(TotalPrice) AS TotalAmountSpent,
    SUM(TotalPrice) / COUNT(DISTINCT InvoiceNo) AS AverageOrderValue
FROM transactions
WHERE CustomerID IS NOT NULL
GROUP BY CustomerID;


-- ============================================================
-- Refresh Product Summary Table
-- ============================================================

TRUNCATE TABLE product_summary;

INSERT INTO product_summary (
    StockCode,
    TotalUnitsSold,
    TotalRevenue,
    AveragePrice
)
SELECT
    StockCode,
    SUM(Quantity) AS TotalUnitsSold,
    SUM(TotalPrice) AS TotalRevenue,
    AVG(UnitPrice) AS AveragePrice
FROM transactions
GROUP BY StockCode;