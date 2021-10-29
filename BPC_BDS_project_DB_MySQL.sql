-- -----------------------------------------------------
-- 	   1. Project Assignment - Database Design
--                  BPC_BDS_MySQL
-- Authors: Adam Kubiš(213431), Jakub Jarina(230086)
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema BPC_BDS_Project
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `BPC_BDS_Project` DEFAULT CHARACTER SET utf8;
USE `BPC_BDS_Project`;

-- -----------------------------------------------------
-- Table `BPC_BDS_Project`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BPC_BDS_Project`.`users` (
  `id_user` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(50) NOT NULL,
  `last_name` VARCHAR(50) NOT NULL,
  `email` VARCHAR(50) NOT NULL,
  `phone_number` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id_user`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `BPC_BDS_Project`.`address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BPC_BDS_Project`.`address` (
  `id_address` INT NOT NULL AUTO_INCREMENT,
  `street` VARCHAR(50) NOT NULL,
  `house_number` INT NOT NULL,
  `postcode` VARCHAR(45) NOT NULL,
  `city` VARCHAR(50) NOT NULL,
  `country` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id_address`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `BPC_BDS_Project`.`order_status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BPC_BDS_Project`.`order_status` (
  `status_code` INT NOT NULL AUTO_INCREMENT,
  `status_description` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`status_code`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `BPC_BDS_Project`.`payment_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BPC_BDS_Project`.`payment_type` (
  `payment_type_id` INT NOT NULL AUTO_INCREMENT,
  `payment_method` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`payment_type_id`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `BPC_BDS_Project`.`payment_status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BPC_BDS_Project`.`payment_status` (
  `id_payment_status` INT NOT NULL AUTO_INCREMENT,
  `payment_status_type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_payment_status`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `BPC_BDS_Project`.`payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BPC_BDS_Project`.`payment` (
  `id_payment` INT NOT NULL AUTO_INCREMENT,
  `payment_type` INT NOT NULL,
  `id_payment_status` INT NOT NULL,
  `subtotal` REAL NOT NULL,
  `discount` REAL NOT NULL,
  `shippment` REAL NOT NULL,
  `total` REAL NOT NULL,
  `paid_at` DATETIME NULL,
  PRIMARY KEY (`id_payment`, `payment_type`, `id_payment_status`),
  INDEX `fk_payment_has_type_idx` (`payment_type` ASC),
  INDEX `fk_payment_payment_status1_idx` (`id_payment_status` ASC),
  CONSTRAINT `fk_payment_has_type`
    FOREIGN KEY (`payment_type`)
    REFERENCES `BPC_BDS_Project`.`payment_type` (`payment_type_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_payment_payment_status1`
    FOREIGN KEY (`id_payment_status`)
    REFERENCES `BPC_BDS_Project`.`payment_status` (`id_payment_status`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `BPC_BDS_Project`.`order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BPC_BDS_Project`.`order` (
  `id_order` INT NOT NULL AUTO_INCREMENT,
  `order_status_code` INT NOT NULL,
  `id_payment` INT NOT NULL,
  PRIMARY KEY (`id_order`, `order_status_code`, `id_payment`),
  INDEX `fk_order_order_status1_idx` (`order_status_code` ASC),
  INDEX `fk_order_payment1_idx` (`id_payment` ASC),
  CONSTRAINT `fk_order_order_status1`
    FOREIGN KEY (`order_status_code`)
    REFERENCES `BPC_BDS_Project`.`order_status` (`status_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_payment1`
    FOREIGN KEY (`id_payment`)
    REFERENCES `BPC_BDS_Project`.`payment` (`id_payment`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `BPC_BDS_Project`.`product_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BPC_BDS_Project`.`product_type` (
  `product_type_id` INT NOT NULL AUTO_INCREMENT,
  `product_type_description` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`product_type_id`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `BPC_BDS_Project`.`product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BPC_BDS_Project`.`product` (
  `id_product` INT NOT NULL AUTO_INCREMENT,
  `id_product_type` INT NOT NULL,
  `product_brand_name` VARCHAR(45) NOT NULL,
  `product_model` VARCHAR(45) NOT NULL,
  `product_version` VARCHAR(45) NULL,
  `product_color` VARCHAR(45) NULL,
  `product_price` REAL NOT NULL,
  `in_stock` INT NOT NULL,
  PRIMARY KEY (`id_product`, `id_product_type`),
  INDEX `fk_product_has_type_idx` (`id_product_type` ASC),
  CONSTRAINT `fk_product_has_type`
    FOREIGN KEY (`id_product_type`)
    REFERENCES `BPC_BDS_Project`.`product_type` (`product_type_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `BPC_BDS_Project`.`users_has_order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BPC_BDS_Project`.`users_has_order` (
  `id_user` INT NOT NULL,
  `id_order` INT NOT NULL,
  PRIMARY KEY (`id_user`, `id_order`),
  INDEX `fk_users_has_order_order1_idx` (`id_order` ASC),
  INDEX `fk_users_has_order_users1_idx` (`id_user` ASC),
  CONSTRAINT `fk_users_has_order_users1`
    FOREIGN KEY (`id_user`)
    REFERENCES `BPC_BDS_Project`.`users` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_has_order_order1`
    FOREIGN KEY (`id_order`)
    REFERENCES `BPC_BDS_Project`.`order` (`id_order`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `BPC_BDS_Project`.`order_has_product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BPC_BDS_Project`.`order_has_product` (
  `id_order` INT NOT NULL,
  `id_product` INT NOT NULL,
  `quantity` INT NOT NULL,
  PRIMARY KEY (`id_order`, `id_product`),
  INDEX `fk_order_has_product_product1_idx` (`id_product` ASC),
  INDEX `fk_order_has_product_order1_idx` (`id_order` ASC),
  CONSTRAINT `fk_order_has_product_order1`
    FOREIGN KEY (`id_order`)
    REFERENCES `BPC_BDS_Project`.`order` (`id_order`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_has_product_product1`
    FOREIGN KEY (`id_product`)
    REFERENCES `BPC_BDS_Project`.`product` (`id_product`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `BPC_BDS_Project`.`account`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BPC_BDS_Project`.`account` (
  `id_account` INT NOT NULL AUTO_INCREMENT,
  `account_type` VARCHAR(45) NOT NULL,
  `registration` DATETIME NULL,
  `last_login` DATETIME NULL,
  PRIMARY KEY (`id_account`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `BPC_BDS_Project`.`users_has_account`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BPC_BDS_Project`.`users_has_account` (
  `id_user` INT NOT NULL,
  `id_account` INT NOT NULL,
  `registration` DATETIME NULL,
  `last_login` DATETIME NULL,
  PRIMARY KEY (`id_user`, `id_account`),
  INDEX `fk_users_has_account_users1_idx` (`id_user` ASC),
  INDEX `fk_users_has_account_account1_idx` (`id_account` ASC),
  CONSTRAINT `fk_users_has_account_users1`
    FOREIGN KEY (`id_user`)
    REFERENCES `BPC_BDS_Project`.`users` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_has_account_account1`
    FOREIGN KEY (`id_account`)
    REFERENCES `BPC_BDS_Project`.`account` (`id_account`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `BPC_BDS_Project`.`users_has_address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BPC_BDS_Project`.`users_has_address` (
  `id_user` INT NOT NULL,
  `id_address` INT NOT NULL,
  PRIMARY KEY (`id_user`, `id_address`),
  INDEX `fk_users_has_address_address1_idx` (`id_address` ASC),
  INDEX `fk_users_has_address_users1_idx` (`id_user` ASC),
  CONSTRAINT `fk_users_has_address_users1`
    FOREIGN KEY (`id_user`)
    REFERENCES `BPC_BDS_Project`.`users` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_has_address_address1`
    FOREIGN KEY (`id_address`)
    REFERENCES `BPC_BDS_Project`.`address` (`id_address`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
