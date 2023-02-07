--Lab 3

-- Question 1a
begin
        DBMS_OUTPUT.PUT_LINE ('Hello world');
end;
/
-- Question 1b
SET SERVEROUTPUT ON;
/
-- Question 1c
begin
        DBMS_OUTPUT.PUT_LINE ('Hello world');
end;

/
-- Question 1d - Answer Below
/
-- Question 2a
begin
    DBMS_OUTPUT.PUT_LINE ('The ubiquitous Hello World');
end;
/
-- Question 2b
begin
    DBMS_OUTPUT.PUT ('The');
    DBMS_OUTPUT.PUT (' ');
    DBMS_OUTPUT.PUT ('ubiquitous');
    DBMS_OUTPUT.PUT (' ');
    DBMS_OUTPUT.PUT ('Hello');
    DBMS_OUTPUT.PUT (' ');
    DBMS_OUTPUT.PUT_LINE ('World');
end;
/
-- Question 2c - Answer Below
/
-- Question 2d - Answer Below
/
-- Question 2e - Answer Below
/
-- Question 2f - Answer Below
/
-- Question 3
begin
    dbms_output.put_line ('My name is ' || '&sv_YourName');
end;
/

-- Question 4a
SET VERIFY ON;
/
-- Question 4b
BEGIN
    DBMS_OUTPUT.PUT_LINE ('My name is ' || ' &sv_YourName');
END;

/
-- Question 4c
SET VERIFY OFF;
/
-- Question 4d
BEGIN
    DBMS_OUTPUT.PUT_LINE ('My name is ' || ' &sv_YourName');
END;

/
-- Question 4e - Answer Below
/
-- Question 5
begin
    dbms_output.put_line ('My name is ' || '&sv_YourName');
end;

/
-- Question 6
begin
    dbms_output.put_line ('Today is ' || '&sv_day');
    dbms_output.put_line ('Tomorrow is ' || '&sv_day');
end;

/
-- Question 7a
begin
    dbms_output.put_line ('Today is ' || '&&sv_day');
    dbms_output.put_line ('Tomorrow is ' || '&sv_day');
end;

/
-- Question 7b 
begin
    dbms_output.put_line ('Today is ' || '&&sv_day');
    dbms_output.put_line ('Tomorrow is ' || '&sv_day');
end;

/
-- Question 8
declare
	v_day varchar2(10) := '&sv_day1';
begin
	dbms_output.put_line('Today is ' || v_day);
end;
/
-- Question 9
declare
    v_day varchar2(10);
begin
    v_day := to_char (sysdate, 'Day');
    
    dbms_output.put_line ('Today is ' || v_day);
    dbms_output.put_line ('Tomorrow is ' || to_char (sysdate +1, 'Day'));
    
end;
/
-- Question 10a
select employeeID
from employee
where employeeID = '100001';
/
-- Question 10b
declare
    v_employeeID employee.employeeID%type;
    v_lastName employee.lastName%type;
    v_firstName employee.firstName%type;
begin
    select employeeID, lastName, firstName
        into v_employeeID, v_lastName, V_firstName
    from employee
    where employeeID = '100001';
    
    dbms_output.put_line ('Employee ID        LASTNAME         FIRSTNAME');
    dbms_output.put_line ('==============================================');
    dbms_output.put (v_employeeID);
    dbms_output.put ('           ');
    dbms_output.put (V_lastName);
    dbms_output.put ('           ');
    dbms_output.put_line (V_firstName);
end;
/
-- Question 10c
select employeeID
from employee;
/
-- Question 10d
declare
    v_employeeID employee.employeeID%type;
    v_lastName employee.lastName%type;
    v_firstName employee.firstName%type;
begin
    select employeeID, lastName, firstName
        into v_employeeID, v_lastName, v_firstName
    from employee;
    
    dbms_output.put_line ('Employee ID        LASTNAME         FIRSTNAME');
    dbms_output.put_line ('==============================================');
    dbms_output.put (v_employeeID);
    dbms_output.put ('           ');
    dbms_output.put (V_lastName);
    dbms_output.put ('           ');
    dbms_output.put_line (V_firstName);
end;
/
-- Question 10e - Answer below
/
-- Question 10f - Answer below
/
-- Question 10h
declare

    v_employee employee%ROWTYPE;
begin
    select *
        into v_employee
    from employee
    where employeeID = '100001';
    
    dbms_output.put_line ('Employee ID        LASTNAME         FIRSTNAME');
    dbms_output.put_line ('==============================================');
    dbms_output.put (v_employee.employeeID);
    dbms_output.put ('           ');
    dbms_output.put (v_employee.lastName);
    dbms_output.put ('           ');
    dbms_output.put_line (v_employee.firstName);
end;
/
-- Question 11a
select jobtitle, count(employeeid)
from employee
group by jobtitle;

/
-- Question 11b
declare
    v_number_employees number;
    v_jobtitle         varchar2(50) := '&v_jobtitle';
begin
    select count(employeeid)
        into v_number_employees
    from employee
    where jobtitle = v_jobtitle;
    
    if v_number_employees < 1 then
        dbms_output.put_line ('There are no employees with the Job Title: ' || v_jobtitle);
    elsif v_number_employees < 4 then
        dbms_output.put_line ('There are between 1 and 3 employees with the Job Title: ' || v_jobtitle);
    else
        dbms_output.put_line ('There are 7 or more employees with the Job Title: ' || v_jobtitle);
    end if;
end;
/
-- Question 11c
declare
    v_number_employees number;
    v_jobtitle         varchar2(50) := '&v_jobtitle';
begin
    select count(employeeid)
        into v_number_employees
    from employee
    where jobtitle = v_jobtitle;
    
    if v_number_employees < 1 then
        dbms_output.put_line ('There are no employees with the Job Title: ' || v_jobtitle);
    elsif v_number_employees < 4 then
        dbms_output.put_line ('There are between 1 and 3 employees with the Job Title: ' || v_jobtitle);
    else
        dbms_output.put_line ('There are 7 or more employees with the Job Title: ' || v_jobtitle);
    end if;
end;
/
-- Question 11d
declare
    v_number_employees number;
    v_jobtitle         varchar2(50) := '&v_jobtitle';
begin
    select count(employeeid)
        into v_number_employees
    from employee
    where jobtitle = v_jobtitle;
    
    if v_number_employees < 1 then
        dbms_output.put_line ('There are no employees with the Job Title: ' || v_jobtitle);
    elsif v_number_employees < 4 then
        dbms_output.put_line ('There are between 1 and 3 employees with the Job Title: ' || v_jobtitle);
    else
        dbms_output.put_line ('There are 7 or more employees with the Job Title: ' || v_jobtitle);
    end if;
end;
/
-- Question 11e
declare
    v_number_employees number;
    v_jobtitle         varchar2(50) := '&v_jobtitle';
begin
    select count(employeeid)
        into v_number_employees
    from employee
    where jobtitle = v_jobtitle;
    
    if v_number_employees < 1 then
        dbms_output.put_line ('There are no employees with the Job Title: ' || v_jobtitle);
    elsif v_number_employees < 4 then
        dbms_output.put_line ('There are between 1 and 3 employees with the Job Title: ' || v_jobtitle);
    else
        dbms_output.put_line ('There are 7 or more employees with the Job Title: ' || v_jobtitle);
    end if;
end;
/
-- Question 12a
declare
    v_number_employees number;
    v_jobtitle         varchar2(50) := '&v_jobtitle';
begin
    select count(employeeid)
        into v_number_employees
    from employee
    where jobtitle = v_jobtitle;
    
    case v_number_employees
        when 0 then
            dbms_output.put_line ('There are no employees with the Job Title: ' || v_jobtitle);
        when 1 then
            dbms_output.put_line ('There are between 1 and 3 employees with the Job Title: ' || v_jobtitle);
        when 2 then
            dbms_output.put_line ('There are between 1 and 3 employees with the Job Title: ' || v_jobtitle);
        when 3 then
            dbms_output.put_line ('There are between 1 and 3 employees with the Job Title: ' || v_jobtitle);
        when 4 then
            dbms_output.put_line ('There are between 4 and 6 employees with the Job Title: ' || v_jobtitle);
        when 5 then
            dbms_output.put_line ('There are between 4 and 6 employees with the Job Title: ' || v_jobtitle);
        when 6 then
            dbms_output.put_line ('There are between 4 and 6 employees with the Job Title: ' || v_jobtitle);
        else
        dbms_output.put_line ('There are 7 or more employees with the Job Title: ' || v_jobtitle);
    end case;
end;
/
-- Question 12b
declare
    v_number_employees number;
    v_jobtitle         varchar2(50) := '&v_jobtitle';
begin
    select count(employeeid)
        into v_number_employees
    from employee
    where jobtitle = v_jobtitle;
    
    case v_number_employees
        when 0 then
            dbms_output.put_line ('There are no employees with the Job Title: ' || v_jobtitle);
        when 1 then
            dbms_output.put_line ('There are between 1 and 3 employees with the Job Title: ' || v_jobtitle);
        when 2 then
            dbms_output.put_line ('There are between 1 and 3 employees with the Job Title: ' || v_jobtitle);
        when 3 then
            dbms_output.put_line ('There are between 1 and 3 employees with the Job Title: ' || v_jobtitle);
        when 4 then
            dbms_output.put_line ('There are between 4 and 6 employees with the Job Title: ' || v_jobtitle);
        when 5 then
            dbms_output.put_line ('There are between 4 and 6 employees with the Job Title: ' || v_jobtitle);
        when 6 then
            dbms_output.put_line ('There are between 4 and 6 employees with the Job Title: ' || v_jobtitle);
        else
        dbms_output.put_line ('There are 7 or more employees with the Job Title: ' || v_jobtitle);
    end case;
end;
/
-- Question 12c
declare
    v_number_employees number;
    v_jobtitle         varchar2(50) := '&v_jobtitle';
begin
    select count(employeeid)
        into v_number_employees
    from employee
    where jobtitle = v_jobtitle;
    
    case v_number_employees
        when 0 then
            dbms_output.put_line ('There are no employees with the Job Title: ' || v_jobtitle);
        when 1 then
            dbms_output.put_line ('There are between 1 and 3 employees with the Job Title: ' || v_jobtitle);
        when 2 then
            dbms_output.put_line ('There are between 1 and 3 employees with the Job Title: ' || v_jobtitle);
        when 3 then
            dbms_output.put_line ('There are between 1 and 3 employees with the Job Title: ' || v_jobtitle);
        when 4 then
            dbms_output.put_line ('There are between 4 and 6 employees with the Job Title: ' || v_jobtitle);
        when 5 then
            dbms_output.put_line ('There are between 4 and 6 employees with the Job Title: ' || v_jobtitle);
        when 6 then
            dbms_output.put_line ('There are between 4 and 6 employees with the Job Title: ' || v_jobtitle);
        else
        dbms_output.put_line ('There are 7 or more employees with the Job Title: ' || v_jobtitle);
    end case;
end;
/
-- Question 12d
declare
    v_number_employees number;
    v_jobtitle         varchar2(50) := '&v_jobtitle';
begin
    select count(employeeid)
        into v_number_employees
    from employee
    where jobtitle = v_jobtitle;
    
    case v_number_employees
        when 0 then
            dbms_output.put_line ('There are no employees with the Job Title: ' || v_jobtitle);
        when 1 then
            dbms_output.put_line ('There are between 1 and 3 employees with the Job Title: ' || v_jobtitle);
        when 2 then
            dbms_output.put_line ('There are between 1 and 3 employees with the Job Title: ' || v_jobtitle);
        when 3 then
            dbms_output.put_line ('There are between 1 and 3 employees with the Job Title: ' || v_jobtitle);
        when 4 then
            dbms_output.put_line ('There are between 4 and 6 employees with the Job Title: ' || v_jobtitle);
        when 5 then
            dbms_output.put_line ('There are between 4 and 6 employees with the Job Title: ' || v_jobtitle);
        when 6 then
            dbms_output.put_line ('There are between 4 and 6 employees with the Job Title: ' || v_jobtitle);
        else
        dbms_output.put_line ('There are 7 or more employees with the Job Title: ' || v_jobtitle);
    end case;
end;
/
-- Question 13a
declare
    v_number_employees number;
    v_jobtitle         employee.jobtitle%type := '&v_jobtitle';
begin
    select count(employeeid)
        into v_number_employees
    from employee
    where jobtitle = v_jobtitle;
    
    case v_number_employees
        when 0 then
            dbms_output.put_line ('There are no employees with the Job Title: ' || v_jobtitle);
        when 1 then
            dbms_output.put_line ('There are between 1 and 3 employees with the Job Title: ' || v_jobtitle);
        when 2 then
            dbms_output.put_line ('There are between 1 and 3 employees with the Job Title: ' || v_jobtitle);
        when 3 then
            dbms_output.put_line ('There are between 1 and 3 employees with the Job Title: ' || v_jobtitle);
        when 4 then
            dbms_output.put_line ('There are between 4 and 6 employees with the Job Title: ' || v_jobtitle);
        when 5 then
            dbms_output.put_line ('There are between 4 and 6 employees with the Job Title: ' || v_jobtitle);
        when 6 then
            dbms_output.put_line ('There are between 4 and 6 employees with the Job Title: ' || v_jobtitle);
        else
        dbms_output.put_line ('There are 7 or more employees with the Job Title: ' || v_jobtitle);
    end case;
end;
/
-- Question 13b - Answer below
/
-- Question 14
declare
    v_number_employees number;
    v_jobtitle         employee.jobtitle%type := '&v_jobtitle';
    v_staff_level      varchar2(100);
begin
    select count(employeeid)
        into v_number_employees
    from employee
    where jobtitle = v_jobtitle;
    
    case v_number_employees
        when 0 then
            v_staff_level := 'There are no employees with the Job Title: ';
        when 1 then
             v_staff_level := 'There are between 1 and 3 employees with the Job Title: ';
        when 2 then
            v_staff_level := 'There are between 1 and 3 employees with the Job Title: ';
        when 3 then
            v_staff_level := 'There are between 1 and 3 employees with the Job Title: ';
        when 4 then
             v_staff_level :=  'There are between 4 and 6 employees with the Job Title: ';
        when 5 then
            v_staff_level :=  'There are between 4 and 6 employees with the Job Title: ';
        when 6 then
            v_staff_level :=  'There are between 4 and 6 employees with the Job Title: ';
        else
            v_staff_level := 'There are 7 or more employees with the Job Title: ';
    end case;
    
    --Output user friendly response
    dbms_output.put_line (v_staff_level || v_jobtitle);
    
end;
/
/* Results
-- Question 1a
Hello world

-- Question 1b
NO OUTPUT

-- Question 1c
Before restart "Hello World" in the DBMS Output.
After restart "Hello World" is printed in both the DBMS adn Script output.
When restarting SQL did not remember the SERVEROUTPUT preference.

PL/SQL procedure successfully completed.



Hello world


PL/SQL procedure successfully completed.


-- Question 1d
The SERVEROUTPUT setting controls whether SQL prints the output generated by
the DBMS_OUTPUT package from PL/SQL procedures.
Lets the PL/SQL procedure be displayed on the DBMS and Script output.
(O.REILLY.com)

-- Question 2a
The ubiquitous Hello World

-- Question 2b
The ubiquitous Hello World

-- Question 2c
The difference is the amount of code for the same output.
The difference between the two procedures , is that DBMS_OUTPUT.PUT_LINE
prints the line out. Without the LINE at the end it will run but not print results.

-- Question 2d
The PUT procedure places a partial line in the buffer. You can build a line of information
piece by piece by making multipole calls to PUT.
(docs.oracle.com/database)

-- Question 2e
Allows you to write data to flat file or to direct your PL/SQL output to a screen.
(dba-oracle.com/t_dbms_output_put_line.htm)

-- Question 2f
DBMS_OUTPUT.PUT can have multiple lines of code that forms a String.
DBMS_OUTPUT.PUT_LINE can form a string with one line of code and
prints an output for the code.

-- Question 3
Running the code brought up a GUI that asked for my name.
Once I input my name, I recieve an output.

old:begin
    dbms_output.put_line ('My name is ' || '&sv_YourName');
end;

new:begin
    dbms_output.put_line ('My name is ' || 'apple');
end;
My name is apple

-- Question 4a
No output

-- Question 4b
old:BEGIN
    DBMS_OUTPUT.PUT_LINE ('My name is ' || ' &sv_YourName');
END;
new:BEGIN
    DBMS_OUTPUT.PUT_LINE ('My name is ' || ' Austin');
END;

PL/SQL procedure successfully completed.

-- Question 4c
No output

-- Question 4d
The output did not appear. It states that the code ran successfully.

PL/SQL procedure successfully completed.
-- Question 4e
The VERIFY setting controls whether or not PL/SQL displays before and after images of each
line that contains a substitution variable.
(oreilly.com)

-- Question 5
I am prompted only once for my name.
The information does not need to persist to print out. 
Whatever you input in the GUI will be displayed.

old:begin
    dbms_output.put_line ('My name is ' || '&sv_YourName');
end;
new:begin
    dbms_output.put_line ('My name is ' || 'Austin');
end;
My name is Austin

-- Question 6
Yes, you can use the same variable twice. The GUI is dispalayed twice, asking
for an input and then provides an output. The output displays both results,
one above the other.

old:begin
    dbms_output.put_line ('Today is ' || '&sv_day');
    dbms_output.put_line ('Tomorrow is ' || '&sv_day');
end;
new:begin
    dbms_output.put_line ('Today is ' || '12');
    dbms_output.put_line ('Tomorrow is ' || '13');
end;
Today is 12
Tomorrow is 13

-- Question 7a
I was only prompted once, but display the same day to both of them.
The difference is the "&&" within the line of code, which overrided the 
second line.

old:begin
    dbms_output.put_line ('Today is ' || '&&sv_day');
    dbms_output.put_line ('Tomorrow is ' || '&sv_day');
end;
new:begin
    dbms_output.put_line ('Today is ' || 'Monday');
    dbms_output.put_line ('Tomorrow is ' || 'Monday');
end;
Today is Monday
Tomorrow is Monday

-- Question 7b
I was never prompted to input a day. The code captures the inputted data
and saves it. Along, with not prompting to the second line to input the next day.

old:begin
    dbms_output.put_line ('Today is ' || '&&sv_day');
    dbms_output.put_line ('Tomorrow is ' || '&sv_day');
end;
new:begin
    dbms_output.put_line ('Today is ' || 'Monday');
    dbms_output.put_line ('Tomorrow is ' || 'Monday');
end;
Today is Monday
Tomorrow is Monday

-- Question 8
old:declare
	v_day varchar2(10) := '&sv_day1';
begin
	dbms_output.put_line('Today is ' || v_day);
end;
new:declare
	v_day varchar2(10) := 'Sunday';
begin
	dbms_output.put_line('Today is ' || v_day);
end;
Today is Sunday

-- Question 9
Today is Wednesday
Tomorrow is Thursday 

PL/SQL procedure successfully completed.

-- Question 10a
Returns one row for the identified employeeID.
EMPLOYEEID
----------
100001

-- Question 10b
Employee ID        LASTNAME         FIRSTNAME
==============================================
100001           Manaugh           Jim


-- Question 10c
EMPLOYEEID
----------
100001
100101
100103
100104
100106
100112
100120
100125
100127
100200
100204

EMPLOYEEID
----------
100206
100209
100220
100330
100365
100399
100475
100488
100550
100559
100600

EMPLOYEEID
----------
100650
100700
100880
100892
100944
100967
100989
101007
101030
101045
101066

EMPLOYEEID
----------
101088
101089
101097
101115
101135
101154
101166

40 rows selected. 

-- Question 10d
Error starting at line : 144 in command -
declare
    v_employeeID employee.employeeID%type;
    v_lastName employee.lastName%type;
    v_firstName employee.firstName%type;
begin
    select employeeID, lastName, firstName
        into v_employeeID, v_lastName, v_firstName
    from employee;

    dbms_output.put_line ('Employee ID        LASTNAME         FIRSTNAME');
    dbms_output.put_line ('==============================================');
    dbms_output.put (v_employeeID);
    dbms_output.put ('           ');
    dbms_output.put (V_lastName);
    dbms_output.put ('           ');
    dbms_output.put_line (V_firstName);
end;
Error report -
ORA-01422: exact fetch returns more than requested number of rows
ORA-06512: at line 6
01422. 00000 -  "exact fetch returns more than requested number of rows"
*Cause:    The number specified in exact fetch is less than the rows returned.
*Action:   Rewrite the query or change number of rows requested

-- Question 10e
The amount of vaules per variable would be 40. It throws an erroe report 
due to the amount trying to fetch is to large. 

-- Question 10f
Scalar-type value can only hold one value at a time.

-- Question 10h
Differences between the code is that the %rowtype attribute
provides a record type that represents a row in the a database table.
Along with delcaring one table and linkning it with the attribute in the table.

Employee ID   LASTNAME   FIRSTNAME
==================================
100001       Manaugh       Jim


PL/SQL procedure successfully completed.


-- Question 11a
JOBTITLE                            COUNT(EMPLOYEEID)
----------------------------------- -----------------
VP Finance                                          1
Sales                                               3
VP Information                                      1
Chief Information Officer                           1
Chief Sales Officer                                 1
VP Operations                                       1
Accountant                                          2
President                                           1
DBA                                                 1
Chief Financial Officer                             1
Engineer                                            5

JOBTITLE                            COUNT(EMPLOYEEID)
----------------------------------- -----------------
Programmer Analyst                                  2
Operations Officer                                  2
Assembly                                           18

14 rows selected. 

-- Question 11b
old:declare
    v_number_employees number;
    v_jobtitle         varchar2(50) := '&v_jobtitle';
begin
    select count(employeeid)
        into v_number_employees
    from employee
    where jobtitle = v_jobtitle;

    if v_number_employees < 1 then
        dbms_output.put_line ('There are no employees with the Job Title: ' || v_jobtitle);
    elsif v_number_employees < 4 then
        dbms_output.put_line ('There are between 1 and 3 employees with the Job Title: ' || v_jobtitle);
    else
        dbms_output.put_line ('There are 7 or more employees with the Job Title: ' || v_jobtitle);
    end if;
end;
new:declare
    v_number_employees number;
    v_jobtitle         varchar2(50) := 'CIO';
begin
    select count(employeeid)
        into v_number_employees
    from employee
    where jobtitle = v_jobtitle;

    if v_number_employees < 1 then
        dbms_output.put_line ('There are no employees with the Job Title: ' || v_jobtitle);
    elsif v_number_employees < 4 then
        dbms_output.put_line ('There are between 1 and 3 employees with the Job Title: ' || v_jobtitle);
    else
        dbms_output.put_line ('There are 7 or more employees with the Job Title: ' || v_jobtitle);
    end if;
end;
There are no employees with the Job Title: CIO


PL/SQL procedure successfully completed.

-- Question 11c
old:declare
    v_number_employees number;
    v_jobtitle         varchar2(50) := '&v_jobtitle';
begin
    select count(employeeid)
        into v_number_employees
    from employee
    where jobtitle = v_jobtitle;

    if v_number_employees < 1 then
        dbms_output.put_line ('There are no employees with the Job Title: ' || v_jobtitle);
    elsif v_number_employees < 4 then
        dbms_output.put_line ('There are between 1 and 3 employees with the Job Title: ' || v_jobtitle);
    else
        dbms_output.put_line ('There are 7 or more employees with the Job Title: ' || v_jobtitle);
    end if;
end;
new:declare
    v_number_employees number;
    v_jobtitle         varchar2(50) := 'Accountant';
begin
    select count(employeeid)
        into v_number_employees
    from employee
    where jobtitle = v_jobtitle;

    if v_number_employees < 1 then
        dbms_output.put_line ('There are no employees with the Job Title: ' || v_jobtitle);
    elsif v_number_employees < 4 then
        dbms_output.put_line ('There are between 1 and 3 employees with the Job Title: ' || v_jobtitle);
    else
        dbms_output.put_line ('There are 7 or more employees with the Job Title: ' || v_jobtitle);
    end if;
end;
There are between 1 and 3 employees with the Job Title: Accountant


PL/SQL procedure successfully completed.

-- Question 11d
old:declare
    v_number_employees number;
    v_jobtitle         varchar2(50) := '&v_jobtitle';
begin
    select count(employeeid)
        into v_number_employees
    from employee
    where jobtitle = v_jobtitle;

    if v_number_employees < 1 then
        dbms_output.put_line ('There are no employees with the Job Title: ' || v_jobtitle);
    elsif v_number_employees < 4 then
        dbms_output.put_line ('There are between 1 and 3 employees with the Job Title: ' || v_jobtitle);
    else
        dbms_output.put_line ('There are 7 or more employees with the Job Title: ' || v_jobtitle);
    end if;
end;
new:declare
    v_number_employees number;
    v_jobtitle         varchar2(50) := 'Engineer';
begin
    select count(employeeid)
        into v_number_employees
    from employee
    where jobtitle = v_jobtitle;

    if v_number_employees < 1 then
        dbms_output.put_line ('There are no employees with the Job Title: ' || v_jobtitle);
    elsif v_number_employees < 4 then
        dbms_output.put_line ('There are between 1 and 3 employees with the Job Title: ' || v_jobtitle);
    else
        dbms_output.put_line ('There are 7 or more employees with the Job Title: ' || v_jobtitle);
    end if;
end;
There are 7 or more employees with the Job Title: Engineer


PL/SQL procedure successfully completed.

-- Question 11e
old:declare
    v_number_employees number;
    v_jobtitle         varchar2(50) := '&v_jobtitle';
begin
    select count(employeeid)
        into v_number_employees
    from employee
    where jobtitle = v_jobtitle;

    if v_number_employees < 1 then
        dbms_output.put_line ('There are no employees with the Job Title: ' || v_jobtitle);
    elsif v_number_employees < 4 then
        dbms_output.put_line ('There are between 1 and 3 employees with the Job Title: ' || v_jobtitle);
    else
        dbms_output.put_line ('There are 7 or more employees with the Job Title: ' || v_jobtitle);
    end if;
end;
new:declare
    v_number_employees number;
    v_jobtitle         varchar2(50) := 'Assembly';
begin
    select count(employeeid)
        into v_number_employees
    from employee
    where jobtitle = v_jobtitle;

    if v_number_employees < 1 then
        dbms_output.put_line ('There are no employees with the Job Title: ' || v_jobtitle);
    elsif v_number_employees < 4 then
        dbms_output.put_line ('There are between 1 and 3 employees with the Job Title: ' || v_jobtitle);
    else
        dbms_output.put_line ('There are 7 or more employees with the Job Title: ' || v_jobtitle);
    end if;
end;
There are 7 or more employees with the Job Title: Assembly


PL/SQL procedure successfully completed.

-- Question 12a
old:declare
    v_number_employees number;
    v_jobtitle         varchar2(50) := '&v_jobtitle';
begin
    select count(employeeid)
        into v_number_employees
    from employee
    where jobtitle = v_jobtitle;

    case v_number_employees
        when 0 then
            dbms_output.put_line ('There are no employees with the Job Title: ' || v_jobtitle);
        when 1 then
            dbms_output.put_line ('There are between 1 and 3 employees with the Job Title: ' || v_jobtitle);
        when 2 then
            dbms_output.put_line ('There are between 1 and 3 employees with the Job Title: ' || v_jobtitle);
        when 3 then
            dbms_output.put_line ('There are between 1 and 3 employees with the Job Title: ' || v_jobtitle);
        when 4 then
            dbms_output.put_line ('There are between 4 and 6 employees with the Job Title: ' || v_jobtitle);
        when 5 then
            dbms_output.put_line ('There are between 4 and 6 employees with the Job Title: ' || v_jobtitle);
        when 6 then
            dbms_output.put_line ('There are between 4 and 6 employees with the Job Title: ' || v_jobtitle);
        else
        dbms_output.put_line ('There are 7 or more employees with the Job Title: ' || v_jobtitle);
    end case;
end;
new:declare
    v_number_employees number;
    v_jobtitle         varchar2(50) := 'CIO';
begin
    select count(employeeid)
        into v_number_employees
    from employee
    where jobtitle = v_jobtitle;

    case v_number_employees
        when 0 then
            dbms_output.put_line ('There are no employees with the Job Title: ' || v_jobtitle);
        when 1 then
            dbms_output.put_line ('There are between 1 and 3 employees with the Job Title: ' || v_jobtitle);
        when 2 then
            dbms_output.put_line ('There are between 1 and 3 employees with the Job Title: ' || v_jobtitle);
        when 3 then
            dbms_output.put_line ('There are between 1 and 3 employees with the Job Title: ' || v_jobtitle);
        when 4 then
            dbms_output.put_line ('There are between 4 and 6 employees with the Job Title: ' || v_jobtitle);
        when 5 then
            dbms_output.put_line ('There are between 4 and 6 employees with the Job Title: ' || v_jobtitle);
        when 6 then
            dbms_output.put_line ('There are between 4 and 6 employees with the Job Title: ' || v_jobtitle);
        else
        dbms_output.put_line ('There are 7 or more employees with the Job Title: ' || v_jobtitle);
    end case;
end;
There are no employees with the Job Title: CIO


PL/SQL procedure successfully completed.

-- Question 12b
old:declare
    v_number_employees number;
    v_jobtitle         varchar2(50) := '&v_jobtitle';
begin
    select count(employeeid)
        into v_number_employees
    from employee
    where jobtitle = v_jobtitle;

    case v_number_employees
        when 0 then
            dbms_output.put_line ('There are no employees with the Job Title: ' || v_jobtitle);
        when 1 then
            dbms_output.put_line ('There are between 1 and 3 employees with the Job Title: ' || v_jobtitle);
        when 2 then
            dbms_output.put_line ('There are between 1 and 3 employees with the Job Title: ' || v_jobtitle);
        when 3 then
            dbms_output.put_line ('There are between 1 and 3 employees with the Job Title: ' || v_jobtitle);
        when 4 then
            dbms_output.put_line ('There are between 4 and 6 employees with the Job Title: ' || v_jobtitle);
        when 5 then
            dbms_output.put_line ('There are between 4 and 6 employees with the Job Title: ' || v_jobtitle);
        when 6 then
            dbms_output.put_line ('There are between 4 and 6 employees with the Job Title: ' || v_jobtitle);
        else
        dbms_output.put_line ('There are 7 or more employees with the Job Title: ' || v_jobtitle);
    end case;
end;
new:declare
    v_number_employees number;
    v_jobtitle         varchar2(50) := 'Accountant';
begin
    select count(employeeid)
        into v_number_employees
    from employee
    where jobtitle = v_jobtitle;

    case v_number_employees
        when 0 then
            dbms_output.put_line ('There are no employees with the Job Title: ' || v_jobtitle);
        when 1 then
            dbms_output.put_line ('There are between 1 and 3 employees with the Job Title: ' || v_jobtitle);
        when 2 then
            dbms_output.put_line ('There are between 1 and 3 employees with the Job Title: ' || v_jobtitle);
        when 3 then
            dbms_output.put_line ('There are between 1 and 3 employees with the Job Title: ' || v_jobtitle);
        when 4 then
            dbms_output.put_line ('There are between 4 and 6 employees with the Job Title: ' || v_jobtitle);
        when 5 then
            dbms_output.put_line ('There are between 4 and 6 employees with the Job Title: ' || v_jobtitle);
        when 6 then
            dbms_output.put_line ('There are between 4 and 6 employees with the Job Title: ' || v_jobtitle);
        else
        dbms_output.put_line ('There are 7 or more employees with the Job Title: ' || v_jobtitle);
    end case;
end;
There are between 1 and 3 employees with the Job Title: Accountant


PL/SQL procedure successfully completed.

-- Question 12c
old:declare
    v_number_employees number;
    v_jobtitle         varchar2(50) := '&v_jobtitle';
begin
    select count(employeeid)
        into v_number_employees
    from employee
    where jobtitle = v_jobtitle;

    case v_number_employees
        when 0 then
            dbms_output.put_line ('There are no employees with the Job Title: ' || v_jobtitle);
        when 1 then
            dbms_output.put_line ('There are between 1 and 3 employees with the Job Title: ' || v_jobtitle);
        when 2 then
            dbms_output.put_line ('There are between 1 and 3 employees with the Job Title: ' || v_jobtitle);
        when 3 then
            dbms_output.put_line ('There are between 1 and 3 employees with the Job Title: ' || v_jobtitle);
        when 4 then
            dbms_output.put_line ('There are between 4 and 6 employees with the Job Title: ' || v_jobtitle);
        when 5 then
            dbms_output.put_line ('There are between 4 and 6 employees with the Job Title: ' || v_jobtitle);
        when 6 then
            dbms_output.put_line ('There are between 4 and 6 employees with the Job Title: ' || v_jobtitle);
        else
        dbms_output.put_line ('There are 7 or more employees with the Job Title: ' || v_jobtitle);
    end case;
end;
new:declare
    v_number_employees number;
    v_jobtitle         varchar2(50) := 'Engineer';
begin
    select count(employeeid)
        into v_number_employees
    from employee
    where jobtitle = v_jobtitle;

    case v_number_employees
        when 0 then
            dbms_output.put_line ('There are no employees with the Job Title: ' || v_jobtitle);
        when 1 then
            dbms_output.put_line ('There are between 1 and 3 employees with the Job Title: ' || v_jobtitle);
        when 2 then
            dbms_output.put_line ('There are between 1 and 3 employees with the Job Title: ' || v_jobtitle);
        when 3 then
            dbms_output.put_line ('There are between 1 and 3 employees with the Job Title: ' || v_jobtitle);
        when 4 then
            dbms_output.put_line ('There are between 4 and 6 employees with the Job Title: ' || v_jobtitle);
        when 5 then
            dbms_output.put_line ('There are between 4 and 6 employees with the Job Title: ' || v_jobtitle);
        when 6 then
            dbms_output.put_line ('There are between 4 and 6 employees with the Job Title: ' || v_jobtitle);
        else
        dbms_output.put_line ('There are 7 or more employees with the Job Title: ' || v_jobtitle);
    end case;
end;
There are between 4 and 6 employees with the Job Title: Engineer


PL/SQL procedure successfully completed.

-- Question 12d
old:declare
    v_number_employees number;
    v_jobtitle         varchar2(50) := '&v_jobtitle';
begin
    select count(employeeid)
        into v_number_employees
    from employee
    where jobtitle = v_jobtitle;

    case v_number_employees
        when 0 then
            dbms_output.put_line ('There are no employees with the Job Title: ' || v_jobtitle);
        when 1 then
            dbms_output.put_line ('There are between 1 and 3 employees with the Job Title: ' || v_jobtitle);
        when 2 then
            dbms_output.put_line ('There are between 1 and 3 employees with the Job Title: ' || v_jobtitle);
        when 3 then
            dbms_output.put_line ('There are between 1 and 3 employees with the Job Title: ' || v_jobtitle);
        when 4 then
            dbms_output.put_line ('There are between 4 and 6 employees with the Job Title: ' || v_jobtitle);
        when 5 then
            dbms_output.put_line ('There are between 4 and 6 employees with the Job Title: ' || v_jobtitle);
        when 6 then
            dbms_output.put_line ('There are between 4 and 6 employees with the Job Title: ' || v_jobtitle);
        else
        dbms_output.put_line ('There are 7 or more employees with the Job Title: ' || v_jobtitle);
    end case;
end;
new:declare
    v_number_employees number;
    v_jobtitle         varchar2(50) := 'Assembly';
begin
    select count(employeeid)
        into v_number_employees
    from employee
    where jobtitle = v_jobtitle;

    case v_number_employees
        when 0 then
            dbms_output.put_line ('There are no employees with the Job Title: ' || v_jobtitle);
        when 1 then
            dbms_output.put_line ('There are between 1 and 3 employees with the Job Title: ' || v_jobtitle);
        when 2 then
            dbms_output.put_line ('There are between 1 and 3 employees with the Job Title: ' || v_jobtitle);
        when 3 then
            dbms_output.put_line ('There are between 1 and 3 employees with the Job Title: ' || v_jobtitle);
        when 4 then
            dbms_output.put_line ('There are between 4 and 6 employees with the Job Title: ' || v_jobtitle);
        when 5 then
            dbms_output.put_line ('There are between 4 and 6 employees with the Job Title: ' || v_jobtitle);
        when 6 then
            dbms_output.put_line ('There are between 4 and 6 employees with the Job Title: ' || v_jobtitle);
        else
        dbms_output.put_line ('There are 7 or more employees with the Job Title: ' || v_jobtitle);
    end case;
end;
There are 7 or more employees with the Job Title: Assembly


PL/SQL procedure successfully completed.
-- Question 13a
old:declare
    v_number_employees number;
    v_jobtitle         employee.jobtitle%type := '&v_jobtitle';
begin
    select count(employeeid)
        into v_number_employees
    from employee
    where jobtitle = v_jobtitle;

    case v_number_employees
        when 0 then
            dbms_output.put_line ('There are no employees with the Job Title: ' || v_jobtitle);
        when 1 then
            dbms_output.put_line ('There are between 1 and 3 employees with the Job Title: ' || v_jobtitle);
        when 2 then
            dbms_output.put_line ('There are between 1 and 3 employees with the Job Title: ' || v_jobtitle);
        when 3 then
            dbms_output.put_line ('There are between 1 and 3 employees with the Job Title: ' || v_jobtitle);
        when 4 then
            dbms_output.put_line ('There are between 4 and 6 employees with the Job Title: ' || v_jobtitle);
        when 5 then
            dbms_output.put_line ('There are between 4 and 6 employees with the Job Title: ' || v_jobtitle);
        when 6 then
            dbms_output.put_line ('There are between 4 and 6 employees with the Job Title: ' || v_jobtitle);
        else
        dbms_output.put_line ('There are 7 or more employees with the Job Title: ' || v_jobtitle);
    end case;
end;
new:declare
    v_number_employees number;
    v_jobtitle         employee.jobtitle%type := 'CIO';
begin
    select count(employeeid)
        into v_number_employees
    from employee
    where jobtitle = v_jobtitle;

    case v_number_employees
        when 0 then
            dbms_output.put_line ('There are no employees with the Job Title: ' || v_jobtitle);
        when 1 then
            dbms_output.put_line ('There are between 1 and 3 employees with the Job Title: ' || v_jobtitle);
        when 2 then
            dbms_output.put_line ('There are between 1 and 3 employees with the Job Title: ' || v_jobtitle);
        when 3 then
            dbms_output.put_line ('There are between 1 and 3 employees with the Job Title: ' || v_jobtitle);
        when 4 then
            dbms_output.put_line ('There are between 4 and 6 employees with the Job Title: ' || v_jobtitle);
        when 5 then
            dbms_output.put_line ('There are between 4 and 6 employees with the Job Title: ' || v_jobtitle);
        when 6 then
            dbms_output.put_line ('There are between 4 and 6 employees with the Job Title: ' || v_jobtitle);
        else
        dbms_output.put_line ('There are 7 or more employees with the Job Title: ' || v_jobtitle);
    end case;
end;
There are no employees with the Job Title: CIO


PL/SQL procedure successfully completed.

-- Question 13b
The %TYPE attribute allows you to declare a constant, variable, or parameter to be of the same 
data type as the previously declared variable.

-- Question 14
    old:declare
    v_number_employees number;
    v_jobtitle         employee.jobtitle%type := '&v_jobtitle';
    v_staff_level      varchar2(100);
begin
    select count(employeeid)
        into v_number_employees
    from employee
    where jobtitle = v_jobtitle;

    case v_number_employees
        when 0 then
            v_staff_level := 'There are no employees with the Job Title: ';
        when 1 then
             v_staff_level := 'There are between 1 and 3 employees with the Job Title: ';
        when 2 then
            v_staff_level := 'There are between 1 and 3 employees with the Job Title: ';
        when 3 then
            v_staff_level := 'There are between 1 and 3 employees with the Job Title: ';
        when 4 then
             v_staff_level :=  'There are between 4 and 6 employees with the Job Title: ';
        when 5 then
            v_staff_level :=  'There are between 4 and 6 employees with the Job Title: ';
        when 6 then
            v_staff_level :=  'There are between 4 and 6 employees with the Job Title: ';
        else
            v_staff_level := 'There are 7 or more employees with the Job Title: ';
    end case;

    --Output user friendly response
    dbms_output.put_line (v_staff_level || v_jobtitle);

end;
new:declare
    v_number_employees number;
    v_jobtitle         employee.jobtitle%type := 'Engineer';
    v_staff_level      varchar2(100);
begin
    select count(employeeid)
        into v_number_employees
    from employee
    where jobtitle = v_jobtitle;

    case v_number_employees
        when 0 then
            v_staff_level := 'There are no employees with the Job Title: ';
        when 1 then
             v_staff_level := 'There are between 1 and 3 employees with the Job Title: ';
        when 2 then
            v_staff_level := 'There are between 1 and 3 employees with the Job Title: ';
        when 3 then
            v_staff_level := 'There are between 1 and 3 employees with the Job Title: ';
        when 4 then
             v_staff_level :=  'There are between 4 and 6 employees with the Job Title: ';
        when 5 then
            v_staff_level :=  'There are between 4 and 6 employees with the Job Title: ';
        when 6 then
            v_staff_level :=  'There are between 4 and 6 employees with the Job Title: ';
        else
            v_staff_level := 'There are 7 or more employees with the Job Title: ';
    end case;

    --Output user friendly response
    dbms_output.put_line (v_staff_level || v_jobtitle);

end;
There are between 4 and 6 employees with the Job Title: Engineer


PL/SQL procedure successfully completed.

*/
