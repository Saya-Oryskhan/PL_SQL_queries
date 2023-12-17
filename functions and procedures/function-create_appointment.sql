CREATE OR REPLACE FUNCTION GENERATE_APPOINTMENT_ID RETURN NUMBER IS
    v_appointment_id NUMBER(9);
    v_exists NUMBER;
BEGIN
    LOOP
        v_appointment_id := TRUNC(DBMS_RANDOM.VALUE(100000000, 999999999));
        SELECT COUNT(*)
        INTO   v_exists
        FROM   APPOINTMENT
        WHERE  APPOINTMENT_ID = v_appointment_id;

        EXIT WHEN v_exists = 0;
    END LOOP;

    RETURN v_appointment_id;
END GENERATE_APPOINTMENT_ID;
/


DECLARE
    v_appointment_id NUMBER;
BEGIN
    v_appointment_id := GENERATE_APPOINTMENT_ID;

    INSERT INTO APPOINTMENT (APPOINTMENT_ID)
    VALUES (v_appointment_id);

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('New appointment added with ID: ' || v_appointment_id);
END;
/
