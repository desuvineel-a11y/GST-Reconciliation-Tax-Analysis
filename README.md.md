# GST Reconciliation & Tax Analysis Dashboard

## Project Overview
This project uses Python-cleaned GST sales, purchase, customer, and product datasets to build an interactive Power BI dashboard for reviewing sales, GST collected, input tax credit (ITC), net GST liability, and overdue receivables.

## Objectives
- Track sales and taxable sales over time.
- Monitor GST collected across CGST, SGST, and IGST.
- Review ITC claimed versus not claimed.
- Identify overdue receivables by state.
- Compare GST collected with ITC claimed to support reconciliation and follow-up.

## Tools Used
- **Python (Pandas):** data preparation and cleaning
- **Power BI Desktop:** data modelling, DAX measures, visuals, and dashboard design

## Data Tables
- `sales_clean` — sales invoices, taxable values, CGST, SGST, IGST, invoice dates, and payment/overdue information
- `purchases_clean` — purchase GST amounts and ITC claim status
- `customers_clean` — customer information, GSTIN, and credit days
- `products_clean` — product GST rates, selling prices, and cost prices

## Dashboard Features
- KPI cards: Total Sales, Total GST Collected, Total Taxable Sales, Total ITC Claimed, Net GST Liability, and Overdue Amount
- Monthly sales trend
- Monthly GST turnover split into CGST, SGST, and IGST
- Overdue amount by state
- ITC claim status donut chart
- Invoice-date range slicer for reviewing sales performance over a selected period

## Key Findings
1. **ITC claim coverage:** The dashboard shows approximately ₹11.05 million of GST as claimed and ₹0.43 million as not claimed, out of approximately ₹11.48 million in purchase GST.
2. **Unclaimed ITC follow-up:** Unclaimed GST is about **3.7%** of total purchase GST (₹0.43 million / ₹11.48 million). Review the underlying invoices and eligibility before deciding whether any amount can be claimed.
3. **GST composition:** The monthly GST turnover visual separates CGST, SGST, and IGST, making it easier to review the tax mix and investigate unusual month-to-month changes.
4. **Receivables follow-up:** The overdue-by-state visual helps prioritise states with the largest overdue balances. Start follow-up with the highest-value states and review the invoices behind those balances.
5. **Period-based reconciliation:** The sales date slicer allows sales-side measures and trends to be reviewed for a selected period. For a complete period reconciliation, compare the selected-period sales/GST figures with purchase-side ITC for the same period.

> **Important interpretation note:** The Net GST Liability KPI can be negative for a selected period. Confirm the measure's sign convention and reconcile the underlying period-level values before interpreting a negative result as a payable or credit balance.

## Recommendations
- Review the invoices making up the unclaimed ITC balance and verify eligibility, supplier documentation, and booking status before claiming.
- Investigate months where GST components or sales change sharply compared with neighbouring months.
- Prioritise overdue receivables by amount and ageing; follow up with customers and document expected payment dates.
- Reconcile sales GST and purchase ITC for matching periods before using Net GST Liability for filing or payment decisions.
- Keep the source data and date scope documented when sharing dashboard figures.

## How to Use
1. Open the `.pbix` file in Power BI Desktop.
2. Use the invoice-date range slicer to explore sales-side trends for a selected period.
3. Review KPI cards, monthly trends, GST components, overdue balances, and ITC claim status together.
4. Validate underlying invoices before making tax-filing or collection decisions.

## Notes and Limitations
- Purchase-side ITC visuals are based on `purchases_clean`; the invoice-date slicer currently filters sales-side visuals and does not automatically apply the same date selection to the purchase-side ITC visual. Treat those figures as purchase totals unless the model is updated to support aligned date filtering.
- This is an analytics project for learning and review, not tax or legal advice. Final GST decisions should be verified against the underlying records and applicable requirements.

## Suggested Repository Structure
```text
GST-Reconciliation-Tax-Analysis/
├── README.md
├── Mini project.pbix
├── data/
│   └── (add cleaned datasets only if they can be shared safely)
└── screenshots/
    └── dashboard.png
```

## GitHub Publishing Checklist
- [ ] Create a repository named `GST-Reconciliation-Tax-Analysis`.
- [ ] Add this `README.md`.
- [ ] Upload the Power BI `.pbix` file if its size is within GitHub's file limits; otherwise use Git LFS or provide a separate share link.
- [ ] Add a dashboard screenshot in a `screenshots` folder and embed it near the top of this README.
- [ ] Do not upload confidential or personally identifiable invoice/customer data.
- [ ] Add a short repository description: **Interactive Power BI dashboard for GST sales analysis, ITC tracking, net GST liability review, and overdue receivables monitoring.**
