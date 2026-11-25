DROP TABLE IF EXISTS CUSTOMER CASCADE;
CREATE TABLE Customer (
    C_ID NUMERIC(5) PRIMARY KEY,
    FName VARCHAR(10) NOT NULL,
    Minit VARCHAR(10),
    LName VARCHAR(10) NOT NULL,
    Phone_no NUMERIC(20),
    Street_name VARCHAR(100),
    Building_no NUMERIC(20),
    Apartement_no NUMERIC(20),
    Email VARCHAR(150) UNIQUE
);

DROP TABLE IF EXISTS Employee CASCADE;
CREATE TABLE Employee (
    E_ID NUMERIC (50) PRIMARY KEY,
	SSN NUMERIC (14) UNIQUE,
	GENDER VARCHAR(1) CHECK (GENDER = 'M' or GENDER = 'F'),
    FName VARCHAR(50) NOT NULL,
    Minit VARCHAR(10),
    LName VARCHAR(50) NOT NULL,
    Phone_no VARCHAR(20),
    Street_name VARCHAR(100),
    Building_no VARCHAR(20),
    Apartement_no VARCHAR(20),
    Email VARCHAR(150) UNIQUE,
	Salary NUMERIC(9) CHECK (Salary > 0) ,
	Specialization VARCHAR(10) CHECK(Specialization IN ('tech' , 'Non_tech')) ,
	supervisor_SSN NUMERIC(14) ,
	CONSTRAINT fk_employee_supervisor
	FOREIGN KEY (Supervisor_SSN)
	REFERENCES Employee(SSN)
	ON DELETE SET NULL
	ON UPDATE CASCADE
);

DROP TABLE IF EXISTS Device CASCADE;
CREATE TABLE Device (
Serial_no NUMERIC(100) PRIMARY KEY , 
device_name VARCHAR(20) NOT NULL ,
Brand VARCHAR(10) ,
Model VARCHAR(20) 
);

DROP TABLE IF EXISTS Inventory CASCADE;
CREATE TABLE Inventory (
inventory_number NUMERIC(3) PRIMARY KEY ,
Locationn VARCHAR(20) , 
Capacity NUMERIC(3) CHECK(Capacity>=0)
);

DROP TABLE IF EXISTS Spare_part CASCADE;
CREATE TABLE Spare_part (
code NUMERIC(100) PRIMARY KEY , 
part_name VARCHAR(20) NOT NULL ,
Brand VARCHAR(10) ,
Model VARCHAR(10) ,
price NUMERIC(9) , CHECK (price > 0 ),
Warranty VARCHAR(50) ,
Supplier_name VARCHAR(15) ,
Supplier_Email VARCHAR(20),
Quantity NUMERIC(1000) CHECK(Quantity > 0) ,
inventory_number NUMERIC (3),
CONSTRAINT fk_spare_part_inventory
FOREIGN KEY (inventory_number)
REFERENCES
Inventory(inventory_number)
ON DELETE CASCADE
ON UPDATE CASCADE
);

DROP TABLE IF EXISTS Service_request CASCADE;
CREATE TABLE Service_request(
Request_ID NUMERIC(4) PRIMARY KEY ,
Status VARCHAR(10) ,
Technician VARCHAR(20) NOT NULL ,
Submission_date date ,
Fee NUMERIC (1000 , 2 ) ,
Malfunction VARCHAR(100) ,
 C_ID NUMERIC(5) ,
 Serial_no NUMERIC(100) ,
 Employee_SSN NUMERIC (14) ,
 CONSTRAINT fk_service_customer
 FOREIGN KEY(C_ID)
 REFERENCES
 Customer(C_ID)
 ON DELETE CASCADE
 ON UPDATE CASCADE ,
 
 CONSTRAINT fk_service_device
 FOREIGN KEY (serial_no)
 REFERENCES
 Device(serial_no)
 ON DELETE CASCADE
 ON UPDATE CASCADE ,

 CONSTRAINT fk_service_employee
 FOREIGN KEY (Employee_SSN)
 REFERENCES
 Employee(SSN)
 ON DELETE SET NULL
 ON UPDATE CASCADE
);

INSERT INTO Customer (C_ID, FName, Minit, LName, Phone_no, Street_name, Building_no, Apartement_no, Email) VALUES
(1, 'Ahmed', 'M', 'Ali', 01012345678, 'Tahrir St', 12, 4, 'ahmed.ali@email.com'),
(2, 'Sara', 'A', 'Hassan', 01198765432, 'Nile St', 45, 12, 'sara.hassan@email.com');

INSERT INTO Device (Serial_no, device_name, Model, Brand) VALUES
(9981, 'COFFE MACHINE', 'Latitude', 'TOSHIPA'),
(4422, 'Smartphone', ' GHALIYAS PHONE ', 'APPLE');

INSERT INTO Employee (E_ID, SSN, GENDER, FName, Minit, LName, Phone_no, Street_name, Building_no, Apartement_no, Email, Salary, Specialization, supervisor_SSN) VALUES
(101, 29501011234567, 'M', 'Mahmoud', 'S', 'Ibrahim', '01234567890', 'Haram St', 'Tower A', '3', 'mahmoud.ibrahim@company.com', 8500.00, 'tech', NULL),
(102, 29805059876543, 'F', 'Mona', 'K', 'Nabil', '01512347890', 'Dokki St', 'Building B', '5', 'mona.nabil@company.com', 6000.00, 'Non_tech', 29501011234567);

INSERT INTO Inventory (inventory_number, Locationn, Capacity) VALUES
(1, 'Main Warehouse', 500),
(2, 'Secondary Store', 200);

INSERT INTO Spare_part (code, part_name, Brand, Model, price, Warranty, Supplier_name, Supplier_Email, Quantity, inventory_number) VALUES
(101, 'RAM 8GB', 'DDR4', 'ModelA', 1200.00, '1 Year', 'Tech Solutions', 'sales@tech.com', 50, 1),
(102, 'Phone Screen', 'OLED', 'A52', 2500.00, '6 Months', 'Global Spares', 'contact@global.com', 20, 2);

INSERT INTO Service_request (Request_ID, Status, Technician, Submission_date, Fee, Malfunction, C_ID, Serial_no, Employee_SSN) VALUES
(1, 'In_Prog', 'Mahmoud', '2026-10-01', 300.00, 'Device not turning on', 1, 9981, 29501011234567),
(2, 'Pending', 'Mahmoud', '2026-10-02', 150.00, 'Broken screen', 2, 4422, 29501011234567);

SELECT *
FROM Spare_part







