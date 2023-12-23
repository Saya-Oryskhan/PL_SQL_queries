CREATE OR REPLACE PROCEDURE add_foreign_key AS
BEGIN
  EXECUTE IMMEDIATE 'ALTER TABLE PRESCRIPTION_DETAIL ADD CONSTRAINT fk_prescription FOREIGN KEY (PRESCRIPTION_ID) REFERENCES PRESCRIPTION(PRESCRIPTION_ID)';
END add_foreign_key;
/

BEGIN
  add_foreign_key;
END;
/




CREATE OR REPLACE PROCEDURE remove_constraint AS
BEGIN
  EXECUTE IMMEDIATE 'ALTER TABLE PRESCRIPTION_detail DROP CONSTRAINT fk_prescription';
  EXECUTE IMMEDIATE 'ALTER TABLE PRESCRIPTION DROP CONSTRAINT pk_prescription';
  DBMS_OUTPUT.PUT_LINE('Foreign key and primary key constraints dropped successfully.');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END remove_constraint;
/

BEGIN
  remove_constraint;
END;
/






CREATE OR REPLACE PROCEDURE remove_primary_key(p_table_name VARCHAR2) AS
BEGIN
  EXECUTE IMMEDIATE 'ALTER TABLE ' || p_table_name || ' DROP PRIMARY KEY';
  
  DBMS_OUTPUT.PUT_LINE('Primary key dropped successfully.');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END remove_primary_key;
/

BEGIN
  remove_primary_key('your_table_name');
END;
/
