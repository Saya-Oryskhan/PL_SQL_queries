CREATE OR REPLACE PROCEDURE process_single_appointment AS
   v_new_appointment_id VARCHAR2(20);
   v_new_prescription_id VARCHAR2(20);
   v_diagnosis_code VARCHAR2(20);
   v_medication_name VARCHAR2(50);
   v_organization_name_company VARCHAR2(50);
   v_date_of_appointment DATE;

   CURSOR appointment_cursor IS
      SELECT APPOINTMENT_ID, DATE_OF_APPOINTMENT
      FROM APPOINTMENT
      WHERE DATE_OF_APPOINTMENT IS NULL AND ROWNUM = 1;

BEGIN
   OPEN appointment_cursor;
   FETCH appointment_cursor INTO v_new_appointment_id, v_date_of_appointment;
   CLOSE appointment_cursor;

   IF v_new_appointment_id IS NOT NULL THEN
      v_new_prescription_id := TO_CHAR(FLOOR(DBMS_RANDOM.VALUE(10, 100)), 'FM00') || '-' ||
                               TO_CHAR(FLOOR(DBMS_RANDOM.VALUE(100, 1000)), 'FM000') || '-' ||
                               TO_CHAR(FLOOR(DBMS_RANDOM.VALUE(1000, 10000)), 'FM0000');

      SELECT DIAGNOSIS_CODE, MEDICATION_NAME, ORGANIZATION_NAME_COMPANY
      INTO v_diagnosis_code, v_medication_name, v_organization_name_company
      FROM (
         SELECT DIAGNOSIS_CODE, MEDICATION_NAME, ORGANIZATION_NAME_COMPANY
         FROM PRESCRIPTION
         WHERE DIAGNOSIS_CODE IS NOT NULL
         ORDER BY DBMS_RANDOM.VALUE
      )
      WHERE ROWNUM = 1;

      INSERT INTO PRESCRIPTION (PRESCRIPTION_ID, DATE_OF_APPOINTMENT, APPOINTMENT_ID, DIAGNOSIS_CODE, MEDICATION_NAME, ORGANIZATION_NAME_COMPANY)
      VALUES (v_new_prescription_id, SYSDATE, v_new_appointment_id, v_diagnosis_code, v_medication_name, v_organization_name_company);

      UPDATE APPOINTMENT
      SET DATE_OF_APPOINTMENT = SYSDATE
      WHERE APPOINTMENT_ID = v_new_appointment_id;

   ELSE
      DBMS_OUTPUT.PUT_LINE('No appointment found without a date.');
   END IF;
END process_single_appointment;
/

BEGIN
    process_single_appointment;
END;
/

