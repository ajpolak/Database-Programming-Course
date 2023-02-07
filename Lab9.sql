--Austin Polak
--Lab 9

-- Question 1
drop table lab9_employee;
--1A
CREATE TABLE LAB9_EMPLOYEE 
AS
SELECT *
FROM EMPLOYEE;
/

-- 1B
CREATE OR REPLACE TRIGGER TBDS_LAB9_EMPLOYEE
    BEFORE DELETE ON LAB9_EMPLOYEE
BEGIN
    DBMS_OUTPUT.PUT_LINE ('Trigger fired before deleting anything from LAB9_EMPLOYEE');
END;
/

-- 1C
CREATE OR REPLACE TRIGGER TBDR_LAB9_EMPLOYEE
    BEFORE DELETE ON LAB9_EMPLOYEE
    FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE ('Trigger fired before deleting a row from LAB9_EMPLOYEE');
END;
/

-- 1D
CREATE OR REPLACE TRIGGER TADS_LAB9_EMPLOYEE
    AFTER DELETE ON LAB9_EMPLOYEE
BEGIN
    DBMS_OUTPUT.PUT_LINE ('Trigger fired AFTER deleting anything from LAB9_EMPLOYEE');
END;
/

-- 1E
CREATE OR REPLACE TRIGGER TADR_LAB9_EMPLOYEE
    AFTER DELETE ON LAB9_EMPLOYEE
    FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE ('Trigger fired AFTER deleting a row from LAB9_EMPLOYEE');
END;
/

-- 1F
DELETE 
FROM LAB9_EMPLOYEE
WHERE EMPLOYEEID = '101135';
/

-- 1G
ROLLBACK;
/

SELECT *
FROM LAB9_EMPLOYEE
WHERE EMPLOYEEID = '101135';
/

-- 1H
DELETE
FROM LAB9_EMPLOYEE
WHERE JOBTITLE = 'Sales';
/

-- 1I
ROLLBACK;
/

SELECT *
FROM LAB9_EMPLOYEE
WHERE JOBTITLE = 'Sales';
/

-- 1J
TRUNCATE TABLE LAB9_EMPLOYEE;
/

SELECT *
FROM LAB9_EMPLOYEE;
/

-- Question 2
-- 2A
CREATE OR REPLACE TRIGGER TBDI_LAB9_EMPLOYEE
    BEFORE INSERT ON LAB9_EMPLOYEE
BEGIN
    DBMS_OUTPUT.PUT_LINE ('Trigger fired before inserting anything from LAB9_EMPLOYEE');
END;
/

CREATE OR REPLACE TRIGGER TBDIFER_LAB9_EMPLOYEE
    BEFORE INSERT ON LAB9_EMPLOYEE
    FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE ('Trigger fired before inserting a ROW from LAB9_EMPLOYEE');
END;
/

CREATE OR REPLACE TRIGGER TADI_LAB9_EMPLOYEE
    AFTER INSERT ON LAB9_EMPLOYEE
BEGIN
    DBMS_OUTPUT.PUT_LINE ('Trigger fired after inserting anything from LAB9_EMPLOYEE');
END;
/

CREATE OR REPLACE TRIGGER TADIFER_LAB9_EMPLOYEE
    AFTER INSERT ON LAB9_EMPLOYEE
    FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE ('Trigger fired after inserting a ROW from LAB9_EMPLOYEE');
END;
/

-- 2B
INSERT INTO LAB9_EMPLOYEE (EMPLOYEEID, LASTNAME, FIRSTNAME, JOBTITLE)
VALUES ('100002', 'Freeman', 'Rallo', 'Assembly');
/

DELETE 
FROM LAB9_EMPLOYEE
WHERE EMPLOYEEID = '100002';
/

-- 2C
INSERT INTO LAB9_EMPLOYEE (EMPLOYEEID, LASTNAME, FIRSTNAME, JOBTITLE)
VALUES ('100002', 'Freeman', 'Rallo', 'Assembly');
/

DELETE 
FROM LAB9_EMPLOYEE
WHERE EMPLOYEEID = '100002';
/

-- 2D ANSWER BELOW
/
-- 2E
INSERT INTO LAB9_EMPLOYEE (EMPLOYEEID, LASTNAME, FIRSTNAME, JOBTITLE)
VALUES ('100002', 'Freeman', 'Rallo', 'Assembly');
INSERT INTO LAB9_EMPLOYEE (EMPLOYEEID, LASTNAME, FIRSTNAME, JOBTITLE)
VALUES ('100003', 'Bonnie', 'Chimichanga', 'Assembly');
INSERT INTO LAB9_EMPLOYEE (EMPLOYEEID, LASTNAME, FIRSTNAME, JOBTITLE)
VALUES ('100004', 'Goosey', 'Razoredge', 'Assembly');
INSERT INTO LAB9_EMPLOYEE (EMPLOYEEID, LASTNAME, FIRSTNAME, JOBTITLE)
VALUES ('100005', 'Haasey', 'Tanny', 'Assembly');
INSERT INTO LAB9_EMPLOYEE (EMPLOYEEID, LASTNAME, FIRSTNAME, JOBTITLE)
VALUES ('100006', 'Balanete', 'Yolanda', 'Assembly');
INSERT INTO LAB9_EMPLOYEE (EMPLOYEEID, LASTNAME, FIRSTNAME, JOBTITLE)
VALUES ('100007', 'Foorevet', 'Lanny', 'Assembly');
INSERT INTO LAB9_EMPLOYEE (EMPLOYEEID, LASTNAME, FIRSTNAME, JOBTITLE)
VALUES ('100008', 'Frado', 'Bonnie', 'Assembly');
INSERT INTO LAB9_EMPLOYEE (EMPLOYEEID, LASTNAME, FIRSTNAME, JOBTITLE)
VALUES ('100009', 'Zombonztoe', 'Ronnie', 'Assembly');
INSERT INTO LAB9_EMPLOYEE (EMPLOYEEID, LASTNAME, FIRSTNAME, JOBTITLE)
VALUES ('100010', 'Valasquez', 'Kodie', 'Assembly');
INSERT INTO LAB9_EMPLOYEE (EMPLOYEEID, LASTNAME, FIRSTNAME, JOBTITLE)
VALUES ('100011', 'Ramonunce', 'Bablo', 'Assembly');

INSERT INTO LAB9_EMPLOYEE (EMPLOYEEID, LASTNAME, FIRSTNAME, JOBTITLE)
VALUES ('100012', 'Freema', 'Rall', 'Assembly');
INSERT INTO LAB9_EMPLOYEE (EMPLOYEEID, LASTNAME, FIRSTNAME, JOBTITLE)
VALUES ('100013', 'Bonni', 'Chimichang', 'Assembly');
INSERT INTO LAB9_EMPLOYEE (EMPLOYEEID, LASTNAME, FIRSTNAME, JOBTITLE)
VALUES ('100014', 'Goose', 'Razoredg', 'Assembly');
INSERT INTO LAB9_EMPLOYEE (EMPLOYEEID, LASTNAME, FIRSTNAME, JOBTITLE)
VALUES ('100015', 'Haase', 'Tann', 'Assembly');
INSERT INTO LAB9_EMPLOYEE (EMPLOYEEID, LASTNAME, FIRSTNAME, JOBTITLE)
VALUES ('100016', 'Balanet', 'Yoland', 'Assembly');
INSERT INTO LAB9_EMPLOYEE (EMPLOYEEID, LASTNAME, FIRSTNAME, JOBTITLE)
VALUES ('100017', 'Fooreve', 'Lann', 'Assembly');
INSERT INTO LAB9_EMPLOYEE (EMPLOYEEID, LASTNAME, FIRSTNAME, JOBTITLE)
VALUES ('100018', 'Frad', 'Bonni', 'Assembly');
INSERT INTO LAB9_EMPLOYEE (EMPLOYEEID, LASTNAME, FIRSTNAME, JOBTITLE)
VALUES ('100019', 'Zombonzto', 'Ronni', 'Assembly');
INSERT INTO LAB9_EMPLOYEE (EMPLOYEEID, LASTNAME, FIRSTNAME, JOBTITLE)
VALUES ('100020', 'Valasque', 'Kodi', 'Assembly');
INSERT INTO LAB9_EMPLOYEE (EMPLOYEEID, LASTNAME, FIRSTNAME, JOBTITLE)
VALUES ('100021', 'Ramonunc', 'Babl', 'Assembly');

INSERT INTO LAB9_EMPLOYEE (EMPLOYEEID, LASTNAME, FIRSTNAME, JOBTITLE)
VALUES ('100022', 'Freem', 'Ral', 'Assembly');
INSERT INTO LAB9_EMPLOYEE (EMPLOYEEID, LASTNAME, FIRSTNAME, JOBTITLE)
VALUES ('100023', 'Bonn', 'Chimichan', 'Assembly');
INSERT INTO LAB9_EMPLOYEE (EMPLOYEEID, LASTNAME, FIRSTNAME, JOBTITLE)
VALUES ('100024', 'Goos', 'Razored', 'Assembly');
INSERT INTO LAB9_EMPLOYEE (EMPLOYEEID, LASTNAME, FIRSTNAME, JOBTITLE)
VALUES ('100025', 'Haas', 'Tan', 'Assembly');
INSERT INTO LAB9_EMPLOYEE (EMPLOYEEID, LASTNAME, FIRSTNAME, JOBTITLE)
VALUES ('100026', 'Balane', 'Yolan', 'Assembly');
INSERT INTO LAB9_EMPLOYEE (EMPLOYEEID, LASTNAME, FIRSTNAME, JOBTITLE)
VALUES ('100027', 'Foorev', 'Lan', 'Assembly');
INSERT INTO LAB9_EMPLOYEE (EMPLOYEEID, LASTNAME, FIRSTNAME, JOBTITLE)
VALUES ('100028', 'Fra', 'Bonn', 'Assembly');
INSERT INTO LAB9_EMPLOYEE (EMPLOYEEID, LASTNAME, FIRSTNAME, JOBTITLE)
VALUES ('100029', 'Zombonzt', 'Ronn', 'Assembly');
INSERT INTO LAB9_EMPLOYEE (EMPLOYEEID, LASTNAME, FIRSTNAME, JOBTITLE)
VALUES ('100030', 'Valasqu', 'Kod', 'Assembly');
INSERT INTO LAB9_EMPLOYEE (EMPLOYEEID, LASTNAME, FIRSTNAME, JOBTITLE)
VALUES ('100031', 'Ramonun', 'Bab', 'Assembly');

INSERT INTO LAB9_EMPLOYEE (EMPLOYEEID, LASTNAME, FIRSTNAME, JOBTITLE)
VALUES ('100032', 'Free', 'Ra', 'Assembly');
INSERT INTO LAB9_EMPLOYEE (EMPLOYEEID, LASTNAME, FIRSTNAME, JOBTITLE)
VALUES ('100033', 'Bon', 'Chimicha', 'Assembly');
INSERT INTO LAB9_EMPLOYEE (EMPLOYEEID, LASTNAME, FIRSTNAME, JOBTITLE)
VALUES ('100034', 'Goo', 'Razore', 'Assembly');
INSERT INTO LAB9_EMPLOYEE (EMPLOYEEID, LASTNAME, FIRSTNAME, JOBTITLE)
VALUES ('100035', 'Haa', 'Ta', 'Assembly');
INSERT INTO LAB9_EMPLOYEE (EMPLOYEEID, LASTNAME, FIRSTNAME, JOBTITLE)
VALUES ('100036', 'Balan', 'Yola', 'Assembly');
INSERT INTO LAB9_EMPLOYEE (EMPLOYEEID, LASTNAME, FIRSTNAME, JOBTITLE)
VALUES ('100037', 'Foore', 'La', 'Assembly');
INSERT INTO LAB9_EMPLOYEE (EMPLOYEEID, LASTNAME, FIRSTNAME, JOBTITLE)
VALUES ('100038', 'Fr', 'Bon', 'Assembly');
INSERT INTO LAB9_EMPLOYEE (EMPLOYEEID, LASTNAME, FIRSTNAME, JOBTITLE)
VALUES ('100039', 'Zombonz', 'Ron', 'Assembly');
INSERT INTO LAB9_EMPLOYEE (EMPLOYEEID, LASTNAME, FIRSTNAME, JOBTITLE)
VALUES ('100040', 'Valasq', 'Ko', 'Assembly');
INSERT INTO LAB9_EMPLOYEE (EMPLOYEEID, LASTNAME, FIRSTNAME, JOBTITLE)
VALUES ('100041', 'Ramonu', 'Ba', 'Assembly');
-- Question 3
-- 3A
create or replace trigger RESTRICT_UPDATE
    before 
    update of emailaddr on LAB9_EMPLOYEE
    for each row
    
    begin
        case
            when ((substr(:new.emailaddr, -4)) != '.com') then
        RAISE_APPLICATION_ERROR(-20000, 'Invalid Email Address');
    end case;
end;
/
/*CREATE OR REPLACE TRIGGER RESTRICT_UPDATE 
    BEFORE 
    UPDATE ON LAB9_EMPLOYEE
    FOR EACH ROW
    WHEN (NEW.EMAILADDR LIKE '%.com%')
BEGIN
    CASE
        WHEN NEW.EMAILADDR NOT like '%.com%' THEN
      raise_application_error(-20111,'EMAIL ADDRESS missing ending portion');
    END;
END;*/
/

-- 3B
update LAB9_EMPLOYEE
set emailaddr = 'joeeagle@yahoo'
where employeeid = '100001';

update LAB9_EMPLOYEE
set emailaddr = 'joeeagle@yahoo.com'
where employeeid = '100001';

-- 3C
create or replace trigger RESTRICT_UPDATE
    before 
    update of emailaddr on LAB9_EMPLOYEE
    for each row

    begin
        if ((substr(:new.emailaddr, -4)) != '.com') then
        RAISE_APPLICATION_ERROR(-20000, 'Invalid Email Address');
    end if;
end;
/
/*CREATE OR REPLACE TRIGGER RESTRICT_UPDATE 
    BEFORE 
    UPDATE ON LAB9_EMPLOYEE
    FOR EACH ROW
    WHEN (NEW.EMAILADDR LIKE '%.com%')
declare
    EA_id     LAB9_EMPLOYEE.EMAILADDR%TYPe;
BEGIN
    IF EA_id not like '%.com%' THEN
      raise_application_error(-20111,'EMAIL ADDRESS missing ending portion');
    END IF;
END;*/
-- 3D
update LAB9_EMPLOYEE
set emailaddr = 'joeeagle@yahoo'
where employeeid = '100001';

update LAB9_EMPLOYEE
set emailaddr = 'joeeagle@yahoo.com'
where employeeid = '100001';

-- Question 4
DROP TABLE LAB9_EMPLOYEE CASCADE CONSTRAINTS;
/

/* Results
-- 1A
Table LAB9_EMPLOYEE created.

-- 1B
Trigger TBDS_LAB9_EMPLOYEE compiled

The object is DELETE and the trigger is going to fire BEFORE the data is deleted.
The timing would be before the data is deleted. 

-- 1C
Trigger TBDR_LAB9_EMPLOYEE compiled

The object is DELETE and the trigger is going to fire BEFORE the data is deleted.
The timing would be before the data is deleted. 
The FOR EACH ROW will fire the trigger on every row that is affected.

-- 1D
Trigger TADS_LAB9_EMPLOYEE compiled

The object is DELETE and the trigger is going to fire AFTER the data is deleted.
The timing would be after the data is deleted. 

-- 1E
Trigger TADR_LAB9_EMPLOYEE compiled

The object is DELETE and the trigger is going to fire AFTER the data is deleted.
The timing would be after the data is deleted. 
The FOR EACH ROW will fire the trigger to all the rows affected or once for the whole trigger.

-- 1F
1 rows deleted.

Trigger fired before deleting anything from LAB9_EMPLOYEE
Trigger fired before deleting a row from LAB9_EMPLOYEE
Trigger fired AFTER deleting a row from LAB9_EMPLOYEE
Trigger fired AFTER deleting anything from LAB9_EMPLOYEE

All four triggers fired, only one time per trigger.
The sequence of the triggers firing, BEFORE will alwasy be first.
Then is will fire the BEFORE that specifies the rows.
The AFTER is in reverse order. It will fire the trigger that specifies the row. 
Then fire the AFTER that only involves that table.

-- 1G
Rollback complete.

EMPLOYEEID LASTNAME             FIRSTNAME       JOBTITLE                            STREETADDRESS                            CITY                 ST POSTALCODE HOMEPHONE    S HIREDATE  RELEASEDA TYPE       TEMPSERVIC LOCKER BIRTHDATE STAMPN SUPERVISOR EMAILADDR                                          SALARYWAGE
---------- -------------------- --------------- ----------------------------------- ---------------------------------------- -------------------- -- ---------- ------------ - --------- --------- ---------- ---------- ------ --------- ------ ---------- -------------------------------------------------- ----------
101135     Deppe                David           Assembly                            8403 Anderson Rd.                        Garyville            FL 33605      919-747-5155 Y 06-MAR-10           Permanent             216    04-MAR-84 007    100944                                                             11.65

-- 1H
3 rows deleted.

Trigger fired before deleting anything from LAB9_EMPLOYEE
Trigger fired before deleting a row from LAB9_EMPLOYEE
Trigger fired AFTER deleting a row from LAB9_EMPLOYEE
Trigger fired before deleting a row from LAB9_EMPLOYEE
Trigger fired AFTER deleting a row from LAB9_EMPLOYEE
Trigger fired before deleting a row from LAB9_EMPLOYEE
Trigger fired AFTER deleting a row from LAB9_EMPLOYEE
Trigger fired AFTER deleting anything from LAB9_EMPLOYEE

All four triggers fired. The BEFORE and AFTER trigger that specifies the table is fired once.
The BEFORE and AFTER trigger that specifies the table and row fires 3 times each.
The sequence of the triggers firing, BEFORE that specifies the table will always be first.
Then it will fire the BEFORE that specifies the rows.
The AFTER is in reverse order. It will fire the trigger that specifies the row.
The BEFORE and AFTER trigger that specifies the table and row will alternate firing for 3 times each.
Lastly, the AFTER trigger that only involves the table will fire.

-- 1I
Rollback complete.


EMPLOYEEID LASTNAME             FIRSTNAME       JOBTITLE                            STREETADDRESS                            CITY                 ST POSTALCODE HOMEPHONE    S HIREDATE  RELEASEDA TYPE       TEMPSERVIC LOCKER BIRTHDATE STAMPN SUPERVISOR EMAILADDR                                          SALARYWAGE
---------- -------------------- --------------- ----------------------------------- ---------------------------------------- -------------------- -- ---------- ------------ - --------- --------- ---------- ---------- ------ --------- ------ ---------- -------------------------------------------------- ----------
100600     Zollman              Calie           Sales                               8304 Harney Rd.                          Stampton             FL 33601      929-763-2047   04-APR-09           Permanent                    20-MAR-87        100880                                                             17.35
101007     Krasner              Jason           Sales                               1846 W. Sigh Ave.                        Grand                FL 33606      919-774-7920   06-MAR-09           Permanent                    08-JUL-63        100880                                                             12.75
101066     Rodgers              Laura           Sales                               4677 Bayshore Blvd.                      Stampton             FL 33601      929-763-0691   05-MAY-09           Permanent                    02-MAR-70        100880                                                              12.6

The data is restored and it was what I expected.

-- 1J
Table LAB9_EMPLOYEE truncated.

no rows selected

None of the triggers fired.

-- Question 2
-- 2A

Trigger TBDI_LAB9_EMPLOYEE compiled

Trigger TBDIFER_LAB9_EMPLOYEE compiled

Trigger TADI_LAB9_EMPLOYEE compiled

Trigger TADIFER_LAB9_EMPLOYEE compiled

-- 2B
1 row inserted.

Trigger fired before inserting anything from LAB9_EMPLOYEE
Trigger fired before inserting a ROW from LAB9_EMPLOYEE
Trigger fired after inserting a ROW from LAB9_EMPLOYEE
Trigger fired after inserting anything from LAB9_EMPLOYEE

All four triggers fired, only one time per trigger.
The sequence of the triggers firing, BEFORE will alwasy be first.
Then is will fire the BEFORE that specifies the rows.
The AFTER is in reverse order. It will fire the trigger that specifies the row. 
Then fire the AFTER that only involves that table.

-- 2C
1 row inserted.

Trigger fired before inserting anything from LAB9_EMPLOYEE
Trigger fired before inserting a ROW from LAB9_EMPLOYEE
Trigger fired after inserting a ROW from LAB9_EMPLOYEE
Trigger fired after inserting anything from LAB9_EMPLOYEE

Hypothesis was correct.

-- 2D
For the triggers that only involve the table it will fire once. (2 triggers fired)
For the triggers that specify the table and row, each trigger will fire per rows inserted.
A total of 40 times per trigger will fire so a final total of 80 triggers getting fired for the
triggers specifing the table and row.
There will be a total of 82 times the triggers will go off.
-- 2E

1 row inserted.
1 row inserted.
1 row inserted.
1 row inserted.
1 row inserted.
1 row inserted.
1 row inserted.
1 row inserted.
1 row inserted.
1 row inserted.
1 row inserted.
1 row inserted.
1 row inserted.
1 row inserted.
1 row inserted.
1 row inserted.
1 row inserted.
1 row inserted.
1 row inserted.
1 row inserted.
1 row inserted.
1 row inserted.
1 row inserted.
1 row inserted.
1 row inserted.
1 row inserted.
1 row inserted.
1 row inserted.
1 row inserted.
1 row inserted.
1 row inserted.
1 row inserted.
1 row inserted.
1 row inserted.
1 row inserted.
1 row inserted.
1 row inserted.
1 row inserted.
1 row inserted.
1 row inserted.

Trigger fired before inserting anything from LAB9_EMPLOYEE
Trigger fired before inserting a ROW from LAB9_EMPLOYEE
Trigger fired after inserting a ROW from LAB9_EMPLOYEE
Trigger fired after inserting anything from LAB9_EMPLOYEE

Trigger fired before inserting anything from LAB9_EMPLOYEE
Trigger fired before inserting a ROW from LAB9_EMPLOYEE
Trigger fired after inserting a ROW from LAB9_EMPLOYEE
Trigger fired after inserting anything from LAB9_EMPLOYEE

Trigger fired before inserting anything from LAB9_EMPLOYEE
Trigger fired before inserting a ROW from LAB9_EMPLOYEE
Trigger fired after inserting a ROW from LAB9_EMPLOYEE
Trigger fired after inserting anything from LAB9_EMPLOYEE

Trigger fired before inserting anything from LAB9_EMPLOYEE
Trigger fired before inserting a ROW from LAB9_EMPLOYEE
Trigger fired after inserting a ROW from LAB9_EMPLOYEE
Trigger fired after inserting anything from LAB9_EMPLOYEE

Trigger fired before inserting anything from LAB9_EMPLOYEE
Trigger fired before inserting a ROW from LAB9_EMPLOYEE
Trigger fired after inserting a ROW from LAB9_EMPLOYEE
Trigger fired after inserting anything from LAB9_EMPLOYEE

Trigger fired before inserting anything from LAB9_EMPLOYEE
Trigger fired before inserting a ROW from LAB9_EMPLOYEE
Trigger fired after inserting a ROW from LAB9_EMPLOYEE
Trigger fired after inserting anything from LAB9_EMPLOYEE

Trigger fired before inserting anything from LAB9_EMPLOYEE
Trigger fired before inserting a ROW from LAB9_EMPLOYEE
Trigger fired after inserting a ROW from LAB9_EMPLOYEE
Trigger fired after inserting anything from LAB9_EMPLOYEE

Trigger fired before inserting anything from LAB9_EMPLOYEE
Trigger fired before inserting a ROW from LAB9_EMPLOYEE
Trigger fired after inserting a ROW from LAB9_EMPLOYEE
Trigger fired after inserting anything from LAB9_EMPLOYEE

Trigger fired before inserting anything from LAB9_EMPLOYEE
Trigger fired before inserting a ROW from LAB9_EMPLOYEE
Trigger fired after inserting a ROW from LAB9_EMPLOYEE
Trigger fired after inserting anything from LAB9_EMPLOYEE

Trigger fired before inserting anything from LAB9_EMPLOYEE
Trigger fired before inserting a ROW from LAB9_EMPLOYEE
Trigger fired after inserting a ROW from LAB9_EMPLOYEE
Trigger fired after inserting anything from LAB9_EMPLOYEE

Trigger fired before inserting anything from LAB9_EMPLOYEE
Trigger fired before inserting a ROW from LAB9_EMPLOYEE
Trigger fired after inserting a ROW from LAB9_EMPLOYEE
Trigger fired after inserting anything from LAB9_EMPLOYEE

Trigger fired before inserting anything from LAB9_EMPLOYEE
Trigger fired before inserting a ROW from LAB9_EMPLOYEE
Trigger fired after inserting a ROW from LAB9_EMPLOYEE
Trigger fired after inserting anything from LAB9_EMPLOYEE

Trigger fired before inserting anything from LAB9_EMPLOYEE
Trigger fired before inserting a ROW from LAB9_EMPLOYEE
Trigger fired after inserting a ROW from LAB9_EMPLOYEE
Trigger fired after inserting anything from LAB9_EMPLOYEE

Trigger fired before inserting anything from LAB9_EMPLOYEE
Trigger fired before inserting a ROW from LAB9_EMPLOYEE
Trigger fired after inserting a ROW from LAB9_EMPLOYEE
Trigger fired after inserting anything from LAB9_EMPLOYEE

Trigger fired before inserting anything from LAB9_EMPLOYEE
Trigger fired before inserting a ROW from LAB9_EMPLOYEE
Trigger fired after inserting a ROW from LAB9_EMPLOYEE
Trigger fired after inserting anything from LAB9_EMPLOYEE

Trigger fired before inserting anything from LAB9_EMPLOYEE
Trigger fired before inserting a ROW from LAB9_EMPLOYEE
Trigger fired after inserting a ROW from LAB9_EMPLOYEE
Trigger fired after inserting anything from LAB9_EMPLOYEE

Trigger fired before inserting anything from LAB9_EMPLOYEE
Trigger fired before inserting a ROW from LAB9_EMPLOYEE
Trigger fired after inserting a ROW from LAB9_EMPLOYEE
Trigger fired after inserting anything from LAB9_EMPLOYEE

Trigger fired before inserting anything from LAB9_EMPLOYEE
Trigger fired before inserting a ROW from LAB9_EMPLOYEE
Trigger fired after inserting a ROW from LAB9_EMPLOYEE
Trigger fired after inserting anything from LAB9_EMPLOYEE

Trigger fired before inserting anything from LAB9_EMPLOYEE
Trigger fired before inserting a ROW from LAB9_EMPLOYEE
Trigger fired after inserting a ROW from LAB9_EMPLOYEE
Trigger fired after inserting anything from LAB9_EMPLOYEE

Trigger fired before inserting anything from LAB9_EMPLOYEE
Trigger fired before inserting a ROW from LAB9_EMPLOYEE
Trigger fired after inserting a ROW from LAB9_EMPLOYEE
Trigger fired after inserting anything from LAB9_EMPLOYEE

Trigger fired before inserting anything from LAB9_EMPLOYEE
Trigger fired before inserting a ROW from LAB9_EMPLOYEE
Trigger fired after inserting a ROW from LAB9_EMPLOYEE
Trigger fired after inserting anything from LAB9_EMPLOYEE

Trigger fired before inserting anything from LAB9_EMPLOYEE
Trigger fired before inserting a ROW from LAB9_EMPLOYEE
Trigger fired after inserting a ROW from LAB9_EMPLOYEE
Trigger fired after inserting anything from LAB9_EMPLOYEE

Trigger fired before inserting anything from LAB9_EMPLOYEE
Trigger fired before inserting a ROW from LAB9_EMPLOYEE
Trigger fired after inserting a ROW from LAB9_EMPLOYEE
Trigger fired after inserting anything from LAB9_EMPLOYEE

Trigger fired before inserting anything from LAB9_EMPLOYEE
Trigger fired before inserting a ROW from LAB9_EMPLOYEE
Trigger fired after inserting a ROW from LAB9_EMPLOYEE
Trigger fired after inserting anything from LAB9_EMPLOYEE

Trigger fired before inserting anything from LAB9_EMPLOYEE
Trigger fired before inserting a ROW from LAB9_EMPLOYEE
Trigger fired after inserting a ROW from LAB9_EMPLOYEE
Trigger fired after inserting anything from LAB9_EMPLOYEE

Trigger fired before inserting anything from LAB9_EMPLOYEE
Trigger fired before inserting a ROW from LAB9_EMPLOYEE
Trigger fired after inserting a ROW from LAB9_EMPLOYEE
Trigger fired after inserting anything from LAB9_EMPLOYEE

Trigger fired before inserting anything from LAB9_EMPLOYEE
Trigger fired before inserting a ROW from LAB9_EMPLOYEE
Trigger fired after inserting a ROW from LAB9_EMPLOYEE
Trigger fired after inserting anything from LAB9_EMPLOYEE

Trigger fired before inserting anything from LAB9_EMPLOYEE
Trigger fired before inserting a ROW from LAB9_EMPLOYEE
Trigger fired after inserting a ROW from LAB9_EMPLOYEE
Trigger fired after inserting anything from LAB9_EMPLOYEE

Trigger fired before inserting anything from LAB9_EMPLOYEE
Trigger fired before inserting a ROW from LAB9_EMPLOYEE
Trigger fired after inserting a ROW from LAB9_EMPLOYEE
Trigger fired after inserting anything from LAB9_EMPLOYEE

Trigger fired before inserting anything from LAB9_EMPLOYEE
Trigger fired before inserting a ROW from LAB9_EMPLOYEE
Trigger fired after inserting a ROW from LAB9_EMPLOYEE
Trigger fired after inserting anything from LAB9_EMPLOYEE

Trigger fired before inserting anything from LAB9_EMPLOYEE
Trigger fired before inserting a ROW from LAB9_EMPLOYEE
Trigger fired after inserting a ROW from LAB9_EMPLOYEE
Trigger fired after inserting anything from LAB9_EMPLOYEE

Trigger fired before inserting anything from LAB9_EMPLOYEE
Trigger fired before inserting a ROW from LAB9_EMPLOYEE
Trigger fired after inserting a ROW from LAB9_EMPLOYEE
Trigger fired after inserting anything from LAB9_EMPLOYEE

Trigger fired before inserting anything from LAB9_EMPLOYEE
Trigger fired before inserting a ROW from LAB9_EMPLOYEE
Trigger fired after inserting a ROW from LAB9_EMPLOYEE
Trigger fired after inserting anything from LAB9_EMPLOYEE

Trigger fired before inserting anything from LAB9_EMPLOYEE
Trigger fired before inserting a ROW from LAB9_EMPLOYEE
Trigger fired after inserting a ROW from LAB9_EMPLOYEE
Trigger fired after inserting anything from LAB9_EMPLOYEE

Trigger fired before inserting anything from LAB9_EMPLOYEE
Trigger fired before inserting a ROW from LAB9_EMPLOYEE
Trigger fired after inserting a ROW from LAB9_EMPLOYEE
Trigger fired after inserting anything from LAB9_EMPLOYEE

Trigger fired before inserting anything from LAB9_EMPLOYEE
Trigger fired before inserting a ROW from LAB9_EMPLOYEE
Trigger fired after inserting a ROW from LAB9_EMPLOYEE
Trigger fired after inserting anything from LAB9_EMPLOYEE

Trigger fired before inserting anything from LAB9_EMPLOYEE
Trigger fired before inserting a ROW from LAB9_EMPLOYEE
Trigger fired after inserting a ROW from LAB9_EMPLOYEE
Trigger fired after inserting anything from LAB9_EMPLOYEE

Trigger fired before inserting anything from LAB9_EMPLOYEE
Trigger fired before inserting a ROW from LAB9_EMPLOYEE
Trigger fired after inserting a ROW from LAB9_EMPLOYEE
Trigger fired after inserting anything from LAB9_EMPLOYEE

Trigger fired before inserting anything from LAB9_EMPLOYEE
Trigger fired before inserting a ROW from LAB9_EMPLOYEE
Trigger fired after inserting a ROW from LAB9_EMPLOYEE
Trigger fired after inserting anything from LAB9_EMPLOYEE

Trigger fired before inserting anything from LAB9_EMPLOYEE
Trigger fired before inserting a ROW from LAB9_EMPLOYEE
Trigger fired after inserting a ROW from LAB9_EMPLOYEE
Trigger fired after inserting anything from LAB9_EMPLOYEE

My hypthesis was incorrect. Every trigger was ran once per insert. 
Giving a total of 160 triggers fired.
-- Question 3
-- 3A
Trigger RESTRICT_UPDATE compiled

-- 3B
1 row updated.
ORA-20111: EMAIL ADDRESS missing ending portion

-- 3C
Trigger RESTRICT_UPDATE compiled

-- 3D
1 row updated.
ORA-20111: EMAIL ADDRESS missing ending portion

-- Question 4
Table LAB9_EMPLOYEE dropped.
*/

