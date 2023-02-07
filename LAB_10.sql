--Lab 10
DROP TABLE airdb_airports;

DROP TABLE airdb_all_info;

DROP TABLE airdb_clone;
-- Question 1

CREATE TABLE airdb_all_info
    AS
SELECT *
FROM cnit372ta.airdb_all_info;

SELECT *
FROM airdb_all_info;
/
-- Question 2

ALTER TABLE airdb_all_info MODIFY (
    origin_city_name NOT NULL,
    dest_city_name NOT NULL
);

ALTER TABLE airdb_all_info MODIFY (
    origin_state_nm NOT NULL,
    dest_state_nm NOT NULL
);

ALTER TABLE airdb_all_info
    ADD CONSTRAINT aaicomb UNIQUE ( origin_airport_id,
                                    dest_airport_id,
                                    fl_num,
                                    carrier,
                                    fl_date );
/
-- Question 3

SELECT*
FROM user_constraints
WHERE table_name = 'AIRDB_ALL_INFO';
/
-- Question 4

CREATE TABLE airdb_clone AS
SELECT *
FROM airdb_all_info;
/
-- Question 5

SELECt *
FROM user_constraints
WHERE table_name = 'AIRDB_CLONE';
/
-- Question 6

ALTER TABLE airdb_clone
    ADD CONSTRAINT aaiccomb UNIQUE ( origin_airport_id,
                                     dest_airport_id,
                                     fl_num,
                                     carrier,
                                     fl_date );
/
-- Question 7

CREATE TABLE airdb_airports (
    airport_id       NUMBER,
    city_market_id   NUMBER,
    airport_code     VARCHAR2(3) PRIMARY KEY,
    city_name        VARCHAR2(30),
    state_abr        VARCHAR2(2),
    state_fips       NUMBER,
    state_name       VARCHAR2(30)
);
/
-- Question 8

INSERT INTO airdb_airports (
    airport_id,
    city_market_id,
    airport_code,
    city_name,
    state_abr,
    state_fips,
    state_name
)
    SELECT
        origin_airport_id,
        origin_city_market_id,
        origin,
        origin_city_name,
        origin_state_abr,
        origin_state_fips,
        origin_state_nm
    FROM
        airdb_all_info
    UNION ALL
    SELECT
        dest_airport_id,
        dest_city_market_id,
        dest,
        dest_city_name,
        dest_state_abr,
        dest_state_fips,
        dest_state_nm
    FROM
        airdb_all_info;

    INSERT INTO airdb_airports (
        airport_id,
        city_market_id,
        airport_code,
        city_name,
        state_abr,
        state_fips,
        state_name
    )
        SELECT
            origin_airport_id,
            origin_city_market_id,
            origin,
            origin_city_name,
            origin_state_abr,
            origin_state_fips,
            origin_state_nm
        FROM
            airdb_all_info
        UNION
        SELECT
            dest_airport_id,
            dest_city_market_id,
            dest,
            dest_city_name,
            dest_state_abr,
            dest_state_fips,
            dest_state_nm
        FROM
            airdb_all_info;

/
-- Question 9
alter table airdb_clone
    add constraint origin_fk foreign key (origin) references airdb_airports(airport_code);
alter table airdb_clone
    add constraint dest_fk foreign key (dest) references airdb_airports(airport_code);
/
select * from user_constraints where table_name = 'AIRDB_CLONE';

--10
ALTER TABLE airdb_clone drop (origin_city_market_id, origin_state_fips, dest_city_market_id, dest_state_fips);
/

--11
ALTER TABLE AIRDB_AIRPORTS
ADD CONSTRAINT STATE_CHECK
CHECK (STATE_ABR IN ('AL','AK', 'AZ', 'AR', 'CA','CO','CT''DE','FL','GA','HI','ID','IL','IN','IA','KS','KY','LA','ME','MD','MA','MI','MN','MS','MO','MT','NE','NV','NH','NJ','NM','NY','NC','ND','OH','OK','OR','PA','RI','SC','SD',
'TN','TX','UT','VT','VA','WA','WV','WI','WY'));
/

--12
ALTER TABLE AIRDB_AIRPORTS
ADD CONSTRAINT STATE_CHECK
CHECK (STATE_ABR IN ('AL','AK', 'AZ', 'AR', 'CA','CO','CT''DE','FL','GA','HI','ID','IL','IN','IA','KS','KY','LA','ME','MD','MA','MI','MN','MS','MO','MT','NE','NV','NH','NJ','NM','NY','NC','ND','OH','OK','OR','PA','RI','SC','SD',
'TN','TX','UT','VT','VA','WA','WV','WI','WY')) DISABLE;
/
select * from user_constraints where table_name = 'AIRDB_AIRPORTS';
/
-- Question 13
DELETE FROM AIRDB_AIRPORTS 
WHERE (STATE_ABR NOT IN ('AL','AK', 'AZ', 'AR', 'CA','CO','CT''DE','FL',
'GA','HI','ID','IL','IN','IA','KS','KY','LA','ME','MD','MA','MI','MN',
'MS','MO','MT','NE','NV','NH','NJ','NM','NY','NC','ND','OH','OK','OR',
'PA','RI','SC','SD','TN','TX','UT','VT','VA','WA','WV','WI','WY')
);
/
-- Question 14
ALTER TABLE AIRDB_CLONE
    DROP CONSTRAINT origin_fk;
ALTER TABLE airdb_clone
    ADD CONSTRAINT origin_fk FOREIGN KEY (dest) 
    REFERENCES airdb_airports ON DELETE SET NULL;
/
-- Question 15
ALTER TABLE airdb_clone
    DROP CONSTRAINT dest_fk;
ALTER TABLE airdb_clone
    ADD CONSTRAINT  dest_fk FOREIGN KEY (origin)
    REFERENCES airdb_airports ON DELETE CASCADE;
/
-- Question 16
DELETE FROM AIRDB_AIRPORTS 
WHERE (STATE_ABR NOT IN ('AL','AK', 'AZ', 'AR', 'CA','CO',
'CT''DE','FL','GA','HI','ID','IL','IN','IA','KS','KY','LA',
'ME','MD','MA','MI','MN','MS','MO','MT','NE','NV','NH','NJ',
'NM','NY','NC','ND','OH','OK','OR','PA','RI','SC','SD',
'TN','TX','UT','VT','VA','WA','WV','WI','WY')
);
/
-- Question 17
ALTER TABLE AIRDB_AIRPORTS
ENABLE CONSTRAINT STATE_CHECK;
/
-- Question 18
select count(*) from airdb_clone
where Origin = null;
/
select count(*) from airdb_clone
where Dest = null;
/
-- Question 19
ALTER TABLE AIRDB_AIRPORTS
ADD CONSTRAINT UNI UNIQUE (AIRPORT_CODE);
/
ALTER TABLE AIRDB_AIRPORTS
MODIFY AIRPORT_CODE NOT NULL;
/
-- Question 20
ALTER TABLE AIRDB_AIRPORTS
ADD CONSTRAINT UNI_CITY UNIQUE (CITY_NAME);
/

-- Question 21
DROP TABLE airdb_all_info CASCADE CONSTRAINTS;

DROP TABLE airdb_clone CASCADE CONSTRAINTS;

DROP TABLE airdb_airports CASCADE CONSTRAINTS;
/


/* Results:
-- Question 1
Table AIRDB_ALL_INFO created.

/
-- Question 2
Table AIRDB_ALL_INFO altered.
Table AIRDB_ALL_INFO altered.
Table AIRDB_ALL_INFO altered.
/
-- Question 3
OWNER                                                                                                                            CONSTRAINT_NAME                                                                                                                  C TABLE_NAME                                                                                                                       SEARCH_CONDITION
-------------------------------------------------------------------------------------------------------------------------------- -------------------------------------------------------------------------------------------------------------------------------- - -------------------------------------------------------------------------------------------------------------------------------- --------------------------------------------------------------------------------
SEARCH_CONDITION_VC
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
R_OWNER                                                                                                                          R_CONSTRAINT_NAME                                                                                                                DELETE_RU STATUS   DEFERRABLE     DEFERRED  VALIDATED     GENERATED      BAD RELY LAST_CHAN INDEX_OWNER                                                                                                                      INDEX_NAME                                                                                                                       INVALID VIEW_RELATED   ORIGIN_CON_ID
-------------------------------------------------------------------------------------------------------------------------------- -------------------------------------------------------------------------------------------------------------------------------- --------- -------- -------------- --------- ------------- -------------- --- ---- --------- -------------------------------------------------------------------------------------------------------------------------------- -------------------------------------------------------------------------------------------------------------------------------- ------- -------------- -------------
AJPOLAK                                                                                                                          SYS_C00266636                                                                                                                    C AIRDB_ALL_INFO                                                                                                                   "ORIGIN_STATE_NM" IS NOT NULL                                                    
"ORIGIN_STATE_NM" IS NOT NULL                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
                                                                                                                                                                                                                                                                            ENABLED  NOT DEFERRABLE IMMEDIATE VALIDATED     GENERATED NAME          05-DEC-21                                                                                                                                                                                                                                                                                                      0

AJPOLAK                                                                                                                          SYS_C00266637                                                                                                                    C AIRDB_ALL_INFO                                                                                                                   "DEST_STATE_NM" IS NOT NULL                                                      
"DEST_STATE_NM" IS NOT NULL                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      
                                                                                                                                                                                                                                                                            ENABLED  NOT DEFERRABLE IMMEDIATE VALIDATED     GENERATED NAME          05-DEC-21                                                                                                                                                                                                                                                                                                      0

OWNER                                                                                                                            CONSTRAINT_NAME                                                                                                                  C TABLE_NAME                                                                                                                       SEARCH_CONDITION
-------------------------------------------------------------------------------------------------------------------------------- -------------------------------------------------------------------------------------------------------------------------------- - -------------------------------------------------------------------------------------------------------------------------------- --------------------------------------------------------------------------------
SEARCH_CONDITION_VC
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
R_OWNER                                                                                                                          R_CONSTRAINT_NAME                                                                                                                DELETE_RU STATUS   DEFERRABLE     DEFERRED  VALIDATED     GENERATED      BAD RELY LAST_CHAN INDEX_OWNER                                                                                                                      INDEX_NAME                                                                                                                       INVALID VIEW_RELATED   ORIGIN_CON_ID
-------------------------------------------------------------------------------------------------------------------------------- -------------------------------------------------------------------------------------------------------------------------------- --------- -------- -------------- --------- ------------- -------------- --- ---- --------- -------------------------------------------------------------------------------------------------------------------------------- -------------------------------------------------------------------------------------------------------------------------------- ------- -------------- -------------

AJPOLAK                                                                                                                          AAI_C1                                                                                                                           U AIRDB_ALL_INFO                                                                                                                                                                                                    
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
                                                                                                                                                                                                                                                                            ENABLED  NOT DEFERRABLE IMMEDIATE VALIDATED     USER NAME               05-DEC-21 AJPOLAK                                                                                                                          AAI_C1                                                                                                                                                              0

AJPOLAK                                                                                                                          SYS_C00266573                                                                                                                    C AIRDB_ALL_INFO                                                                                                                   "ORIGIN_CITY_NAME" IS NOT NULL                                                   
"ORIGIN_CITY_NAME" IS NOT NULL                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   

OWNER                                                                                                                            CONSTRAINT_NAME                                                                                                                  C TABLE_NAME                                                                                                                       SEARCH_CONDITION
-------------------------------------------------------------------------------------------------------------------------------- -------------------------------------------------------------------------------------------------------------------------------- - -------------------------------------------------------------------------------------------------------------------------------- --------------------------------------------------------------------------------
SEARCH_CONDITION_VC
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
R_OWNER                                                                                                                          R_CONSTRAINT_NAME                                                                                                                DELETE_RU STATUS   DEFERRABLE     DEFERRED  VALIDATED     GENERATED      BAD RELY LAST_CHAN INDEX_OWNER                                                                                                                      INDEX_NAME                                                                                                                       INVALID VIEW_RELATED   ORIGIN_CON_ID
-------------------------------------------------------------------------------------------------------------------------------- -------------------------------------------------------------------------------------------------------------------------------- --------- -------- -------------- --------- ------------- -------------- --- ---- --------- -------------------------------------------------------------------------------------------------------------------------------- -------------------------------------------------------------------------------------------------------------------------------- ------- -------------- -------------
                                                                                                                                                                                                                                                                            ENABLED  NOT DEFERRABLE IMMEDIATE VALIDATED     GENERATED NAME          05-DEC-21                                                                                                                                                                                                                                                                                                      0


/
-- Question 4

Table AIRDB_CLONE created.
/
-- Question 5

NOTICED THE CLONE IS MISSING THE CONSTRAINT NAME.

OWNER                                                                                                                            CONSTRAINT_NAME                                                                                                                  C TABLE_NAME                                                                                                                       SEARCH_CONDITION
-------------------------------------------------------------------------------------------------------------------------------- -------------------------------------------------------------------------------------------------------------------------------- - -------------------------------------------------------------------------------------------------------------------------------- --------------------------------------------------------------------------------
SEARCH_CONDITION_VC
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
R_OWNER                                                                                                                          R_CONSTRAINT_NAME                                                                                                                DELETE_RU STATUS   DEFERRABLE     DEFERRED  VALIDATED     GENERATED      BAD RELY LAST_CHAN INDEX_OWNER                                                                                                                      INDEX_NAME                                                                                                                       INVALID VIEW_RELATED   ORIGIN_CON_ID
-------------------------------------------------------------------------------------------------------------------------------- -------------------------------------------------------------------------------------------------------------------------------- --------- -------- -------------- --------- ------------- -------------- --- ---- --------- -------------------------------------------------------------------------------------------------------------------------------- -------------------------------------------------------------------------------------------------------------------------------- ------- -------------- -------------
AJPOLAK                                                                                                                          SYS_C00266669                                                                                                                    C AIRDB_CLONE                                                                                                                      "ORIGIN_STATE_NM" IS NOT NULL                                                    
"ORIGIN_STATE_NM" IS NOT NULL                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
                                                                                                                                                                                                                                                                            ENABLED  NOT DEFERRABLE IMMEDIATE VALIDATED     GENERATED NAME          05-DEC-21                                                                                                                                                                                                                                                                                                      0

AJPOLAK                                                                                                                          SYS_C00266668                                                                                                                    C AIRDB_CLONE                                                                                                                      "ORIGIN_CITY_NAME" IS NOT NULL                                                   
"ORIGIN_CITY_NAME" IS NOT NULL                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
                                                                                                                                                                                                                                                                            ENABLED  NOT DEFERRABLE IMMEDIATE VALIDATED     GENERATED NAME          05-DEC-21                                                                                                                                                                                                                                                                                                      0

OWNER                                                                                                                            CONSTRAINT_NAME                                                                                                                  C TABLE_NAME                                                                                                                       SEARCH_CONDITION
-------------------------------------------------------------------------------------------------------------------------------- -------------------------------------------------------------------------------------------------------------------------------- - -------------------------------------------------------------------------------------------------------------------------------- --------------------------------------------------------------------------------
SEARCH_CONDITION_VC
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
R_OWNER                                                                                                                          R_CONSTRAINT_NAME                                                                                                                DELETE_RU STATUS   DEFERRABLE     DEFERRED  VALIDATED     GENERATED      BAD RELY LAST_CHAN INDEX_OWNER                                                                                                                      INDEX_NAME                                                                                                                       INVALID VIEW_RELATED   ORIGIN_CON_ID
-------------------------------------------------------------------------------------------------------------------------------- -------------------------------------------------------------------------------------------------------------------------------- --------- -------- -------------- --------- ------------- -------------- --- ---- --------- -------------------------------------------------------------------------------------------------------------------------------- -------------------------------------------------------------------------------------------------------------------------------- ------- -------------- -------------

AJPOLAK                                                                                                                          SYS_C00266670                                                                                                                    C AIRDB_CLONE                                                                                                                      "DEST_STATE_NM" IS NOT NULL                                                      
"DEST_STATE_NM" IS NOT NULL                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      
                                                                                                                                                                                                                                                                            ENABLED  NOT DEFERRABLE IMMEDIATE VALIDATED     GENERATED NAME          05-DEC-21                                                                                                                                                                                                                                                                                                      0

/
-- Question 6
Table AIRDB_CLONE altered.


/
-- Question 7

Table AIRDB_AIRPORTS created.

/
-- Question 8
Error starting at line : 91 in command -
INSERT INTO airdb_airports (
    airport_id,
    city_market_id,
    airport_code,
    city_name,
    state_abr,
    state_fips,
    state_name
)
    SELECT
        origin_airport_id,
        origin_city_market_id,
        origin,
        origin_city_name,
        origin_state_abr,
        origin_state_fips,
        origin_state_nm
    FROM
        airdb_all_info
    UNION ALL
    SELECT
        dest_airport_id,
        dest_city_market_id,
        dest,
        dest_city_name,
        dest_state_abr,
        dest_state_fips,
        dest_state_nm
    FROM
        airdb_all_info
Error report -
ORA-00001: unique constraint (AJPOLAK.SYS_C00267565) violated


294 rows inserted.

UNION ALL DOES NOT REMOVE THE DUPLICATES.

/
-- Question 9

Table AIRDB_CLONE altered.


Table AIRDB_CLONE altered.


OWNER                                                                                                                            CONSTRAINT_NAME                                                                                                                  C TABLE_NAME                                                                                                                       SEARCH_CONDITION
-------------------------------------------------------------------------------------------------------------------------------- -------------------------------------------------------------------------------------------------------------------------------- - -------------------------------------------------------------------------------------------------------------------------------- --------------------------------------------------------------------------------
SEARCH_CONDITION_VC
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
R_OWNER                                                                                                                          R_CONSTRAINT_NAME                                                                                                                DELETE_RU STATUS   DEFERRABLE     DEFERRED  VALIDATED     GENERATED      BAD RELY LAST_CHAN INDEX_OWNER                                                                                                                      INDEX_NAME                                                                                                                       INVALID VIEW_RELATED   ORIGIN_CON_ID
-------------------------------------------------------------------------------------------------------------------------------- -------------------------------------------------------------------------------------------------------------------------------- --------- -------- -------------- --------- ------------- -------------- --- ---- --------- -------------------------------------------------------------------------------------------------------------------------------- -------------------------------------------------------------------------------------------------------------------------------- ------- -------------- -------------
AJPOLAK                                                                                                                          ORIGIN_FK                                                                                                                        R AIRDB_CLONE                                                                                                                                                                                                       
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
AJPOLAK                                                                                                                          SYS_C00267565                                                                                                                    NO ACTION ENABLED  NOT DEFERRABLE IMMEDIATE VALIDATED     USER NAME               06-DEC-21                                                                                                                                                                                                                                                                                                      0

AJPOLAK                                                                                                                          DEST_FK                                                                                                                          R AIRDB_CLONE                                                                                                                                                                                                       
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
AJPOLAK                                                                                                                          SYS_C00267565                                                                                                                    NO ACTION ENABLED  NOT DEFERRABLE IMMEDIATE VALIDATED     USER NAME               06-DEC-21                                                                                                                                                                                                                                                                                                      0

OWNER                                                                                                                            CONSTRAINT_NAME                                                                                                                  C TABLE_NAME                                                                                                                       SEARCH_CONDITION
-------------------------------------------------------------------------------------------------------------------------------- -------------------------------------------------------------------------------------------------------------------------------- - -------------------------------------------------------------------------------------------------------------------------------- --------------------------------------------------------------------------------
SEARCH_CONDITION_VC
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
R_OWNER                                                                                                                          R_CONSTRAINT_NAME                                                                                                                DELETE_RU STATUS   DEFERRABLE     DEFERRED  VALIDATED     GENERATED      BAD RELY LAST_CHAN INDEX_OWNER                                                                                                                      INDEX_NAME                                                                                                                       INVALID VIEW_RELATED   ORIGIN_CON_ID
-------------------------------------------------------------------------------------------------------------------------------- -------------------------------------------------------------------------------------------------------------------------------- --------- -------- -------------- --------- ------------- -------------- --- ---- --------- -------------------------------------------------------------------------------------------------------------------------------- -------------------------------------------------------------------------------------------------------------------------------- ------- -------------- -------------

AJPOLAK                                                                                                                          SYS_C00267560                                                                                                                    C AIRDB_CLONE                                                                                                                      "ORIGIN_CITY_NAME" IS NOT NULL                                                   
"ORIGIN_CITY_NAME" IS NOT NULL                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
                                                                                                                                                                                                                                                                            ENABLED  NOT DEFERRABLE IMMEDIATE VALIDATED     GENERATED NAME          06-DEC-21                                                                                                                                                                                                                                                                                                      0

AJPOLAK                                                                                                                          SYS_C00267561                                                                                                                    C AIRDB_CLONE                                                                                                                      "ORIGIN_STATE_NM" IS NOT NULL                                                    
"ORIGIN_STATE_NM" IS NOT NULL                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  

OWNER                                                                                                                            CONSTRAINT_NAME                                                                                                                  C TABLE_NAME                                                                                                                       SEARCH_CONDITION
-------------------------------------------------------------------------------------------------------------------------------- -------------------------------------------------------------------------------------------------------------------------------- - -------------------------------------------------------------------------------------------------------------------------------- --------------------------------------------------------------------------------
SEARCH_CONDITION_VC
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
R_OWNER                                                                                                                          R_CONSTRAINT_NAME                                                                                                                DELETE_RU STATUS   DEFERRABLE     DEFERRED  VALIDATED     GENERATED      BAD RELY LAST_CHAN INDEX_OWNER                                                                                                                      INDEX_NAME                                                                                                                       INVALID VIEW_RELATED   ORIGIN_CON_ID
-------------------------------------------------------------------------------------------------------------------------------- -------------------------------------------------------------------------------------------------------------------------------- --------- -------- -------------- --------- ------------- -------------- --- ---- --------- -------------------------------------------------------------------------------------------------------------------------------- -------------------------------------------------------------------------------------------------------------------------------- ------- -------------- -------------
                                                                                                                                                                                                                                                                            ENABLED  NOT DEFERRABLE IMMEDIATE VALIDATED     GENERATED NAME          06-DEC-21                                                                                                                                                                                                                                                                                                      0

AJPOLAK                                                                                                                          SYS_C00267562                                                                                                                    C AIRDB_CLONE                                                                                                                      "DEST_CITY_NAME" IS NOT NULL                                                     
"DEST_CITY_NAME" IS NOT NULL                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
                                                                                                                                                                                                                                                                            ENABLED  NOT DEFERRABLE IMMEDIATE VALIDATED     GENERATED NAME          06-DEC-21                                                                                                                                                                                                                                                                                                      0

AJPOLAK                                                                                                                          SYS_C00267563                                                                                                                    C AIRDB_CLONE                                                                                                                      "DEST_STATE_NM" IS NOT NULL                                                      

OWNER                                                                                                                            CONSTRAINT_NAME                                                                                                                  C TABLE_NAME                                                                                                                       SEARCH_CONDITION
-------------------------------------------------------------------------------------------------------------------------------- -------------------------------------------------------------------------------------------------------------------------------- - -------------------------------------------------------------------------------------------------------------------------------- --------------------------------------------------------------------------------
SEARCH_CONDITION_VC
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
R_OWNER                                                                                                                          R_CONSTRAINT_NAME                                                                                                                DELETE_RU STATUS   DEFERRABLE     DEFERRED  VALIDATED     GENERATED      BAD RELY LAST_CHAN INDEX_OWNER                                                                                                                      INDEX_NAME                                                                                                                       INVALID VIEW_RELATED   ORIGIN_CON_ID
-------------------------------------------------------------------------------------------------------------------------------- -------------------------------------------------------------------------------------------------------------------------------- --------- -------- -------------- --------- ------------- -------------- --- ---- --------- -------------------------------------------------------------------------------------------------------------------------------- -------------------------------------------------------------------------------------------------------------------------------- ------- -------------- -------------
"DEST_STATE_NM" IS NOT NULL                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
                                                                                                                                                                                                                                                                            ENABLED  NOT DEFERRABLE IMMEDIATE VALIDATED     GENERATED NAME          06-DEC-21                                                                                                                                                                                                                                                                                                      0

AJPOLAK                                                                                                                          AAICCOMB                                                                                                                         U AIRDB_CLONE                                                                                                                                                                                                       
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
                                                                                                                                                                                                                                                                            ENABLED  NOT DEFERRABLE IMMEDIATE VALIDATED     USER NAME               06-DEC-21 AJPOLAK                                                                                                                          AAICCOMB                                                                                                                                                            0


7 rows selected. 


/
-- Question 10

Table AIRDB_CLONE altered.

/
-- Question 11

There may be void data in the table or issues with the datatype corresponding. 

Error starting at line : 167 in command -
ALTER TABLE AIRDB_AIRPORTS
ADD CONSTRAINT STATE_CHECK
CHECK (STATE_ABR IN ('AL','AK', 'AZ', 'AR', 'CA','CO','CT''DE','FL','GA','HI','ID','IL','IN','IA','KS','KY','LA','ME','MD','MA','MI','MN','MS','MO','MT','NE','NV','NH','NJ','NM','NY','NC','ND','OH','OK','OR','PA','RI','SC','SD',
'TN','TX','UT','VT','VA','WA','WV','WI','WY'))
Error report -
ORA-02293: cannot validate (AJPOLAK.STATE_CHECK) - check constraint violated
02293. 00000 - "cannot validate (%s.%s) - check constraint violated"
*Cause:    an alter table operation tried to validate a check constraint to
           populated table that had nocomplying values.
*Action:   Obvious

/
-- Question 12
Table AIRDB_AIRPORTS altered.


OWNER                                                                                                                            CONSTRAINT_NAME                                                                                                                  C TABLE_NAME                                                                                                                       SEARCH_CONDITION
-------------------------------------------------------------------------------------------------------------------------------- -------------------------------------------------------------------------------------------------------------------------------- - -------------------------------------------------------------------------------------------------------------------------------- --------------------------------------------------------------------------------
SEARCH_CONDITION_VC
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
R_OWNER                                                                                                                          R_CONSTRAINT_NAME                                                                                                                DELETE_RU STATUS   DEFERRABLE     DEFERRED  VALIDATED     GENERATED      BAD RELY LAST_CHAN INDEX_OWNER                                                                                                                      INDEX_NAME                                                                                                                       INVALID VIEW_RELATED   ORIGIN_CON_ID
-------------------------------------------------------------------------------------------------------------------------------- -------------------------------------------------------------------------------------------------------------------------------- --------- -------- -------------- --------- ------------- -------------- --- ---- --------- -------------------------------------------------------------------------------------------------------------------------------- -------------------------------------------------------------------------------------------------------------------------------- ------- -------------- -------------
AJPOLAK                                                                                                                          SYS_C00267565                                                                                                                    P AIRDB_AIRPORTS                                                                                                                                                                                                    
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
                                                                                                                                                                                                                                                                            ENABLED  NOT DEFERRABLE IMMEDIATE VALIDATED     GENERATED NAME          06-DEC-21 AJPOLAK                                                                                                                          SYS_C00267565                                                                                                                                                       0

AJPOLAK                                                                                                                          STATE_CHECK                                                                                                                      C AIRDB_AIRPORTS                                                                                                                   STATE_ABR IN ('AL','AK', 'AZ', 'AR', 'CA','CO','CT''DE','FL','GA','HI','ID','IL' 
STATE_ABR IN ('AL','AK', 'AZ', 'AR', 'CA','CO','CT''DE','FL','GA','HI','ID','IL','IN','IA','KS','KY','LA','ME','MD','MA','MI','MN','MS','MO','MT','NE','NV','NH','NJ','NM','NY','NC','ND','OH','OK','OR','PA','RI','SC','SD',                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
'TN','TX','UT','VT','VA','WA','WV','WI','WY')                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  

OWNER                                                                                                                            CONSTRAINT_NAME                                                                                                                  C TABLE_NAME                                                                                                                       SEARCH_CONDITION
-------------------------------------------------------------------------------------------------------------------------------- -------------------------------------------------------------------------------------------------------------------------------- - -------------------------------------------------------------------------------------------------------------------------------- --------------------------------------------------------------------------------
SEARCH_CONDITION_VC
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
R_OWNER                                                                                                                          R_CONSTRAINT_NAME                                                                                                                DELETE_RU STATUS   DEFERRABLE     DEFERRED  VALIDATED     GENERATED      BAD RELY LAST_CHAN INDEX_OWNER                                                                                                                      INDEX_NAME                                                                                                                       INVALID VIEW_RELATED   ORIGIN_CON_ID
-------------------------------------------------------------------------------------------------------------------------------- -------------------------------------------------------------------------------------------------------------------------------- --------- -------- -------------- --------- ------------- -------------- --- ---- --------- -------------------------------------------------------------------------------------------------------------------------------- -------------------------------------------------------------------------------------------------------------------------------- ------- -------------- -------------
                                                                                                                                                                                                                                                                            DISABLED NOT DEFERRABLE IMMEDIATE NOT VALIDATED USER NAME               06-DEC-21                                                                                                                                                                                                                                                                                                      0



/
-- Question 13

The delete will not run due to the child records connected to the data.

Error starting at line : 182 in command -
DELETE FROM AIRDB_AIRPORTS 
WHERE (STATE_ABR NOT IN ('AL','AK', 'AZ', 'AR', 'CA','CO','CT''DE','FL',
'GA','HI','ID','IL','IN','IA','KS','KY','LA','ME','MD','MA','MI','MN',
'MS','MO','MT','NE','NV','NH','NJ','NM','NY','NC','ND','OH','OK','OR',
'PA','RI','SC','SD','TN','TX','UT','VT','VA','WA','WV','WI','WY')
)
Error report -
ORA-02292: integrity constraint (AJPOLAK.DEST_FK) violated - child record found


/
-- Question 14
Table AIRDB_CLONE altered.

Table AIRDB_CLONE altered.

/
-- Question 15
Table AIRDB_CLONE altered.

Table AIRDB_CLONE altered.
/
-- Question 16

The child recordes will be null or deleted, while the parent data is deleted. 

6 rows deleted.

/
-- Question 17
the conflicting data was deleted.

Table AIRDB_AIRPORTS altered.

/
-- Question 18
There are 0 null ids in the table. It will make the forpeign data null.

  COUNT(*)
----------
         0


  COUNT(*)
----------
         0

/
-- Question 19

Table AIRDB_AIRPORTS altered.

/
-- Question 20
Error starting at line : 231 in command -
ALTER TABLE AIRDB_AIRPORTS
ADD CONSTRAINT UNI_CITY UNIQUE (CITY_NAME)
Error report -
ORA-02299: cannot validate (AJPOLAK.UNI_CITY) - duplicate keys found
02299. 00000 - "cannot validate (%s.%s) - duplicate keys found"
*Cause:    an alter table validating constraint failed because the table has
           duplicate key values.
*Action:   Obvious
/

-- Question 21

Table AIRDB_ALL_INFO dropped.


Table AIRDB_CLONE dropped.


Table AIRDB_AIRPORTS dropped.

/
*/

