-- -----------------------------------------------------
-- Schema BPC_BDS_Project
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `BPC_BDS_Project`;
USE `BPC_BDS_Project`;

-- -----------------------------------------------------
-- Table `BPC_BDS_Project`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BPC_BDS_Project`.`users` (
  `id_user` INT NOT NULL,
  `first_name` VARCHAR(50) NOT NULL,
  `last_name` VARCHAR(50) NOT NULL,
  `registration` TIMESTAMP NOT NULL,
  `last_login` TIMESTAMP NOT NULL,
  `email` VARCHAR(50) NOT NULL,
  `phone_number` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id_user`),
  UNIQUE INDEX `id_user_UNIQUE` (`id_user` ASC) VISIBLE);


-- -----------------------------------------------------
-- Table `BPC_BDS_Project`.`address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BPC_BDS_Project`.`address` (
  `id_address` INT NOT NULL,
  `street` VARCHAR(50) NOT NULL,
  `house_number` INT NOT NULL,
  `postcode` VARCHAR(45) NOT NULL,
  `city` VARCHAR(50) NOT NULL,
  `country` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id_address`),
  UNIQUE INDEX `id_address_UNIQUE` (`id_address` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BPC_BDS_Project`.`user_has_address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BPC_BDS_Project`.`user_has_address` (
  `id_user` INT NOT NULL,
  `id_address` INT NOT NULL,
  PRIMARY KEY (`id_user`, `id_address`),
  INDEX `fk_user_has_address_idx` (`id_user` ASC) INVISIBLE,
  INDEX `fk_user_has_address2_idx` (`id_address` ASC) VISIBLE,
  UNIQUE INDEX `id_user_UNIQUE` (`id_user` ASC) VISIBLE,
  UNIQUE INDEX `id_address_UNIQUE` (`id_address` ASC) VISIBLE,
  CONSTRAINT `fk_user_has_address_user`
    FOREIGN KEY (`id_user`)
    REFERENCES `BPC_BDS_Project`.`users` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_address_address`
    FOREIGN KEY (`id_address`)
    REFERENCES `BPC_BDS_Project`.`address` (`id_address`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BPC_BDS_Project`.`product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BPC_BDS_Project`.`product` (
  `id_product` INT NOT NULL,
  `name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id_product`),
  UNIQUE INDEX `id_product_UNIQUE` (`id_product` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BPC_BDS_Project`.`brand`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BPC_BDS_Project`.`brand` (
  `id_brand` INT NOT NULL,
  `brand` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id_brand`),
  UNIQUE INDEX `brand_UNIQUE` (`brand` ASC) VISIBLE,
  UNIQUE INDEX `id_brand_UNIQUE` (`id_brand` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BPC_BDS_Project`.`product_has_brand`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BPC_BDS_Project`.`product_has_brand` (
  `id_product` INT NOT NULL,
  `id_brand` INT NOT NULL,
  PRIMARY KEY (`id_product`, `id_brand`),
  INDEX `fk_product_has_brand1_idx` (`id_brand` ASC) INVISIBLE,
  UNIQUE INDEX `id_product_UNIQUE` (`id_product` ASC) VISIBLE,
  UNIQUE INDEX `id_brand_UNIQUE` (`id_brand` ASC) VISIBLE,
  INDEX `fk_product_has_brand2_idx` (`id_product` ASC) VISIBLE,
  CONSTRAINT `fk_product_has_brand_product`
    FOREIGN KEY (`id_product`)
    REFERENCES `BPC_BDS_Project`.`product` (`id_product`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_product_has_brand_brand`
    FOREIGN KEY (`id_brand`)
    REFERENCES `BPC_BDS_Project`.`brand` (`id_brand`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BPC_BDS_Project`.`order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BPC_BDS_Project`.`order` (
  `id_order` INT NOT NULL,
  `subtotal` FLOAT NOT NULL,
  `discount` FLOAT NOT NULL,
  `shipping` FLOAT NOT NULL,
  `total` FLOAT NOT NULL,
  PRIMARY KEY (`id_order`),
  UNIQUE INDEX `id_order_UNIQUE` (`id_order` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BPC_BDS_Project`.`user_has_order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BPC_BDS_Project`.`user_has_order` (
  `id_user` INT NOT NULL,
  `id_order` INT NOT NULL,
  `status` VARCHAR(50) NOT NULL,
  INDEX `fk_user_has_order1_idx` (`id_order` ASC) INVISIBLE,
  UNIQUE INDEX `id_user_UNIQUE` (`id_user` ASC) VISIBLE,
  UNIQUE INDEX `id_order_UNIQUE` (`id_order` ASC) VISIBLE,
  PRIMARY KEY (`id_user`, `id_order`),
  INDEX `fk_user_has_order2_idx` (`id_user` ASC) VISIBLE,
  CONSTRAINT `fk_user_has_order_user`
    FOREIGN KEY (`id_user`)
    REFERENCES `BPC_BDS_Project`.`users` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_order_order`
    FOREIGN KEY (`id_order`)
    REFERENCES `BPC_BDS_Project`.`order` (`id_order`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BPC_BDS_Project`.`transaction`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BPC_BDS_Project`.`transaction` (
  `id_translation` INT NOT NULL,
  `id_order` INT NOT NULL,
  `payment` VARCHAR(50) NOT NULL,
  `paid_at` DATETIME NOT NULL,
  PRIMARY KEY (`id_translation`, `id_order`),
  INDEX `fk_transaction_order1_idx` (`id_order` ASC) VISIBLE,
  UNIQUE INDEX `id_translation_UNIQUE` (`id_translation` ASC) VISIBLE,
  UNIQUE INDEX `id_order_UNIQUE` (`id_order` ASC) VISIBLE,
  CONSTRAINT `fk_transaction_order1`
    FOREIGN KEY (`id_order`)
    REFERENCES `BPC_BDS_Project`.`order` (`id_order`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BPC_BDS_Project`.`ordered_has_product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BPC_BDS_Project`.`ordered_has_product` (
  `id_order` INT NOT NULL,
  `id_product` INT NOT NULL,
  `quantity` INT NOT NULL,
  PRIMARY KEY (`id_order`, `id_product`),
  INDEX `fk_ordered_has_product1_idx` (`id_product` ASC) INVISIBLE,
  UNIQUE INDEX `id_order_UNIQUE` (`id_order` ASC) VISIBLE,
  UNIQUE INDEX `id_product_UNIQUE` (`id_product` ASC) VISIBLE,
  INDEX `fk_ordered_has_product2_idx` (`id_order` ASC) VISIBLE,
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


-- -----------------------------------------------------
-- Table `BPC_BDS_Project`.`specification`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BPC_BDS_Project`.`specification` (
  `id_specification` INT NOT NULL,
  `product_type` VARCHAR(45) NOT NULL,
  `model` VARCHAR(45) NULL,
  `version` VARCHAR(45) NULL,
  `in_stock` INT NOT NULL,
  PRIMARY KEY (`id_specification`),
  UNIQUE INDEX `id_specification_UNIQUE` (`id_specification` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BPC_BDS_Project`.`product_has_specification`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BPC_BDS_Project`.`product_has_specification` (
  `id_product` INT NOT NULL,
  `id_specification` INT NOT NULL,
  PRIMARY KEY (`id_product`, `id_specification`),
  UNIQUE INDEX `id_product_UNIQUE` (`id_product` ASC) VISIBLE,
  UNIQUE INDEX `id_specification_UNIQUE` (`id_specification` ASC) VISIBLE,
  INDEX `fk_product_has_specification1_idx` (`id_product` ASC) VISIBLE,
  INDEX `fk_product_has_specification2_idx` (`id_specification` ASC) VISIBLE,
  CONSTRAINT `fk_product_has_specification_product1`
    FOREIGN KEY (`id_product`)
    REFERENCES `BPC_BDS_Project`.`product` (`id_product`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_product_has_specification_specification1`
    FOREIGN KEY (`id_specification`)
    REFERENCES `BPC_BDS_Project`.`specification` (`id_specification`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;