-- Question 1
SELECT DISTINCT substr(PHONE,1,3) as AreaCode
FROM CUSTOMER
WHERE STATE = 'CO';

/
-- Question 2
SELECT SUBSTR(PHONE,1,3) as AreaCode, COUNT(CUSTOMERID) as Customer
FROM CUSTOMER
WHERE STATE = 'CO'
GROUP BY SUBSTR(PHONE,1,3)
ORDER BY COUNT(CUSTOMERID) DESC;
/
-- Question 3
SELECT SUBSTR(PHONE,1,3) AS AreaCode
FROM CUSTOMER
WHERE CUSTOMERID IN (
SELECT MAX(CUSTOMERID)
FROM CUSTOMER
WHERE STATE = 'CO');
/
-- Question 4
SELECT CONCAT(CONCAT(CUSTLASTNAME, ', '), CUSTFIRSTNAME) AS NAME, CITY, STATE, PHONE
FROM CUSTOMER
WHERE SUBSTR(PHONE,1,3) IN (
SELECT SUBSTR(PHONE,1,3)
FROM CUSTOMER
WHERE CUSTOMERID IN (
SELECT MAX(CUSTOMERID)
FROM CUSTOMER
WHERE STATE = 'CO'));
/
-- Question 5 - ANSWER DOWN BELOW
/
-- Question 6
SELECT CUSTOMERID, COUNT(*) AS ORDERS
FROM CUSTORDER
WHERE TO_CHAR(ORDERDATE,'YYYY:MM') = '2010:08'
GROUP BY CUSTOMERID
ORDER BY COUNT(*);
/
-- Question 7
SELECT MAX(COUNT(*)) AS TOTALORDERS
FROM CUSTORDER
WHERE TO_CHAR(ORDERDATE,'YYYY:MM') = '2010:08'
GROUP BY CUSTOMERID;
/
-- Question 8
SELECT * FROM
(SELECT CUSTOMERID, COUNT(*) AS ORDERS
FROM CUSTORDER
WHERE TO_CHAR(ORDERDATE,'YYYY:MM') = '2010:08'
GROUP BY CUSTOMERID
ORDER BY COUNT(*) DESC)
WHERE ROWNUM = 1;

/
-- Question 9
SELECT AVG(COUNT(*)) AS AVG_ORDERS
FROM CUSTORDER
WHERE TO_CHAR(ORDERDATE,'YYYY:MM') = '2010:08'
GROUP BY CUSTOMERID;

/
-- Question 10
SELECT CUSTOMER.CUSTOMERID, COUNT(ORDERID) AS ORDERS
FROM CUSTOMER LEFT JOIN CUSTORDER
ON CUSTOMER.CUSTOMERID = CUSTORDER.CUSTOMERID
WHERE TO_CHAR(ORDERDATE,'YYYY:MM') = '2010:08'
GROUP BY CUSTOMER.CUSTOMERID
HAVING COUNT(ORDERID)>
(SELECT AVG(COUNT(ORDERID)) AS AVG_ORDERS
FROM CUSTOMER LEFT JOIN CUSTORDER ON CUSTOMER.CUSTOMERID = CUSTORDER.CUSTOMERID
WHERE TO_CHAR(ORDERDATE,'YYYY:MM') = '2010:08'
GROUP BY CUSTOMER.CUSTOMERID)
ORDER BY COUNT(ORDERID) DESC;
/
-- Question 11
SELECT CUSTOMERID, COUNT(ORDERID) AS ORDERS
FROM CUSTORDER
WHERE TO_CHAR(ORDERDATE,'YYYY:MM') = '2010:08'
GROUP BY CUSTOMERID
HAVING COUNT(ORDERID)<
(SELECT AVG(COUNT(ORDERID)) AS AVG_ORDERS
FROM CUSTORDER
WHERE TO_CHAR(ORDERDATE,'YYYY:MM') = '2010:08'
GROUP BY CUSTOMERID)
ORDER BY COUNT(ORDERID) DESC;
/
-- Question 12 - ANSWER DOWN BELOW
/
-- Question 13
SELECT CUSTOMER.CUSTOMERID, COMPANYNAME, CONCAT(CONCAT(CUSTLASTNAME, ', '), CUSTFIRSTNAME) AS NAME, TO_CHAR(ORDERDATE,'MM.DD.YYYY') AS ORDERDATE
FROM CUSTOMER INNER JOIN CUSTORDER
ON CUSTOMER.CUSTOMERID = CUSTORDER.CUSTOMERID
WHERE STATE = 'IN' AND EXTRACT(YEAR FROM ORDERDATE) = 2010
ORDER BY ORDERDATE ASC;
/
-- Question 14
SELECT COMPANYNAME, CUSTTITLE || ' ' || SUBSTR(CUSTFIRSTNAME,0,1) || '.' || CUSTLASTNAME AS CONTACT_NAME, ORDERDATE, REQUIREDDATE
FROM CUSTOMER INNER JOIN CUSTORDER
ON CUSTOMER.CUSTOMERID = CUSTORDER.CUSTOMERID
WHERE CUSTORDER.CUSTOMERID = 'C-300001'
ORDER BY ORDERDATE ASC;
/
-- Question 15
SELECT DISTINCT CUSTORDERLINE.ORDERID, INVENTORYPART.PARTNUMBER, PARTDESCRIPTION, UNITPRICE, ORDERQUANTITY, CATEGORY.CATEGORYID
FROM CUSTORDERLINE INNER JOIN INVENTORYPART
ON CUSTORDERLINE.PARTNUMBER = INVENTORYPART.PARTNUMBER
INNER JOIN CATEGORY
ON INVENTORYPART.CATEGORYID = CATEGORY.CATEGORYID
WHERE PARTDESCRIPTION LIKE '%BOARD GAMES'
ORDER BY ORDERQUANTITY DESC;
/
-- Question 16
SELECT CUSTORDERLINE.ORDERID, INVENTORYPART.PARTNUMBER, PARTDESCRIPTION, UNITPRICE, ORDERQUANTITY
FROM CUSTORDERLINE INNER JOIN INVENTORYPART
ON CUSTORDERLINE.PARTNUMBER = INVENTORYPART.PARTNUMBER
INNER JOIN CUSTORDER 
ON CUSTORDERLINE.ORDERID = CUSTORDER.ORDERID
WHERE CUSTORDER.CUSTOMERID = 'C-300001' AND CUSTORDER.ORDERDATE = '14 JULY 2010'
ORDER BY ORDERQUANTITY DESC;
/
-- Question 17
SELECT TO_CHAR(ORDERDATE, 'MM.DD.YYYY'), CUSTORDER.ORDERID, INVENTORYPART.PARTNUMBER, PARTDESCRIPTION, UNITPRICE, ORDERQUANTITY
FROM CUSTOMER INNER JOIN CUSTORDER
ON CUSTOMER.CUSTOMERID = CUSTORDER.CUSTOMERID
INNER JOIN CUSTORDERLINE
ON CUSTORDER.ORDERID = CUSTORDERLINE.ORDERID
INNER JOIN INVENTORYPART
ON CUSTORDERLINE.PARTNUMBER = INVENTORYPART.PARTNUMBER
WHERE EXTRACT(YEAR FROM ORDERDATE) = 2011 AND CUSTOMER.COMPANYNAME LIKE '%Bankruptcy Help'
ORDER BY ORDERDATE, ORDERQUANTITY DESC;
/
-- Question 18
SELECT TO_CHAR(ORDERDATE, 'MM.DD.YYYY'), CUSTORDER.ORDERID, INVENTORYPART.PARTNUMBER, PARTDESCRIPTION, (UNITPRICE * ORDERQUANTITY) AS LINE_ITEM_TOTAL
FROM CUSTOMER INNER JOIN CUSTORDER
ON CUSTOMER.CUSTOMERID = CUSTORDER.CUSTOMERID
INNER JOIN CUSTORDERLINE
ON CUSTORDER.ORDERID = CUSTORDERLINE.ORDERID
INNER JOIN INVENTORYPART
ON CUSTORDERLINE.PARTNUMBER = INVENTORYPART.PARTNUMBER
WHERE EXTRACT(YEAR FROM ORDERDATE) = 2011 AND CUSTOMER.COMPANYNAME LIKE '%Bankruptcy Help'
ORDER BY ORDERDATE, ORDERQUANTITY DESC;
/
-- Question 19
SELECT CUSTOMER.CUSTOMERID, COMPANYNAME, CUSTFIRSTNAME || ', ' || CUSTLASTNAME AS CONTACT_NAME, COUNT(ORDERID)
FROM CUSTOMER INNER JOIN CUSTORDER
ON CUSTOMER.CUSTOMERID = CUSTORDER.CUSTOMERID
WHERE STATE = 'IN' AND  TO_CHAR(ORDERDATE,'YYYY:MM') = '2011:01'
GROUP BY CUSTOMER.CUSTOMERID, COMPANYNAME, CUSTFIRSTNAME || ', ' || CUSTLASTNAME
ORDER BY COUNT(ORDERID) ASC;
/
-- Question 20
SELECT CATEGORYNAME, ROUND(AVG(STOCKLEVEL),2)
FROM CATEGORY INNER JOIN INVENTORYPART
ON CATEGORY.CATEGORYID = INVENTORYPART.CATEGORYID
GROUP BY CATEGORYNAME
ORDER BY ROUND(AVG(STOCKLEVEL),2);
/
-- Question 21
SELECT CATEGORYNAME || ': ' || CATEGORY.DESCRIPTION AS CATEGORY_DETAIL, COUNT(DISTINCT INVENTORYPART.PARTNUMBER) AS PART_TYPES
FROM CATEGORY INNER JOIN INVENTORYPART
ON CATEGORY.CATEGORYID = INVENTORYPART.CATEGORYID
GROUP BY CATEGORYNAME || ': ' || CATEGORY.DESCRIPTION
ORDER BY COUNT(DISTINCT INVENTORYPART.PARTNUMBER) ASC;
/
-- Question 22
SELECT CATEGORYNAME, MAX(WEIGHT)
FROM CATEGORY INNER JOIN INVENTORYPART
ON CATEGORY.CATEGORYID = INVENTORYPART.CATEGORYID
WHERE CATEGORYNAME LIKE '%Software'
GROUP BY CATEGORYNAME;
/
-- Question 23
SELECT CATEGORYNAME, MAX(WEIGHT)
FROM CATEGORY INNER JOIN INVENTORYPART
ON CATEGORY.CATEGORYID = INVENTORYPART.CATEGORYID
WHERE CATEGORYNAME IN ('Power', 'Software', 'Storage')
GROUP BY CATEGORYNAME
ORDER BY CATEGORYNAME ASC;
/
-- Question 24
SELECT CATEGORYNAME, WEIGHT, PARTDESCRIPTION
FROM CATEGORY INNER JOIN INVENTORYPART
ON CATEGORY.CATEGORYID = INVENTORYPART.CATEGORYID
WHERE (CATEGORYNAME, WEIGHT) IN
(SELECT CATEGORYNAME, MAX(WEIGHT)
FROM CATEGORY INNER JOIN INVENTORYPART
ON CATEGORY.CATEGORYID = INVENTORYPART.CATEGORYID
WHERE CATEGORYNAME IN ('Power', 'Software', 'Storage')
GROUP BY CATEGORYNAME)
ORDER BY CATEGORYNAME ASC;
/

/* Results
Question 1
ARE
---
719
970
728
644
720

Question 2
ARE   CUSTOMER
--- ----------
719          4
970          2
644          1
720          1
728          1

Question 3
ARE
---
719

Question 4
NAME                                  CITY                 ST PHONE       
------------------------------------- -------------------- -- ------------
Kaakeh, Paul                          Gunnison             CO 719-750-4539
Rodkey, Daniel                        Lamar                CO 719-748-3205
Smith, Matt                           Montrose             CO 719-822-8828
Rice, Paul                            Craig                CO 719-541-1837

Question 5
It is useful to target the most popular area for marketing and advertiseing their products. 
This will also give an example of the behavior/characteristics of residents.

Question 6
CUSTOMERID     ORDERS
---------- ----------
I-300070            1
C-300017            1
I-300031            1
I-300126            1
C-300001            1
I-300091            1
I-300020            1
C-300011            1
I-300069            1
C-300033            1
I-300024            1

CUSTOMERID     ORDERS
---------- ----------
I-300117            1
C-300002            1
I-300132            1
I-300005            1
C-300010            1
I-300122            1
C-300013            1
C-300053            1
I-300068            1
C-300020            1
I-300096            1

CUSTOMERID     ORDERS
---------- ----------
I-300120            1
I-300112            1
I-300115            1
I-300076            1
C-300035            1
I-300012            1
I-300095            1
I-300017            1
I-300026            1
I-300042            1
I-300097            1

CUSTOMERID     ORDERS
---------- ----------
I-300093            1
I-300102            1
I-300007            1
I-300138            1
I-300043            1
I-300108            1
I-300044            1
I-300110            1
C-300051            1
I-300009            1
C-300004            1

CUSTOMERID     ORDERS
---------- ----------
C-300026            1
C-300003            1
I-300004            1
I-300025            1
I-300129            1
I-300002            1
I-300011            1
I-300081            1
I-300088            1
I-300013            1
I-300061            1

CUSTOMERID     ORDERS
---------- ----------
I-300018            1
C-300055            2
I-300016            2
C-300041            2
C-300031            2
C-300027            2
I-300014            2
I-300010            2
C-300005            2
I-300015            2
C-300006            3

66 rows selected.

Question 7
TOTALORDERS
-----------
          3

Question 8
CUSTOMERID     ORDERS
---------- ----------
C-300006            3

Question 9
AVG_ORDERS
----------
1.16666667

Question 10
CUSTOMERID     ORDERS
---------- ----------
C-300006            3
I-300016            2
C-300041            2
C-300031            2
I-300015            2
C-300055            2
I-300010            2
C-300005            2
C-300027            2
I-300014            2

10 rows selected. 

Question 11
CUSTOMERID     ORDERS
---------- ----------
I-300070            1
I-300018            1
I-300031            1
I-300126            1
C-300001            1
I-300091            1
I-300020            1
C-300011            1
I-300069            1
C-300033            1
I-300024            1

CUSTOMERID     ORDERS
---------- ----------
I-300117            1
C-300002            1
I-300132            1
I-300005            1
C-300010            1
I-300122            1
C-300013            1
C-300053            1
I-300068            1
C-300020            1
I-300096            1

CUSTOMERID     ORDERS
---------- ----------
I-300120            1
I-300112            1
I-300115            1
I-300076            1
C-300035            1
I-300012            1
I-300095            1
I-300017            1
I-300026            1
I-300042            1
I-300097            1

CUSTOMERID     ORDERS
---------- ----------
I-300093            1
I-300102            1
I-300007            1
I-300138            1
I-300043            1
I-300108            1
I-300044            1
I-300110            1
C-300051            1
I-300009            1
C-300004            1

CUSTOMERID     ORDERS
---------- ----------
C-300026            1
C-300003            1
I-300004            1
I-300025            1
I-300129            1
I-300002            1
I-300011            1
I-300081            1
I-300088            1
I-300013            1
I-300061            1

CUSTOMERID     ORDERS
---------- ----------
C-300017            1

56 rows selected. 

Question 12
The company can use this infroamtion to identify who is their main contributer in the area. 
The information can help focus on why a certain amount customers are not as invested or not purchaseing products.
Also, the company can put more effort into the people that are not contributing as much as the company desires.

Question 13
CUSTOMERID COMPANYNAME                              NAME                                  ORDERDATE 
---------- ---------------------------------------- ------------------------------------- ----------
C-300001   Baker and Company                        Abbott, Gregory                       07.08.2010
C-300001   Baker and Company                        Abbott, Gregory                       07.14.2010
C-300001   Baker and Company                        Abbott, Gregory                       08.13.2010
I-300030                                            Quintero, Eric                        09.15.2010
C-300014   R and R Air                              Bending, Cathy                        10.04.2010
C-300001   Baker and Company                        Abbott, Gregory                       12.02.2010
I-300147                                            Yaun, Steven                          12.07.2010

7 rows selected. 

Question 14
COMPANYNAME                              CONTACT_NAME                 ORDERDATE REQUIREDD
---------------------------------------- ---------------------------- --------- ---------
Baker and Company                        Mr. G.Abbott                 08-JUL-10 12-JUL-10
Baker and Company                        Mr. G.Abbott                 14-JUL-10 15-JUL-10
Baker and Company                        Mr. G.Abbott                 13-AUG-10 20-AUG-10
Baker and Company                        Mr. G.Abbott                 02-DEC-10 08-DEC-10
Baker and Company                        Mr. G.Abbott                 27-JAN-11 03-FEB-11
Baker and Company                        Mr. G.Abbott                 24-FEB-11 03-MAR-11
Baker and Company                        Mr. G.Abbott                 10-MAR-11 15-MAR-11

7 rows selected. 

Question 15
ORDERID    PARTNUMBER PARTDESCRIPTION                                     UNITPRICE ORDERQUANTITY CATEGORYID
---------- ---------- -------------------------------------------------- ---------- ------------- ----------
2001000536 SFT-005    BOARD GAMES                                              9.99            15 SOFT      
2000000050 SFT-005    BOARD GAMES                                              9.99            14 SOFT      
2000000279 SFT-005    BOARD GAMES                                              9.99            10 SOFT      
2000000426 SFT-005    BOARD GAMES                                              9.99            10 SOFT      
2000000139 SFT-005    BOARD GAMES                                              9.99             2 SOFT      
2000000348 SFT-005    BOARD GAMES                                              9.99             2 SOFT      
2000000005 SFT-005    BOARD GAMES                                              9.99             1 SOFT      
2000000011 SFT-005    BOARD GAMES                                              9.99             1 SOFT      
2000000040 SFT-005    BOARD GAMES                                              9.99             1 SOFT      
2000000206 SFT-005    BOARD GAMES                                              9.99             1 SOFT      
2000000362 SFT-005    BOARD GAMES                                              9.99             1 SOFT      

ORDERID    PARTNUMBER PARTDESCRIPTION                                     UNITPRICE ORDERQUANTITY CATEGORYID
---------- ---------- -------------------------------------------------- ---------- ------------- ----------
2000000436 SFT-005    BOARD GAMES                                              9.99             1 SOFT      
2001000600 SFT-005    BOARD GAMES                                              9.99             1 SOFT      
2001000722 SFT-005    BOARD GAMES                                              9.99             1 SOFT      

14 rows selected. 

Question 16
ORDERID    PARTNUMBER PARTDESCRIPTION                                     UNITPRICE ORDERQUANTITY
---------- ---------- -------------------------------------------------- ---------- -------------
2000000032 BRK-011    2ND PARALLEL PORT                                        5.99            20
2000000032 CTR-019    FLY XPST                                              1717.99             9
2000000032 ADT-003    EXTERNAL SCSI-3 MALE TERMINATOR                         39.99             8
2000000032 CAB-027    2FT 3/1 SCSI CABLE                                      44.99             6
2000000032 SCN-002    SCANJET BUSINESS SERIES COLOR SCANNER                     249             4

Question 17
TO_CHAR(OR ORDERID    PARTNUMBER PARTDESCRIPTION                                     UNITPRICE ORDERQUANTITY
---------- ---------- ---------- -------------------------------------------------- ---------- -------------
02.14.2011 2001000622 BB-004     SOCKET MINI BAREBONE                                   199.99             6
02.14.2011 2001000622 P-005      700 PENTIUM III PROCESSOR                              399.99             4
02.24.2011 2001000676 MIC-009    WHEEL MOUSE                                              29.5            27
02.28.2011 2001000699 MOD-002    112K DUAL MODEM                                         89.99            16
02.28.2011 2001000699 MEM-001    2MB FLASH BUFFER MEMORY                                259.95            12
02.28.2011 2001000699 PRT-003    LASER JET 2500SE                                          699             3
03.22.2011 2001000778 BRK-002    1X4 USB CABLE AND BRACKET                                9.99            20
03.22.2011 2001000778 MEM-004    30.7GB HARD DRIVE                                      269.99            10
03.22.2011 2001000778 P-006      600 PENTIUM III PROCESSOR                              339.99             6

9 rows selected. 

Question 18
TO_CHAR(OR ORDERID    PARTNUMBER PARTDESCRIPTION                                    LINE_ITEM_TOTAL
---------- ---------- ---------- -------------------------------------------------- ---------------
02.14.2011 2001000622 BB-004     SOCKET MINI BAREBONE                                       1199.94
02.14.2011 2001000622 P-005      700 PENTIUM III PROCESSOR                                  1599.96
02.24.2011 2001000676 MIC-009    WHEEL MOUSE                                                  796.5
02.28.2011 2001000699 MOD-002    112K DUAL MODEM                                            1439.84
02.28.2011 2001000699 MEM-001    2MB FLASH BUFFER MEMORY                                     3119.4
02.28.2011 2001000699 PRT-003    LASER JET 2500SE                                              2097
03.22.2011 2001000778 BRK-002    1X4 USB CABLE AND BRACKET                                    199.8
03.22.2011 2001000778 MEM-004    30.7GB HARD DRIVE                                           2699.9
03.22.2011 2001000778 P-006      600 PENTIUM III PROCESSOR                                  2039.94

9 rows selected. 

Question 19
CUSTOMERID COMPANYNAME                              CONTACT_NAME                          COUNT(ORDERID)
---------- ---------------------------------------- ------------------------------------- --------------
C-300014   R and R Air                              Cathy, Bending                                     1
C-300001   Baker and Company                        Gregory, Abbott                                    1
I-300030                                            Eric, Quintero                                     2

Question 20
CATEGORYNAME                   ROUND(AVG(STOCKLEVEL),2)
------------------------------ ------------------------
Computers                                          2.45
Accessories                                        9.21
Power                                              10.5
Storage                                           20.47
Basics                                             20.5
Processors                                        23.74
Software                                          33.89
Cables                                            35.86

8 rows selected. 

Question 21
CATEGORY_DETAIL                                                                                                                      PART_TYPES
------------------------------------------------------------------------------------------------------------------------------------ ----------
Power: Power Supplies                                                                                                                         4
Software: Games, maps                                                                                                                         9
Accessories: Scanners, Printers, Modems                                                                                                      14
Processors: Athlon, Celeron, Pentium, Fans                                                                                                   19
Storage: CD-ROM, DVD, Hard Drives, Memory                                                                                                    19
Computers: Assembled Computers                                                                                                               29
Cables: Printer, Keyboard, Internal, SCSI, Connectors, Brackets                                                                              36
Basics: Casing, Barebone, Monitors, Keyboards, Mice                                                                                          44

8 rows selected. 

Question 22
CATEGORYNAME                   MAX(WEIGHT)
------------------------------ -----------
Software                              .438

Question 23
CATEGORYNAME                   MAX(WEIGHT)
------------------------------ -----------
Power                                    3
Software                              .438
Storage                                  4

Question 24
CATEGORYNAME                       WEIGHT PARTDESCRIPTION                                   
------------------------------ ---------- --------------------------------------------------
Power                                   3 250 WATT POWER SUPPLY                             
Power                                   3 300 WATT POWER SUPPLY                             
Software                             .438 BOARD GAMES                                       
Software                             .438 DESKTOP PUBLISHER                                 
Storage                                 4 ETHERNET FIBER OPTIC MINI-TRANSCEIVER           

*/
