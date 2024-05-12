-- Include your INSERT SQL statements in this file.
-- Make sure to terminate each statement with a semicolon (;)

-- LEAVE this statement on. It is required to connect to your database.
CONNECT TO cs421;

-- Remember to put the INSERT statements for the tables with foreign key references
--    ONLY AFTER the parent tables!

-- This is only an example of how you add INSERT statements to this file.
--   You may remove it.

INSERT INTO HCInstitution (InstName, PhoneNumber, Email, Address, Website) VALUES
('Montreal General Hospital', '5149341934', 'patients.comm@muhc.mcgill.ca', '1650 Cedar Ave', 'https://muhc.ca/'),
('Hôpital Maisonneuve Rosemont', '5142523400', 'hmr@hotmail.ca', 'boulevard Assomption Montréal QC H1T 2M4', 'https://ciusss-estmtl.gouv.qc.ca'),
('Jean-Talon Hospital', '5144956767', 'jth@hotmail.ca', '1385 Rue Jean-Talon E', 'https://www.ciusssnordmtl.ca/'),
('Jewish General Hospital', '5143408222', 'jgh@hotmail.ca', '3755 Côte-Sainte-Catherine', 'https://www.jgh.ca/'),
('Hôtel-Dieu de Québec', '4185254444', 'hddq@hotmail.ca', '11 Côte du Palais', 'https://www.chudequebec.ca/'),
('Clinique Médicale Tardif', '4185299323', 'cmt@hotmail.ca', '400 Bd Jean-Lesage', 'cmt.qc.ca'),
('Centre Médical Montcalme', '4185240585', 'cmm@hotmail.ca', '165 Grande Allée Est', 'cmm.ca'),
('Super-Clinique Médicale', '5147871818', 'scm@hotmail.ca', '1021 Rue Jean Talon Est', 'scm.ca'),
('Clinique Medicale St-Andre', '5147228890', 'cmsta@hotmail.ca', '8448 Bld St-Michel', 'cmsta.ca'),
('Herlz Walk-In Center', '5143408311', 'hwic@hotmail.ca', '5858 Ch. de la Côte-des-Neiges Floor 5', 'https://www.forcemedic.com/'),
('Lac-Saint-Louis', '4507787780', 'lsl@hotmail.ca', '1250 Boulevard Saint-Louis', 'lsl.qc.ca')

;

INSERT INTO CommClinic (InstName) VALUES
('Clinique Médicale Tardif'),
('Centre Médical Montcalme'),
('Super-Clinique Médicale'),
('Clinique Medicale St-Andre'),
('Herlz Walk-In Center')

;


INSERT INTO BirthCenter (InstName) VALUES
('Montreal General Hospital'),
('Hôpital Maisonneuve Rosemont'),
('Jean-Talon Hospital'),
('Jewish General Hospital'),
('Hôtel-Dieu de Québec'),
('Lac-Saint-Louis')

;

INSERT INTO Parent (QcHealthCard, PhoneNumber, Name, BloodType, DateOfBirth, Address, CurrentProfession, Email) VALUES
('MAGM12345678', '5147780071','Mathieu-Joseph Magri', 'O-', '2000-07-11', '4447 Rue de Leacross', 'Student', 'mathieujmagri@hotmail.com'),
('MAGM45678912', '5143762205', 'Mario-John Magri', 'O+', '1995-08-22', '4447 Rue de Lacabane', 'Banker', 'mariojmagri@hotmail.com'),
('MAGM34512333', '5147782205', 'Michael-Luca Magri', 'O-', '1999-08-05', '4345 Rue du petit frere', 'Soccer Player', 'michaelluca@hotmail.com'),
('PETG13536789', '5149887654', 'Gianni Petrozza', 'A-', '1998-02-23', '1234 Rue de Laval', 'Cook', 'gpetrozza@gmail.com'),
('MAGM45004700', '4503451234', 'Mario Jr Magri', 'AB+', '1997-05-25', '4560 Rue de la Metropolitaine', 'Student-Masters', 'mariomagri@gmail.ca')

;

INSERT INTO BiologicalDad (QcHealthCard, PhoneNumber, Name, BloodType, DateOfBirth, Address, CurrentProfession, Email) VALUES
('TOPE12345678', '5147750271','Edward Topping', 'B-', '2000-07-19', '35 Rue du Prophete', 'Sports Bettor', 'edtop@hotmail.com'),
('THED45678123', '4503762205', 'Dante Therrien', 'A+', '1995-08-28', '47 Rue de Larochelle', 'Hockey Player', 'danthe@hotmail.com'),
('ROSE47568907', '5147782205', 'Emeric Rose', 'AB-', '1999-03-23', '435 Rue du grand frere', 'Banker', 'rosy@hotmail.com'),
('TRIM13536000', '5149807334', 'Massimiliano Tribelli', 'A+', '1990-12-31', '4321 Rue de Laval', 'Stock Brocker', 'mtri@gmail.com'),
('PERG45455454', '5148907654', 'Gianluca Perreault', 'AB+', '1987-11-25', '4560 Rue de la Metropolitaine', 'Crossfit Athlete', 'gperrault@hotmail.ca')

;

INSERT INTO BiologicalMom (QcHealthCard, PhoneNumber, Name, BloodType, DateOfBirth, Address, CurrentProfession, Email, TotalNumberOfPregs, CurrentPregNumber) VALUES
('LALJ12345678', '4503762205', 'Jeanne Lalonde', 'A+', '1995-05-05', '3232 Rue de Eddy', 'Psychologist', 'jlalonde@hotmail.ca', 4, 4),
('GIRS43218765', '5143233232', 'Stephanie Giroux', 'AB-', '1968-08-30', '1234 Rue de la Roche de leau', 'Marketer', 'stephgiroux@hotmail.ca', 2, 2),
('PITA45677654', '5148679167', 'Alli Pitlick', 'O+', '1993-10-15', '67 Minnesota Street', 'Agent', 'allipitlick@gmail.com', 2, 2),
('SARN76678778', '4189009889', 'Nora Sarim', 'AB+', '1999-11-28', 'Rue des Perreault', 'Engineer', 'norasarim@hotmail.ca', 1, 1),
('MCCJ45612334', '5143760022', 'Jessy McCollough', 'B+', '1994-02-27', '133 English Street', 'None', 'jessMc@gmail.com', 2, 2),
('CARG45631234', '5140099900', 'Giulia Carrara', 'A-', '1995-11-12', '135 Little Italy Street', 'Accountant', 'carg@hotmail.ca', 1, 1),
('CARL45631221', '5141199911', 'Leyla Caruso', 'A+', '1992-12-11', '138 Little Italy Street', 'Nurse', 'carley@hotmail.ca', 1, 1),
('GUTV10001000', '4183204567', 'Victoria Gutierrez', 'B+', '1988-11-20', '192 Rue de la Montagne', 'Teacher', 'vgutti@gmail.com', 2, 2)

;



INSERT INTO Couple (CoupleID, IsInterestedInProgram, IsInvited, InfoSessionsAttended, ExpectedTimeFrameOfBirth, QcHealthCardMom, QcHealthCardDad, InstName) VALUES
(0, 'Yes', 'Yes', 3, '2021-05-05', 'LALJ12345678', 'TOPE12345678', 'Hôpital Maisonneuve Rosemont'),
(1, 'Yes', 'Yes', 2, '2020-08-18', 'GIRS43218765', 'TOPE12345678', 'Clinique Médicale Tardif'),
(2, 'Yes', 'Yes', 1, '2019-11-11', 'PITA45677654', 'TRIM13536000', 'Hôtel-Dieu de Québec'),
(3, 'Yes', 'Yes', 1, '2022-01-07', 'SARN76678778', 'PERG45455454', 'Clinique Medicale St-Andre'),
(4, 'Yes', 'Yes', 1, '2022-02-10', 'MCCJ45612334', 'TRIM13536000', 'Hôpital Maisonneuve Rosemont'),
(5, 'No', 'No', 0, '2022-02-02', 'CARL45631221', 'TRIM13536000', 'Hôpital Maisonneuve Rosemont'),
(6, 'No', 'No', 0, '2020-07-17', 'CARL45631221', 'TRIM13536000', 'Hôpital Maisonneuve Rosemont'),
(7, 'Yes', 'Yes', 1, '2021-03-30', 'GUTV10001000', 'PERG45455454', 'Lac-Saint-Louis')

;

INSERT INTO Midwife (PractitionerID, Name, Email, PhoneNumber, InstName) VALUES
(0, 'Jeannette LaBrune', 'jlb@hotmail.ca', '5149898989', 'Hôpital Maisonneuve Rosemont'),
(1, 'Greg Focker', 'gregfo@gmail.com', '4503764545', 'Clinique Médicale Tardif'),
(2, 'Betty Draper', 'bettydraps@hotmail.ca', '5141234537', 'Hôtel-Dieu de Québec'),
(3, 'Carmella Soprano', 'carmsop@hotmail.com', '4183451234', 'Clinique Medicale St-Andre'),
(4, 'Florence Dussault', 'floduss@gmail.ca', '5140907656','Hôpital Maisonneuve Rosemont'),
(5, 'Marie Tremblay', 'tremmar@hotmail.ca', '4503198371', 'Hôpital Maisonneuve Rosemont'),
(6, 'Sabrina Capuano', 'capsab@hotmail.ca', '5142205678', 'Clinique Médicale Tardif'),
(7, 'Marie-Anne Legault', 'legmariea@gmail.com', '4184185141', 'Hôtel-Dieu de Québec'),
(8, 'Megan Draper', 'megzdr@hotmail.ca', '5143302290','Clinique Medicale St-Andre'),
(9, 'Christine Sinclair', 'thegoat@hotmail.ca', '4508889999','Lac-Saint-Louis'),
(10, 'Marion Girard', 'mgirard@hotmail.ca', '4502233456', 'Lac-Saint-Louis')

;

INSERT INTO Backups (PrimaryMidwife, BackupMidwife) VALUES
(0, 5),
(1, 6),
(2, 7),
(3, 8),
(4, 9),
(10, 0)

;

INSERT INTO Pregnancy (PregnancyID, PregNum, FinalEstimatedDate, LastMenstruelPDate, LocationOfBirth, UltraSoundDueDate, NumberOfBabies, CoupleID, InstName) Values
(0, 3, '2021-05-03', '2020-08-09', 'Hôpital Maisonneuve Rosemont', '2021-04-13', 2, 0, 'Hôpital Maisonneuve Rosemont'),
(1, 2, '2020-08-18', '2019-12-31', 'Hôtel-Dieu de Québec', '2020-12-01', 1, 1, 'Clinique Médicale Tardif'),
(2, 1, '2019-11-12', '2019-03-21', 'Hôtel-Dieu de Québec', '2019-10-29', 2, 2, 'Hôtel-Dieu de Québec'),
(3, 1, '2021-12-25', '2021-03-11', 'Jewish General Hospital', '2021-12-15', 1, 3, 'Clinique Medicale St-Andre'),
(4, 2, '2022-02-10', '2021-04-28', 'Hôpital Maisonneuve Rosemont', '2022-01-27', 1, 4, 'Lac-Saint-Louis'),
(5, 1, '2021-04-23', '2020-08-28', 'Lac-Saint-Louis', '2021-03-23', 2, 7, 'Lac-Saint-Louis'),
(6, 2, '2022-07-23', '2021-12-24', 'Lac-Saint-Louis', '2022-06-21', 2, 7, 'Lac-Saint-Louis'),
(7, 4, '2022-07-11', '2022-12-14', 'Hôtel-Dieu de Québec', '2022-07-08', 1, 0, 'Clinique Médicale Tardif'),
(8, 2, '2022-07-29', '2022-12-28', 'Lac-Saint-Louis', '2022-07-28', 1, 2, 'Lac-Saint-Louis')

;

INSERT INTO Baby (BabyID, Gender, Name, HealthStatus, BloodType, DateOfBirth, TimeOfBirth, PregnancyID) VALUES
(0, 'M', 'Jacob Topping', 'Healthy, no issues.', 'A+',  '2021-05-02', '1:05:22', 0),
(1, 'M', 'James Topping', 'Healthy, no issues.', 'A+',  '2021-05-02', '1:07:10', 0),
(2, 'F', 'Jessica Giroux', 'Healthy, no issues.', 'AB-', '2020-08-18', '11:35:52', 1),
(3, 'F', 'Sara Tribelli', 'Healthy, no issues.',  'A+', '2019-11-11', '13:27:33', 2),
(4, 'F', 'Michael Tribelli', 'Healthy, no issues.',  'A+', '2019-11-11', '13:28:47', 2),
(5, 'F', 'Sonia Perreault', 'Healthy, no issues.', 'AB+', '2021-12-25', '18:47:13', 3),
(6, 'M', 'John McCollough', 'Healthy, no issues.', 'B+', '2022-02-12', '17:07:00', 4),
(7, 'F', 'Alejandra Gutierrez', 'Healthy, no issues.', 'B+', '2021-04-23', '13:45:42', 5),
(8, 'M', 'Alexis Gutierrez', 'Healthy, no issues.', 'B+', '2021-04-23', '13:47:45', 5),
(9, 'M', 'Arturo Gutierrez', 'Healthy, no issues.', 'B+', '2021-12-24', '00:00:00', 6),
(10, 'M', 'Mike Topping', 'Healthy.', 'A-', '2022-12-14', '00:00:00', 7),
(11, 'M', 'Bello Tribelli', 'Healthy.', 'O+', '2022-12-28', '00:00:00', 8)

;

INSERT INTO Supervises (PractitionerID, PregnancyID) VALUES
(0, 0),
(1, 1),
(2, 2),
(3, 3),
(10, 4),
(10, 5),
(10, 6),
(10, 7),
(10, 8)

;

INSERT INTO OnlineInfoSession (PractitionerID, Date, Time, Language, CouplesAttendance) Values
(0, '2021-01-07', '13:00:00', 'English', 3),
(1, '2018-12-16', '14:00:00', 'French', 1),
(2, '2020-01-15', '09:00:00', 'French', 1),
(3, '2020-02-04', '12:00:00', 'French', 2),
(4, '2021-01-07', '08:30:00', 'English', 1),
(10, '2020-07-03', '10:30:00', 'English', 1)

;

INSERT INTO Attends (CoupleID, PractitionerID, Date, Time, HasAttended, IsRegistered) VALUES
(0, 0, '2021-01-07', '13:00:00', 'Yes', 'Yes'),
(0, 4, '2021-01-07', '08:30:00', 'Yes', 'Yes'),
(0, 3, '2020-02-04', '12:00:00', 'Yes', 'Yes'),
(3, 0, '2021-01-07', '13:00:00', 'Yes', 'Yes'),
(4, 0, '2021-01-07', '13:00:00', 'Yes', 'Yes'),
(1, 3, '2020-02-04', '12:00:00', 'Yes', 'Yes'),
(1, 2, '2020-01-15', '09:00:00', 'Yes', 'Yes'),
(2, 1, '2018-12-16', '14:00:00', 'Yes', 'Yes'),
(7, 10, '2020-07-03', '10:30:00', 'Yes', 'Yes')

;


INSERT INTO Appointment (AppointmentID, Date, Time, PractitionerID, PregnancyID) VALUES
(0, '2021-03-03', '9:30:00', 0, 0),
(1, '2020-08-18', '9:00:00', 1, 1),
(2, '2019-11-12', '11:30:00', 2, 2),
(3, '2021-12-25', '12:30:00', 3, 3),
(4, '2022-02-10', '15:30:00', 10, 4),
(5, '2021-03-23', '15:30:00', 10, 5),
(7, '2022-03-21', '9:00:00', 10, 3),
(8, '2022-03-22', '15:30:00', 10, 4),
(9, '2022-03-24', '11:00:00', 10, 6)

;

INSERT INTO Note (AppointmentID, Date, Time, Observation) VALUES
(0, '2020-05-03', '9:30:00', 'Everything is fine. US appointment planned.'),
(1, '2020-04-18', '9:00:00', 'US appointment planned, baby is healthy.'),
(2, '2019-09-18', '11:30:00', 'All is good. Ultrasound next.'),
(3, '2021-11-27', '12:30:00', 'Ultrasound soon. Pregnancy is on track.'),
(4, '2021-11-13', '15:30:00', 'Tout va bien! Ultrason sera fait bientôt.'),
(5, '2021-03-23', '15:30:00', 'Ultrasound to be done soon. Sample for blood iron taken.'),
(9, '2022-03-24', '11:00:00', 'Discussed previous 3 blood sample tests. Looking good.')

;

INSERT INTO Technician (TechnicianID, Name, PhoneNumber) VALUES
(0, 'Justin Rocheleau', '5141609128'),
(1, 'Nassib Jr. Hassouna', '5141249128'),
(2, 'Mathieu Lapierre', '5141609009'),
(3, 'Jordan Lamour', '4180001234'),
(4, 'Juliette Paquin', '4500840302')

;

INSERT INTO Lab (LabName, NumberOfTests, LabAddress) VALUES
('Institut de Médecine de Montréal', 1, '3535 Rue de la Médecine'),
('Montreal Lab Center', 1, '5340 University Street'),
('Analyse Québec', 1, '9000 Rue de Renée Lévesque'),
('Laval General Testing Center', 1, '4080 Boulevard de Assomption'),
('Centre dAnalyse du Québec', 1, '125 Rue du Port')

;

INSERT INTO MedicalTests (TestID, TestResult, TestType, DateLabWorkWasDone, DateTestWasPrescribed, DateSampleWasTaken, TechnicianID, LabName, PractitionerID, BabyID, PregnancyID) VALUES
(0, 'Success.', 'Ultrasound', '2021-03-13', '2021-03-04', '2021-03-03', 0, 'Institut de Médecine de Montréal', 0, 0, 0),
(1, 'Success.', 'Ultrasound', '2021-03-13', '2021-03-04', '2021-03-03', 0, 'Institut de Médecine de Montréal', 1, 0, 0),
(2, 'Success.', 'Ultrasound', '2020-04-25', '2020-04-19', '2020-04-18', 1, 'Montreal Lab Center', 1, 2, 1),
(3, 'Success.', 'Ultrasound', '2019-09-26', '2019-09-19', '2019-09-18', 2, 'Analyse Québec', 2, 3, 2),
(4, 'Success.', 'Ultrasound', '2019-09-26', '2019-09-19', '2019-09-18', 2, 'Analyse Québec', 2, 4, 2),
(5, 'Success.', 'Ultrasound', '2021-12-05', '2021-11-28', '2021-11-27', 3, 'Laval General Testing Center', 3, 5, 3),
(6, 'Success.', 'Ultrasound', '2021-11-21', '2021-11-14', '2021-11-13', 4, 'Centre dAnalyse du Québec', 10, 6, 4),
(7, 'Success.', 'Ultrasound', '2021-03-30', '2021-03-24', '2021-03-23', 4, 'Centre dAnalyse du Québec', 10, 7, 5),
(8, 'Normal.', 'Blood Iron', '2021-09-20', '2021-09-13', '2021-03-23', 4, 'Centre dAnalyse du Québec', 10, 9, 6),
(9, 'Abnormal.', 'Blood Iron', '2021-12-23', '2021-12-16', '2021-03-23', 4, 'Centre dAnalyse du Québec', 10, 9, 6),
(10, 'Better.', 'Blood Iron', '2022-05-27', '2021-05-20', '2021-03-23', 4, 'Centre dAnalyse du Québec', 10, 9, 6)


;
