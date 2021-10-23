CREATE DATABASE IF NOT EXISTS bpc_bds_project;

USE bpc_bds_project;

CREATE TABLE IF NOT EXISTS `BPC_BDS_Project`.`users` (
  `id_user` INT NOT NULL,
  `first_name` VARCHAR(50) NOT NULL,
  `last_name` VARCHAR(50) NOT NULL,
  `registration` TIMESTAMP NOT NULL,
  `last_login` TIMESTAMP NOT NULL,
  `email` VARCHAR(50) NOT NULL,
  `phone_number` INT NOT NULL,
  PRIMARY KEY (`id_user`),
  UNIQUE INDEX `ID_user_UNIQUE` (`id_user` ASC));
  
  CREATE TABLE IF NOT EXISTS `BPC_BDS_Project`.`address` (
  `id_address` INT NOT NULL,
  `street` VARCHAR(50) NOT NULL,
  `house_number` VARCHAR(50) NOT NULL,
  `postcode` VARCHAR(45) NOT NULL,
  `city` VARCHAR(50) NOT NULL,
  `country` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id_address`),
  UNIQUE INDEX `id_address_UNIQUE` (`id_address` ASC))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `BPC_BDS_Project`.`address_rs` (
  `id_user` INT NOT NULL,
  `id_address` INT NOT NULL,
  PRIMARY KEY (`id_user`, `id_address`),
  INDEX `fk_address_rs_users_idx` (`id_user` ASC),
  INDEX `fk_address_rs_address1_idx` (`id_address` ASC),
  CONSTRAINT `fk_address_rs_users`
    FOREIGN KEY (`id_user`)
    REFERENCES `BPC_BDS_Project`.`users` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_address_rs_address1`
    FOREIGN KEY (`id_address`)
    REFERENCES `BPC_BDS_Project`.`address` (`id_address`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `BPC_BDS_Project`.`order` (
  `id_order` INT NOT NULL,
  `subtotal` FLOAT NOT NULL,
  `discount` FLOAT NOT NULL,
  `shipping` FLOAT NOT NULL,
  `total` FLOAT NOT NULL,
  PRIMARY KEY (`id_order`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `BPC_BDS_Project`.`order_rs` (
  `id_user` INT NOT NULL,
  `id_order` INT NOT NULL,
  `status` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id_user`, `id_order`),
  INDEX `fk_order_rs_order1_idx` (`id_order` ASC),
  UNIQUE INDEX `id_user_UNIQUE` (`id_user` ASC),
  UNIQUE INDEX `id_order_UNIQUE` (`id_order` ASC),
  CONSTRAINT `fk_order_rs_users1`
    FOREIGN KEY (`id_user`)
    REFERENCES `BPC_BDS_Project`.`users` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_rs_order1`
    FOREIGN KEY (`id_order`)
    REFERENCES `BPC_BDS_Project`.`order` (`id_order`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `BPC_BDS_Project`.`transaction` (
  `id_translation` INT NOT NULL,
  `id_order` INT NOT NULL,
  `payment` VARCHAR(50) NOT NULL,
  `paid_at` DATETIME NOT NULL,
  PRIMARY KEY (`id_translation`, `id_order`),
  INDEX `fk_transaction_order1_idx` (`id_order` ASC),
  CONSTRAINT `fk_transaction_order1`
    FOREIGN KEY (`id_order`)
    REFERENCES `BPC_BDS_Project`.`order` (`id_order`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `BPC_BDS_Project`.`specification` (
  `id_product` INT NOT NULL,
  `name` VARCHAR(50) NOT NULL,
  `model` VARCHAR(50) NULL,
  `type` VARCHAR(50) NULL,
  `version` VARCHAR(50) NULL,
  PRIMARY KEY (`id_product`),
  UNIQUE INDEX `id_specification_UNIQUE` (`id_product` ASC))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `BPC_BDS_Project`.`product` (
  `id_product` INT NOT NULL,
  `in_stock` INT NOT NULL,
  PRIMARY KEY (`id_product`),
  UNIQUE INDEX `id_product_UNIQUE` (`id_product` ASC),
  CONSTRAINT `fk_product_specification1`
    FOREIGN KEY (`id_product`)
    REFERENCES `BPC_BDS_Project`.`specification` (`id_product`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `BPC_BDS_Project`.`ordered_has_product` (
  `id_order` INT NOT NULL,
  `id_product` INT NOT NULL,
  `quantity` INT NOT NULL,
  PRIMARY KEY (`id_order`, `id_product`),
  INDEX `fk_ordered_has_product_product1_idx` (`id_product` ASC),
  CONSTRAINT `fk_ordered_has_product_order1`
    FOREIGN KEY (`id_order`)
    REFERENCES `BPC_BDS_Project`.`order` (`id_order`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ordered_has_product_product1`
    FOREIGN KEY (`id_product`)
    REFERENCES `BPC_BDS_Project`.`product` (`id_product`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `BPC_BDS_Project`.`brand` (
  `id_brand` INT NOT NULL,
  `brand` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id_brand`),
  UNIQUE INDEX `brand_UNIQUE` (`brand` ASC) VISIBLE,
  UNIQUE INDEX `id_brand_UNIQUE` (`id_brand` ASC) VISIBLE)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `BPC_BDS_Project`.`brand_rs` (
  `id_product` INT NOT NULL,
  `id_brand` INT NOT NULL,
  PRIMARY KEY (`id_product`, `id_brand`),
  INDEX `fk_brand_rs_brand1_idx` (`id_brand` ASC) VISIBLE,
  UNIQUE INDEX `id_product_UNIQUE` (`id_product` ASC) VISIBLE,
  UNIQUE INDEX `id_brand_UNIQUE` (`id_brand` ASC) VISIBLE,
  CONSTRAINT `fk_brand_rs_product1`
    FOREIGN KEY (`id_product`)
    REFERENCES `BPC_BDS_Project`.`product` (`id_product`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_brand_rs_brand1`
    FOREIGN KEY (`id_brand`)
    REFERENCES `BPC_BDS_Project`.`brand` (`id_brand`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `BPC_BDS_Project`.`product_type` (
  `id_product_type` INT NOT NULL,
  `product_type` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id_product_type`, `product_type`),
  UNIQUE INDEX `id_product_type_UNIQUE` (`id_product_type` ASC) VISIBLE,
  UNIQUE INDEX `product_type_UNIQUE` (`product_type` ASC) VISIBLE)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `BPC_BDS_Project`.`product_type_rs` (
  `product_id_product` INT NOT NULL,
  `id_product_type` INT NOT NULL,
  PRIMARY KEY (`product_id_product`, `id_product_type`),
  INDEX `fk_product_type_rs_product_type1_idx` (`id_product_type` ASC) VISIBLE,
  UNIQUE INDEX `product_id_product_UNIQUE` (`product_id_product` ASC) VISIBLE,
  UNIQUE INDEX `id_product_type_UNIQUE` (`id_product_type` ASC) VISIBLE,
  CONSTRAINT `fk_product_type_rs_product1`
    FOREIGN KEY (`product_id_product`)
    REFERENCES `BPC_BDS_Project`.`product` (`id_product`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_product_type_rs_product_type1`
    FOREIGN KEY (`id_product_type`)
    REFERENCES `BPC_BDS_Project`.`product_type` (`id_product_type`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;