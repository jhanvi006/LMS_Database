mysql> create database LMS;
Query OK, 1 row affected (0.02 sec)

mysql> show databases;
+----------------------+
| Database             |
+----------------------+
| address_book         |
| address_book_service |
| book_store           |
| emp_payroll_service  |
| greeting             |
| information_schema   |
| lms                  |
| mysql                |
| payroll_service      |
| payroll_services     |
| performance_schema   |
| sakila               |
| sys                  |
| user_registration    |
| world                |
+----------------------+
15 rows in set (0.00 sec)

mysql> use lms;
Database changed

mysql> CREATE TABLE user_details
    -> ( id INT(10) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ->   email varchar(100) NOT NULL,
    ->   first_name varchar(100) NOT NULL,
    ->   last_name varchar(100) NOT NULL,
    ->   password varchar(50) NOT NULL,
    ->   contact_number varchar(15),
    ->   verified ENUM('yes','no'),
    ->   creator_stamp DATETIME NOT NULL,
    ->   creator_user varchar(100)
    -> );
Query OK, 0 rows affected, 1 warning (0.04 sec)

mysql> CREATE TABLE hired_candidate
    -> ( id INT(10) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ->   first_name varchar(100) NOT NULL,
    ->   middle_name varchar(100) NOT NULL,
    ->   last_name varchar(100) NOT NULL,
    ->   email_id varchar(100) NOT NULL,
    ->   hired_city varchar(100) NOT NULL,
    ->   degree varchar(100) NOT NULL,
    ->   hired_date DATE NOT NULL,
    ->   mobile_number varchar(15),
    ->   permanent_pincode varchar(7),
    ->   hired_lab varchar(50),
    ->   attitude varchar(200),
    ->   communication_remark varchar(200),
    ->   knowledge_remark varchar(200),
    ->   aggregate_remark varchar(200),
    ->   status ENUM('pending','accepted', 'rejected'),
    ->   creator_stamp DATETIME NOT NULL,
    ->   creator_user varchar(100)
    -> );
Query OK, 0 rows affected, 1 warning (0.03 sec)

mysql> CREATE TABLE fellowship_candidate
    -> ( id INT(10) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ->   cic_id varchar(25) NOT NULL UNIQUE,
    ->   first_name varchar(100) NOT NULL,
    ->   middle_name varchar(100) NOT NULL,
    ->   last_name varchar(100) NOT NULL,
    ->   email_id varchar(100) NOT NULL,
    ->   hired_city varchar(100) NOT NULL,
    ->   degree varchar(100),
    ->   hired_date DATE NOT NULL,
    ->   mobile_number varchar(15),
    ->   permanent_pincode varchar(7),
    ->   hired_lab varchar(50),
    ->   attitude varchar(200),
    ->   communication_remark varchar(200),
    ->   knowledge_remark varchar(200),
    ->   aggregate_remark varchar(200),
    ->   creator_stamp DATETIME NOT NULL,
    ->   creator_user varchar(100),
    ->   birth_date DATE,
    ->   parent_name varchar(200),
    ->   parent_occupation varchar(100),
    ->   parents_mobile_number varchar(15),
    ->   parents_annual_salary DECIMAL(8,2),
    ->   local_address varchar(250),
    ->   permanent_address varchar(250),
    ->   photo_path varchar(1024),
    ->   joining_date DATE,
    ->   candidate_status ENUM('active', 'inactive'),
    ->   personal_information varchar(250),
    ->   bank_information varchar(150),
    ->   educational_information varchar(100),
    ->   document_status ENUM('pending', 'received'),
    ->   remark varchar(200)
    -> );
Query OK, 0 rows affected, 1 warning (0.05 sec)

mysql> CREATE TABLE candidate_bank_details
    -> ( id INT(10) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ->   candidate_id INT(10) NOT NULL,
    ->   name varchar(100) NOT NULL,
    ->   account_number varchar(15) NOT NULL,
    ->   ifsc_code varchar(20) NOT NULL,
    ->   pan_number varchar(10),
    ->   aadhar_number varchar(15),
    ->   creator_stamp DATETIME NOT NULL,
    ->   creator_user varchar(100),
    ->   FOREIGN KEY (candidate_id)
    ->   REFERENCES fellowship_candidate(id)
    ->   ON UPDATE CASCADE
    ->   ON DELETE CASCADE
    -> );
Query OK, 0 rows affected, 2 warnings (0.04 sec)

mysql> CREATE TABLE candidate_qualification
    -> ( id INT(10) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ->   candidate_id INT(10) NOT NULL,
    ->   diploma varchar(100),
    ->   degree_name varchar(100) NOT NULL,
    ->   employee_decipline varchar(100) NOT NULL,
    ->   passing_year YEAR(4) NOT NULL,
    ->   aggr_per DECIMAL(5,2) NOT NULL,
    ->   final_year_per DECIMAL(5,2) NOT NULL,
    ->   training_institute varchar(100),
    ->   training_duration_month INT(2),
    ->   other_training varchar(100),
    ->   creator_stamp DATETIME NOT NULL,
    ->   creator_user varchar(100),
    ->   FOREIGN KEY (candidate_id)
    ->   REFERENCES fellowship_candidate(id)
    ->   ON UPDATE CASCADE
    ->   ON DELETE CASCADE
    -> );
Query OK, 0 rows affected, 4 warnings (0.05 sec)

mysql> CREATE TABLE candidate_documents
    -> ( id INT(10) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ->   candidate_id INT(10) NOT NULL,
    ->   doc_type varchar(100),
    ->   doc_path varchar(2048),
    ->   status ENUM('pending', 'received'),
    ->   creator_stamp DATETIME NOT NULL,
    ->   creator_user varchar(100),
    ->   FOREIGN KEY (candidate_id)
    ->   REFERENCES fellowship_candidate(id)
    ->   ON UPDATE CASCADE
    ->   ON DELETE CASCADE
    -> );
Query OK, 0 rows affected, 2 warnings (0.05 sec)

mysql> CREATE TABLE company
    -> ( id INT(10) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ->   name varchar(100),
    ->   address varchar(255),
    ->   location varchar(100),
    ->   status varchar(50),
    ->   creator_stamp DATETIME NOT NULL,
    ->   creator_user varchar(100)
    -> );
Query OK, 0 rows affected, 1 warning (0.03 sec)

mysql> CREATE TABLE tech_stack
    -> ( id INT(10) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ->   tech_name varchar(100),
    ->   image_path varchar(1024),
    ->   framework varchar(100),
    ->   cur_status varchar(50),
    ->   creator_stamp DATETIME NOT NULL,
    ->   creator_user varchar(100)
    -> );
Query OK, 0 rows affected, 1 warning (0.03 sec)

mysql> CREATE TABLE tech_type
    -> ( id INT(10) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ->   type_name ENUM('full stack', 'frontend', 'backend'),
    ->   cur_status varchar(50),
    ->   creator_stamp DATETIME NOT NULL,
    ->   creator_user varchar(100)
    -> );
Query OK, 0 rows affected, 1 warning (0.03 sec)

mysql> CREATE TABLE lab
    -> ( id INT(10) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ->   name varchar(100),
    ->   location varchar(50),
    ->   address varchar(255),
    ->   status varchar(50),
    ->   creator_stamp DATETIME NOT NULL,
    ->   creator_user varchar(100)
    -> );
Query OK, 0 rows affected, 1 warning (0.03 sec)

mysql> CREATE TABLE lab_threshold
    -> ( id INT(10) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ->   lab_id INT(10),
    ->   lab_capacity INT,
    ->   lead_threshold INT,
    ->   ideation_engg_threshold INT,
    ->   buddy_engg_threshold INT,
    ->   status ENUM('active', 'inactive'),
    ->   creator_stamp DATETIME NOT NULL,
    ->   creator_user varchar(100),
    ->   FOREIGN KEY (lab_id)
    ->   REFERENCES lab(id)
    ->   ON UPDATE CASCADE
    ->   ON DELETE CASCADE
    -> );
Query OK, 0 rows affected, 2 warnings (0.06 sec)

mysql> CREATE TABLE maker_program
    -> ( id INT(10) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ->   program_name varchar(100),
    ->   program_type varchar(50),
    ->   program_link varchar(1024),
    ->   tech_stack_id INT(10),
    ->   tech_type_id INT(10),
    ->   is_program_approved ENUM('yes', 'no'),
    ->   description varchar(200),
    ->   status ENUM('active', 'inactive'),
    ->   creator_stamp DATETIME NOT NULL,
    ->   creator_user varchar(100),
    ->   FOREIGN KEY (tech_stack_id)
    ->   REFERENCES tech_stack(id)
    ->   ON UPDATE CASCADE
    ->   ON DELETE CASCADE,
    ->   FOREIGN KEY (tech_type_id)
    ->   REFERENCES tech_type(id)
    ->   ON UPDATE CASCADE
    ->   ON DELETE CASCADE
    -> );
Query OK, 0 rows affected, 3 warnings (0.04 sec)

mysql> CREATE TABLE mentor
    -> ( id INT(10) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ->   name varchar(100),
    ->   mentor_type ENUM('Lead Mentor', 'Practice Head', 'Support Mentor', 'Buddy Mentor'),
    ->   lab_id INT(10),
    ->   status ENUM('active', 'inactive'),
    ->   creator_stamp DATETIME NOT NULL,
    ->   creator_user varchar(100),
    ->   FOREIGN KEY (lab_id)
    ->   REFERENCES lab(id)
    ->   ON UPDATE CASCADE
    ->   ON DELETE CASCADE
    -> );
Query OK, 0 rows affected, 2 warnings (0.05 sec)

mysql> CREATE TABLE mentor_ideation_map
    -> ( id INT(10) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ->   parent_mentor_id INT(10),
    ->   mentor_id INT(10),
    ->   status ENUM('active', 'inactive'),
    ->   creator_stamp DATETIME NOT NULL,
    ->   creator_user varchar(100),
    ->   FOREIGN KEY (parent_mentor_id)
    ->   REFERENCES mentor(id)
    ->   ON UPDATE CASCADE
    ->   ON DELETE CASCADE,
    ->   FOREIGN KEY (mentor_id)
    ->   REFERENCES mentor(id)
    ->   ON UPDATE CASCADE
    ->   ON DELETE CASCADE
    -> );
Query OK, 0 rows affected, 3 warnings (0.05 sec)

mysql> CREATE TABLE mentor_tech_stack
    -> ( id INT(10) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ->   mentor_id INT(10),
    ->   tech_stack_id INT(10),
    ->   status ENUM('active', 'inactive'),
    ->   creator_stamp DATETIME NOT NULL,
    ->   creator_user varchar(100),
    ->   FOREIGN KEY (mentor_id)
    ->   REFERENCES mentor(id)
    ->   ON UPDATE CASCADE
    ->   ON DELETE CASCADE,
    ->   FOREIGN KEY (tech_stack_id)
    ->   REFERENCES tech_stack(id)
    ->   ON UPDATE CASCADE
    ->   ON DELETE CASCADE
    -> );
Query OK, 0 rows affected, 3 warnings (0.04 sec)

mysql> CREATE TABLE company_requirement
    -> ( id INT(10) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ->   company_id INT(10),
    ->   requested_month DATE,
    ->   city varchar(100),
    ->   is_doc_verification ENUM('yes', 'no'),
    ->   requirement_doc_path varchar(1024),
    ->   no_of_engg INT,
    ->   tech_stack_id INT(10),
    ->   tech_type_id INT(10),
    ->   maker_program_id INT(10),
    ->   lead_id INT(10),
    ->   ideation_engg_id INT(10),
    ->   buddy_engg_id INT(10),
    ->   special_remark varchar(200),
    ->   status ENUM('active', 'inactive'),
    ->   creator_stamp DATETIME NOT NULL,
    ->   creator_user varchar(100),
    ->   FOREIGN KEY (company_id) REFERENCES company(id)
    ->   ON UPDATE CASCADE ON DELETE CASCADE,
    ->   FOREIGN KEY (tech_stack_id) REFERENCES tech_stack(id)
    ->   ON UPDATE CASCADE ON DELETE CASCADE,
    ->   FOREIGN KEY (tech_type_id) REFERENCES tech_type(id)
    ->   ON UPDATE CASCADE ON DELETE CASCADE,
    ->   FOREIGN KEY (maker_program_id) REFERENCES maker_program(id)
    ->   ON UPDATE CASCADE ON DELETE CASCADE,
    ->   FOREIGN KEY (lead_id) REFERENCES mentor(id)
    ->   ON UPDATE CASCADE ON DELETE CASCADE,
    ->   FOREIGN KEY (ideation_engg_id) REFERENCES mentor(id)
    ->   ON UPDATE CASCADE ON DELETE CASCADE,
    ->   FOREIGN KEY (buddy_engg_id) REFERENCES mentor(id)
    ->   ON UPDATE CASCADE ON DELETE CASCADE
    -> );
Query OK, 0 rows affected, 8 warnings (0.06 sec)

mysql> CREATE TABLE candidate_stack_assignment
    -> ( id INT(10) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ->   requirement_id INT(10),
    ->   candidate_id INT(10),
    ->   assigned_date DATE,
    ->   complete_date DATE,
    ->   status ENUM('active', 'inactive'),
    ->   creator_stamp DATETIME NOT NULL,
    ->   creator_user varchar(100),
    ->   FOREIGN KEY (requirement_id) REFERENCES company_requirement(id)
    ->   ON UPDATE CASCADE ON DELETE CASCADE,
    ->   FOREIGN KEY (candidate_id) REFERENCES fellowship_candidate(id)
    ->   ON UPDATE CASCADE ON DELETE CASCADE
    -> );
Query OK, 0 rows affected, 3 warnings (0.05 sec)

mysql> INSERT INTO user_details(email, first_name, last_name, password, contact_number, verified, creator_stamp, creator_user)
    -> VALUES
    -> ('jhanvi.k@gmail.com', 'Jhanvi', 'Kanakhara', 'jhanvi.K.06', '9090909090', 1, NOW(), 'Manali Mehta'),
    -> ('kabir.shah@gmail.com', 'Kabir', 'Shah', 'kshah21', '9191919191', 2, NOW(), 'Manali Mehta'),
    -> ('pooja322@gmail.com', 'Pooja', 'Jha', 'Jha.pooji322', '9292929292', 1, NOW(), 'Manali Mehta'),
    -> ('mayank.tripathi@gmail.com', 'Mayank', 'Tripathi', 'mayu.1221', '9393939393', 1, NOW(), 'Manali Mehta'),
    -> ('aditya.nanda@gmail.com', 'Aditya', 'Nanda', 'adinandan', '9494949494', 2, NOW(), 'Manali Mehta');
Query OK, 5 rows affected (0.02 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> INSERT INTO user_details(email, first_name, last_name, password, contact_number, verified, creator_stamp, creator_user)
    -> VALUES
    -> ('shreya.doshi@gmail.com', 'Shreya', 'Doshi', 'shreyu22', '9595959595', 1, NOW(), 'Manali Mehta'),
    -> ('abhishek.joiser@gmail.com', 'Abhishek', 'Joiser', 'abhi.joiser', '9696969696', 2, NOW(), 'Manali Mehta'),
    -> ('poonam.mehta@gmail.com', 'Poonam', 'Mehta', 'poomehta', '9797979797', 1, NOW(), 'Manali Mehta'),
    -> ('karan.tripathi@gmail.com', 'Karan', 'Tripathi', 'karan.191', '9898989898', 1, NOW(), 'Manali Mehta'),
    -> ('aditya.shah@gmail.com', 'Aditya', 'Shah', 'Shahadi', '9999999999', 1, NOW(), 'Manali Mehta');
Query OK, 5 rows affected (0.01 sec)
Records: 5  Duplicates: 0  Warnings: 0

