Create database Psyliq_intern;
use Psyliq_intern;
show tables;

select * from diabetes_prediction;

-- 1. Retrieve the Patient_id and ages of all patients.

select patient_id, age from diabetes_prediction;

-- 2. Select all female patients who are older than 40.

select * from diabetes_prediction where gender = 'Female' and Age > 40;

-- 3. Calculate the average BMI of patients.

select round(avg(bmi),3) as average_BMI from diabetes_prediction;

-- 4. List patients in descending order of blood glucose levels.

select * from diabetes_prediction order by blood_glucose_level desc;

-- 5. Find patients who have hypertension and diabetes.

select * from diabetes_prediction where hypertension = 1 and diabetes = 1;

-- 6. Determine the number of patients with heart disease.

select * from diabetes_prediction where heart_disease = 1;

-- 7. Group patients by smoking history and count how many smokers and non smokers there are.

select smoking_history,count(*) as total_count from diabetes_prediction group by 1;

-- 8. Retrieve the Patient_ids of patients who have a BMI greater than the average BMI.

select patient_id, BMI from diabetes_prediction where BMI > (select avg(BMI) from diabetes_prediction);

-- 9. Find the patient with the highest HbA1c level and the patient with the lowest HbA1clevel.

# patient with the highest HbA1c level
select * from diabetes_prediction where hba1c_level = (select max(hba1c_level) from diabetes_prediction);

# patient with the lowest HbA1c level
select * from diabetes_prediction where hba1c_level = (select min(hba1c_level) from diabetes_prediction);

-- 10. Calculate the age of patients in years (assuming the current date as of now).

select patient_id, timestampdiff(year,dob,getdata()) as age from diabetes_prediction;

-- 11. Rank patients by blood glucose level within each gender group.
select patient_id, gender, blood_glucose_level,
rank() over(partition by gender order by blood_glucose_level desc) as glucose_rank
from diabetes_prediction;

-- 12. Update the smoking history of patients who are older than 50 to "Ex-smoker."

update diabetes_prediction set smoking_history = "Ex-smoker" where age > 50;
select * from diabetes_prediction where age > 50;

-- 13. Insert a new patient into the database with sample data.

insert into diabetes_prediction (Employeename, Patient_id, gender, Age, Hypertension, Heart_disease, Smoking_history, BMI, HbA1c_level, Blood_glucose_level, Diabetes)
values ("Jeniffer Lawrence De","PT50101","Female",35,0,0,"never",25.55,7,175,0);

-- 14. Delete all patients with heart disease from the database.

delete from diabetes_prediction where heart_disease = 1;

-- 15. Find patients who have hypertension but not diabetes using the EXCEPT operator.

select patient_id from diabetes_prediction where hypertension = 1
except
select patient_id from diabetes_prediction where diabetes = 0;

-- 16. Define a unique constraint on the "patient_id" column to ensure its values are unique.
select * from diabetes_prediction;

alter table diabetes_prediction add constraint unique_patient_id unique(patient_id);

-- 17. Create a view that displays the Patient_ids, ages, and BMI of patients.

create view Patients_data as( select patient_id,age,bmi from diabetes_prediction);
select * from patients_data;

-- 18. Suggest improvements in the database schema to reduce data redundancy and improve data integrity. 

/*  Normalize tables: create a table for patient’s demographics and other for
 health parameters, adding the date to each record to track the patient’s
 health status.
  Use primary and foreign keys to relate each table and avoid duplicates.
  Use appropiate data types to make sure that the new data registered is
consistent to the requested information.
  Apply constraints like NOT NULL to the columns that must be filled.
  Delete redundant columns: analyze the information in each column to decide
if is really important to keep or if we can obtain similar information from
another variable.*/


-- 19. Explain how you can optimize the performance of SQL queries on this dataset.
/* Select only the columns needed, and not all of them.
   Use efficiently the WHERE clause to work with only the necessary records.
   Prefer the use of joins instead of subqueries whenever it’s posible.
   Use stored procedures when creating complex instructions.
   Use windows to work with the data of interest.
   Create indexes in columns frequently used inside the WHERE clause or joins.*/