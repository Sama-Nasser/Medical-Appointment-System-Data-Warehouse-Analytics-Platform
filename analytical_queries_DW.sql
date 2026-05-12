USE MedicalDW

-- Total appointments per doctor
SELECT d.FirstName, d.LastName, COUNT(*) AS Total_Appointments
FROM FactAppointments f
JOIN DimDoctor d ON f.DoctorKey = d.DoctorKey
GROUP BY d.FirstName, d.LastName;

-- Monthly appointment trends
SELECT dd.Year, dd.Month, COUNT(*) AS Monthly_Appointments
FROM FactAppointments f
JOIN DimDate dd ON f.DateKey = dd.DateKey
GROUP BY dd.Year, dd.Month
ORDER BY dd.Year, dd.Month;

-- Appointment status distribution
SELECT s.StatusName, COUNT(*) AS Status_Count
FROM FactAppointments f
JOIN DimAppointmentStatus s ON f.StatusKey = s.StatusKey
GROUP BY s.StatusName;

-- Most common specialties
SELECT d.Speciality, COUNT(*) AS Appointment_Count
FROM FactAppointments f
JOIN DimDoctor d ON f.DoctorKey = d.DoctorKey
GROUP BY d.Speciality
ORDER BY Appointment_Count DESC;

-- Completion Rate per Doctor
SELECT 
    d.FirstName,
    d.LastName,
    COUNT(*) AS TotalAppointments,
    SUM(CASE WHEN s.StatusName = 'completed' THEN 1 ELSE 0 END) AS Completed_Appointments,
    CAST(
        100.0 * SUM(CASE WHEN s.StatusName = 'completed' THEN 1 ELSE 0 END) 
        / COUNT(*) 
        AS DECIMAL(5,2)
    ) AS Completion_Rate
FROM FactAppointments f
JOIN DimDoctor d ON f.DoctorKey = d.DoctorKey
JOIN DimAppointmentStatus s ON f.StatusKey = s.StatusKey
GROUP BY d.FirstName, d.LastName;

-- Average Revenue per Appointment by Clinic
SELECT 
    c.City,
    COUNT(*) AS TotalAppointments,
    SUM(f.PaidAmount) AS Total_Revenue,
    AVG(f.PaidAmount) AS AvgRevenue_PerAppointment
FROM FactAppointments f
JOIN DimClinic c ON f.ClinicKey = c.ClinicKey
GROUP BY c.City;

-- Peak Booking Day of Week
SELECT 
    DATENAME(WEEKDAY, dd.FullDate) AS DayName,
    COUNT(*) AS Total_Appointments
FROM FactAppointments f
JOIN DimDate dd ON f.DateKey = dd.DateKey
GROUP BY DATENAME(WEEKDAY, dd.FullDate)
ORDER BY Total_Appointments DESC;

-- Average Fee by Appointment Type
SELECT 
    t.TypeName,
    AVG(f.FeeAmount) AS Average_Fee
FROM FactAppointments f
JOIN DimAppointmentType t ON f.TypeKey = t.TypeKey
GROUP BY t.TypeName;

-- Payment Method Preference
SELECT 
    m.MethodName,
    COUNT(*) AS Usage_Count,
    SUM(f.PaidAmount) AS Total_Paid
FROM FactAppointments f
JOIN DimPaymentMethod m ON f.MethodKey = m.MethodKey
GROUP BY m.MethodName
ORDER BY Usage_Count DESC;

-- Doctor Performance (Revenue Generated)
SELECT 
    d.FirstName,
    d.LastName,
    SUM(f.PaidAmount) AS Total_Revenue
FROM FactAppointments f
JOIN DimDoctor d ON f.DoctorKey = d.DoctorKey
GROUP BY d.FirstName, d.LastName
ORDER BY Total_Revenue DESC;


