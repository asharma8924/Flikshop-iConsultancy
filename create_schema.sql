-- ============================================
-- 3NF Normalized Database Schema
-- Total Tables: 35
-- ============================================

-- ============================================
-- GEOGRAPHIC LOOKUP TABLES
-- ============================================

CREATE TABLE Country (
    country_id INT PRIMARY KEY AUTO_INCREMENT,
    country_name VARCHAR(100) UNIQUE NOT NULL,
    country_code VARCHAR(3) UNIQUE
);

CREATE TABLE State (
    state_id INT PRIMARY KEY AUTO_INCREMENT,
    state_name VARCHAR(100) NOT NULL,
    state_code VARCHAR(10),
    country_id INT NOT NULL,
    FOREIGN KEY (country_id) REFERENCES Country(country_id),
    UNIQUE(state_name, country_id)
);

CREATE TABLE Address (
    address_id INT PRIMARY KEY AUTO_INCREMENT,
    address_line_1 VARCHAR(255),
    address_line_2 VARCHAR(255),
    city VARCHAR(100),
    state_id INT,
    zipcode VARCHAR(20),
    country_id INT,
    FOREIGN KEY (state_id) REFERENCES State(state_id),
    FOREIGN KEY (country_id) REFERENCES Country(country_id)
);

-- ============================================
-- OTHER LOOKUP/REFERENCE TABLES
-- ============================================

CREATE TABLE Customer_Type (
    customer_type_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_type_name VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE Tag_Name (
    tag_name_id INT PRIMARY KEY AUTO_INCREMENT,
    tag_name VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE Tag_Status (
    tag_status_id INT PRIMARY KEY AUTO_INCREMENT,
    status_name VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE Order_Type (
    order_type_id INT PRIMARY KEY AUTO_INCREMENT,
    order_type_name VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE Order_Status (
    order_status_id INT PRIMARY KEY AUTO_INCREMENT,
    status_name VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE Note_Type (
    note_type_id INT PRIMARY KEY AUTO_INCREMENT,
    note_type_name VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE Request_Status (
    request_status_id INT PRIMARY KEY AUTO_INCREMENT,
    status_name VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE Event_Status (
    event_status_id INT PRIMARY KEY AUTO_INCREMENT,
    status_name VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE Promotion_Type (
    promotion_type_id INT PRIMARY KEY AUTO_INCREMENT,
    promotion_type_name VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE Request_Reason (
    request_reason_id INT PRIMARY KEY AUTO_INCREMENT,
    reason_name VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE Media_Type (
    media_type_id INT PRIMARY KEY AUTO_INCREMENT,
    media_type_name VARCHAR(100) UNIQUE NOT NULL
);

-- ============================================
-- CORE TABLES
-- ============================================

CREATE TABLE Category (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(100) UNIQUE NOT NULL,
    category_description TEXT
);

CREATE TABLE User (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    user_first_name VARCHAR(50) NOT NULL,
    user_last_name VARCHAR(50) NOT NULL,
    user_email VARCHAR(100) UNIQUE NOT NULL,
    credits DECIMAL(10,2) DEFAULT 0.00,
    phone_number VARCHAR(15),
    device_operating_system VARCHAR(50),
    customer_type_id INT,
    address_id INT,
    FOREIGN KEY (customer_type_id) REFERENCES Customer_Type(customer_type_id),
    FOREIGN KEY (address_id) REFERENCES Address(address_id)
);

CREATE TABLE User_Login (
    login_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL UNIQUE,
    login_username VARCHAR(50) UNIQUE NOT NULL,
    login_password VARCHAR(255) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES User(user_id) ON DELETE CASCADE
);

CREATE TABLE User_Tag (
    user_tag_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    tag_name_id INT NOT NULL,
    tag_status_id INT,
    category_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES User(user_id) ON DELETE CASCADE,
    FOREIGN KEY (tag_name_id) REFERENCES Tag_Name(tag_name_id),
    FOREIGN KEY (tag_status_id) REFERENCES Tag_Status(tag_status_id),
    FOREIGN KEY (category_id) REFERENCES Category(category_id)
);

CREATE TABLE Admin_Role (
    role_id INT PRIMARY KEY AUTO_INCREMENT,
    role_name VARCHAR(100) UNIQUE NOT NULL,
    access_level VARCHAR(50) NOT NULL
);

CREATE TABLE Admin (
    admin_id INT PRIMARY KEY AUTO_INCREMENT,
    admin_first_name VARCHAR(50) NOT NULL,
    admin_last_name VARCHAR(50) NOT NULL,
    admin_email VARCHAR(100) UNIQUE NOT NULL,
    phone_number VARCHAR(15),
    role_id INT NOT NULL,
    FOREIGN KEY (role_id) REFERENCES Admin_Role(role_id)
);

CREATE TABLE Admin_Login (
    admin_login_id INT PRIMARY KEY AUTO_INCREMENT,
    admin_id INT NOT NULL UNIQUE,
    login_username VARCHAR(50) UNIQUE NOT NULL,
    login_password VARCHAR(255) NOT NULL,
    FOREIGN KEY (admin_id) REFERENCES Admin(admin_id) ON DELETE CASCADE
);

CREATE TABLE Facility (
    facility_id INT PRIMARY KEY AUTO_INCREMENT,
    facility_name VARCHAR(200) NOT NULL,
    address_id INT,
    visibility VARCHAR(10),
    FOREIGN KEY (address_id) REFERENCES Address(address_id)
);

CREATE TABLE Recipient (
    recipient_id INT PRIMARY KEY AUTO_INCREMENT,
    recipient_first_name VARCHAR(50) NOT NULL,
    recipient_last_name VARCHAR(50) NOT NULL,
    facility_id INT NOT NULL,
    FOREIGN KEY (facility_id) REFERENCES Facility(facility_id)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    order_number VARCHAR(50) UNIQUE NOT NULL,
    order_type_id INT,
    user_id INT NOT NULL,
    order_date DATE NOT NULL,
    delivery_date DATE,
    order_status_id INT,
    recipient_id INT NOT NULL,
    FOREIGN KEY (order_type_id) REFERENCES Order_Type(order_type_id),
    FOREIGN KEY (user_id) REFERENCES User(user_id),
    FOREIGN KEY (order_status_id) REFERENCES Order_Status(order_status_id),
    FOREIGN KEY (recipient_id) REFERENCES Recipient(recipient_id)
);

CREATE TABLE Group_Info (
    group_id INT PRIMARY KEY AUTO_INCREMENT,
    group_name VARCHAR(100) NOT NULL,
    group_start_date DATE,
    group_end_date DATE
);

CREATE TABLE Group_Tags (
    group_tag_id INT PRIMARY KEY AUTO_INCREMENT,
    group_id INT NOT NULL,
    tag_name_id INT NOT NULL,
    FOREIGN KEY (group_id) REFERENCES Group_Info(group_id) ON DELETE CASCADE,
    FOREIGN KEY (tag_name_id) REFERENCES Tag_Name(tag_name_id)
);

CREATE TABLE Group_Members (
    group_member_id INT PRIMARY KEY AUTO_INCREMENT,
    group_id INT NOT NULL,
    user_id INT NOT NULL,
    FOREIGN KEY (group_id) REFERENCES Group_Info(group_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES User(user_id) ON DELETE CASCADE,
    UNIQUE(group_id, user_id)
);

CREATE TABLE Notes (
    note_id INT PRIMARY KEY AUTO_INCREMENT,
    recipient_id INT NOT NULL,
    user_id INT NOT NULL,
    order_id INT,
    note_status VARCHAR(50),
    date_requested DATE,
    subject VARCHAR(255),
    note_type_id INT,
    note_contents TEXT,
    FOREIGN KEY (recipient_id) REFERENCES Recipient(recipient_id),
    FOREIGN KEY (user_id) REFERENCES User(user_id),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (note_type_id) REFERENCES Note_Type(note_type_id)
);

CREATE TABLE Gift_Cards (
    gift_card_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    credits DECIMAL(10,2) NOT NULL,
    redemption_status VARCHAR(10),
    redemption_date DATE,
    gift_card_number VARCHAR(50) UNIQUE NOT NULL,
    FOREIGN KEY (user_id) REFERENCES User(user_id)
);

CREATE TABLE Service_Requests (
    request_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    rating DECIMAL(2,1),
    review TEXT,
    request_status_id INT,
    FOREIGN KEY (user_id) REFERENCES User(user_id),
    FOREIGN KEY (request_status_id) REFERENCES Request_Status(request_status_id)
);

CREATE TABLE Promotions (
    promotion_id INT PRIMARY KEY AUTO_INCREMENT,
    promotion_name VARCHAR(100) NOT NULL,
    promotion_type_id INT,
    promotion_description TEXT,
    promotion_start_date DATE,
    promotion_end_date DATE,
    promotion_status VARCHAR(50),
    credits_added DECIMAL(10,2),
    FOREIGN KEY (promotion_type_id) REFERENCES Promotion_Type(promotion_type_id)
);

CREATE TABLE Team_Events (
    event_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    event_status_id INT,
    event_start_date DATE,
    event_end_date DATE,
    FOREIGN KEY (user_id) REFERENCES User(user_id),
    FOREIGN KEY (event_status_id) REFERENCES Event_Status(event_status_id)
);

CREATE TABLE Credit_Requests (
    credit_request_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    request_reason_id INT,
    request_message TEXT,
    request_status_id INT,
    request_amount DECIMAL(10,2),
    FOREIGN KEY (user_id) REFERENCES User(user_id),
    FOREIGN KEY (request_reason_id) REFERENCES Request_Reason(request_reason_id),
    FOREIGN KEY (request_status_id) REFERENCES Request_Status(request_status_id)
);

CREATE TABLE Suggested_Media (
    media_id INT PRIMARY KEY AUTO_INCREMENT,
    media_name VARCHAR(100) NOT NULL,
    media_type_id INT,
    FOREIGN KEY (media_type_id) REFERENCES Media_Type(media_type_id)
);
