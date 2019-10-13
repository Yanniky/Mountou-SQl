CREATE PROCEDURE UDP_STANDARDISE_CUSTOMER_PO_BOX
AS
BEGIN
UPDATE customer_stg
SET customer_address=REPLACE(customer_address,'.','')
WHERE customer_address LIKE '%P.O. Box%'

UPDATE customer_stg
SET po_address = REPLACE(po_address,'.','')
WHERE po_address LIKE '%P.O. Box%'

UPDATE customer_stg
SET po_address=customer_address
WHERE customer_address LIKE '%PO Box%'

PRINT 'Customer tables P.O. Box number standardised successfully!'
END

exec UDP_STANDARDISE_CUSTOMER_PO_BOX

select * from dbo.customer_stg

select customer_address,po_address from dbo.customer_stg

---------------------------------------------------------------------------------------


