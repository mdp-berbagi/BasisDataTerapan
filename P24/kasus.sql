DROP DATABASE IF EXISTS `P25`;
CREATE DATABASE `P25`;
USE `P25`;

CREATE TABLE `transaksi`(
    `id` INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `nominal` VARCHAR(128) NOT NULL,
    `create_at` TIMESTAMP NOT NULL
);

CREATE TABLE `log`(
    `id` INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `transaksi_id` INT UNSIGNED NOT NULL,
    `query` VARCHAR(128) NOT NULL,
    `create_at` TIMESTAMP NOT NULL
);

DELIMITER ;;
CREATE TRIGGER `logging`
    AFTER INSERT
    ON `transaksi`
    FOR EACH ROW
        BEGIN
            INSERT log(transaksi_id, query)
            VALUES (NEW.id, CONCAT("INSERT INTO `transaksi`(`nominal`) VALUES ('",NEW.nominal,"')"));
        END
;;
DELIMITER ;

INSERT INTO transaksi(`nominal`) VALUES (12000), (13000);

DELIMITER ;;
CREATE EVENT `reccuringEvent`
    ON SCHEDULE
    EVERY 1 SECOND
    DO
        DELETE FROM `log` WHERE `create_at` = `create_at` +  INTERVAL 1 MINUTE;
;;
DELIMITER ;