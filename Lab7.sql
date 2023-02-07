-- Austin Polak

-- Question 1a
CREATE OR REPLACE PACKAGE MATH_CONSTANTS
IS
    c_Pi CONSTANT NUMBER := acos(-1);
END MATH_CONSTANTS;

/
-- Question 1b - ANSWER IN RESULT
/
-- Question 1c
BEGIN
    DBMS_OUTPUT.PUT_LINE(MATH_CONSTANTS.c_Pi);
END;
/
-- Question 1d
SELECT C_Pi
FROM MATH_CONSTANTS;
/
-- Question 1e
CREATE OR REPLACE FUNCTION CALCULATE_AREA
(p_radius NUMBER)
    RETURN NUMBER
    AS
BEGIN
    RETURN ROUND(MATH_CONSTANTS.C_Pi * (p_radius * p_radius), 3);
END CALCULATE_AREA;
/
-- Question 1f
SELECT CALCULATE_AREA(5)
FROM DUAL;

SELECT CALCULATE_AREA(10)
FROM DUAL;

SELECT CALCULATE_AREA(15)
FROM DUAL;
/
-- Question 2a
create or replace function parse_firstname
(p_fullname supplier.contactname%TYPE)
return VARCHAR2 is
    v_firstname supplier.contactname%TYPE;
Begin
    v_firstname := substr(p_fullname, 1, instr(p_fullname, ' ', 1, 1) - 1);
    return v_firstname;
End parse_firstname;
/
-- Question 2b
select parse_firstname(contactname)
from supplier;
/
-- Question 2c
drop function parse_firstname;
/
-- Question 2d
create or replace package pkg_format_eagle_data is
function parse_firstname
(p_fullname supplier.contactname%TYPE)
    return VARCHAR2;
END pkg_format_eagle_data;
/
-- Question 2e
create or replace package body pkg_format_eagle_data is
function parse_firstname
(p_fullname supplier.contactname%TYPE)
    return VARCHAR2
is
    v_firstname
    supplier.contactname%TYPE;
begin
    v_firstname := substr(p_fullname, 1, instr(p_fullname, ' ', 1, 1) - 1);
    return v_firstname;
end parse_firstname;
END pkg_format_eagle_data;
/
-- Question 2f
select pkg_format_eagle_data.parse_firstname(contactname)
from supplier;
/
-- Question 2g
create or replace package pkg_format_eagle_data is 
function parse_firstname
(p_fullname supplier.contactname%TYPE)
return VARCHAR2;
    function parse_lastname
    (p_fullname supplier.contactname%TYPE)
return VARCHAR2;
End pkg_format_eagle_data;
/
-- Question 2h
create or replace package body pkg_format_eagle_data is 
function parse_firstname
(p_fullname supplier.contactname%TYPE)
return VARCHAR2 is
    v_firstname supplier.contactname%TYPE;
begin
    v_firstname := substr(p_fullname, 1, instr(p_fullname, ' ', 1, 1) - 1);
    return v_firstname;
end parse_firstname;

    function parse_lastname(
p_fullname supplier.contactname%TYPE)
return VARCHAR2 is
      v_lastname supplier.contactname%TYPE;
begin
    v_lastname := substr(p_fullname, instr(p_fullname, ' ', 1, 1) + 1);
    return v_lastname;
end parse_lastname;
End pkg_format_eagle_data;
/
-- Question 2i

select pkg_format_eagle_data.parse_lastname(contactname)
from supplier;

select pkg_format_eagle_data.parse_firstname(contactname)
from supplier;
/

-- Question 3a - e
CREATE OR REPLACE PACKAGE pkg_shape_calculations IS
    c_pi CONSTANT NUMBER := acos(-1);
 FUNCTION rectangle_area (
        p_length NUMBER,
        p_width NUMBER) 
    RETURN NUMBER;
 FUNCTION rectangle_area (
        p_length NUMBER)
    RETURN NUMBER;
 FUNCTION circle_area (
        p_radius NUMBER) 
    RETURN NUMBER;
END pkg_shape_calculations;


CREATE OR REPLACE PACKAGE BODY pkg_shape_calculations IS
 FUNCTION check_value (
        p_value NUMBER) 
    RETURN BOOLEAN IS
    v_bool BOOLEAN;
 BEGIN
    IF p_value > 0 THEN
        v_bool := true;
    ELSE
        v_bool := false;
    END IF;
 RETURN v_bool;
 END check_value;


 FUNCTION rectangle_area (
        p_length NUMBER,
        p_width NUMBER) 
    RETURN NUMBER IS
        v_area NUMBER;
 BEGIN
    IF check_value(p_length) = true AND check_value(p_width) = true THEN
        v_area := p_length * p_width;
    ELSE
        v_area := -1;
        dbms_output.put_line('Length and width must be greater than 0');
    END IF;
 RETURN v_area;
    EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put(sqlcode);
        dbms_output.put(': ');
        dbms_output.put_line(substr(sqlerrm, 1, 100));
 END rectangle_area;


 FUNCTION rectangle_area (
        p_length NUMBER) 
    RETURN NUMBER IS
        v_area NUMBER;
 BEGIN
    IF check_value(p_length) = true THEN
        v_area := p_length * p_length;
    ELSE
        v_area := -1;
        dbms_output.put_line('Length must be greater than 0');
    END IF;
 RETURN v_area;
    EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put(sqlcode);
        dbms_output.put(': ');
        dbms_output.put_line(substr(sqlerrm, 1, 100));
 END rectangle_area;


 FUNCTION circle_area (
        p_radius NUMBER) 
    RETURN NUMBER IS
        v_area NUMBER;
 BEGIN
    IF check_value(p_radius) = true THEN
        v_area := c_pi * p_radius * p_radius;
    ELSE
        v_area := -1;
        dbms_output.put_line('Radius must be greater than 0');
 END IF;
    RETURN v_area;
        EXCEPTION
        WHEN OTHERS THEN
            dbms_output.put(sqlcode);
            dbms_output.put(': ');
            dbms_output.put_line(substr(sqlerrm, 1, 100));
    END circle_area;
END pkg_shape_calculations;

/
-- Question 3f
select PKG_SHAPE_CALCULATIONS.rectangle_area(6,2)
from dual;

select PKG_SHAPE_CALCULATIONS.rectangle_area(6,0)
from dual;

select PKG_SHAPE_CALCULATIONS.rectangle_area(-6,4)
from dual;

select PKG_SHAPE_CALCULATIONS.rectangle_area(5)
from dual;

select PKG_SHAPE_CALCULATIONS.rectangle_area(0)
from dual;

select PKG_SHAPE_CALCULATIONS.rectangle_area(-2)
from dual;

select PKG_SHAPE_CALCULATIONS.circle_area(6)
from dual;

select PKG_SHAPE_CALCULATIONS.circle_area(0)
from dual;

select PKG_SHAPE_CALCULATIONS.circle_area(-4)
from dual;
/

/* RESULTS
-- Question 1a
Package MATH_CONSTANTS compiled

-- Question 1b
The inverse cosine function.
acos(-1) is equal to Pi


-- Question 1c
PL/SQL procedure successfully completed.

3.1415926535897932384626433832795028842

-- Question 1d

No, you will recieve an errror.

Error starting at line : 18 in command -
SELECT C_Pi
FROM MATH_CONSTANTS
Error at Command Line : 19 Column : 6
Error report -
SQL Error: ORA-04044: procedure, function, package, or type is not allowed here
04044. 00000 -  "procedure, function, package, or type is not allowed here"
*Cause:    A procedure, function, or package was specified in an
           inappropriate place in a statement.
*Action:   Make sure the name is correct or remove it.

-- Question 1e

Function CALCULATE_AREA compiled

-- Question 1f

CALCULATE_AREA(5)
-----------------
            78.54


CALCULATE_AREA(10)
------------------
           314.159


CALCULATE_AREA(15)
------------------
           706.858

-- Question 2a

Function PARSE_FIRSTNAME compiled

-- Question 2b

PARSE_FIRSTNAME(CONTACTNAME)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
-------------------------------
Dorthy
Rob
Sandy
Timothy
Adam
William
Debra
Paul
Kelli
Kevin
Loraine

PARSE_FIRSTNAME(CONTACTNAME)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
------------------------------
Wade
Elizabeth
David
Alice
Gordon
Jamie
Donald
Lance
Gary
Tim
Darlene

PARSE_FIRSTNAME(CONTACTNAME)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
-----------------------------
Pam
Thurman
Jennie
Travis
Stephen
Yauleng
Brenda

29 rows selected. 



-- Question 2c

Function PARSE_FIRSTNAME dropped.

-- Question 2d

Package PKG_FORMAT_EAGLE_DATA compiled

-- Question 2e

Package Body PKG_FORMAT_EAGLE_DATA compiled

-- Question 2f

PKG_FORMAT_EAGLE_DATA.PARSE_FIRSTNAME(CONTACTNAME)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
---------------------------------------------------
Dorthy
Rob
Sandy
Timothy
Adam
William
Debra
Paul
Kelli
Kevin
Loraine

PKG_FORMAT_EAGLE_DATA.PARSE_FIRSTNAME(CONTACTNAME)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
---------------------------------------------------
Wade
Elizabeth
David
Alice
Gordon
Jamie
Donald
Lance
Gary
Tim
Darlene

PKG_FORMAT_EAGLE_DATA.PARSE_FIRSTNAME(CONTACTNAME)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
----------------------------------------------------
Pam
Thurman
Jennie
Travis
Stephen
Yauleng
Brenda

29 rows selected. 

-- Question 2g

Package PKG_FORMAT_EAGLE_DATA compiled

-- Question 2h

Package Body PKG_FORMAT_EAGLE_DATA compiled

-- Question 2i


PKG_FORMAT_EAGLE_DATA.PARSE_LASTNAME(CONTACTNAME)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
--------------------------------------------------
Beering
Thomas
Goodman
Neal
Cyr
Newlon
Cruz
Smith
Jones
Martin
Platt

PKG_FORMAT_EAGLE_DATA.PARSE_LASTNAME(CONTACTNAME)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
---------------------------------------------------
Holle
Clark
Becker
Mynhier
Mayes
Pickett
Blythe
Andrews
Mikels
White
Jenkins

PKG_FORMAT_EAGLE_DATA.PARSE_LASTNAME(CONTACTNAME)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
--------------------------------------------------
Krick
Mezzo
Fry
Honn
Bird
Depoe
Pritchett

29 rows selected. 


PKG_FORMAT_EAGLE_DATA.PARSE_FIRSTNAME(CONTACTNAME)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
---------------------------------------------------
Dorthy
Rob
Sandy
Timothy
Adam
William
Debra
Paul
Kelli
Kevin
Loraine

PKG_FORMAT_EAGLE_DATA.PARSE_FIRSTNAME(CONTACTNAME)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
----------------------------------------------------
Wade
Elizabeth
David
Alice
Gordon
Jamie
Donald
Lance
Gary
Tim
Darlene

PKG_FORMAT_EAGLE_DATA.PARSE_FIRSTNAME(CONTACTNAME)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
---------------------------------------------------
Pam
Thurman
Jennie
Travis
Stephen
Yauleng
Brenda

29 rows selected. 

-- Question 3a - e

Package PKG_SHAPE_CALCULATIONS compiled


Package Body PKG_SHAPE_CALCULATIONS compiled

--Question 3c
To keep c_pi hidden. Protects the integrity of the package and simpligies maintenance.
Any change to the private element will impact the package.


-- Question 3f

PKG_SHAPE_CALCULATIONS.RECTANGLE_AREA(6,2)
------------------------------------------
                                        12


PKG_SHAPE_CALCULATIONS.RECTANGLE_AREA(6,0)
------------------------------------------
                                        -1


PKG_SHAPE_CALCULATIONS.RECTANGLE_AREA(-6,4)
-------------------------------------------
                                         -1


PKG_SHAPE_CALCULATIONS.RECTANGLE_AREA(5)
----------------------------------------
                                      25


PKG_SHAPE_CALCULATIONS.RECTANGLE_AREA(0)
----------------------------------------
                                      -1


PKG_SHAPE_CALCULATIONS.RECTANGLE_AREA(-2)
-----------------------------------------
                                       -1


PKG_SHAPE_CALCULATIONS.CIRCLE_AREA(6)
-------------------------------------
                           113.097336


PKG_SHAPE_CALCULATIONS.CIRCLE_AREA(0)
-------------------------------------
                                   -1


PKG_SHAPE_CALCULATIONS.CIRCLE_AREA(-4)
--------------------------------------
                                    -1



*/
