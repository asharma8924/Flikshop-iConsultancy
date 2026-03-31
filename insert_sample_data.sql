-- ============================================
-- INSERT Sample Data
-- ============================================

-- ============================================
-- GEOGRAPHIC LOOKUP TABLES
-- ============================================

INSERT INTO Country (country_name, country_code) VALUES
('United States', 'USA'),
('Canada', 'CAN'),
('United Kingdom', 'GBR');

INSERT INTO State (state_name, state_code, country_id) VALUES
('Maryland', 'MD', 1),
('California', 'CA', 1),
('New York', 'NY', 1),
('Ontario', 'ON', 2),
('England', 'ENG', 3);

INSERT INTO Address (address_line_1, address_line_2, city, state_id, zipcode, country_id) VALUES
('1234 Testudo Way', 'Apt 5', 'College Park', 1, '20740', 1),
('8763 Brick Lane', '', 'Baltimore', 1, '21201', 1),
('1976 Testudo Drive', 'Unit 12', 'College Park', 1, '20742', 1),
('500 Prison Road', '', 'Cumberland', 1, '21502', 1),
('750 Correctional Ave', '', 'Hagerstown', 1, '21740', 1),
('100 Detention Blvd', '', 'Baltimore', 1, '21215', 1);

-- ============================================
-- OTHER LOOKUP/REFERENCE TABLES
-- ============================================

INSERT INTO Customer_Type (customer_type_name) VALUES
('SUPER USER'),
('RISING STAR'),
('FLIKSHOP ANGEL');

INSERT INTO Tag_Name (tag_name) VALUES
('Tag 1'),
('Tag 2'),
('Tag 3');

INSERT INTO Tag_Status (status_name) VALUES
('Completed'),
('Canceled'),
('Pending');

INSERT INTO Category (category_name, category_description) VALUES
('Customer', 'Description a'),
('Data sets', 'Description b'),
('Sibling', 'Description c');

INSERT INTO Order_Type (order_type_name) VALUES
('postcard'),
('print'),
('flikbook');

INSERT INTO Order_Status (status_name) VALUES
('delivered'),
('processed'),
('pending');

INSERT INTO Note_Type (note_type_name) VALUES
('order'),
('customer');

INSERT INTO Request_Status (status_name) VALUES
('yes'),
('no'),
('pending'),
('completed'),
('canceled');

INSERT INTO Event_Status (status_name) VALUES
('Pending'),
('Completed');

INSERT INTO Promotion_Type (promotion_type_name) VALUES
('Free credits'),
('Other Type');

INSERT INTO Request_Reason (reason_name) VALUES
('Spouse to Love too'),
('Sibling'),
('Other reason');

INSERT INTO Media_Type (media_type_name) VALUES
('Holiday'),
('Seasonal');

-- ============================================
-- CORE TABLES
-- ============================================

INSERT INTO User (user_first_name, user_last_name, user_email, credits, phone_number, device_operating_system, customer_type_id, address_id) VALUES
('Maya', 'Patel', 'maya@umd.edu', 132.24, '2022222020', 'Android', 1, 1),
('Illia', 'Polishchuk', 'illia@umd.edu', 12.00, '1237891234', 'iOS', 2, 2),
('Andy', 'Yang', 'andy@umd.edu', 34.52, '8404678932', 'Laptop', 3, 3);

INSERT INTO User_Login (user_id, login_username, login_password) VALUES
(1, 'a_maker', '1234!'),
(2, 'i_polish', 'psswrd'),
(3, 'a_yang', 'wDup$');

INSERT INTO User_Tag (user_id, tag_name_id, tag_status_id, category_id) VALUES
(1, 1, 1, 1),
(2, 2, 2, 2),
(3, 3, 3, 3);

INSERT INTO Admin_Role (role_name, access_level) VALUES
('UX-UI Designer', 'Developer'),
('CEO', 'Team Member'),
('Web Designer', 'Tester');

INSERT INTO Admin (admin_first_name, admin_last_name, admin_email, phone_number, role_id) VALUES
('Allan', 'Maker', 'amaker@gmail.com', '6548901233', 1),
('Marcus', 'Butler', 'marcus@gmail.com', '4546789213', 2),
('John', 'Doe', 'jdoe@gmail.com', '9087654567', 3);

INSERT INTO Admin_Login (admin_id, login_username, login_password) VALUES
(1, 'a_maker', 'letmein'),
(2, 'm_butler', 'password'),
(3, 'j_doe', 'Secret123!');

INSERT INTO Facility (facility_name, address_id, visibility) VALUES
('Prison Name 1', 4, 'yes'),
('Prison Name 2', 5, 'no'),
('Prison Name 3', 6, 'yes');

INSERT INTO Recipient (recipient_first_name, recipient_last_name, facility_id) VALUES
('Liv', 'Sevy', 3),
('Sandra', 'Smith', 1),
('Athena', 'Yang', 2);

INSERT INTO Orders (order_number, order_type_id, user_id, order_date, delivery_date, order_status_id, recipient_id) VALUES
('SO124568', 1, 2, '2015-02-05', '2015-02-09', 1, 3),
('SO127645', 2, 3, '2015-02-07', NULL, 2, 1),
('SO376451', 3, 1, '2015-02-09', '2015-02-14', 1, 1);

INSERT INTO Group_Info (group_name, group_start_date, group_end_date) VALUES
('Group 1', '2015-04-14', '2015-05-14'),
('Group 2', '2015-05-07', '2015-11-17'),
('Group 3', '2015-11-23', '2015-12-25');

INSERT INTO Group_Tags (group_id, tag_name_id) VALUES
(1, 2),
(2, 3),
(2, 1),
(3, 2),
(3, 3),
(3, 1);

INSERT INTO Group_Members (group_id, user_id) VALUES
(1, 1),
(1, 2),
(2, 3),
(3, 1),
(3, 2),
(3, 3);

INSERT INTO Notes (recipient_id, user_id, order_id, note_status, date_requested, subject, note_type_id, note_contents) VALUES
(3, 1, 1, 'Yes', '2015-06-07', 'Unprinted ID #122456 Detect Label', 1, 'Message contents 1'),
(2, 1, 2, 'No', '2015-07-02', 'Unprinted ID #122456 Detect Label', 2, 'Message contents 2'),
(3, 2, 3, 'No', '2015-08-27', 'Unprinted ID #122456 Detect Label', 1, 'Message contents 3');

INSERT INTO Gift_Cards (user_id, credits, redemption_status, redemption_date, gift_card_number) VALUES
(3, 25.00, 'yes', '2015-06-12', 'AB1564'),
(2, 50.00, 'no', '2015-07-04', 'HG5432'),
(2, 120.00, 'yes', '2015-08-17', 'J9183J9');

INSERT INTO Service_Requests (user_id, rating, review, request_status_id) VALUES
(3, 3.5, 'Good service.', 1),
(2, NULL, NULL, 2),
(1, 4.0, 'Excellent experience...', 1);

INSERT INTO Promotions (promotion_name, promotion_type_id, promotion_description, promotion_start_date, promotion_end_date, promotion_status, credits_added) VALUES
('Promotion name 1', 1, 'Long description 1', '2015-06-05', '2015-06-12', 'active', 15.00),
('Promotion name 1', 2, 'Long description 2', '2015-07-20', '2015-07-30', 'inactive', 10.00),
('Promotion name 2', 1, 'Long description 3', '2015-08-18', '2015-08-24', 'active', 50.00);

INSERT INTO Team_Events (user_id, event_status_id, event_start_date, event_end_date) VALUES
(2, 1, '2015-03-22', NULL),
(2, 1, '2015-04-30', NULL),
(1, 2, '2015-06-21', '2015-06-28');

INSERT INTO Credit_Requests (user_id, request_reason_id, request_message, request_status_id, request_amount) VALUES
(1, 1, 'Request message 1', 5, 45.00),
(2, 2, 'Request message 2', 3, 50.00),
(3, 3, 'Request message 3', 4, 5.00);

INSERT INTO Suggested_Media (media_name, media_type_id) VALUES
('Valentine''s Day', 1),
('Women''s Day', 1),
('Halloween', 1);
