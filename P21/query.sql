DROP DATABASE IF EXISTS `KASUS_POSTING`;
CREATE DATABASE `KASUS_POSTING`;
USE `KASUS_POSTING`;

CREATE TABLE `post`(
    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    msg TEXT NOT NULL
);

INSERT INTO `post`(msg) 
	VALUES 
		("belajar @mysql di #mdp @mdpcampus #stimikmdp #palembang"),
        ("Kuliah di #stimikmdp #palembang"),
        ("Kuliah malem lagi @mdpcampus @palembang #palembang");

DELIMITER |
CREATE PROCEDURE `ptreding_topic`() 
    BEGIN
        -- Menyiapkan varibale hasil
        DECLARE RESULT TEXT;
        DECLARE LENGTH_TEXT INT;
        DECLARE TEXT_ON_SEARCHER TEXT;
        DECLARE INDEX_FOR_SEARCHING INT;
        DECLARE LAST_TEXT_IN_SEARCHING TEXT;
        DECLARE TEXTDATA TEXT;
        DECLARE SYMBOL TEXT;
        
        SET SYMBOL = "#";
        SET TEXTDATA = (SELECT GROUP_CONCAT(msg SEPARATOR " ") FROM post);

        -- set hasil tanpa string
        SET RESULT = "";

        -- Menyiapkan data maksimum teks
        SET LENGTH_TEXT = LENGTH(TEXTDATA);

        -- Membuat Index dari 0
        SET INDEX_FOR_SEARCHING = 0;
        
        -- Buat temporary table
        CREATE TEMPORARY TABLE `_TEMP_ptrading_topic`(
        	hashtag VARCHAR(255) PRIMARY KEY NOT NULL ,
          	jumlah INT NOT NULL
        );

        -- MEMULAI PENCARIAN
        REPEAT
            SET INDEX_FOR_SEARCHING = INDEX_FOR_SEARCHING + 1;
            SET TEXT_ON_SEARCHER = SUBSTRING_INDEX(TEXTDATA, ' ', INDEX_FOR_SEARCHING);
            SET LAST_TEXT_IN_SEARCHING = SUBSTRING_INDEX(TEXT_ON_SEARCHER, ' ', -1); 

            IF LEFT(LAST_TEXT_IN_SEARCHING, 1) = SYMBOL THEN
            	-- MASUKAN KE TEMPORARY TABLE
                INSERT 
                	INTO `_TEMP_ptrading_topic` (hashtag, jumlah) 
                    VALUES (LAST_TEXT_IN_SEARCHING, 1)
                 	ON DUPLICATE KEY UPDATE jumlah = jumlah + 1;
                    
                
                SET RESULT = CONCAT(RESULT, LAST_TEXT_IN_SEARCHING, ', ');
            END IF;

        UNTIL (LENGTH(TEXT_ON_SEARCHER) >= LENGTH_TEXT) END REPEAT;

        -- Mengembalikan hasil dari pencarian
        SELECT RESULT;
        SELECT * FROM _TEMP_ptrading_topic;
        
        -- Hapus temporary table
        DROP TEMPORARY TABLE `_TEMP_ptrading_topic`;
    END |   
DELIMITER ;

CALL `ptreding_topic`();
