CREATE OR REPLACE VIEW clean_sales AS
SELECT
    transaction_id,
    customer_id,
    category,
    COALESCE(item, 'Sin especificar') AS item,
    COALESCE(price_per_unit, ROUND(total_spent / NULLIF(quantity, 0), 2)) AS price_per_unit,
    quantity,
    total_spent,
    payment_method,
    location,
    transaction_date,
    CASE
        WHEN discount_applied = 'true' THEN TRUE
        WHEN discount_applied = 'false' THEN FALSE
        ELSE FALSE
    END AS discount_applied
FROM raw_sales
WHERE NOT (quantity IS NULL AND total_spent IS NULL);
