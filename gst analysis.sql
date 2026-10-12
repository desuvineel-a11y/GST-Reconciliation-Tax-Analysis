-- Analysis 1: Calculate GST collected
SELECT
    SUM(taxable_value) AS total_taxable_sales,
    SUM(cgst) AS total_cgst,
    SUM(sgst) AS total_sgst,
    SUM(igst) AS total_igst,
    SUM(cgst + sgst + igst) AS total_gst_collected
FROM sales
WHERE doc_type = 'Invoice';

-- Monthly sales and GST trend
SELECT
    DATE_FORMAT(invoice_date, '%Y-%m') AS sales_month,
    SUM(taxable_value) AS monthly_taxable_sales,
    SUM(cgst + sgst + igst) AS monthly_gst
FROM sales
WHERE doc_type = 'Invoice'
GROUP BY DATE_FORMAT(invoice_date, '%Y-%m')
ORDER BY sales_month;

-- Compare GST by tax type
SELECT
    SUM(cgst + sgst) AS total_intrastate_gst,
    SUM(igst) AS total_interstate_gst,
    SUM(cgst + sgst + igst) AS total_gst
FROM sales
WHERE doc_type = 'Invoice';

-- Identify the top 10 customers by taxable sales
SELECT
    c.customer_id,
    c.customer_name,
    c.state,
    SUM(s.taxable_value) AS total_taxable_sales
FROM sales s
JOIN customers c
    ON s.customer_id = c.customer_id
WHERE s.doc_type = 'Invoice'
GROUP BY
    c.customer_id,
    c.customer_name,
    c.state
ORDER BY total_taxable_sales DESC
LIMIT 10;

-- GST by state
SELECT
    c.state,
    SUM(s.taxable_value) AS total_taxable_sales,
    SUM(s.cgst + s.sgst + s.igst) AS total_gst
FROM sales s
JOIN customers c
    ON s.customer_id = c.customer_id
WHERE s.doc_type = 'Invoice'
GROUP BY c.state
ORDER BY total_gst DESC;

-- Identify unpaid sales invoices
SELECT
    invoice_no,
    invoice_date,
    customer_id,
    total_amount
FROM sales
WHERE doc_type = 'Invoice'
  AND payment_date IS NULL
ORDER BY invoice_date;

-- Total outstanding receivables by Invioce
SELECT
    invoice_no,
    invoice_date,
    customer_id,
    SUM(total_amount) AS invoice_amount
FROM sales
WHERE doc_type = 'Invoice'
  AND payment_date IS NULL
GROUP BY
    invoice_no,
    invoice_date,
    customer_id
ORDER BY invoice_date;

-- Total outstanding amount and unpaid invoice count
SELECT
    COUNT(*) AS unpaid_invoice_count,
    SUM(invoice_amount) AS total_outstanding_amount
FROM (
    SELECT
        invoice_no,
        SUM(total_amount) AS invoice_amount
    FROM sales
    WHERE doc_type = 'Invoice'
      AND payment_date IS NULL
    GROUP BY invoice_no
) AS unpaid_invoices;

-- Purchase GST and Input Tax Credit (ITC)
SELECT
    SUM(taxable_value) AS total_purchase_value,
    SUM(gst_amount) AS total_purchase_gst,
    SUM(CASE
        WHEN itc_claimed = 'Y' THEN gst_amount
        ELSE 0
    END) AS itc_claimed_amount,
    SUM(CASE
        WHEN itc_claimed = 'N' THEN gst_amount
        ELSE 0
    END) AS itc_not_claimed_amount
FROM purchases;


-- Calculate estimated net GST payable
SELECT
    (
        SELECT SUM(cgst + sgst + igst)
        FROM sales
        WHERE doc_type = 'Invoice'
    ) AS total_gst_collected,

    (
        SELECT SUM(gst_amount)
        FROM purchases
        WHERE itc_claimed = 'Y'
    ) AS itc_claimed_amount,

    (
        SELECT SUM(cgst + sgst + igst)
        FROM sales
        WHERE doc_type = 'Invoice'
    )
    -
    (
        SELECT SUM(gst_amount)
        FROM purchases
        WHERE itc_claimed = 'Y'
    ) AS estimated_net_gst_payable;