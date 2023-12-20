CREATE OR REPLACE PROCEDURE delete_duplicate_payments (
    p_table_name IN VARCHAR2,
    p_payment_id_column IN VARCHAR2
) AS
    v_sql VARCHAR2(1000);
BEGIN
    v_sql := 'DELETE FROM ' || p_table_name ||
             ' WHERE ' || p_payment_id_column || ' IN ' ||
             '(SELECT ' || p_payment_id_column || ' FROM ' ||
             '(SELECT ' || p_payment_id_column || ', ROW_NUMBER() OVER (PARTITION BY ' ||
             p_payment_id_column || ' ORDER BY rowid) AS rnum FROM ' || p_table_name ||
             ') WHERE rnum > 1)';

    EXECUTE IMMEDIATE v_sql;
    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Duplicate payments deleted successfully.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        ROLLBACK;
END delete_duplicate_payments;
/

BEGIN
    delete_duplicate_payments('PAYMENT', 'PAYMENT_ID');
END;
/