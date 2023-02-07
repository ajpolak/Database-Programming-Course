-- Austin Polak

-- Question 1a
CREATE OR REPLACE PROCEDURE PRINT_EMPLOYEE_ROSTER
AS
    CURRENT_EMPLOYEEID EMPLOYEE.EMPLOYEEID%TYPE;
    CURRENT_LASTNAME EMPLOYEE.LASTNAME%TYPE;
    CURRENT_FIRSTNAME EMPLOYEE.FIRSTNAME%TYPE;
    
    CURSOR ALL_EMPLOYEES
    IS
        SELECT EMPLOYEEID, LASTNAME, FIRSTNAME FROM EMPLOYEE;
        
BEGIN
    OPEN ALL_EMPLOYEES;
    
    FETCH ALL_EMPLOYEES INTO CURRENT_EMPLOYEEID, CURRENT_LASTNAME, CURRENT_FIRSTNAME;
    
    WHILE ALL_EMPLOYEES%FOUND LOOP
    
        DBMS_OUTPUT.PUT (RPAD(CURRENT_EMPLOYEEID, 15, ' '));
        DBMS_OUTPUT.PUT (RPAD(CURRENT_LASTNAME, 30, ' '));
        DBMS_OUTPUT.PUT_LINE (CURRENT_FIRSTNAME);
        FETCH ALL_EMPLOYEES INTO CURRENT_EMPLOYEEID, CURRENT_LASTNAME, CURRENT_FIRSTNAME;
    END LOOP;
    
    CLOSE ALL_EMPLOYEES;
END PRINT_EMPLOYEE_ROSTER;

/
-- Question 1b
EXEC PRINT_EMPLOYEE_ROSTER;
/
-- Question 2a
CREATE OR REPLACE PROCEDURE PRINT_EMPLOYEE_ROSTER
AS
    CURSOR ALL_EMPLOYEES
    IS
        SELECT EMPLOYEEID, LASTNAME, FIRSTNAME FROM EMPLOYEE;
        
    CURRENT_EMPLOYEE ALL_EMPLOYEES%ROWTYPE;
BEGIN
    OPEN ALL_EMPLOYEES;
    
    FETCH ALL_EMPLOYEES INTO CURRENT_EMPLOYEE;
    
    WHILE ALL_EMPLOYEES%FOUND LOOP
    
        DBMS_OUTPUT.PUT (RPAD(CURRENT_EMPLOYEE.EMPLOYEEID, 15, ' '));
        DBMS_OUTPUT.PUT (RPAD(CURRENT_EMPLOYEE.LASTNAME, 30, ' '));
        DBMS_OUTPUT.PUT_LINE (CURRENT_EMPLOYEE.FIRSTNAME);
        FETCH ALL_EMPLOYEES INTO CURRENT_EMPLOYEE;
    END LOOP;
    
    CLOSE ALL_EMPLOYEES;
END PRINT_EMPLOYEE_ROSTER;
/
-- Question 2b
EXEC PRINT_EMPLOYEE_ROSTER;
/
-- Question 2c - ANSWER BELOW
/
-- Question 3a
CREATE OR REPLACE PROCEDURE PRINT_EMPLOYEE_ROSTER
AS
    CURSOR ALL_EMPLOYEES
    IS
        SELECT EMPLOYEEID, LASTNAME || ', ' || FIRSTNAME AS NAME
        FROM EMPLOYEE;
        
    CURRENT_EMPLOYEE ALL_EMPLOYEES%ROWTYPE;
BEGIN
    OPEN ALL_EMPLOYEES;
    FETCH ALL_EMPLOYEES INTO CURRENT_EMPLOYEE;
    WHILE ALL_EMPLOYEES%FOUND LOOP
    
        DBMS_OUTPUT.PUT (RPAD(CURRENT_EMPLOYEE.EMPLOYEEID, 15, ' '));
        DBMS_OUTPUT.PUT_LINE (CURRENT_EMPLOYEE.NAME);
        FETCH ALL_EMPLOYEES INTO CURRENT_EMPLOYEE;
    END LOOP;
    
    CLOSE ALL_EMPLOYEES;
END PRINT_EMPLOYEE_ROSTER;
/
-- Question 3b
EXEC PRINT_EMPLOYEE_ROSTER;
/
-- Question 4a
CREATE OR REPLACE PROCEDURE PRINT_EMPLOYEE_ROSTER
AS
    CURSOR ALL_EMPLOYEES
    IS
        SELECT EMPLOYEEID, LASTNAME || ', ' || FIRSTNAME AS NAME
        FROM EMPLOYEE;
        
    CURRENT_EMPLOYEE ALL_EMPLOYEES%ROWTYPE;
BEGIN
    FOR CURRENT_EMPLOYEE IN ALL_EMPLOYEES LOOP
    
        DBMS_OUTPUT.PUT (RPAD(CURRENT_EMPLOYEE.EMPLOYEEID, 15, ' '));
        DBMS_OUTPUT.PUT_LINE (CURRENT_EMPLOYEE.NAME);
    END LOOP;
END PRINT_EMPLOYEE_ROSTER;
/
-- Question 4b
EXEC PRINT_EMPLOYEE_ROSTER;

/
-- Question 4c - ANSWER BELOW
/
-- Question 5a
CREATE OR REPLACE PROCEDURE PRINT_EMPLOYEE_ROSTER
(P_JOBTITLE IN EMPLOYEE.JOBTITLE%TYPE)
AS
    CURSOR ALL_EMPLOYEES
    IS
        SELECT EMPLOYEEID, LASTNAME || ', ' || FIRSTNAME AS NAME
        FROM EMPLOYEE
        WHERE UPPER(TRIM(JOBTITLE)) = UPPER(TRIM(P_JOBTITLE));
        
BEGIN
    FOR CURRENT_EMPLOYEE IN ALL_EMPLOYEES LOOP
    
        DBMS_OUTPUT.PUT (RPAD(CURRENT_EMPLOYEE.EMPLOYEEID, 15, ' '));
        DBMS_OUTPUT.PUT_LINE (CURRENT_EMPLOYEE.NAME);
    END LOOP;
END PRINT_EMPLOYEE_ROSTER;
/
-- Question 5b
EXEC PRINT_EMPLOYEE_ROSTER('sales');
/
-- Question 5c
EXEC PRINT_EMPLOYEE_ROSTER('assembly');
/
-- Question 5d
EXEC PRINT_EMPLOYEE_ROSTER('student');
/
-- Question 6a
CREATE OR REPLACE PROCEDURE PRINT_EMPLOYEE_ROSTER
(P_JOBTITLE IN EMPLOYEE.JOBTITLE%TYPE)
AS
    CURSOR ALL_EMPLOYEES
    IS
        SELECT EMPLOYEEID, LASTNAME || ', ' || FIRSTNAME AS NAME
        FROM EMPLOYEE
        WHERE UPPER(TRIM(JOBTITLE)) = UPPER(TRIM(P_JOBTITLE));
        
BEGIN
    FOR CURRENT_EMPLOYEE IN ALL_EMPLOYEES LOOP
    
        DBMS_OUTPUT.PUT (RPAD(CURRENT_EMPLOYEE.EMPLOYEEID, 15, ' '));
        DBMS_OUTPUT.PUT_LINE (CURRENT_EMPLOYEE.NAME);
    END LOOP;
    
EXCEPTION
    
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT (SQLCODE);
        DBMS_OUTPUT.PUT (': ');
        DBMS_OUTPUT.PUT_LINE (SUBSTR(SQLERRM, 1, 100));
END PRINT_EMPLOYEE_ROSTER;
/
-- Question 6b
EXEC PRINT_EMPLOYEE_ROSTER('assembly');
/
--Question 6c - ANSWER BELOW
/ 
-- Question 7a
CREATE OR REPLACE PROCEDURE customer_roster (
    p_state IN customer.state%TYPE
) AS

    CURSOR all_customers IS
    SELECT
        companyname,
        city,
        state,
        custlastname
        || ', '
        || custfirstname AS contact_name
    FROM
        customer
    WHERE
        upper(TRIM(state)) = upper(TRIM(p_state));

    cust_roster all_customers%rowtype;
BEGIN
    OPEN all_customers;
    FETCH all_customers INTO cust_roster;
    WHILE all_customers%found LOOP
        dbms_output.put(rpad(cust_roster.companyname, 40, ' '));
        dbms_output.put(rpad(cust_roster.city, 10, ' '));
        dbms_output.put(rpad(cust_roster.state, 5, ' '));
        dbms_output.put_line(rpad(cust_roster.contact_name, 65, ' '));
        FETCH all_customers INTO cust_roster;
    END LOOP;
     CLOSE all_customers;

EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put(sqlcode);
        dbms_output.put(': ');
        dbms_output.put_line(substr(sqlerrm, 1, 100));
END customer_roster;
/
-- Question 7b

EXEC customer_roster('GA');
/
-- Question 8a
CREATE OR REPLACE PROCEDURE customer_search 
(p_name IN customer.custlastname%TYPE)
    AS
    v_name string(25) := upper(trim(p_name));
    CURSOR searching_cust 
    IS
    SELECT companyname, custfirstname, custlastname, custtitle
    FROM customer
    WHERE upper(TRIM(custlastname)) like '%'|| v_name|| '%';
    
    sc_cust searching_cust%rowtype;
BEGIN
    OPEN searching_cust;
    FETCH searching_cust INTO sc_cust;
    WHILE searching_cust%found LOOP
        dbms_output.put(rpad(sc_cust.companyname, 35, ' '));
        dbms_output.put(rpad(sc_cust.custfirstname, 20, ' '));
        dbms_output.put(rpad(sc_cust.custlastname, 15, ' '));
        dbms_output.put_line(sc_cust.custtitle);
        FETCH searching_cust INTO sc_cust;
    END LOOP;
CLOSE searching_cust;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put(sqlcode);
        dbms_output.put(': ');
        dbms_output.put_line(substr(sqlerrm, 1, 100));
END customer_search; 
/
-- Question 8b
exec customer_search ('NA');
 /
-- Question 8c
CREATE OR REPLACE PROCEDURE customer_search 
(l_name IN customer.custlastname%TYPE)
    AS
    vl_name string(25) := upper(trim(l_name));
    CURSOR searching_cust 
    IS
    SELECT companyname, custfirstname, custlastname, custtitle
    FROM customer
    WHERE upper(TRIM(custfirstname)) like '%'|| vl_name|| '%'
    or upper(TRIM(custlastname)) like '%'|| vl_name|| '%';
    
    sc_cust searching_cust%rowtype;
BEGIN
    OPEN searching_cust;
    FETCH searching_cust INTO sc_cust;
    WHILE searching_cust%found LOOP
        dbms_output.put(rpad(sc_cust.companyname, 35, ' '));
        dbms_output.put(rpad(sc_cust.custfirstname, 20, ' '));
        dbms_output.put(rpad(sc_cust.custlastname, 15, ' '));
        dbms_output.put_line(sc_cust.custtitle);
        FETCH searching_cust INTO sc_cust;
    END LOOP;
CLOSE searching_cust;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put(sqlcode);
        dbms_output.put(': ');
        dbms_output.put_line(substr(sqlerrm, 1, 100));
END customer_search; 
 /
-- Question 8d
exec customer_search ('na');
 /
-- Question 8e
CREATE OR REPLACE PROCEDURE customer_search 
(l_name IN customer.custlastname%TYPE)
    AS
    vl_name string(25) := upper(trim(l_name));

BEGIN
    for loop_cust IN 
    (SELECT companyname, custfirstname, 
    custlastname, custtitle
    FROM customer
    WHERE upper(TRIM(custfirstname)) like '%'|| vl_name|| '%'
    or upper(TRIM(custlastname)) like '%'|| vl_name|| '%')
    LOOP
        dbms_output.put(rpad(loop_cust.companyname, 35, ' '));
        dbms_output.put(rpad(loop_cust.custfirstname, 20, ' '));
        dbms_output.put(rpad(loop_cust.custlastname, 15, ' '));
        dbms_output.put_line(loop_cust.custtitle);
    END LOOP loop_cust;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put(sqlcode);
        dbms_output.put(': ');
        dbms_output.put_line(substr(sqlerrm, 1, 100));
END customer_search; 
 /
-- Question 8f
exec customer_search ('na');
 /


/* Results
-- Question 1a
Procedure PRINT_EMPLOYEE_ROSTER compiled

-- Question 1b
PL/SQL procedure successfully completed.

100001         Manaugh                       Jim
100101         Rosner                        Joanne
100103         Bush                          Rita
100104         Abbott                        Michael
100106         Eckelman                      Paul
100112         Hickman                       Steven
100120         Nairn                         Michelle
100125         Stevenson                     Gabrielle
100127         Wendling                      Jason
100200         Zobitz                        Beth
100204         Keck                          David
100206         Xolo                          Kathleen
100209         Yates                         Tina
100220         Vigus                         Todd
100330         Gustavel                      Kristen
100365         Cheswick                      Sherman
100399         Day                           Ronald
100475         Hess                          Steve
100488         Osman                         Jamie
100550         Roland                        Allison
100559         Tyrie                         Meghan
100600         Zollman                       Calie
100650         Lilley                        Edna
100700         Jones                         Charles
100880         German                        Gary
100892         Platt                         Joseph
100944         Stahley                       Ryan
100967         Albregts                      Nicholas
100989         Deagen                        Kathryn
101007         Krasner                       Jason
101030         Moore                         Kristey
101045         Ortman                        Austin
101066         Rodgers                       Laura
101088         Underwood                     Patricha
101089         Alvarez                       Melissa
101097         Brose                         Jack
101115         Cochran                       Steve
101135         Deppe                         David
101154         Hettinger                     Gregory
101166         Reece                         Phil

-- Question 2a
Procedure PRINT_EMPLOYEE_ROSTER compiled

-- Question 2b
PL/SQL procedure successfully completed.

100001         Manaugh                       Jim
100101         Rosner                        Joanne
100103         Bush                          Rita
100104         Abbott                        Michael
100106         Eckelman                      Paul
100112         Hickman                       Steven
100120         Nairn                         Michelle
100125         Stevenson                     Gabrielle
100127         Wendling                      Jason
100200         Zobitz                        Beth
100204         Keck                          David
100206         Xolo                          Kathleen
100209         Yates                         Tina
100220         Vigus                         Todd
100330         Gustavel                      Kristen
100365         Cheswick                      Sherman
100399         Day                           Ronald
100475         Hess                          Steve
100488         Osman                         Jamie
100550         Roland                        Allison
100559         Tyrie                         Meghan
100600         Zollman                       Calie
100650         Lilley                        Edna
100700         Jones                         Charles
100880         German                        Gary
100892         Platt                         Joseph
100944         Stahley                       Ryan
100967         Albregts                      Nicholas
100989         Deagen                        Kathryn
101007         Krasner                       Jason
101030         Moore                         Kristey
101045         Ortman                        Austin
101066         Rodgers                       Laura
101088         Underwood                     Patricha
101089         Alvarez                       Melissa
101097         Brose                         Jack
101115         Cochran                       Steve
101135         Deppe                         David
101154         Hettinger                     Gregory
101166         Reece                         Phil

-- Question 2c
CURRENT_EMPLOYEE is based on the row type(ROWTYPE%) of all emplyees.

-- Question 3a
Procedure PRINT_EMPLOYEE_ROSTER compiled

-- Question 3b
PL/SQL procedure successfully completed.

100001         Manaugh, Jim
100101         Rosner, Joanne
100103         Bush, Rita
100104         Abbott, Michael
100106         Eckelman, Paul
100112         Hickman, Steven
100120         Nairn, Michelle
100125         Stevenson, Gabrielle
100127         Wendling, Jason
100200         Zobitz, Beth
100204         Keck, David
100206         Xolo, Kathleen
100209         Yates, Tina
100220         Vigus, Todd
100330         Gustavel, Kristen
100365         Cheswick, Sherman
100399         Day, Ronald
100475         Hess, Steve
100488         Osman, Jamie
100550         Roland, Allison
100559         Tyrie, Meghan
100600         Zollman, Calie
100650         Lilley, Edna
100700         Jones, Charles
100880         German, Gary
100892         Platt, Joseph
100944         Stahley, Ryan
100967         Albregts, Nicholas
100989         Deagen, Kathryn
101007         Krasner, Jason
101030         Moore, Kristey
101045         Ortman, Austin
101066         Rodgers, Laura
101088         Underwood, Patricha
101089         Alvarez, Melissa
101097         Brose, Jack
101115         Cochran, Steve
101135         Deppe, David
101154         Hettinger, Gregory
101166         Reece, Phil

-- Question 4a
Procedure PRINT_EMPLOYEE_ROSTER compiled

-- Question 4b
PL/SQL procedure successfully completed.

100001         Manaugh, Jim
100101         Rosner, Joanne
100103         Bush, Rita
100104         Abbott, Michael
100106         Eckelman, Paul
100112         Hickman, Steven
100120         Nairn, Michelle
100125         Stevenson, Gabrielle
100127         Wendling, Jason
100200         Zobitz, Beth
100204         Keck, David
100206         Xolo, Kathleen
100209         Yates, Tina
100220         Vigus, Todd
100330         Gustavel, Kristen
100365         Cheswick, Sherman
100399         Day, Ronald
100475         Hess, Steve
100488         Osman, Jamie
100550         Roland, Allison
100559         Tyrie, Meghan
100600         Zollman, Calie
100650         Lilley, Edna
100700         Jones, Charles
100880         German, Gary
100892         Platt, Joseph
100944         Stahley, Ryan
100967         Albregts, Nicholas
100989         Deagen, Kathryn
101007         Krasner, Jason
101030         Moore, Kristey
101045         Ortman, Austin
101066         Rodgers, Laura
101088         Underwood, Patricha
101089         Alvarez, Melissa
101097         Brose, Jack
101115         Cochran, Steve
101135         Deppe, David
101154         Hettinger, Gregory
101166         Reece, Phil

-- Question 4c
Since there is no fetch , the prossesing steps are wuth in the FOR LOOP.
Fetch is implicit because the data is still retrieved from the FOR LOOP.

-- Question 5a
Procedure PRINT_EMPLOYEE_ROSTER compiled

-- Question 5b
PL/SQL procedure successfully completed.

100600         Zollman, Calie
101007         Krasner, Jason
101066         Rodgers, Laura

-- Question 5c
PL/SQL procedure successfully completed.

100101         Rosner, Joanne
100120         Nairn, Michelle
100204         Keck, David
100399         Day, Ronald
100475         Hess, Steve
100550         Roland, Allison
100892         Platt, Joseph
100967         Albregts, Nicholas
100989         Deagen, Kathryn
101030         Moore, Kristey
101045         Ortman, Austin
101088         Underwood, Patricha
101089         Alvarez, Melissa
101097         Brose, Jack
101115         Cochran, Steve
101135         Deppe, David
101154         Hettinger, Gregory
101166         Reece, Phil


-- Question 5d
PL/SQL procedure successfully completed.

Displayed nothing in the DBMS output tab.

-- Question 6a
Procedure PRINT_EMPLOYEE_ROSTER compiled

-- Question 6b
PL/SQL procedure successfully completed.

100101         Rosner, Joanne
100120         Nairn, Michelle
100204         Keck, David
100399         Day, Ronald
100475         Hess, Steve
100550         Roland, Allison
100892         Platt, Joseph
100967         Albregts, Nicholas
100989         Deagen, Kathryn
101030         Moore, Kristey
101045         Ortman, Austin
101088         Underwood, Patricha
101089         Alvarez, Melissa
101097         Brose, Jack
101115         Cochran, Steve
101135         Deppe, David
101154         Hettinger, Gregory
101166         Reece, Phil

--Question 6c
An exception would display a error number associated with a description that 
can be found on Oracles website. SQLERRM  returns the error message associated
with its error-number argument. SQLCODE returns the number code related to the most
recent exception thrown.
 
-- Question 7a
Procedure CUSTOMER_SEARCH compiled

CREATE OR REPLACE PROCEDURE customer_roster (
    p_state IN customer.state%TYPE
) AS

    CURSOR all_customers IS
    SELECT
        companyname,
        city,
        state,
        custlastname
        || ', '
        || custfirstname AS contact_name
    FROM
        customer
    WHERE
        upper(TRIM(state)) = upper(TRIM(p_state));

    cust_roster all_customers%rowtype;
BEGIN
    OPEN all_customers;
    FETCH all_customers INTO cust_roster;
    WHILE all_customers%found LOOP
        dbms_output.put(rpad(cust_roster.companyname, 40, ' '));
        dbms_output.put(rpad(cust_roster.city, 10, ' '));
        dbms_output.put(rpad(cust_roster.state, 5, ' '));
        dbms_output.put_line(rpad(cust_roster.contact_name, 65, ' '));
        FETCH all_customers INTO cust_roster;
    END LOOP;
     CLOSE all_customers;

EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put(sqlcode);
        dbms_output.put(': ');
        dbms_output.put_line(substr(sqlerrm, 1, 100));
END customer_roster;

-- Question 7b
EXEC customer_roster('GA');

Family Medical Center                   Adel      GA   Strong, Susan                                                    
Down Deep Drilling Inc.                 Elberton  GA   Torres, Don                                                      
Athens    GA   Thompson, Jamie                                                  
Macon     GA   Vanderhoff, Rosemary                                             
Nahunta   GA   Malady, Frank                                                    
SwainsboroGA   Osborne, Shirley                                                 

-- Question 8a
Procedure CUSTOMER_SEARCH compiled

CREATE OR REPLACE PROCEDURE customer_search 
(p_name IN customer.custlastname%TYPE)
    AS
    v_name string(25) := upper(trim(p_name));
    CURSOR searching_cust 
    IS
    SELECT companyname, custfirstname, custlastname, custtitle
    FROM customer
    WHERE upper(TRIM(custlastname)) like '%'|| v_name|| '%';
    
    sc_cust searching_cust%rowtype;
BEGIN
    OPEN searching_cust;
    FETCH searching_cust INTO sc_cust;
    WHILE searching_cust%found LOOP
        dbms_output.put(rpad(sc_cust.companyname, 35, ' '));
        dbms_output.put(rpad(sc_cust.custfirstname, 20, ' '));
        dbms_output.put(rpad(sc_cust.custlastname, 15, ' '));
        dbms_output.put_line(sc_cust.custtitle);
        FETCH searching_cust INTO sc_cust;
    END LOOP;
CLOSE searching_cust;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put(sqlcode);
        dbms_output.put(': ');
        dbms_output.put_line(substr(sqlerrm, 1, 100));
END customer_search; 

-- Question 8b
exec customer_search ('NA');

Dorlan              Bresnaham      Dr.
Jay                 Hanau          Mr.
Matt                Nakanishi      Mr.
Jim                 Manaugh        Mr.
Bobs Repair Service                Daniel              Hundnall       Mr.
Automart                           Jessica             Nakamura       Ms.


-- Question 8c
Procedure CUSTOMER_SEARCH compiled

CREATE OR REPLACE PROCEDURE customer_search 
(l_name IN customer.custlastname%TYPE)
    AS
    vl_name string(25) := upper(trim(l_name));
    CURSOR searching_cust 
    IS
    SELECT companyname, custfirstname, custlastname, custtitle
    FROM customer
    WHERE upper(TRIM(custfirstname)) like '%'|| vl_name|| '%'
    or upper(TRIM(custlastname)) like '%'|| vl_name|| '%';
    
    sc_cust searching_cust%rowtype;
BEGIN
    OPEN searching_cust;
    FETCH searching_cust INTO sc_cust;
    WHILE searching_cust%found LOOP
        dbms_output.put(rpad(sc_cust.companyname, 35, ' '));
        dbms_output.put(rpad(sc_cust.custfirstname, 20, ' '));
        dbms_output.put(rpad(sc_cust.custlastname, 15, ' '));
        dbms_output.put_line(sc_cust.custtitle);
        FETCH searching_cust INTO sc_cust;
    END LOOP;
CLOSE searching_cust;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put(sqlcode);
        dbms_output.put(': ');
        dbms_output.put_line(substr(sqlerrm, 1, 100));
END customer_search; 

-- Question 8d
exec customer_search ('na');

Dorlan              Bresnaham      Dr.
Verna               McGrew         Ms.
Christina           Wilson         Mrs.
Jay                 Hanau          Mr.
Matt                Nakanishi      Mr.
Nancy               Basham         Mrs.
Jim                 Manaugh        Mr.
Jonathon            Blanco         Mr.
Bobs Repair Service                Daniel              Hundnall       Mr.
Automart                           Jessica             Nakamura       Ms.
Anna                Mayton         Dr.
Ronald              Miller         Mr.

-- Question 8e
Procedure CUSTOMER_SEARCH compiled

CREATE OR REPLACE PROCEDURE customer_search 
(l_name IN customer.custlastname%TYPE)
    AS
    vl_name string(25) := upper(trim(l_name));

BEGIN
    for loop_cust IN 
    (SELECT companyname, custfirstname, 
    custlastname, custtitle
    FROM customer
    WHERE upper(TRIM(custfirstname)) like '%'|| vl_name|| '%'
    or upper(TRIM(custlastname)) like '%'|| vl_name|| '%')
    LOOP
        dbms_output.put(rpad(loop_cust.companyname, 35, ' '));
        dbms_output.put(rpad(loop_cust.custfirstname, 20, ' '));
        dbms_output.put(rpad(loop_cust.custlastname, 15, ' '));
        dbms_output.put_line(loop_cust.custtitle);
    END LOOP loop_cust;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put(sqlcode);
        dbms_output.put(': ');
        dbms_output.put_line(substr(sqlerrm, 1, 100));
END customer_search; 

-- Question 8f
exec customer_search ('na');

Dorlan              Bresnaham      Dr.
Verna               McGrew         Ms.
Christina           Wilson         Mrs.
Jay                 Hanau          Mr.
Matt                Nakanishi      Mr.
Nancy               Basham         Mrs.
Jim                 Manaugh        Mr.
Jonathon            Blanco         Mr.
Bobs Repair Service                Daniel              Hundnall       Mr.
Automart                           Jessica             Nakamura       Ms.
Anna                Mayton         Dr.
Ronald              Miller         Mr.


*/