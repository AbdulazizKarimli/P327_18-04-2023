CREATE DATABASE CinemaDb

USE CinemaDb

CREATE TABLE Movies(
	Id int primary key identity,
	Name nvarchar(100) NOT NULL,
	Duration int NOT NULL,
	Poster nvarchar(50) NOT NULL,
	Imdb int NOT NULL
)

CREATE TABLE Genres(
	Id int primary key identity,
	Name nvarchar(50) NOT NULL
)

CREATE TABLE Actors(
	Id int primary key identity,
	Name nvarchar(100) NOT NULL,
	Age int NOT NULL
)

CREATE TABLE MovieGenres(
	Id int primary key identity,
	MovieId int foreign key references Movies(Id),
	GenreId int foreign key references Genres(Id)
)

CREATE TABLE MovieActors(
	Id int primary key identity,
	MovieId int foreign key references Movies(Id),
	ActorId int foreign key references Actors(Id)
)

CREATE TABLE Halls(
	Id int primary key identity,
	Name nvarchar(100) NOT NULL,
	SeatCount int NOT NULL
)

CREATE TABLE Seats(
	Id int primary key identity,
	Row int NOT NULL,
	Seat int NOT NULL,
	HallId int foreign key references Halls(Id)
)

CREATE TABLE Customers(
	Id int primary key identity,
	Name nvarchar(100) NOT NULL,
	PhoneNumber nvarchar(15) NOT NULL 
)

CREATE TABLE Sessions(
	Id int primary key identity,
	StartDate datetime2 NOT NULL,
	EndDate datetime2 NOT NULL,
	MovieId int foreign key references Movies(Id),
	HallId int foreign key references Halls(Id)
)

CREATE TABLE Tickets(
	Id int primary key identity,
	Price decimal(18,2) NOT NULL,
	CustomerId int foreign key references Customers(Id),
	SessionId int foreign key references Sessions(Id),
	SeatId int foreign key references Seats(Id)
)

CREATE VIEW TicketDetail
AS
SELECT m.Name 'Movie name', s.StartDate, s.EndDate, h.Name, st.Row, st.Seat, t.Price, c.Name 'Customer name' FROM Tickets t
JOIN Customers c
ON t.CustomerId = c.Id
JOIN Seats st
ON t.SeatId = st.Id
JOIN Sessions s
ON t.SessionId = s.Id
JOIN Movies m
ON s.MovieId = m.Id
JOIN Halls h
ON s.HallId = h.Id

SELECT * FROM TicketDetail