-- Austin Polak

-- Question 1a
SELECT INVENTORYPART.PARTNUMBER, PARTDESCRIPTION, ROUND(AVG(ORDERQUANTITY), 1) AS QUANTITY_SOLD
FROM INVENTORYPART INNER JOIN CUSTORDERLINE
ON INVENTORYPART.PARTNUMBER = CUSTORDERLINE.PARTNUMBER
WHERE CATEGORYID = 'ACCESS'
GROUP BY INVENTORYPART.PARTNUMBER, PARTDESCRIPTION
ORDER BY QUANTITY_SOLD DESC;

/
-- Question 1b - ANSWER BELOW
/
-- Question 2a
SELECT PARTDESCRIPTION, TO_CHAR(ORDERDATE, 'YYYY') AS ORDERYEAR, ROUND(AVG(ORDERQUANTITY), 1) AS TOTALQUANTITY
FROM INVENTORYPART INNER JOIN CUSTORDERLINE
ON INVENTORYPART.PARTNUMBER = CUSTORDERLINE.PARTNUMBER
INNER JOIN CUSTORDER 
ON CUSTORDERLINE.ORDERID = CUSTORDER.ORDERID
WHERE INVENTORYPART.PARTNUMBER LIKE '%DVD-001'
GROUP BY PARTDESCRIPTION, TO_CHAR(ORDERDATE, 'YYYY')
ORDER BY TO_CHAR(ORDERDATE, 'YYYY');
/
-- Question 2b - ANSWER BELOW
/
-- Question 3a
SELECT PARTDESCRIPTION, TO_CHAR(ORDERDATE, 'YYYY') AS ORDERYEAR, SUM(ORDERQUANTITY) AS TOTALQUANTITY
FROM INVENTORYPART INNER JOIN CUSTORDERLINE
ON INVENTORYPART.PARTNUMBER = CUSTORDERLINE.PARTNUMBER
INNER JOIN CUSTORDER 
ON CUSTORDERLINE.ORDERID = CUSTORDER.ORDERID
WHERE INVENTORYPART.PARTNUMBER LIKE '%DVD-001'
GROUP BY PARTDESCRIPTION, TO_CHAR(ORDERDATE, 'YYYY')
ORDER BY TO_CHAR(ORDERDATE, 'YYYY');
/
-- Question 3b - ANSEWR BELOW
/
-- Question 4a
SELECT PARTDESCRIPTION, TO_CHAR(ORDERDATE, 'YYYY') AS ORDERYEAR, COUNT(CUSTORDERLINE.ORDERID) AS AMOUNT_OF_ORDERS
FROM INVENTORYPART INNER JOIN CUSTORDERLINE
ON INVENTORYPART.PARTNUMBER = CUSTORDERLINE.PARTNUMBER
INNER JOIN CUSTORDER 
ON CUSTORDERLINE.ORDERID = CUSTORDER.ORDERID
WHERE INVENTORYPART.PARTNUMBER = 'DVD-001'
GROUP BY PARTDESCRIPTION, TO_CHAR(ORDERDATE, 'YYYY')
ORDER BY TO_CHAR(ORDERDATE, 'YYYY');
/
-- Question 4b - ANSWER BELOW
/
-- Question 5a - ANSWER BELOW
/
-- Question 5b - ANSWER BELOW
/
-- Question 5c - ANSwER BELOW
/
-- Question 6a
SELECT DISTINCT CUSTORDER.ORDERID, SHIPMENT.SHIPMENTID, PACKAGENUMBER, SHIPPEDDATE, SHIPNAME, SHIPADDRESS
FROM CUSTORDER INNER JOIN SHIPMENT
ON CUSTORDER.ORDERID = SHIPMENT.ORDERID 
INNER JOIN PACKINGSLIP
ON SHIPMENT.SHIPMENTID = PACKINGSLIP.SHIPMENTID
WHERE CUSTORDER.ORDERID = '2000000007';
/
-- Question 6b - ANSWER BELOW
/
-- Question 7a
SELECT CUSTLASTNAME || ',' || CUSTFIRSTNAME AS NAME, CUSTOMER.CUSTOMERID, ORDERID
FROM CUSTOMER LEFT OUTER JOIN CUSTORDER
ON CUSTOMER.CUSTOMERID = CUSTORDER.CUSTOMERID
WHERE STATE = 'PA' AND COMPANYNAME IS NULL;
/
-- Question 7b
SELECT CUSTLASTNAME || ',' || CUSTFIRSTNAME AS NAME, CUSTOMER.CUSTOMERID, ORDERID
FROM CUSTOMER RIGHT OUTER JOIN CUSTORDER
ON CUSTOMER.CUSTOMERID = CUSTORDER.CUSTOMERID
WHERE STATE = 'PA' AND COMPANYNAME IS NULL;
/
-- Question 7c
SELECT INVENTORYPART.PARTNUMBER, CATEGORYNAME
FROM INVENTORYPART FULL JOIN CATEGORY
ON CATEGORY.CATEGORYID = INVENTORYPART.CATEGORYID;
/
-- Question 7d
SELECT CUSTFIRSTNAME || ' ' || CUSTLASTNAME AS NAME, CUSTOMER.CUSTOMERID, CUSTORDER.ORDERID
ORDERDATE, SHIPMENT.SHIPMENTID, PACKAGENUMBER, SHIPNAME, SHIPPEDDATE
FROM CUSTOMER 
LEFT OUTER JOIN CUSTORDER
ON CUSTOMER.CUSTOMERID = CUSTORDER.CUSTOMERID
LEFT OUTER JOIN SHIPMENT
ON CUSTORDER.ORDERID = SHIPMENT.ORDERID
LEFT OUTER JOIN PACKINGSLIP
ON SHIPMENT.SHIPMENTID = PACKINGSLIP.SHIPMENTID
WHERE CUSTORDER.ORDERID = '2001000791';
/
-- Question 8a
SELECT DISTINCT CUSTOMERID
FROM CUSTOMER
WHERE STATE = 'PA'
INTERSECT
SELECT CUSTOMERID
FROM CUSTORDER;
/
-- Question 8b
SELECT DISTINCT CUSTOMERID
FROM CUSTOMER
WHERE STATE = 'PA'
MINUS
SELECT CUSTOMERID
FROM CUSTORDER;
/
-- Question 8c
SELECT DISTINCT CUSTOMERID
FROM CUSTOMER
WHERE STATE = 'PA'
INTERSECT
SELECT CUSTOMERID
FROM CUSTORDER
WHERE EXTRACT(YEAR FROM ORDERDATE) = 2011;
/
-- Question 8d
SELECT DISTINCT CUSTOMERID
FROM CUSTOMER
WHERE STATE = 'PA'
MINUS
SELECT CUSTOMERID
FROM CUSTORDER
WHERE EXTRACT(YEAR FROM ORDERDATE) = 2011;
/
-- Question 9a
SELECT DISTINCT PARTNUMBER
FROM INVENTORYPART
WHERE CATEGORYID = 'CAB'
INTERSECT
SELECT DISTINCT PARTNUMBER
FROM CUSTORDERLINE;
/
-- Question 9b
SELECT DISTINCT PARTNUMBER
FROM INVENTORYPART
WHERE CATEGORYID = 'CAB'
MINUS
SELECT DISTINCT PARTNUMBER
FROM CUSTORDERLINE;
/
-- Question 9c
SELECT DISTINCT PARTNUMBER
FROM INVENTORYPART
WHERE CATEGORYID = 'CAB'
INTERSECT
SELECT DISTINCT PARTNUMBER
FROM CUSTORDERLINE
INNER JOIN CUSTORDER 
ON CUSTORDERLINE.ORDERID = CUSTORDER.ORDERID 
WHERE TO_CHAR(CUSTORDER.ORDERDATE, 'YYYY') = '2011';
/
-- Question 9d
SELECT DISTINCT PARTNUMBER
FROM INVENTORYPART
WHERE CATEGORYID = 'CAB'
MINUS
SELECT DISTINCT PARTNUMBER
FROM CUSTORDERLINE
INNER JOIN CUSTORDER 
ON CUSTORDERLINE.ORDERID = CUSTORDER.ORDERID 
WHERE TO_CHAR(CUSTORDER.ORDERDATE, 'YYYY') = '2011';
/
-- Question 10a
SELECT *
FROM (
SELECT CUSTFIRSTNAME AS FIRST_NAME, CUSTLASTNAME AS LAST_NAME
FROM CUSTOMER
WHERE STATE = 'FL'
UNION
SELECT FIRSTNAME AS FIRST_NAME, LASTNAME AS LAST_NAME
FROM EMPLOYEE
)
ORDER BY FIRST_NAME, LAST_NAME ASC;
/
-- Question 10b
SELECT *
FROM (
SELECT CUSTFIRSTNAME AS FIRST_NAME, CUSTLASTNAME AS LAST_NAME
FROM CUSTOMER
WHERE STATE = 'FL'
UNION ALL
SELECT FIRSTNAME AS FIRST_NAME, LASTNAME AS LAST_NAME
FROM EMPLOYEE
)
ORDER BY FIRST_NAME, LAST_NAME ASC;
/
-- Question 11
SELECT CUSTLASTNAME || ', ' || CUSTFIRSTNAME, CUSTOMER.CUSTOMERID, CUSTORDER.ORDERID
FROM CUSTOMER 
FULL JOIN CUSTORDER
ON CUSTOMER.CUSTOMERID = CUSTORDER.CUSTOMERID
WHERE STATE = 'PA'
ORDER BY CUSTOMER.CUSTOMERID, CUSTORDER.ORDERID;
/
/* Results
Question 1a
PARTNUMBER PARTDESCRIPTION                                    QUANTITY_SOLD
---------- -------------------------------------------------- -------------
MOD-001    PCI DATA/FAX/VOICE MODEM                                     8.3
MOD-002    112K DUAL MODEM                                              5.1
PRT-006    SINGLEHEAD THERMAL INKJET PRINTER                            3.8
PRT-004    3-IN-1 COLOR INKJET PRINTER                                  3.6
SCN-002    SCANJET BUSINESS SERIES COLOR SCANNER                        3.5
PRT-003    LASER JET 2500SE                                             3.4
MOD-005    V.90/K56 FLEX 56K FAX MODEM                                  3.1
PRT-001    LASER JET 1999SE                                             2.9
MOD-003    PCI MODEM                                                    2.4
PRT-002    LASER JET 2000SE                                             2.3
SCN-001    SCANJET CSE COLOR SCANNER                                    1.8

PARTNUMBER PARTDESCRIPTION                                    QUANTITY_SOLD
---------- -------------------------------------------------- -------------
MOD-004    PCI V.90 DATA/FAX/VOICE MODEM                                1.6

12 rows selected. 

Question 1b
The caveat is important beacuse it will display the average quantity per individual order.
Without the caveat it would display the average sold for the entire year.

Question 2a
PARTDESCRIPTION                                    ORDE TOTALQUANTITY
-------------------------------------------------- ---- -------------
6X DVD-ROM KIT                                     2010           2.1
6X DVD-ROM KIT                                     2011           4.5

Question 2b
Thje average quantity sold per order more than doubled from 2010 to 2011.

Question 3a
PARTDESCRIPTION                                    ORDE TOTALQUANTITY
-------------------------------------------------- ---- -------------
6X DVD-ROM KIT                                     2010            23
6X DVD-ROM KIT                                     2011            18

Question 3b
The total quantity sold decreased from 2010 to 2011.
They had fewer orders, but they were larger.

Question 4a
PARTDESCRIPTION                                    ORDE AMOUNT_OF_ORDERS
-------------------------------------------------- ---- ----------------
6X DVD-ROM KIT                                     2010               11
6X DVD-ROM KIT                                     2011                4

Question 4b
The number of orders decreased from 2010 to 2011.

Question 5a
They are trying to see if the product is still a good idea to sell.
These questions want to see the amount of product, the 
size quantity, and how often  it is sold.

Question 5b
The product is slowly decreasing by year. The demand for the product 
is becoming less and less. The less orders are being placed, 
but the quantity per order is increased.

Question 5c
The results are in relations with one another and increases my 
confidence that I am getting the correct results.

Question 6a
ORDERID    SHIPMENTID PACKAGENUMBER SHIPPEDDA SHIPNAME             SHIPADDRESS                             
---------- ---------- ------------- --------- -------------------- ----------------------------------------
2000000007 H003                   1 05-JUL-10 Evelyn Cassens       6094 Pearson Ave.                       
2000000007 H003                   2 05-JUL-10 Evelyn Cassens       6094 Pearson Ave.                       
2000000007 H003                   3 05-JUL-10 Evelyn Cassens       6094 Pearson Ave.               

Question 6b
The results show each order with the package details, such as 
where it is going, who it is for, and date shipped.

Question 7a
NAME                                 CUSTOMERID ORDERID   
------------------------------------ ---------- ----------
Wolfe,Thomas                         I-300149   2000000497
Wolfe,Thomas                         I-300149   2001000768
Wolfe,Thomas                         I-300149   2001000670
Wolfe,Thomas                         I-300149   2001000736
Wolfe,Thomas                         I-300149   2001000751
Kaleta,Don                           I-300028             

6 rows selected. 

Question 7b
NAME                                 CUSTOMERID ORDERID   
------------------------------------ ---------- ----------
Wolfe,Thomas                         I-300149   2000000497
Wolfe,Thomas                         I-300149   2001000768
Wolfe,Thomas                         I-300149   2001000670
Wolfe,Thomas                         I-300149   2001000736
Wolfe,Thomas                         I-300149   2001000751

Question 7c
PARTNUMBER CATEGORYNAME                  
---------- ------------------------------
ADT-001    Storage                       
ADT-002    Cables                        
ADT-003    Cables                        
ADT-004    Cables                        
ADT-005    Cables                        
ADT-006    Cables                        
ADT-007    Cables                        
BB-001     Basics                        
BB-002     Basics                        
BB-003     Basics                        
BB-004     Basics                        

PARTNUMBER CATEGORYNAME                  
---------- ------------------------------
BB-005     Basics                        
BRK-001    Cables                        
BRK-002    Cables                        
BRK-003    Cables                        
BRK-004    Cables                        
BRK-005    Cables                        
BRK-006    Cables                        
BRK-007    Cables                        
BRK-008    Cables                        
BRK-009    Cables                        
BRK-010    Cables                        

PARTNUMBER CATEGORYNAME                  
---------- ------------------------------
BRK-011    Cables                        
C-001      Basics                        
C-002      Basics                        
C-003      Basics                        
CAB-001    Cables                        
CAB-002    Cables                        
CAB-003    Cables                        
CAB-004    Cables                        
CAB-005    Cables                        
CAB-006    Cables                        
CAB-007    Cables                        

PARTNUMBER CATEGORYNAME                  
---------- ------------------------------
CAB-008    Cables                        
CAB-009                                  
CAB-010                                  
CAB-011                                  
CAB-012                                  
CAB-013                                  
CAB-014                                  
CAB-015                                  
CAB-016                                  
CAB-017                                  
CAB-018                                  

PARTNUMBER CATEGORYNAME                  
---------- ------------------------------
CAB-019                                  
CAB-020                                  
CAB-021                                  
CAB-022                                  
CAB-023                                  
CAB-024                                  
CAB-025                                  
CAB-026                                  
CAB-027                                  
CAB-028                                  
CD-001     Storage                       

PARTNUMBER CATEGORYNAME                  
---------- ------------------------------
CD-002     Storage                       
CD-003     Storage                       
CD-004     Storage                       
CF-001     Processors                    
CF-002     Processors                    
CF-003     Processors                    
CF-004     Processors                    
CF-005     Processors                    
CF-006     Processors                    
CF-007     Processors                    
CF-008     Processors                    

PARTNUMBER CATEGORYNAME                  
---------- ------------------------------
CF-009     Processors                    
CRD-001                                  
CRD-002                                  
CRD-003                                  
CRD-004                                  
CRD-005                                  
CRD-006                                  
CRD-007                                  
CRD-008                                  
CRD-009                                  
CTR-001    Computers                     

PARTNUMBER CATEGORYNAME                  
---------- ------------------------------
CTR-002    Computers                     
CTR-003    Computers                     
CTR-004    Computers                     
CTR-005    Computers                     
CTR-006    Computers                     
CTR-007    Computers                     
CTR-008    Computers                     
CTR-009    Computers                     
CTR-010    Computers                     
CTR-011    Computers                     
CTR-012    Computers                     

PARTNUMBER CATEGORYNAME                  
---------- ------------------------------
CTR-013    Computers                     
CTR-014    Computers                     
CTR-015    Computers                     
CTR-016    Computers                     
CTR-017    Computers                     
CTR-018    Computers                     
CTR-019    Computers                     
CTR-020    Computers                     
CTR-021    Computers                     
CTR-022    Computers                     
CTR-023    Computers                     

PARTNUMBER CATEGORYNAME                  
---------- ------------------------------
CTR-024    Computers                     
CTR-025    Computers                     
CTR-026    Computers                     
CTR-027    Computers                     
CTR-028    Computers                     
CTR-029    Computers                     
DVD-001    Storage                       
DVD-002    Storage                       
ICAB-001   Cables                        
ICAB-002   Cables                        
ICAB-003   Cables                        

PARTNUMBER CATEGORYNAME                  
---------- ------------------------------
ICAB-004   Cables                        
ICAB-005   Cables                        
ICAB-006   Cables                        
ICAB-007   Cables                        
ICAB-008   Cables                        
KEY-001    Basics                        
KEY-002    Basics                        
KEY-003    Basics                        
KEY-004    Basics                        
KEY-005    Basics                        
KEY-006    Basics                        

PARTNUMBER CATEGORYNAME                  
---------- ------------------------------
KEY-007    Basics                        
KEY-008    Basics                        
KEY-009    Basics                        
MEM-001    Storage                       
MEM-002    Storage                       
MEM-003    Storage                       
MEM-004    Storage                       
MEM-005    Storage                       
MEM-006    Storage                       
MEM-007    Storage                       
MEM-008    Storage                       

PARTNUMBER CATEGORYNAME                  
---------- ------------------------------
MEM-009    Storage                       
MEM-010    Storage                       
MEM-011    Storage                       
MEM-012    Storage                       
MIC-001    Basics                        
MIC-002    Basics                        
MIC-003    Basics                        
MIC-004    Basics                        
MIC-005    Basics                        
MIC-006    Basics                        
MIC-007    Basics                        

PARTNUMBER CATEGORYNAME                  
---------- ------------------------------
MIC-008    Basics                        
MIC-009    Basics                        
MIC-010    Basics                        
MIC-011    Basics                        
MIC-012    Basics                        
MOD-001    Accessories                   
MOD-002    Accessories                   
MOD-003    Accessories                   
MOD-004    Accessories                   
MOD-005    Accessories                   
MOM-001    Basics                        

PARTNUMBER CATEGORYNAME                  
---------- ------------------------------
MOM-002    Basics                        
MOM-003    Basics                        
MOM-004    Basics                        
MON-001    Basics                        
MON-002    Basics                        
MON-003    Basics                        
MON-004    Basics                        
MON-005    Basics                        
MON-006    Basics                        
MON-007    Basics                        
MON-008    Basics                        

PARTNUMBER CATEGORYNAME                  
---------- ------------------------------
P-001      Processors                    
P-002      Processors                    
P-003      Processors                    
P-004      Processors                    
P-005      Processors                    
P-006      Processors                    
P-007      Processors                    
P-008      Processors                    
P-009      Processors                    
P-010      Processors                    
POW-001    Cables                        

PARTNUMBER CATEGORYNAME                  
---------- ------------------------------
POW-002    Cables                        
POW-003    Cables                        
PRT-001    Accessories                   
PRT-002    Accessories                   
PRT-003    Accessories                   
PRT-004    Accessories                   
PRT-005    Accessories                   
PRT-006    Accessories                   
PS-001     Power                         
PS-002     Power                         
PS-003     Power                         

PARTNUMBER CATEGORYNAME                  
---------- ------------------------------
PS-004     Power                         
SCN-001    Accessories                   
SCN-002    Accessories                   
SCN-003    Accessories                   
SFT-001    Software                      
SFT-002    Software                      
SFT-003    Software                      
SFT-004    Software                      
SFT-005    Software                      
SFT-006    Software                      
SFT-007    Software                      

PARTNUMBER CATEGORYNAME                  
---------- ------------------------------
SFT-008    Software                      
SFT-009    Software                      
SP-001     Basics                        
SP-002     Basics                        
SP-003     Basics                        
           Tablets                       

204 rows selected. 

Question 7d
NAME                                 CUSTOMERID ORDERDATE  SHIPMENTID PACKAGENUMBER SHIPNAME             SHIPPEDDA
------------------------------------ ---------- ---------- ---------- ------------- -------------------- ---------
Steven Yaun                          I-300147   2001000791 L258                     Michelle Oakley               

Question 8a
CUSTOMERID
----------
C-300006
C-300040
C-300062
I-300149

Question 8b
CUSTOMERID
----------
I-300028

Question 8c
CUSTOMERID
----------
C-300006
C-300040
I-300149

Question 8d
CUSTOMERID
----------
C-300062
I-300028

Question 9a
PARTNUMBER
----------
ADT-003
ADT-004
ADT-005
ADT-006
ADT-007
BRK-001
BRK-002
BRK-003
BRK-004
BRK-005
BRK-007

PARTNUMBER
----------
BRK-008
BRK-009
BRK-010
BRK-011
CAB-001
CAB-003
CAB-005
CAB-006
CAB-007
CAB-008
ICAB-001

PARTNUMBER
----------
ICAB-002
ICAB-003
ICAB-004
ICAB-005
ICAB-006
ICAB-007
ICAB-008
POW-002
POW-003

31 rows selected. 

Question 9b
PARTNUMBER
----------
ADT-002
BRK-006
CAB-002
CAB-004
POW-001

Question 9c
PARTNUMBER
----------
ADT-003
ADT-004
ADT-005
ADT-006
ADT-007
BRK-001
BRK-002
BRK-003
BRK-004
BRK-005
BRK-007

PARTNUMBER
----------
BRK-008
BRK-009
BRK-010
BRK-011
CAB-001
CAB-003
CAB-005
CAB-006
CAB-007
CAB-008
ICAB-001

PARTNUMBER
----------
ICAB-002
ICAB-003
ICAB-004
ICAB-005
ICAB-006
ICAB-007
ICAB-008
POW-002
POW-003

31 rows selected. 

Question 9d
PARTNUMBER
----------
ADT-002
BRK-006
CAB-002
CAB-004
POW-001

Question 10a

FIRST_NAME      LAST_NAME           
--------------- --------------------
Allison         Roland              
Austin          Ortman              
Beth            Zobitz              
Calie           Zollman             
Charles         Jones               
David           Deppe               
David           Keck                
Edna            Lilley              
Gabrielle       Stevenson           
Gary            German              
Gregory         Hettinger           

FIRST_NAME      LAST_NAME           
--------------- --------------------
Jack            Barrick             
Jack            Brose               
Jamie           Osman               
Jason           Krasner             
Jason           Wendling            
Jim             Manaugh             
Joanne          Rosner              
Joseph          Platt               
Karen           Mangus              
Kathleen        Xolo                
Kathryn         Deagen              

FIRST_NAME      LAST_NAME           
--------------- --------------------
Kathy           Gunderson           
Kelly           Jordan              
Kristen         Gustavel            
Kristey         Moore               
Kristy          Moore               
Laura           Rodgers             
Marla           Reeder              
Meghan          Tyrie               
Melissa         Alvarez             
Michael         Abbott              
Michael         Emore               

FIRST_NAME      LAST_NAME           
--------------- --------------------
Michelle        Nairn               
Nicholas        Albregts            
Patricha        Underwood           
Paul            Eckelman            
Phil            Reece               
Rita            Bush                
Ronald          Day                 
Ryan            Stahley             
Sherman         Cheswick            
Steve           Cochran             
Steve           Hess                

FIRST_NAME      LAST_NAME           
--------------- --------------------
Steven          Hickman             
Tina            Yates               
Todd            Vigus               

47 rows selected. 

Question 10b

FIRST_NAME      LAST_NAME           
--------------- --------------------
Allison         Roland              
Allison         Roland              
Austin          Ortman              
Beth            Zobitz              
Calie           Zollman             
Charles         Jones               
Charles         Jones               
David           Deppe               
David           Keck                
Edna            Lilley              
Gabrielle       Stevenson           

FIRST_NAME      LAST_NAME           
--------------- --------------------
Gary            German              
Gregory         Hettinger           
Jack            Barrick             
Jack            Brose               
Jamie           Osman               
Jason           Krasner             
Jason           Wendling            
Jim             Manaugh             
Jim             Manaugh             
Joanne          Rosner              
Joseph          Platt               

FIRST_NAME      LAST_NAME           
--------------- --------------------
Karen           Mangus              
Kathleen        Xolo                
Kathryn         Deagen              
Kathy           Gunderson           
Kelly           Jordan              
Kristen         Gustavel            
Kristey         Moore               
Kristy          Moore               
Laura           Rodgers             
Marla           Reeder              
Meghan          Tyrie               

FIRST_NAME      LAST_NAME           
--------------- --------------------
Melissa         Alvarez             
Michael         Abbott              
Michael         Emore               
Michelle        Nairn               
Nicholas        Albregts            
Patricha        Underwood           
Paul            Eckelman            
Phil            Reece               
Phil            Reece               
Rita            Bush                
Ronald          Day                 

FIRST_NAME      LAST_NAME           
--------------- --------------------
Ryan            Stahley             
Ryan            Stahley             
Sherman         Cheswick            
Steve           Cochran             
Steve           Hess                
Steven          Hickman             
Tina            Yates               
Todd            Vigus               

52 rows selected. 

Question 11

CUSTLASTNAME||','||CUSTFIRSTNAME      CUSTOMERID ORDERID   
------------------------------------- ---------- ----------
Purcell, George                       C-300006   2000000050
Purcell, George                       C-300006   2000000083
Purcell, George                       C-300006   2000000110
Purcell, George                       C-300006   2000000130
Purcell, George                       C-300006   2000000355
Purcell, George                       C-300006   2001000643
Purcell, George                       C-300006   2001000729
Jones, Mildred                        C-300040   2000000012
Jones, Mildred                        C-300040   2000000284
Jones, Mildred                        C-300040   2001000721
Jones, Mildred                        C-300040   2001000782

CUSTLASTNAME||','||CUSTFIRSTNAME      CUSTOMERID ORDERID   
------------------------------------- ---------- ----------
Gray, Scott                           C-300062   2000000361
Gray, Scott                           C-300062   2000000421
Gray, Scott                           C-300062   2000000440
Gray, Scott                           C-300062   2000000496
Kaleta, Don                           I-300028             
Wolfe, Thomas                         I-300149   2000000497
Wolfe, Thomas                         I-300149   2001000670
Wolfe, Thomas                         I-300149   2001000736
Wolfe, Thomas                         I-300149   2001000751
Wolfe, Thomas                         I-300149   2001000768

21 rows selected. 

*/