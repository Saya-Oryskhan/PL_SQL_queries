CREATE OR REPLACE PACKAGE payment_pkg AS
   TYPE payment_collection IS TABLE OF NUMBER INDEX BY PLS_INTEGER;
   TYPE date_collection IS TABLE OF DATE INDEX BY PLS_INTEGER;
   TYPE amount_collection IS TABLE OF NUMBER INDEX BY PLS_INTEGER;
END payment_pkg;
/

CREATE OR REPLACE FUNCTION generate_payment_id RETURN NUMBER IS
   v_id NUMBER;
   v_count NUMBER;
BEGIN
   LOOP
      v_id := TRUNC(DBMS_RANDOM.VALUE(1, 10000));
      SELECT COUNT(*) INTO v_count
      FROM PAYMENT
      WHERE payment_id = v_id;

      EXIT WHEN v_count = 0;
   END LOOP;

   RETURN v_id;
END generate_payment_id;
/

CREATE OR REPLACE PROCEDURE populate_payments AS
   v_payment_ids payment_pkg.payment_collection;
   v_payment_dates payment_pkg.date_collection;
   v_payment_amounts payment_pkg.amount_collection;
BEGIN
   FOR i IN 1 .. 4
   LOOP
      v_payment_ids(i) := generate_payment_id;
      v_payment_dates(i) := SYSDATE;
      v_payment_amounts(i) := 100 * i;

      BEGIN
         INSERT INTO PAYMENT (payment_id, payment_date, payment_amount)
         VALUES (v_payment_ids(i), v_payment_dates(i), v_payment_amounts(i));

         DBMS_OUTPUT.PUT_LINE('New values: payment_id=' || v_payment_ids(i) || ', payment_date=' || TO_CHAR(v_payment_dates(i), 'DD/MM/YYYY') || ', payment_amount=' || v_payment_amounts(i));
      EXCEPTION
         WHEN DUP_VAL_ON_INDEX THEN
            NULL;
      END;
   END LOOP;
END populate_payments;
/

BEGIN
   populate_payments;
   COMMIT;
END;
/

