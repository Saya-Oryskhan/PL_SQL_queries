CREATE OR REPLACE PROCEDURE search_doctor_by_specialization(
    p_specialization IN DOCTOR.SPECIALIZATION%TYPE
)
AS
BEGIN
    FOR rec IN (SELECT LASTNAME, WORKS_SINCE, CONTACT_NUMBER
                FROM DOCTOR
                WHERE UPPER(SPECIALIZATION) LIKE '%' || UPPER(p_specialization) || '%')
    LOOP
        DBMS_OUTPUT.PUT_LINE(
            'Last Name: ' || rec.LASTNAME ||
            ', Works Since: ' || rec.WORKS_SINCE ||
            ', Contact Number: ' || TO_CHAR(rec.CONTACT_NUMBER)
        );
    END LOOP;
END;
/

DECLARE
    v_specialization DOCTOR.SPECIALIZATION%TYPE := 'Cardiology'; 
BEGIN
    search_doctor_by_specialization(v_specialization);
END;
/
