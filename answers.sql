-- Question 1---
SELECT 
    OrderID,
    CustomerName,
    LTRIM(value) AS Product
FROM 
    ProductDetail
CROSS APPLY 
    STRING_SPLIT(Products, ',');

--Question 2--

-- Create the Orders table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

-- Insert data into Orders
INSERT INTO Orders (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails;

-- Create the normalized OrderDetails_2NF table
CREATE TABLE OrderDetails_2NF (
    OrderID INT,
    Product VARCHAR(100),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Insert data into OrderDetails_2NF
INSERT INTO OrderDetails_2NF (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity
FROM OrderDetails;
