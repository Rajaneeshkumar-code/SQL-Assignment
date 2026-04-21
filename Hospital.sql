Drop table if exists hospital;
CREATE TABLE hospital (
    hospital_name VARCHAR(100),
    location VARCHAR(100),
    department VARCHAR(100),
    doctors_count INT,
    patients_count INT,
    admission_date DATE,
    discharge_date DATE,
    medical_expenses NUMERIC(10,2)
);
select * from hospital;
	copy hospital(hospital_name,location,department,doctors_count,patients_count,admission_date,
	discharge_date,medical_expenses)
	from 'F:\Postgres_sql\Hospital_Data.csv'
	DELIMITER ','
	csv HEADER;
-- 1. Write an SQL query to find the total number of patients across all hospitals. 

select sum(patients_count) from hospital ;
 
-- 2.Retrieve the average count of doctors available in each hospital.
select hospital_name,avg(doctors_count) AS Average_Doctor from hospital group by hospital_name;
 
---3. Find the top 3 hospital departments that have the highest number of patients. 
 select hospital_name ,patients_count from hospital  order by patients_count DESC LIMIT 3; 
--4.Identify the hospital that recorded the highest medical expenses. 
select hospital_name,medical_expenses from hospital order by medical_expenses DESC LIMIT 1;

--5.Calculate the average medical expenses per day for each hospital. 
select hospital_name,avg(medical_expenses) from hospital group by hospital_name;

--6. Find the patient with the longest stay by calculating the difference between Discharge Date and Admission Date.
 
SELECT  
    admission_Date, 
    discharge_Date,
    discharge_date - admission_date AS StayDuration
FROM hospital
ORDER BY StayDuration DESC
LIMIT 1;
--7.Count the total number of patients treated in each city. 
select location,sum(patients_count) as Total_Patients from hospital group by location;

--8.Calculate the average number of days patients spend in each department. 
SELECT 
    department, 
    AVG(discharge_date - admission_date) AS TotalStayDays
FROM hospital
GROUP BY department;

--9.Find the department with the least number of patients. 
select department,min(patients_count) as MinPatient from hospital group by department ORDER BY MinPatient ASC LIMIT 1 ;

--10.Group the data by month and calculate the total medical expenses for each month.
select extract(MONTH FROM admission_date) As MONTH
,sum(medical_expenses) from hospital  group by extract(MONTH FROM admission_date) Order by MONTH;

	