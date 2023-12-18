CREATE OR REPLACE TRIGGER patient_delete_trigger
BEFORE DELETE ON patient
FOR EACH ROW
DECLARE
BEGIN
  DBMS_OUTPUT.PUT_LINE('Warning: Deleting a row from PATIENT table.');
  DBMS_OUTPUT.PUT_LINE('Deleted Patient ID: ' || :OLD.patient_id);
  DBMS_OUTPUT.PUT_LINE('Patient Name: ' || :OLD.lastname);
  DBMS_OUTPUT.PUT_LINE('Deletion Timestamp: ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS'));
END;
/
