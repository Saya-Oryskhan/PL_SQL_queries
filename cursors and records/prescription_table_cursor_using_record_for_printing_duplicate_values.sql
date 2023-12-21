DECLARE
  TYPE PrescriptionRecordType IS RECORD (
    prescription_id          PRESCRIPTION.prescription_id%TYPE,
    appointment_id           PRESCRIPTION.appointment_id%TYPE,
    medication_name          PRESCRIPTION.medication_name%TYPE,
    diagnosis_code           PRESCRIPTION.diagnosis_code%TYPE,
    date_of_appointment      PRESCRIPTION.date_of_appointment%TYPE,
    organization_name_company PRESCRIPTION.organization_name_company%TYPE
  );

  CURSOR prescription_cursor IS
    SELECT *
    FROM PRESCRIPTION
    ORDER BY diagnosis_code;

  v_previous_diagnosis_code PRESCRIPTION.diagnosis_code%TYPE;
  v_prescription_record PrescriptionRecordType;
BEGIN
  OPEN prescription_cursor;

  FETCH prescription_cursor INTO
    v_prescription_record;

  LOOP
    EXIT WHEN prescription_cursor%NOTFOUND;

    IF v_previous_diagnosis_code = v_prescription_record.diagnosis_code THEN
      DBMS_OUTPUT.PUT_LINE('Prescription and Appointment ID: ' || 
                           v_prescription_record.prescription_id || '-' || v_prescription_record.appointment_id ||
                           ', Medication Name: ' || v_prescription_record.medication_name ||
                           ', Diagnosis Code: ' || v_prescription_record.diagnosis_code ||
                           ', Date of Appointment: ' || v_prescription_record.date_of_appointment ||
                           ', Organization Name (Company): ' || v_prescription_record.organization_name_company);
    END IF;

    v_previous_diagnosis_code := v_prescription_record.diagnosis_code;

    FETCH prescription_cursor INTO
      v_prescription_record;
  END LOOP;

  CLOSE prescription_cursor;
END;
/

