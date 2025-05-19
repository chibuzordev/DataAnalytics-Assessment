WITH transactions_monthly AS(
	SELECT 
		owner_id,
        DATE_FORMAT(created_on, "%Y-%m") AS tra_month,
        COUNT(*) AS tra_count
	FROM savings_savingsaccount
    GROUP BY owner_id, tra_month
),
avg_tra_per_customer AS(
	SELECT
		owner_id,
        AVG(tra_count) AS avg_tra_monthly
	FROM transactions_monthly
    GROUP BY owner_id
),
categorized AS(
	SELECT 
		*,
        CASE
			WHEN avg_tra_monthly >=10 THEN "High Frequency"
            WHEN avg_tra_monthly BETWEEN 3 AND 9 THEN "Medium Frequency"
			ELSE "Low frequency"
		END AS frequency_category
	FROM avg_tra_per_customer
)

SELECT
	frequency_category,
    COUNT(*) AS customer_count,
    ROUND(AVG(avg_tra_monthly), 1) AS avg_tra_monthly
FROM categorized
GROUP BY frequency_category
ORDER BY customer_count ASC;