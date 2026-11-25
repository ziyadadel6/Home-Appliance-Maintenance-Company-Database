# Home Appliance Maintenance Database

A PostgreSQL schema for a home-appliance maintenance company. It covers customers, employees, devices, spare parts, inventory and service requests.

## Tables

| Table | Description |
|-------|-------------|
| `Customer` | Customer details: name, phone, address and email (unique). |
| `Employee` | Employee details: SSN (unique), gender, name, address, email, salary, specialization and supervisor. |
| `Employee_Phone` | Multiple phone numbers per employee. |
| `Device` | Devices with serial number, name, brand and model, linked to an employee. |
| `Inventory` | Inventory locations with a capacity. |
| `Spare_part` | Spare parts with price, warranty, supplier, quantity and the inventory that holds them. |
| `Service_request` | Service requests with status, submission date, fee and malfunction description. |
| `Takes_from` | Records which employee takes which quantity from which inventory, with a unit price. |

## Relationships

- `Employee.supervisor_SSN` references `Employee.SSN` (an employee can have a supervisor, a self-referencing relationship).
- `Employee_Phone.Employee_ID` references `Employee.E_ID`.
- `Device.Employee_ID` references `Employee.E_ID`.
- `Spare_part.inventory_number` references `Inventory.inventory_number`.
- `Service_request` references three tables: `Customer` (`C_ID`), `Device` (`Serial_no`) and `Employee` (`Employee_SSN`).
- `Takes_from` links `Employee` and `Inventory` through a composite primary key (`Employee_ID`, `Inventory_number`).

Foreign keys use `ON DELETE` and `ON UPDATE` rules. For example, deleting a customer removes their service requests, while an employee who is a supervisor or is assigned to a service request cannot be deleted (`RESTRICT`).

## Constraints

- Primary keys on every table.
- `UNIQUE`: customer email, employee SSN, employee email.
- `NOT NULL` on required fields such as names, SSN, warranty and service request links.
- `CHECK` rules: gender is `M` or `F`, salary and spare part price are greater than 0, quantities and capacity are not negative.

## How to run

1. Install PostgreSQL and create a database:

   ```
   createdb appliance_maintenance
   ```

2. Run the script (replace `schema.sql` with the file name):

   ```
   psql -d appliance_maintenance -f schema.sql
   ```

The script starts each table with `DROP TABLE IF EXISTS ... CASCADE`, so running it again recreates the tables and deletes any existing data in them. Do not run it on a database you want to keep.

## Scope

This repository contains the schema only. It has no sample data, queries or application code.
