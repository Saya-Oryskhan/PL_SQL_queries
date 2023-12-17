create or replace TRIGGER prevent_duplicate_contact_number
BEFORE INSERT OR UPDATE ON PATIENT
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_count
    FROM PATIENT
    WHERE CONTACT_NUMBER = :NEW.CONTACT_NUMBER;

    IF v_count > 0 THEN
        raise_application_error(-20001, 'Oopsie! Contact number already exists. Please use a different contact number.');
    END IF;
END prevent_duplicate_contact_number;
/