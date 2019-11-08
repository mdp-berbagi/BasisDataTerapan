DROP DATABASE IF EXISTS `Function_Test`;
CREATE DATABASE `Function_Test`;
USE `Function_Test`;


-- CONTOH FUNGSI LENGKAP
DELIMITER |
    CREATE FUNCTION example(x INT(30)) RETURNS INT(10)
    BEGIN
        DECLARE a INT;
        DECLARE b INT;

        SET a = x + 2;
        SET b = a + x;

        RETURN b;
    END; | 
DELIMITER ;

SELECT example(10);

DROP FUNCTION example;



-- CONTOH KASUS
CREATE TABLE anggota(
    ID INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    Nama VARCHAR(255) NOT NULL,
    Gender ENUM('l', 'p') NOT NULL
);

INSERT INTO anggota(Nama, Gender) VALUES
    ('Budi', 'l'),
    ('Sara', 'p'),
    ('Andi', 'l');

DELIMITER |
    CREATE FUNCTION GenderPattern(code VARCHAR(1)) RETURNS VARCHAR(10)
    BEGIN
        RETURN IF(code = 'l', 'Laki-Laki', 'Perempuan');
    END;
|
DELIMITER ;

SELECT 
    `Nama`, 
    GenderPattern(`Gender`) as `Gender Semua` 
FROM `anggota`;
