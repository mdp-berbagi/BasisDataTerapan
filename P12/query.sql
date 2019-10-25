DROP DATABASE IF EXISTS `mdp`;
CREATE DATABASE `mdp`;
USE `mdp`;

CREATE TABLE `mahasiswa`(
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    `npm` VARCHAR(20) NOT NULL,
    `nama` VARCHAR(30) NOT NULL
);

INSERT INTO `mahasiswa`(`npm`,`nama`) VALUES
    ('1923250001', 'Ali'),
    ('1923250002', 'Budianto'),
    ('1923250003', 'Budianti'),
    ('1923250004', 'Carli'),
    ('1923250005', 'Dandi')
;

DESC `mahasiswa`;
SELECT * FROM `mahasiswa`;

CREATE TABLE `ujian`(
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    `mahasiswa_id` INT NOT NULL,
    `nilai` INT NOT NULL
);

INSERT INTO `ujian`(`mahasiswa_id`, `nilai`) VALUES 

    (1, 50),
    (2, 80),
    (3, 50),
    (4, 40),
    (5, 59),

    (1, 60),
    (3, 50),
    (4, 50),
    (5, 41),

    
    (3, 70),
    (5, 42),

    (5, 43)
;

DESC `ujian`;
SELECT * FROM `ujian`;

/* DAFTAR NAMA MAHASISWA YANG LULUS PADA UJIAN PERTAMA */
SELECT 
    `mhs`.*
FROM 
    `mahasiswa` AS `mhs` 
JOIN
    `ujian`
        ON 
            `ujian`.`mahasiswa_id` = `mhs`.`id`
            AND
            (SELECT COUNT(*) FROM `ujian` WHERE `ujian`.`mahasiswa_id` = `mhs`.`id`) = 1
WHERE
    `ujian`.`nilai` >= 60
GROUP BY `mhs`.`id`;

/* DAFTAR NAMA MAHASISWA dan jumlah ujian yang pernah di ikuti */
SELECT 
    `mhs`.*, 
    COUNT(`ujian`.`id`) as `Jumlah Ujian`
FROM 
    `mahasiswa` AS `mhs` 
JOIN
    `ujian`
        ON 
            `ujian`.`mahasiswa_id` = `mhs`.`id`
GROUP BY `mhs`.`id`;

/* DAFTAR NAMA MAHASISWA YANG TIDAK LULUS SETELAH UJIAN KE 4 */
SELECT 
    `mhs`.*
FROM 
    `mahasiswa` AS `mhs` 
JOIN
    `ujian`
        ON 
            `ujian`.`mahasiswa_id` = `mhs`.`id`
            AND
            (SELECT COUNT(*) FROM `ujian` WHERE `ujian`.`mahasiswa_id` = `mhs`.`id`) = 4
WHERE
    `ujian`.`nilai` < 60
GROUP BY `mhs`.`id`;

/* DAFTAR BERISI NAMA MAHASISWA, BERAPA KALI UJIAN DAN BERAPA NILAI TERTINGGINYA */
SELECT 
    `mhs`.*, 
    COUNT(`ujian`.`id`) as `Jumlah Ujian`,
    (SELECT MAX(`nilai`) FROM `ujian` WHERE `mhs`.`id` = `mahasiswa_id`) as `Nilai Tinggi`
FROM 
    `mahasiswa` AS `mhs` 
JOIN
    `ujian`
        ON 
            `ujian`.`mahasiswa_id` = `mhs`.`id`
GROUP BY `mhs`.`id`;
