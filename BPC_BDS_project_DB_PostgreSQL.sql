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
    id_user INTEGER NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    registration TIMESTAMP NOT NULL,
    last_login TIMESTAMP NOT NULL,
    email VARCHAR(50) NOT NULL,
    phone_number VARCHAR(20) NOT NULL,
    PRIMARY KEY (id_user)
);
ALTER TABLE bpc_bds_project.users OWNER TO postgres;

-- -----------------------------------------------------
-- Table BPC_BDS_Project.address
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS bpc_bds_project.address
(
    id_address INTEGER NOT NULL,
    street VARCHAR(50) NOT NULL,
    house_number INTEGER NOT NULL,
    postcode VARCHAR(45) NOT NULL,
    city VARCHAR(50) NOT NULL,
    country VARCHAR(50) NOT NULL,
    PRIMARY KEY (id_address)
);
ALTER TABLE bpc_bds_project.address OWNER TO postgres;


-- -----------------------------------------------------
-- Table BPC_BDS_Project.user_has_address
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS bpc_bds_project.user_has_address
(
    id_user INTEGER NOT NULL,
    id_address INTEGER NOT NULL,
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
ALTER TABLE bpc_bds_project.user_has_address OWNER TO postgres;


-- -----------------------------------------------------
-- Table BPC_BDS_Project.order
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS bpc_bds_project.order
(
    id_order INTEGER NOT NULL,
    subtotal REAL NOT NULL,
    discount REAL NOT NULL,
    shipping REAL NOT NULL,
    total REAL NOT NULL,
    PRIMARY KEY (id_order)
);
ALTER TABLE bpc_bds_project.order OWNER TO postgres;


-- -----------------------------------------------------
-- Table BPC_BDS_Project.user_has_order
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS bpc_bds_project.user_has_order
(
    id_user INTEGER NOT NULL,
    id_order INTEGER NOT NULL,
    status VARCHAR(50) NOT NULL,
	CONSTRAINT fk_user_has_order1
		FOREIGN KEY (id_user)
		REFERENCES bpc_bds_project.users (id_user)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION,
	CONSTRAINT fk_user_has_order2
		FOREIGN KEY (id_order)
		REFERENCES bpc_bds_project.order (id_order)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
);
ALTER TABLE bpc_bds_project.user_has_order OWNER TO postgres;


-- -----------------------------------------------------
-- Table BPC_BDS_Project.transaction
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS bpc_bds_project.transaction
(
    id_transaction INTEGER,
    id_order INTEGER,
    payment VARCHAR(50),
    paid_at TIMESTAMP,
    PRIMARY KEY (id_transaction),
	CONSTRAINT fk_transaction
		FOREIGN KEY (id_order)
		REFERENCES bpc_bds_project.order (id_order)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
);
ALTER TABLE bpc_bds_project.transaction OWNER TO postgres;

-- -----------------------------------------------------
-- Table BPC_BDS_Project.product
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS bpc_bds_project.product
(
    id_product INTEGER NOT NULL,
    name VARCHAR(50) NOT NULL,
    PRIMARY KEY (id_product)
);
ALTER TABLE bpc_bds_project.product OWNER TO postgres;

-- -----------------------------------------------------
-- Table BPC_BDS_Project.order_has_product
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS bpc_bds_project.order_has_product
(
    id_order INTEGER NOT NULL,
    id_product INTEGER NOT NULL,
    quantity INTEGER NOT NULL,
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
-- Table BPC_BDS_Project.brand
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS bpc_bds_project.brand
(
    id_brand INTEGER NOT NULL,
    brand VARCHAR(50) NOT NULL,
    PRIMARY KEY (id_brand)
);
ALTER TABLE bpc_bds_project.brand OWNER TO postgres;

-- -----------------------------------------------------
-- Table BPC_BDS_Project.product_has_brand
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS bpc_bds_project.product_has_brand
(
    id_product INTEGER NOT NULL,
    id_brand INTEGER NOT NULL,
	CONSTRAINT fk_product_has_brand1
		FOREIGN KEY (id_product)
		REFERENCES bpc_bds_project.product (id_product)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION,
	CONSTRAINT fk_product_has_brand2
		FOREIGN KEY (id_brand)
		REFERENCES bpc_bds_project.brand (id_brand)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
);
ALTER TABLE bpc_bds_project.product_has_brand OWNER TO postgres;

-- -----------------------------------------------------
-- Table BPC_BDS_Project.specification
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS BPC_BDS_Project.specification
(
  id_specification INTEGER NOT NULL,
  product_type VARCHAR(45) NOT NULL,
  model VARCHAR(45) NULL,
  version VARCHAR(45) NULL,
  in_stock INTEGER NOT NULL,
  PRIMARY KEY (id_specification)
 );
 
-- -----------------------------------------------------
-- Table BPC_BDS_Project.product_has_specification
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS BPC_BDS_Project.product_has_specification
(
  id_product INTEGER NOT NULL,
  id_specification INTEGER NOT NULL,
  PRIMARY KEY (id_product, id_specification),
  CONSTRAINT fk_product_has_specification1
    FOREIGN KEY (id_product)
    REFERENCES BPC_BDS_Project.product (id_product)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_product_has_specification2
    FOREIGN KEY (id_specification)
    REFERENCES BPC_BDS_Project.specification (id_specification)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);
