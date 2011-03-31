-- pre-requisite in jbprod
grant all on branch to mis;
grant all on city to mis;

-- Run the following SQL statements on USERS table, because we do not store passwords:

ALTER TABLE USERS MODIFY ENCRYPTED_PASSWORD NULL;
ALTER TABLE USERS MODIFY PASSWORD_SALT NULL;

-- view for branches from jbprod

CREATE OR REPLACE FORCE VIEW "BRANCHES" ("ID", "NAME", "ADDRESS", "CITY", "PHONE", "EMAIL", "CATEGORY", "PARENT_ID", "PARENT_NAME", "CARD_ID")
AS
  SELECT a.branchid id,
    a.branchid
    || ' - '
    || a.branchname name,
    a.branchaddress address,
    b.cityname city,
    a.contactnumbers phone,
    a.emailid email,
    a.branchtype category,
    a.parentbranchid parent_id,
    c.branchname parent_name,
    c.branchcard card_idcreate or replace view cards as
select membercardno membership_no,
branch_id branch_id
from jbprod.member_branch_xref
with read only
  FROM jbprod.branch a,
    jbprod.city b,
    jbprod.branch c
  WHERE a.cityid       = b.cityid (+)
  AND A.Parentbranchid = C.Branchid (+)
WITH read only;


