CREATE OR REPLACE PACKAGE depot_pkg AS
   TYPE medication_collection IS TABLE OF VARCHAR2(50);
END depot_pkg;
/

CREATE OR REPLACE PROCEDURE populate_depot AS
   v_price NUMBER := 8750;
   v_medication_count NUMBER := 17;
   v_medication_names depot_pkg.medication_collection := depot_pkg.medication_collection('Diltiazem Hydrochloride', 'Mens Kirkland', 'LBEL', 'Therapeutic T Plus');
BEGIN
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
END populate_depot;
/


BEGIN
   populate_depot;
END;
/
