-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Project
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `Project` ;

-- -----------------------------------------------------
-- Schema Project
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Project` DEFAULT CHARACTER SET utf8 ;
USE `Project` ;

-- -----------------------------------------------------
-- Table `Project`.`CUSTOMERS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Project`.`CUSTOMERS` ;

CREATE TABLE IF NOT EXISTS `Project`.`CUSTOMERS` (
  `customer_id` INT NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NULL,
  `phone_number` BIGINT(11) NOT NULL,
  PRIMARY KEY (`customer_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Project`.`CUSTOMER_ADDRESS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Project`.`CUSTOMER_ADDRESS` ;

CREATE TABLE IF NOT EXISTS `Project`.`CUSTOMER_ADDRESS` (
  `street_address_1` VARCHAR(45) NOT NULL,
  `street_address_2` VARCHAR(45) NULL,
  `city` VARCHAR(45) NOT NULL,
  `state` VARCHAR(45) NOT NULL,
  `country` VARCHAR(45) NOT NULL,
  `Zip code` INT NOT NULL,
  `CUSTOMERS_customer_id` INT NOT NULL,
  INDEX `fk_CUSTOMER_ADDRESS_CUSTOMERS1_idx` (`CUSTOMERS_customer_id` ASC) VISIBLE,
  CONSTRAINT `fk_CUSTOMER_ADDRESS_CUSTOMERS1`
    FOREIGN KEY (`CUSTOMERS_customer_id`)
    REFERENCES `Project`.`CUSTOMERS` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Project`.`PRIME_CUSTOMER`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Project`.`PRIME_CUSTOMER` ;

CREATE TABLE IF NOT EXISTS `Project`.`PRIME_CUSTOMER` (
  `prime_subscription_date` DATETIME NOT NULL,
  `CUSTOMERS_customer_id` INT NOT NULL,
  PRIMARY KEY (`CUSTOMERS_customer_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Project`.`CATEGORY`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Project`.`CATEGORY` ;

CREATE TABLE IF NOT EXISTS `Project`.`CATEGORY` (
  `category_id` INT NOT NULL,
  `category_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`category_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Project`.`PRODUCTS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Project`.`PRODUCTS` ;

CREATE TABLE IF NOT EXISTS `Project`.`PRODUCTS` (
  `product_id` INT NOT NULL AUTO_INCREMENT,
  `product_name` VARCHAR(45) NULL,
  `product_price` INT NULL,
  `quantity` INT NULL,
  `CATEGORY_category_id` INT NOT NULL,
  PRIMARY KEY (`product_id`),
  INDEX `fk_PRODUCTS_CATEGORY1_idx` (`CATEGORY_category_id` ASC) VISIBLE,
  CONSTRAINT `fk_PRODUCTS_CATEGORY1`
    FOREIGN KEY (`CATEGORY_category_id`)
    REFERENCES `Project`.`CATEGORY` (`category_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Project`.`product_color_available`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Project`.`product_color_available` ;

CREATE TABLE IF NOT EXISTS `Project`.`product_color_available` (
  `color` VARCHAR(20) NULL,
  `PRODUCTS_product_id` INT NOT NULL,
  INDEX `fk_product_color_available_PRODUCTS1_idx` (`PRODUCTS_product_id` ASC) VISIBLE,
  CONSTRAINT `fk_product_color_available_PRODUCTS1`
    FOREIGN KEY (`PRODUCTS_product_id`)
    REFERENCES `Project`.`PRODUCTS` (`product_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Project`.`product_size_available`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Project`.`product_size_available` ;

CREATE TABLE IF NOT EXISTS `Project`.`product_size_available` (
  `size` INT NOT NULL,
  `PRODUCTS_product_id` INT NOT NULL,
  PRIMARY KEY (`size`),
  INDEX `fk_product_size_available_PRODUCTS1_idx` (`PRODUCTS_product_id` ASC) VISIBLE,
  CONSTRAINT `fk_product_size_available_PRODUCTS1`
    FOREIGN KEY (`PRODUCTS_product_id`)
    REFERENCES `Project`.`PRODUCTS` (`product_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Project`.`SUPPLIER`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Project`.`SUPPLIER` ;

CREATE TABLE IF NOT EXISTS `Project`.`SUPPLIER` (
  `supplier_id` INT NOT NULL,
  `supplier_name` VARCHAR(45) NULL,
  PRIMARY KEY (`supplier_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Project`.`SUPPLIER_ADDRESS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Project`.`SUPPLIER_ADDRESS` ;

CREATE TABLE IF NOT EXISTS `Project`.`SUPPLIER_ADDRESS` (
  `street_address_1` VARCHAR(45) NOT NULL,
  `street_address_2` VARCHAR(45) NULL,
  `city` VARCHAR(45) NULL,
  `state` VARCHAR(45) NULL,
  `country` VARCHAR(45) NULL,
  `zip_code` VARCHAR(45) NOT NULL,
  `SUPPLIER_supplier_id` INT NOT NULL,
  INDEX `fk_SUPPLIER_ADDRESS_SUPPLIER1_idx` (`SUPPLIER_supplier_id` ASC) VISIBLE,
  CONSTRAINT `fk_SUPPLIER_ADDRESS_SUPPLIER1`
    FOREIGN KEY (`SUPPLIER_supplier_id`)
    REFERENCES `Project`.`SUPPLIER` (`supplier_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Project`.`SUPPLIER_CONTACT_INFORMATION`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Project`.`SUPPLIER_CONTACT_INFORMATION` ;

CREATE TABLE IF NOT EXISTS `Project`.`SUPPLIER_CONTACT_INFORMATION` (
  `phone_number` INT NOT NULL,
  `SUPPLIER_supplier_id` INT NOT NULL,
  PRIMARY KEY (`phone_number`),
  INDEX `fk_SUPPLIER_CONTACT_INFORMATION_SUPPLIER1_idx` (`SUPPLIER_supplier_id` ASC) VISIBLE,
  CONSTRAINT `fk_SUPPLIER_CONTACT_INFORMATION_SUPPLIER1`
    FOREIGN KEY (`SUPPLIER_supplier_id`)
    REFERENCES `Project`.`SUPPLIER` (`supplier_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Project`.`PRODUCTS_has_SUPPLIER`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Project`.`PRODUCTS_has_SUPPLIER` ;

CREATE TABLE IF NOT EXISTS `Project`.`PRODUCTS_has_SUPPLIER` (
  `PRODUCTS_product_id` INT NOT NULL,
  `SUPPLIER_supplier_id` INT NOT NULL,
  PRIMARY KEY (`PRODUCTS_product_id`, `SUPPLIER_supplier_id`),
  INDEX `fk_PRODUCTS_has_SUPPLIER_SUPPLIER1_idx` (`SUPPLIER_supplier_id` ASC) VISIBLE,
  INDEX `fk_PRODUCTS_has_SUPPLIER_PRODUCTS1_idx` (`PRODUCTS_product_id` ASC) VISIBLE,
  CONSTRAINT `fk_PRODUCTS_has_SUPPLIER_PRODUCTS1`
    FOREIGN KEY (`PRODUCTS_product_id`)
    REFERENCES `Project`.`PRODUCTS` (`product_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PRODUCTS_has_SUPPLIER_SUPPLIER1`
    FOREIGN KEY (`SUPPLIER_supplier_id`)
    REFERENCES `Project`.`SUPPLIER` (`supplier_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Project`.`ORDER`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Project`.`ORDER` ;

CREATE TABLE IF NOT EXISTS `Project`.`ORDER` (
  `order_id` INT NOT NULL AUTO_INCREMENT,
  `CUSTOMERS_customer_id` INT NOT NULL,
  PRIMARY KEY (`order_id`),
  INDEX `fk_ORDER_CUSTOMERS1_idx` (`CUSTOMERS_customer_id` ASC) VISIBLE,
  CONSTRAINT `fk_ORDER_CUSTOMERS1`
    FOREIGN KEY (`CUSTOMERS_customer_id`)
    REFERENCES `Project`.`CUSTOMERS` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Project`.`ORDER_ITEMS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Project`.`ORDER_ITEMS` ;

CREATE TABLE IF NOT EXISTS `Project`.`ORDER_ITEMS` (
  `quantity` INT NOT NULL,
  `ORDER_oder_id` INT NOT NULL,
  `PRODUCTS_product_id` INT NOT NULL,
  INDEX `fk_ORDER_ITEMS_ORDER1_idx` (`ORDER_oder_id` ASC) VISIBLE,
  CONSTRAINT `fk_ORDER_ITEMS_ORDER1`
    FOREIGN KEY (`ORDER_oder_id`)
    REFERENCES `Project`.`ORDER` (`order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ORDER_ITEMS_PRODUCTS1`
    FOREIGN KEY (`PRODUCTS_product_id`)
    REFERENCES `Project`.`PRODUCTS` (`product_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Project`.`SHIPMENT`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Project`.`SHIPMENT` ;

CREATE TABLE IF NOT EXISTS `Project`.`SHIPMENT` (
  `shipmen_id` INT NOT NULL AUTO_INCREMENT,
  `ORDER_oder_id` INT NOT NULL,
  PRIMARY KEY (`shipmen_id`, `ORDER_oder_id`),
  INDEX `fk_SHIPMENT_ORDER1_idx` (`ORDER_oder_id` ASC) VISIBLE,
  CONSTRAINT `fk_SHIPMENT_ORDER1`
    FOREIGN KEY (`ORDER_oder_id`)
    REFERENCES `Project`.`ORDER` (`order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Project`.`PAYMENT`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Project`.`PAYMENT` ;

CREATE TABLE IF NOT EXISTS `Project`.`PAYMENT` (
  `ORDER_oder_id` INT NOT NULL,
  `payment_id` INT NOT NULL AUTO_INCREMENT,
  `payment_mode` VARCHAR(45) NOT NULL DEFAULT 'Cash',
  PRIMARY KEY (`payment_id`),
  CONSTRAINT `fk_PAYMENT_ORDER1`
    FOREIGN KEY (`ORDER_oder_id`)
    REFERENCES `Project`.`ORDER` (`order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Project`.`Product_review`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Project`.`Product_review` ;

CREATE TABLE IF NOT EXISTS `Project`.`Product_review` (
  `review_id` INT NOT NULL,
  `review` VARCHAR(45) NULL,
  `PRODUCTS_product_id` INT NOT NULL,
  PRIMARY KEY (`review_id`),
  INDEX `fk_Product_review_PRODUCTS1_idx` (`PRODUCTS_product_id` ASC) VISIBLE,
  CONSTRAINT `fk_Product_review_PRODUCTS1`
    FOREIGN KEY (`PRODUCTS_product_id`)
    REFERENCES `Project`.`PRODUCTS` (`product_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Project`.`Shippers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Project`.`Shippers` ;

CREATE TABLE IF NOT EXISTS `Project`.`Shippers` (
  `shipper_id` INT NOT NULL,
  `Status` VARCHAR(45) NULL,
  `SHIPMENT_shipmen_id` INT NOT NULL,
  `SHIPMENT_ORDER_oder_id` INT NOT NULL,
  INDEX `fk_Shippers_SHIPMENT1_idx` (`SHIPMENT_shipmen_id` ASC, `SHIPMENT_ORDER_oder_id` ASC) VISIBLE,
  CONSTRAINT `fk_Shippers_SHIPMENT1`
    FOREIGN KEY (`SHIPMENT_shipmen_id` , `SHIPMENT_ORDER_oder_id`)
    REFERENCES `Project`.`SHIPMENT` (`shipmen_id` , `ORDER_oder_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `Project`.`CUSTOMERS`
-- -----------------------------------------------------
START TRANSACTION;
USE `Project`;
INSERT INTO `Project`.`CUSTOMERS` (`customer_id`, `first_name`, `last_name`, `phone_number`) VALUES (1, 'Mrunal', 'Ghorpade', 8573086053);
INSERT INTO `Project`.`CUSTOMERS` (`customer_id`, `first_name`, `last_name`, `phone_number`) VALUES (2, 'Sameera', 'shah', 1234567890);
INSERT INTO `Project`.`CUSTOMERS` (`customer_id`, `first_name`, `last_name`, `phone_number`) VALUES (3, 'Vaibhav', 'Bhosale', 9665579397);
INSERT INTO `Project`.`CUSTOMERS` (`customer_id`, `first_name`, `last_name`, `phone_number`) VALUES (4, 'Ketan', 'Patil', 8573054784);
INSERT INTO `Project`.`CUSTOMERS` (`customer_id`, `first_name`, `last_name`, `phone_number`) VALUES (5, 'Manali', 'dey', 9863465700);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Project`.`CUSTOMER_ADDRESS`
-- -----------------------------------------------------
START TRANSACTION;
USE `Project`;
INSERT INTO `Project`.`CUSTOMER_ADDRESS` (`street_address_1`, `street_address_2`, `city`, `state`, `country`, `Zip code`, `CUSTOMERS_customer_id`) VALUES ('61Smith Street', 'Roxburry Crossing ', 'Boston', 'MA', 'USA', 02120, 1);
INSERT INTO `Project`.`CUSTOMER_ADDRESS` (`street_address_1`, `street_address_2`, `city`, `state`, `country`, `Zip code`, `CUSTOMERS_customer_id`) VALUES ('B702 Sahado heights', 'Someshwarwadi', 'Pune', 'Maharashtra', 'India', 411008, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Project`.`PRIME_CUSTOMER`
-- -----------------------------------------------------
START TRANSACTION;
USE `Project`;
INSERT INTO `Project`.`PRIME_CUSTOMER` (`prime_subscription_date`, `CUSTOMERS_customer_id`) VALUES ('11/20/2018', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Project`.`CATEGORY`
-- -----------------------------------------------------
START TRANSACTION;
USE `Project`;
INSERT INTO `Project`.`CATEGORY` (`category_id`, `category_name`) VALUES (1, 'Kurta');
INSERT INTO `Project`.`CATEGORY` (`category_id`, `category_name`) VALUES (2, 'Dresses');
INSERT INTO `Project`.`CATEGORY` (`category_id`, `category_name`) VALUES (3, 'Sarees');
INSERT INTO `Project`.`CATEGORY` (`category_id`, `category_name`) VALUES (4, 'Jackets');
INSERT INTO `Project`.`CATEGORY` (`category_id`, `category_name`) VALUES (5, 'Jumpsuits');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Project`.`PRODUCTS`
-- -----------------------------------------------------
START TRANSACTION;
USE `Project`;
INSERT INTO `Project`.`PRODUCTS` (`product_id`, `product_name`, `product_price`, `quantity`, `CATEGORY_category_id`) VALUES (1, 'cotton kurta', 100, 50, 1);
INSERT INTO `Project`.`PRODUCTS` (`product_id`, `product_name`, `product_price`, `quantity`, `CATEGORY_category_id`) VALUES (2, 'bandhani Kurta', 75, 90, 1);
INSERT INTO `Project`.`PRODUCTS` (`product_id`, `product_name`, `product_price`, `quantity`, `CATEGORY_category_id`) VALUES (3, 'ray ban dress ', 46, 25, 2);
INSERT INTO `Project`.`PRODUCTS` (`product_id`, `product_name`, `product_price`, `quantity`, `CATEGORY_category_id`) VALUES (4, 'malhotra dress', 200, 10, 2);
INSERT INTO `Project`.`PRODUCTS` (`product_id`, `product_name`, `product_price`, `quantity`, `CATEGORY_category_id`) VALUES (5, 'silk saree', 250, 90, 3);
INSERT INTO `Project`.`PRODUCTS` (`product_id`, `product_name`, `product_price`, `quantity`, `CATEGORY_category_id`) VALUES (6, 'cotton saree', 150, 100, 3);
INSERT INTO `Project`.`PRODUCTS` (`product_id`, `product_name`, `product_price`, `quantity`, `CATEGORY_category_id`) VALUES (7, 'cotton jacket', 71, 5, 4);
INSERT INTO `Project`.`PRODUCTS` (`product_id`, `product_name`, `product_price`, `quantity`, `CATEGORY_category_id`) VALUES (8, 'polka dots jumpsuit', 39, 10, 5);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Project`.`product_color_available`
-- -----------------------------------------------------
START TRANSACTION;
USE `Project`;
INSERT INTO `Project`.`product_color_available` (`color`, `PRODUCTS_product_id`) VALUES ('Red', 1);
INSERT INTO `Project`.`product_color_available` (`color`, `PRODUCTS_product_id`) VALUES ('blue', 1);
INSERT INTO `Project`.`product_color_available` (`color`, `PRODUCTS_product_id`) VALUES ('black', 2);
INSERT INTO `Project`.`product_color_available` (`color`, `PRODUCTS_product_id`) VALUES ('green', 2);
INSERT INTO `Project`.`product_color_available` (`color`, `PRODUCTS_product_id`) VALUES ('gray', 2);
INSERT INTO `Project`.`product_color_available` (`color`, `PRODUCTS_product_id`) VALUES ('orange', 3);
INSERT INTO `Project`.`product_color_available` (`color`, `PRODUCTS_product_id`) VALUES ('white', 3);
INSERT INTO `Project`.`product_color_available` (`color`, `PRODUCTS_product_id`) VALUES ('blue', 4);
INSERT INTO `Project`.`product_color_available` (`color`, `PRODUCTS_product_id`) VALUES ('black', 4);
INSERT INTO `Project`.`product_color_available` (`color`, `PRODUCTS_product_id`) VALUES ('green', 5);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Project`.`product_size_available`
-- -----------------------------------------------------
START TRANSACTION;
USE `Project`;
INSERT INTO `Project`.`product_size_available` (`size`, `PRODUCTS_product_id`) VALUES ('L', 5);
INSERT INTO `Project`.`product_size_available` (`size`, `PRODUCTS_product_id`) VALUES ('M', 5);
INSERT INTO `Project`.`product_size_available` (`size`, `PRODUCTS_product_id`) VALUES ('XS', 5);
INSERT INTO `Project`.`product_size_available` (`size`, `PRODUCTS_product_id`) VALUES ('XS', 4);
INSERT INTO `Project`.`product_size_available` (`size`, `PRODUCTS_product_id`) VALUES ('XL', 4);
INSERT INTO `Project`.`product_size_available` (`size`, `PRODUCTS_product_id`) VALUES ('M', 4);
INSERT INTO `Project`.`product_size_available` (`size`, `PRODUCTS_product_id`) VALUES ('S', 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Project`.`SUPPLIER`
-- -----------------------------------------------------
START TRANSACTION;
USE `Project`;
INSERT INTO `Project`.`SUPPLIER` (`supplier_id`, `supplier_name`) VALUES (1, 'Emma');
INSERT INTO `Project`.`SUPPLIER` (`supplier_id`, `supplier_name`) VALUES (2, 'Olivia');
INSERT INTO `Project`.`SUPPLIER` (`supplier_id`, `supplier_name`) VALUES (3, 'James');
INSERT INTO `Project`.`SUPPLIER` (`supplier_id`, `supplier_name`) VALUES (4, 'Mia');
INSERT INTO `Project`.`SUPPLIER` (`supplier_id`, `supplier_name`) VALUES (5, 'Amelia');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Project`.`PRODUCTS_has_SUPPLIER`
-- -----------------------------------------------------
START TRANSACTION;
USE `Project`;
INSERT INTO `Project`.`PRODUCTS_has_SUPPLIER` (`PRODUCTS_product_id`, `SUPPLIER_supplier_id`) VALUES (1, 1);
INSERT INTO `Project`.`PRODUCTS_has_SUPPLIER` (`PRODUCTS_product_id`, `SUPPLIER_supplier_id`) VALUES (2, 1);
INSERT INTO `Project`.`PRODUCTS_has_SUPPLIER` (`PRODUCTS_product_id`, `SUPPLIER_supplier_id`) VALUES (3, 2);
INSERT INTO `Project`.`PRODUCTS_has_SUPPLIER` (`PRODUCTS_product_id`, `SUPPLIER_supplier_id`) VALUES (4, 5);
INSERT INTO `Project`.`PRODUCTS_has_SUPPLIER` (`PRODUCTS_product_id`, `SUPPLIER_supplier_id`) VALUES (2, 2);
INSERT INTO `Project`.`PRODUCTS_has_SUPPLIER` (`PRODUCTS_product_id`, `SUPPLIER_supplier_id`) VALUES (5, 4);
INSERT INTO `Project`.`PRODUCTS_has_SUPPLIER` (`PRODUCTS_product_id`, `SUPPLIER_supplier_id`) VALUES (3, 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Project`.`ORDER`
-- -----------------------------------------------------
START TRANSACTION;
USE `Project`;
INSERT INTO `Project`.`ORDER` (`order_id`, `CUSTOMERS_customer_id`) VALUES (1, 1);
INSERT INTO `Project`.`ORDER` (`order_id`, `CUSTOMERS_customer_id`) VALUES (2, 3);
INSERT INTO `Project`.`ORDER` (`order_id`, `CUSTOMERS_customer_id`) VALUES (3, 4);
INSERT INTO `Project`.`ORDER` (`order_id`, `CUSTOMERS_customer_id`) VALUES (4, 2);
INSERT INTO `Project`.`ORDER` (`order_id`, `CUSTOMERS_customer_id`) VALUES (5, 5);
INSERT INTO `Project`.`ORDER` (`order_id`, `CUSTOMERS_customer_id`) VALUES (6, 5);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Project`.`ORDER_ITEMS`
-- -----------------------------------------------------
START TRANSACTION;
USE `Project`;
INSERT INTO `Project`.`ORDER_ITEMS` (`quantity`, `ORDER_oder_id`, `PRODUCTS_product_id`) VALUES (2, 1, 1);
INSERT INTO `Project`.`ORDER_ITEMS` (`quantity`, `ORDER_oder_id`, `PRODUCTS_product_id`) VALUES (3, 1, 4);
INSERT INTO `Project`.`ORDER_ITEMS` (`quantity`, `ORDER_oder_id`, `PRODUCTS_product_id`) VALUES (1, 2, 1);
INSERT INTO `Project`.`ORDER_ITEMS` (`quantity`, `ORDER_oder_id`, `PRODUCTS_product_id`) VALUES (2, 3, 5);
INSERT INTO `Project`.`ORDER_ITEMS` (`quantity`, `ORDER_oder_id`, `PRODUCTS_product_id`) VALUES (1, 4, 2);
INSERT INTO `Project`.`ORDER_ITEMS` (`quantity`, `ORDER_oder_id`, `PRODUCTS_product_id`) VALUES (3, 4, 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Project`.`SHIPMENT`
-- -----------------------------------------------------
START TRANSACTION;
USE `Project`;


COMMIT;


-- -----------------------------------------------------
-- Data for table `Project`.`PAYMENT`
-- -----------------------------------------------------
START TRANSACTION;
USE `Project`;
INSERT INTO `Project`.`PAYMENT` (`ORDER_oder_id`, `payment_id`, `payment_mode`) VALUES (1, 1, 'Check');
INSERT INTO `Project`.`PAYMENT` (`ORDER_oder_id`, `payment_id`, `payment_mode`) VALUES (2, 2, 'cash');
INSERT INTO `Project`.`PAYMENT` (`ORDER_oder_id`, `payment_id`, `payment_mode`) VALUES (3, 3, 'cash');

COMMIT;

