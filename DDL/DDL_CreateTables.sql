IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Tool')
BEGIN
	CREATE TABLE Tool
	(
		ToolID INT PRIMARY KEY,
		ToolName VARCHAR(100) not null,
		ToolDescription VARCHAR(5000)
	);
END


IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Photo')
BEGIN
	CREATE TABLE Photo
	(
		PhotoID INT PRIMARY KEY,
		PhotoLink VARCHAR(1000) not null
	);
END

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'ToolPhotoDetails')
BEGIN
	CREATE TABLE ToolPhotoDetails
	(
		ToolPhotoDetailsID INT PRIMARY KEY,
		ToolID INT FOREIGN KEY  REFERENCES Tool(ToolId) not null,
		PhotoID INT FOREIGN KEY REFERENCES Photo(PhotoID) not null
	);
END

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'UserInfo')
BEGIN
	CREATE TABLE UserInfo
	(
		UserID INT PRIMARY KEY,
		FirstName VARCHAR(50) not null,
		LastName VARCHAR(50) not null,
		DOB Datetime not null,
		Email VARCHAR(100),
		PhotoID INT FOREIGN KEY REFERENCES Photo(PhotoID) default null
	);

END

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'ToolDetail')
BEGIN
	CREATE TABLE ToolDetail
	(
		ToolDetailID INT PRIMARY KEY,
		ToolId int Foreign key REFERENCES Tool(ToolID) not null,
		IssuedOn VARCHAR(50) default null,
		IssuedBy INT foreign key REFERENCES UserInfo(UserID) default null,
		IsAvailable BIT default 1
	);
END

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'ToolBorrowDetailLog')
BEGIN
	CREATE TABLE ToolBorrowDetailLog
	(
		ToolBorrowDetailID INT PRIMARY KEY,
		ToolDetailID int Foreign key REFERENCES ToolDetail(ToolDetailID) not null,
		IssuedOn Datetime not null,
		ReturnedOn Datetime default null,
		IssuedBy INT foreign key REFERENCES UserInfo(UserID) not null
	);
END