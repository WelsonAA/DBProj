CREATE TABLE Person
(
  PersonID INT NOT NULL,
  DateOfBirth DATE NOT NULL,
  street VARCHAR NOT NULL,
  apartment_no INT NOT NULL,
  bulding_no INT NOT NULL,
  City VARCHAR NOT NULL,
  PostalCode INT NOT NULL,
  Communication_Preference VARCHAR NOT NULL,
  Gender VARCHAR NOT NULL,
  _PassportNumber INT NOT NULL,
  Nationality VARCHAR NOT NULL,
  FirstName VARCHAR NOT NULL,
  MiddleName VARCHAR NOT NULL,
  LastName VARCHAR NOT NULL,
  PRIMARY KEY (PersonID)
);

CREATE TABLE Account
(
  AccountID INT NOT NULL,
  _AccountPassword VARCHAR NOT NULL,
  Email VARCHAR NOT NULL,
  Accountstatus VARCHAR NOT NULL,
  AccountRole VARCHAR NOT NULL,
  Username VARCHAR NOT NULL,
  _AccountType VARCHAR NOT NULL,
  PersonID INT NOT NULL,
  PRIMARY KEY (AccountID),
  FOREIGN KEY (PersonID) REFERENCES Person(PersonID)
);

CREATE TABLE Embassy
(
  EmbassyName VARCHAR NOT NULL,
  street VARCHAR NOT NULL,
  city VARCHAR NOT NULL,
  _EmbassyWorkingHours VARCHAR NOT NULL,
  EmbassyWebsite VARCHAR NOT NULL,
  EmbassyEmail VARCHAR NOT NULL,
  PRIMARY KEY (EmbassyName)
);

CREATE TABLE Person_PersonPhone
(
  PersonPhone INT NOT NULL,
  PersonID INT NOT NULL,
  PRIMARY KEY (PersonPhone, PersonID),
  FOREIGN KEY (PersonID) REFERENCES Person(PersonID)
);

CREATE TABLE Embassy_EmbassyPhone
(
  EmbassyPhone INT NOT NULL,
  EmbassyName VARCHAR NOT NULL,
  PRIMARY KEY (EmbassyPhone, EmbassyName),
  FOREIGN KEY (EmbassyName) REFERENCES Embassy(EmbassyName)
);

CREATE TABLE Staff
(
  _StaffID INT NOT NULL,
  _Performance_Rating FLOAT NOT NULL,
  _HiringDate DATE NOT NULL,
  YearsOf_Experience INT NOT NULL,
  PersonID INT NOT NULL,
  PRIMARY KEY (PersonID),
  FOREIGN KEY (PersonID) REFERENCES Person(PersonID),
  /*FOREIGN KEY (PersonID) REFERENCES Tourist(PersonID)*/
);
CREATE TABLE TourGuide
(
  TourGuideStatus VARCHAR NOT NULL,
  _HourlyPay FLOAT NOT NULL,
  AvailabilityTime time NOT NULL,
  AvailabilityDate DATE NOT NULL,
  PersonID INT NOT NULL,
  PRIMARY KEY (PersonID),
  FOREIGN KEY (PersonID) REFERENCES Staff(PersonID)
);
CREATE TABLE Tourist
(
  TravelStyle VARCHAR NOT NULL,
  Wishlist VARCHAR NOT NULL,
  PersonID INT NOT NULL,
  EmbassyName VARCHAR NOT NULL,
  requestsPersonID INT NOT NULL,
  PRIMARY KEY (PersonID),
  FOREIGN KEY (PersonID) REFERENCES Person(PersonID),
  FOREIGN KEY (EmbassyName) REFERENCES Embassy(EmbassyName),
  FOREIGN KEY (PersonID) REFERENCES TourGuide(PersonID),
  FOREIGN KEY (requestsPersonID) REFERENCES TourGuide(PersonID)
);
CREATE TABLE Payments
(
  PaymentID INT NOT NULL,
  Amount FLOAT NOT NULL,
  PaymentStatus VARCHAR NOT NULL,
  TransactionDate DATE NOT NULL,
  PersonID INT NOT NULL,
  PRIMARY KEY (PaymentID),
  FOREIGN KEY (PersonID) REFERENCES Tourist(PersonID)
);

CREATE TABLE Cart
(
  CartStatus VARCHAR NOT NULL,
  CartID INT NOT NULL,
  PaymentID INT NOT NULL,
  PRIMARY KEY (CartID),
  FOREIGN KEY (PaymentID) REFERENCES Payments(PaymentID)
);
CREATE TABLE Booking
(
  cancellation_Reason VARCHAR,
  BookingPrice FLOAT NOT NULL,
  BookingDate DATE NOT NULL,
  BookingStatus VARCHAR NOT NULL,
  cancellationDate DATE NOT NULL,
  BookingID INT NOT NULL,
  _cancellationFees FLOAT NOT NULL,
  Rating FLOAT,
  CartID INT NOT NULL,
  PRIMARY KEY (BookingID),
  FOREIGN KEY (CartID) REFERENCES Cart(CartID)
);




CREATE TABLE cash
(
  CurrencyType VARCHAR NOT NULL,
  PaymentID INT NOT NULL,
  PRIMARY KEY (PaymentID),
  FOREIGN KEY (PaymentID) REFERENCES Payments(PaymentID)
);

CREATE TABLE Paypal
(
  Email VARCHAR NOT NULL,
  PaypalPassword_ VARCHAR NOT NULL,
  PaymentID INT NOT NULL,
  PRIMARY KEY (PaymentID),
  FOREIGN KEY (PaymentID) REFERENCES Payments(PaymentID)
);

CREATE TABLE Visa
(
  CardNumber INT NOT NULL,
  ExpirationDate DATE NOT NULL,
  CardHolderName VARCHAR NOT NULL,
  SecurityCode INT NOT NULL,
  PaymentID INT NOT NULL,
  PRIMARY KEY (PaymentID),
  FOREIGN KEY (PaymentID) REFERENCES Payments(PaymentID)
);

CREATE TABLE Accommodation
(
  NumRoom INT NOT NULL,
  Accommodation_Status VARCHAR NOT NULL,
  apartment_no INT NOT NULL,
  bulding_no INT NOT NULL,
  street VARCHAR NOT NULL,
  City VARCHAR NOT NULL,
  PostalCode INT NOT NULL,
  BookingID INT NOT NULL,
  PRIMARY KEY (BookingID),
  FOREIGN KEY (BookingID) REFERENCES Booking(BookingID)
);

CREATE TABLE CarRental
(
  CarType VARCHAR NOT NULL,
  _License VARCHAR NOT NULL,
  _Driver bit NOT NULL,
  BookingID INT NOT NULL,
  PRIMARY KEY (BookingID),
  FOREIGN KEY (BookingID) REFERENCES Booking(BookingID)
);

CREATE TABLE Restaurant
(
  RestaurantName VARCHAR NOT NULL,
  _Cuisine VARCHAR NOT NULL,
  street VARCHAR NOT NULL,
  City VARCHAR NOT NULL,
  BookingID INT NOT NULL,
  PRIMARY KEY (BookingID),
  FOREIGN KEY (BookingID) REFERENCES Booking(BookingID)
);

CREATE TABLE Entertainment_Options
(
  Entertainment_OptionsLocation VARCHAR NOT NULL,
  _TicketPrice FLOAT NOT NULL,
  Website VARCHAR NOT NULL,
  Entertainment_OptionsName VARCHAR NOT NULL,
  AvailabilityDate DATE NOT NULL,
  Category VARCHAR NOT NULL,
  _AgeRange VARCHAR NOT NULL,
  BookingID INT NOT NULL,
  PersonID INT NOT NULL,
  PRIMARY KEY (BookingID),
  FOREIGN KEY (BookingID) REFERENCES Booking(BookingID) 
  on delete CASCADE 
  on update CASCADE,
  FOREIGN KEY (PersonID) REFERENCES TourGuide(PersonID)
  ON DELETE CASCADE ON UPDATE CASCADE
  
  
);

CREATE TABLE flight
(
  Baggage_Allowance float  NOT NULL,
  ArrivalTime time NOT NULL,
  DepartureTime time NOT NULL,
  ArrivalDate DATE NOT NULL,
  Flightstatus DATE NOT NULL,
  DepartureCity_ VARCHAR NOT NULL,
  Airline VARCHAR NOT NULL,
  DepartureDate DATE NOT NULL,
  Class VARCHAR NOT NULL,
  ArrivalCity VARCHAR NOT NULL,
  _SeatNo INT NOT NULL,
  BookingID INT NOT NULL,
  PRIMARY KEY (BookingID),
  FOREIGN KEY (BookingID) REFERENCES Booking(BookingID)
);
CREATE TABLE Department
(
  DepID INT NOT NULL,
  DepName VARCHAR NOT NULL,
  PRIMARY KEY (DepID)
);
CREATE TABLE Employee
(
  HiringDate DATE NOT NULL,
  _Salary FLOAT NOT NULL,
  JobTitle VARCHAR NOT NULL,
  PersonID INT NOT NULL,
  DepID INT NOT NULL,
  managesDepID INT NOT NULL,
  Supervision_PersonID INT NOT NULL,
  PRIMARY KEY (PersonID),
  FOREIGN KEY (PersonID) REFERENCES Staff(PersonID),
  FOREIGN KEY (DepID) REFERENCES Department(DepID),
  FOREIGN KEY (managesDepID) REFERENCES Department(DepID),
  FOREIGN KEY (Supervision_PersonID) REFERENCES Employee(PersonID)
);









CREATE TABLE Hotel
(
  _Style_ VARCHAR NOT NULL,
  FoodOptions VARCHAR NOT NULL,
  HotelServices_ VARCHAR NOT NULL,
  RoomType VARCHAR NOT NULL,
  BookingID INT NOT NULL,
  PRIMARY KEY (BookingID),
  FOREIGN KEY (BookingID) REFERENCES Accommodation(BookingID)
);

CREATE TABLE VacationRental
(
  PropertyType_ VARCHAR NOT NULL,
  _HostName VARCHAR NOT NULL,
  PropertySize_ VARCHAR NOT NULL,
  BookingID INT NOT NULL,
  PRIMARY KEY (BookingID),
  FOREIGN KEY (BookingID) REFERENCES Accommodation(BookingID)
);

CREATE TABLE Dependent
(
  DependantName VARCHAR NOT NULL,
  __Gender_ VARCHAR NOT NULL,
  _DateOfBirth DATE NOT NULL,
  Relationship VARCHAR NOT NULL,
  PersonID INT NOT NULL,
  PRIMARY KEY (DependantName, PersonID),
  FOREIGN KEY (PersonID) REFERENCES Employee(PersonID)
);

CREATE TABLE Support
(
  _SupportID INT NOT NULL,
  SupportStatus VARCHAR NOT NULL,
  DateOfRequest DATE NOT NULL,
  SupportType VARCHAR NOT NULL,
  PersonID INT NOT NULL,
  PRIMARY KEY (_SupportID),
  FOREIGN KEY (PersonID) REFERENCES Employee(PersonID)
);

CREATE TABLE proceed
(
  Reviews VARCHAR NOT NULL,
  PersonID INT NOT NULL,
  BookingID INT NOT NULL,
  PRIMARY KEY (PersonID, BookingID),
  FOREIGN KEY (PersonID) REFERENCES Tourist(PersonID),
  FOREIGN KEY (BookingID) REFERENCES Booking(BookingID)
);

CREATE TABLE Ask_for
(
  PersonID INT NOT NULL,
  _SupportID INT NOT NULL,
  PRIMARY KEY (PersonID, _SupportID),
  FOREIGN KEY (PersonID) REFERENCES Tourist(PersonID),
  FOREIGN KEY (_SupportID) REFERENCES Support(_SupportID)
);

CREATE TABLE Coordinate
(
  BookingID INT NOT NULL,
  PersonID INT NOT NULL,
  PRIMARY KEY (BookingID, PersonID),
  FOREIGN KEY (BookingID) REFERENCES Entertainment_Options(BookingID)
  on delete cascade on update cascade,
  FOREIGN KEY (PersonID) REFERENCES Staff(PersonID)
);

CREATE TABLE Checks
(
  PersonID INT NOT NULL,
  BookingID INT NOT NULL,
  PRIMARY KEY (PersonID, BookingID),
  FOREIGN KEY (PersonID) REFERENCES Employee(PersonID),
  FOREIGN KEY (BookingID) REFERENCES Booking(BookingID)
);

CREATE TABLE Accommodation_Accommodation_Phone
(
  Accommodation_Phone INT NOT NULL,
  BookingID INT NOT NULL,
  PRIMARY KEY (Accommodation_Phone, BookingID),
  FOREIGN KEY (BookingID) REFERENCES Accommodation(BookingID)
);

CREATE TABLE Restaurant_RestaurantPhone
(
  RestaurantPhone INT NOT NULL,
  BookingID INT NOT NULL,
  PRIMARY KEY (RestaurantPhone, BookingID),
  FOREIGN KEY (BookingID) REFERENCES Restaurant(BookingID)
);

CREATE TABLE TourGuide_Languages
(
  Languages VARCHAR NOT NULL,
  PersonID INT NOT NULL,
  PRIMARY KEY (Languages, PersonID),
  FOREIGN KEY (PersonID) REFERENCES TourGuide(PersonID)
);

CREATE TABLE Dependent_Telephone
(
  Telephone INT NOT NULL,
  DependantName VARCHAR NOT NULL,
  PersonID INT NOT NULL,
  PRIMARY KEY (Telephone, DependantName, PersonID),
  FOREIGN KEY (DependantName, PersonID) REFERENCES Dependent(DependantName, PersonID)
);
