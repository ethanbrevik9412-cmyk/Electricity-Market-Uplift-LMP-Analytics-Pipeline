-- 1. Top 10 highest average LMP nodes
SELECT
    settlement_location,
    AVG(lmp) AS avg_lmp,
    MAX(lmp) AS peak_lmp
FROM lmp
GROUP BY settlement_location
ORDER BY avg_lmp DESC
LIMIT 10;

-- 2. Highest price volatility nodes
SELECT
    settlement_location,
    STDDEV(lmp) AS price_volatility
FROM lmp
GROUP BY settlement_location
ORDER BY price_volatility DESC
LIMIT 10;

 
-- 3. Most common marginal fuel types

SELECT
    fuel_on_margin AS fuel_type,
    COUNT(*) AS times_marginal
FROM fuel_on_margin
WHERE fuel_on_margin IS NOT NULL
GROUP BY fuel_on_margin
ORDER BY times_marginal DESC;

 
-- 4. Congested vs normal nodes
 
SELECT
    CASE
        WHEN mcc > 0 THEN 'Congested'
        ELSE 'Normal'
    END AS node_type,
    AVG(lmp) AS avg_price
FROM lmp
GROUP BY node_type;

 
-- 5. Top 10 locations by *resource uplift* payments
 
SELECT
    settlement_location,
    SUM(total_uplift) AS total_paid
FROM resource_uplift
GROUP BY settlement_location
ORDER BY SUM(ABS(total_uplift)) DESC
LIMIT 10;

 
-- 6. Total uplift by **settlement area** (zonal uplift)
 
SELECT
    settlement_area,
    SUM(total_uplift) AS total_uplift
FROM zonal_uplift
GROUP BY settlement_area
ORDER BY total_uplift DESC;

 
-- 7. Monthly system uplift cost (resource uplift)
 
SELECT
    TO_CHAR(reference_month, 'MM/YYYY') AS reference_month,
    SUM(total_uplift) AS system_uplift_cost
FROM resource_uplift
GROUP BY reference_month
ORDER BY reference_month;

 
-- 8. Join LMP + resource uplift by node
 
SELECT
    l.settlement_location,
    AVG(l.lmp) AS avg_lmp,
    SUM(r.total_uplift) AS total_uplift
FROM lmp l
JOIN resource_uplift r
    ON l.settlement_location = r.settlement_location
GROUP BY l.settlement_location
ORDER BY total_uplift DESC
LIMIT 30;