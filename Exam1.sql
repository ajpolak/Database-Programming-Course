--Austin Polak
--Lab Exam

--Given Input Data
-------------------------------------------
CREATE TABLE CLASS ( 
       CLASSNO NUMBER(3) PRIMARY KEY, 
CLASSNAME  VARCHAR2(50), 
DEPT    VARCHAR2(25));

INSERT INTO CLASS VALUES (101,'Intro Civ','Hist');
INSERT INTO CLASS VALUES (201,'Med Europe','Hist');
INSERT INTO CLASS VALUES (305,'Ethics','Phil');
INSERT INTO CLASS VALUES (401,'Database Management','CNIT');
INSERT INTO CLASS VALUES (102,'Technical writing','ENGL');

------------------------------------------
CREATE TABLE STUDENT (
 	STUDNO    NUMBER(4) PRIMARY KEY,
        LASTNAME  VARCHAR2(20),
        MAJOR      VARCHAR2(9),
        ENROLLDATE DATE,
        GPA      NUMBER(7,2),
        CLASSNO   NUMBER(3));

-----------------------------------------------

INSERT INTO STUDENT VALUES (7369,'SMITH','HIST','17-DEC-1980',3.5,201);
INSERT INTO STUDENT VALUES (7499,'ALLEN','CS','20-FEB-1981',2.8,305);
INSERT INTO STUDENT VALUES (7521,'WARD','CS','22-FEB-1981',3.0,305);
INSERT INTO STUDENT VALUES (7566,'JONES','CNIT','2-APR-1981',2.5,401);
INSERT INTO STUDENT VALUES (7654,'MARTIN','CS','28-SEP-1981',3.1,305);
INSERT INTO STUDENT VALUES (7698,'BLAKE','CNIT','1-MAY-1981',3.75,305);
INSERT INTO STUDENT VALUES (7782,'CLARK','CNIT','9-JUN-1981',3.4,101);
INSERT INTO STUDENT VALUES (7788,'SCOTT','PHIL','09-DEC-1982',2.9,201);
INSERT INTO STUDENT VALUES (7839,'KING','MGN','17-NOV-1981',2.9,101);
INSERT INTO STUDENT VALUES (7844,'TURNER','CS','8-SEP-1981',2.8,305);
INSERT INTO STUDENT VALUES (7876,'ADAMS','HIST','12-JAN-1983',3.3,201);
INSERT INTO STUDENT VALUES (7900,'JAMES','HIST','3-DEC-1981',3.2,305);
INSERT INTO STUDENT VALUES (7902,'FORD','PHIL','3-DEC-1981',3.6,201);
INSERT INTO STUDENT VALUES (7934,'MILLER','HIST','23-JAN-1982',3.9,101);
/

----------------------------------------------------------

-- QUESTION 1
create or replace function ClassEnrollmentNo 
(p_CLASSNAME IN CLASS.CLASSNAME%TYPE)
return string
is
V_NUMBER_OF_STUDENTS NUMBER := 0;
BEGIN

    SELECT COUNT(*)
    INTO V_NUMBER_OF_STUDENTS
    FROM STUDENT INNER JOIN CLASS 
    ON STUDENT.CLASSNO = CLASS.CLASSNO 
    WHERE TRIM(UPPER(Classname)) = TRIM(UPPER(p_CLASSNAME));

    RETURN V_NUMBER_OF_STUDENTS;
END ClassEnrollmentNo;
/

-- EXECUTE 1
DECLARE
    COUNT_students NUMBER := 0;
BEGIN
    COUNT_students := ClassEnrollmentNo('Ethics');
    DBMS_OUTPUT.PUT_LINE('Number of Student: ' || COUNT_students);
END;
/

------------------------------------------------------

-- QUESTION 2
CREATE OR REPLACE PROCEDURE MinMaxGPA
(p_CLASSNAME IN CLASS.CLASSNAME%TYPE, maxStudentGPA OUT STUDENT.GPA%TYPE,
minStudentGPA OUT STUDENT.GPA%TYPE)
    IS
    
    BEGIN
        select MAX(STUDENT.GPA), MIN(STUDENT.GPA)
        into maxStudentGPA, minStudentGPA
        FROM STUDENT INNER JOIN CLASS
        ON STUDENT.CLASSNO = CLASS.CLASSNO
        WHERE CLASSNAME = p_CLASSNAME;
    
    END MinMaxGPA;
/

-- EXDECUTE 2
SET SERVEROUTPUT ON;
DECLARE
    V_maxStudentGPA student.GPA%type;
    V_minStudentGPA student.GPA%type;
Begin
    MinMaxGPA('Ethics', V_maxStudentGPA, V_minStudentGPA);
    dbms_output.put_line('MAX: ' || V_maxStudentGPA || ' MIN: ' ||  V_minStudentGPA);
END;
/

--------------------------------------------------

-- QUESTION 3
CREATE OR REPLACE PROCEDURE StudentWithGivenGPA 
(p_GPA IN NUMBER, p_CLASSNAME IN VARCHAR2)
IS
    V_GPA STUDENT.GPA%type;
    V_LN STUDENT.LASTNAME%type;
    counter number;

    CURSOR SS IS
    SELECT STUDENT.GPA, LASTNAME
    FROM STUDENT INNER JOIN CLASS
    ON STUDENT.CLASSNO = CLASS.CLASSNO
    WHERE GPA = p_GPA AND CLASSNAME = p_CLASSNAME;

BEGIN
    OPEN SS;
    LOOP
    FETCH SS INTO V_GPA, V_LN;
        EXIT WHEN SS%NOTFOUND;
            dbms_output.put_line(V_GPA || ' ' || V_LN);
        END LOOP;
    CLOSE SS;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        dbms_output.put_line('No such Class or GPA found');
END StudentWithGivenGPA; 
/

-- EXECUTE 3
EXECUTE StudentWithGivenGPA (3.2, 'Ethics');
/

---------------------------------------------------------

-- QUESTION 4
CREATE OR REPLACE PROCEDURE ClassEnrollmentReport (p_CLASSNAME IN VARCHAR2) 
    IS 
        LCOUNT NUMBER(2) := 0; 
        v_MAXGPA student.GPA%type;
        v_MINGPA student.GPA%type;
        v_LN student.lastname%type;
        v_LLN student.lastname%type;
        
        CURSOR SS_GPA IS
        SELECT MAX(student.GPA), MIN(student.GPA) 
        FROM STUDENT INNER JOIN CLASS
        ON STUDENT.CLASSNO = CLASS.CLASSNO
        WHERE UPPER(CLASSNAME) = UPPER(p_CLASSNAME);
        
        CURSOR MAX_LN IS
        SELECT LASTNAME
        FROM STUDENT
        WHERE GPA = (SELECT MAX(student.GPA)
        FROM STUDENT INNER JOIN CLASS
        ON STUDENT.CLASSNO = CLASS.CLASSNO
        WHERE UPPER(CLASSNAME) = UPPER(p_CLASSNAME));
        
        CURSOR MIN_LN IS 
        SELECT LASTNAME
        FROM STUDENT
        WHERE GPA = (SELECT MIN(student.GPA) 
        FROM STUDENT INNER JOIN CLASS
        ON STUDENT.CLASSNO = CLASS.CLASSNO
        WHERE UPPER(CLASSNAME) = UPPER(p_CLASSNAME));
        
    BEGIN 
        OPEN SS_GPA;
        OPEN MAX_LN;
        OPEN MIN_LN;
        FETCH SS_GPA INTO v_MAXGPA, v_MINGPA;
        FETCH MAX_LN INTO v_LN;
        FETCH MIN_LN INTO v_LLN;
        CLOSE SS_GPA;
        CLOSE MAX_LN;
        CLOSE MIN_LN;
        
       SELECT COUNT(*) 
       INTO LCOUNT
       FROM STUDENT INNER JOIN CLASS
       ON STUDENT.CLASSNO = CLASS.CLASSNO 
       WHERE UPPER(CLASSNAME) = UPPER(p_CLASSNAME); 
       DBMS_OUTPUT.PUT_LINE('Number of Students: ' || LCOUNT);
    CASE
        WHEN LCOUNT = 0 THEN 
        DBMS_OUTPUT.PUT_LINE('No students found');
        WHEN LCOUNT >= 2 THEN
        DBMS_OUTPUT.PUT_LINE('MAX: ' || v_MAXGPA || ' ' || v_LN || ' MIN: ' || v_MINGPA || ' ' || v_LLN);
        WHEN LCOUNT = 1 THEN
        DBMS_OUTPUT.PUT_LINE('One student found');
    END CASE;
END; 
/ 

-- EXECUTE 4
EXECUTE ClassEnrollmentReport ('Intro Civ');
EXECUTE ClassEnrollmentReport ('intro civ');
EXECUTE ClassEnrollmentReport ('DB1');
EXECUTE ClassEnrollmentReport ('DATABASE MANAGEMENT');
EXECUTE ClassEnrollmentReport ('Technical writing');
/

-------------------------------------------------------------------

--Question 5:
(select firstname || ' '|| lastname AS Person_of_Interest, homephone, 
    nvl(emailaddr, 'Empty email'), 'Eagle Electronics' as Employer, streetaddress 
    --streeetaddress
    from employee 
    --employees
    where jobtitle = 'Assembly' and substr(homephone,1,3) != '919') 
    --phone to homephone, 919 needs quotation marks
UNION
(select custfirstname || ' '|| custlastname AS Person_of_Interest, phone, 
    nvl(emailaddr, 'Empty email'), companyname, address 
    --nl to nvl
    from customer
    where (companyname is not null and address like '%Rd%.'  
    --Rd needs % around for LIKE
    and state in ('OH', 'IN', 'MI', 'KY', 'ND'))  
    or substr(phone,1,3) = 898 and state = 'CT'  
    and substr(phone,-1,1) != substr(fax,-1,1))




