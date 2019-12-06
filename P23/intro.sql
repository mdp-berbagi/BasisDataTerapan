DROP DATABASE IF EXISTS `intro_trigger`;
CREATE DATABASE `intro_trigger`;
USE `intro_trigger`;

CREATE TABLE `account`(
    id INT(10) UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    amount DECIMAl(10,0) NOT NULL
);

DELIMITER ;;
CREATE TRIGGER example_before_insert
    BEFORE INSERT 
    ON account 
    FOR EACH ROW
        BEGIN
            SET NEW.amount = NEW.amount * 1000;
        END
;;
DELIMITER ;

INSERT INTO `account`(amount) VALUES (10), (30);

SELECT * FROM account;




DELIMITER ;;
CREATE TRIGGER example_before_update
    BEFORE UPDATE
    ON account
    FOR EACH ROW
        BEGIN
            SET NEW.amount = (NEW.amount * 1000) + OLD.amount;
        END
;;
DELIMITER ;

UPDATE account SET amount = 10 WHERE id = 1;

SELECT * FROM account;






DROP DATABASE IF EXISTS `intro_trigger`;