-- DROP DATABASE IF EXISTS GRAB3;

CREATE DATABASE GRAB3;

USE GRAB3;



CREATE TABLE USERS(
	ID_USER CHAR(5) PRIMARY KEY, 
    FIRST_NAME CHAR(50), 
    LAST_NAME CHAR(50), 
    GENDER ENUM('MALE', 'FEMALE', 'OTHER'),
    BIRTHDATE DATE,
    PHONE CHAR(5)
);


CREATE TABLE LOCATIONS(
	ID_LOCATION INT AUTO_INCREMENT PRIMARY KEY,
    LOCATION CHAR(20)
);



CREATE TABLE CUSTOMERS(
	ID_CUS CHAR(50) PRIMARY KEY,
    ID_USER CHAR(5),
    CARDNUMBER CHAR(10),
    SECURITY_CODE CHAR(10),
    ID_LOCATION INT,
    
    FOREIGN KEY (ID_USER) REFERENCES USERS(ID_USER) ON UPDATE RESTRICT ON DELETE CASCADE,
    FOREIGN KEY (ID_LOCATION) REFERENCES LOCATIONS(ID_LOCATION) ON UPDATE RESTRICT ON DELETE CASCADE
);


CREATE TABLE DRIVERS(
	ID_DRIVER CHAR(5) PRIMARY KEY, 
    ID_USER CHAR(5),
    LICENSE CHAR(20),
    NUMBER_PLATE CHAR(20),
    STAR FLOAT,
    
    FOREIGN KEY (ID_USER) REFERENCES USERS(ID_USER) ON UPDATE RESTRICT ON DELETE CASCADE
);


CREATE TABLE RESTAURANTS(
	ID_RES CHAR(5) PRIMARY KEY,
    NAME_RES CHAR(50),
    DESCRIPTIONS CHAR(200), 
    OPEN_HOUR TIME,
    CLOSE_HOUR TIME,
    ID_LOCATION INT,
    STAR FLOAT,
    
    FOREIGN KEY (ID_LOCATION) REFERENCES LOCATIONS(ID_LOCATION) ON UPDATE RESTRICT ON DELETE CASCADE
);


CREATE TABLE FOODS(
	ID_FOOD CHAR(5) PRIMARY KEY,
    ID_RES CHAR(5),
    FNAME CHAR(50),
    PRICE INT,
    STOCKS INT,
    
    FOREIGN KEY (ID_RES) REFERENCES RESTAURANTS(ID_RES) ON UPDATE RESTRICT ON DELETE CASCADE
);


CREATE TABLE STATUSS(
	ID_STATUSS INT PRIMARY KEY, 
    STATUSS CHAR(50)
);


CREATE TABLE ORDERS(
	ID_ORDER CHAR(5) PRIMARY KEY,
    ID_CUS CHAR(5), 
    ID_DRIVER CHAR(5), 
    ID_RES CHAR(10),
	ID_STATUSS INT,
    ID_LOC_CUS INT, 
    NOTE CHAR(100),
    ORDER_TIME DATETIME,
    TAKEN_TIME DATETIME,
    
    FOREIGN KEY (ID_RES) REFERENCES RESTAURANTS(ID_RES) ON UPDATE RESTRICT ON DELETE CASCADE, 
    FOREIGN KEY (ID_CUS) REFERENCES CUSTOMERS(ID_CUS) ON UPDATE RESTRICT ON DELETE CASCADE, 
    FOREIGN KEY (ID_DRIVER) REFERENCES DRIVERS(ID_DRIVER) ON UPDATE RESTRICT ON DELETE CASCADE,
	FOREIGN KEY (ID_STATUSS) REFERENCES STATUSS(ID_STATUSS) ON UPDATE RESTRICT ON DELETE CASCADE,
    FOREIGN KEY (ID_LOC_CUS) REFERENCES LOCATIONS(ID_LOCATION) ON UPDATE RESTRICT ON DELETE CASCADE
    
);


CREATE TABLE MESSAGES(
	ID_MESS INT AUTO_INCREMENT PRIMARY KEY,
    ID_ORDER CHAR(5),
    MESSAGE CHAR(100),
    
    FOREIGN KEY (ID_ORDER) REFERENCES ORDERS(ID_ORDER) ON UPDATE RESTRICT ON DELETE CASCADE
);


CREATE TABLE ORDER_DETAILS(
	ID_OD INT AUTO_INCREMENT PRIMARY KEY,
    ID_ORDER CHAR(5),
    ID_FOOD CHAR(5), 
    QUANTITY INT,
    PRICE INT,
    
    FOREIGN KEY (ID_ORDER) REFERENCES ORDERS(ID_ORDER) ON UPDATE RESTRICT ON DELETE CASCADE,
	FOREIGN KEY (ID_FOOD) REFERENCES FOODS(ID_FOOD) ON UPDATE RESTRICT ON DELETE CASCADE
);


CREATE TABLE VOUCHERS(
	ID_VOUCHER CHAR(20) PRIMARY KEY,
    DISCOUNT FLOAT,
    MAX_USE INT
);


CREATE TABLE PAYMENTS(
	ID_PAYM INT AUTO_INCREMENT PRIMARY KEY,
    ID_ORDER CHAR(5),
    RES_COST INT,
    SHIP_COST INT,
    PAYMENT_METHOD ENUM('MOMO', 'AIRPAY', 'ZALO', 'BANKING', 'COD'),
    IS_PAID ENUM('0', '1'),
    VOUCHER_PM CHAR(20), 
    ID_VOUCHER CHAR(20) DEFAULT NULL,
    TOTAL_PRICE INT,

	FOREIGN KEY (ID_ORDER) REFERENCES ORDERS(ID_ORDER) ON UPDATE RESTRICT ON DELETE CASCADE,
    FOREIGN KEY (ID_VOUCHER) REFERENCES VOUCHERS(ID_VOUCHER) ON UPDATE RESTRICT ON DELETE CASCADE
);


CREATE TABLE RATINGS(
	ID_RATING CHAR(5) PRIMARY KEY, 
    ID_ORDER CHAR(5), 
    ID_RES CHAR(10),
    STAR_RES INT,
	ID_DRIVER CHAR(5),
    STAR_DRIVER INT,

	FOREIGN KEY (ID_RES) REFERENCES RESTAURANTS(ID_RES) ON UPDATE RESTRICT ON DELETE CASCADE,
	FOREIGN KEY (ID_ORDER) REFERENCES ORDERS(ID_ORDER) ON UPDATE RESTRICT ON DELETE CASCADE,
    FOREIGN KEY (ID_DRIVER) REFERENCES DRIVERS(ID_DRIVER) ON UPDATE RESTRICT ON DELETE CASCADE
);



CREATE TABLE AUDIT (
	AUDIT_ID INT NOT NULL AUTO_INCREMENT,
	CHANGED_TABLE CHAR(20) NOT NULL,
	ID CHAR(10) NOT NULL,
	FIELD1 CHAR(30) NOT NULL,
	OLD_DATA CHAR(30) DEFAULT NULL,
	NEW_DATA CHAR(30) DEFAULT NULL,
	ACTION_TIME DATETIME NOT NULL,
    
	PRIMARY KEY(AUDIT_ID)
);