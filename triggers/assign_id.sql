create or replace TRIGGER "ASSIGN_ID"
BEFORE INSERT ON PATIENT
FOR EACH ROW
BEGIN
    BEGIN
        IF :NEW.PATIENT_ID IS NULL THEN
            SELECT NVL(MAX(PATIENT_ID), 0) + 1 INTO :NEW.PATIENT_ID FROM PATIENT;
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20001, 'Oopsie! Unable to assign ID in ASSIGN_ID trigger. Reason: ' || SQLERRM);
    END;
END;
/