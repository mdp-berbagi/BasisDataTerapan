DROP DATABASE IF EXISTS `intro_trigger`;
CREATE DATABASE `intro_trigger`;
USE `intro_trigger`;

CREATE TABLE `user` (
    `id` INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(30) NOT NULL,
    `birthdate` DATE
);

CREATE TABLE `notif` (
    `id` INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `user_id` INT UNSIGNED NOT NULL,
    `msg` VARCHAR(255) NOT NULL
);


DELIMITER ;;
CREATE TRIGGER `user_validation`
    AFTER INSERT
    ON `user`
    FOR EACH ROW
        BEGIN
            IF NEW.birthdate IS NULL OR NEW.birthdate = "0000-00-00"  THEN
                INSERT 
                    INTO `notif`(user_id, msg) 
                    VALUES (
                        NEW.id, 
                        "Tanggal lahir kosong, isi tanggal lahir agar fitur OYO premum mu aktif!"
                    );
            END IF;
        END
;;
DELIMITER ;

INSERT 
    INTO `user`(`name`, `birthdate`) 
    VALUES 
        ("Budi", "1996-11-12"),
        ("Anas", NULL),
        ("Nyimas", "");

SELECT * FROM `user`;
SELECT * FROM `notif`;

DROP DATABASE IF EXISTS `intro_trigger`;