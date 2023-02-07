-- Austin Polak

-- Question 1a
CREATE OR REPLACE PROCEDURE HELLO_WORLD
AS
    V_OUTPUT VARCHAR2(35) := 'Hello World';
BEGIN
    DBMS_OUTPUT.PUT_LINE (V_OUTPUT);
END HELLO_WORLD;

EXECUTE HELLO_WORLD;
/
-- Question 1b - Answer Below
/
-- Question 1c - Answer Below
/
-- Question 2
CREATE OR REPLACE PROCEDURE hello_world AS
    v_output VARCHAR2(35) := 'Hello World';
BEGIN
    dbms_output.put_line(v_output);
END hello_world;

EXECUTE hello_world;
/
/
-- Question 3a
CREATE OR REPLACE PROCEDURE HELLO_WORLD
(P_NAME IN VARCHAR2)
AS
    V_OUTPUT VARCHAR2(35);
BEGIN
    V_OUTPUT := 'Hello ' || P_NAME;
    DBMS_OUTPUT.PUT_LINE (V_OUTPUT);
END HELLO_WORLD;
/
-- Question 3b
DECLARE
     P_NAME VARCHAR2(35) := 'World';
BEGIN
    HELLO_WORLD (P_NAME);
END;

/
-- Question 3c
DECLARE
     P_NAME VARCHAR2(35) := 'Mark';
BEGIN
    HELLO_WORLD (P_NAME);
END;
/
-- Question 3d
DECLARE
     P_NAME VARCHAR2(35) := 'I have so much fun coding in SQL and PLSQL.';
BEGIN
    HELLO_WORLD (P_NAME);
END;

/
-- Question 3e
CREATE OR REPLACE PROCEDURE HELLO_WORLD
(P_NAME IN VARCHAR2)
AS
    V_OUTPUT VARCHAR2(50);
BEGIN
    V_OUTPUT := 'Hello ' || P_NAME;
    DBMS_OUTPUT.PUT_LINE (V_OUTPUT);
END HELLO_WORLD;

/
-- Question 3f
CREATE OR REPLACE PROCEDURE HELLO_WORLD
(P_NAME IN VARCHAR2)
AS
    V_OUTPUT VARCHAR2(50);
BEGIN
    V_OUTPUT := 'Hello ' || P_NAME;
    DBMS_OUTPUT.PUT_LINE (V_OUTPUT);
END HELLO_WORLD;

DECLARE
     P_NAME VARCHAR2(50) := 'I have so much fun coding in SQL and PLSQL.';
BEGIN
    HELLO_WORLD (P_NAME);
END;
/
-- Question 4a
CREATE OR REPLACE PROCEDURE HELLO_WORLD
(
    P_GREETING IN VARCHAR2,
    P_NAME IN VARCHAR2
)
AS
    V_OUTPUT VARCHAR2(75);
BEGIN
    V_OUTPUT := P_GREETING || ' ' || P_NAME;
    DBMS_OUTPUT.PUT_LINE (V_OUTPUT);
END HELLO_WORLD;
/
-- Question 4b
EXEC HELLO_WORLD ('Hello', 'World');

/
-- Question 4c
EXEC HELLO_WORLD ('World');
/
-- Question 4d
CREATE OR REPLACE PROCEDURE HELLO_WORLD
(
    P_GREETING IN VARCHAR2,
    P_NAME IN VARCHAR2
)
AS
    V_OUTPUT VARCHAR2(75);
BEGIN
    V_OUTPUT := P_GREETING || ' ' || P_NAME;
    DBMS_OUTPUT.PUT_LINE (V_OUTPUT);
END HELLO_WORLD;

EXEC HELLO_WORLD ('Goodbye', 'Hal');

/
-- Question 4e
EXEC HELLO_WORLD ('Hello', null);
/
-- Question 5a
CREATE OR REPLACE FUNCTION NUMBER_OF_EMPLOYEES
    RETURN NUMBER
AS
    V_NUMBER_OF_EMPLOYEES NUMBER := 0;
BEGIN
    
    SELECT COUNT(*)
        INTO V_NUMBER_OF_EMPLOYEES
    FROM EMPLOYEE;
    
    RETURN V_NUMBER_OF_EMPLOYEES;
END NUMBER_OF_EMPLOYEES;

/
-- Question 5b
SELECT NUMBER_OF_EMPLOYEES FROM DUAL;
/
-- Question 6a
CREATE OR REPLACE FUNCTION NUMBER_OF_EMPLOYEES
    (P_JOBTITLE IN VARCHAR2)
    RETURN NUMBER
AS
    V_NUMBER_OF_EMPLOYEES NUMBER := 0;
BEGIN

    SELECT COUNT(*)
        INTO V_NUMBER_OF_EMPLOYEES
    FROM EMPLOYEE
    WHERE JOBTITLE = P_JOBTITLE;
    
    RETURN V_NUMBER_OF_EMPLOYEES;
END NUMBER_OF_EMPLOYEES;
/
-- Question 6b
--SQL
SELECT COUNT(NUMBER_OF_EMPLOYEES (JOBTITLE))
FROM EMPLOYEE
WHERE JOBTITLE = 'Engineer';

--PL/SQL
DECLARE
    EAGLE_ENGINEERS NUMBER := 0;
BEGIN
    EAGLE_ENGINEERS := NUMBER_OF_EMPLOYEES('Engineer');
    DBMS_OUTPUT.PUT_LINE(EAGLE_ENGINEERS);
END;
/
-- Question 6c
CREATE OR REPLACE FUNCTION NUMBER_OF_EMPLOYEES
    (P_JOBTITLE IN EMPLOYEE.JOBTITLE%TYPE)
    RETURN NUMBER
AS
    V_NUMBER_OF_EMPLOYEES NUMBER := 0;
BEGIN

    SELECT COUNT(*)
    INTO V_NUMBER_OF_EMPLOYEES
    FROM EMPLOYEE
    WHERE TRIM(UPPER(EMPLOYEE.JOBTITLE)) LIKE TRIM(UPPER(P_JOBTITLE));
    
    RETURN V_NUMBER_OF_EMPLOYEES;
END NUMBER_OF_EMPLOYEES;

/
-- Question 6d
DECLARE
    EAGLE_ENGINEERS NUMBER := 0;
BEGIN
    EAGLE_ENGINEERS := NUMBER_OF_EMPLOYEES('Engineer   ');
    DBMS_OUTPUT.PUT_LINE(EAGLE_ENGINEERS);
END;

/
-- Question 6e
DECLARE
    EAGLE_DBA NUMBER := 0;
BEGIN
    EAGLE_DBA := NUMBER_OF_EMPLOYEES('dba');
    DBMS_OUTPUT.PUT_LINE(EAGLE_DBA);
END;
/
-- Question 6f
DECLARE
    EAGLE_DBA NUMBER := 0;
BEGIN
    EAGLE_DBA := NUMBER_OF_EMPLOYEES('DBA');
    DBMS_OUTPUT.PUT_LINE(EAGLE_DBA);
END;
/
-- Question 6g
DECLARE
    EAGLE_CSO NUMBER := 0;
BEGIN
    EAGLE_CSO := NUMBER_OF_EMPLOYEES('chief sales officer');
    DBMS_OUTPUT.PUT_LINE(EAGLE_CSO);
END;
/
-- Question 6h
DECLARE
    EAGLE_CSO NUMBER := 0;
BEGIN
    EAGLE_CSO := NUMBER_OF_EMPLOYEES('   chief sales officer   ');
    DBMS_OUTPUT.PUT_LINE(EAGLE_CSO);
END;
/
-- Question 6i
DECLARE
    EAGLE_CEO NUMBER := 0;
BEGIN
    EAGLE_CEO := NUMBER_OF_EMPLOYEES('   CEO   ');
    DBMS_OUTPUT.PUT_LINE(EAGLE_CEO);
END;

/
-- Question 7a
CREATE OR REPLACE PROCEDURE SIMPLE_LOOP_EXAMPLE
AS
    LCOUNTER NUMBER;
    V_CURRENT_DATE NUMBER;
BEGIN
    V_CURRENT_DATE := TO_NUMBER(TO_CHAR(SYSDATE, 'DD'));
    
    LCOUNTER := 1;
    LOOP
        DBMS_OUTPUT.PUT_LINE (LCOUNTER);
        IF LCOUNTER>= V_CURRENT_DATE THEN
            EXIT;
        ELSE  
            LCOUNTER := LCOUNTER + 1;
        END IF;
    END LOOP;
    
END SIMPLE_LOOP_EXAMPLE;
/
-- Question 7b
EXEC SIMPLE_LOOP_EXAMPLE;
/
-- Question 7c - Answer Below
/
-- Question 7d - Answer Below
/
-- Question 7e
CREATE OR REPLACE PROCEDURE SIMPLE_LOOP_EXAMPLE
AS
    LCOUNTER NUMBER;
    V_CURRENT_DATE NUMBER;
BEGIN
    V_CURRENT_DATE := TO_NUMBER(TO_CHAR(SYSDATE, 'DD'));
    
    LCOUNTER := 1;
    LOOP
         
        DBMS_OUTPUT.PUT_LINE (LCOUNTER);
        LCOUNTER := LCOUNTER + 1;
        EXIT WHEN LCOUNTER>= V_CURRENT_DATE;
        
    END LOOP;
    
END SIMPLE_LOOP_EXAMPLE;

EXEC SIMPLE_LOOP_EXAMPLE;

/
-- Question 8a
CREATE OR REPLACE PROCEDURE WHILE_LOOP_EXAMPLE
AS 
    LCOUNTER NUMBER := 1;
    V_CURRENT_DATE NUMBER := TO_NUMBER(TO_CHAR(SYSDATE, 'DD'));
BEGIN
    WHILE (LCOUNTER <= 32)
    LOOP
     DBMS_OUTPUT.PUT_LINE (LCOUNTER);
        LCOUNTER := LCOUNTER + 1;
        EXIT WHEN LCOUNTER>= V_CURRENT_DATE;
        
    END LOOP;
    
END WHILE_LOOP_EXAMPLE;

EXEC WHILE_LOOP_EXAMPLE;
        
/
-- Question 8b
CREATE OR REPLACE PROCEDURE WHILE_LOOP_EXAMPLE
AS 
    LCOUNTER NUMBER := 1;
    V_CURRENT_DATE NUMBER := TO_NUMBER(TO_CHAR(SYSDATE, 'DD'));
BEGIN
    WHILE (LCOUNTER <= 32)
    LOOP
     DBMS_OUTPUT.PUT_LINE (LCOUNTER);
        LCOUNTER := LCOUNTER + 1;
        EXIT WHEN LCOUNTER>= V_CURRENT_DATE;
        
    END LOOP;
    
END WHILE_LOOP_EXAMPLE;

EXEC WHILE_LOOP_EXAMPLE;
        
/

-- Question 9a
CREATE OR REPLACE PROCEDURE FOR_LOOP_EXAMPLE
AS
    LCOUNTER NUMBER;
    V_CURRENT_DATE NUMBER := TO_NUMBER(TO_CHAR(SYSDATE, 'DD'));
BEGIN
         FOR LCOUNTER IN 1..v_CURRENT_DATE
         LOOP
        DBMS_OUTPUT.PUT_LINE (LCOUNTER);
       EXIT WHEN LCOUNTER>= V_CURRENT_DATE;
       END LOOP;
    
END FOR_LOOP_EXAMPLE;

EXEC FOR_LOOP_EXAMPLE;
/
-- Question 9b
CREATE OR REPLACE PROCEDURE FOR_LOOP_EXAMPLE
AS
    LCOUNTER NUMBER;
    V_CURRENT_DATE NUMBER := TO_NUMBER(TO_CHAR(SYSDATE, 'DD'));
BEGIN
         FOR LCOUNTER IN 1..v_CURRENT_DATE
         LOOP
        DBMS_OUTPUT.PUT_LINE (LCOUNTER);
       EXIT WHEN LCOUNTER>= V_CURRENT_DATE;
       END LOOP;
    
END FOR_LOOP_EXAMPLE;

EXEC FOR_LOOP_EXAMPLE;
/
-- Question 10a
CREATE OR REPLACE FUNCTION DAYS_AWAY 
(D_AWAY IN DATE)
RETURN NUMBER
IS
    COUNTER NUMBER;
    V_CURRENT_DATE NUMBER;
    R_DATE NUMBER;
BEGIN
    V_CURRENT_DATE := TO_NUMBER(TO_CHAR(SYSDATE, 'DD'));
    R_DATE := TO_NUMBER(TO_CHAR(D_AWAY, 'DD'));
    COUNTER := R_DATE - V_CURRENT_DATE;
    RETURN COUNTER;
    DBMS_OUTPUT.PUT_LINE (COUNTER);
END DAYS_AWAY;
/
-- Question 10b
DECLARE
    DAYS NUMBER := 0;
BEGIN
    DAYS := DAYS_AWAY('22-SEP-2021');
    DBMS_OUTPUT.PUT_LINE('The difference in days is ' || DAYS);
END;
/
-- Question 11a
CREATE OR REPLACE PROCEDURE DAYS_OF_THE_WEEK (dat_date DATE)
AS 
    V_CURRENT_DATE NUMBER;
    V_DATE VARCHAR2(100);
BEGIN
     V_CURRENT_DATE := TO_CHAR(dat_date, 'D');
     IF V_CURRENT_DATE = 1 THEN
        V_DATE := 'Sunday';
    ELSIF V_CURRENT_DATE = 2 THEN
        V_DATE := 'Monday';
    ELSIF V_CURRENT_DATE = 3 THEN
        V_DATE := 'Tuesday';
    ELSIF V_CURRENT_DATE = 4 THEN
        V_DATE := 'Wednesday';
    ELSIF V_CURRENT_DATE = 5 THEN
        V_DATE := 'Thursday';
    ELSIF V_CURRENT_DATE = 6 THEN
        V_DATE := 'Friday';
    ELSE
        V_DATE := 'Saturday';
    END IF;
    DBMS_OUTPUT.PUT_LINE (V_DATE);
END DAYS_OF_THE_WEEK;
/
-- Question 11b
EXEC DAYS_OF_THE_WEEK ('28-AUG-2021');
/

/* Results:
-- Question 1a
Procedure HELLO_WORLD compiled

Printed to the script output

-- Question 1b
EXECUTE HELLO_WORLD;

Hello World


PL/SQL procedure successfully completed.

-- Question 1c
Anonymous blocks are not stored in your DB, whereas named block are stored as an object.
Named blocks can be called from either type of blocks.

-- Question 2
When you FORMAT the code, it changed all my upper caps to lower case.

-- Question 3a
Procedure HELLO_WORLD compiled

-- Question 3b
DECLARE
     P_NAME VARCHAR2(35);
BEGIN
    HELLO_WORLD (P_NAME);
    DBMS_OUTPUT.PUT_LINE (P_NAME);
END;

Hello World

PL/SQL procedure successfully completed.

-- Question 3c
Hello Mark


PL/SQL procedure successfully completed.

-- Question 3d
Error starting at line : 46 in command -
DECLARE
     P_NAME VARCHAR2(35) := 'I have so much fun coding in SQL and PLSQL.';
BEGIN
    HELLO_WORLD (P_NAME);
END;
Error report -
ORA-06502: PL/SQL: numeric or value error: character string buffer too small
ORA-06512: at line 2
06502. 00000 -  "PL/SQL: numeric or value error%s"
*Cause:    An arithmetic, numeric, string, conversion, or constraint error
           occurred. For example, this error occurs if an attempt is made to
           assign the value NULL to a variable declared NOT NULL, or if an
           attempt is made to assign an integer larger than 99 to a variable
           declared NUMBER(2).
*Action:   Change the data, how it is manipulated, or how it is declared so
           that values do not violate constraints.


-- Question 3e
CREATE OR REPLACE PROCEDURE HELLO_WORLD
(P_NAME IN VARCHAR2)
AS
    V_OUTPUT VARCHAR2(50);
BEGIN
    V_OUTPUT := 'Hello ' || P_NAME;
    DBMS_OUTPUT.PUT_LINE (V_OUTPUT);
END HELLO_WORLD;

Expanded the amount of characters the parameter is allowed.

-- Question 3f
Procedure HELLO_WORLD compiled

Hello I have so much fun coding in SQL and PLSQL.


PL/SQL procedure successfully completed.

-- Question 4a
Procedure HELLO_WORLD compiled


-- Question 4b
EXEC HELLO_WORLD ('Hello', 'World');

Hello World


PL/SQL procedure successfully completed.

-- Question 4c
Error starting at line : 105 in command -
BEGIN HELLO_WORLD ('World'); END;
Error report -
ORA-06550: line 1, column 59:
PLS-00306: wrong number or types of arguments in call to 'HELLO_WORLD'
ORA-06550: line 1, column 59:
PL/SQL: Statement ignored
06550. 00000 -  "line %s, column %s:\n%s"
*Cause:    Usually a PL/SQL compilation error.
*Action:

The code is missing the other parameter to fully run and complete.
Wrong number of argument error.

-- Question 4d
EXEC HELLO_WORLD ('Goodbye', 'Hal');

Goodbye Hal


-- Question 4e
EXEC HELLO_WORLD ('Hello', null);

Hello 

-- Question 5a
Function NUMBER_OF_EMPLOYEES compiled

-- Question 5B
Function NUMBER_OF_EMPLOYEES compiled


NUMBER_OF_EMPLOYEES
-------------------
                 40


-- Question 6a
Function NUMBER_OF_EMPLOYEES compiled

-- Question 6b
SELECT COUNT(NUMBER_OF_EMPLOYEES (JOBTITLE))
FROM EMPLOYEE
WHERE JOBTITLE = 'Engineer';

COUNT(NUMBER_OF_EMPLOYEES(JOBTITLE))
------------------------------------
                                   5

-- Question 6c
Function NUMBER_OF_EMPLOYEES compiled


-- Question 6d
5

-- Question 6e
1

-- Question 6f
1

-- Question 6g
1

-- Question 6h
1

-- Question 6i
0

-- Question 7a
Procedure SIMPLE_LOOP_EXAMPLE compiled

-- Question 7b
EXEC SIMPLE_LOOP_EXAMPLE;

1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22


PL/SQL procedure successfully completed.

-- Question 7c
The simple loop prints the current month days, starting at the beginning day of the month.
Then adds one to the date till it reachs the current date, which is the 22nd.

-- Question 7d
The exit strategy is used by exiting after getting the lowest day of the current month.
Then the lowest day is add by one. The loop will keep going till you recieve the current date(day).
IF THEN ELSE EXIT STRATEGY
-- Question 7e
Procedure SIMPLE_LOOP_EXAMPLE compiled


PL/SQL procedure successfully completed.

1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22



-- Question 8a
CREATE OR REPLACE PROCEDURE WHILE_LOOP_EXAMPLE
AS 
    LCOUNTER NUMBER := 1;
    V_CURRENT_DATE NUMBER := TO_NUMBER(TO_CHAR(SYSDATE, 'DD'));
BEGIN
    WHILE (LCOUNTER <= 32)
    LOOP
     DBMS_OUTPUT.PUT_LINE (LCOUNTER);
        LCOUNTER := LCOUNTER + 1;
        EXIT WHEN LCOUNTER>= V_CURRENT_DATE;
        
    END LOOP;
    
END WHILE_LOOP_EXAMPLE;

The first condition is tested, if the condition is true the statement gets executed
and if the condition is false the control will move out of the while loop.

-- Question 8b

PL/SQL procedure successfully completed.

1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23

-- Question 9a
CREATE OR REPLACE PROCEDURE FOR_LOOP_EXAMPLE
AS
    LCOUNTER NUMBER;
    V_CURRENT_DATE NUMBER := TO_NUMBER(TO_CHAR(SYSDATE, 'DD'));
BEGIN
         FOR LCOUNTER IN 1..v_CURRENT_DATE
         LOOP
        DBMS_OUTPUT.PUT_LINE (LCOUNTER);
       EXIT WHEN LCOUNTER>= V_CURRENT_DATE;
       END LOOP;
    
END FOR_LOOP_EXAMPLE;

EXEC FOR_LOOP_EXAMPLE;



-- Question 9b

Procedure FOR_LOOP_EXAMPLE compiled


PL/SQL procedure successfully completed.

1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24

-- Question 10a
Function DAYS_AWAY compiled

-- Question 10b
PL/SQL procedure successfully completed.

The difference in days is -6
-- Question 11a
CREATE OR REPLACE PROCEDURE DAYS_OF_THE_WEEK (dat_date DATE)
AS 
    V_CURRENT_DATE NUMBER;
    V_DATE VARCHAR2(100);
BEGIN
     V_CURRENT_DATE := TO_CHAR(dat_date, 'D');
     IF V_CURRENT_DATE = 1 THEN
        V_DATE := 'Sunday';
    ELSIF V_CURRENT_DATE = 2 THEN
        V_DATE := 'Monday';
    ELSIF V_CURRENT_DATE = 3 THEN
        V_DATE := 'Tuesday';
    ELSIF V_CURRENT_DATE = 4 THEN
        V_DATE := 'Wednesday';
    ELSIF V_CURRENT_DATE = 5 THEN
        V_DATE := 'Thursday';
    ELSIF V_CURRENT_DATE = 6 THEN
        V_DATE := 'Friday';
    ELSE
        V_DATE := 'Saturday';
    END IF;
    DBMS_OUTPUT.PUT_LINE (V_DATE);
END DAYS_OF_THE_WEEK;

Procedure DAYS_OF_THE_WEEK compiled

-- Question 11b
EXEC DAYS_OF_THE_WEEK ('28-AUG-2021');


PL/SQL procedure successfully completed.

Saturday

*/