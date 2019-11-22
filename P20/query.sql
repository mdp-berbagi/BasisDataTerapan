-- BUAT DATABASE KE SERVER
DROP DATABASE IF EXISTS `KASUS_PROSEDUR`;
CREATE DATABASE `KASUS_PROSEDUR`;
USE `KASUS_PROSEDUR`;

-- BUAT TABLE MAHASISWA
CREATE TABLE `mhs`(
    id INT(4) unsigned zerofill PRIMARY KEY AUTO_INCREMENT,
    npm VARCHAR(225) NOT NULL,
    Jurusan VARCHAR(255) NOT NULL,
    nama VARCHAR(255) NOT NULL
);

-- BUAT PROSEDUR : Pembuatan NPM dari Jurusan dan langsung INPUT
DELIMITER |
CREATE PROCEDURE `mhs_creator`(namaInput VARCHAR(255), kode_jurusan CHAR(2))
BEGIN
    DECLARE prefix_npm VARCHAR(255);
    DECLARE namaJurusan VARCHAR(255);
    DECLARE banyakJurusan INT;

    -- AMBIL TAHUN SKRNG
    SET prefix_npm = DATE_FORMAT(NOW(), '%y');

    -- AMBIL TAHUN TAMAT
    SET prefix_npm = CONCAT(prefix_npm, (prefix_npm + 4));

    -- AMBIL JURUSAN
    SET prefix_npm = CONCAT(prefix_npm, IF(kode_jurusan = 'SI', 24, 25));

    -- BUAT JURUSAN
    SET namaJurusan = IF(kode_jurusan = "SI", "Sistem Informasi", "Teknik Informatika");

    -- BANYAK JURUSAN
    SET banyakJurusan = (SELECT COUNT(*) FROM `mhs` WHERE `Jurusan` = namaJurusan);
    
    -- INSERT KE TABLE
    INSERT INTO 
        `mhs`(npm, Jurusan, nama) 
        VALUES (CONCAT(prefix_npm, LPAD(banyakJurusan + 1, '4', '0')), namaJurusan, namaInput);
    
END | 
DELIMITER ;

-- TEST
CALL `mhs_creator`("Budi", "SI");
CALL `mhs_creator`("Ali", "TI");
CALL `mhs_creator`("Budi 2", "SI");
CALL `mhs_creator`("Ali 2", "TI");

-- LOOK A TEST
SELECT * FROM mhs;

-- CLEAN DATABASE DARI SERVER
DROP DATABASE `KASUS_PROSEDUR`;