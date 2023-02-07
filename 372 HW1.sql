HW1
--Mark Holstrom
--Jeffrey Tsai
--Austin Polak
Question1 

CREATE TABLE firstname
( firstName VARCHAR2(20)
);

CREATE TABLE lastname
( lastName VARCHAR2(20)
);

CREATE TABLE city
( city VARCHAR2(20)
);

CREATE TABLE state
( state VARCHAR2(20)
);

CREATE TABLE HW1_Q1_CONTACT
(
firstName VARCHAR2(20)
lastName VARCHAR2(20)
city VARCHAR2(20)
state VARCHAR2(20)
);

SELECT *
FROM STATE CROSS JOIN HW1_Q1_CONTACT
ON 


CREATE TABLE Firstname
( FirstName VARCHAR2(20)
);
CREATE TABLE Lastname
( LastName VARCHAR2(20)
);
CREATE TABLE City
( City VARCHAR2(20)
);

CREATE TABLE State
( state VARCHAR2(20)
);

CREATE TABLE HW1_Q1_CONTACT
(
firstname varchar2(100),
lastname varchar2(100),
city varchar2(100),
state varchar2(100)
);



insert into Firstname
select custfirstname from customer
where customerid between 'C-300001' and 'C-300060';

select Firstname from Firstname;

insert into Lastname
select custlastname from customer
where customerid between 'C-300001' and 'C-300060';

select Lastname from Lastname;

select distinct * from Firstname cross join Lastname;

insert into City
select city from customer
where customerid between 'C-300001' and 'C-300060';

insert into State
select State from customer
where customerid between 'C-300001' and 'C-300060';

insert into HW1_Q1_CONTACT
select distinct * from Firstname cross join Lastname cross join City cross join State;

select customerid from customer


drop TABLE Firstname;
drop TABLE Lastname;
drop TABLE City;
drop TABLE State;
drop TABLE HW1_Q1_CONTACT;

--Question 2
--q2a
CREATE OR REPLACE PROCEDURE generate_multiplication_table (
    p_gmt IN INTEGER
) IS
    i  INTEGER := 1;
    ii INTEGER;
BEGIN
    IF
        p_gmt > 0
        AND p_gmt <= 15
    THEN
        FOR i IN 1..p_gmt LOOP
            FOR ii IN 1..p_gmt LOOP
                dbms_output.put(rpad(i * ii, 5, ' '));
            END LOOP;

            dbms_output.new_line;
        END LOOP outer;

    ELSIF p_gmt = 0 THEN
        dbms_output.put_line('Error. Must have to be in between 1 to 15');
    ELSE
        dbms_output.put_line('Error. Must have to be in between 1 to 15');
    END IF;
END generate_multiplication_table;
/

exec GENERATE_MULTIPLICATION_TABLE(3);
exec GENERATE_MULTIPLICATION_TABLE(8);
exec GENERATE_MULTIPLICATION_TABLE(14);

/

--q2b
CREATE OR REPLACE PROCEDURE generate_multiplication_table (
    p_gmt IN INTEGER
) IS
    i  INTEGER := 1;
    ii INTEGER;
BEGIN
    IF p_gmt < 0 OR p_gmt > 15 THEN
        dbms_output.put_line('Error. Must have to be in between 1 to 15');
    ELSE
        WHILE i <= p_gmt LOOP
            ii := 1;
            WHILE ii <= p_gmt LOOP
                dbms_output.put(rpad(i * ii, 5, ' '));
                ii := ii + 1;
                EXIT WHEN i > p_gmt;
            END LOOP;

            dbms_output.new_line;
            i := i + 1;
            EXIT WHEN i > p_gmt;
        END LOOP;
    END IF;
END generate_multiplication_table;
/

exec GENERATE_MULTIPLICATION_TABLE(3);
exec GENERATE_MULTIPLICATION_TABLE(8);
exec GENERATE_MULTIPLICATION_TABLE(14);

--q2c
CREATE OR REPLACE PROCEDURE generate_multiplication_table (
    p_gmt IN INTEGER
) IS
    i  INTEGER := 1;
    ii INTEGER := 1;
BEGIN
    IF p_gmt < 0 OR p_gmt > 15 THEN
        dbms_output.put_line('Error. Must have to be in between 1 to 15');
    ELSE
        LOOP
            ii := 1;
            LOOP
                dbms_output.put(rpad(i * ii, 5, ' '));
                ii := ii + 1;
                EXIT WHEN ii > p_gmt;
            END LOOP;

            dbms_output.new_line;
            i := i + 1;
            EXIT WHEN i > p_gmt;
        END LOOP;
    END IF;
END generate_multiplication_table;
/


exec GENERATE_MULTIPLICATION_TABLE(3);
exec GENERATE_MULTIPLICATION_TABLE(8);
exec GENERATE_MULTIPLICATION_TABLE(14);

/*RESULTS
--q1
6,088,269 rows inserted.

--q2a
1    2    3    
2    4    6    
3    6    9    

1    2    3    4    5    6    7    8    
2    4    6    8    10   12   14   16   
3    6    9    12   15   18   21   24   
4    8    12   16   20   24   28   32   
5    10   15   20   25   30   35   40   
6    12   18   24   30   36   42   48   
7    14   21   28   35   42   49   56   
8    16   24   32   40   48   56   64   

1    2    3    4    5    6    7    8    9    10   11   12   13   14   
2    4    6    8    10   12   14   16   18   20   22   24   26   28   
3    6    9    12   15   18   21   24   27   30   33   36   39   42   
4    8    12   16   20   24   28   32   36   40   44   48   52   56   
5    10   15   20   25   30   35   40   45   50   55   60   65   70   
6    12   18   24   30   36   42   48   54   60   66   72   78   84   
7    14   21   28   35   42   49   56   63   70   77   84   91   98   
8    16   24   32   40   48   56   64   72   80   88   96   104  112  
9    18   27   36   45   54   63   72   81   90   99   108  117  126  
10   20   30   40   50   60   70   80   90   100  110  120  130  140  
11   22   33   44   55   66   77   88   99   110  121  132  143  154  
12   24   36   48   60   72   84   96   108  120  132  144  156  168  
13   26   39   52   65   78   91   104  117  130  143  156  169  182  
14   28   42   56   70   84   98   112  126  140  154  168  182  196

--q2b
1    2    3    
2    4    6    
3    6    9    

1    2    3    4    5    6    7    8    
2    4    6    8    10   12   14   16   
3    6    9    12   15   18   21   24   
4    8    12   16   20   24   28   32   
5    10   15   20   25   30   35   40   
6    12   18   24   30   36   42   48   
7    14   21   28   35   42   49   56   
8    16   24   32   40   48   56   64   

1    2    3    4    5    6    7    8    9    10   11   12   13   14   
2    4    6    8    10   12   14   16   18   20   22   24   26   28   
3    6    9    12   15   18   21   24   27   30   33   36   39   42   
4    8    12   16   20   24   28   32   36   40   44   48   52   56   
5    10   15   20   25   30   35   40   45   50   55   60   65   70   
6    12   18   24   30   36   42   48   54   60   66   72   78   84   
7    14   21   28   35   42   49   56   63   70   77   84   91   98   
8    16   24   32   40   48   56   64   72   80   88   96   104  112  
9    18   27   36   45   54   63   72   81   90   99   108  117  126  
10   20   30   40   50   60   70   80   90   100  110  120  130  140  
11   22   33   44   55   66   77   88   99   110  121  132  143  154  
12   24   36   48   60   72   84   96   108  120  132  144  156  168  
13   26   39   52   65   78   91   104  117  130  143  156  169  182  
14   28   42   56   70   84   98   112  126  140  154  168  182  196

--q2c
1    2    3    
2    4    6    
3    6    9    

1    2    3    4    5    6    7    8    
2    4    6    8    10   12   14   16   
3    6    9    12   15   18   21   24   
4    8    12   16   20   24   28   32   
5    10   15   20   25   30   35   40   
6    12   18   24   30   36   42   48   
7    14   21   28   35   42   49   56   
8    16   24   32   40   48   56   64   

1    2    3    4    5    6    7    8    9    10   11   12   13   14   
2    4    6    8    10   12   14   16   18   20   22   24   26   28   
3    6    9    12   15   18   21   24   27   30   33   36   39   42   
4    8    12   16   20   24   28   32   36   40   44   48   52   56   
5    10   15   20   25   30   35   40   45   50   55   60   65   70   
6    12   18   24   30   36   42   48   54   60   66   72   78   84   
7    14   21   28   35   42   49   56   63   70   77   84   91   98   
8    16   24   32   40   48   56   64   72   80   88   96   104  112  
9    18   27   36   45   54   63   72   81   90   99   108  117  126  
10   20   30   40   50   60   70   80   90   100  110  120  130  140  
11   22   33   44   55   66   77   88   99   110  121  132  143  154  
12   24   36   48   60   72   84   96   108  120  132  144  156  168  
13   26   39   52   65   78   91   104  117  130  143  156  169  182  
14   28   42   56   70   84   98   112  126  140  154  168  182  196
*/
