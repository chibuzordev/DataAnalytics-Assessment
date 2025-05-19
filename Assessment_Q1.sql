WITH funded_savings AS(
	SELECT owner_id, COUNT(*) as savings_count, SUM(amount) as savings_total
    FROM savings_savingsaccount
    WHERE transaction_status = "success"
    GROUP BY owner_id
),
funded_investments AS(
	SELECT owner_id, COUNT(*) AS investment_count, SUM(amount) as investments_total
    FROM plans_plan
    WHERE status_id = 1
    GROUP BY owner_id
),
combined AS (
    SELECT 
        u.id AS owner_id,
        CONCAT(u.first_name, " ", u.last_name) as name,
        fs.savings_count,
        fi.investment_count,
        IFNULL(fs.savings_total, 0) + IFNULL(fi.investments_total, 0) AS total_deposits
    FROM users_customuser u
    JOIN funded_savings fs ON u.id = fs.owner_id
    JOIN funded_investments fi ON u.id = fi.owner_id
)

SELECT *
FROM combined
ORDER BY total_deposits DESC;