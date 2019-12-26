DROP DATABASE IF EXISTS `learnPartition`;
CREATE DATABASE `learnPartition`;
USE `learnPartition`;

CREATE TABLE `menu` (
    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    nama VARCHAR(45) NOT NULL
)ENGINE=MyISAM;

CREATE TABLE `menu2` (
    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    nama VARCHAR(45) NOT NULL,
    tgl DATE
)ENGINE=MyISAM;

INSERT 
    INTO `menu`(`nama`) 
    VALUES 
        ('Ayam Bakar'),
        ('Mie Goreng'),
        ('Nasi Goreng'),
        ('Sate Padang'),
        ('Bubur Kacang Ijo'),
        ('Mie Ayam'),
        ('Bakso');

INSERT 
    INTO `menu2`(`nama`, `tgl`) 
    VALUES 
        ('Ayam Bakar', '2019-11-01'),
        ('Mie Goreng', '2019-11-01'),
        ('Nasi Goreng','2019-10-01'),
        ('Sate Padang','2019-09-01'),
        ('Bubur Kacang Ijo', '2019-09-01'),
        ('Mie Ayam', '2019-09-01'),
        ('Bakso', '2019-09-01');

ALTER TABLE `menu` PARTITION BY RANGE (`id`) 
(
    PARTITION `p1` VALUES LESS THAN (3),
    PARTITION `p2` VALUES LESS THAN (5),
    PARTITION `p3` VALUES LESS THAN MAXVALUE
);

SELECT * FROM `menu` PARTITION(p2);


-- ALTER TABLE `menu2` PARTITION BY HASH (YEAR(`tgl`)) PARTITIONS 3;

ALTER TABLE `menu2` PARTITION BY HASH (YEAR(`tgl`)) 
(
    PARTITION c0,
    PARTITION c1,
    PARTITION c2
);

DROP DATABASE IF EXISTS `learnPartition`;

