-- Group Members: Austin Polak, Jeffrey Tsai, Zhenyou Liu, Dylan Goudy
-- CNIT372
-- Project Bookstore Management 

drop table BRANCH;
drop table BOOK;
drop table CLIENT;
DROP TABLE BOOK_CATEGORY;
DROP TABLE BOOKDETAIL;
drop table CLIENTORDER;


Create Table BRANCH (
    BRANCHID VARCHAR2(10) PRIMARY KEY,
    MANAGERID NUMBER(10),
    ADDRESS VARCHAR2(30),
    CITY VARCHAR2(20),
    STATE VARCHAR2(2)
    );
    
CREATE TABLE BOOK_CATEGORY(
    CATEGORYID VARCHAR2(10) PRIMARY KEY,
    CATEGORY_NAME VARCHAR2(25));
    
create table BOOK(
    bookID varchar2(5) Primary Key,
    CATEGORYID VARCHAR2(10) NOT NULL,
    bookTitle varchar2(50),
    a_firstname varchar2(15),
    a_lastname varchar2(15),
    release_date date,
    status varchar2(10),
    price number,
    CONSTRAINT BOOK_fk1 FOREIGN KEY ( CATEGORYID ) REFERENCES BOOK_CATEGORY ( CATEGORYID )
    );

create table CLIENT(
    clientid varchar2(5) Primary Key,
    firstname varchar2(15),
    lastname varchar2(15),
    birth date,
    email varchar2(50),
    phone varchar2(10),
    state varchar2(2)
    );
    
CREATE TABLE BOOKDETAIL (
    bookid   VARCHAR2(5) NOT NULL,
    branchid VARCHAR2(10) NOT NULL,
    amount   NUMBER,
    CONSTRAINT bookdetail_pk PRIMARY KEY ( bookid, branchid ),
    CONSTRAINT bookdetail_fk1 foreign key (bookid) REFERENCES BOOK(bookid),
    CONSTRAINT bookdetail_fk2 foreign key (branchid) REFERENCES BRANCH(branchid)
);

CREATE TABLE CLIENTORDER (
    orderid     VARCHAR2(5) NOT NULL,
    bookid      VARCHAR2(5) NOT NULL,
    clientid    VARCHAR2(10) NOT NULL,
    orderdate   DATE,
    requiredate DATE,
    CONSTRAINT order_pk PRIMARY KEY ( orderid ),
    CONSTRAINT order_fk1 FOREIGN KEY ( bookid ) REFERENCES book ( bookid ),
    CONSTRAINT order_fk2 FOREIGN KEY ( clientid ) REFERENCES client ( clientid )
);
    
INSERT INTO Branch VALUES ('BR1',1101,'7862 Grant Dr.','Lake Forest','CA');
INSERT INTO Branch VALUES ('BR2',1201,'5 Marconi Road','Oklahoma City','OK');
INSERT INTO Branch VALUES ('BR3',1301,'100 W. Randolph St.','Chicago','IL');
INSERT INTO Branch VALUES ('BR4',1401,'4090 Cambridge Dr.','New River','AZ');
INSERT INTO Branch VALUES ('BR5',1501,'517 Rollo St.','Austin','TX');
INSERT INTO Branch VALUES ('BR6',1601,'1516 Wendall Rd.','Tampa','FL');
INSERT INTO Branch VALUES ('BR7',1701,'669 Hoohie Ave.','Portlan','OR');
INSERT INTO Branch VALUES ('BR8',1801,'312 Elm Street.','Yonker','NY');

----

INSERT INTO BOOK_CATEGORY (CATEGORYID, CATEGORY_NAME) 
VALUES ('C001', 'Action and Adventure.');

INSERT INTO BOOK_CATEGORY (CATEGORYID, CATEGORY_NAME) 
VALUES ('C002', 'Non-fiction.');

INSERT INTO BOOK_CATEGORY (CATEGORYID, CATEGORY_NAME) 
VALUES ('C003', 'Graphic Novel.');

INSERT INTO BOOK_CATEGORY (CATEGORYID, CATEGORY_NAME) 
VALUES ('C004', 'Mystery.');

INSERT INTO BOOK_CATEGORY (CATEGORYID, CATEGORY_NAME) 
VALUES ('C005', 'Fantasy.');

INSERT INTO BOOK_CATEGORY (CATEGORYID, CATEGORY_NAME) 
VALUES ('C006', 'Historical Fiction.');

INSERT INTO BOOK_CATEGORY (CATEGORYID, CATEGORY_NAME) 
VALUES ('C007', 'Horror.');

INSERT INTO BOOK_CATEGORY (CATEGORYID, CATEGORY_NAME) 
VALUES ('C008', 'Literary Fiction.');

----

INSERT INTO BOOK (BOOKID, CATEGORYID, BOOKTITLE, A_FIRSTNAME, A_LASTNAME, RELEASE_DATE, STATUS, PRICE) 
VALUES ('1001', 'C001', 'To Kill a Mockingbird', 'Harper', 'Lee', to_date('11/01/1960', 'MM/DD/RRRR'), 'OutofStock', 9.99);

INSERT INTO BOOK (BOOKID, CATEGORYID, BOOKTITLE, A_FIRSTNAME, A_LASTNAME, RELEASE_DATE, STATUS, PRICE) 
VALUES ('1002', 'C005', 'Pride and Prejudice', 'Jane', 'Austen', to_date('11/02/1960', 'MM/DD/RRRR'), 'InStock', 10.99);

INSERT INTO BOOK (BOOKID, CATEGORYID, BOOKTITLE, A_FIRSTNAME, A_LASTNAME, RELEASE_DATE, STATUS, PRICE) 
VALUES ('1003', 'C002', 'Anne Frank: The Diary of a Young Girl', 'Anne', 'Frank', to_date('11/03/1960', 'MM/DD/RRRR'), 'InStock', 12.99);

INSERT INTO BOOK (BOOKID, CATEGORYID, BOOKTITLE, A_FIRSTNAME, A_LASTNAME, RELEASE_DATE, STATUS, PRICE) 
VALUES ('1004', 'C003', '1984', 'George', 'Orwell', to_date('11/04/1960', 'MM/DD/RRRR'), 'OutofStock', 15.99);

INSERT INTO BOOK (BOOKID, CATEGORYID, BOOKTITLE, A_FIRSTNAME, A_LASTNAME, RELEASE_DATE, STATUS, PRICE) 
VALUES ('1005', 'C004', 'Harry Potteer and the Sorcerer''s Stone', 'JK', 'Rowling', to_date('11/05/1960', 'MM/DD/RRRR'), 'InStock', 17.49);

INSERT INTO BOOK (BOOKID, CATEGORYID, BOOKTITLE, A_FIRSTNAME, A_LASTNAME, RELEASE_DATE, STATUS, PRICE) 
VALUES ('1006', 'C005', 'The Lord of the Rings', 'J. R. R.', 'Tolkien', to_date('11/06/1960', 'MM/DD/RRRR'), 'InStock', 9.99);

INSERT INTO BOOK (BOOKID, CATEGORYID, BOOKTITLE, A_FIRSTNAME, A_LASTNAME, RELEASE_DATE, STATUS, PRICE) 
VALUES ('1007', 'C006', 'The Great Gatsby', 'F. Scott', 'Fitzgerald', to_date('11/07/1960', 'MM/DD/RRRR'), 'InStock', 10.99);

INSERT INTO BOOK (BOOKID, CATEGORYID, BOOKTITLE, A_FIRSTNAME, A_LASTNAME, RELEASE_DATE, STATUS, PRICE) 
VALUES ('1008', 'C006', 'Charlotte''s Web', 'E. B.', 'White', to_date('11/08/1960', 'MM/DD/RRRR'), 'InStock', 12.99);

INSERT INTO BOOK (BOOKID, CATEGORYID, BOOKTITLE, A_FIRSTNAME, A_LASTNAME, RELEASE_DATE, STATUS, PRICE) 
VALUES ('1009', 'C007', 'Little Women', 'Louisa', 'May Alcott', to_date('11/09/1960', 'MM/DD/RRRR'), 'InStock', 15.99);

INSERT INTO BOOK (BOOKID, CATEGORYID, BOOKTITLE, A_FIRSTNAME, A_LASTNAME, RELEASE_DATE, STATUS, PRICE) 
VALUES ('1010', 'C007', 'The Hobbit', 'J. R. R.', 'Tolkien', to_date('11/10/1960', 'MM/DD/RRRR'), 'InStock', 10.99);

INSERT INTO BOOK (BOOKID, CATEGORYID, BOOKTITLE, A_FIRSTNAME, A_LASTNAME, RELEASE_DATE, STATUS, PRICE) 
VALUES ('1011', 'C006', 'Fahrenheit 451: A Novel', 'Ray', 'Bradbury', to_date('11/11/1960', 'MM/DD/RRRR'), 'InStock', 9.99);

INSERT INTO BOOK (BOOKID, CATEGORYID, BOOKTITLE, A_FIRSTNAME, A_LASTNAME, RELEASE_DATE, STATUS, PRICE) 
VALUES ('1012', 'C008', 'Jane Eyre', 'Charlotte', 'Bronte', to_date('11/12/1960', 'MM/DD/RRRR'), 'InStock', 10.99);

INSERT INTO BOOK (BOOKID, CATEGORYID, BOOKTITLE, A_FIRSTNAME, A_LASTNAME, RELEASE_DATE, STATUS, PRICE) 
VALUES ('1013', 'C008', 'Gone With the Wind', 'Margaret', 'Mitchell', to_date('11/13/1960', 'MM/DD/RRRR'), 'InStock', 12.99);

INSERT INTO BOOK (BOOKID, CATEGORYID, BOOKTITLE, A_FIRSTNAME, A_LASTNAME, RELEASE_DATE, STATUS, PRICE) 
VALUES ('1014', 'C001', 'Animal Farm', 'George', 'Orwell', to_date('11/14/1960', 'MM/DD/RRRR'), 'InStock', 15.99);

INSERT INTO BOOK (BOOKID, CATEGORYID, BOOKTITLE, A_FIRSTNAME, A_LASTNAME, RELEASE_DATE, STATUS, PRICE) 
VALUES ('1015', 'C002', 'The Catcher in the Rye', 'J. D.', 'Salinger', to_date('11/15/1960', 'MM/DD/RRRR'), 'InStock', 7.99);

-----

INSERT INTO CLIENT (CLIENTID, FIRSTNAME, LASTNAME, BIRTH, EMAIL, PHONE, STATE) 
VALUES ('2001', 'Paul', 'George', to_date('03/01/1990', 'MM/DD/RRRR'), 'abc001@nbamail.com', '765123021', 'OK');

INSERT INTO CLIENT (CLIENTID, FIRSTNAME, LASTNAME, BIRTH, EMAIL, PHONE, STATE) 
VALUES ('2002', 'Michael', 'Jordan', to_date('03/02/1990', 'MM/DD/RRRR'), 'abc002@nbamail.com', '765123022', 'IL');

INSERT INTO CLIENT (CLIENTID, FIRSTNAME, LASTNAME, BIRTH, EMAIL, PHONE, STATE) 
VALUES ('2003', 'Klay', 'Thompson', to_date('03/03/1990', 'MM/DD/RRRR'), 'abc003@nbamail.com', '765123023', 'CA');

INSERT INTO CLIENT (CLIENTID, FIRSTNAME, LASTNAME, BIRTH, EMAIL, PHONE, STATE) 
VALUES ('2004', 'Stephen ', 'Curry', to_date('03/04/1990', 'MM/DD/RRRR'), 'abc004@nbamail.com', '765123024', 'CA');

INSERT INTO CLIENT (CLIENTID, FIRSTNAME, LASTNAME, BIRTH, EMAIL, PHONE, STATE) 
VALUES ('2005', 'Chris', 'Paul', to_date('03/05/1990', 'MM/DD/RRRR'), 'abc005@nbamail.com', '765123025', 'AZ');

INSERT INTO CLIENT (CLIENTID, FIRSTNAME, LASTNAME, BIRTH, EMAIL, PHONE, STATE) 
VALUES ('2006', 'Marc', 'Gasol', to_date('03/06/1990', 'MM/DD/RRRR'), 'abc006@nbamail.com', '765123026', 'CA');

INSERT INTO CLIENT (CLIENTID, FIRSTNAME, LASTNAME, BIRTH, EMAIL, PHONE, STATE) 
VALUES ('2007', 'Kobe ', 'Bryant', to_date('03/07/1990', 'MM/DD/RRRR'), 'abc007@nbamail.com', '765123027', 'CA');

INSERT INTO CLIENT (CLIENTID, FIRSTNAME, LASTNAME, BIRTH, EMAIL, PHONE, STATE) 
VALUES ('2008', 'Tony', 'Parker', to_date('03/08/1990', 'MM/DD/RRRR'), 'abc008@nbamail.com', '765123028', 'TX');

INSERT INTO CLIENT (CLIENTID, FIRSTNAME, LASTNAME, BIRTH, EMAIL, PHONE, STATE) 
VALUES ('2009', 'Tim', 'Duncan', to_date('03/09/1990', 'MM/DD/RRRR'), 'abc009@nbamail.com', '765123029', 'TX');

INSERT INTO CLIENT (CLIENTID, FIRSTNAME, LASTNAME, BIRTH, EMAIL, PHONE, STATE) 
VALUES ('2010', 'Malik', 'Monk', to_date('03/10/1990', 'MM/DD/RRRR'), 'abc010@nbamail.com', '765123030', 'CA');

INSERT INTO CLIENT (CLIENTID, FIRSTNAME, LASTNAME, BIRTH, EMAIL, PHONE, STATE) 
VALUES ('2011', 'Damian', 'Lillard', to_date('03/11/1990', 'MM/DD/RRRR'), 'abc011@nbamail.com', '765123031', 'OR');

INSERT INTO CLIENT (CLIENTID, FIRSTNAME, LASTNAME, BIRTH, EMAIL, PHONE, STATE) 
VALUES ('2012', 'Jimmy', 'Butler', to_date('03/12/1990', 'MM/DD/RRRR'), 'abc012@nbamail.com', '765123032', 'FL');

INSERT INTO CLIENT (CLIENTID, FIRSTNAME, LASTNAME, BIRTH, EMAIL, PHONE, STATE) 
VALUES ('2013', 'Luka', 'Doncic', to_date('03/13/1990', 'MM/DD/RRRR'), 'abc013@nbamail.com', '765123033', 'TX');

INSERT INTO CLIENT (CLIENTID, FIRSTNAME, LASTNAME, BIRTH, EMAIL, PHONE, STATE) 
VALUES ('2014', 'Lebron', 'James', to_date('03/14/1990', 'MM/DD/RRRR'), 'abc014@nbamail.com', '765123034', 'CA');

INSERT INTO CLIENT (CLIENTID, FIRSTNAME, LASTNAME, BIRTH, EMAIL, PHONE, STATE) 
VALUES ('2015', 'James', 'Harden', to_date('03/15/1990', 'MM/DD/RRRR'), 'abc015@nbamail.com', '765123035', 'NY');

INSERT INTO CLIENT (CLIENTID, FIRSTNAME, LASTNAME, BIRTH, EMAIL, PHONE, STATE) 
VALUES ('2016', 'Kevin', 'Durant', to_date('03/16/1990', 'MM/DD/RRRR'), 'abc016@nbamail.com', '765123036', 'NY');

INSERT INTO CLIENT (CLIENTID, FIRSTNAME, LASTNAME, BIRTH, EMAIL, PHONE, STATE) 
VALUES ('2017', 'Devin', 'Booker', to_date('03/17/1990', 'MM/DD/RRRR'), 'abc017@nbamail.com', '765123037', 'AZ');

INSERT INTO CLIENT (CLIENTID, FIRSTNAME, LASTNAME, BIRTH, EMAIL, PHONE, STATE) 
VALUES ('2018', 'Victor', 'Oladipo', to_date('03/18/1990', 'MM/DD/RRRR'), 'abc018@nbamail.com', '765123038', 'FL');

INSERT INTO CLIENT (CLIENTID, FIRSTNAME, LASTNAME, BIRTH, EMAIL, PHONE, STATE) 
VALUES ('2019', 'Duncan', 'Robinson', to_date('03/19/1990', 'MM/DD/RRRR'), 'abc019@nbamail.com', '765123039', 'FL');

INSERT INTO CLIENT (CLIENTID, FIRSTNAME, LASTNAME, BIRTH, EMAIL, PHONE, STATE) 
VALUES ('2020', 'Rui', 'Hachimura', to_date('03/20/1990', 'MM/DD/RRRR'), 'abc020@nbamail.com', '765123040', 'DC');

----

INSERT INTO CLIENTORDER (ORDERID, CLIENTID, BOOKID, ORDERDATE, REQUIREDATE) 
VALUES ('3001', '2001', '1001', to_date('8-Mar-11', 'DD-MON-RR'), to_date('10-Mar-11', 'DD-MON-RR'));
INSERT INTO CLIENTORDER (ORDERID, CLIENTID, BOOKID, ORDERDATE, REQUIREDATE) 
VALUES ('3002', '2001', '1002', to_date('8-Mar-11', 'DD-MON-RR'), to_date('10-Mar-11', 'DD-MON-RR'));
INSERT INTO CLIENTORDER (ORDERID, CLIENTID, BOOKID, ORDERDATE, REQUIREDATE) 
VALUES ('3003', '2001', '1003', to_date('8-Mar-11', 'DD-MON-RR'), to_date('10-Mar-11', 'DD-MON-RR'));
INSERT INTO CLIENTORDER (ORDERID, CLIENTID, BOOKID, ORDERDATE, REQUIREDATE) 
VALUES ('3004', '2002', '1004', to_date('9-Mar-11', 'DD-MON-RR'), to_date('10-Mar-11', 'DD-MON-RR'));
INSERT INTO CLIENTORDER (ORDERID, CLIENTID, BOOKID, ORDERDATE, REQUIREDATE) 
VALUES ('3005', '2002', '1005', to_date('9-Mar-11', 'DD-MON-RR'), to_date('10-Mar-11', 'DD-MON-RR'));
INSERT INTO CLIENTORDER (ORDERID, CLIENTID, BOOKID, ORDERDATE, REQUIREDATE) 
VALUES ('3006', '2003', '1006', to_date('10-Mar-11', 'DD-MON-RR'), to_date('10-Mar-11', 'DD-MON-RR'));
INSERT INTO CLIENTORDER (ORDERID, CLIENTID, BOOKID, ORDERDATE, REQUIREDATE) 
VALUES ('3007', '2003', '1007', to_date('10-Mar-11', 'DD-MON-RR'), to_date('11-Mar-11', 'DD-MON-RR'));
INSERT INTO CLIENTORDER (ORDERID, CLIENTID, BOOKID, ORDERDATE, REQUIREDATE) 
VALUES ('3008', '2003', '1008', to_date('10-Mar-11', 'DD-MON-RR'), to_date('12-Mar-11', 'DD-MON-RR'));
INSERT INTO CLIENTORDER (ORDERID, CLIENTID, BOOKID, ORDERDATE, REQUIREDATE) 
VALUES ('3009', '2003', '1009', to_date('10-Mar-11', 'DD-MON-RR'), to_date('13-Mar-11', 'DD-MON-RR'));
INSERT INTO CLIENTORDER (ORDERID, CLIENTID, BOOKID, ORDERDATE, REQUIREDATE) 
VALUES ('3010', '2004', '1010', to_date('10-Mar-11', 'DD-MON-RR'), to_date('14-Mar-11', 'DD-MON-RR'));
INSERT INTO CLIENTORDER (ORDERID, CLIENTID, BOOKID, ORDERDATE, REQUIREDATE) 
VALUES ('3011', '2004', '1011', to_date('10-Mar-11', 'DD-MON-RR'), to_date('15-Mar-11', 'DD-MON-RR'));
INSERT INTO CLIENTORDER (ORDERID, CLIENTID, BOOKID, ORDERDATE, REQUIREDATE) 
VALUES ('3012', '2010', '1012', to_date('11-Mar-11', 'DD-MON-RR'), to_date('16-Mar-11', 'DD-MON-RR'));
INSERT INTO CLIENTORDER (ORDERID, CLIENTID, BOOKID, ORDERDATE, REQUIREDATE) 
VALUES ('3013', '2011', '1013', to_date('12-Mar-11', 'DD-MON-RR'), to_date('17-Mar-11', 'DD-MON-RR'));
INSERT INTO CLIENTORDER (ORDERID, CLIENTID, BOOKID, ORDERDATE, REQUIREDATE) 
VALUES ('3014', '2012', '1014', to_date('13-Mar-11', 'DD-MON-RR'), to_date('18-Mar-11', 'DD-MON-RR'));
INSERT INTO CLIENTORDER (ORDERID, CLIENTID, BOOKID, ORDERDATE, REQUIREDATE) 
VALUES ('3015', '2020', '1015', to_date('14-Mar-11', 'DD-MON-RR'), to_date('19-Mar-11', 'DD-MON-RR'));


----

INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR1', '1001', 3);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR1', '1002', 2);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR1', '1003', 3);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR1', '1004', 5);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR1', '1005', 6);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR1', '1006', 7);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR1', '1007', 2);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR1', '1008', 9);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR1', '1009', 1);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR1', '1010', 3);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR1', '1011', 4);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR1', '1012', 5);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR1', '1013', 3);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR1', '1014', 2);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR1', '1015', 1);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR2', '1001', 4);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR2', '1002', 6);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR2', '1003', 7);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR2', '1004', 9);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR2', '1005', 1);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR2', '1006', 7);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR2', '1007', 5);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR2', '1008', 7);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR2', '1009', 5);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR2', '1010', 2);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR2', '1011', 6);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR2', '1012', 3);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR2', '1013', 3);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR2', '1014', 3);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR2', '1015', 3);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR3', '1001', 7);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR3', '1002', 5);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR3', '1003', 4);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR3', '1004', 3);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR3', '1005', 6);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR3', '1006', 7);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR3', '1007', 4);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR3', '1008', 7);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR3', '1009', 8);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR3', '1010', 4);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR3', '1011', 3);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR3', '1012', 2);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR3', '1013', 5);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR3', '1014', 3);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR3', '1015', 6);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR4', '1001', 7);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR4', '1002', 3);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR4', '1003', 6);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR4', '1004', 3);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR4', '1005', 6);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR4', '1006', 3);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR4', '1007', 4);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR4', '1008', 2);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR4', '1009', 5);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR4', '1010', 6);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR4', '1011', 3);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR4', '1012', 1);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR4', '1013', 4);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR4', '1014', 5);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR4', '1015', 8);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR5', '1001', 6);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR5', '1002', 7);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR5', '1003', 4);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR5', '1004', 6);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR5', '1005', 4);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR5', '1006', 8);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR5', '1007', 3);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR5', '1008', 3);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR5', '1009', 3);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR5', '1010', 3);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR5', '1011', 2);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR5', '1012', 4);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR5', '1013', 6);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR5', '1014', 9);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR5', '1015', 7);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR6', '1001', 7);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR6', '1002', 7);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR6', '1003', 5);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR6', '1004', 5);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR6', '1005', 2);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR6', '1006', 4);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR6', '1007', 5);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR6', '1008', 6);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR6', '1009', 7);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR6', '1010', 3);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR6', '1011', 5);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR6', '1012', 6);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR6', '1013', 3);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR6', '1014', 5);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR6', '1015', 6);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR7', '1001', 3);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR7', '1002', 2);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR7', '1003', 4);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR7', '1004', 7);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR7', '1005', 8);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR7', '1006', 10);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR7', '1007', 3);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR7', '1008', 4);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR7', '1009', 6);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR7', '1010', 4);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR7', '1011', 3);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR7', '1012', 2);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR7', '1013', 7);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR7', '1014', 8);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR7', '1015', 9);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR8', '1001', 7);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR8', '1002', 6);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR8', '1003', 5);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR8', '1004', 4);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR8', '1005', 3);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR8', '1006', 4);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR8', '1007', 6);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR8', '1008', 5);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR8', '1009', 4);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR8', '1010', 5);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR8', '1011', 4);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR8', '1012', 6);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR8', '1013', 7);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR8', '1014', 5);
INSERT INTO BOOKDETAIL (BRANCHID, BOOKID, AMOUNT) 
VALUES ('BR8', '1015', 4);

------------------------------------

--Project

--1
/*
Can you find books with a specific author name?
*/

CREATE OR REPLACE PROCEDURE FIND_AUTHOR (AUTHOR VARCHAR2)
AS
    Author_last book.a_lastname%type;
    Author_first book.a_firstname%type;
    Book_title book.booktitle%type;
    
    CURSOR FIND
    IS
        SELECT booktitle, a_firstname, a_lastname FROM book WHERE a_lastname = author;
        
BEGIN 
    OPEN FIND;
    FETCH FIND into book_title, Author_first, Author_last;
    WHILE FIND%FOUND LOOP
        DBMS_OUTPUT.PUT_LINE(book_title || ' by ' || author_first || ' ' || author_last);

        FETCH FIND into book_title, Author_first, Author_last;
    END LOOP;
    CLOSE FIND;
END FIND_AUTHOR;
/
execute FIND_AUTHOR ('Orwell');
/

-----------------------------------------------
-- Question 2
/*
Can you search the number of books rented from a specific customer?
*/

CREATE OR REPLACE FUNCTION NUMBER_OF_BOOKS
(P_CLIENT IN CLIENTORDER.CLIENTID%TYPE)
RETURN NUMBER
AS
V_NUMBER_OF_BOOKS NUMBER := 0;
NAME VARCHAR2(20);
BEGIN

SELECT COUNT(*)
INTO V_NUMBER_OF_BOOKS
FROM CLIENTORDER
WHERE TRIM(UPPER(CLIENTORDER.CLIENTID)) LIKE TRIM(UPPER(P_CLIENT));

SELECT FIRSTNAME || ' ' || LASTNAME
INTO NAME
FROM CLIENT
WHERE CLIENTID = P_CLIENT;
DBMS_OUTPUT.PUT_LINE('Name of Client: ' || NAME);
DBMS_OUTPUT.PUT_LINE('Number of Books: ' || V_NUMBER_OF_BOOKS );
RETURN V_NUMBER_OF_BOOKS;
END NUMBER_OF_BOOKS;
/
select NUMBER_OF_BOOKS(2001) from dual;
/

----------------------------------------------
--3
/*
Can you locate if a book has recently been rented?
*/
CREATE OR REPLACE FUNCTION CHECKRENT(p_booktitle in book.booktitle%type)
return book.status%type is book_stat book.status%type;
begin
select book.status into book_stat from book where book.booktitle = p_booktitle;
return book_stat;
end checkrent;
/

declare
selected_book book.booktitle%type;
stock book.status%type;
begin
selected_book := 'Animal Farm';
stock := checkrent(selected_book);
dbms_output.put_line('The book ' || selected_book || ' is ' || stock);
end;
/

------------------------------------
--4
/*
Can you find out customers from which state places the most orders?
*/
CREATE OR REPLACE PROCEDURE MAXORDERSTATE
AS
    p_state client.state%type;
    p_count number;
    
    CURSOR SEND
    IS
    select state, count(ORDERID) from clientorder inner join client on clientorder.clientid = client.clientid group by state;
    
BEGIN 
    OPEN SEND;
    FETCH SEND into p_state, p_count;
    WHILE SEND%FOUND LOOP
        DBMS_OUTPUT.PUT_LINE(p_state || '  ' || p_count);

        FETCH SEND into p_state, p_count;
    END LOOP;
    CLOSE SEND;

END MAXORDERSTATE;
/
execute maxorderstate;
/

--------------------------------------------------------
--5
/*
Can you find customers in a certain range of orders?
*/

create or replace procedure rangeoforder (low number, high number)
as
    num number;
    clientname varchar2(50);

    CURSOR range
    IS
     select client.firstname || ' ' || lastname as name, count(orderid) as number_of_orders 
     from clientorder inner join client on client.clientid = clientorder.clientid group by client.firstname || ' ' || lastname 
     having count(*) between low and high;
begin 
    OPEN range;
    FETCH range into clientname, num;
    WHILE range%FOUND LOOP
        DBMS_OUTPUT.PUT_LINE(clientname || ', Number of Orders: ' || num);

        FETCH range into clientname, num;
    END LOOP;
    CLOSE range;

end rangeoforder;
/
execute rangeoforder(1,3);
/

------------------------------------------
--6
/*
Can you find customer personal information including the total amount of order placed by the customer, 
the customer name(first name, last name), address(address, city, state, postcode) by giving the customerID?
*/
create or replace package personal_info
as
function clientname(c_id varchar2) return varchar2;
function clientinfo(c_id varchar2) return varchar2;
function clientorders(c_id varchar2) return number;
end personal_info;
/
create or replace package body personal_info
as 
function clientname (c_id varchar2)
return varchar2
as
    name varchar2(30);
begin
    select firstname || ' ' || lastname into name from client where clientid = '2001';
    DBMS_OUTPUT.PUT_LINE(c_id || ' ' || name);
    return name;
end clientname;

function clientinfo (c_id varchar2)
return varchar2
as
    name1 varchar2(30);
    emailaddr varchar2(30);
    phonenumber varchar2(10);
    state1 varchar2(2);
begin
    select firstname || ' ' || lastname, email, phone, state into name1, emailaddr, phonenumber, state1
    from client where clientid = c_id;
    DBMS_OUTPUT.PUT_LINE(c_id || ' ' || name1 || ' ' || emailaddr || ' ' || phonenumber || ' ' || state1);
    return name1;
end clientinfo;

function clientorders (c_id varchar2)
return number
as
    numb number;
begin
    select count(orderid) into numb from clientorder where clientid = c_id;
    DBMS_OUTPUT.PUT_LINE(c_id || ' Number of Orders: ' || numb);
    return numb;
end clientorders;

end personal_info;
/
select personal_info.clientname ('2001') from dual;
select personal_info.clientinfo ('2001') from dual;
select personal_info.clientorders ('2001') from dual;
/

---------------------------------------------
--7
/*
Finding the average price of all books, number of books priced over the average, and books over the price that is inserted
*/
create or replace package price_cal as
function ave_book return number;
function over_avg return number;
function priceover(price2 number) return varchar2;
end price_cal;
/
create or replace package body price_cal as
function ave_book return number
as 
    numb number;
begin 
    select avg(price) into numb from book;
    DBMS_OUTPUT.PUT_LINE('Average price of the books is: ' || round(numb,2));
    return numb;
end ave_book;

function over_avg return number
as 
    numb1 number;
begin 
    select count(*) into numb1 from book where price > (select avg(price) from book); 
    DBMS_OUTPUT.PUT_LINE('Number of books higher than average: ' || numb1);
    return numb1;
end over_avg;

function priceover (price2 number) return varchar2
as 
    numb2 number;
    price1 number;
    Price_too_high exception;
    CURSOR SEND_PRICE
    IS
    select bookid, price from book where price >= price2;
    
begin 
    OPEN SEND_PRICE;
    FETCH SEND_PRICE into numb2, price1;
        DBMS_OUTPUT.PUT_LINE('Book over $' ||  price2 || ': ');
    if SEND_PRICE%NOTFOUND then 
        raise price_too_high;
    end if;    
    WHILE SEND_PRICE%FOUND LOOP
        DBMS_OUTPUT.PUT_LINE(numb2 || '  $' || price1);
        FETCH SEND_PRICE into numb2, price1;
    END LOOP;    

    CLOSE SEND_PRICE; 
    return numb2;
    EXCEPTION
    WHEN price_too_high THEN
        DBMS_OUTPUT.PUT_LINE('Price too high. ');
end priceover;

end price_cal;
/
select price_cal.ave_book from dual;
select price_cal.over_avg from dual;
select price_cal.priceover(17.49) from dual;
select price_cal.priceover(18) from dual;
/

--------------------------------
-- 8
/*
How would you insert, update or delete an branch and book from the database tables? 
*/

drop trigger Trigger1_question8;
Create or replace trigger Trigger1_question8
after delete on branch
For each row
Begin 
DBMS_output.put_line('One branch is deleted from the book table');
end;
/
delete from branch where branchid = 'BR2';
rollback;
/

Create or replace trigger Trigger2_question8
after insert on book
For each row
Begin 
DBMS_output.put_line('One book is insert from the book table');
end;
/
insert into book values('1017', 'C002', 'The Book',	'J. D.', 'Salinger', '15-NOV-90', 'InStock', 12.99);
rollback;
/

create or replace trigger Trigger3_question8
after update on book
for each row
begin
DBMS_output.put_line('One book in the book table has been updated.');
end;
/
update book set price = 30 where bookid = '1001';
/
rollback;

----------------------
--9
/*
How would you display all the orders placed by one customer in a time frame (month, day, hour)?
*/

create or replace procedure Order_of_customer
(p_date IN Date, p_custid in varchar2)
as 
current_order clientorder%rowtype;
cursor all_order
is 
select orderid
from clientorder
where (clientid = p_custid) AND (orderdate = p_date);
begin
dbms_output.put_line('Orders with date ' || p_date || ' Clientid ' || p_custid || ':');
for current_order in all_order loop
dbms_output.put_line(current_order.orderid);
end loop;
end Order_of_customer;
/
execute Order_of_customer('08-MAR-11', '2001');
/
------------------------
-- 10
/*
How would you create a receipt for the customer after a purchase? 
*/

CREATE OR REPLACE PROCEDURE RECEIPT(p_CLIENTID in CLIENT.CLIENTID%TYPE,
p_CLIENTORDER IN CLIENTORDER.ORDERDATE%TYPE,
client_Firstname out client.firstname%type,
client_Lastname out client.lastname%type,
book_title out book.booktitle%type,
book_price out book.price%type,
book_id out clientorder.bookid%type,
return_date out clientorder.requiredate%type) AS
BEGIN
select client.firstname, client.lastname
into client_firstname, client_lastname
from client where clientid = p_clientid;

select book.booktitle, book.price, clientorder.bookid, clientorder.requiredate
into book_title, book_price, book_id, return_date
from clientorder inner join book on clientorder.bookid = book.bookid
where clientorder.orderdate = p_clientorder;
dbms_output.put_line('      RECEIPT');
dbms_output.put_line('Date: ' || p_clientorder);
dbms_output.put_line('Name: ' || client_firstname || ' ' || client_lastname);
dbms_output.put_line('Book ID: ' || book_id);
dbms_output.put_line('Book Title: ' || book_title);
dbms_output.put_line('Book price:  $' || book_price);
dbms_output.put_line('Return date: ' || return_date);
end;
/

declare 
idclient varchar2(5) := '2011';
order_date date := '12-Mar-11';
clientFNAME client.firstname%type;
clientLNAME client.lastname%type;
book__TITLE book.booktitle%type;
bookPRICE book.price%type;
idbook clientorder.bookid%type;
returndate clientorder.requiredate%type;
begin
receipt(idclient, order_date, clientFNAME, clientLNAME, book__title, bookprice, idbook, returndate);
end;
/

-------------------------
-- 11
/*
Can you find the availability date of a book that is rented out?
*/

CREATE OR REPLACE PROCEDURE CHECKAVAILABILITY(p_booktitle in book.booktitle%TYPE) as
begin
if(checkrent(p_booktitle) = ('OutofStock')) 
then
dbms_output.put_line('The book is out of stock. It will be returned on ' || getReturndate(getBookid(p_booktitle)));
else 
dbms_output.put_line('The book is In stock');
end if;
end;
/
CREATE OR REPLACE FUNCTION getReturndate(p_bookid in clientorder.bookid%type)
return clientorder.requiredate%type is returndate clientorder.requiredate%type;
begin
select clientorder.requiredate into returndate from clientorder where clientorder.bookid = p_bookid;
return returndate;
end getReturndate;
/
CREATE OR REPLACE FUNCTION getBOOKID(p_booktitle in book.booktitle%type)
return book.bookid%type is book_id book.bookid%type;
begin
select book.bookid into book_id from book where book.booktitle = p_booktitle;
return book_id;
end getBOOKID;
/

declare
book_title varchar2(50) := '1984';
begin
checkavailability(book_title);
end;

declare
book_title varchar2(50) := 'Charlotte''s Web';
begin
checkavailability(book_title);
end;
/
