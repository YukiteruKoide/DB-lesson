-- GROUP BY
SELECT age,COUNT(*),MAX(birth_day),MIN(birth_day) FROM users u 
WHERE birth_place ="日本"
GROUP BY age
ORDER BY COUNT(*);



SELECT department,SUM(salary),FLOOR(AVG(salary)),MIN(salary) FROM employees
WHERE age > 40
GROUP BY department
;


SELECT
	CASE
		WHEN name IN ("香川県","高知県","愛媛県","徳島県") THEN "四国"
		ELSE "その他"
	END AS "地域名",COUNT(*)
FROM 
	prefectures
GROUP BY
	CASE
		WHEN name IN ("香川県","高知県","愛媛県","徳島県") THEN "四国"
		ELSE "その他"
	END;
	
-- CASE
SELECT 
	age,
	CASE
		WHEN age < 20 THEN "未成年"
		ELSE "成人"
		END AS "分類",
		COUNT(*)
FROM users
GROUP BY age ;
