create database LMS;
show databases;
use lms;

CREATE TABLE user_details (id INT(10) NOT NULL AUTO_INCREMENT PRIMARY KEY, email varchar(100) NOT NULL,
    first_name varchar(100) NOT NULL, last_name varchar(100) NOT NULL, password varchar(50) NOT NULL,
    contact_number varchar(15), verified ENUM('yes','no'), creator_stamp DATETIME NOT NULL,
    creator_user varchar(100));

CREATE TABLE hired_candidate (id INT(10) NOT NULL AUTO_INCREMENT PRIMARY KEY, first_name varchar(100) NOT NULL,
    middle_name varchar(100) NOT NULL, last_name varchar(100) NOT NULL, email_id varchar(100) NOT NULL,
    hired_city varchar(100) NOT NULL, degree varchar(100) NOT NULL, hired_date DATE NOT NULL,
    mobile_number varchar(15), permanent_pincode varchar(7), hired_lab varchar(50), attitude varchar(200),
    communication_remark varchar(200), knowledge_remark varchar(200), aggregate_remark varchar(200),
    status ENUM('pending','accepted', 'rejected'), creator_stamp DATETIME NOT NULL, creator_user varchar(100));

CREATE TABLE fellowship_candidate (id INT(10) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    cic_id varchar(25) NOT NULL UNIQUE, first_name varchar(100) NOT NULL, middle_name varchar(100) NOT NULL,
    last_name varchar(100) NOT NULL, email_id varchar(100) NOT NULL, hired_city varchar(100) NOT NULL,
    degree varchar(100), hired_date DATE NOT NULL, mobile_number varchar(15), permanent_pincode varchar(7),
    hired_lab varchar(50), attitude varchar(200), communication_remark varchar(200), knowledge_remark varchar(200),
    aggregate_remark varchar(200), creator_stamp DATETIME NOT NULL, creator_user varchar(100), birth_date DATE,
    parent_name varchar(200), parent_occupation varchar(100), parents_mobile_number varchar(15),
    parents_annual_salary DECIMAL(8,2), local_address varchar(250), permanent_address varchar(250),
    photo_path varchar(1024), joining_date DATE, candidate_status ENUM('active', 'inactive'),
    personal_information varchar(250), bank_information varchar(150), educational_information varchar(100),
    document_status ENUM('pending', 'received'), remark varchar(200));

CREATE TABLE candidate_bank_details (id INT(10) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    candidate_id INT(10) NOT NULL, name varchar(100) NOT NULL, account_number varchar(25) NOT NULL,
    ifsc_code varchar(20) NOT NULL, pan_number varchar(20), aadhar_number varchar(25),
    creator_stamp DATETIME NOT NULL, creator_user varchar(100),
    FOREIGN KEY (candidate_id) REFERENCES fellowship_candidate(id) ON UPDATE CASCADE ON DELETE CASCADE);

CREATE TABLE candidate_qualification (id INT(10) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    candidate_id INT(10) NOT NULL, diploma varchar(100), degree_name varchar(100) NOT NULL,
    employee_decipline varchar(100) NOT NULL, passing_year YEAR(4) NOT NULL, aggr_per DECIMAL(5,2) NOT NULL,
    final_year_per DECIMAL(5,2) NOT NULL, training_institute varchar(100), training_duration_month INT(2),
    other_training varchar(100), creator_stamp DATETIME NOT NULL, creator_user varchar(100),
    FOREIGN KEY (candidate_id) REFERENCES fellowship_candidate(id) ON UPDATE CASCADE ON DELETE CASCADE);

CREATE TABLE candidate_documents (id INT(10) NOT NULL AUTO_INCREMENT PRIMARY KEY, candidate_id INT(10) NOT NULL,
    doc_type varchar(100), doc_path varchar(2048), status ENUM('pending', 'received'),
    creator_stamp DATETIME NOT NULL, creator_user varchar(100), FOREIGN KEY (candidate_id)
    REFERENCES fellowship_candidate(id) ON UPDATE CASCADE ON DELETE CASCADE);

CREATE TABLE company (id INT(10) NOT NULL AUTO_INCREMENT PRIMARY KEY, name varchar(100), address varchar(255),
    location varchar(100), status ENUM('active', 'inactive'), creator_stamp DATETIME NOT NULL,
    creator_user varchar(100));

CREATE TABLE tech_stack (id INT(10) NOT NULL AUTO_INCREMENT PRIMARY KEY, tech_name varchar(100),
    image_path varchar(1024), framework varchar(100), cur_status ENUM('active', 'inactive'),
    creator_stamp DATETIME NOT NULL, creator_user varchar(100));

CREATE TABLE tech_type (id INT(10) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    type_name ENUM('full stack', 'frontend', 'backend'), cur_status ENUM('active', 'inactive'),
    creator_stamp DATETIME NOT NULL, creator_user varchar(100));

CREATE TABLE lab (id INT(10) NOT NULL AUTO_INCREMENT PRIMARY KEY, name varchar(100), location varchar(50),
    address varchar(255), status ENUM('active', 'inactive'), creator_stamp DATETIME NOT NULL,
    creator_user varchar(100));

CREATE TABLE lab_threshold (id INT(10) NOT NULL AUTO_INCREMENT PRIMARY KEY, lab_id INT(10), lab_capacity INT,
    lead_threshold INT, ideation_engg_threshold INT, buddy_engg_threshold INT, status ENUM('active', 'inactive'),
    creator_stamp DATETIME NOT NULL, creator_user varchar(100), FOREIGN KEY (lab_id) REFERENCES lab(id)
    ON UPDATE CASCADE ON DELETE CASCADE);

CREATE TABLE maker_program (id INT(10) NOT NULL AUTO_INCREMENT PRIMARY KEY, program_name varchar(100),
    program_type varchar(50), program_link varchar(1024), tech_stack_id INT(10), tech_type_id INT(10),
    is_program_approved ENUM('yes', 'no'), description varchar(200), status ENUM('active', 'inactive'),
    creator_stamp DATETIME NOT NULL, creator_user varchar(100), FOREIGN KEY (tech_stack_id)
    REFERENCES tech_stack(id) ON UPDATE CASCADE ON DELETE CASCADE, FOREIGN KEY (tech_type_id)
    REFERENCES tech_type(id) ON UPDATE CASCADE ON DELETE CASCADE);

CREATE TABLE mentor (id INT(10) NOT NULL AUTO_INCREMENT PRIMARY KEY, name varchar(100),
    mentor_type ENUM('Lead Mentor', 'Practice Head', 'Support Mentor', 'Buddy Mentor'), lab_id INT(10),
    status ENUM('active', 'inactive'), creator_stamp DATETIME NOT NULL, creator_user varchar(100),
    FOREIGN KEY (lab_id) REFERENCES lab(id) ON UPDATE CASCADE ON DELETE CASCADE);

CREATE TABLE mentor_ideation_map (id INT(10) NOT NULL AUTO_INCREMENT PRIMARY KEY, parent_mentor_id INT(10),
    mentor_id INT(10), status ENUM('active', 'inactive'), creator_stamp DATETIME NOT NULL,
    creator_user varchar(100), FOREIGN KEY (parent_mentor_id) REFERENCES mentor(id) ON UPDATE CASCADE
    ON DELETE CASCADE, FOREIGN KEY (mentor_id) REFERENCES mentor(id) ON UPDATE CASCADE ON DELETE CASCADE);

CREATE TABLE mentor_tech_stack (id INT(10) NOT NULL AUTO_INCREMENT PRIMARY KEY, mentor_id INT(10),
    tech_stack_id INT(10), status ENUM('active', 'inactive'), creator_stamp DATETIME NOT NULL,
    creator_user varchar(100), FOREIGN KEY (mentor_id) REFERENCES mentor(id) ON UPDATE CASCADE
    ON DELETE CASCADE, FOREIGN KEY (tech_stack_id) REFERENCES tech_stack(id) ON UPDATE CASCADE
    ON DELETE CASCADE);

CREATE TABLE company_requirement (id INT(10) NOT NULL AUTO_INCREMENT PRIMARY KEY, company_id INT(10),
    requested_month DATE, city varchar(100), is_doc_verification ENUM('true', 'false'),
    requirement_doc_path varchar(1024), no_of_engg INT, tech_stack_id INT(10), tech_type_id INT(10),
    maker_program_id INT(10), lead_id INT(10), ideation_engg_id INT(10), buddy_engg_id INT(10),
    special_remark varchar(200), status ENUM('active', 'inactive'), creator_stamp DATETIME NOT NULL,
    creator_user varchar(100), FOREIGN KEY (company_id) REFERENCES company(id)
    ON UPDATE CASCADE ON DELETE CASCADE, FOREIGN KEY (tech_stack_id) REFERENCES tech_stack(id)
    ON UPDATE CASCADE ON DELETE CASCADE, FOREIGN KEY (tech_type_id) REFERENCES tech_type(id)
    ON UPDATE CASCADE ON DELETE CASCADE, FOREIGN KEY (maker_program_id) REFERENCES maker_program(id)
    ON UPDATE CASCADE ON DELETE CASCADE, FOREIGN KEY (lead_id) REFERENCES mentor(id)
    ON UPDATE CASCADE ON DELETE CASCADE, FOREIGN KEY (ideation_engg_id) REFERENCES mentor(id)
    ON UPDATE CASCADE ON DELETE CASCADE, FOREIGN KEY (buddy_engg_id) REFERENCES mentor(id)
    ON UPDATE CASCADE ON DELETE CASCADE);

CREATE TABLE candidate_stack_assignment (id INT(10) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    requirement_id INT(10), candidate_id INT(10), assigned_date DATE, complete_date DATE,
    status ENUM('active', 'inactive'), creator_stamp DATETIME NOT NULL, creator_user varchar(100),
    FOREIGN KEY (requirement_id) REFERENCES company_requirement(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (candidate_id) REFERENCES fellowship_candidate(id) ON UPDATE CASCADE ON DELETE CASCADE);

INSERT INTO user_details(email, first_name, last_name, password, contact_number, verified, creator_stamp,
    creator_user) VALUES
    ('jhanvi.k@gmail.com', 'Jhanvi', 'Kanakhara', 'jhanvi.K.06', '9090909090', 1, NOW(), 'Manali Mehta'),
    ('kabir.shah@gmail.com', 'Kabir', 'Shah', 'kshah21', '9191919191', 2, NOW(), 'Manali Mehta'),
    ('pooja322@gmail.com', 'Pooja', 'Jha', 'Jha.pooji322', '9292929292', 1, NOW(), 'Manali Mehta'),
    ('mayank.tripathi@gmail.com', 'Mayank', 'Tripathi', 'mayu.1221', '9393939393', 1, NOW(), 'Manali Mehta'),
    ('aditya.nanda@gmail.com', 'Aditya', 'Nanda', 'adinandan', '9494949494', 2, NOW(), 'Manali Mehta');

INSERT INTO user_details(email, first_name, last_name, password, contact_number, verified, creator_stamp,
    creator_user) VALUES
    ('shreya.doshi@gmail.com', 'Shreya', 'Doshi', 'shreyu22', '9595959595', 1, NOW(), 'Manali Mehta'),
    ('abhishek.joiser@gmail.com', 'Abhishek', 'Joiser', 'abhi.joiser', '9696969696', 2, NOW(), 'Manali Mehta'),
    ('poonam.mehta@gmail.com', 'Poonam', 'Mehta', 'poomehta', '9797979797', 1, NOW(), 'Manali Mehta'),
    ('karan.tripathi@gmail.com', 'Karan', 'Tripathi', 'karan.191', '9898989898', 1, NOW(), 'Manali Mehta'),
    ('aditya.shah@gmail.com', 'Aditya', 'Shah', 'Shahadi', '9999999999', 1, NOW(), 'Manali Mehta');

INSERT INTO hired_candidate (first_name, middle_name, last_name, email_id, hired_city, degree, hired_date,
    mobile_number, permanent_pincode, hired_lab, attitude, communication_remark, knowledge_remark,
    aggregate_remark, status, creator_stamp, creator_user) VALUES
    ('Shreya', 'P', 'Lakhani', 'sp.lakhani@yahoo.com', 'Bangalore', 'M.E', '2021-04-10', '1090230490',
    '320010', 'lab_01', 'good', 'good', 'good', 'over all good', 1, '2021-04-10', 'Anmol Patel'),
    ('Shreeti', 'A', 'Bakshi', 'sba.bakshi@google.com', 'Ahmedabad', 'BCA', '2021-06-20', '3910934856',
    '310210', 'lab_02', 'good', 'good', 'good', 'over all good', 2, '2021-06-20', 'Anmol Patel'),
    ('Komal', 'Hitesh', 'Mehta', 'km.mehta@gmail.com', 'Bangalore', 'B.E', '2020-03-17', '901220490',
    '320 010', 'lab_01', 'good', 'good', 'good', 'over all good', 1, '2021-04-10', 'Anmol Patel'),
    ('Kreena', 'Jignesh', 'Somani', 'kreena@yahoo.com', 'Mumbai', 'BCom', '2022-01-10', '2222230490',
    '221 055', 'lab_04', 'good', 'good', 'good', 'over all good', 'rejected', '2021-04-10', 'Anmol Patel'),
    ('Shreyas', 'Parth', 'Parekh', 'spp@yahoo.com', 'Pune', 'MBA', '2021-04-10', '9870605500', '521009',
    'lab_03', 'good', 'good', 'good', 'over all good', 'accepted', '2021-04-10', 'Aman Mehta'),
    ('Karan', 'B', 'Bhatt', 'karan.b2@google.com', 'Ahmedabad', 'BCA', '2019-03-20', '2109234986', '221221',
    'lab_02', 'good', 'good', 'good', 'over all good', 2, '2021-06-20', 'Anmol Patel'),
    ('Pooja', 'Manish', 'Kapoor', 'pkapoor@gmail.com', 'Delhi', 'LLB', '2020-03-17', '9999909000', '454545',
    'lab_03', 'good', 'good', 'good', 'over all good', 3, '2021-04-10', 'Aman Mehta'),
    ('Malhar', 'Dinesh', 'Thaker', 'malhar@google.com', 'Mumbai', 'BEd', '2022-01-10', '2233030490',
    '221 881', 'lab_05', 'good', 'good', 'good', 'over all good', 1, '2021-04-10', 'Ashish Jha'),
    ('Janam', 'A', 'Parekh', 'janam@yahoo.com', 'Vadodara', 'BTech', '2020-09-09', '88580912099', '312200',
    'lab_04', 'good', 'good', 'good', 'over all good', 'accepted', '2021-04-10', 'Aman Mehta'),
    ('Darshan', 'L', 'Bhatt', 'dlb.bhatt@google.com', 'Ahmedabad', 'MCA', '2018-12-15', '6501923300',
    '221221', 'lab_02', 'good', 'good', 'good', 'over all good', 2, '2021-06-20', 'Anmol Patel');

INSERT INTO fellowship_candidate (cic_id, first_name, middle_name, last_name, email_id, hired_city, degree,
    hired_date, mobile_number, permanent_pincode, hired_lab, attitude, communication_remark, knowledge_remark,
    aggregate_remark, creator_stamp, creator_user, birth_date, parent_name, parent_occupation,
    parents_mobile_number, parents_annual_salary, local_address, permanent_address, photo_path, joining_date,
    candidate_status, personal_information, bank_information, educational_information, document_status, remark)
    VALUES
    ('CIC032022-11333', 'Janvi', 'Bipin', 'Bhayani', 'jhanvibb@gmail.com', 'Pune', 'MTech', '2020-06-11',
    '9809808000', '323 232', 'lab_01', 'good', 'good', 'average', 'good', NOW(), 'Raj Nanda', '1890-10-29',
    'Bipin Bhayani', 'Manufecturer', '4545454499', '90000', 'mumbai', 'mumbai', 'images/image_01',
    '2020-06-15', 1, '', '', 'Mtech mechanical', 1, ''),
    ('CIC032022-11334', 'Pooja', 'Hitesh', 'Bhadra', 'pooja@gmail.com', 'Pune', 'MBA', '2021-04-19',
    '7070808000', '211 232', 'lab_02', 'good', 'good', 'average', 'good', NOW(), 'Raj Nanda', '1993-10-29',
    'Hitesh Bhadra', 'Marketing', '7172770011', '95000', 'mumbai', 'surat', 'images/image_01', '2021-05-15',
    2, '', '', 'MBA in sales and marketing', 2, ''),
    ('CIC032022-11335', 'Dev', 'Bipin', 'Shah', 'devshah@gmail.com', 'Mumbai', 'MBA', '2020-11-11',
    '9801238900', '300 232', 'lab_01', 'average', 'good', 'average', 'average', NOW(), 'Raj Nanda',
    '1990-01-29', 'Bipin Shah', 'Manager', '9810908090', '100000', 'mumbai', 'mumbai', 'images/image_003',
    '2020-11-15', 1, '', '', 'MBA', 2, ''),
    ('CIC032022-11336', 'Kabir', 'Sanjay', 'Oza', 'kabir@gmail.com', 'Ahmedabad', 'BCom', '2020-11-11',
    '9809801100', '511 232', 'lab_06', 'good', 'good', 'good', 'good', NOW(), 'Raj Nanda', '1992-04-16',
    'Sanjay Oza', 'Baker', '9812087700', '50000', 'jamnagar', 'jamnagar', 'images/image_06', '2020-11-15', 2,
    '', '', '', 1, ''),
    ('CIC032022-11337', 'Prakash', 'Chaman', 'Khoyani', 'prakash@gmail.com', 'Delhi', 'BEd', '2021-12-11',
    '7809808000', '410 022', 'lab_10', 'good', 'good', 'average', 'good', NOW(), 'Raj Nanda', '1994-02-28',
    'Chaman', 'LLB', '4040401122', '70000', 'agra', 'delhi', 'images/image_01', '2021-12-15', 1, '', '', '',
    2, ''),
    ('CIC032022-11338', 'Naveen', 'Nitin', 'Nathwani', 'nnn@gmail.com', 'Jaipur', 'BCom', '2021-01-30',
    '6809808000', '218 502', 'lab_05', 'good', 'good', 'average', 'good', NOW(), 'Raj Nanda', '1995-11-29',
    'Nitin Nathwani', 'Business', '7501232001', '900000', 'mumbai', 'mumbai', 'images/image_01', '2021-02-05',
     1, '', '', 'BCom', 1, ''),
    ('CIC032022-11339', 'Ridhi', 'Kapil', 'Sharma', 'rksharma@gmail.com', 'Pune', 'BTech', '2021-02-14',
    '6012056456', '421 009', 'lab_01', 'good', 'good', 'average', 'good', NOW(), 'Raj Nanda', '1994-03-16',
    'Kapil Sharma', 'Artist', '6660078066', '910000', 'pune', 'pune', 'images/images.010', '2021-02-15', 2,
    '', '', 'Btech electrical', 1, ''),
    ('CIC032022-11340', 'Sanjana', 'Sanjay', 'Nanda', 'ssnanda@gmail.com', 'Rajkot', 'BCA', '2021-02-14',
    '5091029010', '301 002', 'lab_04', 'good', 'good', 'average', 'good', NOW(), 'Raj Nanda', '1996-01-01',
    'Sanjay Nanda', 'Manufecturer', '5010029901', '510000', 'rajkot', 'junagadh', 'images/image_01',
    '2021-02-25', 2, '', '', 'BCA', 2, ''),
    ('CIC032022-11341', 'Khushboo', 'Hemant', 'Patel', 'boopatel@gmail.com', 'Rajkot', 'BE', '2021-04-21',
    '1020102010', '412 211', 'lab_03', 'good', 'good', 'average', 'good', NOW(), 'Raj Nanda', '1998-11-19',
    'Hemant Patel', 'Writer', '1020102010', '940000', 'rajkot', 'rajkot', 'images/image_03', '2021-04-25', 1,
    '', '', 'BE', 1, ''),
    ('CIC032022-11342', 'Abhishek', 'A', 'Jayakar', 'abhijayakar@gmail.com', 'Bangalore', 'MTech',
    '2021-06-01', '9809820100', '411 510', 'lab_05', 'good', 'good', 'average', 'good', NOW(), 'Raj Nanda',
    '1995-07-20', 'Anil Jayakar', 'Professor', '9812091200', '910000', 'bangalore', 'bangalore',
    'images/image_07', '2021-06-10', 1, '', '', 'Mtech cse', 2, '');

INSERT INTO candidate_bank_details (candidate_id, name, account_number, ifsc_code, pan_number, aadhar_number,
    creator_stamp, creator_user) VALUES
    (1, 'Bhayani Janvi', '441033096501', 'HDFC000112', 'ABABS1120P', '1122 2121 0900', NOW(), 'Aman Singh'),
    (11, 'Pooja Bhadra', '312033095200', 'SBI0000112', 'DSDSQ9011Q', '5120 4510 2010', NOW(), 'Aman Singh'),
    (13, 'Kabir Oza', '908811069011', 'HDFC010105', 'MKPO1021L', '4311 9089 6700', NOW(), 'Aman Singh'),
    (15, 'Navin Nitin Nathwani', '880111223312', 'BOB200112', 'ABDEU0120P', '3300 9080 1011', NOW(), 'Aman Singh'),
    (17, 'Nanda Sanjana', '441433905601', 'ICICI000111', 'ZXWEQ1231M', '2211 2021 0900', NOW(), 'Aman Singh'),
    (12, 'Dev Shah', '455623096501', 'BOB0000412', 'LOKMM2133S', '5634 0900 1765', NOW(), 'Aman Singh'),
    (14, 'Khoyani Prakash', '222233096501', 'HDFC000112', 'PDPDL5402K', '1122 0404 0311', NOW(), 'Aman Singh'),
    (16, 'Ridhi Sharma', '430122986501', 'HDFC000112', 'ABABS6520P', '1233 2121 1150', NOW(), 'Aman Singh'),
    (19, 'Jayakar Abhishek', '609933096501', 'ICICI00110', 'ALOMD40922', '6750 3480 1113', NOW(), 'Aman Singh'),
    (18, 'Khushboo Patel', '120948753900', 'HDFC000112', 'WPAEE22901R', '3847 4354 5601', NOW(), 'Aman Singh');

INSERT INTO candidate_qualification (candidate_id, diploma, degree_name, employee_decipline, passing_year,
    aggr_per, final_year_per, training_institute, training_duration_month, other_training, creator_stamp,
    creator_user) VALUES
    (1, 'operting systems', 'BE', 'engineering', 2019, 78.03, 75.1, 'abc institute', 3, '', NOW(), 'Pooja Goswami'),
    (11, '', 'BCom', 'accountant', 2019, 81.33, 79.81, 'abc institute', 4, '', NOW(), 'Pooja Goswami'),
    (13, '', 'Hotel Management', 'manager', 2021, 65, 61.11, '', NULL , '', NOW(), 'Pooja Goswami'),
    (15, '', 'ME', 'engineering', 2020, 89.03, 85.91, 'carrers institute', 3, '', NOW(), 'Pooja Goswami'),
    (17, '', 'BCA', 'developer', 2020, 71.22, 70, 'abc institute', 3, '', NOW(), 'Pooja Goswami'),
    (12, 'designer', 'BBA', 'adminstator', 2021, 51.55, 50, '', NULL, '', NOW(), 'Pooja Goswami'),
    (14, '', 'LLB', 'advocate', 2019, 58.03, 55.1, 'ttp institute', 6, '', NOW(), 'Pooja Goswami'),
    (16, '', 'CA', 'accountant', 2022, 98.03, 97.85, 'weqww institute', 10, '', NOW(), 'Pooja Goswami'),
    (19, '', 'BE', 'engineering', 2021, 88.03, 86.91, 'abc institute', 3, '', NOW(), 'Pooja Goswami'),
    (18, '', 'BCom', 'economy', 2020, 68.03, 65.1, 'abc institute', 4, '', NOW(), 'Pooja Goswami');

INSERT INTO candidate_documents (candidate_id, doc_type, doc_path, status, creator_stamp, creator_user) VALUES
    (1, 'aadhar card', 'doc/aadhar.pdf', 2, NOW(), 'Pallavi Deshpande'),
    (11, 'pan card', 'doc/pan.pdf', 2, NOW(), 'Pallavi Deshpande'),
    (13, 'pan card', 'doc/pan.pdf', 1, NOW(), 'Pallavi Deshpande'),
    (15, 'aadhar card', 'doc/aadhar.pdf', 1, NOW(), 'Pallavi Deshpande'),
    (17, 'certificate', 'doc/certi.pdf', 2, NOW(), 'Pallavi Deshpande'),
    (12, 'aadhar card', 'doc/aadhar.pdf', 2, NOW(), 'Pallavi Deshpande'),
    (14, 'pan card', 'doc/pan.pdf', 1, NOW(), 'Pallavi Deshpande'),
    (16, 'aadhar card', 'doc/aadhar.pdf', 2, NOW(), 'Pallavi Deshpande'),
    (19, 'certificate', 'doc/certi.pdf', 2, NOW(), 'Pallavi Deshpande'),
    (18, 'aadhar card', 'doc/aadhar.pdf', 1, NOW(), 'Pallavi Deshpande');

INSERT INTO company (name, address, location, status, creator_stamp, creator_user) VALUES
    ('Bridgelabz Solutions', 'baner', 'pune', 1, NOW(), 'Parth Pawar'),
    ('Newton Technologies', 'cn road', 'delhi', 2, NOW(), 'Parth Pawar'),
    ('Scad Technologies', 'malad', 'mumbai', 1, NOW(), 'Parth Pawar'),
    ('KPIT Technologies', 'hinjewadi', 'pune', 1, NOW(), 'Parth Pawar'),
    ('Infosys Technologies', 'road 3', 'bangalore', 2, NOW(), 'Parth Pawar'),
    ('Deloitte', 'sharkhej', 'ahmedabad', 1, NOW(), 'Parth Pawar'),
    ('Oracle', 'hitec city', 'hyderabad', 2, NOW(), 'Parth Pawar'),
    ('Google', 'hitec city', 'hyderabad', 1, NOW(), 'Parth Pawar'),
    ('Wipro', 'hinjewadi', 'pune', 1, NOW(), 'Parth Pawar'),
    ('Aisomax Consultancy', 'sadhuwaswani road', 'rajkot', 1, NOW(), 'Parth Pawar');

INSERT INTO tech_stack (tech_name, image_path, framework, cur_status, creator_stamp, creator_user) VALUES
    ('java', 'images/img_01', 'spring', 1, NOW(), 'Apeksha Patel'),
    ('java', 'images/img_01', 'angular', 1, NOW(), 'Apeksha Patel'),
    ('java', 'images/img_01', 'hibernate', 2, NOW(), 'Apeksha Patel'),
    ('php', 'images/img_01', 'larvel', 1, NOW(), 'Apeksha Patel'),
    ('php', 'images/img_01', 'symphony', 2, NOW(), 'Apeksha Patel'),
    ('javascript', 'images/img_01', 'node', 1, NOW(), 'Apeksha Patel'),
    ('javascript', 'images/img_01', 'express', 1, NOW(), 'Apeksha Patel'),
    ('python', 'images/img_01', 'django', 1, NOW(), 'Apeksha Patel'),
    ('python', 'images/img_01', 'flask', 1, NOW(), 'Apeksha Patel'),
    ('javascript', 'images/img_01', 'jquery', 1, NOW(), 'Apeksha Patel');

INSERT INTO tech_type (type_name, cur_status, creator_stamp, creator_user) VALUES
    (1, 1, NOW(), 'Apeksha Patel'), (2, 1, NOW(), 'Apeksha Patel'), (3, 2, NOW(), 'Apeksha Patel');

INSERT INTO lab (name, location, address, status, creator_stamp, creator_user) VALUES
    ('lab_01', 'pune', 'hinjewadi', 1, NOW(), 'Apeksha Patel'),
    ('lab_05', 'pune', 'baner', 1, NOW(), 'Apeksha Patel'),
    ('lab_10', 'mumbai', 'andheri', 2, NOW(), 'Apeksha Patel'),
    ('lab_03', 'ahmedabad', 'science city rd', 1, NOW(), 'Apeksha Patel'),
    ('lab_12', 'ahmedabad', 'cg road', 2, NOW(), 'Apeksha Patel');

INSERT INTO lab_threshold (lab_id, lab_capacity, lead_threshold, ideation_engg_threshold,
    buddy_engg_threshold, status, creator_stamp, creator_user) VALUES
    (1, 150, 5, 20, 25, 1, NOW(), 'Apeksha Patel'), (2, 350, 8, 30, 25, 1, NOW(), 'Apeksha Patel'),
    (3, 200, 7, 28, 30, 1, NOW(), 'Apeksha Patel'), (4, 100, 3, 10, 15, 1, NOW(), 'Apeksha Patel'),
    (5, 250, 6, 20, 25, 1, NOW(), 'Apeksha Patel'), (6, 500, 10, 25, 30, 1, NOW(), 'Apeksha Patel'),
    (7, 150, 4, 10, 15, 1, NOW(), 'Apeksha Patel'), (8, 250, 5, 10, 25, 1, NOW(), 'Apeksha Patel'),
    (9, 300, 7, 15, 25, 1, NOW(), 'Apeksha Patel'), (10, 150, 3, 10, 25, 1, NOW(), 'Apeksha Patel');

INSERT INTO maker_program
    (program_name, program_type, program_link, tech_stack_id, tech_type_id, is_program_approved, description,
    status, creator_stamp, creator_user) VALUES
    ('Java_Full_Stack', 'full stack', 'https://java-full-stack-program/abc-abcx', 1, 1, 1, '', 1, NOW(), 'Harsh Shah'),
    ('Java_Backend_Hibernate', 'backend', 'https://java-backend-program/sdc-aecx', 2, 3, 1, 'Tutorial related to db connection', 1, NOW(), 'Harsh Shah'),
    ('Python_Frontend_PyScript', 'frontend', 'https://python-program/rrt-erss', 8, 2, 2, '', 2, NOW(), 'Harsh Shah'),
    ('Javascript_Full_Stack+Express+Node', 'full stack', 'https://js-full-stack-program/snfkds', 3, 1, 2, '', 1, NOW(), 'Harsh Shah'),
    ('Javascript_backend', 'backend', 'https://javascript-backend-program/mclkdsf', 6, 3, 1, '', 1, NOW(), 'Harsh Shah'),
    ('PHP', 'backend', 'https://php-backend-program/sdwef9efjwe', 5, 3, 1, 'LAMP stack', 1, NOW(), 'Harsh Shah'),
    ('Javascript_full_stack+jquery+react', 'full stack', 'https://javascript-full-stack-program/esdfcwe', 1, 1, 1, '', 2, NOW(), 'Harsh Shah');

INSERT INTO mentor (name, mentor_type, lab_id, status, creator_stamp, creator_user) VALUES
    ('Abhishek Singh', 1, 5, 1, NOW(), 'Neha Gupta'), ('Aarya Bhatt', 1, 3, 1, NOW(), 'Neha Gupta'),
    ('Neha Parmar', 3, 10, 2, NOW(), 'Neha Gupta'), ('Pranav Jhala', 2, 2, 1, NOW(), 'Neha Gupta'),
    ('Sandeep Mehta', 2, 8, 1, NOW(), 'Neha Gupta'), ('Gaurav Verma', 2, 7, 2, NOW(), 'Neha Gupta'),
    ('Priya Patel', 3, 4, 1, NOW(), 'Neha Gupta'), ('Pooja Nanda', 1, 6, 1, NOW(), 'Neha Gupta'),
    ('Kabir Patel', 3, 5, 1, NOW(), 'Neha Gupta'), ('Mukesh Kapoor', 3, 8, 1, NOW(), 'Neha Gupta');

INSERT INTO mentor_ideation_map (parent_mentor_id, mentor_id, status, creator_stamp, creator_user) VALUES
    (1, 3, 1, NOW(), 'Neha Gupta'), (1, 4, 1, NOW(), 'Neha Gupta'), (1, 5, 1, NOW(), 'Neha Gupta'),
    (2, 6, 2, NOW(), 'Neha Gupta'), (2, 5, 1, NOW(), 'Neha Gupta'), (1, 7, 1, NOW(), 'Neha Gupta'),
    (2, 10, 1, NOW(), 'Neha Gupta'), (2, 9, 1, NOW(), 'Neha Gupta'), (5, 8, 2, NOW(), 'Neha Gupta');

INSERT INTO mentor_tech_stack (mentor_id, tech_stack_id, status, creator_stamp, creator_user) VALUES
    (1, 5, 1, NOW(), 'Neha Gupta'), (2, 3, 1, NOW(), 'Neha Gupta'), (3, 2, 2, NOW(), 'Neha Gupta'),
    (4, 8, 1, NOW(), 'Neha Gupta'), (5, 10, 1, NOW(), 'Neha Gupta'), (6, 9, 1, NOW(), 'Neha Gupta'),
    (7, 2, 2, NOW(), 'Neha Gupta'), (8, 1, 1, NOW(), 'Neha Gupta'), (9, 4, 1, NOW(), 'Neha Gupta'),
    (10, 3, 2, NOW(), 'Neha Gupta');

INSERT INTO company_requirement (company_id, requested_month, city, is_doc_verification,
    requirement_doc_path, no_of_engg, tech_stack_id, tech_type_id, maker_program_id, lead_id,
    ideation_engg_id, buddy_engg_id, special_remark, status, creator_stamp, creator_user) VALUES
    (1, '2019-04-19', 'Mumbai', 1, 'doc/doc1.pdf', 10, 3, 2, 9, 1, 4, 5, '', 1, NOW(), 'Kashish Parmar'),
    (3, '2019-05-10', 'Pune', 2, 'doc/doc1.pdf', 5, 5, 1, 5, 2, 3, 6, '', 1, NOW(), 'Kashish Parmar'),
    (4, '2020-06-15', 'Ahmedabad', 1, 'doc/doc1.pdf', 4, 1, 3, 4, 1, 8, 9, '', 1, NOW(), 'Kashish Parmar'),
    (5, '2020-08-31', 'Delhi', 1, 'doc/doc1.pdf', 5, 7, 3, 8, 5, 2, 10, '', 2, NOW(), 'Kashish Parmar'),
    (10, '2020-01-01', 'Bangalore', 2, 'doc/doc1.pdf', 8, 10, 2, 9, 1, 4, 5, '', 1, NOW(), 'Kashish Parmar'),
    (7, '2021-11-11', 'Pune', 1, 'doc/doc1.pdf', 10, 5, 1, 1, 5, 2, 7, '', 1, NOW(), 'Kashish Parmar');