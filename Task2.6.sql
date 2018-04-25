use MTL17802018

/*query for clients CDSNumber*/
CREATE PROCEDURE 
cdsNumbers
AS
BEGIN
SELECT CDSNumber, CDSACCOUNT.clientId ,CDSACCOUNT.accountId, firstname, lastname
FROM CDSACCOUNT
INNER JOIN 
CLIENTS ON CLIENTS.clientId = CDSACCOUNT.clientId INNER JOIN
ACCOUNTS ON ACCOUNTS.accountId=CDSACCOUNT.accountId
END
GO




/*Query counts number of CDSACCOUNT applications that have been approved*/
CREATE PROCEDURE approvedCDSApplications
AS
BEGIN

SELECT COUNT(*) as totalapproved_accounts
FROM CDSACCOUNTVIEW
WHERE CDSACCOUNTVIEW.status = 'approved' 

END


/*query for CDSAccount applications status and actions to  take*/
CREATE PROCEDURE actiontoTake
AS
BEGIN
SELECT *, (CASE status  
	WHEN 'processing' THEN 'Check with SBG on Account'
	WHEN 'approved' THEN 'Inform client of CDSAccount Availability'
	WHEN 'rejected' THEN 'Inform client of rejection, ask to reapply' 
	  END  
	)
	FROM CDSACCOUNTVIEW 
END 
GO



/*query that checks whether application has surpassed 30 days without approval*/
CREATE PROCEDURE delayedApplications
AS
BEGIN
SELECT * FROM CDSACCOUNTVIEW
WHERE DATEDIFF(DAY, applicationDate, DATEADD(month,1,applicationDate)) >=  30 AND applicationDate in 
(select applicationDate from CDSACCOUNTVIEW WHERE status='processing')
END
GO

/*Query to determine average accounts opened in a day*/
CREATE PROCEDURE accountsopenedinaDay
AS
BEGIN
WITH ACCOUNTS_CTE (accountId)
AS
(
SELECT count(*) FROM ACCOUNTS

GROUP BY dateOpened 
)
SELECT AVG(accountId) AS "Average Accounts Opened in a Day "
FROM ACCOUNTS_CTE
END
GO

/*Query for employee firstname and their departments*/
CREATE PROCEDURE employee_dept
AS
BEGIN
SELECT EMPLOYEES.departmentId, firstname 
FROM EMPLOYEES
left outer JOIN
DEPARTMENT ON  DEPARTMENT.departmentId = EMPLOYEES.departmentId
END

exec cdsNumbers
exec employee_dept
exec delayedApplications
exec approvedCDSApplications
exec accountsopenedinaDay
exec actiontoTake