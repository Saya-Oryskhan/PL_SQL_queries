CREATE OR REPLACE PROCEDURE populate_depot AS
    v_price NUMBER := 8750;
    v_medication_count NUMBER := 17;
BEGIN
    FOR rec_pharmacy IN (SELECT PHARMACY_ID FROM PHARMACY)
    LOOP
        FOR rec_medication IN (
            SELECT 'Diltiazem Hydrochloride' AS MEDICATION_NAME FROM DUAL
            UNION ALL
            SELECT 'Mens Kirkland' FROM DUAL
            UNION ALL
            SELECT 'LBEL' FROM DUAL
            UNION ALL
            SELECT 'Therapeutic T Plus' FROM DUAL
        )
        LOOP
            BEGIN
                INSERT INTO DEPOT (PHARMACY_ID, MEDICATION_NAME, PRICE, AVAILABILITY_STATUS, MEDICATION_COUNT)
                VALUES (rec_pharmacy.PHARMACY_ID, rec_medication.MEDICATION_NAME, v_price, 'Available', v_medication_count);

            EXCEPTION
                WHEN DUP_VAL_ON_INDEX THEN
                    DBMS_OUTPUT.PUT_LINE('Duplicate record for PHARMACY_ID=' || rec_pharmacy.PHARMACY_ID || ' and MEDICATION_NAME=' || rec_medication.MEDICATION_NAME);
            END;
        END LOOP;
    END LOOP;
END populate_depot;
/

BEGIN
    populate_depot;
END;
/