CREATE OR REPLACE PROCEDURE deletee_patient(
    p_lastname IN PATIENT.LASTNAME%TYPE,
    p_dob IN PATIENT.DATE_OF_BIRTH%TYPE,
    p_contact_number IN PATIENT.CONTACT_NUMBER%TYPE,
    p_password IN PATIENT.PASSWORD%TYPE
)
AS
BEGIN
    DELETE FROM PATIENT
    WHERE LASTNAME = p_lastname
      AND DATE_OF_BIRTH = p_dob
      AND CONTACT_NUMBER = p_contact_number
      AND PASSWORD = p_password;

    COMMIT;
END;
/

DECLARE
    v_lastname PATIENT.LASTNAME%TYPE := 'OneMoreTest2';
    v_dob PATIENT.DATE_OF_BIRTH%TYPE := '19122023';
    v_contact_number PATIENT.CONTACT_NUMBER%TYPE := '1234567800';
    v_password PATIENT.PASSWORD%TYPE := 'Qwerty12345';
BEGIN
    deletee_patient(v_lastname, v_dob, v_contact_number, v_password);
END;
/
