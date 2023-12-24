CREATE OR REPLACE TRIGGER prevent_duplicate_lastname_dob
BEFORE INSERT OR UPDATE ON PATIENT
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    :NEW.DATE_OF_BIRTH := TO_CHAR(TO_DATE(:NEW.DATE_OF_BIRTH, 'DD-MM-YYYY'), 'DD/MM/YYYY');

    SELECT COUNT(*)
    INTO v_count
    FROM PATIENT
    WHERE LASTNAME = :NEW.LASTNAME
      AND DATE_OF_BIRTH = TO_DATE(:NEW.DATE_OF_BIRTH, 'DD/MM/YYYY');

    IF v_count > 0 THEN
        raise_application_error(-20001, 'Such user already exists');
    END IF;
END prevent_duplicate_lastname_dob;
/
