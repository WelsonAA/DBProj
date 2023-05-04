use TRAVELLISM; 
go
create schema TRAVELLISM_schema;


CREATE TABLE Person (
    PersonID INT,
    FirstName VARCHAR(50),
    MiddleName VARCHAR(50),
    LastName VARCHAR(50),
    DateOfBirth DATE,
    Gender CHAR(1),
	PersonPhone VARCHAR(50),
    street VARCHAR(50),
    apartment_no VARCHAR(50),
	bulding_no VARCHAR(50),
    City VARCHAR(50),
    State VARCHAR(50),
    Country VARCHAR(50),
    PostalCode VARCHAR(20),
    PassportNumber VARCHAR(50),
    Nationality VARCHAR(50),
    CommunicationPreference VARCHAR(20)
	constraint passport_UQ unique(PassportNumber),
	constraint Ppersonid_PK primary key ( PersonID)
);


CREATE TABLE Staff (
    StaffID INT,
    PerformanceRating FLOAT,
    HiringDate DATE,
    YearsOfExperience INT,
	CONSTRAINT StaffId_pk PRIMARY KEY (StaffID)

);


CREATE TABLE Embassy (
    EmbassyName VARCHAR(100),
    EmbassyPhone VARCHAR(20),
    EmbassyEmail VARCHAR(100),
    EmbassyWebsite VARCHAR(100),
    EmbassyWorkingHours VARCHAR(100)
	constraint embassyname_PK primary key (EmbassyName),
	constraint embassyemail_UQ unique(EmbassyEmail),
);



CREATE TABLE Department (
    DepID INT ,
    Name VARCHAR(200),
    ManagerID INT,
	constraint depid_PK primary key (DepID),
	constraint ManagerID_FK foreign key (ManagerID) references Employee (PersonID),

);

CREATE TABLE TourGuide (
	PersonID int,
    HourlyPay DECIMAL(10, 2),
    TourGuideStatus VARCHAR(20),
    Languages VARCHAR(200),
    AvailabilityDate DATE,
    AvailabilityTime TIME,
    YearsOfExperience INT,
	StaffID INT,
   constraint TGpersonid_FK foreign key (PersonID) references Person (PersonID),
   constraint TGstaffId_FK foreign key (StaffID) references Staff (StaffID),

   constraint TGpersonid_PK primary key (PersonID)

);

CREATE TABLE Tourist (
	PersonID int,
    TravelStyle VARCHAR(200),
    Wishlist VARCHAR(500),
	TourGuideID INT ,
	EmbassyName VARCHAR(200),

    constraint TpersonID_PK primary key (PersonID),
	constraint TpersonID_FK foreign key (PersonID) references Person (PersonID),
	constraint TtourGuide_FK foreign key (TourGuideID) references Person (PersonID),
	constraint TEmbassyName_FK foreign key (EmbassyName) references Embassy (EmbassyName),

);

CREATE TABLE Employee (
	DepID int,
	PersonID int,
    HiringDate DATE,
    JobTitle VARCHAR(100),
    Salary DECIMAL(10, 2),
    ManagerID INT,
	StaffID INT,

	constraint EPersonID_PK primary key (PersonID),
    constraint EpersonID_FK foreign key (PersonID) references Person (PersonID),
	constraint manager_FK foreign key (ManagerID) references Employee (PersonID),
	constraint depid_FK foreign key (DepID) references Department (DepID),
	constraint EstaffId_FK foreign key (StaffID) references Staff (StaffID),

);



CREATE TABLE Account (
    AccountID INT ,
    AccountPassword VARCHAR(50),
	TouristID int ,
    Email VARCHAR(100),
    Username VARCHAR(50),
    AccountRole VARCHAR(50),
    AccountType VARCHAR(50),
	constraint Atouristid_FK foreign key (TouristID) references Tourist (PersonID),
	constraint accountid_PK primary key (AccountID),
	constraint email_UQ unique(Email),
	constraint username_UQ unique(Username),

);




CREATE TABLE Booking (
   BookingID int,
   BookingDate Date,
   CancellationDate Date,
   BookingStatus VARCHAR(20),
   cancellationReason VARCHAR(20),
   cancellationFees DECIMAL(10, 2),
   BookingPrice DECIMAL(10,2),
   Rating DECIMAL(2, 1),

   constraint bookingid_PK primary key (BookingID)
);

CREATE TABLE Restaurant (
	BookingID int,
    RestaurantName VARCHAR(200),
    Cuisine VARCHAR(100),
	RestaurantPhone VARCHAR (50),
	constraint RBookingID_PK primary key (BookingID),
	constraint restid_FK foreign key (BookingID) references Booking (BookingID),
);

CREATE TABLE EntertainmentOptions (
	BookingID int,
    EntertainmentOptionsLocation VARCHAR(500),
    TicketPrice DECIMAL(10, 2),
    Website VARCHAR(50),
    EntertainmentOptionsName VARCHAR(50),
    AvailabilityDate DATE,
    Category VARCHAR(50),
    AgeRange VARCHAR(50),
   constraint  EBookingID_PK primary key (BookingID),
   constraint EBookingID_fk foreign key (BookingID) references Booking (BookingID),
);

CREATE TABLE Flight (
	BookingID int,
    Class VARCHAR(50),
    Status VARCHAR(50),
    DepartureDate DATE,
    DepartureTime TIME,
    ArrivalDate DATE,
    ArrivalTime TIME,
    BaggageAllowance DECIMAL(10, 2),
    Airline VARCHAR(200),
    DepartureCity VARCHAR(50),
    ArrivalCity VARCHAR(50),
    SeatNo VARCHAR(50)
	constraint  FbookingID_PK primary key (BookingID),
   constraint FbookingID_Fk foreign key (BookingID) references Booking (BookingID)
);

CREATE TABLE Accommodation (
	BookingID int,
    NumRoom INT,
    AccommodationStatus VARCHAR(50),
	AccommodationPhone VARCHAR(50),
	constraint  ABookingID_PK primary key (BookingID),
	constraint ABookingID_FK foreign key (BookingID) references Booking(BookingID)

);
CREATE TABLE Hotel (
	BookingID INT,
    Style VARCHAR(50),
    FoodOptions VARCHAR(200),
    HotelServices VARCHAR(1000),
	constraint  HBookingID_PK primary key (BookingID),
	constraint  HBookingID_FK foreign key (BookingID) references Accommodation (BookingID)
);

CREATE TABLE VacationRental (
	BookingID INT,
	PropertyType VARCHAR (50),
    HostName VARCHAR(50),
	PropertySize INT,
	constraint  VBookingID_PK primary key (BookingID),
	constraint VBookingID_FK foreign key (BookingID) references Accommodation (BookingID),
   
);


CREATE TABLE CarRental (
	BookingID int,
    CarType VARCHAR(200),
    License VARCHAR(50),
    Driver bit,
	constraint  CbookingID_PK primary key (BookingID),
	constraint CbookingID_FK foreign key (BookingID) references Booking(BookingID),
);

CREATE TABLE Payment (
    PaymentID INT ,
    PaymentStatus VARCHAR(50),
    Amount DECIMAL(10, 2),
	TransactionDate DATE, 
	TouristID INT,

	constraint paymentid_PK primary key ( PaymentID),
   	constraint PtouristID foreign key (TouristID) references Tourist(PersonID),

);


CREATE TABLE EmployeeDependent (
    DependantName VARCHAR(50),
    EmployeeID INT,
    Gender VARCHAR(1),
    Relationship VARCHAR(20),
    DateOfBirth DATE,
    Telephone VARCHAR(50),
    CONSTRAINT PK_Dependent PRIMARY KEY (DependantName, EmployeeID),
    CONSTRAINT FK_Dependent_EmployeeID FOREIGN KEY (EmployeeID) REFERENCES Employee(PersonID)
);



CREATE TABLE Visa (
    PaymentID INT PRIMARY KEY,
    CardNumber VARCHAR(50),
    ExpirationDate DATE,
    CardHolderName VARCHAR(50),
    SecurityCode VARCHAR(10)
);

CREATE TABLE Cash (
    PaymentID INT PRIMARY KEY,
    CurrencyType VARCHAR(20)
);

CREATE TABLE Paypal (
    PaymentID INT PRIMARY KEY,
    Email VARCHAR(50),
    PaypalPassword VARCHAR(50)
);

CREATE TABLE Support (
    SupportID INT PRIMARY KEY,
    SupportStatus VARCHAR(20),
    DateOfRequest DATE,
    UserID INT,
    SupportType VARCHAR(50),
    TouristID INT,
    EmployeeID INT,
    CONSTRAINT FK_Support_TouristID FOREIGN KEY (TouristID) REFERENCES Tourist(PersonID),
    CONSTRAINT FK_Support_EmployeeID FOREIGN KEY (EmployeeID) REFERENCES Employee(PersonID)
);


CREATE TABLE BOOK (
    Reviews VARCHAR(255),
    PersonID INT,
    BookingId INT,
    PRIMARY KEY (PersonID, BookingId),
    FOREIGN KEY (PersonID) REFERENCES Person(PersonID),
    FOREIGN KEY (BookingId) REFERENCES Booking(BookingId)
);

CREATE TABLE CheckBooking (
    EmployeeId INT,
    BookingID INT,
    PRIMARY KEY (EmployeeId, BookingID),
    FOREIGN KEY (EmployeeId) REFERENCES Employee(PersonID),
    FOREIGN KEY (BookingID) REFERENCES Booking(BookingId)
);

CREATE TABLE Contact (
    PersonID INT,
    StaffID INT,
    PRIMARY KEY (PersonID, StaffID),
    FOREIGN KEY (PersonID) REFERENCES Person(PersonID),
    FOREIGN KEY (StaffID) REFERENCES Staff(StaffId)
);

CREATE TABLE Coordinate (
    EntertainmentId INT,
    StaffId INT,
    FOREIGN KEY (EntertainmentId) REFERENCES EntertainmentOptions(BookingID),
    FOREIGN KEY (StaffId) REFERENCES Staff(StaffId),
    PRIMARY KEY (EntertainmentId, StaffId)
);

CREATE TABLE PersonAddress (
    PersonId INT,
    PersonAddress VARCHAR(255),
    FOREIGN KEY (PersonId) REFERENCES Person(PersonID),
    PRIMARY KEY (PersonId, PersonAddress)
);

CREATE TABLE EmbassyLocation (
    EmbassyName VARCHAR(100),
    EmbassyLocation VARCHAR(255),
    FOREIGN KEY (EmbassyName) REFERENCES Embassy(EmbassyName),
    PRIMARY KEY (EmbassyName, EmbassyLocation)
);

CREATE TABLE RestaurantAddress (
    BookingId INT,
    RestaurantLocation VARCHAR(255),
    FOREIGN KEY (BookingId) REFERENCES Restaurant(BookingId),
    PRIMARY KEY (BookingId, RestaurantLocation)
);

CREATE TABLE AccommodationLocation (
    BookingId INT,
    AccommodationLocation VARCHAR(255),
    FOREIGN KEY (BookingId) REFERENCES Accommodation(BookingId),
    PRIMARY KEY (BookingId, AccommodationLocation)
);
