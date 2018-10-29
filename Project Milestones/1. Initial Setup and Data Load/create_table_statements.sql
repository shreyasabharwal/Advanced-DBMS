CREATE TABLE Hotel (
    HotelID            int PRIMARY KEY,
    HotelRoom          varchar(80),
    Address            varchar(80),
    City               varchar(80),
	ZipCode			   varchar(80)
);

CREATE TABLE Room (
	RoomID                int PRIMARY KEY,
    RoomNumber            int,
    HotelID        		  int REFERENCES Hotel(HotelID)
);

CREATE TABLE Reservation (
    ReservationID            int PRIMARY KEY,
    HotelID                  int REFERENCES Hotel(HotelID),
    RoomID 				     int REFERENCES Room(RoomID),
	GuestID				     int REFERENCES Guest(GuestID),
    CheckinDate              date,
	Numberofdays			 int
);


CREATE TABLE Guest (
    GuestID            int PRIMARY KEY,
    FirstName          varchar(80),
    LastName           varchar(80),
    Address            varchar(80),
	City			   varchar(80),
	ZipCode			   varchar(80)
);