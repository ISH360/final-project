CREATE DATABASE hospital_portal;
USE hospital_portal;
CREATE TABLE patients (
    patient_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    patient_name VARCHAR(45) NOT NULL,
    age INT NOT NULL,
    admission_date DATE,
    discharge_date DATE
);
CREATE TABLE appointments (
    appointment_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATE NOT NULL,
    appointment_time DECIMAL NOT NULL,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
);
INSERT INTO patients (patient_name, age, admission_date, discharge_date) 
VALUES 
    ('John Doe', 35, '2023-01-01', '2023-01-10'),
    ('Jane Smith', 45, '2023-02-15', '2023-03-01'),
    ('Bob Johnson', 28, '2023-03-10', '2023-03-20');
DELIMITER //
CREATE PROCEDURE ScheduleAppointment(
    IN patientID INT,
    IN doctorID INT,
    IN appDate DATE,
    IN appTime DECIMAL
)
BEGIN
    INSERT INTO appointments (patient_id, doctor_id, appointment_date, appointment_time)
    VALUES (patientID, doctorID, appDate, appTime);
END //
DELIMITER ;
DELIMITER //
CREATE PROCEDURE DischargePatient(
    IN patientID INT
)
BEGIN
    UPDATE patients SET discharge_date = CURRENT_DATE() WHERE patient_id = patientID;
END //
DELIMITER ;
CREATE TABLE doctors (
    doctor_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    doctor_name VARCHAR(45) NOT NULL,
    specialty VARCHAR(45) NOT NULL
);

INSERT INTO doctors (doctor_name, specialty) VALUES
    ('Dr. wall', 'Cardiology'),
    ('Dr. russ', 'Orthopedics'),
    ('Dr. bron', 'Pediatrics');
CREATE VIEW doctor_appointment_patient AS
SELECT 
    a.appointment_id,
    p.patient_id,
    p.patient_name,
    p.age,
    p.admission_date,
    p.discharge_date,
    d.doctor_id,
    a.appointment_date,
    a.appointment_time
FROM appointments a
JOIN patients p ON a.patient_id = p.patient_id
JOIN doctors d ON a.doctor_id = d.doctor_id;

call scheduleappointment(1,3,"2023-10-04","12.30");

select * from appointments 


call DischargePatient
