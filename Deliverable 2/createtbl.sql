-- Include your create table DDL statements in this file.
-- Make sure to terminate each statement with a semicolon (;)

-- LEAVE this statement on. It is required to connect to your database.
CONNECT TO cs421;

-- Remember to put the create table ddls for the tables with foreign key references
--    ONLY AFTER the parent tables has already been created.

-- This is only an example of how you add create table ddls to this file.
--   You may remove it.

CREATE TABLE Parent (
	QcHealthCard CHAR(12) NOT NULL,
	PhoneNumber CHAR(10) NOT NULL,
	Name VARCHAR(50) NOT NULL,
	BloodType VARCHAR(3),
	DateOfBirth DATE NOT NULL,
	Address VARCHAR(50) NOT NULL,
	CurrentProfession VARCHAR(50),
	Email VARCHAR(50) NOT NULL UNIQUE,
	PRIMARY KEY (QcHealthCard)

);

CREATE TABLE BiologicalDad (
	QcHealthCard CHAR(12) NOT NULL,
	PhoneNumber CHAR(10) NOT NULL UNIQUE,
	Name VARCHAR(50) NOT NULL,
	BloodType VARCHAR(3),
	DateOfBirth DATE NOT NULL,
	Address VARCHAR(50) NOT NULL UNIQUE,
	CurrentProfession VARCHAR(50),
	Email VARCHAR(50) NOT NULL UNIQUE,
	PRIMARY KEY (QcHealthCard)

);

CREATE TABLE BiologicalMom (
	QcHealthCard CHAR(12) NOT NULL,
	PhoneNumber CHAR(10) NOT NULL UNIQUE,
	Name VARCHAR(50) NOT NULL,
	BloodType VARCHAR(3),
	DateOfBirth DATE NOT NULL,
	Address VARCHAR(50) NOT NULL UNIQUE,
	CurrentProfession VARCHAR(50),
	Email VARCHAR(50) NOT NULL UNIQUE,
	TotalNumberOfPregs INT,
	CurrentPregNumber INT,
	PRIMARY KEY (QcHealthCard)

);

CREATE TABLE HCInstitution(
	InstName VARCHAR(50) NOT NULL,
	PhoneNumber CHAR(10) NOT NULL UNIQUE,
	Email VARCHAR(50) NOT NULL UNIQUE,
	Address VARCHAR(50) NOT NULL UNIQUE,
	Website VARCHAR(50) NOT NULL UNIQUE,
	PRIMARY KEY (InstName)
);

CREATE TABLE CommClinic(
	InstName VARCHAR(50) NOT NULL,
	PRIMARY KEY (InstName),
	FOREIGN KEY (InstName) REFERENCES HCInstitution

);

CREATE TABLE BirthCenter(
	InstName VARCHAR(50) NOT NULL,
	PRIMARY KEY (InstName),
	FOREIGN KEY (InstName) REFERENCES HCInstitution

);

CREATE TABLE Couple (
	CoupleID INT NOT NULL,
	IsInterestedInProgram VARCHAR(5),
	IsInvited VARCHAR(5),
	InfoSessionsAttended INT,
	ExpectedTimeFrameOfBirth DATE,
	QcHealthCardMom CHAR(12) NOT NULL,
	QcHealthCardDad CHAR(12),
	InstName VARCHAR(50),
	PRIMARY KEY (CoupleID),
	FOREIGN KEY (QcHealthCardMom) REFERENCES BiologicalMom,
	FOREIGN KEY (QcHealthCardDad) REFERENCES BiologicalDad,
	FOREIGN KEY (InstName) REFERENCES HCInstitution

);

CREATE TABLE Midwife(
	PractitionerID INT NOT NULL,
	Name VARCHAR(50) NOT NULL,
	Email VARCHAR(50) NOT NULL UNIQUE,
	PhoneNumber CHAR(10) NOT NULL UNIQUE,
	InstName VARCHAR(50) NOT NULL,
	PRIMARY KEY (PractitionerID),
	FOREIGN KEY (InstName) REFERENCES HCInstitution
	 
);

CREATE TABLE Backups(
	PrimaryMidwife INT NOT NULL,
	BackupMidwife INT NOT NULL,
	PRIMARY KEY (PrimaryMidwife, BackupMidwife),
	FOREIGN KEY (PrimaryMidwife) REFERENCES Midwife,
	FOREIGN KEY (BackupMidwife) REFERENCES Midwife

);

CREATE TABLE Pregnancy (
	PregnancyID INT NOT NULL,
	PregNum INT,
	FinalEstimatedDate DATE,
	LastMenstruelPDate DATE,
	LocationOfBirth VARCHAR(50),
	UltraSoundDueDate DATE,
	NumberOfBabies INT,
	CoupleID INT NOT NULL,
	InstName VARCHAR(50),
	PRIMARY KEY (PregnancyID),
	FOREIGN KEY (LocationOfBirth) REFERENCES BirthCenter,
	FOREIGN KEY (InstName) REFERENCES HCInstitution,
	FOREIGN KEY (CoupleID) REFERENCES Couple
	
);

CREATE TABLE Baby (
	BabyID INT NOT NULL,
	Gender CHAR(1),
	Name VARCHAR(50),
	HealthStatus VARCHAR(200),
	BloodType VARCHAR(3),
	DateOfBirth DATE,
	TimeOfBirth TIME,
	PregnancyID INT NOT NULL,
	PRIMARY KEY (BabyID),
	FOREIGN KEY (PregnancyID) REFERENCES Pregnancy

);

CREATE TABLE Supervises(
	PractitionerID INT NOT NULL,
	PregnancyID INT NOT NULL,
	PRIMARY KEY (PractitionerID, PregnancyID),
	FOREIGN KEY (PractitionerID) REFERENCES Midwife,
	FOREIGN KEY (PregnancyID) REFERENCES Pregnancy

);

CREATE TABLE OnlineInfoSession(
	PractitionerID INT NOT NULL,
	Date DATE NOT NULL,
	Time TIME NOT NULL,
	Language VARCHAR(10) NOT NULL,
	CouplesAttendance INT,
	PRIMARY KEY (PractitionerID, Date, Time),
	FOREIGN KEY (PractitionerID) REFERENCES Midwife

);

CREATE TABLE Attends(
	CoupleID INT NOT NULL,
	PractitionerID INT NOT NULL,
	Date DATE NOT NULL,
	Time TIME NOT NULL,
	HasAttended VARCHAR(5),
	IsRegistered VARCHAR(5),
	PRIMARY KEY (CoupleID, PractitionerID, Date, Time),
	FOREIGN KEY (CoupleID) REFERENCES Couple,
	FOREIGN KEY (PractitionerID, Date, Time) REFERENCES OnlineInfoSession
	
);

CREATE TABLE Appointment (
	AppointmentID INT NOT NULL,
	Date DATE,
	Time TIME,
	PractitionerID INT NOT NULL,
	PregnancyID INT NOT NULL,
	PRIMARY KEY (AppointmentID),
	FOREIGN KEY (PractitionerID) REFERENCES Midwife,
	FOREIGN KEY (PregnancyID) REFERENCES Pregnancy 	

);

CREATE TABLE Note (
	AppointmentID INT NOT NULL,
	Date DATE NOT NULL,
	Time TIME NOT NULL,
	Observation VARCHAR(255),
	PRIMARY KEY (AppointmentID, Date, Time),
	FOREIGN KEY (AppointmentID) REFERENCES Appointment

);

CREATE TABLE Technician (
	TechnicianID INT NOT NULL,
	Name VARCHAR(50) NOT NULL,
	PhoneNumber CHAR(10) NOT NULL UNIQUE,
	PRIMARY KEY (TechnicianID)

);

CREATE TABLE Lab (
	LabName VARCHAR(50) NOT NULL,
	NumberOfTests INT,
	LabAddress VARCHAR(50),
	PRIMARY KEY (LabName)

);

CREATE TABLE MedicalTests (
	TestID INT NOT NULL,
	TestResult VARCHAR(10),
	TestType VARCHAR(10),
	DateLabWorkWasDone DATE,
	DateTestWasPrescribed DATE, 	
	DateSampleWasTaken DATE,
	TechnicianID INT NOT NULL,
	LabName VARCHAR(50) NOT NULL,
	PractitionerID INT NOT NULL,
	BabyID INT,
	PregnancyID INT,
	PRIMARY KEY (TestID),
	FOREIGN KEY (TechnicianID) REFERENCES Technician,
	FOREIGN KEY (LabName) REFERENCES Lab,
	FOREIGN KEY (PractitionerID) REFERENCES Midwife,
	FOREIGN KEY (BabyID) REFERENCES Baby,
	FOREIGN KEY (PregnancyID) REFERENCES Pregnancy

);

