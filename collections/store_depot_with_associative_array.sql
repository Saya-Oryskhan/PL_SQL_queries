CREATE OR REPLACE PACKAGE depoot_pkg AS
   TYPE medication_associative_array IS TABLE OF VARCHAR2(50) INDEX BY PLS_INTEGER;
END depoot_pkg;
/

CREATE OR REPLACE PROCEDURE populate_depoot AS
   v_price NUMBER := 2190;
   v_medication_count NUMBER := 190;
   v_medication_names depoot_pkg.medication_associative_array;
BEGIN
   v_medication_names(1) := 'COUMADIN';
   v_medication_names(2) := 'Vicks QlearQuil';
   v_medication_names(3) := 'TopCare Laxative';
   v_medication_names(4) := 'Antacid';

   FOR rec_pharmacy IN (SELECT PHARMACY_ID FROM PHARMACY)
   LOOP
      FOR i IN v_medication_names.FIRST .. v_medication_names.LAST
      LOOP
         BEGIN
            INSERT INTO DEPOT (PHARMACY_ID, MEDICATION_NAME, PRICE, AVAILABILITY_STATUS, MEDICATION_COUNT)
            VALUES (rec_pharmacy.PHARMACY_ID, v_medication_names(i), v_price, 'Available', v_medication_count);

         EXCEPTION
            WHEN DUP_VAL_ON_INDEX THEN
               DBMS_OUTPUT.PUT_LINE('Duplicate record for PHARMACY_ID=' || rec_pharmacy.PHARMACY_ID || ' and MEDICATION_NAME=' || v_medication_names(i));
         END;
      END LOOP;
   END LOOP;
END populate_depoot;
/

BEGIN
    populate_depoot;
END;
/
