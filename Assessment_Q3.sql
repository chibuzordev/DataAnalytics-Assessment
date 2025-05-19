SELECT 
    id AS plan_id,
    owner_id,
    'Investment' AS type,
    created_on,
    DATEDIFF(CURDATE(), created_on) AS inactivity_days
FROM plans_plan
WHERE status_id = 1
  AND created_on < CURDATE() - INTERVAL 365 DAY

UNION

SELECT 
    id AS plan_id,
    owner_id,
    'Investment' AS type,
    transaction_date,
    DATEDIFF(CURDATE(), transaction_date) AS inactivity_days
FROM savings_savingsaccount
WHERE transaction_date < CURDATE() - INTERVAL 365 DAY
;
  