/*
Here are 10 questions you can use to practice data analysis with the dataset:
1. What is the average transaction amount for each merchant?
2. How many transactions were made using each card type (Credit vs. Debit)?
3. Which merchant had the highest total transaction amount over the dataset period?
4. What is the distribution of transaction amounts by merchant category?
5. Which age group has the highest average transaction amount?
6. What is the ratio of male to female customers for each card issuer?
7. How does the average transaction amount vary by card issuer?
8. What are the top 5 customers with the highest total transaction amounts?
9. How many transactions were made by customers aged 30-40?
10. What is the total transaction amount for each month in the dataset?
*/
SELECT TOP 10 *
FROM credit_card;

-- 1. What is the average transaction amount for each merchant?
SELECT MerchantName, ROUND(AVG(TransactionAmount),2) AS AvgTransactionAmount
FROM credit_card
GROUP BY MerchantName

--2. How many transactions were made using each card type (Credit vs. Debit)?
SELECT CardType, COUNT(TransactionAmount) AS Number_of_Transactions
FROM credit_card
GROUP BY CardType

--3 Which merchant had the highest total transaction amount over the dataset period?
SELECT MerchantName, ROUND(SUM(TransactionAmount),2) AS Transaction_Amount_Sum
FROM credit_card
GROUP BY MerchantName
ORDER BY Transaction_Amount_Sum DESC

--4  What is the distribution of transaction amounts by merchant category?
SELECT MerchantCategory, ROUND(SUM(TransactionAmount),2) AS Sum_Transaction_Amount,
	ROUND(AVG(TransactionAmount),2) AS Avg_Transaction_Amount,
	COUNT(TransactionAmount) AS Transaction_Amount_Count
FROM credit_card
GROUP BY MerchantCategory

--5 Which age group has the highest average transaction amount?
SELECT 
    CASE 
        WHEN CustomerAge BETWEEN 18 AND 29 THEN '18-29'
        WHEN CustomerAge BETWEEN 30 AND 39 THEN '30-39'
        WHEN CustomerAge BETWEEN 40 AND 49 THEN '40-49'
        WHEN CustomerAge BETWEEN 50 AND 59 THEN '50-59'
        WHEN CustomerAge >= 60 THEN '60+'
        ELSE 'Unknown'
    END AS AgeGroup,
    ROUND(AVG(TransactionAmount),2) AS AverageTransactionAmount
FROM credit_card
GROUP BY 
    CASE 
        WHEN CustomerAge BETWEEN 18 AND 29 THEN '18-29'
        WHEN CustomerAge BETWEEN 30 AND 39 THEN '30-39'
        WHEN CustomerAge BETWEEN 40 AND 49 THEN '40-49'
        WHEN CustomerAge BETWEEN 50 AND 59 THEN '50-59'
        WHEN CustomerAge >= 60 THEN '60+'
        ELSE 'Unknown'
    END
ORDER BY AgeGroup;

-- 6 What is the ratio of male to female customers for each card issuer?
SELECT CardIssuer,
    SUM(CASE WHEN CustomerGender = 'Male' THEN 1 ELSE 0 END) AS MaleCount,
    SUM(CASE WHEN CustomerGender = 'Female' THEN 1 ELSE 0 END) AS FemaleCount,
    (SUM(CASE WHEN CustomerGender = 'Male' THEN 1 ELSE 0 END) * 1.0 / 
     SUM(CASE WHEN CustomerGender = 'Female' THEN 1 ELSE 0 END)) AS MaleToFemaleRatio
FROM credit_card
GROUP BY CardIssuer;

-- 7 How does the average transaction amount vary by card issuer?
SELECT CardIssuer, ROUND(AVG(TransactionAmount),2) AS AverageTransactionAmount
FROM credit_card
GROUP BY CardIssuer
ORDER BY AverageTransactionAmount DESC

-- 8 What are the top 5 customers with the highest total transaction amounts?
SELECT  TOP 5 CustomerID, ROUND(SUM(TransactionAmount),2) AS TotalAmount
FROM credit_card
GROUP BY CustomerID
ORDER BY TotalAmount DESC

-- 9 How many transactions were made by customers aged 30-40?
SELECT CustomerAge, COUNT(*) AS TransactionCount
FROM credit_card
WHERE CustomerAge BETWEEN 30 AND 40
GROUP BY CustomerAge;

--10 What is the total transaction amount for each month in the dataset?
SELECT 
    FORMAT(TransactionDate, 'yyyy-MM') AS Month, 
    ROUND(SUM(TransactionAmount), 2) AS Monthly_Transaction_Amount
FROM credit_card
GROUP BY 
    FORMAT(TransactionDate, 'yyyy-MM')
ORDER BY 
    Month;