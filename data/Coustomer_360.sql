CREATE OR REPLACE VIEW vw_digital_banking_analysis AS
SELECT
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,

    ib.internet_banking_id,
    ib.username,
    ib.registration_date AS internet_banking_registered_on,
    ib.account_status AS internet_banking_status,
    ib.two_factor_enabled,

    mb.mobile_banking_id,
    mb.registered_mobile,
    mb.app_name,
    mb.device_type,
    mb.biometric_enabled,
    mb.account_status AS mobile_banking_status,

    lh.login_id,
    lh.login_time,
    lh.logout_time,
    lh.login_channel,
    lh.ip_address,
    lh.device_name,
    lh.login_status,

    ol.otp_log_id,
    ol.otp_purpose,
    ol.delivery_method,
    ol.verification_status,

    u.upi_id,
    u.provider,
    u.primary_upi,
    u.status AS upi_status

FROM customers c

LEFT JOIN internet_banking ib
       ON c.customer_id = ib.customer_id

LEFT JOIN mobile_banking mb
       ON c.customer_id = mb.customer_id

LEFT JOIN login_history lh
       ON ib.internet_banking_id = lh.internet_banking_id

LEFT JOIN otp_logs ol
       ON ib.internet_banking_id = ol.internet_banking_id

LEFT JOIN accounts a
       ON c.customer_id = a.customer_id

LEFT JOIN upi_ids u
       ON a.account_no = u.account_no;