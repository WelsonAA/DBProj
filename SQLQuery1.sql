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
    street VARCHAR(50),
    apartment_no VARCHAR(50),
	bulding_no VARCHAR(50),
    City VARCHAR(50),
    State VARCHAR(50),
    Country VARCHAR(50),
    PostalCode VARCHAR(20),
    PassportNumber VARCHAR(50),
    /*TelephoneNumber VARCHAR(20), multi value */
    /*CardNumber1 VARCHAR(20)*/
    Nationality VARCHAR(50),
    CommunicationPreference VARCHAR(20)
	constraint passport_UQ unique(PassportNumber),
	constraint Ppersonid_PK primary key ( PersonID)
);
CREATE TABLE Account (
    AccountID INT ,
    AccountPassword VARCHAR(50),
	PersonID int ,
    Email VARCHAR(100),
    Username VARCHAR(50),
    AccountRole VARCHAR(50),
    AccountType VARCHAR(50)
	constraint Apersonid_FK foreign key (PersonID) references Person (PersonID),
	constraint accountid_PK primary key (AccountID),
	constraint email_UQ unique(Email),
	constraint username_UQ unique(Username)

);

CREATE TABLE Embassy (
    EmbassyName VARCHAR(100),
    EmbassyLocation VARCHAR(100),
    EmbassyPhone VARCHAR(20),
    EmbassyEmail VARCHAR(100),
    EmbassyWebsite VARCHAR(100),
    EmbassyWorkingHours VARCHAR(100)
	constraint embassyname_PK primary key (EmbassyName),
	constraint embassyemail_UQ unique(EmbassyEmail),
);

/*****TO REVISE***/
CREATE TABLE Department (
    DepID INT ,
    Name VARCHAR(200),
    ManagerID INT
	constraint depid_PK primary key (DepID)
);
CREATE TABLE Employee (
    EmployeeID INT,
	DepID int,
	PersonID int,
    HiringDate DATE,
    JobTitle VARCHAR(100),
    Salary DECIMAL(10, 2),
   
    ManagerID INT,
    PerformanceRating DECIMAL(2, 1)
	constraint employee_PK primary key (EmployeeID)
    constraint Epersonid_FK foreign key (PersonID) references Person (PersonID),
	constraint manager_FK foreign key (ManagerID) references Employee (EmployeeID),
	constraint depid_FK foreign key (DepID) references Department (DepID)
	
);
CREATE TABLE TourGuide (
    TourGuideID INT ,
	PersonID int,
    HourlyPay DECIMAL(10, 2),
    TourGuideStatus VARCHAR(20),
    Review VARCHAR(1000),
    Languages VARCHAR(200),
    AvailabilityDate DATE,
    AvailabilityTime TIME,
    YearsOfExperience INT,
   constraint TGpersonid_FK foreign key (PersonID) references Person (PersonID),
   constraint tourguideid_PK primary key (TourGuideID)

);
CREATE TABLE Tourist (
    TouristID INT,
	 PersonID int,
    TravelStyle VARCHAR(200),
    Wishlist VARCHAR(500),
    constraint touristid_PK primary key (TouristID),
	constraint Tpersonid_FK foreign key (PersonID) references Person (PersonID),
);


CREATE TABLE Bookings (
   BookingID int,
   BookingDate Date,
   CancellationDate Date,
   BookingStatus VARCHAR(20),
   cancellationReason VARCHAR(20),
   cancellationFees DECIMAL(10, 2)
   constraint bookingid_PK primary key (BookingID)
);
CREATE TABLE Restaurant (
    RestID INT ,
	BookingID int,
    RestaurantName VARCHAR(200),
    Cuisine VARCHAR(100),
    RestaurantAddress VARCHAR(500),
    Rating DECIMAL(2, 1),
    PriceRange VARCHAR(50)
	constraint restid_PK primary key (RestID),
	constraint restid_FK foreign key (BookingID) references Bookings (BookingID),
);
CREATE TABLE EntertainmentOptions (
    EntertainmentID INT ,
	BookingID int,
    EntertainmentOptionsLocation VARCHAR(500),
    TicketPrice DECIMAL(10, 2),
    Rating DECIMAL(2, 1),
    Website VARCHAR(50),
    EntertainmentOptionsName VARCHAR(50),
    AvailabilityDate DATE,
    Category VARCHAR(50),
    AgeRange VARCHAR(50),
   /*TelephoneNumber VARCHAR(20), multi value */
   constraint  entertainmentid_PK primary key (EntertainmentID),
   constraint entertainmentid_FK foreign key (BookingID) references Bookings (BookingID),
);
CREATE TABLE Flight (
    FlightID INT,
	BookingID int,
    Class VARCHAR(50),
    Status VARCHAR(50),
    DepartureDate DATE,
    DepartureTime TIME,
    ArrivalDate DATE,
    ArrivalTime TIME,
    BaggageAllowance DECIMAL(10, 2),
    Airline VARCHAR(200),
    TicketPrice DECIMAL(10, 2),
    DepartureCity VARCHAR(50),
    ArrivalCity VARCHAR(50),
    SeatNo VARCHAR(50)
	 constraint  flightid_PK primary key (FlightID),
   constraint flightid_FK foreign key (BookingID) references Bookings (BookingID)
);
CREATE TABLE Accommodation (
    AccommodationID INT,
	BookingID int,
    Price DECIMAL(10, 2),
    NumRoom INT,
    Rating DECIMAL(2, 1),
    AccommodationStatus VARCHAR(50)
	constraint  accommodationid_PK primary key (AccommodationID),
	constraint accommodationid_FK foreign key (BookingID) references Bookings(BookingID)

);
CREATE TABLE Hotel (
    HotelID INT,
	AccommodationID INT,
    Style VARCHAR(50),
    FoodOptions VARCHAR(200),
    HotelServices VARCHAR(1000),
    /*Telephone VARCHAR(50)*/
	constraint  hotelid_PK primary key (HotelID),
	constraint  hotelid_FK foreign key (AccommodationID) references Accommodation (AccommodationID)
);
CREATE TABLE VacationRental (
    RentID INT ,
	PersonID int,
	AccommodationID INT,
    Offer VARCHAR(50),
    RentalType VARCHAR(50),
    HostID INT,
	constraint  rentid_PK primary key (RentID),
	constraint rentid_FK foreign key (AccommodationID) references Accommodation (AccommodationID),
	constraint hostid_FK foreign key (HostID) references Person (PersonID)
   
);
CREATE TABLE CarRental (
    CarRentalID INT ,
	BookingID int,
    Type VARCHAR(200),
    License VARCHAR(50),
    Driver bit,
    PricePerWeek DECIMAL(10, 2),
    Address VARCHAR(500)
	constraint  carrentalid_PK primary key (CarRentalID),
	constraint bookingid_FK foreign key (BookingID) references Bookings(BookingID),
);

CREATE TABLE Payment (
    PaymentID INT ,
    PaymentStatus VARCHAR(50),
    Amount DECIMAL(10, 2),
    PaymentMethod VARCHAR(50),
    CardType VARCHAR(50),
    ExpirationDate DATE,
    SecurityCode VARCHAR(10),
    CardHolderName VARCHAR(200),
	constraint paymentid_PK primary key ( PaymentID),
   
);


