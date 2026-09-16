-- Nulos por columna
SELECT
    COUNT(*) AS total_filas,
    COUNT(*) - COUNT(transaction_id)   AS nulos_transaction_id,
    COUNT(*) - COUNT(customer_id)      AS nulos_customer_id,
    COUNT(*) - COUNT(category)         AS nulos_category,
    COUNT(*) - COUNT(item)             AS nulos_item,
    COUNT(*) - COUNT(price_per_unit)   AS nulos_price_per_unit,
    COUNT(*) - COUNT(quantity)         AS nulos_quantity,
    COUNT(*) - COUNT(total_spent)      AS nulos_total_spent,
    COUNT(*) - COUNT(payment_method)   AS nulos_payment_method,
    COUNT(*) - COUNT(location)         AS nulos_location,
    COUNT(*) - COUNT(transaction_date) AS nulos_transaction_date,
    COUNT(*) - COUNT(discount_applied) AS nulos_discount_applied
FROM raw_sales;

-- Duplicados en transaction_id
SELECT transaction_id, COUNT(*) AS veces
FROM raw_sales
GROUP BY transaction_id
HAVING COUNT(*) > 1;

-- Validación cruzada: price_per_unit * quantity = total_spent
SELECT COUNT(*) AS filas_inconsistentes
FROM raw_sales
WHERE price_per_unit IS NOT NULL
  AND quantity IS NOT NULL
  AND total_spent IS NOT NULL
  AND ROUND(total_spent - (price_per_unit * quantity), 2) <> 0;

-- Valores únicos de discount_applied
SELECT discount_applied, COUNT(*)
FROM raw_sales
GROUP BY discount_applied;

-- Rangos generales
SELECT
    MIN(transaction_date) AS fecha_min,
    MAX(transaction_date) AS fecha_max,
    MIN(price_per_unit) AS precio_min,
    MAX(price_per_unit) AS precio_max,
    MIN(quantity) AS cantidad_min,
    MAX(quantity) AS cantidad_max,
    MIN(total_spent) AS total_min,
    MAX(total_spent) AS total_max
FROM raw_sales;

-- Patrón de nulos recuperables (price/quantity/total)
SELECT
    COUNT(*) FILTER (
        WHERE price_per_unit IS NULL AND quantity IS NOT NULL AND total_spent IS NOT NULL
    ) AS recuperable_price,
    COUNT(*) FILTER (
        WHERE (price_per_unit IS NULL AND quantity IS NULL)
           OR (price_per_unit IS NULL AND total_spent IS NULL)
           OR (quantity IS NULL AND total_spent IS NULL)
    ) AS dos_o_mas_nulos_no_recuperables
FROM raw_sales;
