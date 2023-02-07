--hw3

CREATE OR REPLACE PACKAGE HW03 IS

function degree_to_radians (
    deg IN NUMBER
) RETURN float;

FUNCTION km_to_miles (
    km IN NUMERIC
) RETURN NUMERIC;

FUNCTION distance_between_zips (
    zip1  IN  hw2_q1_zipcode.zipcode%TYPE,
    zip2  IN  hw2_q1_zipcode.zipcode%TYPE
) RETURN NUMBER;

FUNCTION distance_between_zips (
    zip1  IN  hw2_q1_zipcode.zipcode%TYPE
) RETURN NUMBER;

procedure POI_WITHIN_DISTANCE (miles in number);

FUNCTION POI_DENSITY (miles IN number)
return NUMBER;

END HW03;
/

CREATE OR REPLACE PACKAGE BODY HW03
IS

--1
FUNCTION degree_to_radians (
    deg IN NUMBER
) RETURN float AS

    rad   DECIMAL(5, 4);
    pi    DECIMAL(5, 4) := 3.14159265359;
BEGIN
    rad := deg * pi / 180.0;
    RETURN rad;
END degree_to_radians;

--2
FUNCTION km_to_miles (
    km IN NUMERIC
) RETURN NUMERIC AS
    miles NUMERIC(5, 4);
BEGIN
    miles := km * 0.621371192;
    dbms_output.put_line('km to miles: ' || miles);
    RETURN miles;
END km_to_miles;


--3
FUNCTION distance_between_zips (
    zip1  IN  hw2_q1_zipcode.zipcode%TYPE,
    zip2  IN  hw2_q1_zipcode.zipcode%TYPE
) RETURN NUMBER AS

    ziprow1       hw2_q1_zipcode%rowtype;
    ziprow2       hw2_q1_zipcode%rowtype;
    p_latitude1   NUMBER;
    p_latitude2   NUMBER;
    p_longtitude1  NUMBER;
    p_longtitude2  NUMBER;
    earth_radius  NUMBER := 6371;
    pi_approx     NUMBER := acos(-1);
    lat_delta     NUMBER;
    lon_delta     NUMBER;
    arc           NUMBER;
BEGIN
    SELECT
        *
    INTO ziprow1
    FROM
        hw2_q1_zipcode
    WHERE
        zipcode = zip1;

    SELECT
        *
    INTO ziprow2
    FROM
        hw2_q1_zipcode
    WHERE
        zipcode = zip2;

    p_latitude1 := degree_to_radians(ziprow1.latitude);
    p_latitude2 := degree_to_radians(ziprow2.latitude);
    p_longtitude1 := degree_to_radians(ziprow1.longtitude);
    p_longtitude2 := degree_to_radians(ziprow2.longtitude);
    lat_delta := ( p_latitude2 - p_latitude1 ) * pi_approx;
    lon_delta := ( p_longtitude2 - p_longtitude1 ) * pi_approx;
    arc := sin(lat_delta / 2) * sin(lat_delta / 2) + sin(lon_delta / 2) * sin(lon_delta / 2) * cos(p_latitude1 * pi_approx) * cos(
    p_latitude2 * pi_approx);

    RETURN earth_radius * 2 * atan2(sqrt(arc), sqrt(1 - arc));
    EXCEPTION
    WHEN NO_DATA_FOUND THEN return -1;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT (SQLCODE);
        DBMS_OUTPUT.PUT (': ');
        DBMS_OUTPUT.PUT_LINE (SUBSTR(SQLERRM, 1, 100));
END distance_between_zips;

--4
FUNCTION distance_between_zips (
    zip1  IN  hw2_q1_zipcode.zipcode%TYPE
) RETURN NUMBER AS

    ziprow1       hw2_q1_zipcode%rowtype;
    ziprow2       hw2_q1_zipcode%rowtype;
    p_latitude1   NUMBER;
    p_latitude2   NUMBER;
    p_longtitude1  NUMBER;
    p_longtitude2  NUMBER;
    earth_radius  NUMBER := 6371;
    pi_approx     NUMBER := acos(-1);
    lat_delta     NUMBER;
    lon_delta     NUMBER;
    arc           NUMBER;
BEGIN
    SELECT * INTO ziprow1 FROM hw2_q1_zipcode WHERE zipcode = zip1;

    SELECT * INTO ziprow2 FROM hw2_q1_zipcode WHERE zipcode = '33605';

    p_latitude1 := degree_to_radians(ziprow1.latitude);
    p_latitude2 := degree_to_radians(ziprow2.latitude);
    p_longtitude1 := degree_to_radians(ziprow1.longtitude);
    p_longtitude2 := degree_to_radians(ziprow2.longtitude);
    lat_delta := ( p_latitude2 - p_latitude1 ) * pi_approx;
    lon_delta := ( p_longtitude2 - p_longtitude1 ) * pi_approx;
    arc := sin(lat_delta / 2) * sin(lat_delta / 2) + sin(lon_delta / 2) * sin(lon_delta / 2) * cos(p_latitude1 * pi_approx) * cos(
    p_latitude2 * pi_approx);

    RETURN earth_radius * 2 * atan2(sqrt(arc), sqrt(1 - arc));
EXCEPTION
    WHEN NO_DATA_FOUND THEN return -1;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT (SQLCODE);
        DBMS_OUTPUT.PUT (': ');
        DBMS_OUTPUT.PUT_LINE (SUBSTR(SQLERRM, 1, 100));

END distance_between_zips;

--5
procedure POI_WITHIN_DISTANCE (miles in number)
is
km number := miles_to_km(miles);
cursor POI_CURSOR is select * from PERSON_OF_INTEREST;
begin
     DBMS_OUTPUT.PUT_LINE (RPAD('NAME', 20)||'  '||RPAD('COMPANY NAME',20)||'   '||RPAD('POI TYPE',10)||'   '||RPAD('CITY',15)||'   '||'DISTANCE FROM EE');
    for POI_RECORD in POI_CURSOR loop
    
    if DISTANCE_BETWEEN_ZIPS(POI_RECORD.ZIP) < km then
    DBMS_OUTPUT.PUT_LINE (LPAD(POI_RECORD.Name,20)||'    '||LPAD(POI_RECORD.company_name, 20)||'    '|| LPAD(POI_RECORD.POI_TYPE, 10)||'    '||LPAD(POI_RECORD.CITY,15)||'    '||TO_CHAR(DISTANCE_BETWEEN_ZIPS(POI_RECORD.ZIP),'99999.999'));
    end if;
    end loop;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT (SQLCODE);
        DBMS_OUTPUT.PUT (': ');
        DBMS_OUTPUT.PUT_LINE (SUBSTR(SQLERRM, 1, 100));
end POI_WITHIN_DISTANCE;

--6
FUNCTION POI_DENSITY (miles IN number) 
return NUMBER is
km number := miles_to_km(miles);
cursor POI_CURSOR is select * from PERSON_OF_INTEREST;
COUNTER NUMBER :=0;
begin
    for POI_RECORD in POI_CURSOR loop
    
    if DISTANCE_BETWEEN_ZIPS(POI_RECORD.ZIP) < km then
    COUNTER:=COUNTER+1;
    end if;
    end loop;
    return Counter;
exception
    WHEN OTHERS THEN
        dbms_output.put(sqlcode);
        dbms_output.put(': ');
        dbms_output.put_line(substr(sqlerrm, 1, 100));

end POI_DENSITY;

End HW03;
/

--executions
/*
select HW03.degree_to_radians(185) from dual;
select HW03.km_to_miles(8.1) from dual;
select HW03.distance_between_zips('06759', '06762') from dual;
select HW03.distance_between_zips('06759') from dual;
execute HW03.POI_WITHIN_DISTANCE(2000);
select HW03.POI_DENSITY(2000) from dual;
*/


--QUESTION 7
/*
The procedures or fuctions should be accessible publicly because the objects are called in
specifications in the package in order need to be assessable for the granting of privileges
*/

--QUESTION 8

GRANT EXECUTE ON HW03 TO CNIT372TA;

GRANT ALL ON HW03 TO BAKERELE;
/*
Grant succeeded.

Grant succeeded.
*/

--QUESTION 9
select HW03.degree_to_radians(185) from dual;
select HW03.km_to_miles(8.1) from dual;
select HW03.distance_between_zips('06759', '06762') from dual;
select HW03.distance_between_zips('06759') from dual;
execute HW03.POI_WITHIN_DISTANCE(2000);
select HW03.POI_DENSITY(2000) from dual;
/
/*

HW03.DEGREE_TO_RADIANS(185)
---------------------------
                     3.2289


HW03.KM_TO_MILES(8.1)
---------------------
                    5
km to miles: 5.0331


HW03.DISTANCE_BETWEEN_ZIPS('06759','06762')
-------------------------------------------
                                 57.5155398


HW03.DISTANCE_BETWEEN_ZIPS('06759')
-----------------------------------
                         3640.77358


PL/SQL procedure successfully completed.
NAME                  COMPANY NAME           POI TYPE     CITY              DISTANCE FROM EE
        Ryan Stahley          none on record      Customer              Grand        12.225
          Scott Gray    Security Installatio      Customer               York      2406.699
        Scott Yarian          none on record      Customer         Whiteville      1430.306
        Sharon Rouls        Sharons Shamrock      Customer             Dothan      1044.330
    Sherman Cheswick       Eagle Electronics      Employee              Palma        10.580
     Shirley Osborne          none on record      Customer         Swainsboro       313.545
        Stephen Bird     Storage Specialties      Supplier       Williamsburg      2213.500
          Steve Hess       Eagle Electronics      Employee        Fort Sutton        12.063
      Steven Hickman       Eagle Electronics      Employee              Grand        12.225
         Steven Yaun          none on record      Customer       Indianapolis      1293.166
        Susan Strong    Family Medical Cente      Customer               Adel       389.755
        Thomas Wolfe          none on record      Customer           Scranton      2798.927
           Tim White           Network Niche      Supplier            Lansing       956.954
        Timothy Neal    Computer Accessories      Supplier          Charlotte       793.581
          Todd Vigus       Eagle Electronics      Employee        Fort Sutton        12.063
           Tom Baker          none on record      Customer             Sparta      2655.065
         Tonya Owens          none on record      Customer          Abbeville       417.074
     Tracy Cicholski          Dixon Pharmacy      Customer    Crystal Springs      2757.158
      Trevor Snuffer          none on record      Customer        Rocky Mount      1791.732
        Verna McGrew          none on record      Customer         Huntsville      1424.631
       Yauleng Depoe      Scanning the World      Supplier            Detroit       880.457
      Allison Roland          none on record      Customer              Palma        10.580
      Allison Roland       Eagle Electronics      Employee              Palma        10.580
   Andrea Montgomery          none on record      Customer           Thurmont      2117.395
          Andrew Ray          none on record      Customer          Millville      2897.435
      Andrew Yelnick          none on record      Customer            Detroit       878.211
         Andy Huegel          none on record      Customer            Milford      2739.789
         Anna Mayton          none on record      Customer           McKenzie      1498.783
        Anne Hatzell          none on record      Customer            Seaford      2668.020
        Aricka Bross     Apartment Referrals      Customer             Jewett      1086.207
       Austin Ortman       Eagle Electronics      Employee              Grand        12.225
         Beth Zobitz       Eagle Electronics      Employee          Garyville          .000
      Brenda Kitchel    Cheesman Corporation      Customer            Roanoke      1181.756
    Brenda Pritchett      Wizard Electronics      Supplier              Dover      2732.382
       Bruce Fogarty       Photography Niche      Customer          Ellenboro       998.340
         Bryan Price          none on record      Customer            Hampton      2320.841
          Carl Hague          none on record      Customer         Cincinnati       858.001
       Charles Jones          none on record      Customer              Grand        12.225
       Charles Jones       Eagle Electronics      Employee              Grand        12.225
      Daniel Stabnik          none on record      Customer         Perryville      2506.667
        David Becker              Load It Up      Supplier         Charleston       997.140
         David Chang          none on record      Customer          Mansfield       827.480
         David Deppe       Eagle Electronics      Employee          Garyville          .000
          David Keck       Eagle Electronics      Employee          Garyville          .000
       Dennis Eberle          none on record      Customer           Waterloo      3190.024
          Don Kaleta          none on record      Customer            Altoona      1851.437
          Don Torres    Down Deep Drilling I      Customer           Elberton       410.431
       Doug Blizzard       Collectibles Inc.      Customer          Mars Hill      2794.436
         Edna Lilley       Eagle Electronics      Employee              Palma        10.580
        Frank Malady          none on record      Customer            Nahunta       264.259
         Gary German       Eagle Electronics      Employee              Grand        12.225
          Gary Kempf          none on record      Customer             Kenton       793.843
       Geo Schofield         Cleaning Supply      Customer             Winona      2518.479
      George Trenkle          none on record      Customer             Edison      3191.457
     Gerald Campbell          none on record      Customer          Westfield      2235.564
   Gregory Hettinger       Eagle Electronics      Employee              Palma        10.580
      Heather Wallpe    Reflexions Manufactu      Customer         Park Hills      2746.241
      Heather Waters    Happytime Escort Ser      Customer          Lake City      1072.912
          Jack Brose       Eagle Electronics      Employee        Fort Sutton        12.063
    Jack Illingworth          none on record      Customer            Buffalo      1868.794
         James Gross          none on record      Customer           Lakewood      3212.845
         Jamie Osman       Eagle Electronics      Employee        Fort Sutton        12.063
       Jamie Pickett        Miracle Machines      Supplier         Cinncinati       845.681
      Jamie Thompson          none on record      Customer             Athens       482.674
       Jason Krasner       Eagle Electronics      Employee              Grand        12.225
      Jason Wendling       Eagle Electronics      Employee              Grand        12.225
           Jay Hanau          none on record      Customer             Marion      2188.718
       Jeff Kowaiski    Quality Equipment Co      Customer         Wellsville      2092.266
    Jennifer Hundley          none on record      Customer           Richwood      1064.724
       Jennifer Kmec      Kelly Dance Studio      Customer          Taneytown      2197.592
        Jessica Cain          none on record      Customer         Greenville      1079.042
          Jim Lichty         Bankruptcy Help      Customer            Chicago      1728.691
         Jim Manaugh       Eagle Electronics      Employee          Garyville          .000
         Jim Manaugh          none on record      Customer          Garyville          .000
        Jim Sokeland     Powerful Employment      Customer       Reisterstown      2303.634
       Joanne Rosner       Eagle Electronics      Employee        Fort Sutton        12.063
       John Skadberg          none on record      Customer            Findlay       813.527
     Jonathon Blanco          none on record      Customer            Oshkosh      1954.139
      Joseph Schuman          none on record      Customer              Akron      1016.007
           Kara Orze         Appliances Inc.      Customer             Wausau      2244.763
      Kathryn Deagen       Eagle Electronics      Employee          Garyville          .000
         Kelli Jones    Dot Com Incorporated      Supplier              Macon       488.703
        Kelly Jordan        Supplying Crafts      Customer       Jacksonville       301.896
       Kevin Jackson          none on record      Customer        New Orleans      2713.989
    Kristen Gustavel       Eagle Electronics      Employee          Garyville          .000
       Kristey Moore       Eagle Electronics      Employee        Fort Sutton        12.063
        Kristy Moore          none on record      Customer        Fort Sutton        12.063
          Linda Hari          none on record      Customer           Franklin      1423.929
        Lou Caldwell          none on record      Customer         Louisville      1188.253
        Marla Reeder          none on record      Customer            Bonifay      1140.039
       Matthew Quant          none on record      Customer             Hamlet      1131.466
        Meghan Tyrie       Eagle Electronics      Employee          Garyville          .000
     Melissa Alvarez       Eagle Electronics      Employee          Garyville          .000
    Meredith Rushing          none on record      Customer          Lexington       808.800
      Michael Abbott       Eagle Electronics      Employee              Grand        12.225
       Michael Emore          none on record      Customer            Orlando       353.794
      Michelle Nairn       Eagle Electronics      Employee        Fort Sutton        12.063
  Patricha Underwood       Eagle Electronics      Employee              Palma        10.580
       Paul Eckelman       Eagle Electronics      Employee        Fort Sutton        12.063
        Peter Austin          none on record      Customer           Barnwell       549.411
          Phil Reece          none on record      Customer        Fort Sutton        12.063
          Phil Reece       Eagle Electronics      Employee        Fort Sutton        12.063
       Richard Kluth    Main St. Bar and Gri      Customer         Middletown      2683.276
           Rita Bush       Eagle Electronics      Employee          Garyville          .000
          Rob Thomas    Accessories and More      Supplier          Pittsburg      1351.373
       Robert Dalury                     TAS      Customer           Bay City       928.692
       Ronald Miller          none on record      Customer          Kalamazoo      1147.604
 Rosemary Vanderhoff          none on record      Customer              Macon       506.970
      Ruth Albeering          none on record      Customer              Galax       868.242
        Ryan Stahley       Eagle Electronics      Employee              Grand        12.225

HW03.POI_DENSITY(2000)
----------------------
                   110


 */
--QUESTION 10
select HW03.degree_to_radians(185) from dual;
select HW03.km_to_miles(8.1) from dual;
select HW03.distance_between_zips('06759', '06762') from dual;
select HW03.distance_between_zips('06759') from dual;
execute HW03.POI_WITHIN_DISTANCE(2000);
select HW03.POI_DENSITY(2000) from dual;
/
/*

HW03.DEGREE_TO_RADIANS(185)
---------------------------
                     3.2289


HW03.KM_TO_MILES(8.1)
---------------------
                    5
km to miles: 5.0331


HW03.DISTANCE_BETWEEN_ZIPS('06759','06762')
-------------------------------------------
                                 57.5155398


HW03.DISTANCE_BETWEEN_ZIPS('06759')
-----------------------------------
                         3640.77358


PL/SQL procedure successfully completed.
NAME                  COMPANY NAME           POI TYPE     CITY              DISTANCE FROM EE
        Ryan Stahley          none on record      Customer              Grand        12.225
          Scott Gray    Security Installatio      Customer               York      2406.699
        Scott Yarian          none on record      Customer         Whiteville      1430.306
        Sharon Rouls        Sharons Shamrock      Customer             Dothan      1044.330
    Sherman Cheswick       Eagle Electronics      Employee              Palma        10.580
     Shirley Osborne          none on record      Customer         Swainsboro       313.545
        Stephen Bird     Storage Specialties      Supplier       Williamsburg      2213.500
          Steve Hess       Eagle Electronics      Employee        Fort Sutton        12.063
      Steven Hickman       Eagle Electronics      Employee              Grand        12.225
         Steven Yaun          none on record      Customer       Indianapolis      1293.166
        Susan Strong    Family Medical Cente      Customer               Adel       389.755
        Thomas Wolfe          none on record      Customer           Scranton      2798.927
           Tim White           Network Niche      Supplier            Lansing       956.954
        Timothy Neal    Computer Accessories      Supplier          Charlotte       793.581
          Todd Vigus       Eagle Electronics      Employee        Fort Sutton        12.063
           Tom Baker          none on record      Customer             Sparta      2655.065
         Tonya Owens          none on record      Customer          Abbeville       417.074
     Tracy Cicholski          Dixon Pharmacy      Customer    Crystal Springs      2757.158
      Trevor Snuffer          none on record      Customer        Rocky Mount      1791.732
        Verna McGrew          none on record      Customer         Huntsville      1424.631
       Yauleng Depoe      Scanning the World      Supplier            Detroit       880.457
      Allison Roland          none on record      Customer              Palma        10.580
      Allison Roland       Eagle Electronics      Employee              Palma        10.580
   Andrea Montgomery          none on record      Customer           Thurmont      2117.395
          Andrew Ray          none on record      Customer          Millville      2897.435
      Andrew Yelnick          none on record      Customer            Detroit       878.211
         Andy Huegel          none on record      Customer            Milford      2739.789
         Anna Mayton          none on record      Customer           McKenzie      1498.783
        Anne Hatzell          none on record      Customer            Seaford      2668.020
        Aricka Bross     Apartment Referrals      Customer             Jewett      1086.207
       Austin Ortman       Eagle Electronics      Employee              Grand        12.225
         Beth Zobitz       Eagle Electronics      Employee          Garyville          .000
      Brenda Kitchel    Cheesman Corporation      Customer            Roanoke      1181.756
    Brenda Pritchett      Wizard Electronics      Supplier              Dover      2732.382
       Bruce Fogarty       Photography Niche      Customer          Ellenboro       998.340
         Bryan Price          none on record      Customer            Hampton      2320.841
          Carl Hague          none on record      Customer         Cincinnati       858.001
       Charles Jones          none on record      Customer              Grand        12.225
       Charles Jones       Eagle Electronics      Employee              Grand        12.225
      Daniel Stabnik          none on record      Customer         Perryville      2506.667
        David Becker              Load It Up      Supplier         Charleston       997.140
         David Chang          none on record      Customer          Mansfield       827.480
         David Deppe       Eagle Electronics      Employee          Garyville          .000
          David Keck       Eagle Electronics      Employee          Garyville          .000
       Dennis Eberle          none on record      Customer           Waterloo      3190.024
          Don Kaleta          none on record      Customer            Altoona      1851.437
          Don Torres    Down Deep Drilling I      Customer           Elberton       410.431
       Doug Blizzard       Collectibles Inc.      Customer          Mars Hill      2794.436
         Edna Lilley       Eagle Electronics      Employee              Palma        10.580
        Frank Malady          none on record      Customer            Nahunta       264.259
         Gary German       Eagle Electronics      Employee              Grand        12.225
          Gary Kempf          none on record      Customer             Kenton       793.843
       Geo Schofield         Cleaning Supply      Customer             Winona      2518.479
      George Trenkle          none on record      Customer             Edison      3191.457
     Gerald Campbell          none on record      Customer          Westfield      2235.564
   Gregory Hettinger       Eagle Electronics      Employee              Palma        10.580
      Heather Wallpe    Reflexions Manufactu      Customer         Park Hills      2746.241
      Heather Waters    Happytime Escort Ser      Customer          Lake City      1072.912
          Jack Brose       Eagle Electronics      Employee        Fort Sutton        12.063
    Jack Illingworth          none on record      Customer            Buffalo      1868.794
         James Gross          none on record      Customer           Lakewood      3212.845
         Jamie Osman       Eagle Electronics      Employee        Fort Sutton        12.063
       Jamie Pickett        Miracle Machines      Supplier         Cinncinati       845.681
      Jamie Thompson          none on record      Customer             Athens       482.674
       Jason Krasner       Eagle Electronics      Employee              Grand        12.225
      Jason Wendling       Eagle Electronics      Employee              Grand        12.225
           Jay Hanau          none on record      Customer             Marion      2188.718
       Jeff Kowaiski    Quality Equipment Co      Customer         Wellsville      2092.266
    Jennifer Hundley          none on record      Customer           Richwood      1064.724
       Jennifer Kmec      Kelly Dance Studio      Customer          Taneytown      2197.592
        Jessica Cain          none on record      Customer         Greenville      1079.042
          Jim Lichty         Bankruptcy Help      Customer            Chicago      1728.691
         Jim Manaugh       Eagle Electronics      Employee          Garyville          .000
         Jim Manaugh          none on record      Customer          Garyville          .000
        Jim Sokeland     Powerful Employment      Customer       Reisterstown      2303.634
       Joanne Rosner       Eagle Electronics      Employee        Fort Sutton        12.063
       John Skadberg          none on record      Customer            Findlay       813.527
     Jonathon Blanco          none on record      Customer            Oshkosh      1954.139
      Joseph Schuman          none on record      Customer              Akron      1016.007
           Kara Orze         Appliances Inc.      Customer             Wausau      2244.763
      Kathryn Deagen       Eagle Electronics      Employee          Garyville          .000
         Kelli Jones    Dot Com Incorporated      Supplier              Macon       488.703
        Kelly Jordan        Supplying Crafts      Customer       Jacksonville       301.896
       Kevin Jackson          none on record      Customer        New Orleans      2713.989
    Kristen Gustavel       Eagle Electronics      Employee          Garyville          .000
       Kristey Moore       Eagle Electronics      Employee        Fort Sutton        12.063
        Kristy Moore          none on record      Customer        Fort Sutton        12.063
          Linda Hari          none on record      Customer           Franklin      1423.929
        Lou Caldwell          none on record      Customer         Louisville      1188.253
        Marla Reeder          none on record      Customer            Bonifay      1140.039
       Matthew Quant          none on record      Customer             Hamlet      1131.466
        Meghan Tyrie       Eagle Electronics      Employee          Garyville          .000
     Melissa Alvarez       Eagle Electronics      Employee          Garyville          .000
    Meredith Rushing          none on record      Customer          Lexington       808.800
      Michael Abbott       Eagle Electronics      Employee              Grand        12.225
       Michael Emore          none on record      Customer            Orlando       353.794
      Michelle Nairn       Eagle Electronics      Employee        Fort Sutton        12.063
  Patricha Underwood       Eagle Electronics      Employee              Palma        10.580
       Paul Eckelman       Eagle Electronics      Employee        Fort Sutton        12.063
        Peter Austin          none on record      Customer           Barnwell       549.411
          Phil Reece          none on record      Customer        Fort Sutton        12.063
          Phil Reece       Eagle Electronics      Employee        Fort Sutton        12.063
       Richard Kluth    Main St. Bar and Gri      Customer         Middletown      2683.276
           Rita Bush       Eagle Electronics      Employee          Garyville          .000
          Rob Thomas    Accessories and More      Supplier          Pittsburg      1351.373
       Robert Dalury                     TAS      Customer           Bay City       928.692
       Ronald Miller          none on record      Customer          Kalamazoo      1147.604
 Rosemary Vanderhoff          none on record      Customer              Macon       506.970
      Ruth Albeering          none on record      Customer              Galax       868.242
        Ryan Stahley       Eagle Electronics      Employee              Grand        12.225

HW03.POI_DENSITY(2000)
----------------------
                   110

*/