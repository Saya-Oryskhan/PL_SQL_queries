DECLARE
  CURSOR cur_prescriptions IS
    SELECT PRESCRIPTION_ID, MEDICATION_NAME
    FROM PRESCRIPTION_DETAIL
    WHERE QUANTITY IS NULL;

  v_prescription_id PRESCRIPTION_DETAIL.PRESCRIPTION_ID%TYPE;
  v_medication_name PRESCRIPTION_DETAIL.MEDICATION_NAME%TYPE;
BEGIN
  OPEN cur_prescriptions;
  LOOP
    FETCH cur_prescriptions INTO v_prescription_id, v_medication_name;
    EXIT WHEN cur_prescriptions%NOTFOUND;

    DBMS_OUTPUT.PUT_LINE('PRESCRIPTION_ID: ' || v_prescription_id || ', MEDICATION_NAME: ' || v_medication_name);
  END LOOP;
  CLOSE cur_prescriptions;
END;
/
