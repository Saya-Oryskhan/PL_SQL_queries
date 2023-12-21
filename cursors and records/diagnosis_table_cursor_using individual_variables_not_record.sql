DECLARE
  CURSOR cur_diagnosis IS
    SELECT DIAGNOSIS_CODE, MAIN_MEDICATION_USED, DESCRIPTION
    FROM DIAGNOSIS
    ORDER BY MAIN_MEDICATION_USED; 
    
  v_diagnosis_code DIAGNOSIS.DIAGNOSIS_CODE%TYPE;
  v_main_medication_used DIAGNOSIS.MAIN_MEDICATION_USED%TYPE;
  v_description DIAGNOSIS.DESCRIPTION%TYPE;
BEGIN
  OPEN cur_diagnosis;
  LOOP
    FETCH cur_diagnosis INTO v_diagnosis_code, v_main_medication_used, v_description;
    EXIT WHEN cur_diagnosis%NOTFOUND;
    
    DBMS_OUTPUT.PUT_LINE('DIAGNOSIS_CODE: ' || v_diagnosis_code || ', MAIN_MEDICATION_USED: ' || v_main_medication_used || ', DESCRIPTION: ' || v_description);
  END LOOP;
  CLOSE cur_diagnosis;
END;
/
