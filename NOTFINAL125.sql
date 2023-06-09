use travellism;
CREATE TABLE Person
(
  PersonID INT ,
  DateOfBirth DATE NOT NULL,
  street VARCHAR(20) NOT NULL,
  apartment_no INT ,
  bulding_no INT ,
  City VARCHAR(20) NOT NULL,
  PostalCode INT NOT NULL,
  Communication_Preference VARCHAR(20) NOT NULL,
  Gender VARCHAR(20) NOT NULL,
  PassportNumber INT NOT NULL,
  Nationality VARCHAR(20) NOT NULL,
  FirstName VARCHAR(20) NOT NULL,
  MiddleName VARCHAR(20) NOT NULL,
  LastName VARCHAR(20) NOT NULL,
  PRIMARY KEY (PersonID)
);

CREATE TABLE Account
(
  AccountID INT ,
  AccountPassword VARCHAR(20) NOT NULL,
  Email VARCHAR(20) NOT NULL,
  Accountstatus VARCHAR(20) NOT NULL,
  AccountRole VARCHAR(20) NOT NULL,
  Username VARCHAR(20) NOT NULL,
  AccountType VARCHAR(20) NOT NULL,
  PersonID INT NOT NULL,
  PRIMARY KEY (AccountID),
  FOREIGN KEY (PersonID) REFERENCES Person(PersonID) on update CASCADE ON DELETE CASCADE
  );

CREATE TABLE Embassy
(
  EmbassyName VARCHAR(20) ,
  street VARCHAR(20) NOT NULL,
  city VARCHAR(20) NOT NULL,
  EmbassyWorkingHours VARCHAR(20),
  EmbassyWebsite VARCHAR(20) ,
  EmbassyEmail VARCHAR(20) ,
  PRIMARY KEY (EmbassyName)
);

CREATE TABLE Person_PersonPhone
(
  PersonPhone INT ,
  PersonID INT ,
  PRIMARY KEY (PersonPhone, PersonID),
  FOREIGN KEY (PersonID) REFERENCES Person(PersonID) on UPDATE CASCADE ON DELETE CASCADE

);

CREATE TABLE Embassy_EmbassyPhone
(
  EmbassyPhone INT ,
  EmbassyName VARCHAR(20),
  PRIMARY KEY (EmbassyPhone, EmbassyName),
  FOREIGN KEY (EmbassyName) REFERENCES Embassy(EmbassyName) on UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Staff
(
  StaffID INT NOT NULL UNIQUE,
  Performance_Rating FLOAT ,
  HiringDate DATE NOT NULL,
  YearsOf_Experience INT ,
  PersonID INT NOT NULL,
  PRIMARY KEY (PersonID),
  FOREIGN KEY (PersonID) REFERENCES Person(PersonID) on UPDATE CASCADE ON DELETE CASCADE
);
CREATE TABLE TourGuide
(
  TourGuideStatus VARCHAR(20) NOT NULL,
  HourlyPay FLOAT NOT NULL,
  AvailabilityTime time ,
  AvailabilityDate DATE ,
  PersonID INT,
  PRIMARY KEY (PersonID),
  FOREIGN KEY (PersonID) REFERENCES Staff(PersonID) on UPDATE CASCADE ON DELETE CASCADE
);
CREATE TABLE Tourist
(
  TravelStyle VARCHAR(20) ,
  Wishlist VARCHAR(20) default null,
  PersonID INT,
  EmbassyName VARCHAR(20) ,
  PRIMARY KEY (PersonID),
  FOREIGN KEY (PersonID) REFERENCES Person(PersonID) on UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (EmbassyName) REFERENCES Embassy(EmbassyName) on UPDATE CASCADE ON DELETE SET NULL,
  FOREIGN KEY (PersonID) REFERENCES TourGuide(PersonID)on UPDATE CASCADE ON DELETE CASCADE
);
CREATE TABLE Payments
(
  PaymentID INT ,
  Amount FLOAT NOT NULL,
  PaymentStatus VARCHAR(20) NOT NULL,
  TransactionDate DATE NOT NULL,
  PersonID INT ,
  PRIMARY KEY (PaymentID),
  FOREIGN KEY (PersonID) REFERENCES Tourist(PersonID) on UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Cart
(
  CartStatus VARCHAR(20) ,
  CartID INT ,
  PaymentID INT ,
  PRIMARY KEY (CartID),
  FOREIGN KEY (PaymentID) REFERENCES Payments(PaymentID) on UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Booking
(
  cancellation_Reason VARCHAR(20) default null,
  BookingPrice FLOAT NOT NULL,
  BookingDate DATE NOT NULL,
  BookingStatus VARCHAR(20) NOT NULL,
  cancellationDate DATE default null,
  BookingID INT,
  cancellationFees FLOAT default 0,
  Rating FLOAT,
  CartID INT,
  PRIMARY KEY (BookingID),
  FOREIGN KEY (CartID) REFERENCES Cart(CartID) on UPDATE CASCADE ON DELETE SET NULL
);




CREATE TABLE cash
(
  CurrencyType VARCHAR(20) NOT NULL,
  PaymentID INT ,
  PRIMARY KEY (PaymentID),
  FOREIGN KEY (PaymentID) REFERENCES Payments(PaymentID) on UPDATE CASCADE ON DELETE CASCADE

);

CREATE TABLE Paypal
(
  Email VARCHAR(20) NOT NULL,
  PaypalPassword VARCHAR(20) NOT NULL,
  PaymentID INT,
  PRIMARY KEY (PaymentID),
  FOREIGN KEY (PaymentID) REFERENCES Payments(PaymentID) on UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Visa
(
  CardNumber INT NOT NULL,
  ExpirationDate DATE NOT NULL,
  CardHolderName VARCHAR(20) NOT NULL,
  SecurityCode INT NOT NULL,
  PaymentID INT ,
  PRIMARY KEY (PaymentID),
  FOREIGN KEY (PaymentID) REFERENCES Payments(PaymentID) on UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Accommodation
(
  NumRoom INT,
  AccommodationStatus VARCHAR(20),
  apartment_no INT NOT NULL,
  bulding_no INT NOT NULL,
  street VARCHAR(20) NOT NULL,
  City VARCHAR(20) NOT NULL,
  PostalCode INT,
  BookingID INT ,
  PRIMARY KEY (BookingID),
  FOREIGN KEY (BookingID) REFERENCES Booking(BookingID) on UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE CarRental
(
  CarType VARCHAR(20) NOT NULL,
  License VARCHAR(20) NOT NULL,
  Driver bit NOT NULL,
  BookingID INT ,
  PRIMARY KEY (BookingID),
  FOREIGN KEY (BookingID) REFERENCES Booking(BookingID) on UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Restaurant
(
  RestaurantName VARCHAR(20) NOT NULL,
  Cuisine VARCHAR(20) ,
  street VARCHAR(20) NOT NULL,
  City VARCHAR(20) NOT NULL,
  BookingID INT,
  PRIMARY KEY (BookingID),
  FOREIGN KEY (BookingID) REFERENCES Booking(BookingID) on UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Entertainment_Options
(
  Entertainment_OptionsLocation VARCHAR(20) ,
  TicketPrice FLOAT NOT NULL,
  Website VARCHAR(20) ,
  Entertainment_OptionsName VARCHAR(20) NOT NULL,
  AvailabilityDate DATE NOT NULL,
  Category VARCHAR(20) NOT NULL,
  AgeRange VARCHAR(20) default null ,
  BookingID INT ,
  PersonID INT,
  PRIMARY KEY (BookingID),
  FOREIGN KEY (BookingID) REFERENCES Booking(BookingID) on delete CASCADE on update CASCADE,
  FOREIGN KEY (PersonID) REFERENCES TourGuide(PersonID) ON DELETE CASCADE ON UPDATE SET NULL
  
  
);

CREATE TABLE flight
(
  Baggage_Allowance float  NOT NULL,
  ArrivalTime time NOT NULL,
  DepartureTime time NOT NULL,
  ArrivalDate DATE NOT NULL,
  Flightstatus DATE NOT NULL,
  DepartureCity VARCHAR(20) NOT NULL,
  Airline VARCHAR(20) NOT NULL,
  DepartureDate DATE NOT NULL,
  Class VARCHAR(20) NOT NULL,
  ArrivalCity VARCHAR(20) NOT NULL,
  SeatNo INT NOT NULL,
  BookingID INT,
  PRIMARY KEY (BookingID),
  FOREIGN KEY (BookingID) REFERENCES Booking(BookingID) on UPDATE CASCADE ON DELETE CASCADE
);


CREATE TABLE Department
(
  DepID INT,
  DepName VARCHAR(20) NOT NULL,
  PRIMARY KEY (DepID)
  
);
ALTER TABLE Department
ADD EmployeeID INT,
ADD CONSTRAINT FK_Department_Employee
FOREIGN KEY (EmployeeID) REFERENCES Employee(PersonID) ON UPDATE CASCADE ON DELETE CASCADE;

CREATE TABLE Employee
(
  HiringDate DATE NOT NULL,
  Salary FLOAT NOT NULL,
  JobTitle VARCHAR(20) NOT NULL,
  PersonID INT ,
  DepID INT ,
  managesDepID INT default NULL,
  Supervision_PersonID INT default NULL,
  PRIMARY KEY (PersonID),
  FOREIGN KEY (PersonID) REFERENCES Staff(PersonID) on UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (managesDepID) REFERENCES Department(DepID) on UPDATE CASCADE ON DELETE SET NULL,
  FOREIGN KEY (Supervision_PersonID) REFERENCES Employee(PersonID) on UPDATE CASCADE ON DELETE SET NULL
);






CREATE TABLE Hotel
(
  HotelName VARCHAR(20) NOT NULL,
  Style VARCHAR(20),
  FoodOptions VARCHAR(20) NOT NULL,
  HotelServices_ VARCHAR(20) NOT NULL,
  RoomType VARCHAR(20) NOT NULL,
  BookingID INT ,
  PRIMARY KEY (BookingID),
  FOREIGN KEY (BookingID) REFERENCES Accommodation(BookingID)on UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE VacationRental
(
  PropertyType_ VARCHAR(20) NOT NULL,
  HostName VARCHAR(20) NOT NULL,
  PropertySize_ VARCHAR(20) ,
  BookingID INT ,
  PRIMARY KEY (BookingID),
  FOREIGN KEY (BookingID) REFERENCES Accommodation(BookingID) on UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Dependent
(
  DependantName VARCHAR(20),
  Gender VARCHAR(20) NOT NULL,
  DateOfBirth DATE NOT NULL,
  Relationship VARCHAR(20) NOT NULL,
  PersonID INT ,
  PRIMARY KEY (DependantName, PersonID),
  FOREIGN KEY (PersonID) REFERENCES Employee(PersonID) on UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Support
(
  SupportID INT ,
  SupportStatus VARCHAR(20) NOT NULL,
  DateOfRequest DATE NOT NULL,
  SupportType VARCHAR(20) NOT NULL,
  PersonID INT ,
  PRIMARY KEY (SupportID),
  FOREIGN KEY (PersonID) REFERENCES Employee(PersonID) on UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE proceed
(
  Reviews VARCHAR(20) ,
  PersonID INT ,
  BookingID INT ,
  PRIMARY KEY (PersonID, BookingID),
  FOREIGN KEY (PersonID) REFERENCES Tourist(PersonID) on UPDATE CASCADE ON DELETE CASCADE, 
  FOREIGN KEY (BookingID) REFERENCES Booking(BookingID)on UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Ask_for
(
  PersonID INT ,
  SupportID INT ,
  PRIMARY KEY (PersonID, SupportID),
  FOREIGN KEY (PersonID) REFERENCES Tourist(PersonID)on UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (SupportID) REFERENCES Support(SupportID)on UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Coordinate
(
  BookingID INT,
  PersonID INT ,
  PRIMARY KEY (BookingID, PersonID),
  FOREIGN KEY (BookingID) REFERENCES Entertainment_Options(BookingID) on delete cascade on update cascade,
  FOREIGN KEY (PersonID) REFERENCES Staff(PersonID) on UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Checks
(
  PersonID INT ,
  BookingID INT,
  PRIMARY KEY (PersonID, BookingID),
  FOREIGN KEY (PersonID) REFERENCES Employee(PersonID)on UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (BookingID) REFERENCES Booking(BookingID)on UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Contacts
(
staff_personid int ,
tourist_personid int
primary key (staff_Personid),
foreign key (tourist_personid ) references Tourist (personId)on UPDATE CASCADE ON DELETE CASCADE,
foreign key (staff_personid ) references Staff (personId)on UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Accommodation_Accommodation_Phone
(
  Accommodation_Phone INT,
  BookingID INT ,
  PRIMARY KEY (Accommodation_Phone, BookingID) ,
  FOREIGN KEY (BookingID) REFERENCES Accommodation(BookingID)on UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Restaurant_RestaurantPhone
(
  RestaurantPhone INT ,
  BookingID INT,
  PRIMARY KEY (RestaurantPhone, BookingID),
  FOREIGN KEY (BookingID) REFERENCES Restaurant(BookingID) on UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE TourGuide_Languages
(
  Languages VARCHAR(20) ,
  PersonID INT ,
  PRIMARY KEY (Languages, PersonID),
  FOREIGN KEY (PersonID) REFERENCES TourGuide(PersonID) on UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Dependent_Telephone
(
  Telephone INT ,
  DependantName VARCHAR(20) ,
  PersonID INT ,
  PRIMARY KEY (Telephone, DependantName, PersonID),
  FOREIGN KEY (DependantName, PersonID) REFERENCES Dependent(DependantName, PersonID) on UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO Person (PersonID, DateOfBirth, Street, apartment_no, bulding_no, City, PostalCode, Communication_Preference, Gender, PassportNumber, Nationality, FirstName, MiddleName, LastName)
VALUES
  (1, '1990-01-01', 'Street 1', 101, 10, 'City 1', '12345', 'Email', 'Male', '123456', 'Country 1', 'John', 'A.', 'Doe'),
  (2, '1992-03-15', 'Street 2', 202, 20, 'City 2', '23456', 'Phone', 'Female', '987654', 'Country 2', 'Jane', '', 'Smith'),
  (3, '1988-07-20', 'Street 3', 303, 30, 'City 3', '34567', 'SMS', 'Male', '246810', 'Country 3', 'Robert', 'B.', 'Johnson'),
  (4, '1995-05-10', 'Street 4', 404, 40, 'City 4', '45678', 'Email', 'Female', '135792', 'Country 1', 'Emily', 'C.', 'Williams'),
  (5, '1982-12-05', 'Street 5', 505, 50, 'City 5', '56789', 'Phone', 'Male', '246813', 'Country 2', 'Daniel', 'D.', 'Brown'),
  (6, '1991-09-25', 'Street 6', 606, 60, 'City 6', '67890', 'SMS', 'Female', '975318', 'Country 3', 'Sophia', 'E.', 'Davis'),
  (7, '1987-06-15', 'Street 7', 707, 70, 'City 7', '78901', 'Email', 'Male', '357159', 'Country 4', 'William', 'F.', 'Miller'),
  (8, '1994-04-30', 'Street 8', 808, 80, 'City 8', '89012', 'Phone', 'Female', '864209', 'Country 1', 'Olivia', 'G.', 'Taylor'),
  (9, '1983-11-20', 'Street 9', 909, 90, 'City 9', '90123', 'SMS', 'Male', '951357', 'Country 2', 'Michael', 'H.', 'Anderson'),
  (10, '1996-08-10', 'Street 10', 1010, 100, 'City 10', '01234', 'Email', 'Female', '123456', 'Country 3', 'Emma', 'I.', 'Johnson'),
  (11, '1989-05-25', 'Street 11', 1111, 110, 'City 11', '12345', 'Phone', 'Male', '654321', 'Country 4', 'Alexander', 'J.', 'Wilson'),
  (12, '1993-02-15', 'Street 12', 1212, 120, 'City 12', '23456', 'SMS', 'Female', '987654', 'Country 1', 'Abigail', 'K.', 'Martinez'),
  (13, '1997-06-05', 'Street 14', 1414, 140, 'City 14', '34567', 'Email', 'Male', '23456', 'Country 2', 'Isabella', 'L.', 'Garcia'),
  (14, '1984-01-30', 'Street 15', 1515, 150, 'City 15', '45678', 'Phone', 'Female', '987654', 'Country 3', 'Ethan', 'M.', 'Lee'),
  (15, '1991-10-15', 'Street 16', 1616, 160, 'City 16', '56789', 'SMS', 'Male', '135792', 'Country 4', 'Mia', 'N.', 'Clark'),
  (16, '1988-07-01', 'Street 17', 1717, 170, 'City 17', '67890', 'Email', 'Female', '246813', 'Country 1', 'James', 'O.', 'Lopez'),
  (17, '1995-03-20', 'Street 18', 1818, 180, 'City 18', '78901', 'Phone', 'Male', '975318', 'Country 2', 'Ava', 'P.', 'Harris'),
  (18, '1982-10-05', 'Street 19', 1919, 190, 'City 19', '89012', 'SMS', 'Female', '57159', 'Country 3', 'Benjamin', 'Q.', 'Young'),
  (19, '1989-07-15', 'Street 20', 2020, 200, 'City 20', '90123', 'Email', 'Male', '864209', 'Country 4', 'Charlotte', 'R.', 'Allen');
INSERT INTO Account (AccountID, AccountPassword, Email, AccountStatus, AccountRole, Username, AccountType, PersonID)
VALUES
  (1, 'password1', 'email1@example.com', 'Active', 'Admin', 'user1', 'Type1', 1),
  (2, 'password2', 'email2@example.com', 'Active', 'User', 'user2', 'Type2', 2),
  (3, 'password3', 'email3@example.com', 'Active', 'User', 'user3', 'Type1', 3),
  (4, 'password4', 'email4@example.com', 'Active', 'User', 'user4', 'Type2', 4),
  (5, 'password5', 'email5@example.com', 'Inactive', 'User', 'user5', 'Type1', 5),
  (6, 'password6', 'email6@example.com', 'Active', 'User', 'user6', 'Type2', 6),
  (7, 'password7', 'email7@example.com', 'Active', 'Admin', 'user7', 'Type1', 7);

INSERT INTO Account (AccountID, AccountPassword, Email, Accountstatus, AccountRole, Username, AccountType, PersonID)
VALUES
  (8, 'pass123', 'example1@example.com', 'Active', 'User', 'user1', 'Standard', 8),
  (9, 'pass456', 'example2@example.com', 'Active', 'User', 'user2', 'Standard', 9),
  (10, 'pass789', 'example3@example.com', 'Active', 'User', 'user3', 'Premium', 10),
  (11, 'passabc', 'example4@example.com', 'Inactive', 'Admin', 'admin1', 'Admin', 11),
  (12, 'passdef', 'example5@example.com', 'Active', 'User', 'user5', 'Standard', 12),
  (13, 'passghi', 'example6@example.com', 'Active', 'User', 'user6', 'Standard', 13),
  (14, 'passjkl', 'example7@example.com', 'Inactive', 'User', 'user7', 'Standard', 14),
  (15, 'passmno', 'example8@example.com', 'Active', 'User', 'user8', 'Standard', 15),
  (16, 'passpqr', 'example9@example.com', 'Active', 'User', 'user9', 'Premium', 16),
  (17, 'passtu', 'example10@example.com', 'Active', 'User', 'user10', 'Standard', 17);

INSERT INTO Embassy (EmbassyName, Street, City, EmbassyWorkingHours, EmbassyWebsite, EmbassyEmail)
VALUES
  ('Embassy1', 'Street 1', 'City 1', '9 AM - 5 PM', 'www.embassy1.com', 'info@embassy1.com'),
  ('Embassy2', 'Street 2', 'City 2', '8 AM - 4 PM', 'www.embassy2.com', 'info@embassy2.com'),
  ('Embassy3', 'Street 3', 'City 3', '10 AM - 6 PM', 'www.embassy3.com', 'info@embassy3.com'),
  ('Embassy4', 'Street 4', 'City 4', '9 AM - 5 PM', 'www.embassy4.com', 'info@embassy4.com'),
  ('Embassy5', 'Street 5', 'City 5', '8:30 AM - 4:30 PM', 'www.embassy5.com', 'info@embassy5.com'),
  ('Embassy6', 'Street 6', 'City 6', '9 AM - 5 PM', 'www.embassy6.com', 'info@embassy6.com'),
  ('Embassy7', 'Street 7', 'City 7', '8:30 AM - 4:30 PM', 'www.embassy7.com', 'info@embassy7.com'),
  ('Embassy8', 'Street 8', 'City 8', '9 AM - 5 PM', 'www.embassy8.com', 'info@embassy8.com');

INSERT INTO Person_PersonPhone (PersonPhone, PersonID)
VALUES
  (111111, 1),
  (222222, 2),
  (333333, 3),
  (444444, 4),
  (555555, 5),
  (666666, 6),
  (777777, 7);

INSERT INTO Embassy_EmbassyPhone (EmbassyPhone, EmbassyName)
VALUES
  (111111, 'Embassy1'),
  (222222, 'Embassy2'),
  (333333, 'Embassy3'),
  (444444, 'Embassy4'),
  (555555, 'Embassy5');

INSERT INTO Staff (StaffID, Performance_Rating , HiringDate, YearsOf_Experience , PersonID)
VALUES
  (1, 4.2, '2022-01-15', 5, 1),
  (2, 3.8, '2021-05-10', 3, 2),
  (3, 4.5, '2023-02-28', 8, 3),
  (4, 3.2, '2020-12-01', 2, 4),
  (5, 4.0, '2022-08-17', 6, 5),
  (6, 4.8, '2021-11-02', 4, 6),
  (7, 3.9, '2023-03-20', 7, 7),
  (8, 4.1, '2022-06-05', 5, 8),
  (9, 4.6, '2021-09-12', 9, 9),
  (10, 4.3, '2022-04-25', 6, 10);

INSERT INTO TourGuide (TourGuideStatus, HourlyPay, AvailabilityTime, AvailabilityDate, PersonID)
VALUES
  ('Active', 25.5, '09:00:00', '2023-05-15', 1),
  ('Active', 22.75, '10:30:00', '2023-05-16', 2),
  ('Inactive', 20.0, '14:00:00', '2023-05-17', 3),
  ('Active', 26.0, '11:15:00', '2023-05-18', 4),
  ('Active', 24.5, '13:45:00', '2023-05-19', 5);

INSERT INTO Tourist (TravelStyle, Wishlist, PersonID, EmbassyName)
VALUES
  ('Adventure', 'Hiking', 1, 'Embassy1'),
  ('Relaxation', NULL, 2, 'Embassy2'),
  ('Cultural', 'Museums', 3, NULL),
  ('Beach', 'Snorkeling', 4, 'Embassy3'),
  ('Sightseeing', 'Landmarks', 5, 'Embassy4');

INSERT INTO Payments (PaymentID, Amount, PaymentStatus, TransactionDate, PersonID)
VALUES
  (1, 100.0, 'Paid', '2023-05-01', 1),
  (2, 75.5, 'Paid', '2023-05-02', 2),
  (3, 50.0, 'Pending', '2023-05-03', 3),
  (4, 120.0, 'Paid', '2023-05-04', 4),
  (5, 90.25, 'Paid', '2023-05-05', 5),
  (6, 80.0, 'Pending', '2023-05-06', 2),
  (7, 60.75, 'Paid', '2023-05-07', 4),
  (8, 110.0, 'Paid', '2023-05-08', 1);

INSERT INTO Payments (PaymentID, Amount, PaymentStatus, TransactionDate, PersonID)
VALUES
  (9, 120.00, 'Completed', '2023-04-01', 1),
  (10, 90.00, 'Pending', '2023-05-01', 2),
  (11, 80.00, 'Completed', '2023-06-01', 3),
  (12, 150.00, 'Pending', '2023-07-01', 4),
  (13, 60.00, 'Completed', '2023-08-01', 5),
  (14, 110.00, 'Completed', '2023-09-01', 4),
  (15, 95.00, 'Pending', '2023-10-01', 3);

INSERT INTO Cart (CartStatus, CartID, PaymentID)
VALUES
  ('Active', 1, 1),
  ('Active', 2, 2),
  ('Inactive', 3, 3),
  ('Active', 4, 4),
  ('Active', 5, 5),
  ('Inactive', 6, 6),
  ('Active', 7, 7);

INSERT INTO Booking (cancellation_Reason, BookingPrice, BookingDate, BookingStatus, cancellationDate, BookingID, cancellationFees, Rating, CartID)
VALUES
  (NULL, 150.0, '2023-05-01', 'Confirmed', NULL, 1, 0.0, 4.5, 1),
  ('Change of plans', 200.0, '2023-05-02', 'Cancelled', '2023-04-30', 2, 20.0, NULL, 2),
  (NULL, 120.0, '2023-05-03', 'Confirmed', NULL, 3, 0.0, 3.8, 3),
  ('Not satisfied', 180.0, '2023-05-04', 'Cancelled', '2023-05-02', 4, 15.0, NULL, 1),
  (NULL, 90.0, '2023-05-05', 'Confirmed', NULL, 5, 0.0, 4.2, 2),
  ('Emergency', 250.0, '2023-05-06', 'Cancelled', '2023-05-05', 6, 30.0, NULL, 3),
  (NULL, 200.0, '2023-05-07', 'Confirmed', NULL, 7, 0.0, 4.9, 1);

INSERT INTO Cart (CartStatus, CartID, PaymentID)
VALUES
  ('Active', 1, 1),
  ('Active', 2, 2),
  ('Inactive', 3, 3),
  ('Active', 4, 4),
  ('Active', 5, 5),
  ('Inactive', 6, 6),
  ('Active', 7, 7);

INSERT INTO cash (CurrencyType, PaymentID)
VALUES
  ('USD', 1),
  ('EUR', 2),
  ('GBP', 3),
  ('CAD', 4),
  ('AUD', 5),
  ('JPY', 6);

INSERT INTO Paypal (Email, PaypalPassword, PaymentID)
VALUES
  ('user1@example.com', 'password1', 1),
  ('user2@example.com', 'password2', 2),
  ('user3@example.com', 'password3', 3),
  ('user4@example.com', 'password4', 4),
  ('user5@example.com', 'password5', 5),
  ('user6@example.com', 'password6', 6);
  
  INSERT INTO Visa (CardNumber, ExpirationDate, CardHolderName, SecurityCode, PaymentID)
VALUES
  (123456789, '2024-12-01', 'John Doe', 123, 6),
  (987654321, '2025-06-01', 'Jane Smith', 456, 7),
  (456789012, '2023-09-01', 'Mike Johnson', 789, 8),
  (567890123, '2024-03-01', 'Sarah Williams', 234, 9),
  (901234567, '2025-11-01', 'David Brown', 567, 10);
  
  INSERT INTO Booking (cancellation_Reason, BookingPrice, BookingDate, BookingStatus, cancellationDate, BookingID, cancellationFees, Rating, CartID)
VALUES
  ('Change of plans', 250.00, '2023-05-01', 'Confirmed', NULL, 8, 0, NULL, 1),
  (NULL, 180.00, '2023-05-02', 'Confirmed', NULL, 9, 0, NULL, 2),
  (NULL, 300.00, '2023-05-03', 'Confirmed', NULL, 10, 0, NULL, 3),
  ('bad weather', 150.00, '2023-05-04', 'Cancelled', '2023-05-03', 11, 50.00, NULL, 4),
  (NULL, 200.00, '2023-05-05', 'Confirmed', NULL, 12, 0, NULL, 4);

INSERT INTO Booking (cancellation_Reason, BookingPrice, BookingDate, BookingStatus, cancellationDate, BookingID, cancellationFees, Rating, CartID)
VALUES
  (NULL, 220.00, '2023-05-06', 'Confirmed', NULL, 13, 0, NULL, 1),
  (NULL, 180.00, '2023-05-07', 'Confirmed', NULL, 14, 0, NULL, 2),
  (NULL, 300.00, '2023-05-08', 'Confirmed', NULL, 15, 0, NULL, 3),
  ('Change of plans', 150.00, '2023-05-09', 'Cancelled', '2023-05-07', 16, 50.00, NULL, 4),
  (NULL, 200.00, '2023-05-10', 'Confirmed', NULL, 17, 0, NULL, 5),
  (NULL, 250.00, '2023-05-11', 'Confirmed', NULL, 18, 0, NULL, 4),
  ('Emergency situation', 300.00, '2023-05-12', 'Cancelled', '2023-05-10', 19, 75.00, NULL, 3),
  (NULL, 180.00, '2023-05-13', 'Confirmed', NULL, 20, 0, NULL, 2),
  (NULL, 220.00, '2023-05-14', 'Confirmed', NULL, 21, 0, NULL, 1),
  (NULL, 250.00, '2023-05-15', 'Confirmed', NULL, 22, 0, NULL, 1);
  INSERT INTO Booking (cancellation_Reason, BookingPrice, BookingDate, BookingStatus, cancellationDate, BookingID, cancellationFees, Rating, CartID)
VALUES
  (NULL, 150.00, '2023-05-15', 'Confirmed', NULL, 23, 0, NULL, 1),
  ('Change of plans', 200.00, '2023-05-16', 'Confirmed', NULL, 24, 0, NULL, 2),
  (NULL, 100.00, '2023-05-17', 'Confirmed', NULL, 25, 0, NULL, 3),
  (NULL, 180.00, '2023-05-18', 'Confirmed', NULL, 26, 0, NULL, 4),
  ('Weather conditions', 120.00, '2023-05-19', 'Confirmed', NULL, 27, 0, NULL, 5),
  (NULL, 90.00, '2023-05-20', 'Confirmed', NULL, 28, 0, NULL, 5),
  (NULL, 160.00, '2023-05-21', 'Confirmed', NULL, 29, 0, NULL, 4),
  (NULL, 140.00, '2023-05-22', 'Confirmed', NULL, 30, 0, NULL, 3),
  ('Schedule conflict', 250.00, '2023-05-23', 'Confirmed', NULL, 31, 0, NULL, 2),
  (NULL, 110.00, '2023-05-24', 'Confirmed', NULL, 32, 0, NULL, 1);


  INSERT INTO Accommodation (NumRoom, AccommodationStatus, apartment_no , bulding_no , Street, City, PostalCode, BookingID)
VALUES
  (2, 'Booked', 101, 1, 'Main Street', 'City A', 12345, 1),
  (3, 'Available', 202, 2, 'Broadway', 'City B', 67890, 2),
  (1, 'Booked', 303, 3, 'Oak Avenue', 'City C', 54321, 3),
  (2, 'Available', 404, 4, 'Elm Street', 'City D', 98765, 4),
  (4, 'Booked', 505, 5, 'Maple Lane', 'City E', 13579, 5),
  (1, 'Available', 606, 6, 'Cedar Road', 'City F', 24680, 6),
  (3, 'Booked', 707, 7, 'Pine Street', 'City G', 90876, 7),
  (2, 'Available', 808, 8, 'Willow Avenue', 'City H', 64203, 8),
  (1, 'Booked', 909, 9, 'Spruce Lane', 'City I', 47628, 9),
  (4, 'Available', 1010, 10, 'Birch Road', 'City J', 31459, 10);

INSERT INTO CarRental (CarType, License, Driver, BookingID)
VALUES
  ('Sedan', 'ABC123', 1, 11),
  ('SUV', 'DEF456', 0, 12),
  ('Compact', 'GHI789', 1, 13),
  ('Van', 'JKL012', 1, 14),
  ('Convertible', 'MNO345', 0, 15);
  
  INSERT INTO Restaurant (RestaurantName, Cuisine, Street, City, BookingID)
VALUES
  ('Italian Delights', 'Italian', 'Main Street', 'New York', 16),
  ('Sushi Paradise', 'Japanese', 'Central Avenue', 'Tokyo', 17),
  ('Spice Kingdom', 'Indian', 'Street 4', 'Mumbai', 18),
  ('Mexican Fiesta', 'Mexican', 'Sunset Boulevard', 'Los Angeles', 19),
  ('French Bistro', 'French', 'Rue de la Paix', 'Paris', 20);

INSERT INTO Entertainment_Options (Entertainment_OptionsLocation, TicketPrice, Website, Entertainment_OptionsName, AvailabilityDate, Category, AgeRange, BookingID, PersonID)
VALUES
  ('Amusement Park', 50.00, 'www.amuse.com', 'Funland', '2023-05-15', 'Outdoor', 'All Ages', 21, NULL),
  ('Concert Hall', 80.00, 'www.concerthall.com', 'Symphony Night', '2023-05-20', 'Music', '18+', 22, NULL),
  ('Movie Theater', 12.50, 'www.movie.com', 'Blockbuster Cinema', '2023-05-18', 'Movies', 'All Ages', 23, NULL),
  ('Museum', 15.00, 'www.museum.com', 'Art Gallery', '2023-05-17', 'Art', 'All Ages', 24, NULL),
  ('Zoo', 20.00, 'www.zoo.com', 'Wildlife Adventure', '2023-05-16', 'Nature', 'All Ages', 25, NULL);


INSERT INTO flight (Baggage_Allowance, ArrivalTime, DepartureTime, ArrivalDate, FlightStatus, DepartureCity, Airline, DepartureDate, Class, ArrivalCity, SeatNo, BookingID)
VALUES
  (23.5, '12:30:00', '10:00:00', '2023-05-25', 'On Time', 'New York', 'ABC Airlines', '2023-05-25', 'Business', 'London', 15, 20),
  (18.0, '08:45:00', '06:15:00', '2023-05-26', 'Delayed', 'Paris', 'XYZ Airways', '2023-05-26', 'Economy', 'Rome', 28, 21),
  (20.0, '15:20:00', '13:00:00', '2023-05-27', 'On Time', 'Tokyo', 'DEF Airlines', '2023-05-27', 'First Class', 'Sydney', 7, 22),
  (25.5, '09:10:00', '07:30:00', '2023-05-28', 'On Time', 'Chicago', 'GHI Airways', '2023-05-28', 'Economy', 'Dubai', 12, 23),
  (30.0, '16:45:00', '14:15:00', '2023-05-29', 'On Time', 'Los Angeles', 'JKL Airlines', '2023-05-29', 'Business', 'Mumbai', 33, 24);

INSERT INTO Department (DepID, DepName)
VALUES
  (1, 'Sales'),
  (2, 'Marketing'),
  (3, 'Finance'),
  (4, 'Human Resources'),
  (5, 'IT'),
  (6, 'Operations'),
  (7, 'Research'),
  (8, 'Customer Service'),
  (9, 'Production'),
  (10, 'Quality Assurance');


INSERT INTO Employee (HiringDate, Salary, JobTitle, PersonID, DepID, managesDepID, Supervision_PersonID)
VALUES
  ('2022-01-01', 5000, 'Manager', 6, 1, NULL, 6),
  ('2022-02-01', 4000, 'Sales Representative', 7, 1, NULL, 6),
  ('2022-03-01', 4500, 'Marketing Coord', 8, 2, NULL, 7),
  ('2022-04-01', 5500, 'Financial Analyst', 9, 3, NULL, 8),
  ('2022-05-01', 6000, 'HR Manager', 10, 4, NULL, 9),
  ('2022-06-01', 5500, 'IT Specialist', 1, 5, NULL, 10),
  ('2022-07-01', 4000, 'Operations Assistant', 2, 6, NULL, 10),
  ('2022-08-01', 4200, 'Research Associate', 3, 7, NULL, 7),
  ('2022-09-01', 3800, 'Customer Service', 4, 8, NULL,9),
  ('2022-10-01', 5000, 'Supervisor', 5, 9, 1, 2);

INSERT INTO Hotel (HotelName, Style, FoodOptions, HotelServices_, RoomType, BookingID)
VALUES ('Hotel A', 'Modern', 'Breakfast, Lunch', 'Gym, Spa', 'Deluxe', 1),
       ('Hotel B', 'Classic', 'All-Inclusive', 'Pool, Restaurant', 'Standard', 2),
       ('Hotel C', 'Boutique', 'Breakfast', 'Concierge, Gym', 'Suite', 3),
       ('Hotel D', 'Resort', 'Buffet', 'Entertainment', 'Villa', 4),
       ('Hotel E', 'Luxury', 'Fine Dining', '24-hour Front Desk', 'Executive', 5);

INSERT INTO VacationRental (PropertyType_, HostName, PropertySize_, BookingID)
VALUES ('Apartment', 'John Smith', '100 sqm', 1),
       ('Cabin', 'Emma Johnson', '80 sqm', 2),
       ('Villa', 'Michael Brown', '250 sqm', 3),
       ('Chalet', 'Sophia Davis', '120 sqm', 4),
       ('Beach House', 'William Wilson', '180 sqm', 5);

update VacationRental
set BookingID=BookingID+5
where BookingID>0;
select * from VacationRental;
INSERT INTO Dependent (DependantName, Gender, DateOfBirth, Relationship, PersonID)
VALUES ('Emily Johnson', 'Female', '2010-04-15', 'Daughter', 1),
       ('Daniel Smith', 'Male', '2007-09-22', 'Son', 2),
       ('Olivia Davis', 'Female', '2004-12-10', 'Daughter', 3),
       ('Ethan Wilson', 'Male', '2012-07-08', 'Son', 4),
       ('Ava Thompson', 'Female', '2009-03-27', 'Daughter', 5);

INSERT INTO Dependent_Telephone (Telephone, DependantName, PersonID) VALUES
(1234567890, 'Emily Johnson', 1),
(1276543210, 'Daniel Smith', 2),
(1255555555, 'Olivia Davis', 3),
(1112223333, 'Ethan Wilson', 4),
(1298887777, 'Ava Thompson', 5);

INSERT INTO Restaurant_RestaurantPhone (RestaurantPhone, BookingID) VALUES
(1234567890, 16),
(1276543210, 17),
(1255555555, 18),
(1112223333, 19),
(1198887777, 20);

INSERT INTO TourGuide_Languages (Languages, PersonID) VALUES
('Mandarin', 1),
('Japanese', 2),
('Arabic', 3),
('Russian', 4),
('Portuguese', 5);

INSERT INTO Accommodation_Accommodation_Phone (Accommodation_Phone, BookingID) VALUES (1234567890, 1);
INSERT INTO Accommodation_Accommodation_Phone (Accommodation_Phone, BookingID) VALUES (1176543210, 2);
INSERT INTO Accommodation_Accommodation_Phone (Accommodation_Phone, BookingID) VALUES (1155555555, 3);
INSERT INTO Accommodation_Accommodation_Phone (Accommodation_Phone, BookingID) VALUES (1111111111, 4);
INSERT INTO Accommodation_Accommodation_Phone (Accommodation_Phone, BookingID) VALUES (1199999999, 5);

INSERT INTO Checks (PersonID, BookingID)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

INSERT INTO Coordinate (BookingID, PersonID)
VALUES
(21, 6),
(22, 7),
(23, 8),
(24, 9),
(25, 10);
INSERT INTO Support (SupportID, SupportStatus, DateOfRequest, SupportType, PersonID)
VALUES
  (1, 'Open', '2023-05-01', 'Technical', 1),
  (2, 'Closed', '2023-05-02', 'Billing', 6),
  (3, 'Open', '2023-05-03', 'General', 2),
  (4, 'Closed', '2023-05-04', 'Technical', 7),
  (5, 'Open', '2023-05-05', 'General', 8);

INSERT INTO Ask_for (PersonID, SupportID) VALUES (1, 1);
INSERT INTO Ask_for (PersonID, SupportID) VALUES (2, 2);
INSERT INTO Ask_for (PersonID, SupportID) VALUES (3, 3);
INSERT INTO Ask_for (PersonID, SupportID) VALUES (4, 4);
INSERT INTO Ask_for (PersonID, SupportID) VALUES (5, 5);

INSERT INTO proceed (Reviews, PersonID, BookingID) VALUES
('Great experience!', 1, 1),
('Highly recommended!', 2, 2),
('Average service.', 3, 3),
('Excellent support!', 4, 4),
('bad accommodation.', 5, 5);
