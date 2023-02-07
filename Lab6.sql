-- Austin Polak

-- Question 1
CREATE TABLE PERSON_OF_INTEREST (
NAME VARCHAR2(20),
COMPANYNAME VARCHAR2(40),
TELEPHONE VARCHAR2(14),
EMAILADDRESS VARCHAR2(50));


/
-- Question 2
SELECT CUSTFIRSTNAME ||' ' || CUSTLASTNAME, NVL(COMPANYNAME, 'NONE ON RECORD'), PHONE, EMAILADDR
FROM CUSTOMER
UNION
SELECT FIRSTNAME||' ' || LASTNAME, NVL(NULL, 'Eagle Electronic') AS COMPANYNAME, HOMEPHONE, EMAILADDR
FROM EMPLOYEE
UNION
SELECT CONTACTNAME, NVL(COMPANYNAME, 'NONE ON RECORD'), PHONE, EMAILADDR
FROM SUPPLIER;


/
-- Question 3
INSERT ALL INTO PERSON_OF_INTEREST(NAME, COMPANYNAME, TELEPHONE, EMAILADDRESS)
SELECT CUSTFIRSTNAME ||' ' || CUSTLASTNAME, NVL(COMPANYNAME, 'NONE ON RECORD'), PHONE, EMAILADDR
FROM CUSTOMER
UNION
SELECT FIRSTNAME||' ' || LASTNAME, NVL(NULL, 'Eagle Electronic') AS COMPANYNAME, HOMEPHONE, EMAILADDR
FROM EMPLOYEE
UNION
SELECT CONTACTNAME, NVL(COMPANYNAME, 'NONE ON RECORD'), PHONE, EMAILADDR
FROM SUPPLIER;
/
-- Question 4
UPDATE PERSON_OF_INTEREST
SET EMAILADDRESS = NVL(EMAILADDRESS, 'NONE ON RECORD');

SELECT *
FROM person_of_interest;
/
-- Question 5
delete 
from person_of_interest
where COMPANYNAME = 'NONE ON RECORD';

SELECT *
FROM person_of_interest;
/
-- Question 6
TRUNCATE TABLE PERSON_OF_INTEREST;

SELECT *
FROM person_of_interest;
/
-- Question 7
CREATE TABLE COPY_CUSTOMER AS
SELECT *
FROM CUSTOMER;

SELECT *
FROM COPY_CUSTOMER;
/
-- Question 8
INSERT INTO COPY_CUSTOMER (CUSTOMERID, COMPANYNAME, CUSTFIRSTNAME, CUSTLASTNAME, CUSTTITLE, CITY, STATE)
VALUES ('Z-12345', 'Quick Stop', 'Randal', 'Graves', 'Mr.', 'Leonardo', 'NJ');

select *
from copy_customer
where customerid = 'Z-12345';

/
-- Question 9
update copy_customer
set POSTALCODE = 07737
WHERE CUSTOMERID = 'Z-12345';

select *
from copy_customer
where customerid = 'Z-12345';
/
-- Question 10
DELETE
FROM COPY_CUSTOMER
WHERE STATE = 'OH';

SELECT *
FROM COPY_CUSTOMER;
/
-- Question 11
DELETE
FROM COPY_CUSTOMER
WHERE CUSTOMERID = 'Z-12345';

select *
from copy_customer
where customerid = 'Z-12345';
/
-- Question 12
UPDATE COPY_CUSTOMER
SET CITY = 'Leonardo', State = 'NJ';

select city, state
from copy_customer;

/
-- Question 13
CREATE TABLE EMPLOYEE_BOTTOM_25(
EMPLOYEE_ID VARCHAR2(10),
EMPLOYEE_NAME VARCHAR2(35),
JOB_TITLE VARCHAR(35),
SALARY NUMBER(9,2));

CREATE TABLE EMPLOYEE_BOTTOM_10(
EMPLOYEE_ID VARCHAR2(10),
EMPLOYEE_NAME VARCHAR2(35),
JOB_TITLE VARCHAR(35),
SALARY NUMBER(9,2));

CREATE TABLE EMPLOYEE_OTHERS(
EMPLOYEE_ID VARCHAR2(10),
EMPLOYEE_NAME VARCHAR2(35),
JOB_TITLE VARCHAR(35),
SALARY NUMBER(9,2));
/
-- Question 14
insert all
WHEN SALARYWAGE <= (SELECT AVG(SALARYWAGE)/2 AS BOTTOM25 FROM EMPLOYEE)
THEN
INTO EMPLOYEE_BOTTOM_25
VALUES(EMPLOYEEID, NAME, JOBTITLE, SALARYWAGE)
WHEN SALARYWAGE >= (SELECT AVG(SALARYWAGE)*1.8 AS TOP10
FROM EMPLOYEE) THEN INTO EMPLOYEE_BOTTOM_10
VALUES(EMPLOYEEID, NAME, JOBTITLE, SALARYWAGE)
ELSE
INTO EMPLOYEE_OTHERS
VALUES(EMPLOYEEID, NAME, JOBTITLE, SALARYWAGE)
SELECT EMPLOYEEID, FIRSTNAME || '' || LASTNAME AS NAME, JOBTITLE, SALARYWAGE
FROM EMPLOYEE;

SELECT *
FROM employee_bottom_10;
SELECT *
FROM employee_bottom_25;
SELECT *
FROM employee_others;
/
-- Question 15
DELETE FROM employee_bottom_25;
DELETE FROM employee_bottom_10;
DELETE FROM employee_others;

SELECT *
FROM employee_bottom_10;
SELECT *
FROM employee_bottom_25;
SELECT *
FROM employee_others;
/
-- Question 16
CREATE TABLE EMPLOYEE_TOP_2(
EMPLOYEE_ID VARCHAR2(10),
EMPLOYEE_NAME VARCHAR2(35),
JOB_TITLE VARCHAR(35),
SALARY NUMBER(9,2));
/
-- Question 17
insert all
WHEN SALARYWAGE <= (SELECT AVG(SALARYWAGE)/2 AS BOTTOM25 FROM EMPLOYEE)
THEN
INTO EMPLOYEE_BOTTOM_25
VALUES(EMPLOYEEID, NAME, JOBTITLE, SALARYWAGE)
WHEN SALARYWAGE >= (SELECT AVG(SALARYWAGE)*1.8 AS TOP10
FROM EMPLOYEE) 
THEN 
INTO EMPLOYEE_BOTTOM_10
VALUES(EMPLOYEEID, NAME, JOBTITLE, SALARYWAGE)
WHEN SALARYWAGE >= (SELECT AVG(SALARYWAGE)*1.96 AS TOP02
FROM EMPLOYEE) 
THEN
INTO EMPLOYEE_TOP_2
VALUES(EMPLOYEEID, NAME, JOBTITLE, SALARYWAGE)
ELSE
INTO EMPLOYEE_OTHERS
VALUES(EMPLOYEEID, NAME, JOBTITLE, SALARYWAGE)
SELECT EMPLOYEEID, FIRSTNAME || '' || LASTNAME AS NAME, JOBTITLE, SALARYWAGE
FROM EMPLOYEE;

SELECT *
FROM employee_bottom_10;
SELECT *
FROM employee_bottom_25;
SELECT *
FROM employee_top_2;
SELECT *
FROM employee_others;
/
-- Question 18
UPDATE employee_top_2
SET SALARY = SALARY*1.2;

SELECT *
FROM employee_TOP_2;
/
-- Question 19
INSERT INTO employee_top_2(EMPLOYEE_ID, EMPLOYEE_NAME, JOB_TITLE, SALARY)
VALUES ('101','Happy Owner', 'Big Boss', '1000000');

select *
from employee_top_2
where employee_id = '101';
/
-- Question 20
MERGE INTO EMPLOYEE_BOTTOM_10 f
using EMPLOYEE_TOP_2 b
ON (f.EMPLOYEE_ID = b.EMPLOYEE_ID)
when matched THEN
UPDATE SET f.SALARY = b.SALARY;
/
-- Question 21
DROP TABLE COPY_CUSTOMER CASCADE CONSTRAINTS;
DROP TABLE PERSON_OF_INTEREST CASCADE CONSTRAINTS;
DROP TABLE EMPLOYEE_BOTTOM_10 CASCADE CONSTRAINTS;
DROP TABLE EMPLOYEE_TOP_2 CASCADE CONSTRAINTS;
DROP TABLE EMPLOYEE_BOTTOM_25 CASCADE CONSTRAINTS;
DROP TABLE EMPLOYEE_OTHERS CASCADE CONSTRAINTS;
/
-- BOUNS
DELETE 
FROM SUPPLIERS
WHERE PURCHASEORDER.DATEORDERID = NULL;
/
/* Results
Question 1
Table PERSON_OF_INTEREST created.

Question 2

CUSTFIRSTNAME||''||CUSTLASTNAME      PHONE        EMAILADDR                                          NVL(COMPANYNAME,'NONEONRECORD')         
------------------------------------ ------------ -------------------------------------------------- ----------------------------------------
Adam Cyr                             315-474-5634 acyr@cablesany.com                                 Cables Anywhere                         
Alice Mynhier                        303-696-0557 almyn@Nway.magcomp.com                             Magic Components                        
Allen Robles                         644-730-8090 copy@onlineservice.com                             Copy Center                             
Allison Roland                       929-498-4174 alley@onlineservice.com                            NONE ON RECORD                          
Allison Roland                       929-498-4174                                                    Eagle Electronic                        
Amy Heide                            802-894-1024 letout@usol.com                                    Outlets                                 
Andrea Griswold                      970-746-0995 andygwold@usol.com                                 NONE ON RECORD                          
Andrea Montgomery                    349-397-7772                                                    NONE ON RECORD                          
Andrew Ray                           609-345-9680 andyray@usol.com                                   NONE ON RECORD                          
Andrew Smith                         709-307-2568 smokey@zeronet.net                                 NONE ON RECORD                          
Andrew Yelnick                       517-803-5818 family@free.com                                    NONE ON RECORD                          

CUSTFIRSTNAME||''||CUSTLASTNAME      PHONE        EMAILADDR                                          NVL(COMPANYNAME,'NONEONRECORD')         
------------------------------------ ------------ -------------------------------------------------- ----------------------------------------
Andy Huegel                          302-620-1366                                                    NONE ON RECORD                          
Angela Wainscott                     208-788-4112 awainscott@free.com                                NONE ON RECORD                          
Angie Hoover                         307-459-4165 ahoover@free.com                                   Goodwork Corporation                    
Anita Pastron                        901-796-4654 contracts@fast.com                                 Industrail Contracting Co               
Anna Mayton                          888-451-1233 doctor@free.com                                    NONE ON RECORD                          
Anne Hatzell                         302-651-6440 hazel@zeronet.net                                  NONE ON RECORD                          
Ansel Farrell                        712-440-3934 prickly@onlineservice.com                          NONE ON RECORD                          
Archie Doremski                      307-944-8959 sheetz@free.com                                    Greenpart Steet Metal                   
Aricka Bross                         419-676-9758 placetolive@free.com                               Apartment Referrals                     
Austin Ortman                        919-774-9999                                                    Eagle Electronic                        
Beth Zobitz                          919-747-8404 bzobitz@eagle.com                                  Eagle Electronic                        

CUSTFIRSTNAME||''||CUSTLASTNAME      PHONE        EMAILADDR                                          NVL(COMPANYNAME,'NONEONRECORD')         
------------------------------------ ------------ -------------------------------------------------- ----------------------------------------
Bill Umbarger                        207-155-1577 cheezy@onlineservice.com                           NONE ON RECORD                          
Bob Weldy                            571-490-6449 sucker42@usol.com                                  NONE ON RECORD                          
Brad Arquette                        775-914-4294 arq@usol.com                                       NONE ON RECORD                          
Brenda Jones                         720-800-2638 show@free.com                                      NONE ON RECORD                          
Brenda Kitchel                       804-214-8732 cheesman@zeronet.net                               Cheesman Corporation                    
Brenda Pritchett                     302-696-1000 bpritchett@wizelec.com                             Wizard Electronics                      
Bridgette Kyger                      301-467-6480 homeloans@fast.com                                 Sampson Home Mortgages                  
Brittany Cottingham                  419-464-5273 plastic@onlineservice.com                          Cottingham Plastics                     
Bruce Fogarty                        598-791-1420 photoniche@usol.com                                Photography Niche                       
Bryan Price                          804-674-9666                                                    NONE ON RECORD                          
Calie Zollman                        929-763-2047                                                    Eagle Electronic                        

CUSTFIRSTNAME||''||CUSTLASTNAME      PHONE        EMAILADDR                                          NVL(COMPANYNAME,'NONEONRECORD')         
------------------------------------ ------------ -------------------------------------------------- ----------------------------------------
Carey Dailey                         728-896-2767 shelty@usol.com                                    NONE ON RECORD                          
Carl Dallas                          864-541-5114 analyzeh20@fast.com                                Water Analysts                          
Carl Hague                           419-890-3531                                                    NONE ON RECORD                          
Carrie Buchko                        817-739-1335 goobert@free.com                                   NONE ON RECORD                          
Cathy Bending                        765-617-2811 rrair@zeronet.net                                  R and R Air                             
Cathy Harvey                         336-477-0249 findwork@onlineservice.com                         The Employment Agency                   
Cecil Scheetz                        207-679-9822 cecil@free.com                                     Tippe Inn                               
Charlene Franks                      307-892-2938 learn@rydell.edu                                   Rydell High School                      
Charles Jones                        919-774-5552 charlie@usol.com                                   NONE ON RECORD                          
Charles Jones                        919-774-5552 cjones@eagle.com                                   Eagle Electronic                        
Chas Funk                            860-498-3900 duck@usol.com                                      NONE ON RECORD                          

CUSTFIRSTNAME||''||CUSTLASTNAME      PHONE        EMAILADDR                                          NVL(COMPANYNAME,'NONEONRECORD')         
------------------------------------ ------------ -------------------------------------------------- ----------------------------------------
Chris Dunlap                         307-473-2281                                                    NONE ON RECORD                          
Christina Wilson                     316-210-8989                                                    NONE ON RECORD                          
Dan Lageveen                         307-344-8928 veenie@zeronet.net                                 NONE ON RECORD                          
Daniel Barton                        915-894-8034 dannie@zeronet.net                                 NONE ON RECORD                          
Daniel Ezra                          207-744-1997 swim@zeronet.net                                   Pools For You                           
Daniel Hundnall                      918-830-9731 fixit@usol.com                                     Bobs Repair Service                     
Daniel Rodkey                        719-748-3205 dannie@free.com                                    NONE ON RECORD                          
Daniel Stabnik                       636-746-4124                                                    NONE ON RECORD                          
Danita Sharp                         360-650-5604 girlfriend@fast.com                                NONE ON RECORD                          
Darlene Jenkins                      678-490-5461 DarJen@Germ.opticimag.com                          Optical Images                          
David Becker                         843-646-4187 BeckerDavid@Loadiu.com                             Load It Up                              

CUSTFIRSTNAME||''||CUSTLASTNAME      PHONE        EMAILADDR                                          NVL(COMPANYNAME,'NONEONRECORD')         
------------------------------------ ------------ -------------------------------------------------- ----------------------------------------
David Chang                          740-750-1272 lion@free.com                                      NONE ON RECORD                          
David Deppe                          919-747-5155                                                    Eagle Electronic                        
David Keck                           919-747-9921                                                    Eagle Electronic                        
David Schilling                      502-421-1516                                                    NONE ON RECORD                          
David Smith                          309-980-4350 emerald@onlineservice.com                          NONE ON RECORD                          
David Tarter                         518-500-0570 estate@fast.com                                    Realty Specialties                      
David Tietz                          651-912-1583 tietz@free.com                                     NONE ON RECORD                          
Dean Eagon                           970-581-8611                                                    NONE ON RECORD                          
Dean Katpally                        808-799-3727 phonecorp@usol.com                                 Phone Corporation                       
Debra Cruz                           812-547-7359 Debra@Francomp.com                                 Computer Fundamentals                   
Dennis Drazer                        253-315-4247 dollarplan@usol.com                                Financial Planning Consul               

CUSTFIRSTNAME||''||CUSTLASTNAME      PHONE        EMAILADDR                                          NVL(COMPANYNAME,'NONEONRECORD')         
------------------------------------ ------------ -------------------------------------------------- ----------------------------------------
Dennis Eberle                        515-708-1802 deber@free.com                                     NONE ON RECORD                          
Dennis Mundy                         603-306-0774 rino@usol.com                                      NONE ON RECORD                          
Dennis Sammons                       616-544-1969 repairit@free.com                                  Gards Auto Repair                       
Don Kaleta                           724-695-2157 stud@zeronet.net                                   NONE ON RECORD                          
Don Torres                           706-649-6375 drill@usol.com                                     Down Deep Drilling Inc.                 
Donald Blythe                        520-486-6025 Dblythe@makenoise.com                              Make Some Noise Inc.                    
Dorlan Bresnaham                     603-497-7374 dorlan@usol.com                                    NONE ON RECORD                          
Dorthy Beering                       213-465-4900 dbeering@actual.com                                Actual  Computers                       
Doug Blizzard                        228-646-5114 collectit@onlineservice.com                        Collectibles Inc.                       
Dusty Jones                          674-727-0511 rr@usol.com                                        Railroad Express                        
Edna Lilley                          929-498-2840 elilley@eagle.com                                  Eagle Electronic                        

CUSTFIRSTNAME||''||CUSTLASTNAME      PHONE        EMAILADDR                                          NVL(COMPANYNAME,'NONEONRECORD')         
------------------------------------ ------------ -------------------------------------------------- ----------------------------------------
Elizabeth Clark                      646-846-6232 eclark.com                                         Luxury Laptops                          
Elizabeth Derhammer                  785-970-9916 lizzy@onlineservice.com                            NONE ON RECORD                          
Elizabeth Henderson                  449-486-8018                                                    NONE ON RECORD                          
Eric Becker                          910-717-7613 daddyo@usol.com                                    NONE ON RECORD                          
Eric Fannon                          209-980-0812 ef@free.com                                        NONE ON RECORD                          
Eric Quintero                        812-805-1588 diamond@onlineservice.com                          NONE ON RECORD                          
Eugene Gasper                        705-580-6124 medcare@fast.com                                   Regency Hospital                        
Evelyn Cassens                       302-762-9526 dr.animal@onlineservice.com                        Vets Inc.                               
Frank Aamodt                         898-762-8741 fa@fast.com                                        Franklin Trinkets                       
Frank Malady                         574-493-0510 frankmala@zeronet.net                              NONE ON RECORD                          
Gabrielle Stevenson                  929-763-4873 gstevenson@eagle.com                               Eagle Electronic                        

CUSTFIRSTNAME||''||CUSTLASTNAME      PHONE        EMAILADDR                                          NVL(COMPANYNAME,'NONEONRECORD')         
------------------------------------ ------------ -------------------------------------------------- ----------------------------------------
Gary German                          919-774-3325 ggerman@eagle.com                                  Eagle Electronic                        
Gary Kempf                           937-724-7313 kempfg@free.com                                    NONE ON RECORD                          
Gary Mikels                          505-660-9632 GaryMikels@Swiss.Alliance.com                      Networking Alliance                     
Geo Schofield                        228-480-9751 cleanit@usol.com                                   Cleaning Supply                         
George Purcell                       432-320-6905 design@zeronet.net                                 BMA Advertising Design                  
George Trenkle                       856-267-7913 cold@fast.com                                      NONE ON RECORD                          
Gerald Campbell                      431-087-1044 gcampbell@free.com                                 NONE ON RECORD                          
Ginger Xiao                          605-846-0451 acctsbryant@zeronet.net                            Bryant Accounting                       
Gordon Mayes                         207-634-1969 Gordon@den.modmagic.com                            Modem Magicians                         
Gregory Abbott                       812-447-3621 greggie@usol.com                                   Baker and Company                       
Gregory Hettinger                    929-498-7144                                                    Eagle Electronic                        

CUSTFIRSTNAME||''||CUSTLASTNAME      PHONE        EMAILADDR                                          NVL(COMPANYNAME,'NONEONRECORD')         
------------------------------------ ------------ -------------------------------------------------- ----------------------------------------
Heather Wallpe                       816-433-9799 flex@onlineservice.com                             Reflexions Manufacturing                
Heather Waters                       869-741-7817 dates@free.com                                     Happytime Escort Service                
Helene Ziekart                       203-244-9192                                                    NONE ON RECORD                          
Hugo Gillespie                       785-981-0669 critters@free.com                                  Wadake Critters                         
Irene Poczekay                       401-461-9567                                                    NONE ON RECORD                          
Jack Akers                           301-454-6061 pizazz@usol.com                                    NONE ON RECORD                          
Jack Barrick                         786-494-4782 1natbank@free.com                                  First National Bank                     
Jack Brose                           919-486-5104                                                    Eagle Electronic                        
Jack Illingworth                     914-748-9829 illing@free.com                                    NONE ON RECORD                          
Jacob Richer                         425-942-3763 laugh@free.com                                     NONE ON RECORD                          
James Gross                          908-879-8672 jgross@fast.com                                    NONE ON RECORD                          

CUSTFIRSTNAME||''||CUSTLASTNAME      PHONE        EMAILADDR                                          NVL(COMPANYNAME,'NONEONRECORD')         
------------------------------------ ------------ -------------------------------------------------- ----------------------------------------
James Jones                          971-522-5851 puffy@fast.com                                     NONE ON RECORD                          
James King                           207-708-3317 jamesk@usol.com                                    NONE ON RECORD                          
James Laake                          613-785-7063                                                    NONE ON RECORD                          
James Schilling                      319-429-9772                                                    NONE ON RECORD                          
Jamie Osman                          919-486-2519 josman@eagle.com                                   Eagle Electronic                        
Jamie Pickett                        937-147-2569 jpickett@machinemiracle.com                        Miracle Machines                        
Jamie Thompson                       706-471-1222 jthompson@onlineservice.com                        NONE ON RECORD                          
Jane Mumford                         270-428-5866                                                    NONE ON RECORD                          
Jared Meers                          701-371-1701 rehabsouth@zeronet.net                             South Street Rehabilitation             
Jason Krasner                        919-774-7920                                                    Eagle Electronic                        
Jason Laxton                         978-860-2824 coondog@usol.com                                   NONE ON RECORD                          

CUSTFIRSTNAME||''||CUSTLASTNAME      PHONE        EMAILADDR                                          NVL(COMPANYNAME,'NONEONRECORD')         
------------------------------------ ------------ -------------------------------------------------- ----------------------------------------
Jason Wendling                       919-774-6798 jwendling@eagle.com                                Eagle Electronic                        
Jay Hanau                            773-490-8254                                                    NONE ON RECORD                          
Jeff Kowaiski                        212-492-5644 equipit@usol.com                                   Quality Equipment Corp.                 
Jeffery Jordan                       509-989-9996 seeya@usol.com                                     NONE ON RECORD                          
Jennie Fry                           806-456-6285 Jfry@yourparts.com                                 Pick Your Parts                         
Jennifer Hundley                     304-713-3298 jenhund@fast.com                                   NONE ON RECORD                          
Jennifer Kmec                        443-542-1386 dancingk@free.com                                  Kelly Dance Studio                      
Jerry Mennen                         520-306-8426 mennenj@free.com                                   NONE ON RECORD                          
Jerry Muench                         464-669-8537 redhot@onlineservice.com                           NONE ON RECORD                          
Jessica Cain                         517-901-2610                                                    NONE ON RECORD                          
Jessica Nakamura                     605-324-2193 carsell@usol.com                                   Automart                                

CUSTFIRSTNAME||''||CUSTLASTNAME      PHONE        EMAILADDR                                          NVL(COMPANYNAME,'NONEONRECORD')         
------------------------------------ ------------ -------------------------------------------------- ----------------------------------------
Jim Lichty                           618-847-1904 bankrupt@usol.com                                  Bankruptcy Help                         
Jim Manaugh                          919-747-5603 jmanaugh@eagle.com                                 Eagle Electronic                        
Jim Manaugh                          919-747-5603 jmanaugh@eagle.com                                 NONE ON RECORD                          
Jim Sokeland                         723-366-1117 employment@zeronet.net                             Powerful Employment                     
Jim Webb                             978-204-3019                                                    NONE ON RECORD                          
Jo Jacko                             856-752-7471                                                    NONE ON RECORD                          
Joan Hedden                          501-710-0658                                                    NONE ON RECORD                          
Joanne Rosner                        919-486-2822                                                    Eagle Electronic                        
John Garcia                          207-311-0174 jgar@onlineservice.com                             NONE ON RECORD                          
John McGinnis                        208-741-1963 john@zeronet.net                                   NONE ON RECORD                          
John Skadberg                        513-282-3919 skad@zeronet.net                                   NONE ON RECORD                          

CUSTFIRSTNAME||''||CUSTLASTNAME      PHONE        EMAILADDR                                          NVL(COMPANYNAME,'NONEONRECORD')         
------------------------------------ ------------ -------------------------------------------------- ----------------------------------------
Jon Clute                            480-181-8940                                                    NONE ON RECORD                          
Jonathon Blanco                      902-226-1858 hammer@free.com                                    NONE ON RECORD                          
Joseph Platt                         929-763-5228                                                    Eagle Electronic                        
Joseph Schuman                       330-209-1273                                                    NONE ON RECORD                          
Joshua Cole                          865-269-7782 fido@zeronet.net                                   NONE ON RECORD                          
Juicheng Nugent                      802-352-8923 nugent@fast.com                                    NONE ON RECORD                          
Kara Orze                            414-773-1017 appinc@zeronet.net                                 Appliances Inc.                         
Karen Burns                          707-598-2670 burnskaren@fast.com                                Recreation Supply                       
Karen Mangus                         863-623-0459 missright@onlineservice.com                        NONE ON RECORD                          
Karen Marko                          580-555-1871 marko@usol.com                                     NONE ON RECORD                          
Karen Randolph                       603-744-9002 cookin@zeronet.net                                 NONE ON RECORD                          

CUSTFIRSTNAME||''||CUSTLASTNAME      PHONE        EMAILADDR                                          NVL(COMPANYNAME,'NONEONRECORD')         
------------------------------------ ------------ -------------------------------------------------- ----------------------------------------
Kathleen Plyman                      507-543-2052 needles@onlineservice.com                          Needle Center                           
Kathleen Xolo                        929-763-5513 kxolo@eagle.com                                    Eagle Electronic                        
Kathryn Deagen                       919-747-9164                                                    Eagle Electronic                        
Kathy Gunderson                      941-330-3314                                                    NONE ON RECORD                          
Kelli Jones                          912-647-0391 kjoneskelli@DCI.com                                Dot Com Incorporated                    
Kelly Jordan                         727-951-7737 supplycrafts@fast.com                              Supplying Crafts                        
Kenneth Mintier                      323-673-0690 builder@usol.com                                   NONE ON RECORD                          
Kenneth Wilcox                       515-872-8848 kenny@onlineservice.com                            NONE ON RECORD                          
Kevin Jackson                        225-624-2341                                                    NONE ON RECORD                          
Kevin Martin                         606-677-9789 kmartin@easyaccess.com                             Easy Accessories                        
Kevin Zubarev                        208-364-3785 sign3@fast.com                                     Signs Signs Signs                       

CUSTFIRSTNAME||''||CUSTLASTNAME      PHONE        EMAILADDR                                          NVL(COMPANYNAME,'NONEONRECORD')         
------------------------------------ ------------ -------------------------------------------------- ----------------------------------------
Kimber Spaller                       878-119-5448 mcgimmie@zero.net                                  NONE ON RECORD                          
Kris Shinn                           469-740-2748 shinnk@zeronet.net                                 NONE ON RECORD                          
Kristen Gustavel                     919-747-1530 kgustavel@eagle.com                                Eagle Electronic                        
Kristey Moore                        919-486-6765                                                    Eagle Electronic                        
Kristy Moore                         919-486-6765 fluffy@onlineservice.com                           NONE ON RECORD                          
Lance Andrews                        972-534-7322 LanceA@braz.monitorU.com                           Monitors for You                        
Larry Gardiner                       225-313-6268 square@onlineserveice.com                          NONE ON RECORD                          
Larry Osmanova                       541-905-4819 citybus@fast.com                                   City Bus Transport                      
Laura Rodgers                        929-763-0691                                                    Eagle Electronic                        
Lawrence Pullen                      644-591-3243 laurie@free.com                                    NONE ON RECORD                          
Linda Bowen                          605-234-4114                                                    NONE ON RECORD                          

CUSTFIRSTNAME||''||CUSTLASTNAME      PHONE        EMAILADDR                                          NVL(COMPANYNAME,'NONEONRECORD')         
------------------------------------ ------------ -------------------------------------------------- ----------------------------------------
Linda Hari                           270-411-2316                                                    NONE ON RECORD                          
Linda Li                             203-744-4677 ll@free.com                                        NONE ON RECORD                          
Lisa Pettry                          702-799-7272 lpett@zeronet.net                                  NONE ON RECORD                          
Loraine Platt                        520-475-5322 LoraineP@ComponGerm.com                            Greatest Components                     
Lou Caldwell                         606-901-1238 lucky@fast.com                                     NONE ON RECORD                          
Louise Cool                          208-956-0698                                                    NONE ON RECORD                          
Lucille Appleton                     914-497-2160 muscle@zeronet.net                                 NONE ON RECORD                          
Lynne Lagunes                        208-502-9976 hello@zeronet.net                                  NONE ON RECORD                          
Marc Williams                        435-774-4595 peanut@fast.com                                    NONE ON RECORD                          
Marjorie Vandermay                   308-489-1137 nam@fast com                                       National Art Museum                     
Marla Reeder                         728-442-3031 reedmar@zeronet.net                                NONE ON RECORD                          

CUSTFIRSTNAME||''||CUSTLASTNAME      PHONE        EMAILADDR                                          NVL(COMPANYNAME,'NONEONRECORD')         
------------------------------------ ------------ -------------------------------------------------- ----------------------------------------
Marty Fay                            501-631-3727 sparky@free.com                                    NONE ON RECORD                          
Mary Ann Rausch                      307-944-3324 spiritual@free.com                                 NONE ON RECORD                          
Mary Deets                           808-562-4081 camphere@fast.com                                  Camping Supplies                        
Mary Jo Wales                        852-441-4984 jomary@onlineservice.com                           NONE ON RECORD                          
Mary Uhl                             803-974-2809 mouse@fast.com                                     Flowers by Mickey                       
Matt Nakanishi                       435-710-5324 nakan@free.com                                     NONE ON RECORD                          
Matt Shade                           623-422-6616 shadtree@free.com                                  NONE ON RECORD                          
Matt Smith                           719-822-8828 matsm@fast.com                                     NONE ON RECORD                          
Matthew Quant                        910-577-1319 walker@onlineservice.com                           NONE ON RECORD                          
Meghan Tyrie                         919-747-8589 mtyrie@eagle.com                                   Eagle Electronic                        
Melissa Alvarez                      919-747-3781                                                    Eagle Electronic                        

CUSTFIRSTNAME||''||CUSTLASTNAME      PHONE        EMAILADDR                                          NVL(COMPANYNAME,'NONEONRECORD')         
------------------------------------ ------------ -------------------------------------------------- ----------------------------------------
Melody Fazal                         760-877-4849 melfazal@zeronet.net                               NONE ON RECORD                          
Meredith Rushing                     606-608-2105 merry@free.com                                     NONE ON RECORD                          
Michael Abbott                       919-774-2720 mabbott@eagle.com                                  Eagle Electronic                        
Michael Emore                        352-472-1224 mikemore@usol.com                                  NONE ON RECORD                          
Michael Tendam                       406-424-7496 flute@usol.com                                     NONE ON RECORD                          
Michelle Nairn                       919-486-6919                                                    Eagle Electronic                        
Michelle Oakley                      978-514-5425 littleone@usol.com                                 NONE ON RECORD                          
Mike Condie                          336-211-1238 kidrec@zeronet.net                                 Kids Recreation Inc.                    
Mike Dunbar                          208-297-5374 duh@onlineservice.com                              NONE ON RECORD                          
Mildred Jones                        610-437-6687 compconsul@usol.com                                Computer Consultants                    
Nancy Basham                         207-422-7135                                                    NONE ON RECORD                          

CUSTFIRSTNAME||''||CUSTLASTNAME      PHONE        EMAILADDR                                          NVL(COMPANYNAME,'NONEONRECORD')         
------------------------------------ ------------ -------------------------------------------------- ----------------------------------------
Nicholas Albregts                    929-763-4843                                                    Eagle Electronic                        
Noemi Elston                         307-359-9514 closetoheaven@zeronet.net                          North Street Church                     
Norman Fields                        501-346-4841 catv@onlineservice.com                             The Cable Company                       
Orville Gilliland                    490-263-2957 eia@zeronet.net                                    Easy Internet Access                    
Pam Krick                            860-624-2539 pkrick@Passoc.com                                  Printing Associated                     
Patricha Underwood                   929-498-1956                                                    Eagle Electronic                        
Patricia Leong                       520-247-4141 patrice@usol.com                                   NONE ON RECORD                          
Patrick Bollock                      307-635-1692 pat@fast.com                                       NONE ON RECORD                          
Paul Eckelman                        919-486-6410 peckelman@eagle.com                                Eagle Electronic                        
Paul Kaakeh                          719-750-4539 graphit@usol.com                                   Laser Graphics Associates               
Paul Rice                            719-541-1837 paulier@onlineservice.com                          NONE ON RECORD                          

CUSTFIRSTNAME||''||CUSTLASTNAME      PHONE        EMAILADDR                                          NVL(COMPANYNAME,'NONEONRECORD')         
------------------------------------ ------------ -------------------------------------------------- ----------------------------------------
Paul Smith                           219-703-2277 psmith@computervideo.comq                          Computer Video                          
Paul Sullivan                        785-322-5896 sullie@zeronet.net                                 NONE ON RECORD                          
Peter Austin                         803-343-6063                                                    NONE ON RECORD                          
Phil Reece                           919-486-0649 sly@zeronet.net                                    NONE ON RECORD                          
Phil Reece                           919-486-0649                                                    Eagle Electronic                        
Phillip Hession                      231-711-6837 howdy@usol.com                                     NONE ON RECORD                          
Rachel Davis                         702-907-4818 rachdav@zeronet.net                                NONE ON RECORD                          
Randall Neely                        802-319-9805 storage@fast.com                                   Store It Here                           
Randolph Darling                     860-684-1620 randolph@fast.com                                  NONE ON RECORD                          
Randy Talauage                       347-671-2022 paintit@fast.com                                   Ceramic Supply                          
Richard Kluth                        302-296-8012 rickkluth@free.com                                 Main St. Bar and Grill                  

CUSTFIRSTNAME||''||CUSTLASTNAME      PHONE        EMAILADDR                                          NVL(COMPANYNAME,'NONEONRECORD')         
------------------------------------ ------------ -------------------------------------------------- ----------------------------------------
Richard Scott                        304-774-2226 kick@onlineservice.com                             Karate Made Easy                        
Richard Stetler                      256-412-8112 screwball@free.com                                 NONE ON RECORD                          
Richard Strehle                      206-434-7305 vacation@fast.com                                  Vacation Car Rentals                    
Richard Zito                         603-787-0787 rzito@zeronet.net                                  NONE ON RECORD                          
Rita Bush                            919-747-4397 rbush@eagle.com                                    Eagle Electronic                        
Rob Thomas                           484-374-1998 rthomas@bestchoice.com                             Accessories and More                    
Robert Cortez                        603-442-3740                                                    NONE ON RECORD                          
Robert Dalury                        906-278-6446 tas@zeronet.net                                    TAS                                     
Robert Lister                        801-404-1240 fines@free.com                                     Fire Alarm Systems                      
Ronald Day                           929-763-6488                                                    Eagle Electronic                        
Ronald Miller                        734-820-2076 picky@zeronet.net                                  NONE ON RECORD                          

CUSTFIRSTNAME||''||CUSTLASTNAME      PHONE        EMAILADDR                                          NVL(COMPANYNAME,'NONEONRECORD')         
------------------------------------ ------------ -------------------------------------------------- ----------------------------------------
Rosemary Vanderhoff                  770-293-8783                                                    NONE ON RECORD                          
Roy Beer                             206-745-2584 wizzy@usol.com                                     NONE ON RECORD                          
Roy McGrew                           208-324-0783 grow@zeronet.net                                   NONE ON RECORD                          
Russ Mann                            775-549-1798 scooter@onlineservice.com                          NONE ON RECORD                          
Ruth Albeering                       784-444-0131 rabeering@free.com                                 NONE ON RECORD                          
Ruth Ball                            651-479-7538                                                    NONE ON RECORD                          
Ryan Stahley                         919-774-5340 rstahley@eagle.com                                 Eagle Electronic                        
Ryan Stahley                         919-774-5340 rstahley@eagle.com                                 NONE ON RECORD                          
Sally Valle                          972-234-2044 roi@usol.com                                       Investment Specialties                  
Sandy Goodman                        208-614-3136 Sgoodman@connex.com                                Connexions                              
Sarah McCammon                       520-438-7944 squirrel@zeronet.net                               NONE ON RECORD                          

CUSTFIRSTNAME||''||CUSTLASTNAME      PHONE        EMAILADDR                                          NVL(COMPANYNAME,'NONEONRECORD')         
------------------------------------ ------------ -------------------------------------------------- ----------------------------------------
Scott Gray                           484-453-7105 keepsafe@zeronet.net                               Security Installation                   
Scott Yarian                         252-310-2224 syarian@fast.com                                   NONE ON RECORD                          
Sean Akropolis                       907-262-4254 pickle@free.com                                    NONE ON RECORD                          
Sharon Rouls                         205-246-3224 irish@free.com                                     Sharons Shamrock                        
Sherman Cheswick                     929-498-8150 scheswick@eagle.com                                Eagle Electronic                        
Sherry Garling                       353-822-7623 homely@fast.com                                    Manufactured Homes Corp.                
Shirley Osborne                      706-333-7174                                                    NONE ON RECORD                          
Stephanie Pearl                      660-447-8319 mommyl@fast.com                                    NONE ON RECORD                          
Stephanie Yeinick                    573-455-4278 jewels@usol.com                                    Tuckers Jewels                          
Stephen Bird                         540-514-1415 sbird@storeit.com                                  Storage Specialties                     
Steve Cochran                        929-763-1283                                                    Eagle Electronic                        

CUSTFIRSTNAME||''||CUSTLASTNAME      PHONE        EMAILADDR                                          NVL(COMPANYNAME,'NONEONRECORD')         
------------------------------------ ------------ -------------------------------------------------- ----------------------------------------
Steve Fulkerson                      602-129-1885 cellcall@usol.com                                  Cellular Services                       
Steve Hess                           919-486-8804                                                    Eagle Electronic                        
Steven Hickman                       919-774-4874 shickman@eagle.com                                 Eagle Electronic                        
Steven Yaun                          317-780-9804 yawn@fast.com                                      NONE ON RECORD                          
Susan Strong                         912-760-7840 fammed@onlineservice.com                           Family Medical Center                   
Susan Watson                         801-746-7701 mswatson@fast.com                                  NONE ON RECORD                          
Tammi Baldocchio                     401-989-4975                                                    NONE ON RECORD                          
Ted Zissa                            405-151-7445                                                    NONE ON RECORD                          
Terry Xu                             417-546-2570 muffin@fast.com                                    NONE ON RECORD                          
Thomas Wolfe                         610-365-9766 wolf@onlineservice.com                             NONE ON RECORD                          
Thomas Zelenka                       603-374-3706 zelenka@free.com                                   NONE ON RECORD                          

CUSTFIRSTNAME||''||CUSTLASTNAME      PHONE        EMAILADDR                                          NVL(COMPANYNAME,'NONEONRECORD')         
------------------------------------ ------------ -------------------------------------------------- ----------------------------------------
Thurman Mezzo                        415-967-1415 tmezzo@playingaround.com                           Playing Around                          
Tim Carlton                          203-608-3465                                                    NONE ON RECORD                          
Tim Leffert                          315-486-4777 trailrent@zeronet.net                              Trailor Rentals                         
Tim Parker                           315-985-4102 jeckle@onlineservice.com                           NONE ON RECORD                          
Tim White                            517-777-1905 twhite@networkN.com                                Network Niche                           
Timothy Neal                         704-736-9458 tneal@compAccess.com                               Computer Accessories                    
Tina Yates                           929-763-4438 tyates@eagle.com                                   Eagle Electronic                        
Todd Vigus                           919-486-7143 tvigus@eagle.com                                   Eagle Electronic                        
Tom Baker                            414-778-5640 bologna@free.com                                   NONE ON RECORD                          
Tom Irelan                           240-634-5581 tucker@free.com                                    NONE ON RECORD                          
Tom Moore                            270-692-2845 seedle@fast.com                                    NONE ON RECORD                          

CUSTFIRSTNAME||''||CUSTLASTNAME      PHONE        EMAILADDR                                          NVL(COMPANYNAME,'NONEONRECORD')         
------------------------------------ ------------ -------------------------------------------------- ----------------------------------------
Tommy McFerren                       503-767-7054 mcferren@cole.com                                  Cole Sales and Associates               
Tonya Owens                          843-773-2751                                                    NONE ON RECORD                          
Tracy Cicholski                      601-959-1315 dixpharm@free.com                                  Dixon Pharmacy                          
Travis Camargo                       816-746-4913                                                    NONE ON RECORD                          
Travis Honn                          303-564-1515 thonn@radiant.com                                  Radiant Computers                       
Trevor Snuffer                       336-185-0630 snuffer@zeronet.net                                NONE ON RECORD                          
Trudi Antonio                        718-747-3259 toni@onlineservice.com                             NONE ON RECORD                          
Verna McGrew                         334-547-9329 verngrew@free.com                                  NONE ON RECORD                          
Wade Holle                           887-746-6174 Wade@jLi.com                                       Just Link It                            
Wade Jacobs                          803-477-5347 connernat@usol.com                                 Conner National                         
William Newlon                       909-452-4936 Wnewlon@ccs.com                                    Creative Computer Solutions             

CUSTFIRSTNAME||''||CUSTLASTNAME      PHONE        EMAILADDR                                          NVL(COMPANYNAME,'NONEONRECORD')         
------------------------------------ ------------ -------------------------------------------------- ----------------------------------------
Yauleng Depoe                        313-475-1177 ydepoe@sw.com                                      Scanning the World                      
Zach McGrew                          520-730-8494                                                    NONE ON RECORD                          
Zack Hill                            503-794-2322 boogie@free.com                                    NONE ON RECORD                          

300 rows selected. 

Question 3
300 rows inserted.

Question 4

300 rows updated.


NAME                 COMPANYNAME                              TELEPHONE      EMAILADDRESS                                      
-------------------- ---------------------------------------- -------------- --------------------------------------------------
Jamie Osman          Eagle Electronic                         919-486-2519   josman@eagle.com                                  
Jamie Pickett        Miracle Machines                         937-147-2569   jpickett@machinemiracle.com                       
Jamie Thompson       NONE ON RECORD                           706-471-1222   jthompson@onlineservice.com                       
Jane Mumford         NONE ON RECORD                           270-428-5866   NONE ON RECORD                                    
Jared Meers          South Street Rehabilitation              701-371-1701   rehabsouth@zeronet.net                            
Jason Krasner        Eagle Electronic                         919-774-7920   NONE ON RECORD                                    
Jason Laxton         NONE ON RECORD                           978-860-2824   coondog@usol.com                                  
Jason Wendling       Eagle Electronic                         919-774-6798   jwendling@eagle.com                               
Jay Hanau            NONE ON RECORD                           773-490-8254   NONE ON RECORD                                    
Jeff Kowaiski        Quality Equipment Corp.                  212-492-5644   equipit@usol.com                                  
Jeffery Jordan       NONE ON RECORD                           509-989-9996   seeya@usol.com                                    

NAME                 COMPANYNAME                              TELEPHONE      EMAILADDRESS                                      
-------------------- ---------------------------------------- -------------- --------------------------------------------------
Jennie Fry           Pick Your Parts                          806-456-6285   Jfry@yourparts.com                                
Jennifer Hundley     NONE ON RECORD                           304-713-3298   jenhund@fast.com                                  
Jennifer Kmec        Kelly Dance Studio                       443-542-1386   dancingk@free.com                                 
Jerry Mennen         NONE ON RECORD                           520-306-8426   mennenj@free.com                                  
Jerry Muench         NONE ON RECORD                           464-669-8537   redhot@onlineservice.com                          
Jessica Cain         NONE ON RECORD                           517-901-2610   NONE ON RECORD                                    
Jessica Nakamura     Automart                                 605-324-2193   carsell@usol.com                                  
Jim Lichty           Bankruptcy Help                          618-847-1904   bankrupt@usol.com                                 
Jim Manaugh          Eagle Electronic                         919-747-5603   jmanaugh@eagle.com                                
Jim Manaugh          NONE ON RECORD                           919-747-5603   jmanaugh@eagle.com                                
Jim Sokeland         Powerful Employment                      723-366-1117   employment@zeronet.net                            

NAME                 COMPANYNAME                              TELEPHONE      EMAILADDRESS                                      
-------------------- ---------------------------------------- -------------- --------------------------------------------------
Jim Webb             NONE ON RECORD                           978-204-3019   NONE ON RECORD                                    
Jo Jacko             NONE ON RECORD                           856-752-7471   NONE ON RECORD                                    
Joan Hedden          NONE ON RECORD                           501-710-0658   NONE ON RECORD                                    
Joanne Rosner        Eagle Electronic                         919-486-2822   NONE ON RECORD                                    
John Garcia          NONE ON RECORD                           207-311-0174   jgar@onlineservice.com                            
John McGinnis        NONE ON RECORD                           208-741-1963   john@zeronet.net                                  
John Skadberg        NONE ON RECORD                           513-282-3919   skad@zeronet.net                                  
Jon Clute            NONE ON RECORD                           480-181-8940   NONE ON RECORD                                    
Jonathon Blanco      NONE ON RECORD                           902-226-1858   hammer@free.com                                   
Joseph Platt         Eagle Electronic                         929-763-5228   NONE ON RECORD                                    
Joseph Schuman       NONE ON RECORD                           330-209-1273   NONE ON RECORD                                    

NAME                 COMPANYNAME                              TELEPHONE      EMAILADDRESS                                      
-------------------- ---------------------------------------- -------------- --------------------------------------------------
Joshua Cole          NONE ON RECORD                           865-269-7782   fido@zeronet.net                                  
Juicheng Nugent      NONE ON RECORD                           802-352-8923   nugent@fast.com                                   
Kara Orze            Appliances Inc.                          414-773-1017   appinc@zeronet.net                                
Karen Burns          Recreation Supply                        707-598-2670   burnskaren@fast.com                               
Karen Mangus         NONE ON RECORD                           863-623-0459   missright@onlineservice.com                       
Karen Marko          NONE ON RECORD                           580-555-1871   marko@usol.com                                    
Karen Randolph       NONE ON RECORD                           603-744-9002   cookin@zeronet.net                                
Kathleen Plyman      Needle Center                            507-543-2052   needles@onlineservice.com                         
Kathleen Xolo        Eagle Electronic                         929-763-5513   kxolo@eagle.com                                   
Kathryn Deagen       Eagle Electronic                         919-747-9164   NONE ON RECORD                                    
Kathy Gunderson      NONE ON RECORD                           941-330-3314   NONE ON RECORD                                    

NAME                 COMPANYNAME                              TELEPHONE      EMAILADDRESS                                      
-------------------- ---------------------------------------- -------------- --------------------------------------------------
Kelli Jones          Dot Com Incorporated                     912-647-0391   kjoneskelli@DCI.com                               
Kelly Jordan         Supplying Crafts                         727-951-7737   supplycrafts@fast.com                             
Kenneth Mintier      NONE ON RECORD                           323-673-0690   builder@usol.com                                  
Kenneth Wilcox       NONE ON RECORD                           515-872-8848   kenny@onlineservice.com                           
Kevin Jackson        NONE ON RECORD                           225-624-2341   NONE ON RECORD                                    
Kevin Martin         Easy Accessories                         606-677-9789   kmartin@easyaccess.com                            
Kevin Zubarev        Signs Signs Signs                        208-364-3785   sign3@fast.com                                    
Kimber Spaller       NONE ON RECORD                           878-119-5448   mcgimmie@zero.net                                 
Kris Shinn           NONE ON RECORD                           469-740-2748   shinnk@zeronet.net                                
Kristen Gustavel     Eagle Electronic                         919-747-1530   kgustavel@eagle.com                               
Kristey Moore        Eagle Electronic                         919-486-6765   NONE ON RECORD                                    

NAME                 COMPANYNAME                              TELEPHONE      EMAILADDRESS                                      
-------------------- ---------------------------------------- -------------- --------------------------------------------------
Kristy Moore         NONE ON RECORD                           919-486-6765   fluffy@onlineservice.com                          
Lance Andrews        Monitors for You                         972-534-7322   LanceA@braz.monitorU.com                          
Larry Gardiner       NONE ON RECORD                           225-313-6268   square@onlineserveice.com                         
Larry Osmanova       City Bus Transport                       541-905-4819   citybus@fast.com                                  
Laura Rodgers        Eagle Electronic                         929-763-0691   NONE ON RECORD                                    
Lawrence Pullen      NONE ON RECORD                           644-591-3243   laurie@free.com                                   
Linda Bowen          NONE ON RECORD                           605-234-4114   NONE ON RECORD                                    
Linda Hari           NONE ON RECORD                           270-411-2316   NONE ON RECORD                                    
Linda Li             NONE ON RECORD                           203-744-4677   ll@free.com                                       
Lisa Pettry          NONE ON RECORD                           702-799-7272   lpett@zeronet.net                                 
Loraine Platt        Greatest Components                      520-475-5322   LoraineP@ComponGerm.com                           

NAME                 COMPANYNAME                              TELEPHONE      EMAILADDRESS                                      
-------------------- ---------------------------------------- -------------- --------------------------------------------------
Lou Caldwell         NONE ON RECORD                           606-901-1238   lucky@fast.com                                    
Louise Cool          NONE ON RECORD                           208-956-0698   NONE ON RECORD                                    
Lucille Appleton     NONE ON RECORD                           914-497-2160   muscle@zeronet.net                                
Lynne Lagunes        NONE ON RECORD                           208-502-9976   hello@zeronet.net                                 
Marc Williams        NONE ON RECORD                           435-774-4595   peanut@fast.com                                   
Marjorie Vandermay   National Art Museum                      308-489-1137   nam@fast com                                      
Marla Reeder         NONE ON RECORD                           728-442-3031   reedmar@zeronet.net                               
Marty Fay            NONE ON RECORD                           501-631-3727   sparky@free.com                                   
Mary Ann Rausch      NONE ON RECORD                           307-944-3324   spiritual@free.com                                
Mary Deets           Camping Supplies                         808-562-4081   camphere@fast.com                                 
Mary Jo Wales        NONE ON RECORD                           852-441-4984   jomary@onlineservice.com                          

NAME                 COMPANYNAME                              TELEPHONE      EMAILADDRESS                                      
-------------------- ---------------------------------------- -------------- --------------------------------------------------
Mary Uhl             Flowers by Mickey                        803-974-2809   mouse@fast.com                                    
Matt Nakanishi       NONE ON RECORD                           435-710-5324   nakan@free.com                                    
Matt Shade           NONE ON RECORD                           623-422-6616   shadtree@free.com                                 
Matt Smith           NONE ON RECORD                           719-822-8828   matsm@fast.com                                    
Matthew Quant        NONE ON RECORD                           910-577-1319   walker@onlineservice.com                          
Meghan Tyrie         Eagle Electronic                         919-747-8589   mtyrie@eagle.com                                  
Melissa Alvarez      Eagle Electronic                         919-747-3781   NONE ON RECORD                                    
Melody Fazal         NONE ON RECORD                           760-877-4849   melfazal@zeronet.net                              
Meredith Rushing     NONE ON RECORD                           606-608-2105   merry@free.com                                    
Michael Abbott       Eagle Electronic                         919-774-2720   mabbott@eagle.com                                 
Michael Emore        NONE ON RECORD                           352-472-1224   mikemore@usol.com                                 

NAME                 COMPANYNAME                              TELEPHONE      EMAILADDRESS                                      
-------------------- ---------------------------------------- -------------- --------------------------------------------------
Michael Tendam       NONE ON RECORD                           406-424-7496   flute@usol.com                                    
Michelle Nairn       Eagle Electronic                         919-486-6919   NONE ON RECORD                                    
Michelle Oakley      NONE ON RECORD                           978-514-5425   littleone@usol.com                                
Mike Condie          Kids Recreation Inc.                     336-211-1238   kidrec@zeronet.net                                
Mike Dunbar          NONE ON RECORD                           208-297-5374   duh@onlineservice.com                             
Mildred Jones        Computer Consultants                     610-437-6687   compconsul@usol.com                               
Nancy Basham         NONE ON RECORD                           207-422-7135   NONE ON RECORD                                    
Nicholas Albregts    Eagle Electronic                         929-763-4843   NONE ON RECORD                                    
Noemi Elston         North Street Church                      307-359-9514   closetoheaven@zeronet.net                         
Norman Fields        The Cable Company                        501-346-4841   catv@onlineservice.com                            
Orville Gilliland    Easy Internet Access                     490-263-2957   eia@zeronet.net                                   

NAME                 COMPANYNAME                              TELEPHONE      EMAILADDRESS                                      
-------------------- ---------------------------------------- -------------- --------------------------------------------------
Pam Krick            Printing Associated                      860-624-2539   pkrick@Passoc.com                                 
Patricha Underwood   Eagle Electronic                         929-498-1956   NONE ON RECORD                                    
Patricia Leong       NONE ON RECORD                           520-247-4141   patrice@usol.com                                  
Patrick Bollock      NONE ON RECORD                           307-635-1692   pat@fast.com                                      
Paul Eckelman        Eagle Electronic                         919-486-6410   peckelman@eagle.com                               
Paul Kaakeh          Laser Graphics Associates                719-750-4539   graphit@usol.com                                  
Paul Rice            NONE ON RECORD                           719-541-1837   paulier@onlineservice.com                         
Paul Smith           Computer Video                           219-703-2277   psmith@computervideo.comq                         
Paul Sullivan        NONE ON RECORD                           785-322-5896   sullie@zeronet.net                                
Peter Austin         NONE ON RECORD                           803-343-6063   NONE ON RECORD                                    
Phil Reece           Eagle Electronic                         919-486-0649   NONE ON RECORD                                    

NAME                 COMPANYNAME                              TELEPHONE      EMAILADDRESS                                      
-------------------- ---------------------------------------- -------------- --------------------------------------------------
Phil Reece           NONE ON RECORD                           919-486-0649   sly@zeronet.net                                   
Phillip Hession      NONE ON RECORD                           231-711-6837   howdy@usol.com                                    
Rachel Davis         NONE ON RECORD                           702-907-4818   rachdav@zeronet.net                               
Randall Neely        Store It Here                            802-319-9805   storage@fast.com                                  
Randolph Darling     NONE ON RECORD                           860-684-1620   randolph@fast.com                                 
Randy Talauage       Ceramic Supply                           347-671-2022   paintit@fast.com                                  
Richard Kluth        Main St. Bar and Grill                   302-296-8012   rickkluth@free.com                                
Richard Scott        Karate Made Easy                         304-774-2226   kick@onlineservice.com                            
Richard Stetler      NONE ON RECORD                           256-412-8112   screwball@free.com                                
Richard Strehle      Vacation Car Rentals                     206-434-7305   vacation@fast.com                                 
Richard Zito         NONE ON RECORD                           603-787-0787   rzito@zeronet.net                                 

NAME                 COMPANYNAME                              TELEPHONE      EMAILADDRESS                                      
-------------------- ---------------------------------------- -------------- --------------------------------------------------
Rita Bush            Eagle Electronic                         919-747-4397   rbush@eagle.com                                   
Rob Thomas           Accessories and More                     484-374-1998   rthomas@bestchoice.com                            
Robert Cortez        NONE ON RECORD                           603-442-3740   NONE ON RECORD                                    
Robert Dalury        TAS                                      906-278-6446   tas@zeronet.net                                   
Robert Lister        Fire Alarm Systems                       801-404-1240   fines@free.com                                    
Ronald Day           Eagle Electronic                         929-763-6488   NONE ON RECORD                                    
Ronald Miller        NONE ON RECORD                           734-820-2076   picky@zeronet.net                                 
Rosemary Vanderhoff  NONE ON RECORD                           770-293-8783   NONE ON RECORD                                    
Roy Beer             NONE ON RECORD                           206-745-2584   wizzy@usol.com                                    
Roy McGrew           NONE ON RECORD                           208-324-0783   grow@zeronet.net                                  
Russ Mann            NONE ON RECORD                           775-549-1798   scooter@onlineservice.com                         

NAME                 COMPANYNAME                              TELEPHONE      EMAILADDRESS                                      
-------------------- ---------------------------------------- -------------- --------------------------------------------------
Ruth Albeering       NONE ON RECORD                           784-444-0131   rabeering@free.com                                
Ruth Ball            NONE ON RECORD                           651-479-7538   NONE ON RECORD                                    
Ryan Stahley         Eagle Electronic                         919-774-5340   rstahley@eagle.com                                
Ryan Stahley         NONE ON RECORD                           919-774-5340   rstahley@eagle.com                                
Sally Valle          Investment Specialties                   972-234-2044   roi@usol.com                                      
Sandy Goodman        Connexions                               208-614-3136   Sgoodman@connex.com                               
Sarah McCammon       NONE ON RECORD                           520-438-7944   squirrel@zeronet.net                              
Scott Gray           Security Installation                    484-453-7105   keepsafe@zeronet.net                              
Scott Yarian         NONE ON RECORD                           252-310-2224   syarian@fast.com                                  
Sean Akropolis       NONE ON RECORD                           907-262-4254   pickle@free.com                                   
Sharon Rouls         Sharons Shamrock                         205-246-3224   irish@free.com                                    

NAME                 COMPANYNAME                              TELEPHONE      EMAILADDRESS                                      
-------------------- ---------------------------------------- -------------- --------------------------------------------------
Sherman Cheswick     Eagle Electronic                         929-498-8150   scheswick@eagle.com                               
Sherry Garling       Manufactured Homes Corp.                 353-822-7623   homely@fast.com                                   
Shirley Osborne      NONE ON RECORD                           706-333-7174   NONE ON RECORD                                    
Stephanie Pearl      NONE ON RECORD                           660-447-8319   mommyl@fast.com                                   
Stephanie Yeinick    Tuckers Jewels                           573-455-4278   jewels@usol.com                                   
Stephen Bird         Storage Specialties                      540-514-1415   sbird@storeit.com                                 
Steve Cochran        Eagle Electronic                         929-763-1283   NONE ON RECORD                                    
Steve Fulkerson      Cellular Services                        602-129-1885   cellcall@usol.com                                 
Steve Hess           Eagle Electronic                         919-486-8804   NONE ON RECORD                                    
Steven Hickman       Eagle Electronic                         919-774-4874   shickman@eagle.com                                
Steven Yaun          NONE ON RECORD                           317-780-9804   yawn@fast.com                                     

NAME                 COMPANYNAME                              TELEPHONE      EMAILADDRESS                                      
-------------------- ---------------------------------------- -------------- --------------------------------------------------
Susan Strong         Family Medical Center                    912-760-7840   fammed@onlineservice.com                          
Susan Watson         NONE ON RECORD                           801-746-7701   mswatson@fast.com                                 
Tammi Baldocchio     NONE ON RECORD                           401-989-4975   NONE ON RECORD                                    
Ted Zissa            NONE ON RECORD                           405-151-7445   NONE ON RECORD                                    
Terry Xu             NONE ON RECORD                           417-546-2570   muffin@fast.com                                   
Thomas Wolfe         NONE ON RECORD                           610-365-9766   wolf@onlineservice.com                            
Thomas Zelenka       NONE ON RECORD                           603-374-3706   zelenka@free.com                                  
Thurman Mezzo        Playing Around                           415-967-1415   tmezzo@playingaround.com                          
Tim Carlton          NONE ON RECORD                           203-608-3465   NONE ON RECORD                                    
Tim Leffert          Trailor Rentals                          315-486-4777   trailrent@zeronet.net                             
Tim Parker           NONE ON RECORD                           315-985-4102   jeckle@onlineservice.com                          

NAME                 COMPANYNAME                              TELEPHONE      EMAILADDRESS                                      
-------------------- ---------------------------------------- -------------- --------------------------------------------------
Tim White            Network Niche                            517-777-1905   twhite@networkN.com                               
Timothy Neal         Computer Accessories                     704-736-9458   tneal@compAccess.com                              
Tina Yates           Eagle Electronic                         929-763-4438   tyates@eagle.com                                  
Todd Vigus           Eagle Electronic                         919-486-7143   tvigus@eagle.com                                  
Tom Baker            NONE ON RECORD                           414-778-5640   bologna@free.com                                  
Tom Irelan           NONE ON RECORD                           240-634-5581   tucker@free.com                                   
Tom Moore            NONE ON RECORD                           270-692-2845   seedle@fast.com                                   
Tommy McFerren       Cole Sales and Associates                503-767-7054   mcferren@cole.com                                 
Tonya Owens          NONE ON RECORD                           843-773-2751   NONE ON RECORD                                    
Tracy Cicholski      Dixon Pharmacy                           601-959-1315   dixpharm@free.com                                 
Travis Camargo       NONE ON RECORD                           816-746-4913   NONE ON RECORD                                    

NAME                 COMPANYNAME                              TELEPHONE      EMAILADDRESS                                      
-------------------- ---------------------------------------- -------------- --------------------------------------------------
Travis Honn          Radiant Computers                        303-564-1515   thonn@radiant.com                                 
Trevor Snuffer       NONE ON RECORD                           336-185-0630   snuffer@zeronet.net                               
Trudi Antonio        NONE ON RECORD                           718-747-3259   toni@onlineservice.com                            
Verna McGrew         NONE ON RECORD                           334-547-9329   verngrew@free.com                                 
Wade Holle           Just Link It                             887-746-6174   Wade@jLi.com                                      
Wade Jacobs          Conner National                          803-477-5347   connernat@usol.com                                
William Newlon       Creative Computer Solutions              909-452-4936   Wnewlon@ccs.com                                   
Yauleng Depoe        Scanning the World                       313-475-1177   ydepoe@sw.com                                     
Zach McGrew          NONE ON RECORD                           520-730-8494   NONE ON RECORD                                    
Zack Hill            NONE ON RECORD                           503-794-2322   boogie@free.com                                   
Adam Cyr             Cables Anywhere                          315-474-5634   acyr@cablesany.com                                

NAME                 COMPANYNAME                              TELEPHONE      EMAILADDRESS                                      
-------------------- ---------------------------------------- -------------- --------------------------------------------------
Alice Mynhier        Magic Components                         303-696-0557   almyn@Nway.magcomp.com                            
Allen Robles         Copy Center                              644-730-8090   copy@onlineservice.com                            
Allison Roland       Eagle Electronic                         929-498-4174   NONE ON RECORD                                    
Allison Roland       NONE ON RECORD                           929-498-4174   alley@onlineservice.com                           
Amy Heide            Outlets                                  802-894-1024   letout@usol.com                                   
Andrea Griswold      NONE ON RECORD                           970-746-0995   andygwold@usol.com                                
Andrea Montgomery    NONE ON RECORD                           349-397-7772   NONE ON RECORD                                    
Andrew Ray           NONE ON RECORD                           609-345-9680   andyray@usol.com                                  
Andrew Smith         NONE ON RECORD                           709-307-2568   smokey@zeronet.net                                
Andrew Yelnick       NONE ON RECORD                           517-803-5818   family@free.com                                   
Andy Huegel          NONE ON RECORD                           302-620-1366   NONE ON RECORD                                    

NAME                 COMPANYNAME                              TELEPHONE      EMAILADDRESS                                      
-------------------- ---------------------------------------- -------------- --------------------------------------------------
Angela Wainscott     NONE ON RECORD                           208-788-4112   awainscott@free.com                               
Angie Hoover         Goodwork Corporation                     307-459-4165   ahoover@free.com                                  
Anita Pastron        Industrail Contracting Co                901-796-4654   contracts@fast.com                                
Anna Mayton          NONE ON RECORD                           888-451-1233   doctor@free.com                                   
Anne Hatzell         NONE ON RECORD                           302-651-6440   hazel@zeronet.net                                 
Ansel Farrell        NONE ON RECORD                           712-440-3934   prickly@onlineservice.com                         
Archie Doremski      Greenpart Steet Metal                    307-944-8959   sheetz@free.com                                   
Aricka Bross         Apartment Referrals                      419-676-9758   placetolive@free.com                              
Austin Ortman        Eagle Electronic                         919-774-9999   NONE ON RECORD                                    
Beth Zobitz          Eagle Electronic                         919-747-8404   bzobitz@eagle.com                                 
Bill Umbarger        NONE ON RECORD                           207-155-1577   cheezy@onlineservice.com                          

NAME                 COMPANYNAME                              TELEPHONE      EMAILADDRESS                                      
-------------------- ---------------------------------------- -------------- --------------------------------------------------
Bob Weldy            NONE ON RECORD                           571-490-6449   sucker42@usol.com                                 
Brad Arquette        NONE ON RECORD                           775-914-4294   arq@usol.com                                      
Brenda Jones         NONE ON RECORD                           720-800-2638   show@free.com                                     
Brenda Kitchel       Cheesman Corporation                     804-214-8732   cheesman@zeronet.net                              
Brenda Pritchett     Wizard Electronics                       302-696-1000   bpritchett@wizelec.com                            
Bridgette Kyger      Sampson Home Mortgages                   301-467-6480   homeloans@fast.com                                
Brittany Cottingham  Cottingham Plastics                      419-464-5273   plastic@onlineservice.com                         
Bruce Fogarty        Photography Niche                        598-791-1420   photoniche@usol.com                               
Bryan Price          NONE ON RECORD                           804-674-9666   NONE ON RECORD                                    
Calie Zollman        Eagle Electronic                         929-763-2047   NONE ON RECORD                                    
Carey Dailey         NONE ON RECORD                           728-896-2767   shelty@usol.com                                   

NAME                 COMPANYNAME                              TELEPHONE      EMAILADDRESS                                      
-------------------- ---------------------------------------- -------------- --------------------------------------------------
Carl Dallas          Water Analysts                           864-541-5114   analyzeh20@fast.com                               
Carl Hague           NONE ON RECORD                           419-890-3531   NONE ON RECORD                                    
Carrie Buchko        NONE ON RECORD                           817-739-1335   goobert@free.com                                  
Cathy Bending        R and R Air                              765-617-2811   rrair@zeronet.net                                 
Cathy Harvey         The Employment Agency                    336-477-0249   findwork@onlineservice.com                        
Cecil Scheetz        Tippe Inn                                207-679-9822   cecil@free.com                                    
Charlene Franks      Rydell High School                       307-892-2938   learn@rydell.edu                                  
Charles Jones        Eagle Electronic                         919-774-5552   cjones@eagle.com                                  
Charles Jones        NONE ON RECORD                           919-774-5552   charlie@usol.com                                  
Chas Funk            NONE ON RECORD                           860-498-3900   duck@usol.com                                     
Chris Dunlap         NONE ON RECORD                           307-473-2281   NONE ON RECORD                                    

NAME                 COMPANYNAME                              TELEPHONE      EMAILADDRESS                                      
-------------------- ---------------------------------------- -------------- --------------------------------------------------
Christina Wilson     NONE ON RECORD                           316-210-8989   NONE ON RECORD                                    
Dan Lageveen         NONE ON RECORD                           307-344-8928   veenie@zeronet.net                                
Daniel Barton        NONE ON RECORD                           915-894-8034   dannie@zeronet.net                                
Daniel Ezra          Pools For You                            207-744-1997   swim@zeronet.net                                  
Daniel Hundnall      Bobs Repair Service                      918-830-9731   fixit@usol.com                                    
Daniel Rodkey        NONE ON RECORD                           719-748-3205   dannie@free.com                                   
Daniel Stabnik       NONE ON RECORD                           636-746-4124   NONE ON RECORD                                    
Danita Sharp         NONE ON RECORD                           360-650-5604   girlfriend@fast.com                               
Darlene Jenkins      Optical Images                           678-490-5461   DarJen@Germ.opticimag.com                         
David Becker         Load It Up                               843-646-4187   BeckerDavid@Loadiu.com                            
David Chang          NONE ON RECORD                           740-750-1272   lion@free.com                                     

NAME                 COMPANYNAME                              TELEPHONE      EMAILADDRESS                                      
-------------------- ---------------------------------------- -------------- --------------------------------------------------
David Deppe          Eagle Electronic                         919-747-5155   NONE ON RECORD                                    
David Keck           Eagle Electronic                         919-747-9921   NONE ON RECORD                                    
David Schilling      NONE ON RECORD                           502-421-1516   NONE ON RECORD                                    
David Smith          NONE ON RECORD                           309-980-4350   emerald@onlineservice.com                         
David Tarter         Realty Specialties                       518-500-0570   estate@fast.com                                   
David Tietz          NONE ON RECORD                           651-912-1583   tietz@free.com                                    
Dean Eagon           NONE ON RECORD                           970-581-8611   NONE ON RECORD                                    
Dean Katpally        Phone Corporation                        808-799-3727   phonecorp@usol.com                                
Debra Cruz           Computer Fundamentals                    812-547-7359   Debra@Francomp.com                                
Dennis Drazer        Financial Planning Consul                253-315-4247   dollarplan@usol.com                               
Dennis Eberle        NONE ON RECORD                           515-708-1802   deber@free.com                                    

NAME                 COMPANYNAME                              TELEPHONE      EMAILADDRESS                                      
-------------------- ---------------------------------------- -------------- --------------------------------------------------
Dennis Mundy         NONE ON RECORD                           603-306-0774   rino@usol.com                                     
Dennis Sammons       Gards Auto Repair                        616-544-1969   repairit@free.com                                 
Don Kaleta           NONE ON RECORD                           724-695-2157   stud@zeronet.net                                  
Don Torres           Down Deep Drilling Inc.                  706-649-6375   drill@usol.com                                    
Donald Blythe        Make Some Noise Inc.                     520-486-6025   Dblythe@makenoise.com                             
Dorlan Bresnaham     NONE ON RECORD                           603-497-7374   dorlan@usol.com                                   
Dorthy Beering       Actual  Computers                        213-465-4900   dbeering@actual.com                               
Doug Blizzard        Collectibles Inc.                        228-646-5114   collectit@onlineservice.com                       
Dusty Jones          Railroad Express                         674-727-0511   rr@usol.com                                       
Edna Lilley          Eagle Electronic                         929-498-2840   elilley@eagle.com                                 
Elizabeth Clark      Luxury Laptops                           646-846-6232   eclark.com                                        

NAME                 COMPANYNAME                              TELEPHONE      EMAILADDRESS                                      
-------------------- ---------------------------------------- -------------- --------------------------------------------------
Elizabeth Derhammer  NONE ON RECORD                           785-970-9916   lizzy@onlineservice.com                           
Elizabeth Henderson  NONE ON RECORD                           449-486-8018   NONE ON RECORD                                    
Eric Becker          NONE ON RECORD                           910-717-7613   daddyo@usol.com                                   
Eric Fannon          NONE ON RECORD                           209-980-0812   ef@free.com                                       
Eric Quintero        NONE ON RECORD                           812-805-1588   diamond@onlineservice.com                         
Eugene Gasper        Regency Hospital                         705-580-6124   medcare@fast.com                                  
Evelyn Cassens       Vets Inc.                                302-762-9526   dr.animal@onlineservice.com                       
Frank Aamodt         Franklin Trinkets                        898-762-8741   fa@fast.com                                       
Frank Malady         NONE ON RECORD                           574-493-0510   frankmala@zeronet.net                             
Gabrielle Stevenson  Eagle Electronic                         929-763-4873   gstevenson@eagle.com                              
Gary German          Eagle Electronic                         919-774-3325   ggerman@eagle.com                                 

NAME                 COMPANYNAME                              TELEPHONE      EMAILADDRESS                                      
-------------------- ---------------------------------------- -------------- --------------------------------------------------
Gary Kempf           NONE ON RECORD                           937-724-7313   kempfg@free.com                                   
Gary Mikels          Networking Alliance                      505-660-9632   GaryMikels@Swiss.Alliance.com                     
Geo Schofield        Cleaning Supply                          228-480-9751   cleanit@usol.com                                  
George Purcell       BMA Advertising Design                   432-320-6905   design@zeronet.net                                
George Trenkle       NONE ON RECORD                           856-267-7913   cold@fast.com                                     
Gerald Campbell      NONE ON RECORD                           431-087-1044   gcampbell@free.com                                
Ginger Xiao          Bryant Accounting                        605-846-0451   acctsbryant@zeronet.net                           
Gordon Mayes         Modem Magicians                          207-634-1969   Gordon@den.modmagic.com                           
Gregory Abbott       Baker and Company                        812-447-3621   greggie@usol.com                                  
Gregory Hettinger    Eagle Electronic                         929-498-7144   NONE ON RECORD                                    
Heather Wallpe       Reflexions Manufacturing                 816-433-9799   flex@onlineservice.com                            

NAME                 COMPANYNAME                              TELEPHONE      EMAILADDRESS                                      
-------------------- ---------------------------------------- -------------- --------------------------------------------------
Heather Waters       Happytime Escort Service                 869-741-7817   dates@free.com                                    
Helene Ziekart       NONE ON RECORD                           203-244-9192   NONE ON RECORD                                    
Hugo Gillespie       Wadake Critters                          785-981-0669   critters@free.com                                 
Irene Poczekay       NONE ON RECORD                           401-461-9567   NONE ON RECORD                                    
Jack Akers           NONE ON RECORD                           301-454-6061   pizazz@usol.com                                   
Jack Barrick         First National Bank                      786-494-4782   1natbank@free.com                                 
Jack Brose           Eagle Electronic                         919-486-5104   NONE ON RECORD                                    
Jack Illingworth     NONE ON RECORD                           914-748-9829   illing@free.com                                   
Jacob Richer         NONE ON RECORD                           425-942-3763   laugh@free.com                                    
James Gross          NONE ON RECORD                           908-879-8672   jgross@fast.com                                   
James Jones          NONE ON RECORD                           971-522-5851   puffy@fast.com                                    

NAME                 COMPANYNAME                              TELEPHONE      EMAILADDRESS                                      
-------------------- ---------------------------------------- -------------- --------------------------------------------------
James King           NONE ON RECORD                           207-708-3317   jamesk@usol.com                                   
James Laake          NONE ON RECORD                           613-785-7063   NONE ON RECORD                                    
James Schilling      NONE ON RECORD                           319-429-9772   NONE ON RECORD                                    

300 rows selected. 


NAME                 COMPANYNAME                              TELEPHONE      EMAILADDRESS                                      
-------------------- ---------------------------------------- -------------- --------------------------------------------------
Jamie Osman          Eagle Electronic                         919-486-2519   josman@eagle.com                                  
Jamie Pickett        Miracle Machines                         937-147-2569   jpickett@machinemiracle.com                       
Jamie Thompson       NONE ON RECORD                           706-471-1222   jthompson@onlineservice.com                       
Jane Mumford         NONE ON RECORD                           270-428-5866   NONE ON RECORD                                    
Jared Meers          South Street Rehabilitation              701-371-1701   rehabsouth@zeronet.net                            
Jason Krasner        Eagle Electronic                         919-774-7920   NONE ON RECORD                                    
Jason Laxton         NONE ON RECORD                           978-860-2824   coondog@usol.com                                  
Jason Wendling       Eagle Electronic                         919-774-6798   jwendling@eagle.com                               
Jay Hanau            NONE ON RECORD                           773-490-8254   NONE ON RECORD                                    
Jeff Kowaiski        Quality Equipment Corp.                  212-492-5644   equipit@usol.com                                  
Jeffery Jordan       NONE ON RECORD                           509-989-9996   seeya@usol.com                                    

NAME                 COMPANYNAME                              TELEPHONE      EMAILADDRESS                                      
-------------------- ---------------------------------------- -------------- --------------------------------------------------
Jennie Fry           Pick Your Parts                          806-456-6285   Jfry@yourparts.com                                
Jennifer Hundley     NONE ON RECORD                           304-713-3298   jenhund@fast.com                                  
Jennifer Kmec        Kelly Dance Studio                       443-542-1386   dancingk@free.com                                 
Jerry Mennen         NONE ON RECORD                           520-306-8426   mennenj@free.com                                  
Jerry Muench         NONE ON RECORD                           464-669-8537   redhot@onlineservice.com                          
Jessica Cain         NONE ON RECORD                           517-901-2610   NONE ON RECORD                                    
Jessica Nakamura     Automart                                 605-324-2193   carsell@usol.com                                  
Jim Lichty           Bankruptcy Help                          618-847-1904   bankrupt@usol.com                                 
Jim Manaugh          Eagle Electronic                         919-747-5603   jmanaugh@eagle.com                                
Jim Manaugh          NONE ON RECORD                           919-747-5603   jmanaugh@eagle.com                                
Jim Sokeland         Powerful Employment                      723-366-1117   employment@zeronet.net                            

NAME                 COMPANYNAME                              TELEPHONE      EMAILADDRESS                                      
-------------------- ---------------------------------------- -------------- --------------------------------------------------
Jim Webb             NONE ON RECORD                           978-204-3019   NONE ON RECORD                                    
Jo Jacko             NONE ON RECORD                           856-752-7471   NONE ON RECORD                                    
Joan Hedden          NONE ON RECORD                           501-710-0658   NONE ON RECORD                                    
Joanne Rosner        Eagle Electronic                         919-486-2822   NONE ON RECORD                                    
John Garcia          NONE ON RECORD                           207-311-0174   jgar@onlineservice.com                            
John McGinnis        NONE ON RECORD                           208-741-1963   john@zeronet.net                                  
John Skadberg        NONE ON RECORD                           513-282-3919   skad@zeronet.net                                  
Jon Clute            NONE ON RECORD                           480-181-8940   NONE ON RECORD                                    
Jonathon Blanco      NONE ON RECORD                           902-226-1858   hammer@free.com                                   
Joseph Platt         Eagle Electronic                         929-763-5228   NONE ON RECORD                                    
Joseph Schuman       NONE ON RECORD                           330-209-1273   NONE ON RECORD                                    

NAME                 COMPANYNAME                              TELEPHONE      EMAILADDRESS                                      
-------------------- ---------------------------------------- -------------- --------------------------------------------------
Joshua Cole          NONE ON RECORD                           865-269-7782   fido@zeronet.net                                  
Juicheng Nugent      NONE ON RECORD                           802-352-8923   nugent@fast.com                                   
Kara Orze            Appliances Inc.                          414-773-1017   appinc@zeronet.net                                
Karen Burns          Recreation Supply                        707-598-2670   burnskaren@fast.com                               
Karen Mangus         NONE ON RECORD                           863-623-0459   missright@onlineservice.com                       
Karen Marko          NONE ON RECORD                           580-555-1871   marko@usol.com                                    
Karen Randolph       NONE ON RECORD                           603-744-9002   cookin@zeronet.net                                
Kathleen Plyman      Needle Center                            507-543-2052   needles@onlineservice.com                         
Kathleen Xolo        Eagle Electronic                         929-763-5513   kxolo@eagle.com                                   
Kathryn Deagen       Eagle Electronic                         919-747-9164   NONE ON RECORD                                    
Kathy Gunderson      NONE ON RECORD                           941-330-3314   NONE ON RECORD                                    

NAME                 COMPANYNAME                              TELEPHONE      EMAILADDRESS                                      
-------------------- ---------------------------------------- -------------- --------------------------------------------------
Kelli Jones          Dot Com Incorporated                     912-647-0391   kjoneskelli@DCI.com                               
Kelly Jordan         Supplying Crafts                         727-951-7737   supplycrafts@fast.com                             
Kenneth Mintier      NONE ON RECORD                           323-673-0690   builder@usol.com                                  
Kenneth Wilcox       NONE ON RECORD                           515-872-8848   kenny@onlineservice.com                           
Kevin Jackson        NONE ON RECORD                           225-624-2341   NONE ON RECORD                                    
Kevin Martin         Easy Accessories                         606-677-9789   kmartin@easyaccess.com                            
Kevin Zubarev        Signs Signs Signs                        208-364-3785   sign3@fast.com                                    
Kimber Spaller       NONE ON RECORD                           878-119-5448   mcgimmie@zero.net                                 
Kris Shinn           NONE ON RECORD                           469-740-2748   shinnk@zeronet.net                                
Kristen Gustavel     Eagle Electronic                         919-747-1530   kgustavel@eagle.com                               
Kristey Moore        Eagle Electronic                         919-486-6765   NONE ON RECORD                                    

NAME                 COMPANYNAME                              TELEPHONE      EMAILADDRESS                                      
-------------------- ---------------------------------------- -------------- --------------------------------------------------
Kristy Moore         NONE ON RECORD                           919-486-6765   fluffy@onlineservice.com                          
Lance Andrews        Monitors for You                         972-534-7322   LanceA@braz.monitorU.com                          
Larry Gardiner       NONE ON RECORD                           225-313-6268   square@onlineserveice.com                         
Larry Osmanova       City Bus Transport                       541-905-4819   citybus@fast.com                                  
Laura Rodgers        Eagle Electronic                         929-763-0691   NONE ON RECORD                                    
Lawrence Pullen      NONE ON RECORD                           644-591-3243   laurie@free.com                                   
Linda Bowen          NONE ON RECORD                           605-234-4114   NONE ON RECORD                                    
Linda Hari           NONE ON RECORD                           270-411-2316   NONE ON RECORD                                    
Linda Li             NONE ON RECORD                           203-744-4677   ll@free.com                                       
Lisa Pettry          NONE ON RECORD                           702-799-7272   lpett@zeronet.net                                 
Loraine Platt        Greatest Components                      520-475-5322   LoraineP@ComponGerm.com                           

NAME                 COMPANYNAME                              TELEPHONE      EMAILADDRESS                                      
-------------------- ---------------------------------------- -------------- --------------------------------------------------
Lou Caldwell         NONE ON RECORD                           606-901-1238   lucky@fast.com                                    
Louise Cool          NONE ON RECORD                           208-956-0698   NONE ON RECORD                                    
Lucille Appleton     NONE ON RECORD                           914-497-2160   muscle@zeronet.net                                
Lynne Lagunes        NONE ON RECORD                           208-502-9976   hello@zeronet.net                                 
Marc Williams        NONE ON RECORD                           435-774-4595   peanut@fast.com                                   
Marjorie Vandermay   National Art Museum                      308-489-1137   nam@fast com                                      
Marla Reeder         NONE ON RECORD                           728-442-3031   reedmar@zeronet.net                               
Marty Fay            NONE ON RECORD                           501-631-3727   sparky@free.com                                   
Mary Ann Rausch      NONE ON RECORD                           307-944-3324   spiritual@free.com                                
Mary Deets           Camping Supplies                         808-562-4081   camphere@fast.com                                 
Mary Jo Wales        NONE ON RECORD                           852-441-4984   jomary@onlineservice.com                          

NAME                 COMPANYNAME                              TELEPHONE      EMAILADDRESS                                      
-------------------- ---------------------------------------- -------------- --------------------------------------------------
Mary Uhl             Flowers by Mickey                        803-974-2809   mouse@fast.com                                    
Matt Nakanishi       NONE ON RECORD                           435-710-5324   nakan@free.com                                    
Matt Shade           NONE ON RECORD                           623-422-6616   shadtree@free.com                                 
Matt Smith           NONE ON RECORD                           719-822-8828   matsm@fast.com                                    
Matthew Quant        NONE ON RECORD                           910-577-1319   walker@onlineservice.com                          
Meghan Tyrie         Eagle Electronic                         919-747-8589   mtyrie@eagle.com                                  
Melissa Alvarez      Eagle Electronic                         919-747-3781   NONE ON RECORD                                    
Melody Fazal         NONE ON RECORD                           760-877-4849   melfazal@zeronet.net                              
Meredith Rushing     NONE ON RECORD                           606-608-2105   merry@free.com                                    
Michael Abbott       Eagle Electronic                         919-774-2720   mabbott@eagle.com                                 
Michael Emore        NONE ON RECORD                           352-472-1224   mikemore@usol.com                                 

NAME                 COMPANYNAME                              TELEPHONE      EMAILADDRESS                                      
-------------------- ---------------------------------------- -------------- --------------------------------------------------
Michael Tendam       NONE ON RECORD                           406-424-7496   flute@usol.com                                    
Michelle Nairn       Eagle Electronic                         919-486-6919   NONE ON RECORD                                    
Michelle Oakley      NONE ON RECORD                           978-514-5425   littleone@usol.com                                
Mike Condie          Kids Recreation Inc.                     336-211-1238   kidrec@zeronet.net                                
Mike Dunbar          NONE ON RECORD                           208-297-5374   duh@onlineservice.com                             
Mildred Jones        Computer Consultants                     610-437-6687   compconsul@usol.com                               
Nancy Basham         NONE ON RECORD                           207-422-7135   NONE ON RECORD                                    
Nicholas Albregts    Eagle Electronic                         929-763-4843   NONE ON RECORD                                    
Noemi Elston         North Street Church                      307-359-9514   closetoheaven@zeronet.net                         
Norman Fields        The Cable Company                        501-346-4841   catv@onlineservice.com                            
Orville Gilliland    Easy Internet Access                     490-263-2957   eia@zeronet.net                                   

NAME                 COMPANYNAME                              TELEPHONE      EMAILADDRESS                                      
-------------------- ---------------------------------------- -------------- --------------------------------------------------
Pam Krick            Printing Associated                      860-624-2539   pkrick@Passoc.com                                 
Patricha Underwood   Eagle Electronic                         929-498-1956   NONE ON RECORD                                    
Patricia Leong       NONE ON RECORD                           520-247-4141   patrice@usol.com                                  
Patrick Bollock      NONE ON RECORD                           307-635-1692   pat@fast.com                                      
Paul Eckelman        Eagle Electronic                         919-486-6410   peckelman@eagle.com                               
Paul Kaakeh          Laser Graphics Associates                719-750-4539   graphit@usol.com                                  
Paul Rice            NONE ON RECORD                           719-541-1837   paulier@onlineservice.com                         
Paul Smith           Computer Video                           219-703-2277   psmith@computervideo.comq                         
Paul Sullivan        NONE ON RECORD                           785-322-5896   sullie@zeronet.net                                
Peter Austin         NONE ON RECORD                           803-343-6063   NONE ON RECORD                                    
Phil Reece           Eagle Electronic                         919-486-0649   NONE ON RECORD                                    

NAME                 COMPANYNAME                              TELEPHONE      EMAILADDRESS                                      
-------------------- ---------------------------------------- -------------- --------------------------------------------------
Phil Reece           NONE ON RECORD                           919-486-0649   sly@zeronet.net                                   
Phillip Hession      NONE ON RECORD                           231-711-6837   howdy@usol.com                                    
Rachel Davis         NONE ON RECORD                           702-907-4818   rachdav@zeronet.net                               
Randall Neely        Store It Here                            802-319-9805   storage@fast.com                                  
Randolph Darling     NONE ON RECORD                           860-684-1620   randolph@fast.com                                 
Randy Talauage       Ceramic Supply                           347-671-2022   paintit@fast.com                                  
Richard Kluth        Main St. Bar and Grill                   302-296-8012   rickkluth@free.com                                
Richard Scott        Karate Made Easy                         304-774-2226   kick@onlineservice.com                            
Richard Stetler      NONE ON RECORD                           256-412-8112   screwball@free.com                                
Richard Strehle      Vacation Car Rentals                     206-434-7305   vacation@fast.com                                 
Richard Zito         NONE ON RECORD                           603-787-0787   rzito@zeronet.net                                 

NAME                 COMPANYNAME                              TELEPHONE      EMAILADDRESS                                      
-------------------- ---------------------------------------- -------------- --------------------------------------------------
Rita Bush            Eagle Electronic                         919-747-4397   rbush@eagle.com                                   
Rob Thomas           Accessories and More                     484-374-1998   rthomas@bestchoice.com                            
Robert Cortez        NONE ON RECORD                           603-442-3740   NONE ON RECORD                                    
Robert Dalury        TAS                                      906-278-6446   tas@zeronet.net                                   
Robert Lister        Fire Alarm Systems                       801-404-1240   fines@free.com                                    
Ronald Day           Eagle Electronic                         929-763-6488   NONE ON RECORD                                    
Ronald Miller        NONE ON RECORD                           734-820-2076   picky@zeronet.net                                 
Rosemary Vanderhoff  NONE ON RECORD                           770-293-8783   NONE ON RECORD                                    
Roy Beer             NONE ON RECORD                           206-745-2584   wizzy@usol.com                                    
Roy McGrew           NONE ON RECORD                           208-324-0783   grow@zeronet.net                                  
Russ Mann            NONE ON RECORD                           775-549-1798   scooter@onlineservice.com                         

NAME                 COMPANYNAME                              TELEPHONE      EMAILADDRESS                                      
-------------------- ---------------------------------------- -------------- --------------------------------------------------
Ruth Albeering       NONE ON RECORD                           784-444-0131   rabeering@free.com                                
Ruth Ball            NONE ON RECORD                           651-479-7538   NONE ON RECORD                                    
Ryan Stahley         Eagle Electronic                         919-774-5340   rstahley@eagle.com                                
Ryan Stahley         NONE ON RECORD                           919-774-5340   rstahley@eagle.com                                
Sally Valle          Investment Specialties                   972-234-2044   roi@usol.com                                      
Sandy Goodman        Connexions                               208-614-3136   Sgoodman@connex.com                               
Sarah McCammon       NONE ON RECORD                           520-438-7944   squirrel@zeronet.net                              
Scott Gray           Security Installation                    484-453-7105   keepsafe@zeronet.net                              
Scott Yarian         NONE ON RECORD                           252-310-2224   syarian@fast.com                                  
Sean Akropolis       NONE ON RECORD                           907-262-4254   pickle@free.com                                   
Sharon Rouls         Sharons Shamrock                         205-246-3224   irish@free.com                                    

NAME                 COMPANYNAME                              TELEPHONE      EMAILADDRESS                                      
-------------------- ---------------------------------------- -------------- --------------------------------------------------
Sherman Cheswick     Eagle Electronic                         929-498-8150   scheswick@eagle.com                               
Sherry Garling       Manufactured Homes Corp.                 353-822-7623   homely@fast.com                                   
Shirley Osborne      NONE ON RECORD                           706-333-7174   NONE ON RECORD                                    
Stephanie Pearl      NONE ON RECORD                           660-447-8319   mommyl@fast.com                                   
Stephanie Yeinick    Tuckers Jewels                           573-455-4278   jewels@usol.com                                   
Stephen Bird         Storage Specialties                      540-514-1415   sbird@storeit.com                                 
Steve Cochran        Eagle Electronic                         929-763-1283   NONE ON RECORD                                    
Steve Fulkerson      Cellular Services                        602-129-1885   cellcall@usol.com                                 
Steve Hess           Eagle Electronic                         919-486-8804   NONE ON RECORD                                    
Steven Hickman       Eagle Electronic                         919-774-4874   shickman@eagle.com                                
Steven Yaun          NONE ON RECORD                           317-780-9804   yawn@fast.com                                     

NAME                 COMPANYNAME                              TELEPHONE      EMAILADDRESS                                      
-------------------- ---------------------------------------- -------------- --------------------------------------------------
Susan Strong         Family Medical Center                    912-760-7840   fammed@onlineservice.com                          
Susan Watson         NONE ON RECORD                           801-746-7701   mswatson@fast.com                                 
Tammi Baldocchio     NONE ON RECORD                           401-989-4975   NONE ON RECORD                                    
Ted Zissa            NONE ON RECORD                           405-151-7445   NONE ON RECORD                                    
Terry Xu             NONE ON RECORD                           417-546-2570   muffin@fast.com                                   
Thomas Wolfe         NONE ON RECORD                           610-365-9766   wolf@onlineservice.com                            
Thomas Zelenka       NONE ON RECORD                           603-374-3706   zelenka@free.com                                  
Thurman Mezzo        Playing Around                           415-967-1415   tmezzo@playingaround.com                          
Tim Carlton          NONE ON RECORD                           203-608-3465   NONE ON RECORD                                    
Tim Leffert          Trailor Rentals                          315-486-4777   trailrent@zeronet.net                             
Tim Parker           NONE ON RECORD                           315-985-4102   jeckle@onlineservice.com                          

NAME                 COMPANYNAME                              TELEPHONE      EMAILADDRESS                                      
-------------------- ---------------------------------------- -------------- --------------------------------------------------
Tim White            Network Niche                            517-777-1905   twhite@networkN.com                               
Timothy Neal         Computer Accessories                     704-736-9458   tneal@compAccess.com                              
Tina Yates           Eagle Electronic                         929-763-4438   tyates@eagle.com                                  
Todd Vigus           Eagle Electronic                         919-486-7143   tvigus@eagle.com                                  
Tom Baker            NONE ON RECORD                           414-778-5640   bologna@free.com                                  
Tom Irelan           NONE ON RECORD                           240-634-5581   tucker@free.com                                   
Tom Moore            NONE ON RECORD                           270-692-2845   seedle@fast.com                                   
Tommy McFerren       Cole Sales and Associates                503-767-7054   mcferren@cole.com                                 
Tonya Owens          NONE ON RECORD                           843-773-2751   NONE ON RECORD                                    
Tracy Cicholski      Dixon Pharmacy                           601-959-1315   dixpharm@free.com                                 
Travis Camargo       NONE ON RECORD                           816-746-4913   NONE ON RECORD                                    

NAME                 COMPANYNAME                              TELEPHONE      EMAILADDRESS                                      
-------------------- ---------------------------------------- -------------- --------------------------------------------------
Travis Honn          Radiant Computers                        303-564-1515   thonn@radiant.com                                 
Trevor Snuffer       NONE ON RECORD                           336-185-0630   snuffer@zeronet.net                               
Trudi Antonio        NONE ON RECORD                           718-747-3259   toni@onlineservice.com                            
Verna McGrew         NONE ON RECORD                           334-547-9329   verngrew@free.com                                 
Wade Holle           Just Link It                             887-746-6174   Wade@jLi.com                                      
Wade Jacobs          Conner National                          803-477-5347   connernat@usol.com                                
William Newlon       Creative Computer Solutions              909-452-4936   Wnewlon@ccs.com                                   
Yauleng Depoe        Scanning the World                       313-475-1177   ydepoe@sw.com                                     
Zach McGrew          NONE ON RECORD                           520-730-8494   NONE ON RECORD                                    
Zack Hill            NONE ON RECORD                           503-794-2322   boogie@free.com                                   
Adam Cyr             Cables Anywhere                          315-474-5634   acyr@cablesany.com                                

NAME                 COMPANYNAME                              TELEPHONE      EMAILADDRESS                                      
-------------------- ---------------------------------------- -------------- --------------------------------------------------
Alice Mynhier        Magic Components                         303-696-0557   almyn@Nway.magcomp.com                            
Allen Robles         Copy Center                              644-730-8090   copy@onlineservice.com                            
Allison Roland       Eagle Electronic                         929-498-4174   NONE ON RECORD                                    
Allison Roland       NONE ON RECORD                           929-498-4174   alley@onlineservice.com                           
Amy Heide            Outlets                                  802-894-1024   letout@usol.com                                   
Andrea Griswold      NONE ON RECORD                           970-746-0995   andygwold@usol.com                                
Andrea Montgomery    NONE ON RECORD                           349-397-7772   NONE ON RECORD                                    
Andrew Ray           NONE ON RECORD                           609-345-9680   andyray@usol.com                                  
Andrew Smith         NONE ON RECORD                           709-307-2568   smokey@zeronet.net                                
Andrew Yelnick       NONE ON RECORD                           517-803-5818   family@free.com                                   
Andy Huegel          NONE ON RECORD                           302-620-1366   NONE ON RECORD                                    

NAME                 COMPANYNAME                              TELEPHONE      EMAILADDRESS                                      
-------------------- ---------------------------------------- -------------- --------------------------------------------------
Angela Wainscott     NONE ON RECORD                           208-788-4112   awainscott@free.com                               
Angie Hoover         Goodwork Corporation                     307-459-4165   ahoover@free.com                                  
Anita Pastron        Industrail Contracting Co                901-796-4654   contracts@fast.com                                
Anna Mayton          NONE ON RECORD                           888-451-1233   doctor@free.com                                   
Anne Hatzell         NONE ON RECORD                           302-651-6440   hazel@zeronet.net                                 
Ansel Farrell        NONE ON RECORD                           712-440-3934   prickly@onlineservice.com                         
Archie Doremski      Greenpart Steet Metal                    307-944-8959   sheetz@free.com                                   
Aricka Bross         Apartment Referrals                      419-676-9758   placetolive@free.com                              
Austin Ortman        Eagle Electronic                         919-774-9999   NONE ON RECORD                                    
Beth Zobitz          Eagle Electronic                         919-747-8404   bzobitz@eagle.com                                 
Bill Umbarger        NONE ON RECORD                           207-155-1577   cheezy@onlineservice.com                          

NAME                 COMPANYNAME                              TELEPHONE      EMAILADDRESS                                      
-------------------- ---------------------------------------- -------------- --------------------------------------------------
Bob Weldy            NONE ON RECORD                           571-490-6449   sucker42@usol.com                                 
Brad Arquette        NONE ON RECORD                           775-914-4294   arq@usol.com                                      
Brenda Jones         NONE ON RECORD                           720-800-2638   show@free.com                                     
Brenda Kitchel       Cheesman Corporation                     804-214-8732   cheesman@zeronet.net                              
Brenda Pritchett     Wizard Electronics                       302-696-1000   bpritchett@wizelec.com                            
Bridgette Kyger      Sampson Home Mortgages                   301-467-6480   homeloans@fast.com                                
Brittany Cottingham  Cottingham Plastics                      419-464-5273   plastic@onlineservice.com                         
Bruce Fogarty        Photography Niche                        598-791-1420   photoniche@usol.com                               
Bryan Price          NONE ON RECORD                           804-674-9666   NONE ON RECORD                                    
Calie Zollman        Eagle Electronic                         929-763-2047   NONE ON RECORD                                    
Carey Dailey         NONE ON RECORD                           728-896-2767   shelty@usol.com                                   

NAME                 COMPANYNAME                              TELEPHONE      EMAILADDRESS                                      
-------------------- ---------------------------------------- -------------- --------------------------------------------------
Carl Dallas          Water Analysts                           864-541-5114   analyzeh20@fast.com                               
Carl Hague           NONE ON RECORD                           419-890-3531   NONE ON RECORD                                    
Carrie Buchko        NONE ON RECORD                           817-739-1335   goobert@free.com                                  
Cathy Bending        R and R Air                              765-617-2811   rrair@zeronet.net                                 
Cathy Harvey         The Employment Agency                    336-477-0249   findwork@onlineservice.com                        
Cecil Scheetz        Tippe Inn                                207-679-9822   cecil@free.com                                    
Charlene Franks      Rydell High School                       307-892-2938   learn@rydell.edu                                  
Charles Jones        Eagle Electronic                         919-774-5552   cjones@eagle.com                                  
Charles Jones        NONE ON RECORD                           919-774-5552   charlie@usol.com                                  
Chas Funk            NONE ON RECORD                           860-498-3900   duck@usol.com                                     
Chris Dunlap         NONE ON RECORD                           307-473-2281   NONE ON RECORD                                    

NAME                 COMPANYNAME                              TELEPHONE      EMAILADDRESS                                      
-------------------- ---------------------------------------- -------------- --------------------------------------------------
Christina Wilson     NONE ON RECORD                           316-210-8989   NONE ON RECORD                                    
Dan Lageveen         NONE ON RECORD                           307-344-8928   veenie@zeronet.net                                
Daniel Barton        NONE ON RECORD                           915-894-8034   dannie@zeronet.net                                
Daniel Ezra          Pools For You                            207-744-1997   swim@zeronet.net                                  
Daniel Hundnall      Bobs Repair Service                      918-830-9731   fixit@usol.com                                    
Daniel Rodkey        NONE ON RECORD                           719-748-3205   dannie@free.com                                   
Daniel Stabnik       NONE ON RECORD                           636-746-4124   NONE ON RECORD                                    
Danita Sharp         NONE ON RECORD                           360-650-5604   girlfriend@fast.com                               
Darlene Jenkins      Optical Images                           678-490-5461   DarJen@Germ.opticimag.com                         
David Becker         Load It Up                               843-646-4187   BeckerDavid@Loadiu.com                            
David Chang          NONE ON RECORD                           740-750-1272   lion@free.com                                     

NAME                 COMPANYNAME                              TELEPHONE      EMAILADDRESS                                      
-------------------- ---------------------------------------- -------------- --------------------------------------------------
David Deppe          Eagle Electronic                         919-747-5155   NONE ON RECORD                                    
David Keck           Eagle Electronic                         919-747-9921   NONE ON RECORD                                    
David Schilling      NONE ON RECORD                           502-421-1516   NONE ON RECORD                                    
David Smith          NONE ON RECORD                           309-980-4350   emerald@onlineservice.com                         
David Tarter         Realty Specialties                       518-500-0570   estate@fast.com                                   
David Tietz          NONE ON RECORD                           651-912-1583   tietz@free.com                                    
Dean Eagon           NONE ON RECORD                           970-581-8611   NONE ON RECORD                                    
Dean Katpally        Phone Corporation                        808-799-3727   phonecorp@usol.com                                
Debra Cruz           Computer Fundamentals                    812-547-7359   Debra@Francomp.com                                
Dennis Drazer        Financial Planning Consul                253-315-4247   dollarplan@usol.com                               
Dennis Eberle        NONE ON RECORD                           515-708-1802   deber@free.com                                    

NAME                 COMPANYNAME                              TELEPHONE      EMAILADDRESS                                      
-------------------- ---------------------------------------- -------------- --------------------------------------------------
Dennis Mundy         NONE ON RECORD                           603-306-0774   rino@usol.com                                     
Dennis Sammons       Gards Auto Repair                        616-544-1969   repairit@free.com                                 
Don Kaleta           NONE ON RECORD                           724-695-2157   stud@zeronet.net                                  
Don Torres           Down Deep Drilling Inc.                  706-649-6375   drill@usol.com                                    
Donald Blythe        Make Some Noise Inc.                     520-486-6025   Dblythe@makenoise.com                             
Dorlan Bresnaham     NONE ON RECORD                           603-497-7374   dorlan@usol.com                                   
Dorthy Beering       Actual  Computers                        213-465-4900   dbeering@actual.com                               
Doug Blizzard        Collectibles Inc.                        228-646-5114   collectit@onlineservice.com                       
Dusty Jones          Railroad Express                         674-727-0511   rr@usol.com                                       
Edna Lilley          Eagle Electronic                         929-498-2840   elilley@eagle.com                                 
Elizabeth Clark      Luxury Laptops                           646-846-6232   eclark.com                                        

NAME                 COMPANYNAME                              TELEPHONE      EMAILADDRESS                                      
-------------------- ---------------------------------------- -------------- --------------------------------------------------
Elizabeth Derhammer  NONE ON RECORD                           785-970-9916   lizzy@onlineservice.com                           
Elizabeth Henderson  NONE ON RECORD                           449-486-8018   NONE ON RECORD                                    
Eric Becker          NONE ON RECORD                           910-717-7613   daddyo@usol.com                                   
Eric Fannon          NONE ON RECORD                           209-980-0812   ef@free.com                                       
Eric Quintero        NONE ON RECORD                           812-805-1588   diamond@onlineservice.com                         
Eugene Gasper        Regency Hospital                         705-580-6124   medcare@fast.com                                  
Evelyn Cassens       Vets Inc.                                302-762-9526   dr.animal@onlineservice.com                       
Frank Aamodt         Franklin Trinkets                        898-762-8741   fa@fast.com                                       
Frank Malady         NONE ON RECORD                           574-493-0510   frankmala@zeronet.net                             
Gabrielle Stevenson  Eagle Electronic                         929-763-4873   gstevenson@eagle.com                              
Gary German          Eagle Electronic                         919-774-3325   ggerman@eagle.com                                 

NAME                 COMPANYNAME                              TELEPHONE      EMAILADDRESS                                      
-------------------- ---------------------------------------- -------------- --------------------------------------------------
Gary Kempf           NONE ON RECORD                           937-724-7313   kempfg@free.com                                   
Gary Mikels          Networking Alliance                      505-660-9632   GaryMikels@Swiss.Alliance.com                     
Geo Schofield        Cleaning Supply                          228-480-9751   cleanit@usol.com                                  
George Purcell       BMA Advertising Design                   432-320-6905   design@zeronet.net                                
George Trenkle       NONE ON RECORD                           856-267-7913   cold@fast.com                                     
Gerald Campbell      NONE ON RECORD                           431-087-1044   gcampbell@free.com                                
Ginger Xiao          Bryant Accounting                        605-846-0451   acctsbryant@zeronet.net                           
Gordon Mayes         Modem Magicians                          207-634-1969   Gordon@den.modmagic.com                           
Gregory Abbott       Baker and Company                        812-447-3621   greggie@usol.com                                  
Gregory Hettinger    Eagle Electronic                         929-498-7144   NONE ON RECORD                                    
Heather Wallpe       Reflexions Manufacturing                 816-433-9799   flex@onlineservice.com                            

NAME                 COMPANYNAME                              TELEPHONE      EMAILADDRESS                                      
-------------------- ---------------------------------------- -------------- --------------------------------------------------
Heather Waters       Happytime Escort Service                 869-741-7817   dates@free.com                                    
Helene Ziekart       NONE ON RECORD                           203-244-9192   NONE ON RECORD                                    
Hugo Gillespie       Wadake Critters                          785-981-0669   critters@free.com                                 
Irene Poczekay       NONE ON RECORD                           401-461-9567   NONE ON RECORD                                    
Jack Akers           NONE ON RECORD                           301-454-6061   pizazz@usol.com                                   
Jack Barrick         First National Bank                      786-494-4782   1natbank@free.com                                 
Jack Brose           Eagle Electronic                         919-486-5104   NONE ON RECORD                                    
Jack Illingworth     NONE ON RECORD                           914-748-9829   illing@free.com                                   
Jacob Richer         NONE ON RECORD                           425-942-3763   laugh@free.com                                    
James Gross          NONE ON RECORD                           908-879-8672   jgross@fast.com                                   
James Jones          NONE ON RECORD                           971-522-5851   puffy@fast.com                                    

NAME                 COMPANYNAME                              TELEPHONE      EMAILADDRESS                                      
-------------------- ---------------------------------------- -------------- --------------------------------------------------
James King           NONE ON RECORD                           207-708-3317   jamesk@usol.com                                   
James Laake          NONE ON RECORD                           613-785-7063   NONE ON RECORD                                    
James Schilling      NONE ON RECORD                           319-429-9772   NONE ON RECORD                                    

300 rows selected. 

Question 5
157 rows deleted.


NAME                 COMPANYNAME                              TELEPHONE      EMAILADDRESS                                      
-------------------- ---------------------------------------- -------------- --------------------------------------------------
Jamie Osman          Eagle Electronic                         919-486-2519   josman@eagle.com                                  
Jamie Pickett        Miracle Machines                         937-147-2569   jpickett@machinemiracle.com                       
Jared Meers          South Street Rehabilitation              701-371-1701   rehabsouth@zeronet.net                            
Jason Krasner        Eagle Electronic                         919-774-7920   NONE ON RECORD                                    
Jason Wendling       Eagle Electronic                         919-774-6798   jwendling@eagle.com                               
Jeff Kowaiski        Quality Equipment Corp.                  212-492-5644   equipit@usol.com                                  
Jennie Fry           Pick Your Parts                          806-456-6285   Jfry@yourparts.com                                
Jennifer Kmec        Kelly Dance Studio                       443-542-1386   dancingk@free.com                                 
Jessica Nakamura     Automart                                 605-324-2193   carsell@usol.com                                  
Jim Lichty           Bankruptcy Help                          618-847-1904   bankrupt@usol.com                                 
Jim Manaugh          Eagle Electronic                         919-747-5603   jmanaugh@eagle.com                                

NAME                 COMPANYNAME                              TELEPHONE      EMAILADDRESS                                      
-------------------- ---------------------------------------- -------------- --------------------------------------------------
Jim Sokeland         Powerful Employment                      723-366-1117   employment@zeronet.net                            
Joanne Rosner        Eagle Electronic                         919-486-2822   NONE ON RECORD                                    
Joseph Platt         Eagle Electronic                         929-763-5228   NONE ON RECORD                                    
Kara Orze            Appliances Inc.                          414-773-1017   appinc@zeronet.net                                
Karen Burns          Recreation Supply                        707-598-2670   burnskaren@fast.com                               
Kathleen Plyman      Needle Center                            507-543-2052   needles@onlineservice.com                         
Kathleen Xolo        Eagle Electronic                         929-763-5513   kxolo@eagle.com                                   
Kathryn Deagen       Eagle Electronic                         919-747-9164   NONE ON RECORD                                    
Kelli Jones          Dot Com Incorporated                     912-647-0391   kjoneskelli@DCI.com                               
Kelly Jordan         Supplying Crafts                         727-951-7737   supplycrafts@fast.com                             
Kevin Martin         Easy Accessories                         606-677-9789   kmartin@easyaccess.com                            

NAME                 COMPANYNAME                              TELEPHONE      EMAILADDRESS                                      
-------------------- ---------------------------------------- -------------- --------------------------------------------------
Kevin Zubarev        Signs Signs Signs                        208-364-3785   sign3@fast.com                                    
Kristen Gustavel     Eagle Electronic                         919-747-1530   kgustavel@eagle.com                               
Kristey Moore        Eagle Electronic                         919-486-6765   NONE ON RECORD                                    
Lance Andrews        Monitors for You                         972-534-7322   LanceA@braz.monitorU.com                          
Larry Osmanova       City Bus Transport                       541-905-4819   citybus@fast.com                                  
Laura Rodgers        Eagle Electronic                         929-763-0691   NONE ON RECORD                                    
Loraine Platt        Greatest Components                      520-475-5322   LoraineP@ComponGerm.com                           
Marjorie Vandermay   National Art Museum                      308-489-1137   nam@fast com                                      
Mary Deets           Camping Supplies                         808-562-4081   camphere@fast.com                                 
Mary Uhl             Flowers by Mickey                        803-974-2809   mouse@fast.com                                    
Meghan Tyrie         Eagle Electronic                         919-747-8589   mtyrie@eagle.com                                  

NAME                 COMPANYNAME                              TELEPHONE      EMAILADDRESS                                      
-------------------- ---------------------------------------- -------------- --------------------------------------------------
Melissa Alvarez      Eagle Electronic                         919-747-3781   NONE ON RECORD                                    
Michael Abbott       Eagle Electronic                         919-774-2720   mabbott@eagle.com                                 
Michelle Nairn       Eagle Electronic                         919-486-6919   NONE ON RECORD                                    
Mike Condie          Kids Recreation Inc.                     336-211-1238   kidrec@zeronet.net                                
Mildred Jones        Computer Consultants                     610-437-6687   compconsul@usol.com                               
Nicholas Albregts    Eagle Electronic                         929-763-4843   NONE ON RECORD                                    
Noemi Elston         North Street Church                      307-359-9514   closetoheaven@zeronet.net                         
Norman Fields        The Cable Company                        501-346-4841   catv@onlineservice.com                            
Orville Gilliland    Easy Internet Access                     490-263-2957   eia@zeronet.net                                   
Pam Krick            Printing Associated                      860-624-2539   pkrick@Passoc.com                                 
Patricha Underwood   Eagle Electronic                         929-498-1956   NONE ON RECORD                                    

NAME                 COMPANYNAME                              TELEPHONE      EMAILADDRESS                                      
-------------------- ---------------------------------------- -------------- --------------------------------------------------
Paul Eckelman        Eagle Electronic                         919-486-6410   peckelman@eagle.com                               
Paul Kaakeh          Laser Graphics Associates                719-750-4539   graphit@usol.com                                  
Paul Smith           Computer Video                           219-703-2277   psmith@computervideo.comq                         
Phil Reece           Eagle Electronic                         919-486-0649   NONE ON RECORD                                    
Randall Neely        Store It Here                            802-319-9805   storage@fast.com                                  
Randy Talauage       Ceramic Supply                           347-671-2022   paintit@fast.com                                  
Richard Kluth        Main St. Bar and Grill                   302-296-8012   rickkluth@free.com                                
Richard Scott        Karate Made Easy                         304-774-2226   kick@onlineservice.com                            
Richard Strehle      Vacation Car Rentals                     206-434-7305   vacation@fast.com                                 
Rita Bush            Eagle Electronic                         919-747-4397   rbush@eagle.com                                   
Rob Thomas           Accessories and More                     484-374-1998   rthomas@bestchoice.com                            

NAME                 COMPANYNAME                              TELEPHONE      EMAILADDRESS                                      
-------------------- ---------------------------------------- -------------- --------------------------------------------------
Robert Dalury        TAS                                      906-278-6446   tas@zeronet.net                                   
Robert Lister        Fire Alarm Systems                       801-404-1240   fines@free.com                                    
Ronald Day           Eagle Electronic                         929-763-6488   NONE ON RECORD                                    
Ryan Stahley         Eagle Electronic                         919-774-5340   rstahley@eagle.com                                
Sally Valle          Investment Specialties                   972-234-2044   roi@usol.com                                      
Sandy Goodman        Connexions                               208-614-3136   Sgoodman@connex.com                               
Scott Gray           Security Installation                    484-453-7105   keepsafe@zeronet.net                              
Sharon Rouls         Sharons Shamrock                         205-246-3224   irish@free.com                                    
Sherman Cheswick     Eagle Electronic                         929-498-8150   scheswick@eagle.com                               
Sherry Garling       Manufactured Homes Corp.                 353-822-7623   homely@fast.com                                   
Stephanie Yeinick    Tuckers Jewels                           573-455-4278   jewels@usol.com                                   

NAME                 COMPANYNAME                              TELEPHONE      EMAILADDRESS                                      
-------------------- ---------------------------------------- -------------- --------------------------------------------------
Stephen Bird         Storage Specialties                      540-514-1415   sbird@storeit.com                                 
Steve Cochran        Eagle Electronic                         929-763-1283   NONE ON RECORD                                    
Steve Fulkerson      Cellular Services                        602-129-1885   cellcall@usol.com                                 
Steve Hess           Eagle Electronic                         919-486-8804   NONE ON RECORD                                    
Steven Hickman       Eagle Electronic                         919-774-4874   shickman@eagle.com                                
Susan Strong         Family Medical Center                    912-760-7840   fammed@onlineservice.com                          
Thurman Mezzo        Playing Around                           415-967-1415   tmezzo@playingaround.com                          
Tim Leffert          Trailor Rentals                          315-486-4777   trailrent@zeronet.net                             
Tim White            Network Niche                            517-777-1905   twhite@networkN.com                               
Timothy Neal         Computer Accessories                     704-736-9458   tneal@compAccess.com                              
Tina Yates           Eagle Electronic                         929-763-4438   tyates@eagle.com                                  

NAME                 COMPANYNAME                              TELEPHONE      EMAILADDRESS                                      
-------------------- ---------------------------------------- -------------- --------------------------------------------------
Todd Vigus           Eagle Electronic                         919-486-7143   tvigus@eagle.com                                  
Tommy McFerren       Cole Sales and Associates                503-767-7054   mcferren@cole.com                                 
Tracy Cicholski      Dixon Pharmacy                           601-959-1315   dixpharm@free.com                                 
Travis Honn          Radiant Computers                        303-564-1515   thonn@radiant.com                                 
Wade Holle           Just Link It                             887-746-6174   Wade@jLi.com                                      
Wade Jacobs          Conner National                          803-477-5347   connernat@usol.com                                
William Newlon       Creative Computer Solutions              909-452-4936   Wnewlon@ccs.com                                   
Yauleng Depoe        Scanning the World                       313-475-1177   ydepoe@sw.com                                     
Adam Cyr             Cables Anywhere                          315-474-5634   acyr@cablesany.com                                
Alice Mynhier        Magic Components                         303-696-0557   almyn@Nway.magcomp.com                            
Allen Robles         Copy Center                              644-730-8090   copy@onlineservice.com                            

NAME                 COMPANYNAME                              TELEPHONE      EMAILADDRESS                                      
-------------------- ---------------------------------------- -------------- --------------------------------------------------
Allison Roland       Eagle Electronic                         929-498-4174   NONE ON RECORD                                    
Amy Heide            Outlets                                  802-894-1024   letout@usol.com                                   
Angie Hoover         Goodwork Corporation                     307-459-4165   ahoover@free.com                                  
Anita Pastron        Industrail Contracting Co                901-796-4654   contracts@fast.com                                
Archie Doremski      Greenpart Steet Metal                    307-944-8959   sheetz@free.com                                   
Aricka Bross         Apartment Referrals                      419-676-9758   placetolive@free.com                              
Austin Ortman        Eagle Electronic                         919-774-9999   NONE ON RECORD                                    
Beth Zobitz          Eagle Electronic                         919-747-8404   bzobitz@eagle.com                                 
Brenda Kitchel       Cheesman Corporation                     804-214-8732   cheesman@zeronet.net                              
Brenda Pritchett     Wizard Electronics                       302-696-1000   bpritchett@wizelec.com                            
Bridgette Kyger      Sampson Home Mortgages                   301-467-6480   homeloans@fast.com                                

NAME                 COMPANYNAME                              TELEPHONE      EMAILADDRESS                                      
-------------------- ---------------------------------------- -------------- --------------------------------------------------
Brittany Cottingham  Cottingham Plastics                      419-464-5273   plastic@onlineservice.com                         
Bruce Fogarty        Photography Niche                        598-791-1420   photoniche@usol.com                               
Calie Zollman        Eagle Electronic                         929-763-2047   NONE ON RECORD                                    
Carl Dallas          Water Analysts                           864-541-5114   analyzeh20@fast.com                               
Cathy Bending        R and R Air                              765-617-2811   rrair@zeronet.net                                 
Cathy Harvey         The Employment Agency                    336-477-0249   findwork@onlineservice.com                        
Cecil Scheetz        Tippe Inn                                207-679-9822   cecil@free.com                                    
Charlene Franks      Rydell High School                       307-892-2938   learn@rydell.edu                                  
Charles Jones        Eagle Electronic                         919-774-5552   cjones@eagle.com                                  
Daniel Ezra          Pools For You                            207-744-1997   swim@zeronet.net                                  
Daniel Hundnall      Bobs Repair Service                      918-830-9731   fixit@usol.com                                    

NAME                 COMPANYNAME                              TELEPHONE      EMAILADDRESS                                      
-------------------- ---------------------------------------- -------------- --------------------------------------------------
Darlene Jenkins      Optical Images                           678-490-5461   DarJen@Germ.opticimag.com                         
David Becker         Load It Up                               843-646-4187   BeckerDavid@Loadiu.com                            
David Deppe          Eagle Electronic                         919-747-5155   NONE ON RECORD                                    
David Keck           Eagle Electronic                         919-747-9921   NONE ON RECORD                                    
David Tarter         Realty Specialties                       518-500-0570   estate@fast.com                                   
Dean Katpally        Phone Corporation                        808-799-3727   phonecorp@usol.com                                
Debra Cruz           Computer Fundamentals                    812-547-7359   Debra@Francomp.com                                
Dennis Drazer        Financial Planning Consul                253-315-4247   dollarplan@usol.com                               
Dennis Sammons       Gards Auto Repair                        616-544-1969   repairit@free.com                                 
Don Torres           Down Deep Drilling Inc.                  706-649-6375   drill@usol.com                                    
Donald Blythe        Make Some Noise Inc.                     520-486-6025   Dblythe@makenoise.com                             

NAME                 COMPANYNAME                              TELEPHONE      EMAILADDRESS                                      
-------------------- ---------------------------------------- -------------- --------------------------------------------------
Dorthy Beering       Actual  Computers                        213-465-4900   dbeering@actual.com                               
Doug Blizzard        Collectibles Inc.                        228-646-5114   collectit@onlineservice.com                       
Dusty Jones          Railroad Express                         674-727-0511   rr@usol.com                                       
Edna Lilley          Eagle Electronic                         929-498-2840   elilley@eagle.com                                 
Elizabeth Clark      Luxury Laptops                           646-846-6232   eclark.com                                        
Eugene Gasper        Regency Hospital                         705-580-6124   medcare@fast.com                                  
Evelyn Cassens       Vets Inc.                                302-762-9526   dr.animal@onlineservice.com                       
Frank Aamodt         Franklin Trinkets                        898-762-8741   fa@fast.com                                       
Gabrielle Stevenson  Eagle Electronic                         929-763-4873   gstevenson@eagle.com                              
Gary German          Eagle Electronic                         919-774-3325   ggerman@eagle.com                                 
Gary Mikels          Networking Alliance                      505-660-9632   GaryMikels@Swiss.Alliance.com                     

NAME                 COMPANYNAME                              TELEPHONE      EMAILADDRESS                                      
-------------------- ---------------------------------------- -------------- --------------------------------------------------
Geo Schofield        Cleaning Supply                          228-480-9751   cleanit@usol.com                                  
George Purcell       BMA Advertising Design                   432-320-6905   design@zeronet.net                                
Ginger Xiao          Bryant Accounting                        605-846-0451   acctsbryant@zeronet.net                           
Gordon Mayes         Modem Magicians                          207-634-1969   Gordon@den.modmagic.com                           
Gregory Abbott       Baker and Company                        812-447-3621   greggie@usol.com                                  
Gregory Hettinger    Eagle Electronic                         929-498-7144   NONE ON RECORD                                    
Heather Wallpe       Reflexions Manufacturing                 816-433-9799   flex@onlineservice.com                            
Heather Waters       Happytime Escort Service                 869-741-7817   dates@free.com                                    
Hugo Gillespie       Wadake Critters                          785-981-0669   critters@free.com                                 
Jack Barrick         First National Bank                      786-494-4782   1natbank@free.com                                 
Jack Brose           Eagle Electronic                         919-486-5104   NONE ON RECORD                                    

143 rows selected. 

Question 6
Table PERSON_OF_INTEREST truncated.

no rows selected

Question 7
Table COPY_CUSTOMER created.

Question 8
1 row inserted.

CUSTOMERID COMPANYNAME                              CUSTFIRSTNAME   CUSTLASTNAME         CUSTT ADDRESS                                  CITY                 ST POSTALCODE PHONE        FAX          EMAILADDR                                         
---------- ---------------------------------------- --------------- -------------------- ----- ---------------------------------------- -------------------- -- ---------- ------------ ------------ --------------------------------------------------
Z-12345    Quick Stop                               Randal          Graves               Mr.                                            Leonardo             NJ                                                                                        



Question 9
1 row updated.


CUSTOMERID COMPANYNAME                              CUSTFIRSTNAME   CUSTLASTNAME         CUSTT ADDRESS                                  CITY                 ST POSTALCODE PHONE        FAX          EMAILADDR                                         
---------- ---------------------------------------- --------------- -------------------- ----- ---------------------------------------- -------------------- -- ---------- ------------ ------------ --------------------------------------------------
Z-12345    Quick Stop                               Randal          Graves               Mr.                                            Leonardo             NJ 7737                                                                                   


Question 10

7 rows deleted.


CUSTOMERID COMPANYNAME                              CUSTFIRSTNAME   CUSTLASTNAME         CUSTT ADDRESS                                  CITY                 ST POSTALCODE PHONE        FAX          EMAILADDR                                         
---------- ---------------------------------------- --------------- -------------------- ----- ---------------------------------------- -------------------- -- ---------- ------------ ------------ --------------------------------------------------
C-300001   Baker and Company                        Gregory         Abbott               Mr.   7837 Busse Rd.                           Terre Haute          IN 47813      812-447-3621 812-447-4602 greggie@usol.com                                  
C-300002   Cole Sales and Associates                Tommy           McFerren             Dr.   3817 Farrell Rd.                         Bend                 OR 97709      503-767-7054 503-767-3394 mcferren@cole.com                                 
C-300003   Tippe Inn                                Cecil           Scheetz              Ms.   391 Weber Rd.                            Waterville           ME 04903      207-679-9822 207-679-6367 cecil@free.com                                    
C-300004   Franklin Trinkets                        Frank           Aamodt               Mr.   3304 Leredo Ave.                         New Milford          CT 06776      898-762-8741 898-762-9493 fa@fast.com                                       
C-300005   Needle Center                            Kathleen        Plyman               Ms.   7627 Belmont Ave                         New York City        NY 10131      507-543-2052 507-543-1845 needles@onlineservice.com                         
C-300006   BMA Advertising Design                   George          Purcell              Mr.   4281 Jefferson Rd.                       Scranton             PA 18522      432-320-6905 432-320-5741 design@zeronet.net                                
C-300007   Regency Hospital                         Eugene          Gasper               Mr.   7022 Ward Lake Rd.                       Barre                VT 05641      705-580-6124 705-580-4250 medcare@fast.com                                  
C-300008   South Street Rehabilitation              Jared           Meers                Mr.   4271 Airport Rd.                         Grand Forks          ND 58026      701-371-1701 701-371-1372 rehabsouth@zeronet.net                            
C-300009   Dixon Pharmacy                           Tracy           Cicholski            Mrs.  1920 Albion St.                          Crystal Springs      MS 39059      601-959-1315 601-959-4277 dixpharm@free.com                                 
C-300010   Photography Niche                        Bruce           Fogarty              Mr.   1012 Island Ave.                         Ellenboro            WV 26346      598-791-1420 598-791-8582 photoniche@usol.com                               
C-300011   Family Medical Center                    Susan           Strong               Mrs.  5883 Sudbury Rd.                         Adel                 GA 31620      912-760-7840 912-760-8489 fammed@onlineservice.com                          

CUSTOMERID COMPANYNAME                              CUSTFIRSTNAME   CUSTLASTNAME         CUSTT ADDRESS                                  CITY                 ST POSTALCODE PHONE        FAX          EMAILADDR                                         
---------- ---------------------------------------- --------------- -------------------- ----- ---------------------------------------- -------------------- -- ---------- ------------ ------------ --------------------------------------------------
C-300012   Bryant Accounting                        Ginger          Xiao                 Mrs.  6636 Walnut St.                          Rapid City           SD 57703      605-846-0451 605-846-5219 acctsbryant@zeronet.net                           
C-300013   Recreation Supply                        Karen           Burns                Dr.   2850 Farm St.                            Modesto              CA 95354      707-598-2670 707-598-3072 burnskaren@fast.com                               
C-300014   R and R Air                              Cathy           Bending              Mrs.  9573 Chestnut St.                        Evansville           IN 47732      765-617-2811 765-617-5319 rrair@zeronet.net                                 
C-300015   Vets Inc.                                Evelyn          Cassens              Ms.   6094 Pearson St.                         Newark               DE 19726      302-762-9526 302-762-3338 dr.animal@onlineservice.com                       
C-300016   Goodwork Corporation                     Angie           Hoover               Ms.   6427 Genesee St.                         Casper               WY 82638      307-459-4165 307-459-2606 ahoover@free.com                                  
C-300017   Powerful Employment                      Jim             Sokeland             Mr.   6671 Pearl Rd.                           Reisterstown         MD 21136      723-366-1117 723-366-0896 employment@zeronet.net                            
C-300018   Wadake Critters                          Hugo            Gillespie            Mr.   4194 Northfield Rd.                      Salina               KS 67402      785-981-0669 785-981-6634 critters@free.com                                 
C-300019   Conner National                          Wade            Jacobs               Ms.   2610 E. Lake Rd.                         Scranton             ND 58653      803-477-5347 803-477-5487 connernat@usol.com                                
C-300021   Realty Specialties                       David           Tarter               Mr.   6274 Blue Rock Rd.                       Syracuse             NY 13261      518-500-0570 518-500-6159 estate@fast.com                                   
C-300022   Reflexions Manufacturing                 Heather         Wallpe               Ms.   4128 Hulen St.                           Park Hills           MO 63653      816-433-9799 816-433-3621 flex@onlineservice.com                            
C-300023   TAS                                      Robert          Dalury               Mr.   4718 Pleasant Valley Rd.                 Bay City             MI 48708      906-278-6446 906-278-4345 tas@zeronet.net                                   

CUSTOMERID COMPANYNAME                              CUSTFIRSTNAME   CUSTLASTNAME         CUSTT ADDRESS                                  CITY                 ST POSTALCODE PHONE        FAX          EMAILADDR                                         
---------- ---------------------------------------- --------------- -------------------- ----- ---------------------------------------- -------------------- -- ---------- ------------ ------------ --------------------------------------------------
C-300024   Bankruptcy Help                          Jim             Lichty               Mr.   5991 Kenwood Rd.                         Chicago              IL 60624      618-847-1904 618-847-6439 bankrupt@usol.com                                 
C-300025   Railroad Express                         Dusty           Jones                Dr.   1390 Clearview Pkwy.                     Eastport             ID 83826      674-727-0511 674-727-1560 rr@usol.com                                       
C-300026   City Bus Transport                       Larry           Osmanova             Mr.   256 Royal Ln.                            Salem                OR 97311      541-905-4819 541-905-8042 citybus@fast.com                                  
C-300027   Vacation Car Rentals                     Richard         Strehle              Mr.   9862 Rock Island Rd.                     Walla Walla          WA 99362      206-434-7305 206-434-1892 vacation@fast.com                                 
C-300028   Cheesman Corporation                     Brenda          Kitchel              Mrs.  6482 Thomasen Rd.                        Roanoke              VA 24011      804-214-8732 804-214-1253 cheesman@zeronet.net                              
C-300029   Down Deep Drilling Inc.                  Don             Torres               Mr.   1979 Illinois Ave.                       Elberton             GA 30635      706-649-6375 706-649-0420 drill@usol.com                                    
C-300030   Main St. Bar and Grill                   Richard         Kluth                Dr.   7901 Peach Tree Dr.                      Middletown           DE 19709      302-296-8012 302-296-5060 rickkluth@free.com                                
C-300031   Copy Center                              Allen           Robles               Mr.   1228 Bailey Rd.                          Haxtun               CO 80761      644-730-8090 644-730-3557 copy@onlineservice.com                            
C-300032   Greenpart Steet Metal                    Archie          Doremski             Mr.   6580 Midway Rd.                          Cody                 WY 82414      307-944-8959 307-944-3950 sheetz@free.com                                   
C-300033   Pools For You                            Daniel          Ezra                 Mr.   7393 Lake June Rd.                       Auburn               ME 04212      207-744-1997 207-744-8795 swim@zeronet.net                                  
C-300034   Phone Corporation                        Dean            Katpally             Mr.   1179 38th St.                            Kapaa                HI 96746      808-799-3727 808-7991677  phonecorp@usol.com                                

CUSTOMERID COMPANYNAME                              CUSTFIRSTNAME   CUSTLASTNAME         CUSTT ADDRESS                                  CITY                 ST POSTALCODE PHONE        FAX          EMAILADDR                                         
---------- ---------------------------------------- --------------- -------------------- ----- ---------------------------------------- -------------------- -- ---------- ------------ ------------ --------------------------------------------------
C-300035   Store It Here                            Randall         Neely                Mr.   1132 Madison St.                         Rutland              VT 05701      802-319-9805 802-319-1266 storage@fast.com                                  
C-300036   Kids Recreation Inc.                     Mike            Condie               Mr.   449 Troy Ave.                            Wilson               NC 27895      336-211-1238 336-211-3812 kidrec@zeronet.net                                
C-300037   Trailor Rentals                          Tim             Leffert              Mr.   2765 Independence Ave.                   Rome                 NY 13442      315-486-4777 315-486-0683 trailrent@zeronet.net                             
C-300038   Water Analysts                           Carl            Dallas               Mr.   2530 Lakewood Blvd.                      Sumter               SC 29153      864-541-5114 864-541-9632 analyzeh20@fast.com                               
C-300039   Gards Auto Repair                        Dennis          Sammons              Mr.   581 Sahara Blvd.                         Saginaw              MI 48609      616-544-1969 616-544-3365 repairit@free.com                                 
C-300040   Computer Consultants                     Mildred         Jones                Ms.   2278 Flamingo Rd.                        Allentown            PA 18195      610-437-6687 610-437-6210 compconsul@usol.com                               
C-300041   Laser Graphics Associates                Paul            Kaakeh               Mr.   3616 Jones Blvd.                         Gunnison             CO 81247      719-750-4539 719-750-9842 graphit@usol.com                                  
C-300042   Signs Signs Signs                        Kevin           Zubarev              Mr.   5933 Valley St.                          Blackfoot            ID 83221      208-364-3785 208-364-5230 sign3@fast.com                                    
C-300043   Flowers by Mickey                        Mary            Uhl                  Ms.   6936 Citrus Blvd.                        Charleston           SC 29413      803-974-2809 803-974-6131 mouse@fast.com                                    
C-300044   Kelly Dance Studio                       Jennifer        Kmec                 Mrs.  9413 E. Broadway St.                     Taneytown            MD 21787      443-542-1386 443-542-0474 dancingk@free.com                                 
C-300045   National Art Museum                      Marjorie        Vandermay            Ms.   5384 Raymond Ave.                        Beatrice             NE 68310      308-489-1137 308-489-9640 nam@fast com                                      

CUSTOMERID COMPANYNAME                              CUSTFIRSTNAME   CUSTLASTNAME         CUSTT ADDRESS                                  CITY                 ST POSTALCODE PHONE        FAX          EMAILADDR                                         
---------- ---------------------------------------- --------------- -------------------- ----- ---------------------------------------- -------------------- -- ---------- ------------ ------------ --------------------------------------------------
C-300046   Tuckers Jewels                           Stephanie       Yeinick              Ms.   2596 S. Fairview Rd.                     Moberly              MO 65270      573-455-4278 573-455-3163 jewels@usol.com                                   
C-300047   The Employment Agency                    Cathy           Harvey               Mrs.  9481 Town Line Rd.                       Asheville            NC 28810      336-477-0249 336-477-7464 findwork@onlineservice.com                        
C-300048   Cleaning Supply                          Geo             Schofield            Mr.   4931 Talbot Blvd.                        Winona               MS 38967      228-480-9751 228-480-4037 cleanit@usol.com                                  
C-300049   Appliances Inc.                          Kara            Orze                 Ms.   2666 Stillwater Rd.                      Wausau               WI 54401      414-773-1017 414-773-2842 appinc@zeronet.net                                
C-300050   Quality Equipment Corp.                  Jeff            Kowaiski             Mr.   3323 Mission Pkwy.                       Wellsville           NY 14895      212-492-5644 212-492-9525 equipit@usol.com                                  
C-300051   Sharons Shamrock                         Sharon          Rouls                Mrs.  1274 Weaver Rd.                          Dothan               AL 36303      205-246-3224 205-246-5699 irish@free.com                                    
C-300052   Manufactured Homes Corp.                 Sherry          Garling              Ms.   4350 Concord Blvd.                       Millinockets         ME 04462      353-822-7623 353-822-9722 homely@fast.com                                   
C-300053   Camping Supplies                         Mary            Deets                Mrs.  4534 South Acres Rd.                     Pearl City           HI 96782      808-562-4081 808-562-0004 camphere@fast.com                                 
C-300054   Financial Planning Consul                Dennis          Drazer               Dr.   4799 Silverstar Rd.                      Seattle              WA 98115      253-315-4247 253-315-7522 dollarplan@usol.com                               
C-300055   Fire Alarm Systems                       Robert          Lister               Mr.   3016 Dunlap Ave.                         Provo                UT 84603      801-404-1240 801-404-8056 fines@free.com                                    
C-300056   Happytime Escort Service                 Heather         Waters               Mrs.  805 Cactus Rd.                           Lake City            SC 29560      869-741-7817 869-741-0539 dates@free.com                                    

CUSTOMERID COMPANYNAME                              CUSTFIRSTNAME   CUSTLASTNAME         CUSTT ADDRESS                                  CITY                 ST POSTALCODE PHONE        FAX          EMAILADDR                                         
---------- ---------------------------------------- --------------- -------------------- ----- ---------------------------------------- -------------------- -- ---------- ------------ ------------ --------------------------------------------------
I-300052                                            Andrew          Yelnick              Mr.   6972 Winton Rd.                          Detroit              MI 48226      517-803-5818              family@free.com                                   
I-300053                                            Stephanie       Pearl                Mrs.  6460 Springdale Rd.                      Maryville            MO 64468      660-447-8319              mommyl@fast.com                                   
I-300054                                            Dorlan          Bresnaham            Dr.   1328 Mill Ave.                           Plymouth             NH 03264      603-497-7374              dorlan@usol.com                                   
I-300055                                            Jon             Clute                Dr.   1680 River Oaks Blvd.                    Tucson               AZ 85711      480-181-8940                                                                
I-300056                                            Elizabeth       Henderson            Ms.   2819 Otay Rd.                            Zeona                SD 57758      449-486-8018                                                                
I-300057                                            Tonya           Owens                Mrs.  1414 Fields Ertel Rd.                    Abbeville            SC 29620      843-773-2751                                                                
I-300058                                            Matthew         Quant                Mr.   253 Silver Creek Rd.                     Hamlet               NC 28345      910-577-1319              walker@onlineservice.com                          
I-300059                                            Kenneth         Mintier              Mr.   4831 Skeet Blvd.                         Eureka               CA 95534      323-673-0690              builder@usol.com                                  
I-300060                                            Lucille         Appleton             Ms.   5260 Blue Mound Rd.                      Newburgh             NY 12553      914-497-2160              muscle@zeronet.net                                
I-300061                                            Brenda          Jones                Mrs.  3696 Cooper St.                          Aurora               CO 80230      720-800-2638              show@free.com                                     
I-300062                                            John            McGinnis             Dr.   7841 Hurst Blvd.                         Preston              ID 83263      208-741-1963              john@zeronet.net                                  

CUSTOMERID COMPANYNAME                              CUSTFIRSTNAME   CUSTLASTNAME         CUSTT ADDRESS                                  CITY                 ST POSTALCODE PHONE        FAX          EMAILADDR                                         
---------- ---------------------------------------- --------------- -------------------- ----- ---------------------------------------- -------------------- -- ---------- ------------ ------------ --------------------------------------------------
I-300063                                            Dennis          Eberle               Mr.   9425 James Rd.                           Waterloo             IA 50707      515-708-1802              deber@free.com                                    
I-300064                                            Jo              Jacko                Mrs.  6588 Ken Caryl Rd.                       Vineland             NJ 08361      856-752-7471                                                                
I-300065                                            Karen           Randolph             Ms.   1038 Coal Mine Rd.                       Franklin             NH 03235      603-744-9002              cookin@zeronet.net                                
I-300066                                            Ruth            Ball                 Dr.   1093 Valley View Ln.                     St. Cloud            MN 56387      651-479-7538                                                                
I-300067                                            Travis          Camargo              Mr.   6681 Forrest Ln.                         Neosho               MO 64853      816-746-4913                                                                
I-300068                                            Jerry           Muench               Mr.   1694 Stone Valley Rd.                    Miami                TX 79059      464-669-8537              redhot@onlineservice.com                          
I-300069                                            Verna           McGrew               Ms.   4755 Rocket Blvd.                        Huntsville           AL 35811      334-547-9329              verngrew@free.com                                 
I-300070                                            Elizabeth       Derhammer            Ms.   2343 Pioneer Pkwy.                       Garden City          KS 67868      785-970-9916              lizzy@onlineservice.com                           
I-300071                                            Ted             Zissa                Mr.   4935 Cedar Hill Rd.                      Ardmore              OK 73402      405-151-7445                                                                
I-300072                                            Matt            Shade                Mr.   8441 Skillman Ave.                       Green Valley         AZ 85622      623-422-6616              shadtree@free.com                                 
I-300073                                            Dean            Eagon                Mr..  616 Burton Rd.                           Peublo               CO 81011      970-581-8611                                                                

CUSTOMERID COMPANYNAME                              CUSTFIRSTNAME   CUSTLASTNAME         CUSTT ADDRESS                                  CITY                 ST POSTALCODE PHONE        FAX          EMAILADDR                                         
---------- ---------------------------------------- --------------- -------------------- ----- ---------------------------------------- -------------------- -- ---------- ------------ ------------ --------------------------------------------------
I-300074                                            Andrew          Ray                  Mr.   1246 Ferry St.                           Millville            NJ 08332      609-345-9680              andyray@usol.com                                  
I-300075                                            Robert          Cortez               Mr.   219 Pleasant Run Rd.                     Keene                NH 03435      603-442-3740                                                                
I-300076                                            Tim             Carlton              Mr.   1038 Lancaster St.                       Enfield              CT 06082      203-608-3465                                                                
I-300077                                            Jennifer        Hundley              Mrs.  6354 Buckner Blvd.                       Richwood             WV 26261      304-713-3298              jenhund@fast.com                                  
I-300078                                            Andrea          Griswold             Dr.   8215 Garland Rd.                         Leadville            CO 80429      970-746-0995              andygwold@usol.com                                
I-300079                                            Christina       Wilson               Mrs.  5766 Scyene Rd.                          Pratt                KS 67124      316-210-8989                                                                
I-300080                                            Juicheng        Nugent               Mr.   9443 Illinois Ave.                       Springfield          VT 05156      802-352-8923              nugent@fast.com                                   
I-300081                                            Bryan           Price                Mr.   1745 Best Line Rd.                       Hampton              VA 23666      804-674-9666                                                                
I-300082                                            Helene          Ziekart              Mrs.  9533 Simonds Rd.                         New Haven            CT 06511      203-244-9192                                                                
I-300083                                            Marty           Fay                  Ms.   9241 School Rd.                          Fairbanks            AK 99775      501-631-3727              sparky@free.com                                   
I-300084                                            Lisa            Pettry               Mrs.  8515 Cossell Ave.                        Carson City          NV 89714      702-799-7272              lpett@zeronet.net                                 

CUSTOMERID COMPANYNAME                              CUSTFIRSTNAME   CUSTLASTNAME         CUSTT ADDRESS                                  CITY                 ST POSTALCODE PHONE        FAX          EMAILADDR                                         
---------- ---------------------------------------- --------------- -------------------- ----- ---------------------------------------- -------------------- -- ---------- ------------ ------------ --------------------------------------------------
I-300085                                            Zach            McGrew               Mr.   5788 Rockville Rd.                       Globe                AZ 85502      520-730-8494                                                                
I-300086                                            Jamie           Thompson             Ms.   6878 Holt Ave.                           Athens               GA 30606      706-471-1222              jthompson@onlineservice.com                       
I-300087                                            Charles         Jones                Mr.   1420 N. Highland Ave.                    Grand                FL 33606      919-774-5552              charlie@usol.com                                  
I-300088                                            Thomas          Zelenka              Dr.   5371 Brookeville Rd.                     Manchester           NH 03108      603-374-3706              zelenka@free.com                                  
I-300089                                            James           Laake                Mr.   3434 Great Street                        Aladdin              WY 82710      613-785-7063                                                                
I-300090                                            Daniel          Stabnik              Mr.   3745 35th St.                            Perryville           MO 63775      636-746-4124                                                                
I-300091                                            Trudi           Antonio              Ms.   9882 Strother Rd.                        Potsdam              NY 13699      718-747-3259              toni@onlineservice.com                            
I-300092                                            John            Garcia               Mr.   231 63rd St.                             Portland             ME 04122      207-311-0174              jgar@onlineservice.com                            
I-300093                                            Jay             Hanau                Mr.   5897 Sunset Rd.                          Marion               IL 62959      773-490-8254                                                                
I-300095                                            Joshua          Cole                 Mr.   7903 Paradise Rd.                        Jackson              TN 38308      865-269-7782              fido@zeronet.net                                  
I-300096                                            David           Schilling            Mr.   8671 Chapel Rd.                          Bowling Green        KY 42102      502-421-1516                                                                

CUSTOMERID COMPANYNAME                              CUSTFIRSTNAME   CUSTLASTNAME         CUSTT ADDRESS                                  CITY                 ST POSTALCODE PHONE        FAX          EMAILADDR                                         
---------- ---------------------------------------- --------------- -------------------- ----- ---------------------------------------- -------------------- -- ---------- ------------ ------------ --------------------------------------------------
I-300097                                            Mary Ann        Rausch               Mrs.  3679 Western Ave.                        Green River          WY 82938      307-944-3324              spiritual@free.com                                
I-300098                                            Allison         Roland               Mrs.  4599 S. Maodill Ave.                     Palma                FL 33604      929-498-4174              alley@onlineservice.com                           
I-300099                                            Roy             Beer                 Mr.   8065 Colina Rd.                          Yakima               WA 98907      206-745-2584              wizzy@usol.com                                    
I-300100                                            Chris           Dunlap               Mrs.  3526 10th St.                            Gillette             WY 82731      307-473-2281                                                                
I-300101                                            Ansel           Farrell              Mr.   316 Birch St.                            Storm Lake           IA 50588      712-440-3934              prickly@onlineservice.com                         
I-300102                                            Jason           Laxton               Mr.   7858 Dowling Ave. N.                     Athol                MA 01368      978-860-2824              coondog@usol.com                                  
I-300103                                            Larry           Gardiner             Mr.   1739 W 39th St.                          Winnsboro            LA 71295      225-313-6268              square@onlineserveice.com                         
I-300104                                            Lawrence        Pullen               Mr.   4599 Rheem Blvd.                         Greenbush            MN 56726      644-591-3243              laurie@free.com                                   
I-300105                                            Matt            Nakanishi            Mr.   8108 Middle Rd.                          Price                UT 84501      435-710-5324              nakan@free.com                                    
I-300106                                            Nancy           Basham               Mrs.  3409 36th Ave. N.                        Dexter               ME 04930      207-422-7135                                                                
I-300107                                            Rachel          Davis                Ms.   2954 Cedar Lake Rd.                      Reno                 NV 89523      702-907-4818              rachdav@zeronet.net                               

CUSTOMERID COMPANYNAME                              CUSTFIRSTNAME   CUSTLASTNAME         CUSTT ADDRESS                                  CITY                 ST POSTALCODE PHONE        FAX          EMAILADDR                                         
---------- ---------------------------------------- --------------- -------------------- ----- ---------------------------------------- -------------------- -- ---------- ------------ ------------ --------------------------------------------------
I-300108                                            Sarah           McCammon             Mrs.  3216 Dimond Lake Rd.                     Kingman              AZ 86411      520-438-7944              squirrel@zeronet.net                              
I-300109                                            David           Tietz                Mr.   5235 E. 44th St.                         Montevideo           MN 56265      651-912-1583              tietz@free.com                                    
I-300110                                            Jim             Manaugh              Mr.   1011 W. Hillsborough Ave.                Garyville            FL 33605      919-747-5603              jmanaugh@eagle.com                                
I-300111                                            Richard         Stetler              Mr.   7496 University Ave.                     Auburn               AL 36832      256-412-8112              screwball@free.com                                
I-300112                                            Jonathon        Blanco               Mr.   8095 Mounty Rd.                          Oshkosh              WI 54904      902-226-1858              hammer@free.com                                   
I-300113                                            Randolph        Darling              Mr.   8254 Coral Way                           Putnam               CT 06260      860-684-1620              randolph@fast.com                                 
I-300114                                            Melody          Fazal                Mrs.  4603 Killian Rd.                         Bakersfield          CA 93311      760-877-4849              melfazal@zeronet.net                              
I-300115                                            Michael         Tendam               Dr.   190 Dixie St.                            Glasgow              MT 592331     406-424-7496              flute@usol.com                                    
I-300116                                            Sean            Akropolis            Mr.   6603 E. Little Yak Rd.                   Anchorage            AK 99509      907-262-4254              pickle@free.com                                   
I-300117                                            Anne            Hatzell              Ms.   5200 Belfat Blvd.                        Seaford              DE 19973      302-651-6440              hazel@zeronet.net                                 
I-300118                                            Meredith        Rushing              Dr.   1856 Cullen Blvd.                        Lexington            KY 40516      606-608-2105              merry@free.com                                    

CUSTOMERID COMPANYNAME                              CUSTFIRSTNAME   CUSTLASTNAME         CUSTT ADDRESS                                  CITY                 ST POSTALCODE PHONE        FAX          EMAILADDR                                         
---------- ---------------------------------------- --------------- -------------------- ----- ---------------------------------------- -------------------- -- ---------- ------------ ------------ --------------------------------------------------
I-300120                                            Zack            Hill                 Mr.   2064 Preston Rd.                         Winston              OR 97496      503-794-2322              boogie@free.com                                   
I-300121                                            Dan             Lageveen             Mr.   3056 Southern Ave. N.                    Laramie              WY 82073      307-344-8928              veenie@zeronet.net                                
I-300122                                            Marla           Reeder               Mrs.  1029 Moraga Ave. W.                      Bonifay              FL 32425      728-442-3031              reedmar@zeronet.net                               
I-300123                                            Linda           Bowen                Mrs.  5541 Bell Rd.                            Huron                SD 57350      605-234-4114                                                                
I-300124                                            Michael         Emore                Mr.   7347 Peoria Ave.                         Orlando              FL 32810      352-472-1224              mikemore@usol.com                                 
I-300125                                            Mary Jo         Wales                Dr.   1416 Wynnewood Ave.                      Wallowa              OR 97885      852-441-4984              jomary@onlineservice.com                          
I-300126                                            Tom             Moore                Mr.   7742 Glendale Ave.                       Morehead             KY 04351      270-692-2845              seedle@fast.com                                   
I-300127                                            Susan           Watson               Mrs.  6151 Indian School Rd.                   Ogden                UT 84414      801-746-7701              mswatson@fast.com                                 
I-300128                                            Tom             Irelan               Mr.   7833 McDowell Rd.                        Cumberland           MD 21503      240-634-5581              tucker@free.com                                   
I-300129                                            Rosemary        Vanderhoff           Dr.   843 99th St.                             Macon                GA 31206      770-293-8783                                                                
I-300130                                            Mike            Dunbar               Mr.   1750 Broadway St.                        Grangeville          ID 83531      208-297-5374              duh@onlineservice.com                             

CUSTOMERID COMPANYNAME                              CUSTFIRSTNAME   CUSTLASTNAME         CUSTT ADDRESS                                  CITY                 ST POSTALCODE PHONE        FAX          EMAILADDR                                         
---------- ---------------------------------------- --------------- -------------------- ----- ---------------------------------------- -------------------- -- ---------- ------------ ------------ --------------------------------------------------
I-300131                                            Ryan            Stahley              Mr.   9281 E. Bird St.                         Grand                FL 33606      919-774-5340              rstahley@eagle.com                                
I-300132                                            Patricia        Leong                Ms.   6213 Baseline Rd.                        Prescott             AZ 86313      520-247-4141              patrice@usol.com                                  
I-300133                                            Roy             McGrew               Mr.   1968 Elliot Rd.                          Nampa                ID 83686      208-324-0783              grow@zeronet.net                                  
I-300134                                            Tom             Baker                Mr.   483 Greenway St.                         Sparta               WI 54656      414-778-5640              bologna@free.com                                  
I-300135                                            Bill            Umbarger             Mr.   1476 Eastern Pkwy.                       Belfast              ME 04915      207-155-1577              cheezy@onlineservice.com                          
I-300136                                            Bob             Weldy                Mr.   8227 Oak Ridge Rd.                       Lynchburg            VA 24506      571-490-6449              sucker42@usol.com                                 
I-300137                                            Kris            Shinn                Dr.   7451 Tiden St.                           Pecos                TX 79772      469-740-2748              shinnk@zeronet.net                                
I-300138                                            James           King                 Dr.   2734 Mulga Loop Rd.                      Lincoln              ME 04457      207-708-3317              jamesk@usol.com                                   
I-300139                                            Frank           Malady               Mr.   7894 Geary Blvd.                         Nahunta              GA 31533      574-493-0510              frankmala@zeronet.net                             
I-300140                                            Jim             Webb                 Mr.   3577 Hessian Ave.                        Lowell               MA 01853      978-204-3019                                                                
I-300141                                            Daniel          Rodkey               Ms.   4024 Mill Plain Blvd.                    Lamar                CO 81052      719-748-3205              dannie@free.com                                   

CUSTOMERID COMPANYNAME                              CUSTFIRSTNAME   CUSTLASTNAME         CUSTT ADDRESS                                  CITY                 ST POSTALCODE PHONE        FAX          EMAILADDR                                         
---------- ---------------------------------------- --------------- -------------------- ----- ---------------------------------------- -------------------- -- ---------- ------------ ------------ --------------------------------------------------
I-300142                                            Marc            Williams             Mr.   8443 15th St.                            Cedar City           VT 84721      435-774-4595              peanut@fast.com                                   
I-300143                                            Kristy          Moore                Ms.   4410 W. Spruce St.                       Fort Sutton          FL 33603      919-486-6765              fluffy@onlineservice.com                          
I-300144                                            Russ            Mann                 Mr.   6879 Island Ave.                         Las Vegas            NV 89199      775-549-1798              scooter@onlineservice.com                         
I-300145                                            Carrie          Buchko               Mrs.  3793 Leheigh Ave.                        Jasper               TX 75951      817-739-1335              goobert@free.com                                  
I-300146                                            Michelle        Oakley               Ms.   5348 Elmwood Ave.                        Brockton             MA 02303      978-514-5425              littleone@usol.com                                
I-300147                                            Steven          Yaun                 Mr.   4711 Hook Rd.                            Indianapolis         IN 46208      317-780-9804              yawn@fast.com                                     
I-300148                                            Jack            Illingworth          Mr.   2741 Ashland Ave.                        Buffalo              NY 14206      914-748-9829              illing@free.com                                   
I-300149                                            Thomas          Wolfe                Mr.   7347 Broad St.                           Scranton             PA 18510      610-365-9766              wolf@onlineservice.com                            
I-300150                                            Irene           Poczekay             Mrs.  7000 W. 7th St.                          Newport              RI 02840      401-461-9567                                                                
I-300151                                            Andy            Huegel               Dr.   7542 Haverford Blvd.                     Milford              DE 19963      302-620-1366                                                                
I-300152                                            Karen           Marko                Ms.   4954 Clifton Rd.                         Lawton               OK 73506      580-555-1871              marko@usol.com                                    

CUSTOMERID COMPANYNAME                              CUSTFIRSTNAME   CUSTLASTNAME         CUSTT ADDRESS                                  CITY                 ST POSTALCODE PHONE        FAX          EMAILADDR                                         
---------- ---------------------------------------- --------------- -------------------- ----- ---------------------------------------- -------------------- -- ---------- ------------ ------------ --------------------------------------------------
I-300153                                            Trevor          Snuffer              Mr.   6550 Forbes Ave.                         Rocky Mount          NC 27803      336-185-0630              snuffer@zeronet.net                               
I-300154                                            Phil            Reece                Mr.   1204 N. Nebraska Ave.                    Fort Sutton          FL 33603      919-486-0649              sly@zeronet.net                                   
I-300155                                            Linda           Hari                 Mrs.  791 McKnight Rd.                         Franklin             KY 42134      270-411-2316                                                                
I-300156                                            Andrew          Smith                Mr.   1244 Fremont Ave.                        Tribune              KS 67879      709-307-2568              smokey@zeronet.net                                
I-300157                                            Linda           Li                   Ms.   5920 Grove St.                           Torrington           CT 06790      203-744-4677              ll@free.com                                       
C-300057   Industrail Contracting Co                Anita           Pastron              Ms.   2817 Northern Ave.                       McMinnville          TN 37111      901-796-4654 901-796-3276 contracts@fast.com                                
C-300058   Outlets                                  Amy             Heide                Ms.   9119 Camelback Rd.                       Brattleboro          VT 05304      802-894-1024 802-894-1135 letout@usol.com                                   
C-300059   Rydell High School                       Charlene        Franks               Mrs.  1627 Thomas Rd.                          Douglas              WY 82633      307-892-2938 307-892-1477 learn@rydell.edu                                  
C-300060   Collectibles Inc.                        Doug            Blizzard             Mr.   856 Van Buren St.                        Mars Hill            MS 39666      228-646-5114 228-646-2170 collectit@onlineservice.com                       
C-300061   Karate Made Easy                         Richard         Scott                Mr.   1489 Dobbins Rd.                         Fairmont             WV 26555      304-774-2226 304-774-8150 kick@onlineservice.com                            
C-300062   Security Installation                    Scott           Gray                 Mr.   115 Shea Blvd.                           York                 PA 17406      484-453-7105 484-453-6614 keepsafe@zeronet.net                              

CUSTOMERID COMPANYNAME                              CUSTFIRSTNAME   CUSTLASTNAME         CUSTT ADDRESS                                  CITY                 ST POSTALCODE PHONE        FAX          EMAILADDR                                         
---------- ---------------------------------------- --------------- -------------------- ----- ---------------------------------------- -------------------- -- ---------- ------------ ------------ --------------------------------------------------
C-300063   Ceramic Supply                           Randy           Talauage             Mr.   6364 Brown St.                           Northport            WA 99157      347-671-2022 347-671-9116 paintit@fast.com                                  
C-300064   Bobs Repair Service                      Daniel          Hundnall             Mr.   909 Reams Rd.                            Enid                 OK 73705      918-830-9731 918-830-3898 fixit@usol.com                                    
C-300065   Investment Specialties                   Sally           Valle                Dr.   6298 Killingsworth St.                   Denton               TX 76208      972-234-2044 972-234-1543 roi@usol.com                                      
C-300066   North Street Church                      Noemi           Elston               Mr.   3024 28th St.                            Rock Springs         WY 82902      307-359-9514 307-359-8090 closetoheaven@zeronet.net                         
C-300067   Supplying Crafts                         Kelly           Jordan               Ms.   168 Division St.                         Jacksonville         FL 32205      727-951-7737 727-951-9889 supplycrafts@fast.com                             
C-300068   Cellular Services                        Steve           Fulkerson            Mr.   6912 White Horse Rd.                     Snowflake            AZ 85937      602-129-1885 602-129-5545 cellcall@usol.com                                 
C-300069   Easy Internet Access                     Orville         Gilliland            Mr.   5515 Page-Mill Rd.                       Vancleeve            MS 39565      490-263-2957 490-263-6303 eia@zeronet.net                                   
C-300070   Sampson Home Mortgages                   Bridgette       Kyger                Mrs.  5682 Chester Pike Rd.                    Annapolis            MD 21412      301-467-6480 301-467-5740 homeloans@fast.com                                
C-300071   The Cable Company                        Norman          Fields               Dr.   4174 Collings St.                        Juneau               AK 99811      501-346-4841 501-346-0928 catv@onlineservice.com                            
C-300072   Automart                                 Jessica         Nakamura             Ms.   8233 Clairton Ave.                       Mitchell             SD 57301      605-324-2193 605-324-1030 carsell@usol.com                                  
C-300073   First National Bank                      Jack            Barrick              Mr.   2638 Becks Run Rd.                       Titusville           FL 32783      786-494-4782 786-494-1359 1natbank@free.com                                 

CUSTOMERID COMPANYNAME                              CUSTFIRSTNAME   CUSTLASTNAME         CUSTT ADDRESS                                  CITY                 ST POSTALCODE PHONE        FAX          EMAILADDR                                         
---------- ---------------------------------------- --------------- -------------------- ----- ---------------------------------------- -------------------- -- ---------- ------------ ------------ --------------------------------------------------
I-300001                                            Anna            Mayton               Dr.   2381 Basse Rd.                           McKenzie             Al 36456      888-451-1233              doctor@free.com                                   
I-300002                                            Lou             Caldwell             Mr.   1486 Joliet Rd.                          Louisville           KY 40211      606-901-1238              lucky@fast.com                                    
I-300004                                            Jeffery         Jordan               Mr.   1500 Normantown Rd.                      Spokane              WA 99211      509-989-9996              seeya@usol.com                                    
I-300005                                            Kimber          Spaller              Mrs.  1565 Culebra Rd.                         Sitka                AK 99836      878-119-5448              mcgimmie@zero.net                                 
I-300006                                            Eric            Fannon               Mr.   2526 Nelson Rd.                          Redding              CA 96003      209-980-0812              ef@free.com                                       
I-300007                                            Jessica         Cain                 Ms.   942 55th St.                             Greenville           MI 48838      517-901-2610                                                                
I-300008                                            Richard         Zito                 Mr.   7569 130th St.                           Lebanon              NH 03766      603-787-0787              rzito@zeronet.net                                 
I-300009                                            Angela          Wainscott            Dr.   3646 North Ave.                          Idaho Falls          ID 83415      208-788-4112              awainscott@free.com                               
I-300010                                            James           Gross                Dr.   1983 Mill St.                            Lakewood             NJ 08701      908-879-8672              jgross@fast.com                                   
I-300011                                            Jack            Akers                Mr.   1485 71st St.                            Wilmington           DE 19850      301-454-6061              pizazz@usol.com                                   
I-300012                                            Kevin           Jackson              Mr.   5990 Cuba Rd.                            New Orleans          LA 70123      225-624-2341                                                                

CUSTOMERID COMPANYNAME                              CUSTFIRSTNAME   CUSTLASTNAME         CUSTT ADDRESS                                  CITY                 ST POSTALCODE PHONE        FAX          EMAILADDR                                         
---------- ---------------------------------------- --------------- -------------------- ----- ---------------------------------------- -------------------- -- ---------- ------------ ------------ --------------------------------------------------
I-300013                                            Shirley         Osborne              Mrs.  816 Penny Rd.                            Swainsboro           GA 30401      706-333-7174                                                                
I-300014                                            Eric            Becker               Mr.   8784 Wabash Ave.                         Kinston              NC 28504      910-717-7613              daddyo@usol.com                                   
I-300015                                            Karen           Mangus               Mrs.  4804 Ridge Rd.                           Sebring              FL 33871      863-623-0459              missright@onlineservice.com                       
I-300016                                            Peter           Austin               Mr.   4804 River Rd.                           Barnwell             SC 29812      803-343-6063                                                                
I-300017                                            Brad            Arquette             Mr.   2599 Ben Hill Rd.                        Tonopah              NV 89049      775-914-4294              arq@usol.com                                      
I-300018                                            Daniel          Barton               Mr.   4599 Atlanta Rd.                         Sweetwater           TX 79556      915-894-8034              dannie@zeronet.net                                
I-300019                                            Jerry           Mennen               Dr.   869 Clay St.                             Flagstaff            AZ 86038      520-306-8426              mennenj@free.com                                  
I-300020                                            Kenneth         Wilcox               Mr.   9364 Hershell Rd.                        Creston              IA 50801      515-872-8848              kenny@onlineservice.com                           
I-300021                                            Matt            Smith                Mr.   6804 All Rd.                             Montrose             CO 81402      719-822-8828              matsm@fast.com                                    
I-300022                                            Paul            Sullivan             Mr.   9399 Flat Rd.                            Wichita              KS 67251      785-322-5896              sullie@zeronet.net                                
I-300023                                            Gerald          Campbell             Dr.   1869 Boundary St.                        Westfield            WI 53964      431-087-1044              gcampbell@free.com                                

CUSTOMERID COMPANYNAME                              CUSTFIRSTNAME   CUSTLASTNAME         CUSTT ADDRESS                                  CITY                 ST POSTALCODE PHONE        FAX          EMAILADDR                                         
---------- ---------------------------------------- --------------- -------------------- ----- ---------------------------------------- -------------------- -- ---------- ------------ ------------ --------------------------------------------------
I-300024                                            Joan            Hedden               Mrs.  4518 Red Bud Trail                       Springdale           AR 72765      501-710-0658                                                                
I-300025                                            Ronald          Miller               Mr.   360 Spring St.                           Kalamazoo            MI 49008      734-820-2076              picky@zeronet.net                                 
I-300026                                            Terry           Xu                   Ms.   2019 Elm St.                             Columbia             MO 65215      417-546-2570              muffin@fast.com                                   
I-300027                                            Danita          Sharp                Ms.   3475 Mystic St.                          Yakima               WA 98908      360-650-5604              girlfriend@fast.com                               
I-300028                                            Don             Kaleta               Mr.   8948 Washington St.                      Altoona              PA 16602      724-695-2157              stud@zeronet.net                                  
I-300029                                            Tammi           Baldocchio           Ms.   924 North Ave.                           Slatersville         RI 02876      401-989-4975                                                                
I-300030                                            Eric            Quintero             Mr.   144 Concord Rd.                          Columbus             IN 47202      812-805-1588              diamond@onlineservice.com                         
I-300031                                            Phillip         Hession              Mr.   7610 Hartford Ct.                        Battle Creek         MI 49016      231-711-6837              howdy@usol.com                                    
I-300032                                            Ruth            Albeering            Dr.   1348 Yonge Rd.                           Galax                VA 24333      784-444-0131              rabeering@free.com                                
I-300033                                            Jacob           Richer               Mr.   1490 N. Shore Rd.                        Ephrata              WA 98823      425-942-3763              laugh@free.com                                    
I-300034                                            James           Jones                Mr.   4685 Vernon St.                          Burns                OR 97720      971-522-5851              puffy@fast.com                                    

CUSTOMERID COMPANYNAME                              CUSTFIRSTNAME   CUSTLASTNAME         CUSTT ADDRESS                                  CITY                 ST POSTALCODE PHONE        FAX          EMAILADDR                                         
---------- ---------------------------------------- --------------- -------------------- ----- ---------------------------------------- -------------------- -- ---------- ------------ ------------ --------------------------------------------------
I-300035                                            Tim             Parker               Mr.   2848 Marrett Rd.                         Troy                 NY 12182      315-985-4102              jeckle@onlineservice.com                          
I-300036                                            Andrea          Montgomery           Ms.   1699 Conner Dr.                          Thurmont             MD 21788      349-397-7772                                                                
I-300037                                            Chas            Funk                 Mr.   2490 Maple St.                           Trumbull             CT 06611      860-498-3900              duck@usol.com                                     
I-300038                                            David           Smith                Mr.   9245 Main St.                            Rockford             IL 61125      309-980-4350              emerald@onlineservice.com                         
I-300040                                            Kathy           Gunderson            Mrs.  2257 Oak Springs Rd.                     Marianna             FL 32447      941-330-3314                                                                
I-300041                                            Dennis          Mundy                Mr.   5781 Red Bud Trail                       Littleton            NH 03561      603-306-0774              rino@usol.com                                     
I-300042                                            George          Trenkle              Mr.   1874 Jefferson Ave.                      Edison               NJ 08837      856-267-7913              cold@fast.com                                     
I-300043                                            Carey           Dailey               Ms.   234 Sheridan Dr.                         Denver               CO 80219      728-896-2767              shelty@usol.com                                   
I-300044                                            Louise          Cool                 Mrs.  6831 Walden Ave.                         Hailey               ID 83333      208-956-0698                                                                
I-300046                                            Jane            Mumford              Dr.   8235 Center Rd.                          Campbellsville       KY 42719      270-428-5866                                                                
I-300047                                            Scott           Yarian               Dr.   4198 Center Ridge Rd.                    Whiteville           NC 28472      252-310-2224              syarian@fast.com                                  

CUSTOMERID COMPANYNAME                              CUSTFIRSTNAME   CUSTLASTNAME         CUSTT ADDRESS                                  CITY                 ST POSTALCODE PHONE        FAX          EMAILADDR                                         
---------- ---------------------------------------- --------------- -------------------- ----- ---------------------------------------- -------------------- -- ---------- ------------ ------------ --------------------------------------------------
I-300048                                            Patrick         Bollock              Mr.   1472 Bayley Rd.                          Powell               WY 82435      307-635-1692              pat@fast.com                                      
I-300049                                            Paul            Rice                 Mr.   830 Shaker Blvd.                         Craig                CO 81626      719-541-1837              paulier@onlineservice.com                         
I-300050                                            James           Schilling            Mr.   2021 North Bend Rd.                      Cedar Rapids         IA 52498      319-429-9772                                                                
I-300051                                            Lynne           Lagunes              Ms.   2820 Beechmont Ave.                      Pocatello            ID 83209      208-502-9976              hello@zeronet.net                                 
Z-12345    Quick Stop                               Randal          Graves               Mr.                                            Leonardo             NJ 7737                                                                                   

225 rows selected. 


Question 11
1 row deleted.

no rows selected

Question 12
224 rows updated.


CITY                 ST
-------------------- --
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ

CITY                 ST
-------------------- --
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ

CITY                 ST
-------------------- --
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ

CITY                 ST
-------------------- --
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ

CITY                 ST
-------------------- --
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ

CITY                 ST
-------------------- --
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ

CITY                 ST
-------------------- --
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ

CITY                 ST
-------------------- --
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ

CITY                 ST
-------------------- --
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ

CITY                 ST
-------------------- --
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ

CITY                 ST
-------------------- --
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ

CITY                 ST
-------------------- --
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ

CITY                 ST
-------------------- --
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ

CITY                 ST
-------------------- --
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ

CITY                 ST
-------------------- --
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ

CITY                 ST
-------------------- --
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ

CITY                 ST
-------------------- --
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ

CITY                 ST
-------------------- --
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ

CITY                 ST
-------------------- --
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ

CITY                 ST
-------------------- --
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ

CITY                 ST
-------------------- --
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ
Leonardo             NJ

224 rows selected. 

Question 13
Table EMPLOYEE_BOTTOM_25 created.

Table EMPLOYEE_BOTTOM_10 created.

Table EMPLOYEE_OTHERS created.

Question 14
40 rows inserted.

EMPLOYEE_I EMPLOYEE_NAME                       JOB_TITLE                               SALARY
---------- ----------------------------------- ----------------------------------- ----------
100101     JoanneRosner                        Assembly                                  16.3
100120     MichelleNairn                       Assembly                                 16.75
100204     DavidKeck                           Assembly                                  17.8
100220     ToddVigus                           Accountant                                  15
100399     RonaldDay                           Assembly                                 16.25
100475     SteveHess                           Assembly                                  17.6
100550     AllisonRoland                       Assembly                                 16.85
100600     CalieZollman                        Sales                                    17.35
100892     JosephPlatt                         Assembly                                 17.95
100967     NicholasAlbregts                    Assembly                                  15.5
100989     KathrynDeagen                       Assembly                                 16.95

EMPLOYEE_I EMPLOYEE_NAME                       JOB_TITLE                               SALARY
---------- ----------------------------------- ----------------------------------- ----------
101007     JasonKrasner                        Sales                                    12.75
101030     KristeyMoore                        Assembly                                  13.6
101045     AustinOrtman                        Assembly                                  10.5
101066     LauraRodgers                        Sales                                     12.6
101088     PatrichaUnderwood                   Assembly                                 18.45
101089     MelissaAlvarez                      Assembly                                 13.25
101097     JackBrose                           Assembly                                 12.05
101115     SteveCochran                        Assembly                                  10.5
101135     DavidDeppe                          Assembly                                 11.65
101154     GregoryHettinger                    Assembly                                 11.25
101166     PhilReece                           Assembly                                  10.5

22 rows selected. 


EMPLOYEE_I EMPLOYEE_NAME                       JOB_TITLE                               SALARY
---------- ----------------------------------- ----------------------------------- ----------
100106     PaulEckelman                        Accountant                               53600
100209     TinaYates                           Engineer                                 52000
100488     JamieOsman                          Programmer Analyst                       46300
100559     MeghanTyrie                         Engineer                                 50100
100880     GaryGerman                          Chief Sales Officer                      48900
100944     RyanStahley                         Engineer                                 48600

6 rows selected. 

Question 15

22 rows deleted.

12 rows deleted.

6 rows deleted.

no rows selected
no rows selected
no rows selected

Question 16

Table EMPLOYEE_TOP_2 created.

Question 17
50 rows inserted.


EMPLOYEE_I EMPLOYEE_NAME                       JOB_TITLE                               SALARY
---------- ----------------------------------- ----------------------------------- ----------
100001     JimManaugh                          Chief Financial Officer                  75500
100103     RitaBush                            VP Operations                            85800
100104     MichaelAbbott                       Engineer                                 74400
100112     StevenHickman                       Programmer Analyst                       57600
100125     GabrielleStevenson                  Chief Information Officer                75300
100127     JasonWendling                       Operations Officer                       65600
100200     BethZobitz                          Engineer                                 55200
100206     KathleenXolo                        VP Finance                               80700
100330     KristenGustavel                     Operations Officer                       68800
100365     ShermanCheswick                     President                                99900
100650     EdnaLilley                          VP Information                           93900

EMPLOYEE_I EMPLOYEE_NAME                       JOB_TITLE                               SALARY
---------- ----------------------------------- ----------------------------------- ----------
100700     CharlesJones                        DBA                                      65600

12 rows selected. 


EMPLOYEE_I EMPLOYEE_NAME                       JOB_TITLE                               SALARY
---------- ----------------------------------- ----------------------------------- ----------
100101     JoanneRosner                        Assembly                                  16.3
100120     MichelleNairn                       Assembly                                 16.75
100204     DavidKeck                           Assembly                                  17.8
100220     ToddVigus                           Accountant                                  15
100399     RonaldDay                           Assembly                                 16.25
100475     SteveHess                           Assembly                                  17.6
100550     AllisonRoland                       Assembly                                 16.85
100600     CalieZollman                        Sales                                    17.35
100892     JosephPlatt                         Assembly                                 17.95
100967     NicholasAlbregts                    Assembly                                  15.5
100989     KathrynDeagen                       Assembly                                 16.95

EMPLOYEE_I EMPLOYEE_NAME                       JOB_TITLE                               SALARY
---------- ----------------------------------- ----------------------------------- ----------
101007     JasonKrasner                        Sales                                    12.75
101030     KristeyMoore                        Assembly                                  13.6
101045     AustinOrtman                        Assembly                                  10.5
101066     LauraRodgers                        Sales                                     12.6
101088     PatrichaUnderwood                   Assembly                                 18.45
101089     MelissaAlvarez                      Assembly                                 13.25
101097     JackBrose                           Assembly                                 12.05
101115     SteveCochran                        Assembly                                  10.5
101135     DavidDeppe                          Assembly                                 11.65
101154     GregoryHettinger                    Assembly                                 11.25
101166     PhilReece                           Assembly                                  10.5

22 rows selected. 


EMPLOYEE_I EMPLOYEE_NAME                       JOB_TITLE                               SALARY
---------- ----------------------------------- ----------------------------------- ----------
100001     JimManaugh                          Chief Financial Officer                  75500
100103     RitaBush                            VP Operations                            85800
100104     MichaelAbbott                       Engineer                                 74400
100125     GabrielleStevenson                  Chief Information Officer                75300
100127     JasonWendling                       Operations Officer                       65600
100206     KathleenXolo                        VP Finance                               80700
100330     KristenGustavel                     Operations Officer                       68800
100365     ShermanCheswick                     President                                99900
100650     EdnaLilley                          VP Information                           93900
100700     CharlesJones                        DBA                                      65600

10 rows selected. 


EMPLOYEE_I EMPLOYEE_NAME                       JOB_TITLE                               SALARY
---------- ----------------------------------- ----------------------------------- ----------
100106     PaulEckelman                        Accountant                               53600
100209     TinaYates                           Engineer                                 52000
100488     JamieOsman                          Programmer Analyst                       46300
100559     MeghanTyrie                         Engineer                                 50100
100880     GaryGerman                          Chief Sales Officer                      48900
100944     RyanStahley                         Engineer                                 48600

6 rows selected. 
Question 18
10 rows updated.


EMPLOYEE_I EMPLOYEE_NAME                       JOB_TITLE                               SALARY
---------- ----------------------------------- ----------------------------------- ----------
100001     JimManaugh                          Chief Financial Officer                  90600
100103     RitaBush                            VP Operations                           102960
100104     MichaelAbbott                       Engineer                                 89280
100125     GabrielleStevenson                  Chief Information Officer                90360
100127     JasonWendling                       Operations Officer                       78720
100206     KathleenXolo                        VP Finance                               96840
100330     KristenGustavel                     Operations Officer                       82560
100365     ShermanCheswick                     President                               119880
100650     EdnaLilley                          VP Information                          112680
100700     CharlesJones                        DBA                                      78720

10 rows selected. 



Question 19
1 row inserted.


EMPLOYEE_I EMPLOYEE_NAME                       JOB_TITLE                               SALARY
---------- ----------------------------------- ----------------------------------- ----------
101        Happy Owner                         Big Boss                               1000000

Question 20
10 rows merged.


Question 21
 Table COPY_CUSTOMER dropped.


Table PERSON_OF_INTEREST dropped.


Table EMPLOYEE_BOTTOM_10 dropped.


Table EMPLOYEE_TOP_2 dropped.


Table EMPLOYEE_BOTTOM_25 dropped.


Table EMPLOYEE_OTHERS dropped.

    

*/