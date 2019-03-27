--Calculate the value of each order line item, then sum all the values
--by order id as specified in the group by clause
SELECT SUM(OrderDetail.Quantity * OrderDetail.UnitPrice * (1-OrderDetail.Discount)) AS order_value
--Get data from orders table
FROM [Order]
--Join the other 3 tables on appropriate IDs
INNER JOIN OrderDetail ON [Order].Id=OrderDetail.OrderId
INNER JOIN Employee ON [Order].EmployeeId=Employee.Id
INNER JOIN Customer ON [Order].CustomerId=Customer.Id
--Request only records where phone area codes match
WHERE
    --Use SUBSTR to get area code from customer phone number
    SUBSTR(
        --Remove symbols from customer phone number for use as first arg in SUBSTR
        REPLACE(REPLACE(REPLACE(REPLACE(
        Customer.Phone,'-',' '),')',''),'(',''),'.',' '),
        --Start slice at string index 1
        1,
        --Find slice end index using INSTR
        INSTR(
            --Remove symbols from customer phone number again to provide
            --phone # string identical to the one cleaned above
            REPLACE(REPLACE(REPLACE(REPLACE(
            Customer.Phone,'-',' '),')',''),'(',''),'.',' '),
            --Ask INSTR to search for the space after the area code and provide its index
            " "
        )
    )
    --Compare customer and employee area codes
    = 
    --Use SUBSTR to get area code from employee phone number
    SUBSTR(
        --Remove symbols from employee phone number for use as first arg in SUBSTR
        REPLACE(REPLACE(REPLACE(REPLACE(
        Employee.HomePhone,'-',' '),')',''),'(',''),'.',' '),
        --Start slice at string index 1
        1,
        --Find slice end index using INSTR
        INSTR(
            --Remove symbols from employee phone number again to provide
            --phone # string identical to the one cleaned above
            REPLACE(REPLACE(REPLACE(REPLACE(
            Employee.HomePhone,'-',' '),')',''),'(',''),'.',' '),
            --Ask INSTR to search for the space after the area code and provide its index
            " "
        )
    )
--Group all data by its order id, working in concert with SELECT,
--which sums up the value of each order
GROUP BY [Order].Id