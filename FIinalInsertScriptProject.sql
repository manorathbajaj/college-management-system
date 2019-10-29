USE [master]
GO

/****** Object:  Database [PROJECT_TEAM_14_TEST]    Script Date: 7/28/2019 6:59:08 PM ******/
CREATE DATABASE [PROJECT_TEAM_14_TEST]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'PROJECT_TEAM_14_TEST', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\PROJECT_TEAM_14_TEST.mdf' , SIZE = 3264KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'PROJECT_TEAM_14_TEST_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\PROJECT_TEAM_14_TEST_log.ldf' , SIZE = 832KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO


USE [PROJECT_TEAM_14_TEST]
GO
/****** Object:  UserDefinedFunction [dbo].[CheckClubs]    Script Date: 7/28/2019 7:18:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[CheckClubs] (@StudentID int)
RETURNS smallint
AS
BEGIN
	DECLARE @Count smallint = 0
	SELECT @Count = COUNT(StudentID)
		FROM Student_Has_Club
		WHERE StudentID = @StudentID
	RETURN @Count;
END;
GO
/****** Object:  UserDefinedFunction [dbo].[FundingComplete]    Script Date: 7/28/2019 7:18:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[FundingComplete] (@ProjectID int)
Returns smallint
AS
BEGIN 
	IF 
	(
	Select SUM(g.DonorAmount)
	FROM Grants g
	JOIN Project p
	ON g.ProjectID = p.ProjectID
	WHERE @ProjectID = g.ProjectID
	GROUP BY g.ProjectID
	) > (Select pp.FundingRequired FROM Project pp WHERE ProjectID = @ProjectID)
	 Return 1;
	 Return 0;
END;
GO
/****** Object:  Table [dbo].[Address]    Script Date: 7/28/2019 7:18:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Address](
	[AddressID] [int] IDENTITY(1,1) NOT NULL,
	[Line1] [varchar](45) NOT NULL,
	[Line2] [varchar](45) NOT NULL,
	[City] [varchar](45) NOT NULL,
	[State] [varchar](45) NOT NULL,
	[ZipCode] [varchar](45) NOT NULL,
	[COUNTRY] [varchar](45) NOT NULL,
	[StudentID] [int] NULL,
	[EmployeeID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[AddressID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Class]    Script Date: 7/28/2019 7:18:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Class](
	[RoomID] [int] NOT NULL,
	[TimeSlot] [varchar](45) NULL,
	[CourseID] [int] NULL,
	[Professor_EmployeeID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[RoomID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Club]    Script Date: 7/28/2019 7:18:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Club](
	[ClubID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](45) NOT NULL,
	[PresidentID] [int] NOT NULL,
	[EnrollmetFee] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[ClubID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Course]    Script Date: 7/28/2019 7:18:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Course](
	[CourseID] [int] IDENTITY(1,1) NOT NULL,
	[CourseName] [varchar](45) NOT NULL,
	[PreReqID] [int] NULL,
	[CourseLevel] [int] NOT NULL,
	[Credit] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CourseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Department]    Script Date: 7/28/2019 7:18:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Department](
	[DepartmentID] [int] IDENTITY(1,1) NOT NULL,
	[NAME] [varchar](45) NOT NULL,
	[HODID] [int] NULL,
	[Extension] [varchar](45) NULL,
PRIMARY KEY CLUSTERED 
(
	[DepartmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 7/28/2019 7:18:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee](
	[EmployeeID] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](45) NOT NULL,
	[LastName] [varchar](45) NOT NULL,
	[Gender] [varchar](45) NULL,
	[DOB] [date] NOT NULL,
	[Email] [varchar](45) NULL,
PRIMARY KEY CLUSTERED 
(
	[EmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fees]    Script Date: 7/28/2019 7:18:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fees](
	[ReceiptNo] [int] IDENTITY(1,1) NOT NULL,
	[Fee] [float] NOT NULL,
	[DatePaid] [date] NOT NULL,
	[StudentID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ReceiptNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Grants]    Script Date: 7/28/2019 7:18:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Grants](
	[InvoiceID] [int] IDENTITY(1,1) NOT NULL,
	[DonorName] [varchar](45) NULL,
	[DonorAmount] [float] NULL,
	[ProjectID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[InvoiceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Management]    Script Date: 7/28/2019 7:18:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Management](
	[EmployeeID] [int] NOT NULL,
	[username] [varchar](45) NULL,
	[password] [varchar](45) NULL,
	[EncryptedPassword] [varbinary](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[EmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Professor]    Script Date: 7/28/2019 7:18:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Professor](
	[EmployeeID] [int] NOT NULL,
	[DepartmentID] [int] NULL,
	[Specialization] [varchar](45) NOT NULL,
	[isFullTime] [tinyint] NULL,
PRIMARY KEY CLUSTERED 
(
	[EmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Project]    Script Date: 7/28/2019 7:18:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Project](
	[ProjectID] [int] IDENTITY(1,1) NOT NULL,
	[ProjectName] [varchar](45) NOT NULL,
	[Synopsis] [text] NULL,
	[FundingRequired] [float] NULL,
	[isActive] [tinyint] NULL,
	[isFunded] [tinyint] NULL,
	[Professor_EmployeeID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ProjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Student]    Script Date: 7/28/2019 7:18:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Student](
	[StudentID] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](45) NOT NULL,
	[LastName] [varchar](45) NOT NULL,
	[ContactNo] [varchar](45) NOT NULL,
	[Gender] [varchar](45) NULL,
	[DOB] [date] NOT NULL,
	[YearEnrolled] [date] NOT NULL,
	[Email] [varchar](45) NULL,
PRIMARY KEY CLUSTERED 
(
	[StudentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Student_Has_Club]    Script Date: 7/28/2019 7:18:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Student_Has_Club](
	[StudentID] [int] NOT NULL,
	[ClubID] [int] NOT NULL,
	[isActive] [tinyint] NULL,
PRIMARY KEY CLUSTERED 
(
	[StudentID] ASC,
	[ClubID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Student_Has_Course]    Script Date: 7/28/2019 7:18:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Student_Has_Course](
	[StudentID] [int] NOT NULL,
	[CourseID] [int] NOT NULL,
	[Grade] [float] NULL,
	[Semester] [varchar](45) NULL,
	[StartDate] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[StudentID] ASC,
	[CourseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TA]    Script Date: 7/28/2019 7:18:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TA](
	[StudentID] [int] NULL,
	[RoomID] [int] NULL,
	[CourseID] [int] NULL,
	[Professor_EmployeeID] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vwDepartmentGrantsTotal]    Script Date: 7/28/2019 7:18:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwDepartmentGrantsTotal] 
AS 
	SELECT d.DepartmentID, SUM(g.DonorAmount) as [Total Grant Amount],COUNT(g.DonorAmount) AS [No. of Donations]
 	FROM
	Department d
	JOIN Professor p
	ON d.DepartmentID = p.DepartmentID
	JOIN Project pr
	ON p.EmployeeID = pr.Professor_EmployeeID
	JOIN Grants g 
	ON g.ProjectID = pr.ProjectID
	Group BY d.DepartmentID
GO
/****** Object:  View [dbo].[vwProfessorinDepartment]    Script Date: 7/28/2019 7:18:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwProfessorinDepartment]
AS 
	SELECT p.DepartmentID ,d.NAME, Count(p.DepartmentID) as [Total Professors]
	FROM Department d 
	JOIN Professor p
	on d.DepartmentID = p.DepartmentID
	GROUP BY p.DepartmentID, d.NAME
GO
/****** Object:  View [dbo].[vwStudentTotalCredits]    Script Date: 7/28/2019 7:18:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwStudentTotalCredits]
AS
	SELECT s.StudentID , s.FirstName, s.LastName ,Sum(c.Credit) As [Total Credits], Count(c.Credit) As [Courses Registered]
	FROM Student s
	JOIN Student_Has_Course shc
	ON s.StudentID = shc.StudentID
	JOIN Course c
	ON shc.CourseID = c.CourseID
	GROUP BY s.StudentID,S.FirstName,s.LastName
GO
/****** Object:  View [dbo].[vwStudentTotalFeesPaid]    Script Date: 7/28/2019 7:18:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwStudentTotalFeesPaid]
AS 
	SELECT s.StudentID,s.FirstName,s.LastName , SUM(f.Fee) as [Total Fees] 
	From Student s
	JOIN Fees f
	ON s.StudentID = f.StudentID
	GROUP BY s.StudentID, s.FirstName, s.LastName
GO
SET IDENTITY_INSERT [dbo].[Address] ON 
GO
INSERT [dbo].[Address] ([AddressID], [Line1], [Line2], [City], [State], [ZipCode], [COUNTRY], [StudentID], [EmployeeID]) VALUES (1, N'14 Palace Road', N'Apt 1', N'Boston', N'MA', N'02115', N'USA', 1, NULL)
GO
INSERT [dbo].[Address] ([AddressID], [Line1], [Line2], [City], [State], [ZipCode], [COUNTRY], [StudentID], [EmployeeID]) VALUES (2, N'75 Peterborough Street', N'Apt 1', N'Boston', N'MA', N'02115', N'USA', NULL, 1)
GO
INSERT [dbo].[Address] ([AddressID], [Line1], [Line2], [City], [State], [ZipCode], [COUNTRY], [StudentID], [EmployeeID]) VALUES (3, N'15 Palace Road', N'Apt 1', N'Boston', N'MA', N'02115', N'USA', 2, NULL)
GO
INSERT [dbo].[Address] ([AddressID], [Line1], [Line2], [City], [State], [ZipCode], [COUNTRY], [StudentID], [EmployeeID]) VALUES (4, N'16 Palace Road', N'Apt 1', N'Boston', N'MA', N'02115', N'USA', 3, NULL)
GO
INSERT [dbo].[Address] ([AddressID], [Line1], [Line2], [City], [State], [ZipCode], [COUNTRY], [StudentID], [EmployeeID]) VALUES (5, N'18 Palace Road', N'Apt 1', N'Boston', N'MA', N'02115', N'USA', 4, NULL)
GO
INSERT [dbo].[Address] ([AddressID], [Line1], [Line2], [City], [State], [ZipCode], [COUNTRY], [StudentID], [EmployeeID]) VALUES (6, N'19 Palace Road', N'Apt 1', N'Boston', N'MA', N'02115', N'USA', 5, NULL)
GO
INSERT [dbo].[Address] ([AddressID], [Line1], [Line2], [City], [State], [ZipCode], [COUNTRY], [StudentID], [EmployeeID]) VALUES (7, N'13 Palace Road', N'Apt 1', N'Boston', N'MA', N'02115', N'USA', 6, NULL)
GO
INSERT [dbo].[Address] ([AddressID], [Line1], [Line2], [City], [State], [ZipCode], [COUNTRY], [StudentID], [EmployeeID]) VALUES (8, N'12 Palace Road', N'Apt 1', N'Boston', N'MA', N'02115', N'USA', 7, NULL)
GO
INSERT [dbo].[Address] ([AddressID], [Line1], [Line2], [City], [State], [ZipCode], [COUNTRY], [StudentID], [EmployeeID]) VALUES (9, N'11 Palace Road', N'Apt 1', N'Boston', N'MA', N'02115', N'USA', 8, NULL)
GO
INSERT [dbo].[Address] ([AddressID], [Line1], [Line2], [City], [State], [ZipCode], [COUNTRY], [StudentID], [EmployeeID]) VALUES (10, N'10 Palace Road', N'Apt 1', N'Boston', N'MA', N'02115', N'USA', 9, NULL)
GO
INSERT [dbo].[Address] ([AddressID], [Line1], [Line2], [City], [State], [ZipCode], [COUNTRY], [StudentID], [EmployeeID]) VALUES (11, N'20 Palace Road', N'Apt 1', N'Boston', N'MA', N'02115', N'USA', 10, NULL)
GO
INSERT [dbo].[Address] ([AddressID], [Line1], [Line2], [City], [State], [ZipCode], [COUNTRY], [StudentID], [EmployeeID]) VALUES (12, N'75 Peterborough Street', N'Apt 1', N'Boston', N'MA', N'02115', N'USA', NULL, 12)
GO
INSERT [dbo].[Address] ([AddressID], [Line1], [Line2], [City], [State], [ZipCode], [COUNTRY], [StudentID], [EmployeeID]) VALUES (13, N'75 Peterborough Street', N'Apt 1', N'Boston', N'MA', N'02115', N'USA', NULL, 13)
GO
INSERT [dbo].[Address] ([AddressID], [Line1], [Line2], [City], [State], [ZipCode], [COUNTRY], [StudentID], [EmployeeID]) VALUES (14, N'75 Peterborough Street', N'Apt 1', N'Boston', N'MA', N'02115', N'USA', NULL, 14)
GO
INSERT [dbo].[Address] ([AddressID], [Line1], [Line2], [City], [State], [ZipCode], [COUNTRY], [StudentID], [EmployeeID]) VALUES (15, N'75 Peterborough Street', N'Apt 1', N'Boston', N'MA', N'02115', N'USA', NULL, 15)
GO
INSERT [dbo].[Address] ([AddressID], [Line1], [Line2], [City], [State], [ZipCode], [COUNTRY], [StudentID], [EmployeeID]) VALUES (16, N'75 Peterborough Street', N'Apt 1', N'Boston', N'MA', N'02115', N'USA', NULL, 16)
GO
INSERT [dbo].[Address] ([AddressID], [Line1], [Line2], [City], [State], [ZipCode], [COUNTRY], [StudentID], [EmployeeID]) VALUES (17, N'75 Peterborough Street', N'Apt 1', N'Boston', N'MA', N'02115', N'USA', NULL, 17)
GO
INSERT [dbo].[Address] ([AddressID], [Line1], [Line2], [City], [State], [ZipCode], [COUNTRY], [StudentID], [EmployeeID]) VALUES (18, N'75 Peterborough Street', N'Apt 1', N'Boston', N'MA', N'02115', N'USA', NULL, 18)
GO
INSERT [dbo].[Address] ([AddressID], [Line1], [Line2], [City], [State], [ZipCode], [COUNTRY], [StudentID], [EmployeeID]) VALUES (19, N'75 Peterborough Street', N'Apt 1', N'Boston', N'MA', N'02115', N'USA', NULL, 19)
GO
INSERT [dbo].[Address] ([AddressID], [Line1], [Line2], [City], [State], [ZipCode], [COUNTRY], [StudentID], [EmployeeID]) VALUES (20, N'75 Peterborough Street', N'Apt 1', N'Boston', N'MA', N'02115', N'USA', NULL, 20)
GO
INSERT [dbo].[Address] ([AddressID], [Line1], [Line2], [City], [State], [ZipCode], [COUNTRY], [StudentID], [EmployeeID]) VALUES (21, N'76 Peterborough Street', N'Apt 1', N'Boston', N'MA', N'02115', N'USA', NULL, 1)
GO
INSERT [dbo].[Address] ([AddressID], [Line1], [Line2], [City], [State], [ZipCode], [COUNTRY], [StudentID], [EmployeeID]) VALUES (22, N'77 Peterborough Street', N'Apt 1', N'Boston', N'MA', N'02115', N'USA', NULL, 2)
GO
INSERT [dbo].[Address] ([AddressID], [Line1], [Line2], [City], [State], [ZipCode], [COUNTRY], [StudentID], [EmployeeID]) VALUES (23, N'78 Peterborough Street', N'Apt 1', N'Boston', N'MA', N'02115', N'USA', NULL, 3)
GO
INSERT [dbo].[Address] ([AddressID], [Line1], [Line2], [City], [State], [ZipCode], [COUNTRY], [StudentID], [EmployeeID]) VALUES (24, N'79 Peterborough Street', N'Apt 1', N'Boston', N'MA', N'02115', N'USA', NULL, 4)
GO
INSERT [dbo].[Address] ([AddressID], [Line1], [Line2], [City], [State], [ZipCode], [COUNTRY], [StudentID], [EmployeeID]) VALUES (25, N'80 Peterborough Street', N'Apt 1', N'Boston', N'MA', N'02115', N'USA', NULL, 5)
GO
INSERT [dbo].[Address] ([AddressID], [Line1], [Line2], [City], [State], [ZipCode], [COUNTRY], [StudentID], [EmployeeID]) VALUES (26, N'81 Peterborough Street', N'Apt 1', N'Boston', N'MA', N'02115', N'USA', NULL, 6)
GO
INSERT [dbo].[Address] ([AddressID], [Line1], [Line2], [City], [State], [ZipCode], [COUNTRY], [StudentID], [EmployeeID]) VALUES (27, N'82 Peterborough Street', N'Apt 1', N'Boston', N'MA', N'02115', N'USA', NULL, 7)
GO
INSERT [dbo].[Address] ([AddressID], [Line1], [Line2], [City], [State], [ZipCode], [COUNTRY], [StudentID], [EmployeeID]) VALUES (28, N'82 Peterborough Street', N'Apt 1', N'Boston', N'MA', N'02115', N'USA', NULL, 8)
GO
INSERT [dbo].[Address] ([AddressID], [Line1], [Line2], [City], [State], [ZipCode], [COUNTRY], [StudentID], [EmployeeID]) VALUES (29, N'84 Peterborough Street', N'Apt 1', N'Boston', N'MA', N'02115', N'USA', NULL, 9)
GO
INSERT [dbo].[Address] ([AddressID], [Line1], [Line2], [City], [State], [ZipCode], [COUNTRY], [StudentID], [EmployeeID]) VALUES (30, N'85 Peterborough Street', N'Apt 1', N'Boston', N'MA', N'02115', N'USA', NULL, 10)
GO
SET IDENTITY_INSERT [dbo].[Address] OFF
GO
INSERT [dbo].[Class] ([RoomID], [TimeSlot], [CourseID], [Professor_EmployeeID]) VALUES (1, N'1-2', 1, 11)
GO
INSERT [dbo].[Class] ([RoomID], [TimeSlot], [CourseID], [Professor_EmployeeID]) VALUES (2, N'2-3', 2, 11)
GO
INSERT [dbo].[Class] ([RoomID], [TimeSlot], [CourseID], [Professor_EmployeeID]) VALUES (3, N'3-4', 3, 12)
GO
INSERT [dbo].[Class] ([RoomID], [TimeSlot], [CourseID], [Professor_EmployeeID]) VALUES (4, N'4-5', 18, 13)
GO
INSERT [dbo].[Class] ([RoomID], [TimeSlot], [CourseID], [Professor_EmployeeID]) VALUES (5, N'5-6', 19, 14)
GO
INSERT [dbo].[Class] ([RoomID], [TimeSlot], [CourseID], [Professor_EmployeeID]) VALUES (6, N'6-7', 20, 15)
GO
INSERT [dbo].[Class] ([RoomID], [TimeSlot], [CourseID], [Professor_EmployeeID]) VALUES (7, N'8-9', 21, 16)
GO
INSERT [dbo].[Class] ([RoomID], [TimeSlot], [CourseID], [Professor_EmployeeID]) VALUES (8, N'9-10', 22, 17)
GO
INSERT [dbo].[Class] ([RoomID], [TimeSlot], [CourseID], [Professor_EmployeeID]) VALUES (9, N'10-11', 23, 18)
GO
INSERT [dbo].[Class] ([RoomID], [TimeSlot], [CourseID], [Professor_EmployeeID]) VALUES (10, N'11-12', 24, 19)
GO
SET IDENTITY_INSERT [dbo].[Club] ON 
GO
INSERT [dbo].[Club] ([ClubID], [Name], [PresidentID], [EnrollmetFee]) VALUES (1, N'Trekking Club', 1, 50)
GO
INSERT [dbo].[Club] ([ClubID], [Name], [PresidentID], [EnrollmetFee]) VALUES (4, N'Cycling Club', 2, 50)
GO
INSERT [dbo].[Club] ([ClubID], [Name], [PresidentID], [EnrollmetFee]) VALUES (5, N'Swimming Club', 3, 50)
GO
INSERT [dbo].[Club] ([ClubID], [Name], [PresidentID], [EnrollmetFee]) VALUES (6, N'Coding Club', 4, 0)
GO
INSERT [dbo].[Club] ([ClubID], [Name], [PresidentID], [EnrollmetFee]) VALUES (7, N'Data Club', 5, 10)
GO
INSERT [dbo].[Club] ([ClubID], [Name], [PresidentID], [EnrollmetFee]) VALUES (8, N'Cinema Club', 6, 100)
GO
INSERT [dbo].[Club] ([ClubID], [Name], [PresidentID], [EnrollmetFee]) VALUES (9, N'Acting Club', 7, 80)
GO
INSERT [dbo].[Club] ([ClubID], [Name], [PresidentID], [EnrollmetFee]) VALUES (10, N'Dance Club', 8, 120)
GO
INSERT [dbo].[Club] ([ClubID], [Name], [PresidentID], [EnrollmetFee]) VALUES (11, N'Fight Club', 9, 500)
GO
INSERT [dbo].[Club] ([ClubID], [Name], [PresidentID], [EnrollmetFee]) VALUES (12, N'Literature Club', 10, 200)
GO
SET IDENTITY_INSERT [dbo].[Club] OFF
GO
SET IDENTITY_INSERT [dbo].[Course] ON 
GO
INSERT [dbo].[Course] ([CourseID], [CourseName], [PreReqID], [CourseLevel], [Credit]) VALUES (1, N'Web Design', 6000, 5, 4)
GO
INSERT [dbo].[Course] ([CourseID], [CourseName], [PreReqID], [CourseLevel], [Credit]) VALUES (2, N'Web Tools', 6001, 5, 4)
GO
INSERT [dbo].[Course] ([CourseID], [CourseName], [PreReqID], [CourseLevel], [Credit]) VALUES (3, N'Algorithms', 6002, 4, 4)
GO
INSERT [dbo].[Course] ([CourseID], [CourseName], [PreReqID], [CourseLevel], [Credit]) VALUES (18, N'Application Development', NULL, 4, 4)
GO
INSERT [dbo].[Course] ([CourseID], [CourseName], [PreReqID], [CourseLevel], [Credit]) VALUES (19, N'Big Data', NULL, 3, 4)
GO
INSERT [dbo].[Course] ([CourseID], [CourseName], [PreReqID], [CourseLevel], [Credit]) VALUES (20, N'SmartPhones', NULL, 3, 4)
GO
INSERT [dbo].[Course] ([CourseID], [CourseName], [PreReqID], [CourseLevel], [Credit]) VALUES (21, N'DMDD', NULL, 3, 4)
GO
INSERT [dbo].[Course] ([CourseID], [CourseName], [PreReqID], [CourseLevel], [Credit]) VALUES (22, N'Cloud Computing', NULL, 4, 4)
GO
INSERT [dbo].[Course] ([CourseID], [CourseName], [PreReqID], [CourseLevel], [Credit]) VALUES (23, N'User Experience', NULL, 2, 4)
GO
INSERT [dbo].[Course] ([CourseID], [CourseName], [PreReqID], [CourseLevel], [Credit]) VALUES (24, N'Business Analysis', NULL, 1, 4)
GO
SET IDENTITY_INSERT [dbo].[Course] OFF
GO
SET IDENTITY_INSERT [dbo].[Department] ON 
GO
INSERT [dbo].[Department] ([DepartmentID], [NAME], [HODID], [Extension]) VALUES (1, N'CS', 11, N'601')
GO
INSERT [dbo].[Department] ([DepartmentID], [NAME], [HODID], [Extension]) VALUES (2, N'IS', 12, N'602')
GO
INSERT [dbo].[Department] ([DepartmentID], [NAME], [HODID], [Extension]) VALUES (3, N'EM', 13, N'603')
GO
INSERT [dbo].[Department] ([DepartmentID], [NAME], [HODID], [Extension]) VALUES (4, N'Analytics', 14, N'604')
GO
INSERT [dbo].[Department] ([DepartmentID], [NAME], [HODID], [Extension]) VALUES (5, N'Arts', NULL, N'605')
GO
INSERT [dbo].[Department] ([DepartmentID], [NAME], [HODID], [Extension]) VALUES (6, N'Law', NULL, N'606')
GO
INSERT [dbo].[Department] ([DepartmentID], [NAME], [HODID], [Extension]) VALUES (7, N'Biotech', NULL, N'607')
GO
INSERT [dbo].[Department] ([DepartmentID], [NAME], [HODID], [Extension]) VALUES (8, N'Aero', NULL, N'608')
GO
INSERT [dbo].[Department] ([DepartmentID], [NAME], [HODID], [Extension]) VALUES (9, N'Mech', NULL, N'609')
GO
INSERT [dbo].[Department] ([DepartmentID], [NAME], [HODID], [Extension]) VALUES (10, N'Industrial', NULL, N'610')
GO
SET IDENTITY_INSERT [dbo].[Department] OFF
GO
SET IDENTITY_INSERT [dbo].[Employee] ON 
GO
INSERT [dbo].[Employee] ([EmployeeID], [FirstName], [LastName], [Gender], [DOB], [Email]) VALUES (1, N'Simon', N'Wang', N'Male', CAST(N'1980-06-11' AS Date), N'simon123')
GO
INSERT [dbo].[Employee] ([EmployeeID], [FirstName], [LastName], [Gender], [DOB], [Email]) VALUES (2, N'vishal', N'chawla', N'Male', CAST(N'1980-06-11' AS Date), N'vishal.chawla@husky.neu.edu')
GO
INSERT [dbo].[Employee] ([EmployeeID], [FirstName], [LastName], [Gender], [DOB], [Email]) VALUES (3, N'jon', N'doe', N'Male', CAST(N'1970-06-11' AS Date), N'jon.doe@husky.neu.edu')
GO
INSERT [dbo].[Employee] ([EmployeeID], [FirstName], [LastName], [Gender], [DOB], [Email]) VALUES (4, N'jessica', N'jones', N'Female', CAST(N'1980-09-11' AS Date), N'jessica.jones@husky.neu.edu')
GO
INSERT [dbo].[Employee] ([EmployeeID], [FirstName], [LastName], [Gender], [DOB], [Email]) VALUES (5, N'wayne', N'rooney', N'Male', CAST(N'1981-06-11' AS Date), N'wayne.rooney@husky.neu.edu')
GO
INSERT [dbo].[Employee] ([EmployeeID], [FirstName], [LastName], [Gender], [DOB], [Email]) VALUES (6, N'romero', N'lukaku', N'Male', CAST(N'1982-06-11' AS Date), N'romero.lukaku@husky.neu.edu')
GO
INSERT [dbo].[Employee] ([EmployeeID], [FirstName], [LastName], [Gender], [DOB], [Email]) VALUES (7, N'juan', N'mata', N'Male', CAST(N'1983-06-11' AS Date), N'juan.mata@husky.neu.edu')
GO
INSERT [dbo].[Employee] ([EmployeeID], [FirstName], [LastName], [Gender], [DOB], [Email]) VALUES (8, N'ashley', N'young', N'Male', CAST(N'1973-06-11' AS Date), N'ashley.young@husky.neu.edu')
GO
INSERT [dbo].[Employee] ([EmployeeID], [FirstName], [LastName], [Gender], [DOB], [Email]) VALUES (9, N'paul', N'pogba', N'Male', CAST(N'1984-06-11' AS Date), N'paul.pogba@husky.neu.edu')
GO
INSERT [dbo].[Employee] ([EmployeeID], [FirstName], [LastName], [Gender], [DOB], [Email]) VALUES (10, N'marcus', N'rashford', N'Male', CAST(N'1985-06-11' AS Date), N'marcus.rashford@husky.neu.edu')
GO
INSERT [dbo].[Employee] ([EmployeeID], [FirstName], [LastName], [Gender], [DOB], [Email]) VALUES (11, N'oliver', N'giroud', N'Male', CAST(N'1986-06-11' AS Date), N'oliver.giroud@husky.neu.edu')
GO
INSERT [dbo].[Employee] ([EmployeeID], [FirstName], [LastName], [Gender], [DOB], [Email]) VALUES (12, N'aaron', N'ramsey', N'Male', CAST(N'1986-07-11' AS Date), N'aaron.ramsey@husky.neu.edu')
GO
INSERT [dbo].[Employee] ([EmployeeID], [FirstName], [LastName], [Gender], [DOB], [Email]) VALUES (13, N'pablo', N'dybala', N'Male', CAST(N'1980-09-11' AS Date), N'pablo.dybala@husky.neu.edu')
GO
INSERT [dbo].[Employee] ([EmployeeID], [FirstName], [LastName], [Gender], [DOB], [Email]) VALUES (14, N'sami', N'khedira', N'Male', CAST(N'1981-02-11' AS Date), N'sami.khedira@husky.neu.edu')
GO
INSERT [dbo].[Employee] ([EmployeeID], [FirstName], [LastName], [Gender], [DOB], [Email]) VALUES (15, N'luis', N'suarez', N'Male', CAST(N'1982-02-11' AS Date), N'luis.suarez@husky.neu.edu')
GO
INSERT [dbo].[Employee] ([EmployeeID], [FirstName], [LastName], [Gender], [DOB], [Email]) VALUES (16, N'lionel', N'messi', N'Male', CAST(N'1983-02-11' AS Date), N'lionel.messi@husky.neu.edu')
GO
INSERT [dbo].[Employee] ([EmployeeID], [FirstName], [LastName], [Gender], [DOB], [Email]) VALUES (17, N'gareth', N'bale', N'Male', CAST(N'1979-01-11' AS Date), N'gareth.bale@husky.neu.edu')
GO
INSERT [dbo].[Employee] ([EmployeeID], [FirstName], [LastName], [Gender], [DOB], [Email]) VALUES (18, N'granit', N'xhaka', N'Male', CAST(N'1984-11-11' AS Date), N'granit.xhaka@husky.neu.edu')
GO
INSERT [dbo].[Employee] ([EmployeeID], [FirstName], [LastName], [Gender], [DOB], [Email]) VALUES (19, N'diego', N'costa', N'Male', CAST(N'1985-04-11' AS Date), N'diego.costa@husky.neu.edu')
GO
INSERT [dbo].[Employee] ([EmployeeID], [FirstName], [LastName], [Gender], [DOB], [Email]) VALUES (20, N'luke', N'shaw', N'Male', CAST(N'1985-12-11' AS Date), N'luke.shaw@husky.neu.edu')
GO
SET IDENTITY_INSERT [dbo].[Employee] OFF
GO
SET IDENTITY_INSERT [dbo].[Fees] ON 
GO
INSERT [dbo].[Fees] ([ReceiptNo], [Fee], [DatePaid], [StudentID]) VALUES (1, 6251.56, CAST(N'2019-07-28' AS Date), 1)
GO
INSERT [dbo].[Fees] ([ReceiptNo], [Fee], [DatePaid], [StudentID]) VALUES (2, 2545.56, CAST(N'2018-08-28' AS Date), 1)
GO
INSERT [dbo].[Fees] ([ReceiptNo], [Fee], [DatePaid], [StudentID]) VALUES (3, 3251.26, CAST(N'2019-09-28' AS Date), 1)
GO
INSERT [dbo].[Fees] ([ReceiptNo], [Fee], [DatePaid], [StudentID]) VALUES (4, 6251.56, CAST(N'2019-07-28' AS Date), 2)
GO
INSERT [dbo].[Fees] ([ReceiptNo], [Fee], [DatePaid], [StudentID]) VALUES (5, 2251.56, CAST(N'2019-08-28' AS Date), 2)
GO
INSERT [dbo].[Fees] ([ReceiptNo], [Fee], [DatePaid], [StudentID]) VALUES (6, 3251.56, CAST(N'2019-09-28' AS Date), 2)
GO
INSERT [dbo].[Fees] ([ReceiptNo], [Fee], [DatePaid], [StudentID]) VALUES (7, 6251.56, CAST(N'2019-07-28' AS Date), 3)
GO
INSERT [dbo].[Fees] ([ReceiptNo], [Fee], [DatePaid], [StudentID]) VALUES (8, 6251.56, CAST(N'2019-07-27' AS Date), 4)
GO
INSERT [dbo].[Fees] ([ReceiptNo], [Fee], [DatePaid], [StudentID]) VALUES (9, 6251.56, CAST(N'2019-07-26' AS Date), 5)
GO
INSERT [dbo].[Fees] ([ReceiptNo], [Fee], [DatePaid], [StudentID]) VALUES (10, 6251.56, CAST(N'2019-07-25' AS Date), 6)
GO
INSERT [dbo].[Fees] ([ReceiptNo], [Fee], [DatePaid], [StudentID]) VALUES (11, 6251.56, CAST(N'2019-07-24' AS Date), 7)
GO
INSERT [dbo].[Fees] ([ReceiptNo], [Fee], [DatePaid], [StudentID]) VALUES (12, 6251.56, CAST(N'2019-07-23' AS Date), 8)
GO
INSERT [dbo].[Fees] ([ReceiptNo], [Fee], [DatePaid], [StudentID]) VALUES (13, 6251.56, CAST(N'2019-07-22' AS Date), 9)
GO
INSERT [dbo].[Fees] ([ReceiptNo], [Fee], [DatePaid], [StudentID]) VALUES (14, 6251.56, CAST(N'2019-07-28' AS Date), 10)
GO
INSERT [dbo].[Fees] ([ReceiptNo], [Fee], [DatePaid], [StudentID]) VALUES (15, 2545.56, CAST(N'2019-08-25' AS Date), 10)
GO
INSERT [dbo].[Fees] ([ReceiptNo], [Fee], [DatePaid], [StudentID]) VALUES (16, 3251.56, CAST(N'2019-09-29' AS Date), 10)
GO
SET IDENTITY_INSERT [dbo].[Fees] OFF
GO
SET IDENTITY_INSERT [dbo].[Grants] ON 
GO
INSERT [dbo].[Grants] ([InvoiceID], [DonorName], [DonorAmount], [ProjectID]) VALUES (1, N'Charles Xavier', 9500, 1)
GO
INSERT [dbo].[Grants] ([InvoiceID], [DonorName], [DonorAmount], [ProjectID]) VALUES (3, N'Charles Xavier', 500, 1)
GO
INSERT [dbo].[Grants] ([InvoiceID], [DonorName], [DonorAmount], [ProjectID]) VALUES (4, N'Bob Xavier', 19000, 2)
GO
INSERT [dbo].[Grants] ([InvoiceID], [DonorName], [DonorAmount], [ProjectID]) VALUES (5, N'Dave Xavier', 500, 2)
GO
INSERT [dbo].[Grants] ([InvoiceID], [DonorName], [DonorAmount], [ProjectID]) VALUES (7, N'Francis Xavier', 10000, 5)
GO
INSERT [dbo].[Grants] ([InvoiceID], [DonorName], [DonorAmount], [ProjectID]) VALUES (8, N'Karl Xavier', 10000, 6)
GO
INSERT [dbo].[Grants] ([InvoiceID], [DonorName], [DonorAmount], [ProjectID]) VALUES (9, N'Francis Xavier', 10000, 7)
GO
INSERT [dbo].[Grants] ([InvoiceID], [DonorName], [DonorAmount], [ProjectID]) VALUES (10, N'Francis Xavier', 10000, 8)
GO
INSERT [dbo].[Grants] ([InvoiceID], [DonorName], [DonorAmount], [ProjectID]) VALUES (11, N'Francis Xavier', 10000, 9)
GO
INSERT [dbo].[Grants] ([InvoiceID], [DonorName], [DonorAmount], [ProjectID]) VALUES (12, N'Chris Xavier', 9000, 4)
GO
INSERT [dbo].[Grants] ([InvoiceID], [DonorName], [DonorAmount], [ProjectID]) VALUES (13, N'test donor1', 20000, 10)
GO
INSERT [dbo].[Grants] ([InvoiceID], [DonorName], [DonorAmount], [ProjectID]) VALUES (14, N'test donor1', 1000, 10)
GO
SET IDENTITY_INSERT [dbo].[Grants] OFF
GO
INSERT [dbo].[Management] ([EmployeeID], [username], [password], [EncryptedPassword]) VALUES (1, N'abc', N'abc', 0x0054368456345C43A9E94059713BB289010000006DD5F1BD0E49D6C84F2A04420F9583F9811470590B797B4F10D07E1D2307FDB5)
GO
INSERT [dbo].[Management] ([EmployeeID], [username], [password], [EncryptedPassword]) VALUES (2, N'vishal', N'chawla', 0x0054368456345C43A9E94059713BB2890100000060B6F00B1444B8140819E0F6E6F7FC934EF35F28569C7BF05EED1AE082152CCB)
GO
INSERT [dbo].[Management] ([EmployeeID], [username], [password], [EncryptedPassword]) VALUES (3, N'johnd', N'password', 0x0054368456345C43A9E94059713BB289010000004F2F449CD18D8563E9D877125223A4B81F53B75DFFA026E415A3052D66C85E0470D7D6D9AC8E1FF4E5B84FFE43DE1DC2)
GO
INSERT [dbo].[Management] ([EmployeeID], [username], [password], [EncryptedPassword]) VALUES (4, N'jjones', N'password2', 0x0054368456345C43A9E94059713BB289010000004C596F48B1EC82B1F8CBBF0E5C1B70E8B4B047AD1C5FC816E7DB660E288EF7D8335079F40D4048C8F54F65AF380811DD)
GO
INSERT [dbo].[Management] ([EmployeeID], [username], [password], [EncryptedPassword]) VALUES (5, N'wayne', N'password3', 0x0054368456345C43A9E94059713BB28901000000F4BE9D183ACE36EE2A981C2F93A71FF6B093C660F71A3179DB61F6165B7546466F261CD8016DE86DBF172F400C52FFBB)
GO
INSERT [dbo].[Management] ([EmployeeID], [username], [password], [EncryptedPassword]) VALUES (6, N'romero', N'password4', 0x0054368456345C43A9E94059713BB28901000000CC848227145B8FEE08E87E0BF5E038DE1AC0FDD98143481EC6E5FF6931CADD40F4DCBDE00F1109EE425A88A933223AF6)
GO
INSERT [dbo].[Management] ([EmployeeID], [username], [password], [EncryptedPassword]) VALUES (7, N'juan', N'password5', 0x0054368456345C43A9E94059713BB2890100000094B1EB8018AE7AAD18D6AE5A17F59B7AB58F8C9B9D4B1F2DB8FA238FBAC2F9ADAEC68962D107309B5DEABDFAB7BD4397)
GO
INSERT [dbo].[Management] ([EmployeeID], [username], [password], [EncryptedPassword]) VALUES (8, N'ashley', N'password6', 0x0054368456345C43A9E94059713BB289010000000F3814E481255A9DE4D5CFBA814B17001F2EC347E0932B997B5F2AA1DCE815B19726316A023323BD3805BD4DF3ED1DDD)
GO
INSERT [dbo].[Management] ([EmployeeID], [username], [password], [EncryptedPassword]) VALUES (9, N'paul', N'password7', 0x0054368456345C43A9E94059713BB289010000005FCE2BEDB97FB1068E751F1B26A4346050F76220E6824B8349C0FC768698196629571D42F57C1B3C032F2E30601552B2)
GO
INSERT [dbo].[Management] ([EmployeeID], [username], [password], [EncryptedPassword]) VALUES (10, N'marcus', N'password8', 0x0054368456345C43A9E94059713BB28901000000CE491A5EB4DA9950C879E26D593FE056BBBF9188F91010BE00E6D41602E310380DC700E2FFBF7B6CE718D0382BAFEB83)
GO
INSERT [dbo].[Professor] ([EmployeeID], [DepartmentID], [Specialization], [isFullTime]) VALUES (11, 1, N'Artificial Intelligence', 1)
GO
INSERT [dbo].[Professor] ([EmployeeID], [DepartmentID], [Specialization], [isFullTime]) VALUES (12, 2, N'Software Dev', 1)
GO
INSERT [dbo].[Professor] ([EmployeeID], [DepartmentID], [Specialization], [isFullTime]) VALUES (13, 3, N'Data Management', 1)
GO
INSERT [dbo].[Professor] ([EmployeeID], [DepartmentID], [Specialization], [isFullTime]) VALUES (14, 4, N'Digital Analytics', 1)
GO
INSERT [dbo].[Professor] ([EmployeeID], [DepartmentID], [Specialization], [isFullTime]) VALUES (15, 4, N'Liberal Arts', 1)
GO
INSERT [dbo].[Professor] ([EmployeeID], [DepartmentID], [Specialization], [isFullTime]) VALUES (16, 4, N'Criminal Law', 1)
GO
INSERT [dbo].[Professor] ([EmployeeID], [DepartmentID], [Specialization], [isFullTime]) VALUES (17, 1, N'Nanotech', 1)
GO
INSERT [dbo].[Professor] ([EmployeeID], [DepartmentID], [Specialization], [isFullTime]) VALUES (18, 1, N'Digital Aero', 1)
GO
INSERT [dbo].[Professor] ([EmployeeID], [DepartmentID], [Specialization], [isFullTime]) VALUES (19, 2, N'Digital Mech', 1)
GO
INSERT [dbo].[Professor] ([EmployeeID], [DepartmentID], [Specialization], [isFullTime]) VALUES (20, 3, N'Program Management', 1)
GO
SET IDENTITY_INSERT [dbo].[Project] ON 
GO
INSERT [dbo].[Project] ([ProjectID], [ProjectName], [Synopsis], [FundingRequired], [isActive], [isFunded], [Professor_EmployeeID]) VALUES (1, N'Cognitive architectures', N'In 4CAPS computations are distributed and dynamically balanced among independent processing centers. Like in other cognitive architectures 
(e.g., ACT-R), these processing centers have been identified with corresponding cortical regions in the human brain. Performing specific 
task, such as reading or driving, requires the simultaneous contribution of many of such regions.', 10000, 1, 0, 11)
GO
INSERT [dbo].[Project] ([ProjectID], [ProjectName], [Synopsis], [FundingRequired], [isActive], [isFunded], [Professor_EmployeeID]) VALUES (2, N'Blue Brain Project', N'The initial goal of the project, which was completed in December 2006,[4] was the creation of a simulated rat neocortical column, which is 
considered by some researchers to be the smallest functional unit of the neocortex,[5][6] which is thought to be responsible for higher 
functions such as conscious thought.', 20000, 1, 0, 11)
GO
INSERT [dbo].[Project] ([ProjectID], [ProjectName], [Synopsis], [FundingRequired], [isActive], [isFunded], [Professor_EmployeeID]) VALUES (3, N'CALO Project', N'SRI International made a collection of successful machine learning and reasoning technologies developed in the PAL program, primarily from the 
CALO project, available online. The available technologies include both general-purpose learning methods along with more focused learning 
applications. The PAL software and related publications are available at the PAL Framework website.', 30000, 1, 0, 11)
GO
INSERT [dbo].[Project] ([ProjectID], [ProjectName], [Synopsis], [FundingRequired], [isActive], [isFunded], [Professor_EmployeeID]) VALUES (4, N'FORR Project', N'FORR does not have perfect knowledge of how to solve a problem, but instead learns from experience. Intelligent agents are not optimal, 
but make decisions based on only a subset of all possible good reasons and informative data. These agents can still be considered rational.', 11000, 1, 0, 12)
GO
INSERT [dbo].[Project] ([ProjectID], [ProjectName], [Synopsis], [FundingRequired], [isActive], [isFunded], [Professor_EmployeeID]) VALUES (5, N'Procedural reasoning system', N'The interpreter is responsible for maintaining beliefs about the world state, choosing which goals to attempt to achieve next, and choosing which knowledge 
area to apply in the current situation. How exactly these operations are performed might depend on domain-specific meta-level knowledge areas.', 12000, 1, 0, 12)
GO
INSERT [dbo].[Project] ([ProjectID], [ProjectName], [Synopsis], [FundingRequired], [isActive], [isFunded], [Professor_EmployeeID]) VALUES (6, N'Soar system', N'he goal of the Soar project is to develop the fixed computational building blocks necessary for general intelligent agents – agents that can perform a 
wide range of tasks and encode, use, and learn all types of knowledge to realize the full range of cognitive capabilities found in humans, such as 
decision making, problem solving, planning, and natural language understanding.', 13000, 1, 0, 13)
GO
INSERT [dbo].[Project] ([ProjectID], [ProjectName], [Synopsis], [FundingRequired], [isActive], [isFunded], [Professor_EmployeeID]) VALUES (7, N'Libratus', N'Libratus is an artificial intelligence computer program designed to play poker, specifically heads up no-limit Texas hold
creators intend for it to be generalisable to other, non-Poker-specific applications.', 17000, 1, 0, 14)
GO
INSERT [dbo].[Project] ([ProjectID], [ProjectName], [Synopsis], [FundingRequired], [isActive], [isFunded], [Professor_EmployeeID]) VALUES (8, N'Society of Mind', N'In the process of explaining the society of mind, Minsky introduces a wide range of ideas and concepts. He develops theories about 
how processes such as language, memory, and learning work, and also covers concepts such as consciousness, the sense of self, 
and free will; because of this, many view The Society of Mind as a work of philosophy.', 18000, 1, 0, 15)
GO
INSERT [dbo].[Project] ([ProjectID], [ProjectName], [Synopsis], [FundingRequired], [isActive], [isFunded], [Professor_EmployeeID]) VALUES (9, N'Holmes', N'Its uses include development of digital virtual agents, predictive systems, cognitive process automation, visual 
computing applications, knowledge virtualization, robotics and drones. The HOLMES platform Vision was created by Ramprasad 
K.R. (Rampi), he was the chief technologist for AI at Wipro.', 19000, 1, 0, 17)
GO
INSERT [dbo].[Project] ([ProjectID], [ProjectName], [Synopsis], [FundingRequired], [isActive], [isFunded], [Professor_EmployeeID]) VALUES (10, N'Melomics', N'Melomics applies an evolutionary approach to music composition, i.e., music pieces are obtained by simulated evolution. 
These themes compete to better adapt to a proper fitness function, generally grounded on formal and aesthetic criteria. ', 21000, 1, 0, 19)
GO
SET IDENTITY_INSERT [dbo].[Project] OFF
GO
SET IDENTITY_INSERT [dbo].[Student] ON 
GO
INSERT [dbo].[Student] ([StudentID], [FirstName], [LastName], [ContactNo], [Gender], [DOB], [YearEnrolled], [Email]) VALUES (1, N'Aashay', N'Tiwari', N'8578698680', N'Male', CAST(N'1994-06-04' AS Date), CAST(N'2018-01-01' AS Date), N'tiwari.aa@husky.neu.edu')
GO
INSERT [dbo].[Student] ([StudentID], [FirstName], [LastName], [ContactNo], [Gender], [DOB], [YearEnrolled], [Email]) VALUES (2, N'Kanika', N'Makhija', N'8578698690', N'Female', CAST(N'1994-07-11' AS Date), CAST(N'2018-01-01' AS Date), N'makhija.ka@husky.neu.edu')
GO
INSERT [dbo].[Student] ([StudentID], [FirstName], [LastName], [ContactNo], [Gender], [DOB], [YearEnrolled], [Email]) VALUES (3, N'Riteeka', N'Ratnakar', N'8578698670', N'Female', CAST(N'1996-07-30' AS Date), CAST(N'2018-01-01' AS Date), N'ratnakar.rr@husky.neu.edu')
GO
INSERT [dbo].[Student] ([StudentID], [FirstName], [LastName], [ContactNo], [Gender], [DOB], [YearEnrolled], [Email]) VALUES (4, N'Manorath', N'Bajaj', N'8578698660', N'Male', CAST(N'1996-07-15' AS Date), CAST(N'2018-01-01' AS Date), N'bajaj.mm@husky.neu.edu')
GO
INSERT [dbo].[Student] ([StudentID], [FirstName], [LastName], [ContactNo], [Gender], [DOB], [YearEnrolled], [Email]) VALUES (5, N'Mrinal', N'Sharma', N'8578698650', N'Male', CAST(N'1993-07-30' AS Date), CAST(N'2018-01-01' AS Date), N'sharma.mr@husky.neu.edu')
GO
INSERT [dbo].[Student] ([StudentID], [FirstName], [LastName], [ContactNo], [Gender], [DOB], [YearEnrolled], [Email]) VALUES (6, N'Swagath', N'Sai', N'8578698640', N'Male', CAST(N'1994-08-30' AS Date), CAST(N'2018-01-01' AS Date), N'sai.swa@husky.neu.edu')
GO
INSERT [dbo].[Student] ([StudentID], [FirstName], [LastName], [ContactNo], [Gender], [DOB], [YearEnrolled], [Email]) VALUES (7, N'Shivesh', N'Suri', N'8578698630', N'Male', CAST(N'1992-09-30' AS Date), CAST(N'2018-01-01' AS Date), N'suri.sh@husky.neu.edu')
GO
INSERT [dbo].[Student] ([StudentID], [FirstName], [LastName], [ContactNo], [Gender], [DOB], [YearEnrolled], [Email]) VALUES (8, N'Chetan', N'Jadhav', N'8578698620', N'Male', CAST(N'1992-10-30' AS Date), CAST(N'2017-01-01' AS Date), N'jadhav.ch@husky.neu.edu')
GO
INSERT [dbo].[Student] ([StudentID], [FirstName], [LastName], [ContactNo], [Gender], [DOB], [YearEnrolled], [Email]) VALUES (9, N'Christy', N'Anoop', N'8578698610', N'Male', CAST(N'1996-04-30' AS Date), CAST(N'2018-01-01' AS Date), N'anoop.ch@husky.neu.edu')
GO
INSERT [dbo].[Student] ([StudentID], [FirstName], [LastName], [ContactNo], [Gender], [DOB], [YearEnrolled], [Email]) VALUES (10, N'Mrinal', N'Rai', N'8578698600', N'Female', CAST(N'1993-08-14' AS Date), CAST(N'2018-01-01' AS Date), N'rai.mr@husky.neu.edu')
GO
SET IDENTITY_INSERT [dbo].[Student] OFF
GO
INSERT [dbo].[Student_Has_Club] ([StudentID], [ClubID], [isActive]) VALUES (1, 1, 1)
GO
INSERT [dbo].[Student_Has_Club] ([StudentID], [ClubID], [isActive]) VALUES (1, 4, 1)
GO
INSERT [dbo].[Student_Has_Club] ([StudentID], [ClubID], [isActive]) VALUES (2, 6, 1)
GO
INSERT [dbo].[Student_Has_Club] ([StudentID], [ClubID], [isActive]) VALUES (2, 7, 1)
GO
INSERT [dbo].[Student_Has_Club] ([StudentID], [ClubID], [isActive]) VALUES (3, 8, 1)
GO
INSERT [dbo].[Student_Has_Club] ([StudentID], [ClubID], [isActive]) VALUES (4, 9, 1)
GO
INSERT [dbo].[Student_Has_Club] ([StudentID], [ClubID], [isActive]) VALUES (5, 10, 1)
GO
INSERT [dbo].[Student_Has_Club] ([StudentID], [ClubID], [isActive]) VALUES (6, 11, 1)
GO
INSERT [dbo].[Student_Has_Club] ([StudentID], [ClubID], [isActive]) VALUES (7, 12, 1)
GO
INSERT [dbo].[Student_Has_Club] ([StudentID], [ClubID], [isActive]) VALUES (8, 10, 1)
GO
INSERT [dbo].[Student_Has_Club] ([StudentID], [ClubID], [isActive]) VALUES (9, 8, 1)
GO
INSERT [dbo].[Student_Has_Club] ([StudentID], [ClubID], [isActive]) VALUES (10, 4, 1)
GO
INSERT [dbo].[Student_Has_Course] ([StudentID], [CourseID], [Grade], [Semester], [StartDate]) VALUES (1, 1, 3.75, N'Fall 18', CAST(N'2018-09-05' AS Date))
GO
INSERT [dbo].[Student_Has_Course] ([StudentID], [CourseID], [Grade], [Semester], [StartDate]) VALUES (1, 2, 4, N'Fall 18', CAST(N'2018-09-05' AS Date))
GO
INSERT [dbo].[Student_Has_Course] ([StudentID], [CourseID], [Grade], [Semester], [StartDate]) VALUES (1, 3, 3.3, N'Spring 18', CAST(N'2019-01-05' AS Date))
GO
INSERT [dbo].[Student_Has_Course] ([StudentID], [CourseID], [Grade], [Semester], [StartDate]) VALUES (2, 1, 3.75, N'Fall 18', CAST(N'2018-09-05' AS Date))
GO
INSERT [dbo].[Student_Has_Course] ([StudentID], [CourseID], [Grade], [Semester], [StartDate]) VALUES (2, 2, 3.75, N'Fall 18', CAST(N'2018-09-05' AS Date))
GO
INSERT [dbo].[Student_Has_Course] ([StudentID], [CourseID], [Grade], [Semester], [StartDate]) VALUES (2, 3, 3, N'Spring 18', CAST(N'2018-01-05' AS Date))
GO
INSERT [dbo].[Student_Has_Course] ([StudentID], [CourseID], [Grade], [Semester], [StartDate]) VALUES (3, 18, 3.75, N'Fall 18', CAST(N'2018-09-05' AS Date))
GO
INSERT [dbo].[Student_Has_Course] ([StudentID], [CourseID], [Grade], [Semester], [StartDate]) VALUES (3, 19, 3.75, N'Fall 18', CAST(N'2018-09-05' AS Date))
GO
INSERT [dbo].[Student_Has_Course] ([StudentID], [CourseID], [Grade], [Semester], [StartDate]) VALUES (3, 20, 3, N'Spring 18', CAST(N'2018-01-05' AS Date))
GO
INSERT [dbo].[Student_Has_Course] ([StudentID], [CourseID], [Grade], [Semester], [StartDate]) VALUES (4, 21, 3.75, N'Fall 18', CAST(N'2018-09-05' AS Date))
GO
INSERT [dbo].[Student_Has_Course] ([StudentID], [CourseID], [Grade], [Semester], [StartDate]) VALUES (4, 22, 3.75, N'Fall 18', CAST(N'2018-09-05' AS Date))
GO
INSERT [dbo].[Student_Has_Course] ([StudentID], [CourseID], [Grade], [Semester], [StartDate]) VALUES (4, 23, 3, N'Spring 18', CAST(N'2018-01-05' AS Date))
GO
INSERT [dbo].[Student_Has_Course] ([StudentID], [CourseID], [Grade], [Semester], [StartDate]) VALUES (5, 1, 3.75, N'Fall 18', CAST(N'2018-09-05' AS Date))
GO
INSERT [dbo].[Student_Has_Course] ([StudentID], [CourseID], [Grade], [Semester], [StartDate]) VALUES (5, 2, 3.75, N'Fall 18', CAST(N'2018-09-05' AS Date))
GO
INSERT [dbo].[Student_Has_Course] ([StudentID], [CourseID], [Grade], [Semester], [StartDate]) VALUES (5, 24, 3, N'Spring 18', CAST(N'2018-01-05' AS Date))
GO
INSERT [dbo].[Student_Has_Course] ([StudentID], [CourseID], [Grade], [Semester], [StartDate]) VALUES (6, 1, 3.75, N'Fall 18', CAST(N'2018-09-05' AS Date))
GO
INSERT [dbo].[Student_Has_Course] ([StudentID], [CourseID], [Grade], [Semester], [StartDate]) VALUES (6, 2, 3.75, N'Fall 18', CAST(N'2018-09-05' AS Date))
GO
INSERT [dbo].[Student_Has_Course] ([StudentID], [CourseID], [Grade], [Semester], [StartDate]) VALUES (6, 3, 3, N'Spring 18', CAST(N'2018-01-05' AS Date))
GO
INSERT [dbo].[Student_Has_Course] ([StudentID], [CourseID], [Grade], [Semester], [StartDate]) VALUES (7, 1, 3.75, N'Fall 18', CAST(N'2018-09-05' AS Date))
GO
INSERT [dbo].[Student_Has_Course] ([StudentID], [CourseID], [Grade], [Semester], [StartDate]) VALUES (8, 21, 3.75, N'Fall 18', CAST(N'2018-09-05' AS Date))
GO
INSERT [dbo].[Student_Has_Course] ([StudentID], [CourseID], [Grade], [Semester], [StartDate]) VALUES (9, 23, 3, N'Fall 18', CAST(N'2018-09-05' AS Date))
GO
INSERT [dbo].[Student_Has_Course] ([StudentID], [CourseID], [Grade], [Semester], [StartDate]) VALUES (10, 24, 3.75, N'Fall 18', CAST(N'2018-09-05' AS Date))
GO
INSERT [dbo].[TA] ([StudentID], [RoomID], [CourseID], [Professor_EmployeeID]) VALUES (10, 1, 1, 11)
GO
INSERT [dbo].[TA] ([StudentID], [RoomID], [CourseID], [Professor_EmployeeID]) VALUES (1, 4, 18, 13)
GO
INSERT [dbo].[TA] ([StudentID], [RoomID], [CourseID], [Professor_EmployeeID]) VALUES (2, 5, 19, 14)
GO
INSERT [dbo].[TA] ([StudentID], [RoomID], [CourseID], [Professor_EmployeeID]) VALUES (3, 2, 2, 11)
GO
INSERT [dbo].[TA] ([StudentID], [RoomID], [CourseID], [Professor_EmployeeID]) VALUES (4, 1, 1, 11)
GO
INSERT [dbo].[TA] ([StudentID], [RoomID], [CourseID], [Professor_EmployeeID]) VALUES (5, 9, 23, 18)
GO
INSERT [dbo].[TA] ([StudentID], [RoomID], [CourseID], [Professor_EmployeeID]) VALUES (6, 8, 22, 17)
GO
INSERT [dbo].[TA] ([StudentID], [RoomID], [CourseID], [Professor_EmployeeID]) VALUES (7, 7, 21, 16)
GO
INSERT [dbo].[TA] ([StudentID], [RoomID], [CourseID], [Professor_EmployeeID]) VALUES (8, 6, 20, 15)
GO
INSERT [dbo].[TA] ([StudentID], [RoomID], [CourseID], [Professor_EmployeeID]) VALUES (9, 3, 3, 12)
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Employee__A9D1053471D252A8]    Script Date: 7/28/2019 7:18:41 PM ******/
ALTER TABLE [dbo].[Employee] ADD UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Manageme__F3DBC5724FFF8BEB]    Script Date: 7/28/2019 7:18:41 PM ******/
ALTER TABLE [dbo].[Management] ADD UNIQUE NONCLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Student__A9D10534A49FBB8C]    Script Date: 7/28/2019 7:18:41 PM ******/
ALTER TABLE [dbo].[Student] ADD UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Address]  WITH CHECK ADD FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[Employee] ([EmployeeID])
GO
ALTER TABLE [dbo].[Address]  WITH CHECK ADD FOREIGN KEY([StudentID])
REFERENCES [dbo].[Student] ([StudentID])
GO
ALTER TABLE [dbo].[Class]  WITH CHECK ADD FOREIGN KEY([CourseID])
REFERENCES [dbo].[Course] ([CourseID])
GO
ALTER TABLE [dbo].[Class]  WITH CHECK ADD FOREIGN KEY([Professor_EmployeeID])
REFERENCES [dbo].[Professor] ([EmployeeID])
GO
ALTER TABLE [dbo].[Club]  WITH CHECK ADD FOREIGN KEY([PresidentID])
REFERENCES [dbo].[Student] ([StudentID])
GO
ALTER TABLE [dbo].[Fees]  WITH CHECK ADD FOREIGN KEY([StudentID])
REFERENCES [dbo].[Student] ([StudentID])
GO
ALTER TABLE [dbo].[Grants]  WITH CHECK ADD FOREIGN KEY([ProjectID])
REFERENCES [dbo].[Project] ([ProjectID])
GO
ALTER TABLE [dbo].[Management]  WITH CHECK ADD FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[Employee] ([EmployeeID])
GO
ALTER TABLE [dbo].[Professor]  WITH CHECK ADD FOREIGN KEY([DepartmentID])
REFERENCES [dbo].[Department] ([DepartmentID])
GO
ALTER TABLE [dbo].[Professor]  WITH CHECK ADD FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[Employee] ([EmployeeID])
GO
ALTER TABLE [dbo].[Project]  WITH CHECK ADD FOREIGN KEY([Professor_EmployeeID])
REFERENCES [dbo].[Professor] ([EmployeeID])
GO
ALTER TABLE [dbo].[Student_Has_Club]  WITH CHECK ADD FOREIGN KEY([ClubID])
REFERENCES [dbo].[Club] ([ClubID])
GO
ALTER TABLE [dbo].[Student_Has_Club]  WITH CHECK ADD FOREIGN KEY([StudentID])
REFERENCES [dbo].[Student] ([StudentID])
GO
ALTER TABLE [dbo].[Student_Has_Course]  WITH CHECK ADD FOREIGN KEY([CourseID])
REFERENCES [dbo].[Course] ([CourseID])
GO
ALTER TABLE [dbo].[Student_Has_Course]  WITH CHECK ADD FOREIGN KEY([StudentID])
REFERENCES [dbo].[Student] ([StudentID])
GO
ALTER TABLE [dbo].[TA]  WITH CHECK ADD FOREIGN KEY([CourseID])
REFERENCES [dbo].[Course] ([CourseID])
GO
ALTER TABLE [dbo].[TA]  WITH CHECK ADD FOREIGN KEY([Professor_EmployeeID])
REFERENCES [dbo].[Professor] ([EmployeeID])
GO
ALTER TABLE [dbo].[TA]  WITH CHECK ADD FOREIGN KEY([RoomID])
REFERENCES [dbo].[Class] ([RoomID])
GO
ALTER TABLE [dbo].[TA]  WITH CHECK ADD FOREIGN KEY([StudentID])
REFERENCES [dbo].[Student] ([StudentID])
GO
ALTER TABLE [dbo].[Grants]  WITH CHECK ADD  CONSTRAINT [FundingIsFull] CHECK  (([dbo].[FundingComplete]([ProjectID])<(1)))
GO
ALTER TABLE [dbo].[Grants] CHECK CONSTRAINT [FundingIsFull]
GO
ALTER TABLE [dbo].[Student_Has_Club]  WITH CHECK ADD  CONSTRAINT [RegisteredClubCount] CHECK  (([dbo].[CheckClubs]([StudentID])<=(2)))
GO
ALTER TABLE [dbo].[Student_Has_Club] CHECK CONSTRAINT [RegisteredClubCount]
GO
/****** Object:  Trigger [dbo].[trChangeFundingStatus]    Script Date: 7/28/2019 7:18:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trChangeFundingStatus]
ON [dbo].[Grants]
AFTER INSERT
AS
SET NOCOUNT ON 
	BEGIN 
	IF 
	(
	Select SUM(g.DonorAmount)
	FROM Grants g
	JOIN Project p
	ON g.ProjectID = p.ProjectID
	JOIN inserted
	ON inserted.ProjectID = g.ProjectID
	WHERE inserted.ProjectID = g.ProjectID
	GROUP BY g.ProjectID
	) > (Select pp.FundingRequired FROM Project pp JOIN inserted ON pp.ProjectID = inserted.ProjectID WHERE pp.ProjectID = inserted.ProjectID )
	UPDATE Project
	SET isFunded = 1
	WHERE ProjectID = (SELECT inserted.ProjectID FROM inserted)
	end;
GO
ALTER TABLE [dbo].[Grants] ENABLE TRIGGER [trChangeFundingStatus]
GO
/****** Object:  Trigger [dbo].[trEncryptPassWord]    Script Date: 7/28/2019 7:18:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trEncryptPassWord] 
ON [dbo].[Management]
AFTER INSERT 
AS
SET NOCOUNT ON 
	BEGIN 
		OPEN SYMMETRIC KEY SQLSymmetricKey  
		DECRYPTION BY CERTIFICATE SignedCertificate;
		UPDATE Management  
		SET EncryptedPassword = EncryptByKey(Key_GUID('SQLSymmetricKey'),password);
		CLOSE SYMMETRIC KEY SQLSymmetricKey;  
	END
GO
ALTER TABLE [dbo].[Management] ENABLE TRIGGER [trEncryptPassWord]
GO
