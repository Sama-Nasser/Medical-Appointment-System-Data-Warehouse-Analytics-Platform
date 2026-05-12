CREATE DATABASE [MedicalAppointmentSystem]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'MedicalAppointmentSystem', FILENAME = N'D:\Services\MSSQL\Data\MedicalAppointmentSystem.mdf' , SIZE = 8192KB , MAXSIZE = 1048576KB , FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'MedicalAppointmentSystem_log', FILENAME = N'D:\Services\MSSQL\Data\MedicalAppointmentSystem_log.ldf' , SIZE = 8192KB , MAXSIZE = 5242880KB , FILEGROWTH = 65536KB )
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [MedicalAppointmentSystem].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [MedicalAppointmentSystem] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [MedicalAppointmentSystem] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [MedicalAppointmentSystem] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [MedicalAppointmentSystem] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [MedicalAppointmentSystem] SET ARITHABORT OFF 
GO
ALTER DATABASE [MedicalAppointmentSystem] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [MedicalAppointmentSystem] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [MedicalAppointmentSystem] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [MedicalAppointmentSystem] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [MedicalAppointmentSystem] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [MedicalAppointmentSystem] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [MedicalAppointmentSystem] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [MedicalAppointmentSystem] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [MedicalAppointmentSystem] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [MedicalAppointmentSystem] SET  ENABLE_BROKER 
GO
ALTER DATABASE [MedicalAppointmentSystem] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [MedicalAppointmentSystem] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [MedicalAppointmentSystem] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [MedicalAppointmentSystem] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [MedicalAppointmentSystem] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [MedicalAppointmentSystem] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [MedicalAppointmentSystem] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [MedicalAppointmentSystem] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [MedicalAppointmentSystem] SET  MULTI_USER 
GO
ALTER DATABASE [MedicalAppointmentSystem] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [MedicalAppointmentSystem] SET DB_CHAINING OFF 
GO
ALTER DATABASE [MedicalAppointmentSystem] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [MedicalAppointmentSystem] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [MedicalAppointmentSystem] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [MedicalAppointmentSystem] SET QUERY_STORE = ON
GO
ALTER DATABASE [MedicalAppointmentSystem] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200)
GO
USE [MedicalAppointmentSystem]
GO
/****** Object:  FullTextCatalog [MedicalAppointmentSystem] ******/
CREATE FULLTEXT CATALOG [MedicalAppointmentSystem] WITH ACCENT_SENSITIVITY = ON
AS DEFAULT
GO
/****** Object:  Table [dbo].[Addresses] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Addresses](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ClinicId] [int] NOT NULL,
	[BuildingNumber] [int] NOT NULL,
	[StreetName] [nvarchar](50) NOT NULL,
	[District] [nvarchar](50) NOT NULL,
	[ZipCode] [int] NOT NULL,
	[City] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Addresses] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AISeverityLevels] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AISeverityLevels](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[NameEn] [nvarchar](50) NOT NULL,
	[NameAr] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[NameEn] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[NameAr] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Appointments] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Appointments](
	[Id] [int] NOT NULL,
	[DoctorId] [nvarchar](450) NOT NULL,
	[PatientId] [nvarchar](450) NOT NULL,
	[ClinicId] [nvarchar](450) NOT NULL,
	[ScheduledAt] [datetime] NOT NULL,
	[ActualStartAt] [datetime] NULL,
	[ActualEndAt] [datetime] NULL,
	[AppointmentTypeId] [int] NOT NULL,
	[StatusId] [int] NOT NULL,
	[CancelledById] [int] NULL,
	[CancellationReason] [nvarchar](500) NULL,
	[CancelledAt] [datetime] NULL,
	[RescheduledFromId] [nvarchar](450) NULL,
	[RescheduledToId] [nvarchar](450) NULL,
	[QueueNumber] [int] NULL,
	[QueueStatusId] [int] NULL,
	[FeeAmount] [decimal](10, 2) NULL,
	[BookedAt] [datetime] NULL,
	[BookingSourceId] [int] NULL,
 CONSTRAINT [PK_Appointments] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AppointmentStatuses] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AppointmentStatuses](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AppointmentTypes] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AppointmentTypes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BookingSources] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BookingSources](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CancellationActors] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CancellationActors](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ClinicAdmins] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClinicAdmins](
	[Id] [nvarchar](450) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_ClinicAdmins] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Clinics] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Clinics](
	[Id] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_Clinics] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DoctorPersonalityTypes] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DoctorPersonalityTypes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[NameEn] [nvarchar](100) NOT NULL,
	[NameAr] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[NameEn] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[NameAr] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Doctors] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Doctors](
	[Id] [nvarchar](450) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[BirthDate] [date] NOT NULL,
	[Gender] [bit] NOT NULL,
	[specialityId] [int] NOT NULL,
 CONSTRAINT [PK_Doctors] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DoctorsClinics] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DoctorsClinics](
	[DoctorId] [nvarchar](450) NOT NULL,
	[ClinicId] [int] NOT NULL,
	[Id] [int] NOT NULL,
 CONSTRAINT [PK_DoctorsClinics] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ_DoctorsClinics_DoctorId_ClinicId] UNIQUE NONCLUSTERED 
(
	[DoctorId] ASC,
	[ClinicId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ICD10Codes] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ICD10Codes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [varchar](10) NOT NULL,
	[NameEn] [nvarchar](200) NOT NULL,
	[NameAr] [nvarchar](200) NOT NULL,
	[Category] [nvarchar](100) NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_ICD10Codes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Images] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Images](
	[Id] [int] NOT NULL,
	[DoctorId] [nvarchar](450) NOT NULL,
	[ImageUrl] [varchar](255) NOT NULL,
 CONSTRAINT [PK_Images] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ_Photos_Doctor] UNIQUE NONCLUSTERED 
(
	[DoctorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MedicalDocuments] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MedicalDocuments](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RecordId] [int] NOT NULL,
	[DocumentType] [nvarchar](50) NOT NULL,
	[Title] [nvarchar](50) NULL,
	[FileUrl] [nvarchar](255) NOT NULL,
	[FileFormat] [nvarchar](50) NOT NULL,
	[UploadedAt] [datetime] NOT NULL,
	[Notes] [nvarchar](max) NULL,
 CONSTRAINT [PK_MedicalDocuments] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MedicalRecords] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MedicalRecords](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AppointmentId] [int] NOT NULL,
	[Date] [date] NOT NULL,
	[PatientId] [nvarchar](450) NOT NULL,
	[DoctorNotes] [nvarchar](max) NOT NULL,
	[AIWasCorrect] [bit] NULL,
	[CreatedAt] [datetime] NOT NULL,
 CONSTRAINT [PK_MedicalRecords_1] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_MedicalRecords] UNIQUE NONCLUSTERED 
(
	[AppointmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Notfications] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Notfications](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](450) NOT NULL,
	[Title] [nvarchar](450) NOT NULL,
	[Body] [nvarchar](50) NOT NULL,
	[Type] [nvarchar](50) NOT NULL,
	[Channel] [nvarchar](50) NOT NULL,
	[SentAt] [nvarchar](50) NOT NULL,
	[IsRead] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Notfications] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PaymentMethods] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PaymentMethods](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[NameEn] [nvarchar](50) NOT NULL,
	[NameAr] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[NameEn] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[NameAr] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Payments] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Payments](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AppointmentId] [int] NOT NULL,
	[PaymentMethodId] [int] NOT NULL,
	[PaymentStatusId] [int] NOT NULL,
	[Amount] [decimal](10, 2) NOT NULL,
	[TransactionId] [nvarchar](200) NULL,
	[PaidAt] [datetime] NULL,
	[CreatedAt] [datetime] NOT NULL,
	[Notes] [nvarchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PaymentStatuses] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PaymentStatuses](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PlatformAdmins] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PlatformAdmins](
	[Id] [nvarchar](450) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_PlatformAdmins] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Prescription] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Prescription](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RecordId] [int] NOT NULL,
	[MedicineName] [nvarchar](200) NOT NULL,
	[Dosage] [nvarchar](100) NOT NULL,
	[Frequency] [nvarchar](100) NOT NULL,
	[DurationDays] [int] NULL,
	[Instructions] [nvarchar](max) NULL,
	[IssuedAt] [datetime] NOT NULL,
 CONSTRAINT [PK_Prescription] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Profiles] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Profiles](
	[Id] [int] NOT NULL,
	[UserId] [nvarchar](450) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[BirthDate] [date] NOT NULL,
	[Gender] [bit] NOT NULL,
 CONSTRAINT [PK_Profiles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[QueueStatuses] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QueueStatuses](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RecordDiagnoses] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RecordDiagnoses](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RecordId] [int] NOT NULL,
	[ICD10Id] [int] NOT NULL,
	[DiagnosisType] [varchar](20) NOT NULL,
	[SortOrder] [int] NOT NULL,
 CONSTRAINT [PK_RecordDiagnoses] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Reviews] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reviews](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DoctorId] [nvarchar](450) NOT NULL,
	[PatientId] [nvarchar](450) NOT NULL,
	[Body] [nvarchar](max) NOT NULL,
	[PersonalityTypeId] [int] NOT NULL,
	[Rating] [tinyint] NOT NULL,
 CONSTRAINT [PK_Reviews] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Specialties] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Specialties](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[NameEn] [nvarchar](100) NOT NULL,
	[NameAr] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[NameEn] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[NameAr] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SymptomAssessments] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SymptomAssessments](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AppointmentId] [int] NOT NULL,
	[PatientId] [nvarchar](450) NOT NULL,
	[SymptomsText] [nvarchar](max) NOT NULL,
	[OnsetDuration] [nvarchar](100) NULL,
	[AISuggestedSpecialtyId] [int] NOT NULL,
	[AISeverityId] [int] NOT NULL,
	[AIConfidenceScore] [decimal](5, 2) NULL,
	[WasOverridden] [bit] NULL,
	[ManualSpecialty] [nvarchar](100) NULL,
	[CreatedAt] [datetime] NOT NULL,
 CONSTRAINT [PK_SymptomAssessments] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_SymptomAssessments] UNIQUE NONCLUSTERED 
(
	[AppointmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[Id] [nvarchar](450) NOT NULL,
	[Email] [varchar](50) NOT NULL,
	[password] [varchar](50) NOT NULL,
	[PhoneNumber] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ICD10Codes] ADD  CONSTRAINT [DF_ICD10Codes_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Payments] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[SymptomAssessments] ADD  CONSTRAINT [DF_SymptomAssessments_CreatedAt]  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Addresses]  WITH CHECK ADD  CONSTRAINT [FK_Addresses_Clinics] FOREIGN KEY([ClinicId])
REFERENCES [dbo].[Clinics] ([Id])
GO
ALTER TABLE [dbo].[Addresses] CHECK CONSTRAINT [FK_Addresses_Clinics]
GO
ALTER TABLE [dbo].[Appointments]  WITH CHECK ADD  CONSTRAINT [FK_Appointments_AppointmentStatuses] FOREIGN KEY([StatusId])
REFERENCES [dbo].[AppointmentStatuses] ([Id])
GO
ALTER TABLE [dbo].[Appointments] CHECK CONSTRAINT [FK_Appointments_AppointmentStatuses]
GO
ALTER TABLE [dbo].[Appointments]  WITH CHECK ADD  CONSTRAINT [FK_Appointments_AppointmentTypes] FOREIGN KEY([AppointmentTypeId])
REFERENCES [dbo].[AppointmentTypes] ([Id])
GO
ALTER TABLE [dbo].[Appointments] CHECK CONSTRAINT [FK_Appointments_AppointmentTypes]
GO
ALTER TABLE [dbo].[Appointments]  WITH CHECK ADD  CONSTRAINT [FK_Appointments_BookingSources] FOREIGN KEY([BookingSourceId])
REFERENCES [dbo].[BookingSources] ([Id])
GO
ALTER TABLE [dbo].[Appointments] CHECK CONSTRAINT [FK_Appointments_BookingSources]
GO
ALTER TABLE [dbo].[Appointments]  WITH CHECK ADD  CONSTRAINT [FK_Appointments_CancellationActors] FOREIGN KEY([CancelledById])
REFERENCES [dbo].[CancellationActors] ([Id])
GO
ALTER TABLE [dbo].[Appointments] CHECK CONSTRAINT [FK_Appointments_CancellationActors]
GO
ALTER TABLE [dbo].[Appointments]  WITH CHECK ADD  CONSTRAINT [FK_Appointments_Doctors] FOREIGN KEY([DoctorId])
REFERENCES [dbo].[Doctors] ([Id])
GO
ALTER TABLE [dbo].[Appointments] CHECK CONSTRAINT [FK_Appointments_Doctors]
GO
ALTER TABLE [dbo].[Appointments]  WITH CHECK ADD  CONSTRAINT [FK_Appointments_QueueStatuses] FOREIGN KEY([QueueStatusId])
REFERENCES [dbo].[QueueStatuses] ([Id])
GO
ALTER TABLE [dbo].[Appointments] CHECK CONSTRAINT [FK_Appointments_QueueStatuses]
GO
ALTER TABLE [dbo].[ClinicAdmins]  WITH CHECK ADD  CONSTRAINT [FK_ClinicAdmins_Users] FOREIGN KEY([Id])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[ClinicAdmins] CHECK CONSTRAINT [FK_ClinicAdmins_Users]
GO
ALTER TABLE [dbo].[Doctors]  WITH CHECK ADD  CONSTRAINT [FK_Doctors_Specialties] FOREIGN KEY([specialityId])
REFERENCES [dbo].[Specialties] ([Id])
GO
ALTER TABLE [dbo].[Doctors] CHECK CONSTRAINT [FK_Doctors_Specialties]
GO
ALTER TABLE [dbo].[Doctors]  WITH CHECK ADD  CONSTRAINT [FK_Doctors_Users] FOREIGN KEY([Id])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[Doctors] CHECK CONSTRAINT [FK_Doctors_Users]
GO
ALTER TABLE [dbo].[DoctorsClinics]  WITH CHECK ADD  CONSTRAINT [FK_DoctorsClinics_Clinics] FOREIGN KEY([ClinicId])
REFERENCES [dbo].[Clinics] ([Id])
GO
ALTER TABLE [dbo].[DoctorsClinics] CHECK CONSTRAINT [FK_DoctorsClinics_Clinics]
GO
ALTER TABLE [dbo].[DoctorsClinics]  WITH CHECK ADD  CONSTRAINT [FK_DoctorsClinics_Doctors1] FOREIGN KEY([DoctorId])
REFERENCES [dbo].[Doctors] ([Id])
GO
ALTER TABLE [dbo].[DoctorsClinics] CHECK CONSTRAINT [FK_DoctorsClinics_Doctors1]
GO
ALTER TABLE [dbo].[Images]  WITH CHECK ADD  CONSTRAINT [FK_Images_Doctors] FOREIGN KEY([DoctorId])
REFERENCES [dbo].[Doctors] ([Id])
GO
ALTER TABLE [dbo].[Images] CHECK CONSTRAINT [FK_Images_Doctors]
GO
ALTER TABLE [dbo].[MedicalDocuments]  WITH CHECK ADD  CONSTRAINT [FK_MedicalDocuments_MedicalRecords1] FOREIGN KEY([RecordId])
REFERENCES [dbo].[MedicalRecords] ([Id])
GO
ALTER TABLE [dbo].[MedicalDocuments] CHECK CONSTRAINT [FK_MedicalDocuments_MedicalRecords1]
GO
ALTER TABLE [dbo].[MedicalRecords]  WITH CHECK ADD  CONSTRAINT [FK_MedicalRecords_Appointments1] FOREIGN KEY([AppointmentId])
REFERENCES [dbo].[Appointments] ([Id])
GO
ALTER TABLE [dbo].[MedicalRecords] CHECK CONSTRAINT [FK_MedicalRecords_Appointments1]
GO
ALTER TABLE [dbo].[Notfications]  WITH CHECK ADD  CONSTRAINT [FK_Notfications_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[Notfications] CHECK CONSTRAINT [FK_Notfications_Users]
GO
ALTER TABLE [dbo].[Payments]  WITH CHECK ADD  CONSTRAINT [FK_Payments_Appointments] FOREIGN KEY([AppointmentId])
REFERENCES [dbo].[Appointments] ([Id])
GO
ALTER TABLE [dbo].[Payments] CHECK CONSTRAINT [FK_Payments_Appointments]
GO
ALTER TABLE [dbo].[Payments]  WITH CHECK ADD  CONSTRAINT [FK_Payments_PaymentMethods] FOREIGN KEY([PaymentMethodId])
REFERENCES [dbo].[PaymentMethods] ([Id])
GO
ALTER TABLE [dbo].[Payments] CHECK CONSTRAINT [FK_Payments_PaymentMethods]
GO
ALTER TABLE [dbo].[Payments]  WITH CHECK ADD  CONSTRAINT [FK_Payments_PaymentStatuses] FOREIGN KEY([PaymentStatusId])
REFERENCES [dbo].[PaymentStatuses] ([Id])
GO
ALTER TABLE [dbo].[Payments] CHECK CONSTRAINT [FK_Payments_PaymentStatuses]
GO
ALTER TABLE [dbo].[PlatformAdmins]  WITH CHECK ADD  CONSTRAINT [FK_PlatformAdmins_Users] FOREIGN KEY([Id])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[PlatformAdmins] CHECK CONSTRAINT [FK_PlatformAdmins_Users]
GO
ALTER TABLE [dbo].[Prescription]  WITH CHECK ADD  CONSTRAINT [FK_Prescription_MedicalRecords1] FOREIGN KEY([RecordId])
REFERENCES [dbo].[MedicalRecords] ([Id])
GO
ALTER TABLE [dbo].[Prescription] CHECK CONSTRAINT [FK_Prescription_MedicalRecords1]
GO
ALTER TABLE [dbo].[Profiles]  WITH CHECK ADD  CONSTRAINT [FK_Profiles_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[Profiles] CHECK CONSTRAINT [FK_Profiles_Users]
GO
ALTER TABLE [dbo].[RecordDiagnoses]  WITH CHECK ADD  CONSTRAINT [FK_RecordDiagnoses_ICD10Codes] FOREIGN KEY([ICD10Id])
REFERENCES [dbo].[ICD10Codes] ([Id])
GO
ALTER TABLE [dbo].[RecordDiagnoses] CHECK CONSTRAINT [FK_RecordDiagnoses_ICD10Codes]
GO
ALTER TABLE [dbo].[RecordDiagnoses]  WITH CHECK ADD  CONSTRAINT [FK_RecordDiagnoses_MedicalRecords] FOREIGN KEY([RecordId])
REFERENCES [dbo].[MedicalRecords] ([Id])
GO
ALTER TABLE [dbo].[RecordDiagnoses] CHECK CONSTRAINT [FK_RecordDiagnoses_MedicalRecords]
GO
ALTER TABLE [dbo].[Reviews]  WITH CHECK ADD  CONSTRAINT [FK_Reviews_DoctorPersonalityTypes] FOREIGN KEY([PersonalityTypeId])
REFERENCES [dbo].[DoctorPersonalityTypes] ([Id])
GO
ALTER TABLE [dbo].[Reviews] CHECK CONSTRAINT [FK_Reviews_DoctorPersonalityTypes]
GO
ALTER TABLE [dbo].[Reviews]  WITH CHECK ADD  CONSTRAINT [FK_Reviews_Doctors] FOREIGN KEY([DoctorId])
REFERENCES [dbo].[Doctors] ([Id])
GO
ALTER TABLE [dbo].[Reviews] CHECK CONSTRAINT [FK_Reviews_Doctors]
GO
ALTER TABLE [dbo].[SymptomAssessments]  WITH CHECK ADD  CONSTRAINT [FK_SymptomAssessments_AISeverityLevels] FOREIGN KEY([AISeverityId])
REFERENCES [dbo].[AISeverityLevels] ([Id])
GO
ALTER TABLE [dbo].[SymptomAssessments] CHECK CONSTRAINT [FK_SymptomAssessments_AISeverityLevels]
GO
ALTER TABLE [dbo].[SymptomAssessments]  WITH CHECK ADD  CONSTRAINT [FK_SymptomAssessments_Appointments] FOREIGN KEY([AppointmentId])
REFERENCES [dbo].[Appointments] ([Id])
GO
ALTER TABLE [dbo].[SymptomAssessments] CHECK CONSTRAINT [FK_SymptomAssessments_Appointments]
GO
ALTER TABLE [dbo].[Payments]  WITH CHECK ADD  CONSTRAINT [CK_Payments_Amount] CHECK  (([Amount]>=(0)))
GO
ALTER TABLE [dbo].[Payments] CHECK CONSTRAINT [CK_Payments_Amount]
GO
ALTER TABLE [dbo].[Reviews]  WITH CHECK ADD  CONSTRAINT [CK_Reviews] CHECK  (([Rating]>=(1) AND [Rating]<=(5)))
GO
ALTER TABLE [dbo].[Reviews] CHECK CONSTRAINT [CK_Reviews]

GO
ALTER DATABASE [MedicalAppointmentSystem] SET  READ_WRITE 
GO

SET IDENTITY_INSERT [dbo].[PaymentMethods] ON 
GO
INSERT [dbo].[PaymentMethods] ([Id], [NameEn], [NameAr]) VALUES (1, N'Cash', N'كاش')
GO
INSERT [dbo].[PaymentMethods] ([Id], [NameEn], [NameAr]) VALUES (2, N'Credit Card', N'بطاقة ائتمان')
GO
INSERT [dbo].[PaymentMethods] ([Id], [NameEn], [NameAr]) VALUES (3, N'Wallet', N'محفظة إلكترونية')
GO
INSERT [dbo].[PaymentMethods] ([Id], [NameEn], [NameAr]) VALUES (4, N'Insurance', N'تأمين')
GO
SET IDENTITY_INSERT [dbo].[PaymentMethods] OFF
GO
SET IDENTITY_INSERT [dbo].[PaymentStatuses] ON 
GO
INSERT [dbo].[PaymentStatuses] ([Id], [Name]) VALUES (2, N'paid')
GO
INSERT [dbo].[PaymentStatuses] ([Id], [Name]) VALUES (4, N'partially-refunded')
GO
INSERT [dbo].[PaymentStatuses] ([Id], [Name]) VALUES (3, N'refunded')
GO
INSERT [dbo].[PaymentStatuses] ([Id], [Name]) VALUES (1, N'unpaid')
GO
SET IDENTITY_INSERT [dbo].[PaymentStatuses] OFF
GO
SET IDENTITY_INSERT [dbo].[AppointmentTypes] ON 
GO
INSERT [dbo].[AppointmentTypes] ([Id], [Name]) VALUES (4, N'chronic-care')
GO
INSERT [dbo].[AppointmentTypes] ([Id], [Name]) VALUES (2, N'emergency')
GO
INSERT [dbo].[AppointmentTypes] ([Id], [Name]) VALUES (3, N'follow-up')
GO
INSERT [dbo].[AppointmentTypes] ([Id], [Name]) VALUES (1, N'normal')
GO
SET IDENTITY_INSERT [dbo].[AppointmentTypes] OFF
GO
SET IDENTITY_INSERT [dbo].[AppointmentStatuses] ON 
GO
INSERT [dbo].[AppointmentStatuses] ([Id], [Name]) VALUES (5, N'cancelled')
GO
INSERT [dbo].[AppointmentStatuses] ([Id], [Name]) VALUES (4, N'completed')
GO
INSERT [dbo].[AppointmentStatuses] ([Id], [Name]) VALUES (2, N'confirmed')
GO
INSERT [dbo].[AppointmentStatuses] ([Id], [Name]) VALUES (3, N'in-session')
GO
INSERT [dbo].[AppointmentStatuses] ([Id], [Name]) VALUES (6, N'no-show')
GO
INSERT [dbo].[AppointmentStatuses] ([Id], [Name]) VALUES (1, N'pending')
GO
INSERT [dbo].[AppointmentStatuses] ([Id], [Name]) VALUES (7, N'rescheduled')
GO
SET IDENTITY_INSERT [dbo].[AppointmentStatuses] OFF
GO
SET IDENTITY_INSERT [dbo].[CancellationActors] ON 
GO
INSERT [dbo].[CancellationActors] ([Id], [Name]) VALUES (2, N'doctor')
GO
INSERT [dbo].[CancellationActors] ([Id], [Name]) VALUES (1, N'patient')
GO
INSERT [dbo].[CancellationActors] ([Id], [Name]) VALUES (3, N'system')
GO
SET IDENTITY_INSERT [dbo].[CancellationActors] OFF
GO
SET IDENTITY_INSERT [dbo].[QueueStatuses] ON 
GO
INSERT [dbo].[QueueStatuses] ([Id], [Name]) VALUES (2, N'called')
GO
INSERT [dbo].[QueueStatuses] ([Id], [Name]) VALUES (4, N'done')
GO
INSERT [dbo].[QueueStatuses] ([Id], [Name]) VALUES (3, N'in-session')
GO
INSERT [dbo].[QueueStatuses] ([Id], [Name]) VALUES (1, N'waiting')
GO
SET IDENTITY_INSERT [dbo].[QueueStatuses] OFF
GO
SET IDENTITY_INSERT [dbo].[BookingSources] ON 
GO
INSERT [dbo].[BookingSources] ([Id], [Name]) VALUES (1, N'app')
GO
INSERT [dbo].[BookingSources] ([Id], [Name]) VALUES (3, N'emergency')
GO
INSERT [dbo].[BookingSources] ([Id], [Name]) VALUES (2, N'web')
GO
SET IDENTITY_INSERT [dbo].[BookingSources] OFF
GO
SET IDENTITY_INSERT [dbo].[Specialties] ON 
GO
INSERT [dbo].[Specialties] ([Id], [NameEn], [NameAr]) VALUES (1, N'General Practice', N'طب عام')
GO
INSERT [dbo].[Specialties] ([Id], [NameEn], [NameAr]) VALUES (2, N'Cardiology', N'أمراض القلب')
GO
INSERT [dbo].[Specialties] ([Id], [NameEn], [NameAr]) VALUES (3, N'Dermatology', N'أمراض الجلدية')
GO
INSERT [dbo].[Specialties] ([Id], [NameEn], [NameAr]) VALUES (4, N'Orthopedics', N'العظام والمفاصل')
GO
INSERT [dbo].[Specialties] ([Id], [NameEn], [NameAr]) VALUES (5, N'Neurology', N'أمراض المخ والأعصاب')
GO
INSERT [dbo].[Specialties] ([Id], [NameEn], [NameAr]) VALUES (6, N'Psychiatry', N'الطب النفسي')
GO
INSERT [dbo].[Specialties] ([Id], [NameEn], [NameAr]) VALUES (7, N'Ophthalmology', N'أمراض العيون')
GO
INSERT [dbo].[Specialties] ([Id], [NameEn], [NameAr]) VALUES (8, N'ENT', N'أنف وأذن وحنجرة')
GO
INSERT [dbo].[Specialties] ([Id], [NameEn], [NameAr]) VALUES (9, N'Gastroenterology', N'الجهاز الهضمي')
GO
INSERT [dbo].[Specialties] ([Id], [NameEn], [NameAr]) VALUES (10, N'Endocrinology', N'الغدد الصماء')
GO
INSERT [dbo].[Specialties] ([Id], [NameEn], [NameAr]) VALUES (11, N'Pulmonology', N'أمراض الصدر والتنفس')
GO
INSERT [dbo].[Specialties] ([Id], [NameEn], [NameAr]) VALUES (12, N'Nephrology', N'أمراض الكلى')
GO
INSERT [dbo].[Specialties] ([Id], [NameEn], [NameAr]) VALUES (13, N'Urology', N'المسالك البولية')
GO
INSERT [dbo].[Specialties] ([Id], [NameEn], [NameAr]) VALUES (14, N'Gynecology', N'أمراض النساء والتوليد')
GO
INSERT [dbo].[Specialties] ([Id], [NameEn], [NameAr]) VALUES (15, N'Pediatrics', N'طب الأطفال')
GO
INSERT [dbo].[Specialties] ([Id], [NameEn], [NameAr]) VALUES (16, N'Oncology', N'أمراض الأورام')
GO
INSERT [dbo].[Specialties] ([Id], [NameEn], [NameAr]) VALUES (17, N'Rheumatology', N'أمراض الروماتيزم')
GO
INSERT [dbo].[Specialties] ([Id], [NameEn], [NameAr]) VALUES (18, N'Hematology', N'أمراض الدم')
GO
INSERT [dbo].[Specialties] ([Id], [NameEn], [NameAr]) VALUES (19, N'Radiology', N'الأشعة')
GO
INSERT [dbo].[Specialties] ([Id], [NameEn], [NameAr]) VALUES (20, N'Anesthesiology', N'التخدير')
GO
INSERT [dbo].[Specialties] ([Id], [NameEn], [NameAr]) VALUES (21, N'Emergency Medicine', N'طب الطوارئ')
GO
INSERT [dbo].[Specialties] ([Id], [NameEn], [NameAr]) VALUES (22, N'Internal Medicine', N'الباطنة')
GO
INSERT [dbo].[Specialties] ([Id], [NameEn], [NameAr]) VALUES (23, N'Plastic Surgery', N'الجراحة التجميلية')
GO
INSERT [dbo].[Specialties] ([Id], [NameEn], [NameAr]) VALUES (24, N'General Surgery', N'الجراحة العامة')
GO
INSERT [dbo].[Specialties] ([Id], [NameEn], [NameAr]) VALUES (25, N'Vascular Surgery', N'جراحة الأوعية الدموية')
GO
INSERT [dbo].[Specialties] ([Id], [NameEn], [NameAr]) VALUES (26, N'Dentistry', N'طب الأسنان')
GO
INSERT [dbo].[Specialties] ([Id], [NameEn], [NameAr]) VALUES (27, N'Nutrition', N'التغذية العلاجية')
GO
INSERT [dbo].[Specialties] ([Id], [NameEn], [NameAr]) VALUES (28, N'Physical Therapy', N'العلاج الطبيعي')
GO
SET IDENTITY_INSERT [dbo].[Specialties] OFF
GO
SET IDENTITY_INSERT [dbo].[AISeverityLevels] ON 
GO
INSERT [dbo].[AISeverityLevels] ([Id], [NameEn], [NameAr]) VALUES (1, N'non-urgent', N'غير عاجل')
GO
INSERT [dbo].[AISeverityLevels] ([Id], [NameEn], [NameAr]) VALUES (2, N'urgent', N'عاجل')
GO
SET IDENTITY_INSERT [dbo].[AISeverityLevels] OFF
GO
SET IDENTITY_INSERT [dbo].[DoctorPersonalityTypes] ON 
GO
INSERT [dbo].[DoctorPersonalityTypes] ([Id], [NameEn], [NameAr]) VALUES (1, N'Friendly', N'ودود')
GO
INSERT [dbo].[DoctorPersonalityTypes] ([Id], [NameEn], [NameAr]) VALUES (2, N'Talkative', N'يتحدث كثيرًا')
GO
INSERT [dbo].[DoctorPersonalityTypes] ([Id], [NameEn], [NameAr]) VALUES (3, N'Strict', N'حازم')
GO
INSERT [dbo].[DoctorPersonalityTypes] ([Id], [NameEn], [NameAr]) VALUES (4, N'Professional', N'احترافي')
GO
INSERT [dbo].[DoctorPersonalityTypes] ([Id], [NameEn], [NameAr]) VALUES (5, N'Patient', N'صبور')
GO
INSERT [dbo].[DoctorPersonalityTypes] ([Id], [NameEn], [NameAr]) VALUES (6, N'Good Listener', N'مستمع جيد')
GO
INSERT [dbo].[DoctorPersonalityTypes] ([Id], [NameEn], [NameAr]) VALUES (7, N'Direct', N'مباشر')
GO
INSERT [dbo].[DoctorPersonalityTypes] ([Id], [NameEn], [NameAr]) VALUES (8, N'Reassuring', N'مطمئن')
GO
INSERT [dbo].[DoctorPersonalityTypes] ([Id], [NameEn], [NameAr]) VALUES (9, N'Empathetic', N'متعاطف')
GO
INSERT [dbo].[DoctorPersonalityTypes] ([Id], [NameEn], [NameAr]) VALUES (10, N'Detailed Explainer', N'يشرح بالتفصيل')
GO
SET IDENTITY_INSERT [dbo].[DoctorPersonalityTypes] OFF
GO

