-- -----------------------------------------------------
--     1. Project Assignment - Database Design
--                  BPC_BDS_MySQL
-- Authors: Adam Kubiš(213431), Jakub Jarina(230086)
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema BPC_BDS_Project
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS bpc_bds_project
    AUTHORIZATION postgres;

-- -----------------------------------------------------
-- Table BPC_BDS_Project.users
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS bpc_bds_project.users
(
    id_user serial NOT NULL,
    first_name character varying(50) NOT NULL,
    last_name character varying(50) NOT NULL,
    email character varying(50) NOT NULL,
    phone_number character varying(20) NOT NULL,
    PRIMARY KEY (id_user)
);
ALTER TABLE bpc_bds_project.users OWNER TO postgres;

-- -----------------------------------------------------
-- Table BPC_BDS_Project.address
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS bpc_bds_project.address
(
    id_address serial NOT NULL,
    street character varying(50) NOT NULL,
    house_number integer NOT NULL,
    postcode character varying(45) NOT NULL,
    city character varying(50) NOT NULL,
    country character varying(50) NOT NULL,
    PRIMARY KEY (id_address)
);
ALTER TABLE bpc_bds_project.address OWNER TO postgres;

-- -----------------------------------------------------
-- Table BPC_BDS_Project.account
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS bpc_bds_project.account
(
    id_account serial NOT NULL,
    account_type character varying(45) NOT NULL,
    PRIMARY KEY (id_account)
);
ALTER TABLE bpc_bds_project.account OWNER TO postgres;

-- -----------------------------------------------------
-- Table BPC_BDS_Project.users_has_address
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS bpc_bds_project.users_has_address
(
    id_user serial NOT NULL,
    id_address serial NOT NULL,
		CONSTRAINT fk_user_has_address1
			FOREIGN KEY (id_user)
			REFERENCES bpc_bds_project.users (id_user)
			ON DELETE NO ACTION
			ON UPDATE NO ACTION,
  		CONSTRAINT fk_user_has_address2
			FOREIGN KEY (id_address)
			REFERENCES bpc_bds_project.address (id_address)
			ON DELETE NO ACTION
			ON UPDATE NO ACTION
);
ALTER TABLE bpc_bds_project.users_has_address OWNER TO postgres;

-- -----------------------------------------------------
-- Table BPC_BDS_Project.users_has_account
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS bpc_bds_project.users_has_account
(
    id_user serial NOT NULL,
    id_account serial NOT NULL,
    registration timestamp with time zone,
    last_login timestamp with time zone,
		CONSTRAINT fk_user_has_account1
			FOREIGN KEY (id_user)
			REFERENCES bpc_bds_project.users (id_user)
			ON DELETE NO ACTION
			ON UPDATE NO ACTION,
  		CONSTRAINT fk_user_has_account2
			FOREIGN KEY (id_account)
			REFERENCES bpc_bds_project.account (id_account)
			ON DELETE NO ACTION
			ON UPDATE NO ACTION
);
ALTER TABLE bpc_bds_project.users_has_account OWNER TO postgres;

-- -----------------------------------------------------
-- Table BPC_BDS_Project.payment_type
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS bpc_bds_project.payment_type
(
    payment_type serial NOT NULL,
    payment_method character varying(45) NOT NULL,
    PRIMARY KEY (payment_type)
);
ALTER TABLE bpc_bds_project.payment_type OWNER TO postgres;

-- -----------------------------------------------------
-- Table BPC_BDS_Project.payment_status
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS bpc_bds_project.payment_status
(
    payment_status serial NOT NULL,
    payment_status_type character varying(45) NOT NULL,
    PRIMARY KEY (payment_status)
);
ALTER TABLE bpc_bds_project.payment_status OWNER TO postgres;

-- -----------------------------------------------------
-- Table BPC_BDS_Project.payment
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS bpc_bds_project.payment
(
    id_payment serial NOT NULL,
    payment_type serial NOT NULL,
    id_payment_status serial NOT NULL,
    subtotal real NOT NULL,
    discount real NOT NULL,
    shippment real NOT NULL,
    total real NOT NULL,
    paid_at timestamp with time zone,
    PRIMARY KEY (id_payment),
	CONSTRAINT fk_payment1
			FOREIGN KEY (payment_type)
			REFERENCES bpc_bds_project.payment_type (payment_type)
			ON DELETE NO ACTION
			ON UPDATE NO ACTION,
  	CONSTRAINT fk_payment2
			FOREIGN KEY (id_payment_status)
			REFERENCES bpc_bds_project.payment_status (payment_status)
			ON DELETE NO ACTION
			ON UPDATE NO ACTION
);
ALTER TABLE bpc_bds_project.payment OWNER TO postgres;

-- -----------------------------------------------------
-- Table BPC_BDS_Project.order_status
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS bpc_bds_project.order_status
(
    status_code serial NOT NULL,
    status_description character varying(45) NOT NULL,
    PRIMARY KEY (status_code)
);
ALTER TABLE bpc_bds_project.order_status OWNER TO postgres;

-- -----------------------------------------------------
-- Table BPC_BDS_Project.product_type
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS bpc_bds_project.product_type
(
    product_type serial NOT NULL,
    product_type_description character varying(45) NOT NULL,
    PRIMARY KEY (product_type)
);
ALTER TABLE bpc_bds_project.product_type OWNER TO postgres;

-- -----------------------------------------------------
-- Table BPC_BDS_Project.product
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS bpc_bds_project.product
(
    id_product serial NOT NULL,
    id_product_type serial NOT NULL,
    product_brand_name character varying(45) NOT NULL,
    product_model character varying(45) NOT NULL,
    product_version character varying(45),
    product_color character varying(45),
    product_price real NOT NULL,
    in_stock integer NOT NULL,
    PRIMARY KEY (id_product),
	CONSTRAINT fk_product1
			FOREIGN KEY (id_product_type)
			REFERENCES bpc_bds_project.product_type (product_type)
			ON DELETE NO ACTION
			ON UPDATE NO ACTION
);
ALTER TABLE bpc_bds_project.product OWNER TO postgres;

-- -----------------------------------------------------
-- Table BPC_BDS_Project.order
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS bpc_bds_project.order
(
    id_order serial NOT NULL,
    order_status_code serial NOT NULL,
    id_payment serial NOT NULL,
    PRIMARY KEY (id_order),
	CONSTRAINT fk_order1
			FOREIGN KEY (order_status_code)
			REFERENCES bpc_bds_project.order_status (status_code)
			ON DELETE NO ACTION
			ON UPDATE NO ACTION,
  	CONSTRAINT fk_order2
			FOREIGN KEY (id_payment)
			REFERENCES bpc_bds_project.payment (id_payment)
			ON DELETE NO ACTION
			ON UPDATE NO ACTION
);
ALTER TABLE bpc_bds_project.order OWNER TO postgres;

-- -----------------------------------------------------
-- Table BPC_BDS_Project.order_has_product
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS bpc_bds_project.order_has_product
(
    id_order serial NOT NULL,
    id_product serial NOT NULL,
    quantity integer NOT NULL,
	CONSTRAINT fk_order_has_product1
			FOREIGN KEY (id_order)
			REFERENCES bpc_bds_project.order (id_order)
			ON DELETE NO ACTION
			ON UPDATE NO ACTION,
  	CONSTRAINT fk_order_has_product2
			FOREIGN KEY (id_product)
			REFERENCES bpc_bds_project.product (id_product)
			ON DELETE NO ACTION
			ON UPDATE NO ACTION
);
ALTER TABLE bpc_bds_project.order_has_product OWNER TO postgres;

-- -----------------------------------------------------
-- Table BPC_BDS_Project.users_has_order
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS bpc_bds_project.users_has_order
(
    id_user serial NOT NULL,
    id_order serial NOT NULL,
	CONSTRAINT fk_users_has_order1
			FOREIGN KEY (id_user)
			REFERENCES bpc_bds_project.users (id_user)
			ON DELETE NO ACTION
			ON UPDATE NO ACTION,
  	CONSTRAINT fk_users_has_order2
			FOREIGN KEY (id_order)
			REFERENCES bpc_bds_project.order (id_order)
			ON DELETE NO ACTION
			ON UPDATE NO ACTION
);
ALTER TABLE bpc_bds_project.users_has_order OWNER TO postgres;
