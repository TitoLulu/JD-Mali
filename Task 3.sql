USE master;

-- Drop database
IF DB_ID('MTL17802018') IS NOT NULL DROP DATABASE MTL17802018;


-- If database could not be created due to open connections, abort
IF @@ERROR = 3702 
   RAISERROR('Database cannot be dropped because there are still open connections.', 127, 127) WITH NOWAIT, LOG;

-- Create database
CREATE DATABASE MTL17802018;
GO

USE MTL17802018;
GO


---------------------------------------------------
---The Tables
---------------------------------------------------

---create table DEPARTMENT-->

CREATE TABLE DEPARTMENT(
departmentId INT NOT NULL IDENTITY,
location NVARCHAR(20) NOT NULL,
address NVARCHAR(20) NOT NULL,
manager NVARCHAR(20) NOT NULL,

 CONSTRAINT PK_Department PRIMARY KEY(departmentId)
);

GO

--create table Account

CREATE TABLE ACCOUNTS(
accountId INT NOT NULL IDENTITY,
dateOpened DATETIME NOT NULL,
status NVARCHAR(20) NOT NULL,
personResponsible NVARCHAR(30) NOT NULL,

 CONSTRAINT PK_Accounts PRIMARY KEY(accountId)
);
GO
-- 


--create table CLIENTS

CREATE TABLE CLIENTS(
clientId INT NOT NULL IDENTITY,
firstname NVARCHAR(20) NOT NULL,
lastname NVARCHAR(20) NOT NULL,
dateofBirth DATETIME NOT NULL,
sex NVARCHAR(1) NOT NULL,
nationalIdnetificationNumber NVARCHAR(10),
passportNumber NVARCHAR(10),
telephoneNumber NVARCHAR(10) NOT NULL,
address NVARCHAR (20) NOT NULL,
email NVARCHAR(20) NOT NULL,
defaultBankAccount NVARCHAR(20) NOT NULL,
baneficiary NVARCHAR(30) NOT NULL,
accountId INT NOT NULL,

 CONSTRAINT PK_Clients PRIMARY KEY(clientId),
 CONSTRAINT FK_Account FOREIGN KEY(accountId)
    REFERENCES ACCOUNTS(accountId)


);
GO

--create table EMPLOYEES-->
 
CREATE TABLE EMPLOYEES(
employeeId INT NOT NULL IDENTITY,
firstname NVARCHAR(20) NOT NULL,
lastname NVARCHAR(20) NOT NULL,
dateofBirth DATE NOT NULL,
sex NVARCHAR(1) NOT NULL,
nationalIdnetificationNumber NVARCHAR(10),
passportNumber NVARCHAR(10),
telephoneNumber nvarchar(10) NOT NULL,
address NVARCHAR (20) NOT NULL,
email NVARCHAR(20) NOT NULL,
defaultBankAccount NVARCHAR(20) NOT NULL,
salary NVARCHAR(10) NOT NULL,
role NVARCHAR(30) NOT NULL,
nextofKin NVARCHAR(30) NOT NULL,
departmentId INT NOT NULL,


 CONSTRAINT PK_Employee PRIMARY KEY(employeeId),
 CONSTRAINT FK_Department FOREIGN KEY(departmentId)
    REFERENCES DEPARTMENT(departmentId)
	


);
GO
--create table NORMALACCOUNT-->

CREATE TABLE NORMALACCOUNT(
accountId INT NOT NULL,

CONSTRAINT FK_NAccount FOREIGN KEY(accountId)
    REFERENCES ACCOUNTS(accountId)
);
GO
--create table CDSACCOUNT-->

CREATE TABLE CDSACCOUNT(
CDSNumber NVARCHAR(20) NOT NULL,
accountId INT NOT NULL,
employeeId INT NOT NULL,
status NVARCHAR(20) NOT NULL,
applicationDate DATETIME NOT NULL,
clientId INT NOT NULL,



CONSTRAINT PK_CDSANumber PRIMARY KEY(CDSNumber),
CONSTRAINT FK_CEmployee FOREIGN KEY(employeeId)
    REFERENCES EMPLOYEES(employeeId),
CONSTRAINT FK_CAccount FOREIGN KEY(accountId)
    REFERENCES ACCOUNTS(accountId),
CONSTRAINT FK_CDSclient FOREIGN KEY(clientId)
    REFERENCES CLIENTS(clientId)
);
GO
--create table SERVICE-->


CREATE TABLE SERVICE(
departmentId INT NOT NULL,
type NVARCHAR NOT NULL,

CONSTRAINT FK_SDepartment FOREIGN KEY(departmentId)
    REFERENCES DEPARTMENT(departmentId)


);
GO

--create table STRATEGY-->
CREATE TABLE STRATEGY(
strategyType NVARCHAR NOT NULL,
employeeId INT NOT NULL,

CONSTRAINT FK_SEmployee FOREIGN KEY(employeeId)
    REFERENCES EMPLOYEES(employeeId)

);

GO

--------------------------------------------------------------------------
/*INDEXES AND THEIR IMPORTANCE*/
--------------------------------------------------------------------------

-- non clustered index on date opened-->
CREATE NONCLUSTERED INDEX idx_dateOpened ON dbo.ACCOUNTS(dateopened);
GO

--non clustered index on client firstname-->
CREATE NONCLUSTERED INDEX idx_NC_firstname ON CLIENTS(firstname)

GO

--non clustered index on CDSaccount status and application date
CREATE NONCLUSTERED INDEX Idx_NC_status ON CDSACCOUNT(status);
CREATE NONCLUSTERED INDEX Idx_NC_applicationdate ON CDSACCOUNT(applicationDate);
GO


------------------------------------------------------------------------------
/*Triggers, Views, and email alerts*/
------------------------------------------------------------------------------

/*procedures*/

/*Procedure for DEPARTMENT*/
CREATE PROCEDURE insertDepartment
@loaction NVARCHAR(20), 
@address NVARCHAR(20),
@manager NVARCHAR(20)

AS
BEGIN 
	INSERT INTO DEPARTMENT(location,address,manager)
	VALUES (@loaction,@address,@manager)
END
GO

EXECUTE insertDepartment 'Thika','PMB CT3 Cantonments','Peter Kimaru';
EXECUTE insertDepartment 'Donholm','265 Donholm','Joe Mucheru';
EXECUTE insertDepartment 'Buruburu','1963 Buruburu','Willy Ambaka';
EXECUTE insertDepartment 'Kajiado','056 Kajiado','Katune Mwenda';
EXECUTE insertDepartment 'Tribeka','096 Tribeka','Rose Awour'
GO

/*Procedure for Employee*/
CREATE PROCEDURE insertEmployees
@firstname NVARCHAR(20),
@lastname NVARCHAR(20),
@dateofBirth DATE ,
@sex NVARCHAR(1) ,
@nationalIdnetificationNumber NVARCHAR(10),
@passportNumber NVARCHAR(10),
@telephoneNumber NVARCHAR(10),
@address NVARCHAR (20) ,
@email NVARCHAR(20) ,
@defaultBankAccount NVARCHAR(20) ,
@salary NVARCHAR(10),
@role NVARCHAR(30),
@nextofKin NVARCHAR(30),
@departmentId INT

AS
BEGIN 
	INSERT INTO EMPLOYEES(firstname,lastname,dateofBirth,sex,nationalIdnetificationNumber,passportNumber,telephoneNumber,address,email,
	defaultBankAccount,salary,role,nextofKin,departmentId )
	VALUES (@firstname,@lastname,@dateofBirth,@sex,@nationalIdnetificationNumber,@passportNumber,@telephoneNumber,@address,@email,@defaultBankAccount,
	@salary,@role,@nextofKin,@departmentId)
END
GO
SELECT *FROM EMPLOYEES;

EXECUTE insertEmployees 'Paul','Muthomi','3-3-1992', 'M', 'K28501303','A223511',50,'PMB CT3 CANTONMENTS','muthomi@gmail.com',303456778943,2300,'HR Department','Akinyi',2;
EXECUTE insertEmployees 'Kimani','Mwangi','3-3-1992', 'M', 'K28501303','A223511','05000417705','PMB CT3 CANTONMENTS','muthomi@gmail.com','303456778943','2300','HR Department','Akinyi',4;
EXECUTE insertEmployees 'Dzifa','Muthomi','3-3-1992', 'M', 'K28501303','A223511','05001417705','PMB CT3 CANTONMENTS','muthomi@gmail.com','303456778943','2300','HR Department','Akinyi',5;
EXECUTE insertEmployees 'Dzifa','Muthomi','3-3-1992', 'M', 'K28561303','A2234511','05071417705','PMB CT3 CANTONMENTS','muthomi@gmail.com','303456778943','2300','HR Department','Akinyi',5;
EXECUTE insertEmployees 'Dzifa','Muthomi','3-3-1992', 'M', 'K28501303','A223511','05001417705','PMB CT3 CANTONMENTS','muthomi@gmail.com','303456778943','2300','HR Department','Akinyi',5;
EXECUTE insertEmployees 'Dzifa','Muthomi','3-3-1992', 'M', 'K28521303','A243511','05002417705','PMB CT3 CANTONMENTS','muthomi@gmail.com','303456778943','2300','HR Department','Akinyi',5;
EXECUTE insertEmployees 'Dzifa','Muthomi','3-3-1994', 'M', 'K28501313','A223521','05005417705','PMB CT3 CANTONMENTS','muthomi@gmail.com','303456778943','2300','HR Department','Akinyi',5;
EXECUTE insertEmployees 'Dzifa','Muthomi','3-3-1993', 'M', 'K28502303','A227511','05001457705','PMB CT3 CANTONMENTS','muthomi@gmail.com','303456778943','2300','HR Department','Akinyi',5;
EXECUTE insertEmployees 'Caroline','Muthoni','3-3-1992', 'M', 'K28521303','A213511','05041417705','PMB CT3 CANTONMENTS','muthomi@gmail.com','303456778943','2300','HR Department','Akinyi',5;
EXECUTE insertEmployees 'Eric','Muthomi','3-3-1992', 'M', 'K28501323','A223511','05011417705','PMB CT3 CANTONMENTS','muthomi@gmail.com','303456778943','2300','HR Department','Akinyi',5;
EXECUTE insertEmployees 'Ejyibar','Ekua','3-3-1992', 'M', 'K29501303','A223521','06001417705','PMB CT3 CANTONMENTS','muthomi@gmail.com','303456778943','2300','HR Department','Akinyi',5;

GO

/*Procedure for Accounts */
CREATE PROCEDURE insertAccount
@dateOpened DATETIME, 
@status NVARCHAR(20),
@personResponsible NVARCHAR(20)

AS
BEGIN 
	INSERT INTO ACCOUNTS(dateOpened,status,personResponsible)
	VALUES (@dateOpened,@status,@personResponsible)
END
GO

EXECUTE insertAccount '7-07-2018','active','Peter Mwangi';
EXECUTE insertAccount '7-07-2018','active','Caroline Dzifa';
EXECUTE insertAccount '7-07-2018','active','Peter Muchemi';
EXECUTE insertAccount '7-07-2018','active','Egyiba Ekua';
EXECUTE insertAccount '7-07-2018','active','Nana Ama';
EXECUTE insertAccount '7-07-2018','active','Kimani Mwangi';
EXECUTE insertAccount '7-07-2018','active','Kimani Mwangi';
EXECUTE insertAccount '7-07-2018','active','Kimani Mwangi';
EXECUTE insertAccount '7-07-2018','active','Kimani Mwangi';
EXECUTE insertAccount '7-07-2018','active','Kimani Mwangi';
EXECUTE insertAccount '7-07-2018','active','Kimani Mwangi';

GO
/*Procedure for Client*/
CREATE PROCEDURE insertClient

@firstname NVARCHAR(20),
@lastname NVARCHAR(20) ,
@dateofBirth DATETIME,
@sex NVARCHAR(1) ,
@nationalIdnetificationNumber NVARCHAR(10),
@passportNumber NVARCHAR(10),
@telephoneNumber INT,
@address NVARCHAR (20) ,
@email NVARCHAR(20),
@defaultBankAccount NVARCHAR(20),
@baneficiary NVARCHAR(30),
@accountId INT

AS
BEGIN 
	INSERT INTO CLIENTS(firstname,lastname,dateofBirth,sex,nationalIdnetificationNumber,passportNumber,telephoneNumber,address,email,
	defaultBankAccount,baneficiary,accountId )
	VALUES (@firstname,@lastname,@dateofBirth,@sex,@nationalIdnetificationNumber,@passportNumber,@telephoneNumber,@address,@email,@defaultBankAccount,
	@baneficiary,@accountId)
END
GO
EXEC insertClient 'Peter', 'Wanjau', '2-4-1967','M','3005678','','0234567892','234 DONHOLM','wanjau@softonic.com','2876543672345','Francis Munyua',1;
EXEC insertClient 'Audrey', 'Mutswiri', '2-4-1977','M','3005678','','0234567892','232 DONHOLM','wanjau@softonic.com','2876543672345','Priscilla Anyona',2;
EXEC insertClient 'Caroline', 'Achieng', '4-4-1967','M','3005678','','0234567892','201 Githurai','wanjau@softonic.com','2876543672345','Mugo Mureithi',3;
EXEC insertClient 'Peter', 'Ochieng', '5-5-1987','M','3005678','','0234567892','012 Kahawa','wanjau@softonic.com','2876543672345','Felix Anyang',4;
EXEC insertClient 'Alex', 'Kamau', '5-4-1997','M','3005678','','0234567892','567 Pipeline','wanjau@softonic.com','2876543672345','Yvonne Okwara',5;
EXEC insertClient 'Phylis', 'Musyoka', '4-4-1999','M','3005678','','0234567892','234 Kinoo','wanjau@softonic.com','2876543672345','Cindy Bosibori',6;
EXEC insertClient 'Jacintah', 'Musyoka', '4-4-1999','M','3005678','','0234517892','234 Kinoo','wanjau@softonic.com','2876543672345','Masika Bosibori',7;
EXEC insertClient 'Kamau', 'Musyoka', '4-4-1999','M','3005678','','0234577892','234 Kinoo','wanjau@softonic.com','2876543672345','Kevin Bosibori',8;
EXEC insertClient 'Alieu', 'Musyoka', '4-4-1999','M','3005678','','0134567892','234 Kinoo','wanjau@softonic.com','2876543672345','Calvin Bosibori',9;
EXEC insertClient 'Anne', 'Musyoka', '4-4-1999','M','3005678','','0234567893','234 Kinoo','wanjau@softonic.com','2876543672345','Shirleen Bosibori',10

GO


/*insert procedure for CDSACCOUNT*/
CREATE PROCEDURE insertCDSAccount
@CDSNumber NVARCHAR(20),
@accountId INT,
@employeeId INT,
@status NVARCHAR(20),
@applicationDate DATETIME ,
@clientId INT

AS
BEGIN 
	INSERT INTO CDSACCOUNT(CDSNumber,accountId,employeeId,status,applicationDate,clientId )
	VALUES (@CDSNumber,@accountId,@employeeId,@status,@applicationDate, @clientId)
END
GO

EXEC insertCDSAccount 'NSE234F1',1, 1, 'processing', '7-2-2018',1;
EXEC insertCDSAccount 'NSE224F1',2, 2, 'processing', '7-3-2018',2;
EXEC insertCDSAccount 'NSE254F1',3, 3, 'processing', '7-2-2018',3;
EXEC insertCDSAccount 'NSE232F1',4, 4, 'processing', '7-2-2018',4;
EXEC insertCDSAccount 'NSE233F1',5, 5,'processing', '7-2-2018',5;
EXEC insertCDSAccount 'NSE203F1',6, 6,'processing', '7-2-2018',6;
EXEC insertCDSAccount 'NSE213F1',7, 7,'processing', '7-2-2018',7;
EXEC insertCDSAccount 'NSE223F1',8, 8,'processing', '7-2-2018',8;
EXEC insertCDSAccount 'NSE333F1',10, 9,'processing', '7-2-2018',9;
EXEC insertCDSAccount 'NSE433F1',11, 10,'processing', '7-2-2018',10;

GO



CREATE DATABASE MTL17802018_backup
GO



CREATE TABLE MTL17802018_backup.dbo.DEPARTMENTBackup(
departmentId INT,
location NVARCHAR(20),
address NVARCHAR(20),
manager NVARCHAR(20),
audit_activity VARCHAR(200),
audit_time DATETIME
)
GO

CREATE TRIGGER insertDEPARTMENTTrigger ON
DEPARTMENT
FOR INSERT
AS
	declare @departmentId INT;
	declare @location NVARCHAR(20);
	declare @address NVARCHAR(20);
	declare @manager NVARCHAR(20);
	declare @audit_activity DATE;
	declare @activity VARCHAR(200)

	Select @departmentId = d.departmentId FROM inserted d;
	Select @location= d.location  FROM inserted d;
	Select @address = d.address FROM inserted d;
	Select @manager = d.manager FROM inserted d;

	set @activity = 'Record inserted in Department Table';

	INSERT INTO MTL17802018_backup.dbo.DEPARTMENTBackup(
	departmentId, location, address, manager, audit_activity, 
	audit_time)
	VALUES(@departmentId, @location, @address, @manager, @activity, CURRENT_TIMESTAMP)

	PRINT 'After insert trigger on DEPARTMENT table'

GO

EXEC insertDepartment'Logistics', 'Upper-Hill', 'John Mututho';
GO

CREATE TRIGGER updateTDEPARTMENTrigger ON 
DEPARTMENT 
FOR UPDATE
AS 
	declare @departmentId INT;
	declare @location NVARCHAR(20);
	declare @address NVARCHAR(20);
	declare @manager NVARCHAR(20);
	declare @audit_activity DATE;
	declare @activity VARCHAR(200)

	Select @departmentId = d.departmentId FROM inserted d;
	Select @location= d.location  FROM inserted d;
	Select @address = d.address FROM inserted d;
	Select @manager = d.manager FROM inserted d;

	

	if update(location)	
		set @activity = 'Updated Department location';
	if update(address)	
		set @activity = 'Updated Department address';
	if update(manager)	
		set @activity = 'Updated Department manager';

	INSERT INTO MTL17802018_backup.dbo.DEPARTMENTBackup(
	departmentId, location, address, manager, audit_activity, 
	audit_time)
	VALUES(@departmentId, @location, @address, @manager, @activity, CURRENT_TIMESTAMP)

	PRINT 'After Update trigger on Department table'
	
	EXEC msdb.dbo.sp_send_dbmail
      @profile_name =  'MailProfile',
      @recipients = 'dsampah@ashesi.edu.gh',
      @subject = 'CS424 Database Mail Test by T-SQL',
      @body = 'Action that occured was a DEPARTMENT record update'
GO

UPDATE DEPARTMENT SET location = 'Karatina' 
WHERE departmentId = 4
go

CREATE TRIGGER deleteDEPARTMENTTrigger ON 
DEPARTMENT
FOR DELETE
AS 
	declare @departmentId INT;
	declare @location NVARCHAR(20);
	declare @address NVARCHAR(20);
	declare @manager NVARCHAR(20);
	declare @audit_activity DATE;
	declare @activity VARCHAR(200)

	Select @departmentId = d.departmentId FROM inserted d;
	Select @location= d.location  FROM inserted d;
	Select @address = d.address FROM inserted d;
	Select @manager = d.manager FROM inserted d;
	Set @activity = 'Deleted DEPARTMENT Record';

	INSERT INTO MTL17802018_backup.dbo.DEPARTMENTBackup(
	departmentId, location, address, manager, audit_activity, 
	audit_time)
	VALUES(@departmentId, @location, @address, @manager, @activity, CURRENT_TIMESTAMP)



	PRINT 'After Delete trigger on student table'
	
	EXEC msdb.dbo.sp_send_dbmail
      @profile_name =  'MailProfile',
      @recipients = 'dsampah@ashesi.edu.gh',
      @subject = 'CS424 Database Mail Test by T-SQL',
      @body = 'Action that occured was a DEPARTMENT record delete'
GO

EXEC insertDepartment'Korle-bu', '90-amb-ruiru', 'Kinuthia Njoroge'


GO

 
CREATE TABLE MTL17802018_backup.dbo.ACCOUNTSBackup(
accountId INT,
dateOpened DATETIME ,
status NVARCHAR(20) ,
personResponsible NVARCHAR(30),
audit_activity VARCHAR(200),
audit_time  DATE
)
GO

CREATE TRIGGER insertACCOUNTSTrigger ON
ACCOUNTS
FOR INSERT
AS
	declare @accountId INT;
	declare @dateOpened DATETIME;
	declare @status NVARCHAR(20);
	declare @personResponsible NVARCHAR(20);
	declare @audit_activity DATE;
	declare @activity VARCHAR(200)

	Select @accountId = a.accountId FROM inserted a;
	Select @dateOpened= a.dateOpened  FROM inserted a;
	Select @status = a.status FROM inserted a;
	Select @personResponsible = a.personResponsible FROM inserted a;

	set @activity = 'Record inserted in Accounts Table';

	INSERT INTO MTL17802018_backup.dbo.ACCOUNTSBackup(
	accountId, dateOpened, status, personResponsible, audit_activity, 
	audit_time)
	VALUES(@accountId, @dateOpened, @status, @personResponsible, @activity, CURRENT_TIMESTAMP)

	PRINT 'After insert trigger on DEPARTMENT table'

GO

EXEC insertAccount '6-03-2018', 'active', 'John Munyau';
GO

select * from MTL17802018_backup.dbo.ACCOUNTSBackup
GO

CREATE TRIGGER updateACCOUNTSTrigger ON 
ACCOUNTS 
FOR UPDATE
AS 
	declare @accountId INT;
	declare @dateOpened DATETIME;
	declare @status NVARCHAR(20);
	declare @personResponsible NVARCHAR(20);
	declare @audit_activity DATE;
	declare @activity VARCHAR(200)

	Select @accountId = a.accountId FROM inserted a;
	Select @dateOpened= a.dateOpened  FROM inserted a;
	Select @status = a.status FROM inserted a;
	Select @personResponsible = a.personResponsible FROM inserted a;


	

	if update(dateOpened)	
		set @dateOpened = 'Updated Accounts dateOpened';
	if update(status)	
		set @status = 'Updated Accounts status';
	if update(personResponsible)	
		set @personResponsible = 'Updated Accounts personResponsible';

	INSERT INTO MTL17802018_backup.dbo.ACCOUNTSBackup(
	accountId, dateOpened, status,personResponsible, audit_activity, 
	audit_time)
	VALUES(@accountId, @dateOpened, @status, @personResponsible, @activity, CURRENT_TIMESTAMP)

	PRINT 'After Update trigger on ACCOUNTS table'
	
	EXEC msdb.dbo.sp_send_dbmail
      @profile_name =  'MailProfile',
      @recipients = 'dsampah@ashesi.edu.gh',
      @subject = 'CS424 Database Mail Test by T-SQL',
      @body = 'Action that occured was a ACCOUNTS record update'
GO

UPDATE ACCOUNTS SET status = 'Inactive' 
WHERE accountId = 2
go

CREATE TRIGGER deleteACCOUNTSTrigger ON 
ACCOUNTS
FOR DELETE
AS 
	declare @accountId INT;
	declare @dateOpened DATETIME;
	declare @status NVARCHAR(20);
	declare @personResponsible NVARCHAR(20);
	declare @audit_activity DATE;
	declare @activity VARCHAR(200)

	Select @accountId = a.accountId FROM inserted a;
	Select @dateOpened= a.dateOpened  FROM inserted a;
	Select @status = a.status FROM inserted a;
	Select @personResponsible = a.personResponsible FROM inserted a;
	Set @activity = 'Deleted DEPARTMENT Record';


	INSERT INTO MTL17802018_backup.dbo.ACCOUNTSBackup(
	accountId, dateOpened, status,personResponsible, audit_activity, 
	audit_time)
	VALUES(@accountId, @dateOpened, @status, @personResponsible, @activity, CURRENT_TIMESTAMP)



	PRINT 'After Delete trigger on Accounts table'

		EXEC msdb.dbo.sp_send_dbmail
      @profile_name =  'MailProfile',
      @recipients = 'dsampah@ashesi.edu.gh',
      @subject = 'CS424 Database Mail Test by T-SQL',
      @body = 'Action that occured was a ACCOUNTS record delete'
GO

EXEC insertAccount '9-04-2018', 'no-CDSNumber', 'Kinuthia Kimani'


GO

/*views*/
-- CDS Account View
CREATE VIEW CDSACCOUNTVIEW
AS
SELECT CDSNumber, accountId,employeeId, status,applicationDate,clientId
FROM CDSACCOUNT;


GO

---view for accounts-->
CREATE VIEW  AccountsView  
AS 
SELECT accountId, dateOpened, status, personResponsible
FROM ACCOUNTS;
GO

---view for Department-->
CREATE VIEW  DepartmentView  
AS 
SELECT location, address, manager
FROM DEPARTMENT;
GO

-------------------------------------------------------------------------
/*Queries*/
-------------------------------------------------------------------------


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
GO


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

GO
exec cdsNumbers
GO
exec employee_dept
GO
exec delayedApplications
GO
exec approvedCDSApplications
GO
exec accountsopenedinaDay
GO
exec actiontoTake
GO
SELECT *FROM CLIENTS