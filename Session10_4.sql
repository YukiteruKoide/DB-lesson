SELECT * FROM employees;

-- HAVING
SELECT department, AVG(salary) 
FROM employees 
GROUP BY department 
HAVING AVG(salary)>3980000;


SELECT birth_place, age ,COUNT(*) FROM users
GROUP BY birth_place ,age
HAVING COUNT(*)>2
ORDER BY age
;

-- HAVINGのみ
SELECT 
	"重複なし"
FROM 
	users
HAVING
	count(DISTINCT name)=COUNT(name)
	;

