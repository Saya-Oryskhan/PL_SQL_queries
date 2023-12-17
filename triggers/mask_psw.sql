create or replace TRIGGER mask_password
BEFORE INSERT OR UPDATE ON PATIENT
FOR EACH ROW
DECLARE
    v_actual_password VARCHAR2(50);  
BEGIN
    v_actual_password := :NEW.PASSWORD;

    :NEW.PASSWORD := RPAD('*', LENGTH(v_actual_password), '*');
END mask_password;
/