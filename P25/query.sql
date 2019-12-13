DROP DATABASE IF EXISTS `P25`;
CREATE DATABASE `P25`;
USE `P25`;

-- Cek event_schedule sudah aktif atau belum
SHOW VARIABLES WHERE variable_name = 'event_scheduler';

-- Aktifasi Event
SET GLOBAL event_scheduler = ON;

-- Check hasil perubahan
SHOW VARIABLES WHERE `variable_name` = 'event_scheduler';

-- Buat table contoh
CREATE TABLE `msg`(
    `id` INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `texting` VARCHAR(128) NOT NULL,
    `create_at` TIMESTAMP NOT NULL
);

-- Buat Event
DELIMITER ;;
CREATE EVENT `makeOneTimeMsg` 
    ON SCHEDULE 
    AT CURRENT_TIMESTAMP + INTERVAL 1 MINUTE
    DO
        INSERT INTO `msg`(texting) VALUES ('yes');
;;
DELIMITER ;

-- Buat Event
-- Drop EVENT reccuringEvent sesudah yakin kalau EVENT berhasil
DELIMITER ;;
CREATE EVENT `reccuringEvent`
    ON SCHEDULE
    EVERY 30 SECOND
    STARTS CURRENT_TIMESTAMP + INTERVAL 1 MINUTE -- Opsional
    ENDS CURRENT_TIMESTAMP + INTERVAL 10 MINUTE -- Opsional
    DO
        INSERT INTO `msg`(texting) VALUES ('yes');
;;
DELIMITER ;

-- cek hasil di SELECT * FROM msg;

-- make event stop (not be delete)
ALTER EVENT makeOneTimeMsg DISABLE;

-- make event can run instuction (not be delete)
ALTER EVENT makeOneTimeMsg ENABLE;

-- Show event
SHOW EVENTS;
