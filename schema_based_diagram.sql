CREATE TABLE clinic.Patients (
  id INT PRIMARY KEY,
  name VARCHAR(255),
  date_of_birth DATE
);
CREATE TABLE clinic.Medical_histories (
  id INT PRIMARY KEY,
  admitted_at TIMESTAMP,
  patient_id INT,
  status VARCHAR(255),
  FOREIGN KEY (patient_id) REFERENCES clinic.Patients(Id)
);
CREATE TABLE clinic.Treatments (
  id INT PRIMARY KEY,
  type VARCHAR(255),
  name VARCHAR(255)
);
CREATE TABLE clinic.Invoices (
  id INT PRIMARY KEY,
  total_amount DECIMAL(10,2),
  generated_id TIMESTAMP,
  payed_at TIMESTAMP,
  medical_history_id INT,
  FOREIGN KEY (medical_history_id) REFERENCES clinic.Medical_histories(Id)
);
CREATE TABLE clinic.Invoice_items (
  id INT PRIMARY KEY,
  unit_price DECIMAL(10,2),
  quantity INT,
  total_price DECIMAL(10,2),
  invoice_id INT,
  treatment_id INT,
  FOREIGN KEY (invoice_id) REFERENCES clinic.Invoices(id),
  FOREIGN KEY (treatment_id) REFERENCES clinic.Treatments(Id)
);
