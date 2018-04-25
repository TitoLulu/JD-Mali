USE MTL17802018;
GO

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
EXECUTE insertDepartment 'Tribeka','096 Tribeka','Rose Awour';

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

EXEC insertClient 'Peter', 'Wanjau', '2-4-1967','M','3005678','','0234567892','234 DONHOLM','wanjau@softonic.com','2876543672345','Francis Munyua',1003;
EXEC insertClient 'Audrey', 'Mutswiri', '2-4-1977','M','3005678','','0234567892','232 DONHOLM','wanjau@softonic.com','2876543672345','Priscilla Anyona',1004;
EXEC insertClient 'Caroline', 'Achieng', '4-4-1967','M','3005678','','0234567892','201 Githurai','wanjau@softonic.com','2876543672345','Mugo Mureithi',1005;
EXEC insertClient 'Peter', 'Ochieng', '5-5-1987','M','3005678','','0234567892','012 Kahawa','wanjau@softonic.com','2876543672345','Felix Anyang',1006;
EXEC insertClient 'Alex', 'Kamau', '5-4-1997','M','3005678','','0234567892','567 Pipeline','wanjau@softonic.com','2876543672345','Yvonne Okwara',1007;
EXEC insertClient 'Phelloz', 'Musyoka', '4-4-1999','M','3005678','','0234567892','234 Kinoo','wanjau@softonic.com','2876543672345','Cindy Bosibori',1008;

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

EXEC insertCDSAccount 'NSE234F1',1003, 6, 'processing', '7-2-2018',1;
EXEC insertCDSAccount 'NSE224F1',1006, 6, 'processing', '7-3-2018',1;
EXEC insertCDSAccount 'NSE254F1',1004, 7, 'processing', '7-2-2018',2;
EXEC insertCDSAccount 'NSE232F1',1005, 10, 'processing', '7-2-2018',3;
EXEC insertCDSAccount 'NSE233F1',1007, 9,'processing', '7-2-2018',3;
EXEC insertCDSAccount 'NSE203F1',1007, 7,'processing', '7-2-2018',4;
EXEC insertCDSAccount 'NSE213F1',1007, 16,'processing', '7-2-2018',5;
EXEC insertCDSAccount 'NSE223F1',1007, 12,'processing', '7-2-2018',6;
EXEC insertCDSAccount 'NSE333F1',1007, 11,'processing', '7-2-2018',4;
EXEC insertCDSAccount 'NSE433F1',1007, 13,'processing', '7-2-2018',5;


