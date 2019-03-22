SELECT SUM(OrderDetail.Quantity * OrderDetail.UnitPrice * (1-OrderDetail.Discount)) AS order_value
FROM [Order]
INNER JOIN OrderDetail ON [Order].Id=OrderDetail.OrderId
INNER JOIN Employee ON [Order].EmployeeId=Employee.Id
INNER JOIN Customer ON [Order].CustomerId=Customer.Id
WHERE
    SUBSTR(
        REPLACE(REPLACE(REPLACE(REPLACE(
        Customer.Phone,'-',' '),')',''),'(',''),'.',' '),1,INSTR(
            REPLACE(REPLACE(REPLACE(REPLACE(
            Customer.Phone,'-',' '),')',''),'(',''),'.',' ')," "
        )
    )
    = 
    SUBSTR(
        REPLACE(REPLACE(REPLACE(REPLACE(
        Employee.HomePhone,'-',' '),')',''),'(',''),'.',' '),1,INSTR(
            REPLACE(REPLACE(REPLACE(REPLACE(Employee.HomePhone,'-',' '),')',''),'(',''),'.',' ')," "
        )
    )

GROUP BY [Order].Id