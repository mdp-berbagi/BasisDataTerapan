DROP DATABASE IF EXISTS `PERCOBAAN_PROSEDUR`;
CREATE DATABASE `PERCOBAAN_PROSEDUR`;
USE `PERCOBAAN_PROSEDUR`;

-- GLOBAL VARIABLE, BISA DI AKSES DI MANA SAJA KALAU SUDAH DI DELARASI
SET @VAR_GLOBAL = "YES";

-- BUAT PROSEDUR BARU
DELIMITER |
CREATE PROCEDURE `cobaanProsedur`()
BEGIN
    -- VARIABLE GLOBAL DI PANGGIL DISINI
    SELECT @VAR_GLOBAL as `PERCOBAAN`;
END |
DELIMITER ;

-- BUAT PROSEDUR BARU DENGAN PARAMETER
DELIMITER |
CREATE PROCEDURE `cobaanProsedurDgnParm`(parm TEXT)
BEGIN
    SELECT parm as `PERCOBAAN`;
END |
DELIMITER ;

-- PERCOBAAN PEMANGGILAN
CALL cobaanProsedur();
CALL cobaanProsedurDgnParm("INI PAKAI PARM");


-- IN, OUT, DAN INOUT PARAMETERS