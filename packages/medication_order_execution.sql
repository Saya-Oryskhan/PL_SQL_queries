BEGIN
    delivery_performance_pkg.update_delivered_date(1, SYSDATE);
    COMMIT;
END;
/





-- Display on-time deliveries
DECLARE
    v_cursor SYS_REFCURSOR;
    v_order_rec medication_order%ROWTYPE;
BEGIN
    v_cursor := delivery_performance_pkg.get_on_time_deliveries;
    LOOP
        FETCH v_cursor INTO v_order_rec;
        EXIT WHEN v_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('On-Time Delivery - Order ID: ' || v_order_rec.order_id);
    END LOOP;
    CLOSE v_cursor;
END;
/





-- Display late deliveries
DECLARE
    v_cursor SYS_REFCURSOR;
    v_order_rec medication_order%ROWTYPE;
BEGIN
    v_cursor := delivery_performance_pkg.get_late_deliveries;
    LOOP
        FETCH v_cursor INTO v_order_rec;
        EXIT WHEN v_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Late Delivery - Order ID: ' || v_order_rec.order_id);
    END LOOP;
    CLOSE v_cursor;
END;
/






-- Display pending deliveries
DECLARE
    v_cursor SYS_REFCURSOR;
    v_order_rec medication_order%ROWTYPE;
BEGIN
    v_cursor := delivery_performance_pkg.get_pending_deliveries;
    LOOP
        FETCH v_cursor INTO v_order_rec;
        EXIT WHEN v_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Pending Delivery - Order ID: ' || v_order_rec.order_id);
    END LOOP;
    CLOSE v_cursor;
END;
/
