DROP TABLE IF EXISTS raw_sales;

CREATE TABLE raw_sales (
    transaction_id      VARCHAR(20),
    customer_id         VARCHAR(20),
    category             VARCHAR(50),
    item                  VARCHAR(50),
    price_per_unit       NUMERIC(10,2),
    quantity              NUMERIC(10,2),
    total_spent           NUMERIC(10,2),
    payment_method        VARCHAR(30),
    location              VARCHAR(20),
    transaction_date      DATE,
    discount_applied      VARCHAR(10)
);
