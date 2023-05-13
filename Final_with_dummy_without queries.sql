
create database travellism;
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
  Email VARCHAR(50) NOT NULL,
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
CREATE TABLE Cart
(
  CartStatus VARCHAR(20) ,
  CartID INT ,
  PaymentID INT ,
  PRIMARY KEY (CartID)
  
);
CREATE TABLE Payments
(
  PaymentID INT ,
  Amount FLOAT NOT NULL,
  PaymentStatus VARCHAR(20) NOT NULL,
  TransactionDate DATE NOT NULL,
  PersonID INT ,
  CartID Int not null,
  PRIMARY KEY (PaymentID),
  FOREIGN KEY (PersonID) REFERENCES Tourist(PersonID) on UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (CartID) REFERENCES Cart(CartID) on UPDATE CASCADE ON DELETE CASCADE
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
  Flightstatus varchar(40) NOT NULL,
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
CREATE TABLE Employee
(
  HiringDate DATE NOT NULL,
  Salary FLOAT NOT NULL,
  JobTitle VARCHAR(20) NOT NULL,
  PersonID INT ,
  DepID INT,
  managesDepID INT default NULL,
  Supervision_PersonID INT default NULL,
  PRIMARY KEY (PersonID),
  FOREIGN KEY (PersonID) REFERENCES Staff(PersonID) on UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (managesDepID) REFERENCES Department(DepID) on UPDATE CASCADE ON DELETE SET NULL,
  FOREIGN KEY (Supervision_PersonID) REFERENCES Employee(PersonID) on UPDATE CASCADE ON DELETE SET NULL
);

ALTER TABLE Department
ADD EmployeeID INT not null;
ALTER TABLE Department
ADD CONSTRAINT FK_Department_Employee
FOREIGN KEY (EmployeeID) REFERENCES Employee(PersonID) ON UPDATE CASCADE ON DELETE CASCADE;






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
  EmployeeID INT not null ,
  PRIMARY KEY (DependantName, EmployeeID),
  FOREIGN KEY (EmployeeID) REFERENCES Employee(PersonID) on UPDATE CASCADE ON DELETE CASCADE
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
tourist_personid int,
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
  EmployeeID INT ,
  PRIMARY KEY (Telephone, DependantName, EmployeeID),
  FOREIGN KEY (DependantName, EmployeeID) REFERENCES Dependent(DependantName, EmployeeID) on UPDATE CASCADE ON DELETE CASCADE
);


INSERT INTO Person (PersonID, DateOfBirth, Street, apartment_no, bulding_no, City, PostalCode, Communication_Preference, Gender, PassportNumber, Nationality, FirstName, MiddleName, LastName)
VALUES
  (1, '1990-01-01', 'Main Street', 101, 10, 'New York City', '12345', 'Email', 'Male', '123456', 'United States', 'John', 'A.', 'Doe'),
  (2, '1992-03-15', 'Oxford Street', 202, 20, ' London', '23456', 'Phone', 'Female', '987654', 'United Kingdom', 'Jane', '', 'Smith'),
  (3, '1988-07-20', 'La Rambla', 303, 30, ' Barcelona', '34567', 'SMS', 'Male', '246810', 'Spain', 'Robert', 'B.', 'Johnson'),
  (4, '1995-05-10', 'Via del Corso', 404, 40, 'Rome', '45678', 'Email', 'Female', '135792', 'Italy', 'Emily', 'C.', 'Williams'),
  (5, '1982-12-05', 'Rodeo Drive', 505, 50, 'Beverly Hills', '56789', 'Phone', 'Male', '246813', 'United States', 'Daniel', 'D.', 'Brown'),
  (6, '1991-09-25', 'Champs-Élysées', 606, 60, ' Paris', '67890', 'SMS', 'Female', '975318', 'France', 'Sophia', 'E.', 'Davis'),
  (7, '1987-06-15', 'Orchard Road', 707, 70, 'Singapore', '78901', 'Email', 'Male', '357159', 'Singapore', 'William', 'F.', 'Miller'),
  (8, '1994-04-30', 'Fifth Avenue', 808, 80, 'New York City', '89012', 'Phone', 'Female', '864209', 'United States', 'Olivia', 'G.', 'Taylor'),
  (9, '1983-11-20', 'Avenida Paulista', 909, 90, 'São Paulo', '90123', 'SMS', 'Male', '951357', ' Brazil', 'Michael', 'H.', 'Anderson'),
  (10, '1996-08-10', 'Myeong-dong', 1010, 100, ' Seoul', '01234', 'Email', 'Female', '123456', 'South Korea', 'Emma', 'I.', 'Johnson'),
  (11, '1989-05-25', 'Nevsky Prospect', 1111, 110, 'St. Petersburg', '12345', 'Phone', 'Male', '654321', 'Russia', 'Alexander', 'J.', 'Wilson'),
  (12, '1993-02-15', 'Shibuya Crossing', 1212, 120, 'Tokyo', '23456', 'SMS', 'Female', '987654', 'Japan', 'Abigail', 'K.', 'Martinez'),
  (13, '1997-06-05', 'Nanjing Road', 1414, 140, ' Shanghai', '34567', 'Email', 'Male', '23456', 'China', 'Isabella', 'L.', 'Garcia'),
  (14, '1984-01-30', 'Princes Street', 1515, 150, ' Edinburgh', '45678', 'Phone', 'Female', '987654', 'United Kingdom', 'Ethan', 'M.', 'Lee'),
  (15, '1991-10-15', 'Grafton Street', 1616, 160, 'Dublin', '56789', 'SMS', 'Male', '135792', 'Ireland', 'Mia', 'N.', 'Clark'),
  (16, '1988-07-01', 'Knez Mihailova Street', 1717, 170, 'Belgrade', '67890', 'Email', 'Female', '246813', ' Serbia', 'James', 'O.', 'Lopez'),
  (17, '1995-03-20', 'Istiklal Street', 1818, 180, ' Istanbul', '78901', 'Phone', 'Male', '975318', 'Turkey', 'Ava', 'P.', 'Harris'),
  (18, '1982-10-05', 'Karl Johans Gate', 1919, 190, ' Oslo', '89012', 'SMS', 'Female', '57159', 'Norway', 'Benjamin', 'Q.', 'Young'),
  (19, '1989-07-15', 'Avenyn', 2020, 200, 'Gothenburg', '90123', 'Email', 'Male', '864209', 'Sweden', 'Charlotte', 'R.', 'Allen');
  

INSERT INTO Account (AccountID, AccountPassword, Email, AccountStatus, AccountRole, Username, AccountType, PersonID)
VALUES
  (1, 'password1', 'email1@example.com', 'Active', 'Tourist', 'user1', 'Premium', 1),
  (2, 'password2', 'email2@example.com', 'Active', 'Employee', 'user2', 'Standard', 2),
  (3, 'password3', 'email3@example.com', 'Active', 'Tourguide', 'user3', 'Standard', 3),
  (4, 'password4', 'email4@example.com', 'Active', 'Tourist', 'user4', 'Premium', 4),
  (5, 'password5', 'email5@example.com', 'Inactive', 'Employee', 'user5', 'Standard', 5),
  (6, 'password6', 'email6@example.com', 'Active', 'Tourguide', 'user6', 'Standard', 6),
  (7, 'password7', 'email7@example.com', 'Active', 'Tourist', 'user7', 'Premium', 7);

INSERT INTO Account (AccountID, AccountPassword, Email, Accountstatus, AccountRole, Username, AccountType, PersonID)
VALUES
  (8, 'pass123', 'example1@example.com', 'Active', 'Tourist', 'user1', 'Standard', 8),
  (9, 'pass456', 'example2@example.com', 'Active', 'Employee', 'user2', 'Standard', 9),
  (10, 'pass789', 'example3@example.com', 'Active', 'Tourist', 'user3', 'Premium', 10),
  (11, 'passabc', 'example4@example.com', 'Inactive', 'Tourist', 'admin1', 'Premium', 11),
  (12, 'passdef', 'example5@example.com', 'Active', 'Tourguide', 'user5', 'Standard', 12),
  (13, 'passghi', 'example6@example.com', 'Active', 'Tourguide', 'user6', 'Standard', 13),
  (14, 'passjkl', 'example7@example.com', 'Inactive', 'Tourguide', 'user7', 'Standard', 14),
  (15, 'passmno', 'example8@example.com', 'Active', 'Employee', 'user8', 'Standard', 15),
  (16, 'passpqr', 'example9@example.com', 'Active', 'Employee', 'user9', 'Premium', 16),
  (17, 'passtu', 'example10@example.com', 'Active', 'Tourist', 'user10', 'Premium', 17);

INSERT INTO Embassy (EmbassyName, Street, City, EmbassyWorkingHours, EmbassyWebsite, EmbassyEmail)
VALUES
  ('Embassy of the United States of America', 'Pariser Platz 2', 'Berlin', '9 AM - 5 PM', ' www.de.usembassy.gov', 'berlinvisa@state.gov'),
  ('Embassy of France in the United States', ' 4101 Reservoir Road NW', 'Washington', '8 AM - 4 PM', 'www.franceintheus.org', 'info@ambafrance-us.org'),
  ('Embassy of Canada', '501 Pennsylvania Avenue NW', 'Washington', '10 AM - 6 PM', 'www.canada.ca', 'wshdc@international.gc.ca'),
  ('Embassy of Japan', '2520 Massachusetts Avenue NW', 'Washington', '9 AM - 5 PM', 'www.us.emb-japan.go.jp', 'info@embjapan.org'),
  ('Embassy of Australia', 'Jalan H.R. Rasuna Said Kav C15-16', 'Jakarta Selatan', '8:30 AM - 4:30 PM', 'www.indonesia.embassy.gov.au/jakt', 'jakarta.info@dfat.gov.au'),
  ('Embassy of Brazil in Spain', 'Calle de Lagasca', 'Madrid', '9 AM - 5 PM', ' madri.itamaraty.gov.br/es/', 'secomadri@itamaraty.gov.br'),
  ('Embassy of Australia in Germany', 'Wallstraße 76-79', 'Berlin', '8:30 AM - 4:30 PM', 'germany.embassy.gov.au/', 'berlin.embassy@dfat.gov.au'),
  ('Embassy of South Africa in France', '59 Quai dOrsay', 'Paris', '9 AM - 5 PM', 'www.afriquesud.net/paris/', 'info.paris@dirco.gov.za');

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
  (111111, 'Embassy of the United States of America'),
  (222222, 'Embassy of France in the United States'),
  (333333, 'Embassy of Canada'),
  (444444, 'Embassy of Japan'),
  (555555, 'Embassy of Australia');

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
  
  INSERT INTO Staff (StaffID, Performance_Rating , HiringDate, YearsOf_Experience , PersonID)
VALUES
  (11, 4.2, '2022-01-15', 5, 11),
  (12, 3.8, '2021-05-10', 3, 12),
  (13, 4.5, '2023-02-28', 8, 13),
  (14, 3.2, '2020-12-01', 2, 14),
  (15, 4.0, '2022-08-17', 6, 15),
  (16, 4.8, '2021-11-02', 4, 16),
  (17, 3.9, '2023-03-20', 7, 17),
  (18, 4.1, '2022-06-05', 5, 18),
  (19, 4.6, '2021-09-12', 9, 19);

INSERT INTO TourGuide (TourGuideStatus, HourlyPay, AvailabilityTime, AvailabilityDate, PersonID)
VALUES
  ('Active', 25.5, '09:00:00', '2023-05-15', 1),
  ('Active', 22.75, '10:30:00', '2023-05-16', 2),
  ('Inactive', 20.0, '14:00:00', '2023-05-17', 3),
  ('Active', 26.0, '11:15:00', '2023-05-18', 4),
  ('Active', 24.5, '13:45:00', '2023-05-19', 5);

INSERT INTO Tourist (TravelStyle, Wishlist, PersonID, EmbassyName)
VALUES
  ('Adventure', 'Hiking', 1, 'Embassy of the United States of America'),
  ('Relaxation', NULL, 2, 'Embassy of France in the United States'),
  ('Cultural', 'Museums', 3, NULL),
  ('Beach', 'Snorkeling', 4, 'Embassy of Canada'),
  ('Sightseeing', 'Landmarks', 5, 'Embassy of Japan');

INSERT INTO Cart (CartStatus, CartID, PaymentID)
VALUES
  ('Active', 1, 1),
  ('Active', 2, 2),
  ('Inactive', 3, 3),
  ('Active', 4, 4),
  ('Active', 5, 5),
  ('Inactive', 6, 6),
  ('Active', 7, 7);

INSERT INTO Payments (PaymentID, Amount, PaymentStatus, TransactionDate, PersonID,CartID)
VALUES
  (1, 100.0, 'Paid', '2023-05-01', 1,1),
  (2, 75.5, 'Paid', '2023-05-02', 2,2),
  (3, 50.0, 'Pending', '2023-05-03', 3,3),
  (4, 120.0, 'Paid', '2023-05-04', 4,4),
  (5, 90.25, 'Paid', '2023-05-05', 5,5),
  (6, 80.0, 'Pending', '2023-05-06', 2,6),
  (7, 60.75, 'Paid', '2023-05-07', 4,7),
  (8, 110.0, 'Paid', '2023-05-08', 1,5);
INSERT INTO Booking (cancellation_Reason, BookingPrice, BookingDate, BookingStatus, cancellationDate, BookingID, cancellationFees, Rating, CartID)
VALUES
  (NULL, 150.0, '2023-05-01', 'Confirmed', Null, 1, 0.0, 4.5, 1),
  ('Change of plans', 200.0, '2023-05-02', 'Cancelled', '2023-05-13', 2, 20.0, NULL, 2),
  (NULL, 120.0, '2023-05-03', 'Confirmed', NULL, 3, 0.0, 3.8, 3),
  ('Not satisfied', 180.0, '2023-05-04', 'Cancelled', '2023-05-07', 4, 15.0, NULL, 1),
  (NULL, 90.0, '2023-05-05', 'Confirmed', NULL, 5, 0.0, 4.2, 2),
  ('Emergency', 250.0, '2023-05-01', 'Cancelled', '2023-05-03', 6, 30.0, NULL, 3),
  (NULL, 200.0, '2023-05-07', 'Confirmed', NULL, 7, 0.0, 4.9, 1);

INSERT INTO cash (CurrencyType, PaymentID)
VALUES
  ('USD', 1),
  ('EUR', 2),
  ('GBP', 3),
  ('CAD',4),
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
  (123456789, '2024-12-01', 'John Doe', 123, 1),
  (987654321, '2025-06-01', 'Jane Smith', 456, 2),
  (456789012, '2023-09-01', 'Mike Johnson', 789, 3),
  (567890123, '2024-03-01', 'Sarah Williams', 234, 4),
  (901234567, '2025-11-01', 'David Brown', 567, 5);
  
  INSERT INTO Booking (cancellation_Reason, BookingPrice, BookingDate, BookingStatus, cancellationDate, BookingID, cancellationFees, Rating, CartID)
VALUES
  ('Change of plans', 250.00, '2023-05-01', 'Cancelled', '2023-05-03', 8, 0, NULL, 1),
  (NULL, 180.00, '2023-05-02', 'Confirmed', NULL, 9, 0, 5, 2),
  (NULL, 300.00, '2023-05-03', 'Confirmed', NULL, 10, 0, 4, 3),
  ('bad weather', 150.00, '2023-05-06', 'Cancelled', '2023-05-08', 11, 50.00, NULL, 4),
  (NULL, 200.00, '2023-05-05', 'Confirmed', NULL, 12, 0, 4.5, 4);


  
  INSERT INTO Booking (cancellation_Reason, BookingPrice, BookingDate, BookingStatus, cancellationDate, BookingID, cancellationFees, Rating, CartID)
VALUES
  (NULL, 150.00, '2023-05-15', 'Confirmed', NULL, 23, 0, 5, 1),
  ('Change of plans', 200.00, '2023-04-16', 'Cancelled','2023-04-18', 24, 0, NULL, 2),
  (NULL, 100.00, '2023-05-17', 'Confirmed', NULL, 25, 0, 4.6, 3),
  (NULL, 180.00, '2023-05-18', 'Confirmed', NULL, 26, 0, 3.8, 4),
  ('Weather conditions', 120.00, '2023-05-10', 'Cancelled', '2023-05-11', 27, 0, NULL, 5),
  (NULL, 90.00, '2023-05-20', 'Confirmed', NULL, 28, 0, 3.6, 5),
  (NULL, 160.00, '2023-05-21', 'Confirmed', NULL, 29, 0, 5, 4),
  (NULL, 140.00, '2023-05-22', 'Confirmed', NULL, 30, 0, 4.8, 3),
  ('Schedule conflict', 250.00, '2023-03-23', 'Cancelled', '2023-03-25', 31, 0, NULL, 2),
  (NULL, 110.00, '2023-05-24', 'Confirmed', NULL, 32, 0, 4.9, 1);


  INSERT INTO Accommodation (NumRoom, AccommodationStatus, apartment_no , bulding_no , Street, City, PostalCode, BookingID)
VALUES
  (2, 'Booked', 101, 1, 'Main Street', 'New York City', 12345, 1),
  (3, 'Available', 202, 2, 'Broadway', ' New York City', 67890, 2),
  (1, 'Booked', 303, 3, 'Champs-Élysées', 'Paris', 54321, 3),
  (2, 'Available', 404, 4, 'Orchard Road', 'Singapore', 98765, 4),
  (4, 'Booked', 505, 5, 'Lombard Street', ' San Francisco', 13579, 5),
  (1, 'Available', 606, 6, 'Rodeo Drive', 'Beverly Hills', 24680, 6),
  (3, 'Booked', 707, 7, 'OConnell Street', 'Dublin', 90876, 7),
  (2, 'Available', 808, 8, 'Abbey Road', 'London', 64203, 8),
  (1, 'Booked', 909, 9, 'Nevsky Prospect', 'St. Petersburg', 47628, 9),
  (4, 'Available', 1010, 10, 'La Rambla', 'La Rambla', 31459, 10);

INSERT INTO CarRental (CarType, License, Driver, BookingID)
VALUES
  ('Sedan', 'ABC123', 1, 1),
  ('SUV', 'DEF456', 0, 2),
  ('Compact', 'GHI789', 1, 3),
  ('Van', 'JKL012', 1, 4),
  ('Convertible', 'MNO345', 0, 5);
  
  INSERT INTO Restaurant (RestaurantName, Cuisine, Street, City, BookingID)
VALUES
  ('Italian Delights', 'Italian', 'Main Street', 'New York', 6),
  ('Sushi Paradise', 'Japanese', 'Central Avenue', 'Tokyo', 7),
  ('Spice Kingdom', 'Indian', 'Street 4', 'Mumbai', 8),
  ('Mexican Fiesta', 'Mexican', 'Sunset Boulevard', 'Los Angeles', 9),
  ('French Bistro', 'French', 'Rue de la Paix', 'Paris', 10);

INSERT INTO Entertainment_Options (Entertainment_OptionsLocation, TicketPrice, Website, Entertainment_OptionsName, AvailabilityDate, Category, AgeRange, BookingID, PersonID)
VALUES
  ('Amusement Park', 50.00, 'www.amuse.com', 'Funland', '2023-05-15', 'Outdoor', 'All Ages', 1, NULL),
  ('Concert Hall', 80.00, 'www.concerthall.com', 'Symphony Night', '2023-05-20', 'Music', '18+', 2, NULL),
  ('Movie Theater', 12.50, 'www.movie.com', 'Blockbuster Cinema', '2023-05-18', 'Movies', 'All Ages', 3, NULL),
  ('Museum', 15.00, 'www.museum.com', 'Art Gallery', '2023-05-17', 'Art', 'All Ages', 4, NULL),
  ('Zoo', 20.00, 'www.zoo.com', 'Wildlife Adventure', '2023-05-16', 'Nature', 'All Ages', 5, NULL);


INSERT INTO flight (Baggage_Allowance, ArrivalTime, DepartureTime, ArrivalDate, FlightStatus, DepartureCity, Airline, DepartureDate, Class, ArrivalCity, SeatNo, BookingID)
VALUES
  (23.5, '12:30:00', '10:00:00', '2023-05-25', 'On Time', 'New York', 'ABC Airlines', '2023-05-25', 'Business', 'London', 15, 10),
  (18.0, '08:45:00', '06:15:00', '2023-05-26', 'Delayed', 'Paris', 'XYZ Airways', '2023-05-26', 'Economy', 'Rome', 28, 11),
  (20.0, '15:20:00', '13:00:00', '2023-05-27', 'On Time', 'Tokyo', 'DEF Airlines', '2023-05-27', 'First Class', 'Sydney', 7, 12),
  (25.5, '09:10:00', '07:30:00', '2023-05-28', 'On Time', 'Chicago', 'GHI Airways', '2023-05-28', 'Economy', 'Dubai', 12, 1),
  (30.0, '16:45:00', '14:15:00', '2023-05-29', 'On Time', 'Los Angeles', 'JKL Airlines', '2023-05-29', 'Business', 'Mumbai', 33, 3);





INSERT INTO Employee (HiringDate, Salary, JobTitle, PersonID, DepID, managesDepID, Supervision_PersonID)
VALUES
('2022-01-01', 5000, 'Manager', 6, null, NULL, 6),
 ('2022-02-01', 4000, 'Sales Representative', 7, null, NULL, 6),
  ('2022-03-01', 4500, 'Marketing Coord', 8, null, NULL, 7),
 ('2022-04-01', 5500, 'Financial Analyst', 9, null, NULL, 8),
 ('2022-05-01', 6000, 'HR Manager', 10, null, NULL, 9),
  ('2022-06-01', 5500, 'IT Specialist', 1, null, NULL, 10),
 ('2022-07-01', 4000, 'Operations Assistant', 2, null, NULL, 10),
  ('2022-08-01', 4200, 'Research Associate', 3, null, NULL, 7),
  ('2022-09-01', 3800, 'Customer Service', 4, null, NULL,9),
  ('2022-10-01', 5000, 'Supervisor', 5, null, null, 6);
  

  INSERT INTO Department (DepID, DepName,EmployeeID)
VALUES
  (1, 'Sales',1),
  (2, 'Marketing',7),
  (3, 'Finance',2),
  (4, 'Human Resources',3),
  (5, 'IT',6),
  (6, 'Operations',4),
  (7, 'Research',5),
  (8, 'Customer Service',2),
  (9, 'Production',7),
  (10, 'Quality Assurance',6);
  INSERT INTO Employee (HiringDate, Salary, JobTitle, PersonID, DepID, managesDepID, Supervision_PersonID)
VALUES
('2022-01-01', 5000, 'Manager', 11, 1, 6, 6),
 ('2022-02-01', 4000, 'Sales Representative', 12, 1, 6, 6),
  ('2022-03-01', 4500, 'Marketing Coord', 13, 2, 7, 7),
 ('2022-04-01', 5500, 'Financial Analyst', 14, 2, 8, 8),
 ('2022-05-01', 6000, 'HR Manager', 15, 3, 9, 9),
  ('2022-06-01', 5500, 'IT Specialist', 16, 5, 10, 10),
 ('2022-07-01', 4000, 'Operations Assistant', 17, 6, 1, 10),
  ('2022-08-01', 4200, 'Research Associate', 18, 9, 2, 7),
  ('2022-09-01', 3800, 'Customer Service', 19, 8, 3,9);
  select * from person;

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
INSERT INTO Dependent (DependantName, Gender, DateOfBirth, Relationship, EmployeeID)
VALUES ('Emily Johnson', 'Female', '2010-04-15', 'Daughter', 1),
       ('Daniel Smith', 'Male', '2007-09-22', 'Son', 2),
       ('Olivia Davis', 'Female', '2004-12-10', 'Daughter', 3),
       ('Ethan Wilson', 'Male', '2012-07-08', 'Son', 4),
       ('Ava Thompson', 'Female', '2009-03-27', 'Daughter', 5);

INSERT INTO Dependent_Telephone (Telephone, DependantName, EmployeeID) VALUES
(1234567890, 'Emily Johnson', 1),
(1276543210, 'Daniel Smith', 2),
(1255555555, 'Olivia Davis', 3),
(1112223333, 'Ethan Wilson', 4),
(1298887777, 'Ava Thompson', 5);

INSERT INTO Restaurant_RestaurantPhone (RestaurantPhone, BookingID) VALUES
(1234567890, 6),
(1276543210, 7),
(1255555555, 8),
(1112223333, 9),
(1198887777, 10);

INSERT INTO TourGuide_Languages (Languages, PersonID) VALUES
('Mandarin', 1),
('Japanese', 2),
('Arabic', 3),
('Russian', 4),
('Portuguese', 5);

INSERT INTO Accommodation_Accommodation_Phone (Accommodation_Phone, BookingID) VALUES ('1234567890', 7);
INSERT INTO Accommodation_Accommodation_Phone (Accommodation_Phone, BookingID) VALUES ('1176543210', 2);
INSERT INTO Accommodation_Accommodation_Phone (Accommodation_Phone, BookingID) VALUES ('1155555555', 3);
INSERT INTO Accommodation_Accommodation_Phone (Accommodation_Phone, BookingID) VALUES ('1111111111', 4);
INSERT INTO Accommodation_Accommodation_Phone (Accommodation_Phone, BookingID) VALUES ('1199999999', 5);

INSERT INTO Checks (PersonID, BookingID)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

INSERT INTO Coordinate (BookingID, PersonID)
VALUES
(1, 6),
(2, 7),
(3, 8),
(4, 9),
(5, 10);

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
('bad accommodation', 5, 5);


SHOW TABLES;
DESCRIBE Account;
select * from Account;
select * from Embassy;
select * from person_personphone;
select * from Embassy_Embassyphone;
select * from Staff;
select * from TourGuide;
select * from Tourist;
select * from Cart;
select * from Booking;
select * from paypal;
select * from Accommodation;
select * from CarRental;
select * from Restaurant;
select * from Entertainment_Options;
select * from flight;
select * from Department;


select * from Payments;
select * from cash;
select * from visa;
select * from Booking;
select * from Person;




select *
from employee as E,department as D
where E.DepID=D.DepID and
		D.DepName='Production';

SELECT Salary, HiringDate, DepName
FROM employee, department
WHERE department.DepID=employee.DepID and
Salary > 4000 AND HiringDate BETWEEN '2022-01-01' AND '2022-06-30'
ORDER BY HiringDate;

 
 update Booking
 set cancellationFees = 1.2*cancellationFees
 where cancellation_Reason is null
 
 
