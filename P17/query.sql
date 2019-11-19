DROP DATABASE IF EXISTS `KASUS_POSTING`;
CREATE DATABASE `KASUS_POSTING`;
USE `KASUS_POSTING`;

CREATE TABLE `post`(
    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    msg TEXT NOT NULL
);

DELIMITER |
CREATE FUNCTION `symbol_pattern_getter`(TEXTDATA TEXT, SYMBOL TEXT) 
RETURNS TEXT
-- DETERMINISTIC
    BEGIN
        -- Menyiapkan varibale hasil
        DECLARE RESULT TEXT;
        DECLARE LENGTH_TEXT INT;
        DECLARE TEXT_ON_SEARCHER TEXT;
        DECLARE INDEX_FOR_SEARCHING INT;
        DECLARE LAST_TEXT_IN_SEARCHING TEXT;

        -- set hasil tanpa string
        SET RESULT = "";

        -- Menyiapkan data maksimum teks
        SET LENGTH_TEXT = LENGTH(TEXTDATA);

        -- Membuat Index dari 0
        SET INDEX_FOR_SEARCHING = 0;

        -- MEMULAI PENCARIAN
        REPEAT
            SET INDEX_FOR_SEARCHING = INDEX_FOR_SEARCHING + 1;
            SET TEXT_ON_SEARCHER = SUBSTRING_INDEX(TEXTDATA, ' ', INDEX_FOR_SEARCHING);
            SET LAST_TEXT_IN_SEARCHING = SUBSTRING_INDEX(TEXT_ON_SEARCHER, ' ', -1); 

            IF LEFT(LAST_TEXT_IN_SEARCHING, 1) = SYMBOL THEN
                SET RESULT = CONCAT(RESULT, LAST_TEXT_IN_SEARCHING, ', ');
            END IF;

        UNTIL (LENGTH(TEXT_ON_SEARCHER) >= LENGTH_TEXT) END REPEAT;

        -- Mengembalikan hasil dari pencarian
        RETURN RESULT;
    END |   
DELIMITER ;

SELECT `symbol_pattern_getter`("Belajar @mysql di #mdp @campus", "@");