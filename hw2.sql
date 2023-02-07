-- Austin Polak, Luke Siemers, Anh Nguyen
-- HW2
-- 10/25/2021
DROP TABLE hw2_q1_zipcode;

SET HEADING ON;
--1A
create table hw2_q1_zipcode
(
zipcode varchar2(30),
state varchar2(30),
city varchar2(30),
latitude number,
longitude number,
updated date
);
/
commit;

--1B
/*
1. right clicked on table hw2_q1_zipcode
2. selected import data
3. browsed computer for data zipCodes_1990Census_clean.txt, unchecked header file format, then clicked on next 
4. clicked next on import method
5. from selected columns, move column 7 back to available columns, then clicked on next 
6. from source data columns, confirmed source data columns matched target table columns. 
For the last data and time column, typed date form 'MM/DD/YYYY HH:MI:SS AM'. Clicked next, then finish.
*/

--1C
SELECT ZIPCODE FROM hw2_q1_zipcode GROUP BY ZIPCODE HAVING COUNT(*)>=2;
/

--1D
SELECT POSTALCODE FROM EMPLOYEE WHERE POSTALCODE NOT IN 
(SELECT ZIPCODE FROM hw2_q1_zipcode);
SELECT POSTALCODE FROM CUSTOMER WHERE POSTALCODE NOT IN 
(SELECT ZIPCODE FROM hw2_q1_zipcode);
SELECT POSTALCODE FROM SUPPLIER WHERE POSTALCODE NOT IN 
(SELECT ZIPCODE FROM hw2_q1_zipcode);
/

--1E
DROP TABLE SUPPLEMENT;

create table SUPPLEMENT
(
zipcode varchar2(30),
state varchar2(30),
city varchar2(30),
latitude number,
longitude number,
updated date
);

/* Load data into supplemental table
1. right clicked on table supplemental
2. selected import data
3. browsed computer for data zipCodes_supplemental.xlsx, then clicked on next
4. clicked next on import method
5. clicked next on choose columns
6. from source data columns, confirmed source data columns matched target table columns. 
For the last data and time column, typed date form 'MM/DD/YYYY HH:MI'. Clicked next, then finish.
*/

MERGE INTO hw2_q1_zipcode a
USING 
    (SELECT zipcode, state, city, latitude, longitude, updated
    FROM supplement) b
ON (a.zipcode = b.zipcode)
WHEN MATCHED THEN
    UPDATE SET
        a.state = b.state,
        a.city = b.city,
        a.latitude = b.latitude,
        a.longitude = b.longitude,
        a.updated = b.updated
WHEN NOT MATCHED THEN
    INSERT (a.zipcode, a.state, a.city, a.latitude, a.longitude, a.updated)
    VALUES (b.zipcode, b.state, b.city, b.latitude, b.longitude, b.updated);


INSERT INTO hw2_q1_zipcode VALUES
('01368', 'MA', 'ROYALSTON', 42.67047, -72.19703, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('01853', 'MA', 'LOWELL', 42.64350, -71.31010, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('02303', 'MA', 'BROCKTON', 42.08340, -71.01880, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('03108', 'NH', 'MANCHESTER', 42.99560, -71.45560, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('03435', 'NH', 'KEENE', 42.93370, -72.27940, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('04112', 'ME', 'PORTLAND', 43.66150, -70.25550, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('04122', 'ME', 'PORTLAND', 43.66150, -70.25550, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('04212', 'ME', 'AUBURN', 44.09760, -70.23190, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('04903', 'ME', 'WATERVILLE', 44.55170, -69.63220, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('05304', 'VT', 'BRATTLEBORO', 42.85090, -72.55840, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('08361', 'NJ', 'VINELAND', 39.44976, -74.95860, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('10131', 'NY', 'NEW YORK', 40.71430, -74.00670, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('13261', 'NY', 'SYRACUSE', 43.04820, -76.14790, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('13442', 'NY', 'ROME', 43.21250, -75.45620, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('13699', 'NY', 'POTSDAM', 44.66180, -74.99471, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('18195', 'PA', 'TREXLERTOWN', 40.57760, -75.56870, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('18522', 'PA', 'SCRANTON', 41.41184, -75.66525, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('19726', 'DE', 'NEWARD', 39.68370, -75.75010, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('19850', 'DE', 'WILMINGTON', 39.75790,-75.54740, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('21412', 'MD', 'PAROLE', 38.97850, -76.49280, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('21503', 'MD', 'CUMBERLAND', 39.65280, -78.76260, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('24506', 'VA', 'LYNCHBURG', 37.41360, -79.14270, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('26555', 'WV', 'FAIRMONT', 39.48500, -80.14260, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('27895', 'NC', 'WILSON', 35.72130, -77.91550, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('28504', 'NC', 'KINSTON', 35.22683, -77.65110, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('28810', 'NC', 'ASHEVILLE', 35.59770, -82.55660, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('29153', 'SC', 'SUMTER', 33.97268, -80.29962, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('29413', 'SC', 'CHARLESTON', 32.77650, -79.93120, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('30722', 'GA', 'DALTON', 34.76980, -84.97030, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('32447', 'FL', 'MARIANNA', 30.76056, -85.25703, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('32783', 'FL', 'TITUSVILLE', 28.61180, -80.80780, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('33601', 'FL', 'TAMPA', 27.94750, -82.45880, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('33871', 'FL', 'SEBRING', 27.49540, -81.44110, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('36832', 'AL', 'AUBURN', 32.57073, -85.57542, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('37111', 'TN', 'MCMINNVILLE', 35.65630, -85.78370, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('38308', 'TN', 'JACKSON', 35.61470, -88.81360, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('39565', 'MS', 'VANCLEAVE', 30.58330, -88.72114, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('40512', 'KY', 'LEXINGTON', 38.04940, -84.50040, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('42102', 'KY', 'BOWLING GREEN', 36.99060,-86.44370, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('42719', 'KY', 'CAMPBELLSVILLE', 37.34330, -85.34170, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('45819', 'OH', 'BUCKLAND', 40.61804, -84.26798, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('46624', 'IN', 'SOUTH BEND', 41.68330, -86.25030, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('46801', 'IN', 'FORT WAYNE', 41.13060, -85.12890, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('47202', 'IN', 'COLUMBUS', 39.20160, -85.92140, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('47732', 'IN', 'EVANSVILLE', 37.97440, -87.55550, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('47813', 'IN', 'TERRE HAUTE', 39.43360, -87.41010, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('48609', 'MI', 'SAGINAW', 43.40300, -84.07321, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('49016', 'MI', 'BATTLE CREEK', 42.34569, -85.28882, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('52498', 'IA', 'CEDAR RAPIDS', 42.00830, -91.64370, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('57703', 'SD', 'RAPID CITY', 44.02613, -103.07566, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('58026', 'GR', 'TOSCANA', 43.13067, 11.01607, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('592331', 'MT', 'SAINT MARIE', 48.40615, -106.48773, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('61125', 'IL', 'ROCKFORD', 42.27120, -89.09390, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('64853', 'MO', 'NEWTONIA', 36.86860, -94.36750, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('65215', 'MO', 'COLUMBIA', 38.95229, -92.31931, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('67251', 'KS', 'WICHITA', 37.69360, -97.4804, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('67402', 'KS', 'SALINA', 38.84060, -97.61120, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('72765', 'AR', 'SPRINGDALE', 36.18640, -94.12890, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('73402', 'OK', 'ARDMORE', 34.17440, -97.14340, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('73506', 'OK', 'LAWTON', 34.60880, -98.39020, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('73705', 'OK', 'ENID', 36.34220 ,-97.90337, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('76208', 'TX', 'DENTON', 33.20904, -97.05646, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('80230', 'CO', 'DENVER', 39.71995, -104.89175, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('80328', 'CO', 'BOULDER', 40.01498, -105.27055, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('80761', 'ID', 'BALI', -8.40952, 115.18892, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('81011', 'CO', 'PUEBLO', 38.25440, -104.60860, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('81247', 'CO', 'GUNNISON', 38.45750, -107.29210 , sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('81402', 'CO', 'MONTROSE', 38.47840, -107.87590, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('81626', 'CO', 'CRAIG', 40.51550, -107.54580, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('82073', 'WY', 'LARAMIE', 41.31360, -105.58060, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('82638', 'WY', 'HILAND', 42.86680, -106.312502, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('82902', 'WY', 'ROCK SPRINGS', 41.58780, -109.20240, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('83209', 'ID', 'POCATELLO', 42.86146, -112.43360, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('83415', 'ID', 'IDAHO FALLS', 43.46670, -112.03350, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('83441', 'ID', 'REXBURG', 43.82630, -111.78880, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('83531', 'ID', 'GRANGEVILLE', 45.96360, -116.25560, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('83826', 'ID', 'EASTPORT', 48.95703, -116.19828, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('84603', 'UT', 'PROVO', 40.23370, -111.65790, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('84721', 'UT', 'CEDAR CITY', 37.67770, -113.06120, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('85011', 'AZ', 'PHOENIX', 33.44860, -112.07330, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('85070', 'AZ', 'PHOENIX', 33.44860, -112.07330, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('85502', 'AZ', 'GLOBE', 33.39440, -110.78580, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('85622', 'AZ', 'GREEN VALLEY', 31.86640, -110.99310, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('86313', 'AZ', 'PRESCOTT', 34.54010, -112.46780, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('86411', 'AZ', 'HACKBERRY', 35.23223, -113.57618, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('87594', 'NM', 'SANTA FE', 35.68660, -105.93740, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('89199', 'NV', 'LAS VEGAS', 36.17430, -115.13910, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('89714', 'NV', 'CARSON CITY', 39.16370, -119.76670, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('89721', 'NV', 'CARSON CITY', 39.16370, -119.76670, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('94232', 'CA', 'SACRAMENTO', 38.58190, -121.49350, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('95534', 'CA', 'CUTTEN', 40.76350, -124.14510, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('97311', 'OR', 'SALEM', 44.94310, -123.03360, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('97709', 'OR', 'BEND', 44.05860, -121.31420, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('98907', 'WA', 'YAKIMA', 46.60220, -120.50480, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('99211', 'WA', 'SPOKANE', 47.65880, -117.42500, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('99509', 'AK', 'ANCHORAGE', 61.21810, -149.90030, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('99775', 'AK', 'FAIRBANKS', 64.86057,-147.83776, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('99811', 'AK', 'JUNEAU', 58.30160, -134.41940, sysdate);
INSERT INTO hw2_q1_zipcode VALUES
('99836', 'AK', 'PORT ALEXANDER', 56.24770, -133.64380, sysdate);


/
--1F
(SELECT postalCode
FROM Customer
UNION 
SELECT postalCode 
FROM SUPPLIER
UNION
SELECT postalCode 
FROM EMPLOYEE)
MINUS
SELECT zipCode
FROM HW2_Q1_ZIPCODE;
/
-- Question 2
--2a

CREATE OR REPLACE FUNCTION DEG_TO_RAD (
    DEG IN NUMBER
) RETURN float AS
    RADIAN  DECIMAL(5, 4);
    PI   DECIMAL(5, 4) := 3.14159265359;
BEGIN
    RADIAN := DEG * PI / 180.0;
    RETURN RADIAN;
END DEG_TO_RAD;
/

DECLARE
    RADIAN2 float;
BEGIN
    RADIAN2 := DEG_TO_RAD(185);
    dbms_output.put_line(TO_CHAR(RADIAN2,'9.9999'));
END;


--2b
CREATE OR REPLACE FUNCTION KM_CONVERSION (KM IN NUMERIC) 
RETURN NUMERIC AS
    POI_MILES NUMERIC(5, 4);
BEGIN
    POI_MILES := KM * 0.621371192;
    dbms_output.put_line('Miles converted to KM: ' || POI_MILES);
    RETURN POI_MILES;
END KM_CONVERSION;
/

DECLARE
    POI_MILES_2 NUMERIC(5, 4);
BEGIN
    POI_MILES_2 := KM_CONVERSION(8.1);
END;
/

--2c
CREATE OR REPLACE FUNCTION DISTANCE_BETWEEN_ZIPS(
    ZIPCODE1  IN  HW2_Q1_ZIPCODE.ZIPCODE%TYPE,
    ZIPCODE2  IN  HW2_Q1_ZIPCODE.ZIPCODE%TYPE
) RETURN NUMBER AS
    ZIPCODEROW_1       hw2_q1_zipcode%rowtype;
    ZIPCODEROW_2       hw2_q1_zipcode%rowtype;
    V_LAT_1   NUMBER; V_LAT_2   NUMBER;
    V_LONG_1  NUMBER; V_LONG_2  NUMBER;
    earth_radius  NUMBER := 6371;
    pi_approx     NUMBER := acos(-1);
    lat_delta     NUMBER; lon_delta     NUMBER;
    arc           NUMBER;
BEGIN
    SELECT * INTO ZIPCODEROW_1
    FROM HW2_Q1_ZIPCODE
    WHERE ZIPCODE = ZIPCODE1;
    SELECT * INTO ZIPCODEROW_2
    FROM HW2_Q1_ZIPCODE
    WHERE ZIPCODE = ZIPCODE2;
    V_LAT_1 := DEG_TO_RAD(ZIPCODEROW_1.latitude);
    V_LAT_2 := DEG_TO_RAD(ZIPCODEROW_2 .latitude);
    V_LONG_1 := DEG_TO_RAD(ZIPCODEROW_1.longitude);
    V_LONG_2 := DEG_TO_RAD(ZIPCODEROW_2.longitude);
    lat_delta := ( V_LAT_2 - V_LAT_1 ) * pi_approx;
    lon_delta := ( V_LONG_2 - V_LONG_1 ) * pi_approx;
    arc := sin(lat_delta / 2) * sin(lat_delta / 2) + sin(lon_delta / 2) * sin(lon_delta / 2) * cos(V_LAT_1 * pi_approx) * cos(V_LAT_2 * pi_approx);
    RETURN earth_radius * 2 * atan2(sqrt(arc), sqrt(1 - arc));
EXCEPTION
    WHEN NO_DATA_FOUND THEN return -1;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT (SQLCODE);
        DBMS_OUTPUT.PUT (': ');
        DBMS_OUTPUT.PUT_LINE (SUBSTR(SQLERRM, 1, 100));
END DISTANCE_BETWEEN_ZIPS;
/
DECLARE
    DISTANCE FLOAT;
BEGIN
    DISTANCE := DISTANCE_BETWEEN_ZIPS('06759', '06762');
    dbms_output.put_line('The distance between the two points is ' || TO_CHAR(DISTANCE,'99999.999') || 'km');
END;
/

--2d
CREATE OR REPLACE FUNCTION DISTANCE_BETWEEN_EAGLEZIP(
    ZIPCODE1  IN  HW2_Q1_ZIPCODE.ZIPCODE%TYPE)
    RETURN NUMBER AS
    ZIPCODEROW_1       hw2_q1_zipcode%rowtype;
    ZIPCODEROW_2       hw2_q1_zipcode%rowtype;
    V_LAT_1   NUMBER; V_LAT_2   NUMBER;
    V_LONG_1  NUMBER; V_LONG_2  NUMBER;
    earth_radius  NUMBER := 6371;
    pi_approx     NUMBER := acos(-1);
    lat_delta     NUMBER; lon_delta     NUMBER;
    arc           NUMBER;
BEGIN
    SELECT * INTO ZIPCODEROW_1
    FROM HW2_Q1_ZIPCODE
    WHERE ZIPCODE = ZIPCODE1;
    SELECT * INTO ZIPCODEROW_2
    FROM HW2_Q1_ZIPCODE
    WHERE ZIPCODE = '33605';
    V_LAT_1 := DEG_TO_RAD(ZIPCODEROW_1.latitude);
    V_LAT_2 := DEG_TO_RAD(ZIPCODEROW_2 .latitude);
    V_LONG_1 := DEG_TO_RAD(ZIPCODEROW_1.longitude);
    V_LONG_2 := DEG_TO_RAD(ZIPCODEROW_2.longitude);
    lat_delta := ( V_LAT_2 - V_LAT_1 ) * pi_approx;
    lon_delta := ( V_LONG_2 - V_LONG_1 ) * pi_approx;
    arc := sin(lat_delta / 2) * sin(lat_delta / 2) + sin(lon_delta / 2) * sin(lon_delta / 2) * cos(V_LAT_1 * pi_approx) * cos(V_LAT_2 * pi_approx);
    RETURN earth_radius * 2 * atan2(sqrt(arc), sqrt(1 - arc));
EXCEPTION
    WHEN NO_DATA_FOUND THEN return -1;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT (SQLCODE);
        DBMS_OUTPUT.PUT (': ');
        DBMS_OUTPUT.PUT_LINE (SUBSTR(SQLERRM, 1, 100));
END DISTANCE_BETWEEN_EAGLEZIP;
/
DECLARE
    DISTANCE FLOAT;
BEGIN
    DISTANCE := DISTANCE_BETWEEN_EAGLEZIP('06759');
    dbms_output.put_line('The distance between the two points is ' || TO_CHAR(DISTANCE,'99999.999') || 'km');
END;
/

--2e

CREATE OR REPLACE FUNCTION MILE_CONVERSION (MILES IN NUMBER) 
RETURN NUMBER AS KM NUMBER;
BEGIN
    KM := MILES * 1/0.62137;
    RETURN KM;
END MILE_CONVERSION;
/
drop table PERSON_OF_INTEREST CASCADE CONSTRAINTS;

CREATE Table PERSON_OF_INTEREST 
(name varchar2(50), 
company_name varchar2(50), 
telephone varchar2(12), 
email_address varchar2(50), 
CITY varchar2(60), 
ZIP varchar2(10), 
POSITION_TYPE varchar2(20));

INSERT ALL INTO person_of_interest 
(name, telephone, email_address, company_name, CITY, ZIP, POSITION_TYPE)
SELECT custfirstname || ' ' || custlastname as Name, phone, 
emailaddr, NVL(Companyname, 'none on record'), city, postalcode, 'Customer'
FROM customer
UNION
SELECT firstname || ' ' || lastname as Name, homephone, 
emailaddr,'Eagle Electronics', city, postalcode, 'Employee'
FROM employee
UNION
SELECT contactname as Name, phone, 
emailaddr, NVL(Companyname, 'none on record'), city, postalcode, 'Supplier'
FROM Supplier;
/

CREATE OR REPLACE procedure POI_WITHIN_DISTANCE (POI_MILE in number)
IS KM NUMBER := MILE_CONVERSION(POI_MILE);
CURSOR POI_CUR IS SELECT * 
FROM PERSON_OF_INTEREST;
    BEGIN
    DBMS_OUTPUT.PUT_LINE (RPAD('NAME', 20)||'  '||
    RPAD('COMPANY NAME',20)||'   '||
    RPAD('POI TYPE',10)||'   '||
    RPAD('CITY',15)||'   '||'DISTANCE FROM EE');
    FOR POI_CONTAIN IN POI_CUR LOOP
    IF DISTANCE_BETWEEN_EAGLEZIP(POI_CONTAIN.ZIP) < KM THEN
    DBMS_OUTPUT.PUT_LINE (LPAD(POI_CONTAIN.Name,20)||'    '||
    LPAD(POI_CONTAIN.company_name, 20)||'    '|| 
    LPAD(POI_CONTAIN.POSITION_TYPE, 10)||'    '||
    LPAD(POI_CONTAIN.CITY,15)||'    '||
    TO_CHAR(DISTANCE_BETWEEN_EAGLEZIP(POI_CONTAIN.ZIP),'99999.999'));
    END IF;
    END LOOP;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT (SQLCODE);
        DBMS_OUTPUT.PUT (': ');
        DBMS_OUTPUT.PUT_LINE (SUBSTR(SQLERRM, 1, 100));
END;
/
EXECUTE POI_WITHIN_DISTANCE(1500);
--2f
CREATE OR REPLACE FUNCTION POI_DENSITY (POI_MILES IN number) 
RETURN NUMBER IS
KM NUMBER := MILE_CONVERSION(POI_MILES);
CURSOR POI_CUR IS SELECT * FROM PERSON_OF_INTEREST;
COUNTER NUMBER :=0;
    BEGIN
        FOR POI_REC IN POI_CUR LOOP
        IF DISTANCE_BETWEEN_EAGLEZIP(POI_REC.ZIP) < KM THEN
        COUNTER := COUNTER+1;
    END IF;
    END LOOP;
    RETURN Counter;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT (SQLCODE);
        DBMS_OUTPUT.PUT (': ');
        DBMS_OUTPUT.PUT_LINE (SUBSTR(SQLERRM, 1, 100));
END;
/

SELECT POI_DENSITY(2000)
FROM DUAL;

/*result
--1C
no rows selected

--1D

POSTALCODE                    
------------------------------
01368
01853
02303
03108
03435
04112
04122
04212
04903
05304
08361

POSTALCODE                    
------------------------------
10131
13261
13442
13699
18195
18522
19726
19850
21412
21503
24506

POSTALCODE                    
------------------------------
26555
27895
28504
28810
29153
29413
30722
32447
32783
33601
33871

POSTALCODE                    
------------------------------
36832
37111
38308
39565
40512
42102
42719
45819
46624
46801
47202

POSTALCODE                    
------------------------------
47732
47813
48609
49016
52498
57703
58026
592331
61125
64853
65215

POSTALCODE                    
------------------------------
67251
67402
72765
73402
73506
73705
76208
80230
80328
80761
81011

POSTALCODE                    
------------------------------
81247
81402
81626
82073
82638
82902
83209
83415
83441
83531
83826

POSTALCODE                    
------------------------------
84603
84721
85011
85070
85502
85622
86313
86411
87594
89199
89714

POSTALCODE                    
------------------------------
89721
94232
95534
97311
97709
98907
99211
99509
99775
99811
99836

99 rows selected. 

--1E

99 rows inserted

--1F
no rows selected


commit;

--2A
Function DEGREES_TO_RADIANS compiled

DEGREES_TO_RADIANS(1000)
------------------------
              17.4532778
              
              
--2B
Function KM_TO_MILES compiled

KM_TO_MILES(100)
----------------
          62.137

--2C
Function DISTANCE_BETWEEN_ZIPS compiled

The distance between the two points is 57.516km

--2D
Function DISTANCE_BETWEEN_ZIPS compiled

The distance between the two points is 3640.774km
--2E
Table PERSON_OF_INTEREST dropped.

Table PERSON_OF_INTEREST created.

300 rows inserted.

Procedure POI_WITHIN_DISTANCE compiled

PL/SQL procedure successfully completed.

NAME                  COMPANY NAME           POI TYPE     CITY              DISTANCE FROM EE
        Ryan Stahley          none on record      Customer              Grand        12.225
-1422: ORA-01422: exact fetch returns more than requested number of rows
-6503: ORA-06503: PL/SQL: Function returned without value

--2F
-1422: ORA-01422: exact fetch returns more than requested number of rows
-6503: ORA-06503: PL/SQL: Function returned without value

*/