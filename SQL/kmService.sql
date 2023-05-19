ALTER TABLE OFFERS ADD DOCNO VARCHAR(10);

CREATE TABLE NOM_DOCNUMBERS (
    COUNTER             DOUBLE PRECISION DEFAULT 0,
    TABLENAME           VARCHAR(32),
    C_USER_ID           INTEGER,
    C_ACTIONDATETIME    TIMESTAMP DEFAULT 'now'
);

ALTER TABLE NOM_DOCNUMBERS ADD UNIQUE (TABLENAME);

CREATE INDEX IND_NOM_DOCNUMBERS_ADT ON NOM_DOCNUMBERS (C_ACTIONDATETIME);

CREATE INDEX IND_NOM_DOCNUMBERS_USRID ON NOM_DOCNUMBERS (C_USER_ID); 

INSERT INTO NOM_DOCNUMBERS (COUNTER, TABLENAME, C_USER_ID) VALUES(1, 'OFFERS', 1);

ALTER TABLE OFFERS ADD REV INTEGER DEFAULT 1 NOT NULL;

ALTER TABLE OFFERSDETAIL ADD REV VARCHAR(100); 

UPDATE OFFERSDETAIL SET REV=';1;'