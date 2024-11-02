use DA
--Duplicate Employee Check

SELECT EmployeeID, COUNT(*) AS DuplicateCount
FROM Employees
GROUP BY EmployeeID 
HAVING COUNT(*) > 1;


--Duplicate Order Check

SELECT OrderID, COUNT(*) AS DuplicateCount
FROM Orders
GROUP BY OrderID 
HAVING COUNT(*) > 1;


--Employee Salary with Bonus Calculation
SELECT Full_Name, Salary,
       COALESCE(bonus, Salary, 0) AS Total_bonus,
       (Salary * COALESCE(bonus, 0)) + Salary AS Total_Salaries
FROM Employees;


--Employee Count and Average Salary by Department

SELECT Department, COUNT(EmployeeID) AS NO_Emp, ROUND(AVG(Salary), 2) AS 'Average Salary based on NO.Emp'
FROM Department dep INNER JOIN Employees emp ON dep.Department_ID = emp.Department_ID
GROUP BY Department
ORDER BY NO_Emp DESC;



--Employee Count and Salary Sum by Status

SELECT Status, COUNT(EmployeeID) AS NO_Emp, ROUND(SUM(Salary), 2) AS 'Total Salaries'
FROM Employees
GROUP BY Status
ORDER BY [Total Salaries] DESC;



--Average Salary by Department and Status (Including Bonus)

SELECT Department, Status, COUNT(EmployeeID) AS NO_Emp, ROUND(AVG((Salary * bonus) + Salary), 2) AS 'Average Salary based on NO.Emp'
FROM Department dep INNER JOIN Employees emp ON dep.Department_ID = emp.Department_ID
GROUP BY Department, Status
ORDER BY Status DESC, 'Average Salary based on NO.Emp' DESC;


--Count of Employees with Bonus by Department and Status

SELECT Department, Status, COUNT(EmployeeID) AS NO_Emp
FROM Department dep INNER JOIN Employees emp ON dep.Department_ID = emp.Department_ID
WHERE emp.bonus > 0
GROUP BY Department, Status
ORDER BY NO_Emp DESC;




--Product and Sales Data

--Product Count by Category

SELECT Category, COUNT(ProductID) AS Total_Products
FROM Product
GROUP BY Category
ORDER BY Total_Products DESC;


--Total Quantity Ordered by Product for Completed Orders
select Product_NE , Sum(Quantity) as 'Quantity Orderd'
from Product pro inner join Orders ord
on pro.ProductID=ord.Product_ID
where ord.Status=1
group by Product_NE
order by 'Quantity Orderd' desc



--Total Revenue per Product

SELECT Product_NE, ROUND(SUM(Price * Quantity), 2) AS Total_Revenue_For_Each_Product
FROM Product pro LEFT JOIN Orders ord ON pro.ProductID = ord.Product_ID
GROUP BY Product_NE
ORDER BY Total_Revenue_For_Each_Product DESC;


--Total Revenue per Category

SELECT Category, ROUND(SUM(Price*Quantity), 2) AS Total_Revenue_For_Each_Category
FROM Product pro LEFT JOIN Orders ord ON pro.ProductID = ord.Product_ID
GROUP BY Category
ORDER BY Total_Revenue_For_Each_Category DESC;


--Top 10 Products by Revenue for Completed Orders

SELECT TOP 10 Product_NE, SUM(Quantity) AS AC_Order, ROUND(SUM(Price), 2) AS Total_Revenue
FROM Product pro LEFT JOIN Orders ord ON pro.ProductID = ord.Product_ID
WHERE ord.Status = 1
GROUP BY Product_NE
ORDER BY AC_Order DESC, Total_Revenue DESC;


--Top 10 Products by Revenue for Failed Orders

SELECT TOP 10 Product_NE, SUM(Quantity) AS FE_Order, SUM(price) AS Total_Lost
FROM Orders ord INNER JOIN Product pro ON ord.Product_ID = pro.ProductID
WHERE Status = 0
GROUP BY Product_NE
ORDER BY FE_Order DESC;


--Top 20 Orders by Country and Product

SELECT TOP 20 Country, Product_NE, SUM(Quantity) AS Total_Order, ROUND(SUM(Price), 2) AS Total_Revenue
FROM Product pro
     INNER JOIN Orders ord ON pro.ProductID = ord.Product_ID
     INNER JOIN Customers cust ON ord.CustomerID = cust.CustomerID
     INNER JOIN Country coun ON cust.Country_ID = coun.Country_ID
WHERE ord.Status = 1
GROUP BY Country, Product_NE
ORDER BY Total_Order DESC;




--Customer and Order Data
--Top 10 Customers by Total Purchases

SELECT TOP 10 Customer_N, Country, COUNT(OrderID) AS 'Total Orders', SUM(Price * Quantity) AS 'Total Purchases'
FROM Customers cust
     INNER JOIN Orders ord ON cust.CustomerID = ord.CustomerID
     INNER JOIN Country coun ON cust.Country_ID = coun.Country_ID
GROUP BY Customer_N, Country
ORDER BY 'Total Purchases' DESC;


--Top 10 Employees by Number of Work Orders

SELECT TOP 10 Full_Name, COUNT(OrderID) AS NO_Work_Orders
FROM Employees emp INNER JOIN Orders ord ON emp.EmployeeID = ord.EmployeeID
GROUP BY Full_Name
ORDER BY NO_Work_Orders DESC;



--Total Orders by Money Transfer Method

SELECT MonyTransfere, COUNT(OrderID) AS Total_Orders
FROM Orders ord
     INNER JOIN Customers cust ON ord.CustomerID = cust.CustomerID
     INNER JOIN MonyTransfere MT ON cust.MonyTransfere_ID = MT.MonyTransfere_ID
GROUP BY MonyTransfere
ORDER BY Total_Orders DESC;



