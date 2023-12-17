CREATE OR REPLACE FUNCTION check_medication_availability(p_medication_name IN VARCHAR2)
RETURN VARCHAR2
AS
  v_availability_status VARCHAR2(100) := 'Not Available in any pharmacies or maybe it is a typo';
BEGIN
  SELECT 'Available'
    INTO v_availability_status
    FROM (
      SELECT 1
      FROM DEPOT
      WHERE MEDICATION_NAME = p_medication_name AND ROWNUM = 1
    );

  RETURN v_availability_status;

EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RETURN v_availability_status;
  WHEN OTHERS THEN
    RETURN 'Error';
END check_medication_availability;
/


DECLARE
  v_status VARCHAR2(100);
BEGIN
  v_status := check_medication_availability('Bee Smart');
  DBMS_OUTPUT.PUT_LINE('Availability status: ' || v_status);
END;
/