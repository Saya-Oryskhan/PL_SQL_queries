CREATE OR REPLACE PACKAGE delivery_performance_pkg AS
    -- Procedure to update the delivered_date for a given order_id
    PROCEDURE update_delivered_date(p_order_id IN NUMBER, p_delivered_date IN DATE);


    -- Function to get the orders that were delivered on time
    FUNCTION get_on_time_deliveries RETURN SYS_REFCURSOR;

    -- Function to get the orders that were delivered late
    FUNCTION get_late_deliveries RETURN SYS_REFCURSOR;

    -- Function to get the orders that are still pending delivery
    FUNCTION get_pending_deliveries RETURN SYS_REFCURSOR;
END delivery_performance_pkg;
/






CREATE OR REPLACE PACKAGE BODY delivery_performance_pkg AS
    -- Procedure to update the delivered_date for a given order_id
    PROCEDURE update_delivered_date(p_order_id IN NUMBER, p_delivered_date IN DATE) IS
    BEGIN
        UPDATE medication_order
        SET delivered_date = p_delivered_date
        WHERE order_id = p_order_id;
    END update_delivered_date;



    -- Function to get the orders that were delivered on time
    FUNCTION get_on_time_deliveries RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor FOR
        SELECT *
        FROM medication_order
        WHERE status = 'TRUE' AND delivered_date IS NOT NULL AND delivered_date <= ordered_date;

        RETURN v_cursor;
    END get_on_time_deliveries;

    -- Function to get the orders that were delivered late
    FUNCTION get_late_deliveries RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor FOR
        SELECT *
        FROM medication_order
        WHERE status = 'TRUE' AND delivered_date IS NOT NULL AND delivered_date > ordered_date;

        RETURN v_cursor;
    END get_late_deliveries;

    -- Function to get the orders that are still pending delivery
    FUNCTION get_pending_deliveries RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor FOR
        SELECT *
        FROM medication_order
        WHERE status = 'FALSE' AND delivered_date IS NULL;

        RETURN v_cursor;
    END get_pending_deliveries;
END delivery_performance_pkg;
/