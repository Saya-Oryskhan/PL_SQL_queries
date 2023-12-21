DECLARE
    v_total_rating NUMBER := 0;
    v_total_rated_number NUMBER := 0;
    v_average_rating NUMBER;
    
    CURSOR pharmacy_cursor IS
        SELECT NVL(RATED_NUMBER, 0) AS RATED_NUMBER, NVL(RATING, 0) AS RATING
        FROM PHARMACY;
BEGIN
    FOR pharmacy_rec IN pharmacy_cursor LOOP
        v_total_rating := v_total_rating + pharmacy_rec.RATING;
        v_total_rated_number := v_total_rated_number + pharmacy_rec.RATED_NUMBER;
    END LOOP;

    IF v_total_rated_number > 0 THEN
        v_average_rating := v_total_rating / v_total_rated_number;
        DBMS_OUTPUT.PUT_LINE('Average Rating: ' || TO_CHAR(v_average_rating));
    ELSE
        DBMS_OUTPUT.PUT_LINE('No ratings available.');
    END IF;
END;
/