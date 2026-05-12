CREATE DATABASE MedicalDW;
GO

USE MedicalDW;
GO
-- Dimension Tables
CREATE TABLE DimDoctor (
    DoctorKey INT IDENTITY PRIMARY KEY,
    DoctorId NVARCHAR(450),
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Speciality NVARCHAR(100)
);

CREATE TABLE DimPatient (
    PatientKey INT IDENTITY PRIMARY KEY,
    PatientId NVARCHAR(450),
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    BirthDate DATE,
    Gender BIT
);

CREATE TABLE DimClinic (
    ClinicKey INT IDENTITY PRIMARY KEY,
    ClinicId INT,
    City NVARCHAR(50),
    District NVARCHAR(50)
);

CREATE TABLE DimDate (
    DateKey INT PRIMARY KEY,
    FullDate DATE,
    Year INT,
    Month INT,
    Day INT
);

CREATE TABLE DimAppointmentStatus (
    StatusKey INT IDENTITY PRIMARY KEY,
    StatusId INT,
    StatusName VARCHAR(50)
);

CREATE TABLE DimAppointmentType (
    TypeKey INT IDENTITY PRIMARY KEY,
    TypeId INT,
    TypeName VARCHAR(50)
);

CREATE TABLE DimPaymentMethod (
    MethodKey INT IDENTITY PRIMARY KEY,
    MethodId INT,
    MethodName NVARCHAR(50)
);

CREATE TABLE DimPaymentStatus (
    PayStatusKey INT IDENTITY PRIMARY KEY,
    StatusId INT,
    StatusName NVARCHAR(50)
);

-- Fact Table
CREATE TABLE FactAppointments (
    AppointmentKey INT IDENTITY PRIMARY KEY,
    AppointmentId INT,
    DoctorKey INT,
    PatientKey INT,
    ClinicKey INT,
    DateKey INT,
    TypeKey INT,
    StatusKey INT,
    MethodKey INT,
    PayStatusKey INT,
    FeeAmount DECIMAL(10,2),
    PaidAmount DECIMAL(10,2),
    FOREIGN KEY (DoctorKey) REFERENCES DimDoctor(DoctorKey),
    FOREIGN KEY (PatientKey) REFERENCES DimPatient(PatientKey),
    FOREIGN KEY (ClinicKey) REFERENCES DimClinic(ClinicKey),
    FOREIGN KEY (DateKey) REFERENCES DimDate(DateKey),
    FOREIGN KEY (TypeKey) REFERENCES DimAppointmentType(TypeKey),
    FOREIGN KEY (StatusKey) REFERENCES DimAppointmentStatus(StatusKey),
    FOREIGN KEY (MethodKey) REFERENCES DimPaymentMethod(MethodKey),
    FOREIGN KEY (PayStatusKey) REFERENCES DimPaymentStatus(PayStatusKey)
);



-- Doctor Dimension
INSERT INTO MedicalDW.dbo.DimDoctor (DoctorId, FirstName, LastName, Speciality)
SELECT 
    d.Id, 
    d.FirstName, 
    d.LastName, 
    s.NameEn
FROM MedicalAppointmentSystem.dbo.Doctors d
JOIN MedicalAppointmentSystem.dbo.Specialties s 
    ON d.specialityId = s.Id;
-- Patient Dimension
INSERT INTO MedicalDW.dbo.DimPatient (PatientId, FirstName, LastName, BirthDate, Gender)
SELECT 
    u.Id, 
    p.FirstName, 
    p.LastName, 
    p.BirthDate, 
    p.Gender
FROM MedicalAppointmentSystem.dbo.Profiles p
JOIN MedicalAppointmentSystem.dbo.Users u 
    ON p.UserId = u.Id
WHERE NOT EXISTS (
    SELECT 1 
    FROM MedicalDW.dbo.DimPatient dp 
    WHERE dp.PatientId = u.Id
);

-- Clinic Dimension
INSERT INTO MedicalDW.dbo.DimClinic (ClinicId, City, District)
SELECT 
    c.Id, 
    a.City, 
    a.District
FROM MedicalAppointmentSystem.dbo.Clinics c
JOIN MedicalAppointmentSystem.dbo.Addresses a 
    ON c.Id = a.ClinicId
WHERE NOT EXISTS (
    SELECT 1 
    FROM MedicalDW.dbo.DimClinic dc 
    WHERE dc.ClinicId = c.Id
);
-- Date Dimension (populate separately with calendar table)
INSERT INTO MedicalDW.dbo.DimDate (DateKey, FullDate, Year, Month, Day)
SELECT DISTINCT
    CONVERT(INT, FORMAT(a.ScheduledAt,'yyyyMMdd')),
    CAST(a.ScheduledAt AS DATE),
    YEAR(a.ScheduledAt), 
    MONTH(a.ScheduledAt),
    DAY(a.ScheduledAt)
FROM MedicalAppointmentSystem.dbo.Appointments a;
-- Appointment Status Dimension
INSERT INTO MedicalDW.dbo.DimAppointmentStatus (StatusId, StatusName)
SELECT Id, Name 
FROM MedicalAppointmentSystem.dbo.AppointmentStatuses;
-- Appointment Type Dimension
INSERT INTO MedicalDW.dbo.DimAppointmentType (TypeId, TypeName)
SELECT Id, Name 
FROM MedicalAppointmentSystem.dbo.AppointmentTypes;
-- Payment Method Dimension
INSERT INTO MedicalDW.dbo.DimPaymentMethod (MethodId, MethodName)
SELECT Id, NameEn 
FROM MedicalAppointmentSystem.dbo.PaymentMethods;

-- Payment Status Dimension
INSERT INTO MedicalDW.dbo.DimPaymentStatus (StatusId, StatusName)
SELECT Id, Name 
FROM MedicalAppointmentSystem.dbo.PaymentStatuses;

-- Fact Table
INSERT INTO MedicalDW.dbo.FactAppointments (
    AppointmentId,
    DoctorKey,
    PatientKey,
    ClinicKey,
    DateKey,
    TypeKey,
    StatusKey,
    MethodKey,
    PayStatusKey,
    FeeAmount,
    PaidAmount
)
SELECT 
    a.Id,
    d.DoctorKey,
    p.PatientKey,
    c.ClinicKey,
    CONVERT(INT, FORMAT(a.ScheduledAt,'yyyyMMdd')),
    t.TypeKey,
    s.StatusKey,
    pm.MethodKey,
    ps.PayStatusKey,
    a.FeeAmount,
    ISNULL(pay.Amount, 0)
FROM MedicalAppointmentSystem.dbo.Appointments a
JOIN MedicalDW.dbo.DimDoctor d ON a.DoctorId = d.DoctorId
JOIN MedicalDW.dbo.DimPatient p ON a.PatientId = p.PatientId
JOIN MedicalDW.dbo.DimClinic c ON a.ClinicId = c.ClinicId
JOIN MedicalDW.dbo.DimAppointmentType t ON a.AppointmentTypeId = t.TypeId
JOIN MedicalDW.dbo.DimAppointmentStatus s ON a.StatusId = s.StatusId
LEFT JOIN MedicalAppointmentSystem.dbo.Payments pay ON a.Id = pay.AppointmentId
LEFT JOIN MedicalDW.dbo.DimPaymentMethod pm ON pay.PaymentMethodId = pm.MethodId
LEFT JOIN MedicalDW.dbo.DimPaymentStatus ps ON pay.PaymentStatusId = ps.StatusId;
