CREATE OR REPLACE PROCEDURE delete_duplicate_rows (
	p_table_name IN VARCHAR2,
	p_column_name IN VARCHAR2
) AS
BEGIN
	FOR dup_row IN (SELECT MIN(rowid) AS min_rowid
                        FROM p_table_name
                        GROUP BY p_column_name
                        HAVING COUNT(*) > 1)
        LOOP 
            DELETE FROM p_table_name
	    WHERE ROWID = dup_row.min_rowid;
        END LOOP;
END delete_duplicate_rows;
/

BEGIN
	delete_duplicate_rows('PAYMENT', 'PAYMENT_ID');
END;
/