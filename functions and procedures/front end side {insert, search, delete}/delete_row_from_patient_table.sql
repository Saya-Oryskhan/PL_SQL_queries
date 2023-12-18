CREATE OR REPLACE PROCEDURE delete_patient(
    p_patient_id IN PATIENT.PATIENT_ID%TYPE
)
AS
BEGIN
    DELETE FROM PATIENT
    WHERE PATIENT_ID = p_patient_id;

    COMMIT;
END;
/

DECLARE
    v_patient_id PATIENT.PATIENT_ID%TYPE := 122;
BEGIN
    delete_patient(v_patient_id);
END;
/
