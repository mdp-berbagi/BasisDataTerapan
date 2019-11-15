DROP DATABASE IF EXISTS `KASUS_POSTING`;
CREATE DATABASE `KASUS_POSTING`;
USE `KASUS_POSTING`;

CREATE TABLE `post`(
    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    msg TEXT NOT NULL
);

DELIMITER |
CREATE FUNCTION `symbol_pattern_getter`(msg TEXT, symbol TEXT) 
RETURNS TEXT
-- DETERMINISTIC
    BEGIN
        DECLARE idx INT;
        DECLARE hasil TEXT;
        DECLARE KATA TEXT;

        SET idx = 0;
        SET hasil = "";

        REPEAT
            SET idx = idx + 1;
            SET KATA = SUBSTRING_INDEX(msg, ' ', idx);

        UNTIL KATA IS NULL END REPEAT;

        RETURN hasil;
    END |   
DELIMITER ;

SELECT `symbol_pattern_getter`("Belajar @mysql di #mdp @campus", "@");