-- Create CUSTOMERS table
CREATE TABLE customers (
    customer_id NUMBER PRIMARY KEY,
    customer_name VARCHAR2(50),
    city VARCHAR2(50)
);

-- Create ORDERS table
CREATE TABLE orders (
    order_id NUMBER PRIMARY KEY,
    customer_id NUMBER,
    order_date DATE,
    amount NUMBER(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);


---- Inserting data into above tables ----
-- Insert sample data into CUSTOMERS
INSERT INTO customers VALUES (1, 'Ravi Kumar', 'Hyderabad');
INSERT INTO customers VALUES (2, 'Anita Sharma', 'Mumbai');
INSERT INTO customers VALUES (3, 'John Paul', 'Delhi');
INSERT INTO customers VALUES (4, 'Priya Singh', 'Chennai');

-- Insert sample data into ORDERS
INSERT INTO orders VALUES (101, 1, DATE '2025-08-01', 5000);
INSERT INTO orders VALUES (102, 1, DATE '2025-08-05', 2000);
INSERT INTO orders VALUES (103, 2, DATE '2025-08-07', 3000);
INSERT INTO orders VALUES (104, 4, DATE '2025-08-09', 1500); -- Orphan record (no matching customer)

---- joins ----

---- inner join----

--- Category-wise Loan Count ---
SELECT c.CategoryName, COUNT(*) AS TotalLoans
FROM Loans l, Books b, Categories c
where l.BookID = b.BookID
and b.CategoryID = c.CategoryID
GROUP BY c.CategoryName
ORDER BY TotalLoans DESC;

--- Loans with Book Details ---
SELECT c.customer_id, c.customer_name, o.order_id, o.amount
FROM customers c, orders o
where c.customer_id = o.customer_id;

--- Books with or without Authors --- 
SELECT b.BookID, b.Title, a.Name
FROM Books b, BookAuthors ba , Authors a 
where b.BookID = ba.BookID
and ba.AuthorID = a.AuthorID;

--- Books with their Category ---
SELECT b.Title, c.CategoryName
FROM Books b, Categories c 
where b.CategoryID = c.CategoryID;

--- book without loans ---
SELECT b.BookID, b.Title
FROM Books b, Loans l 
where b.BookID = l.BookID(+)
and l.LoanID IS NULL;

--- book with loans ---
SELECT l.LoanID, b.Title, l.LoanDate, l.ReturnDate
FROM Loans, Books b 
where l.BookID = b.BookID;

---- left outer join ----

--- customer with orders details ---
SELECT c.customer_id, c.customer_name, o.order_id, o.amount
FROM customers c, orders o
WHERE c.customer_id = o.customer_id(+);

--- books details with author details ---
SELECT b.BookID, b.Title, a.Name
FROM Books b, BookAuthors ba,Authors a 
where b.BookID = ba.BookID (+)
and ba.AuthorID = a.AuthorID(+);

--- book details including title, author names, category types ---
SELECT b.Title, a.AuthorName, c.CategoryName
FROM Books b, BookAuthors ba,Authors a ,Categories c
where b.BookID = ba.BookID and ba.AuthorID = a.AuthorID and b.CategoryID = c.CategoryID;

---- right join ----

--- customers details with or without order details ---
SELECT c.customer_id, c.customer_name, o.order_id, o.amount
FROM customers c, orders o
WHERE c.customer_id(+) = o.customer_id;

--- books with author details ---
SELECT a.AuthorID, a.Name, b.Title
FROM Books b, BookAuthors ba,  Authors a 
where b.BookID(+) = ba.BookID 
and ba.AuthorID(+) = a.AuthorID;

---- full join ----

--- total customers and their order details ---
SELECT c.customer_id, c.customer_name, o.order_id, o.amount
FROM customers c, orders o
WHERE c.customer_id = o.customer_id(+)
union
SELECT c.customer_id, c.customer_name, o.order_id, o.amount
FROM customers c, orders o
WHERE c.customer_id(+) = o.customer_id;

--- all books and all author details ---
SELECT b.BookID, b.Title, a.Name
FROM Books b, BookAuthors ba,Authors a 
where b.BookID = ba.BookID (+)
and ba.AuthorID = a.AuthorID(+)
union
SELECT a.AuthorID, a.Name, b.Title
FROM Books b, BookAuthors ba,  Authors a 
where b.BookID(+) = ba.BookID 
and ba.AuthorID(+) = a.AuthorID;


