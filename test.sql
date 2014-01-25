
DROP DATABASE `test`;
CREATE DATABASE `test`;
USE `test`;
CREATE TABLE `partner` (
  `partner_id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(45) NOT NULL DEFAULT '',
  PRIMARY KEY (`partner_id`) )
ENGINE = InnoDB;

INSERT INTO `partner` ( `name` ) VALUES ('test1');
INSERT INTO `partner` ( `name` ) VALUES ('test2');
