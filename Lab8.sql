--Austin Polak, Jeffrey Tsai
--CNIT 372 Lab 8: Part B
--11/10/2021

--Partner 1: Austin Polak
--partner 2: Jeffrey Tsai

--B1
CREATE OR REPLACE VIEW SUPERVISOR AS
	SELECT SUPERVISOR, COUNT(EMPLOYEEID) AS EMPLOYEEID
    FROM EMPLOYEE
    GROUP BY SUPERVISOR;
/
--B2
GRANT READ ON SUPERVISOR TO TSAI102;
/
--B3
SELECT * FROM AJPOLAK.SUPERVISOR;
/
--B4
INSERT INTO EMPLOYEE (EMPLOYEEID, LASTNAME, FIRSTNAME, SUPERVISOR)
    VALUES('104511', 'Jimmy', 'Johns', '100206');
/
--B5
SELECT * FROM SUPERVISOR;
/
--B6
SELECT * FROM AJPOLAK.SUPERVISOR;
/
--B7
INSERT INTO EMPLOYEE (EMPLOYEEID, LASTNAME, FIRSTNAME, SUPERVISOR)
    VALUES('104511', 'Jimmy', 'Johns', '100206');
    commit;
/
--B8
SELECT * FROM AJPOLAK.SUPERVISOR;
/
--B9
delete from employee where employeeid = '104511';
/
--B10
SELECT * FROM SUPERVISOR;
/
--B11
SELECT * FROM AJPOLAK.SUPERVISOR;
/
--B12
revoke READ ON SUPERVISOR from TSAI102;
/
--B13
SELECT * FROM AJPOLAK.SUPERVISOR;
/
--B14
DROP VIEW SUPERVISOR;
/
--B15 - Answer Below
/
--B16 - Answer Below
/


/*Results
--B1

View SUPERVISOR created.

--B2

Grant succeeded.

--B3

SUPERVISOR EMPLOYEEID
---------- ----------
100200              2
100559              5
100104              3
100944              5
100365              3
100127              2
100125              3
100206              2
100650              2
                    1
100330              2

SUPERVISOR EMPLOYEEID
---------- ----------
100209              4
100001              2
100103              2
100880              3

15 rows selected. 

--B4

1 row inserted.

--B5

Yes, the new employee was added to the employee table and was
included into the output.

SUPERVISOR EMPLOYEEID
---------- ----------
100200              2
100559              5
100104              3
100944              5
100365              3
100127              2
100125              3
100206              2
100650              2
                    1
100330              2

SUPERVISOR EMPLOYEEID
---------- ----------
100209              4
100001              2
100103              2
100880              3

15 rows selected. 

--B6

No, did not see the new employee because 
we did not use commit so it did not pass the vaule.

SUPERVISOR NUMBEROFEMPLOYEES
---------- -----------------
100200                     2
100559                     5
100104                     3
100944                     5
100365                     3
100127                     2
100125                     3
100206                     1
100650                     2
                           1
100330                     2

SUPERVISOR NUMBEROFEMPLOYEES
---------- -----------------
100209                     4
100001                     2
100103                     2
100880                     3

15 rows selected. 

--B7

Commit complete.

--B8

Yes, the new employee was added to the employee table and was
included into the output. Commiting the employee 
passes it to the other partner when employee is called.

SUPERVISOR EMPLOYEEID
---------- ----------
100200              2
100559              5
100104              3
100944              5
100365              3
100127              2
100125              3
100206              2
100650              2
                    1
100330              2

SUPERVISOR EMPLOYEEID
---------- ----------
100209              4
100001              2
100103              2
100880              3

15 rows selected. 
--B9

1 row deleted.

--B10

The employee is gone from the table adn view because i deleted it.

SUPERVISOR EMPLOYEEID
---------- ----------
100200              2
100559              5
100104              3
100944              5
100365              3
100127              2
100125              3
100206              1
100650              2
                    1
100330              2

SUPERVISOR EMPLOYEEID
---------- ----------
100209              4
100001              2
100103              2
100880              3

15 rows selected. 


--B11

Yes, the employee is still there because partner1 did not commit it when 
deleting employee.

SUPERVISOR EMPLOYEEID
---------- ----------
100200              2
100559              5
100104              3
100944              5
100365              3
100127              2
100125              3
100206              2
100650              2
                    1
100330              2

SUPERVISOR EMPLOYEEID
---------- ----------
100209              4
100001              2
100103              2
100880              3

15 rows selected. 

--B12

Revoke succeeded.

--B13

Error starting at line : 36 in command -
SELECT * FROM TSAI102.SUPERVISOR
Error at Command Line : 36 Column : 23
Error report -
SQL Error: ORA-00942: table or view does not exist
00942. 00000 -  "table or view does not exist"
*Cause:    
*Action:


--B14

View SUPERVISOR dropped.

--B15

The privilege we are lacking is create materalized view. 
We must also have access to any master tables of the materiallized view that we do  not own.
(Section: Prerequisites https://docs.oracle.com/cd/B19306_01/server.102/b14200/statements_6002.htm)

--B16

The privilege we are lacking is the create role system privilege.
The reason why we are not granted this privilege is because students 
should not a have the ability to change the database across the whole system.
Students are users and the role privilege is for admins.
(Section: Prerequisites https://docs.oracle.com/cd/B19306_01/server.102/b14200/statements_6012.htm)
*/
