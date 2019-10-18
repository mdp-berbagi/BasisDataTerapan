-- HAPUS dan BUAT DATABASE
DROP DATABASE IF EXISTS database_stock;

-- BUAT TABLE BARU
CREATE DATABASE database_stock;
use database_stock;


-- CREATE TABLE BARANG
CREATE TABLE `barang`(
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  kode VARCHAR(50) NOT NULL,
  nama VARCHAR(100) NOT NULL,
  satuan VARCHAR(20) NOT NULL
);

-- CREATE TABLE STOCK
CREATE TABLE `stock`(
  barang_id INT UNSIGNED NOT NULL,
  jumlah INT NOT NULL,
  tgl DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- CREATE TABLE HARGA
CREATE TABLE `harga`(
  barang_id INT UNSIGNED NOT NULL,
  nilai INT NOT NULL,
  tgl DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- INSERT TABLE `barang`
INSERT INTO `barang`(kode,nama,satuan) VALUES
  ('BM001', 'Minyak Bimolo 1 KG', 'Botol'),
  ('BM001', 'Minyak Bimolo 2 KG', 'Botol'),
  ('CR001', 'Shampo Clear', 'Botol'),
  ('LX001', 'Sabun Lux', 'Buah'),
  ('PP001', 'Pepsodent Kecil', 'Kotak'),
  ('PP002', 'Pepsodent Besar', 'Kotak'),
  ('PS001', 'Pocari Sweat', 'Kaleng'),
  ('SM001', 'Sampoerna Mild 16 Batang', 'Bungkus'),
  ('SM002', 'Sampoerna Mild 12 Batang', 'Bungkus'),
  ('SM003', 'Sampoerna Hijau', 'Bungkus'),
  ('SN001', 'Shampo Sunsik', 'Botol'),
  ('YL001', 'Yakult', 'Kaleng');

INSERT INTO `stock`(barang_id, jumlah, tgl) VALUES
  ('1', '2432', NOW()),
  ('2', '2112', NOW()),
  ('3', '1244', NOW()),
  ('4', '1298', NOW()),
  ('5', '5432', NOW()),
  ('6', '6432', NOW()),
  ('7', '2432', NOW()),
  ('8', '9432', NOW()),
  ('9', '9432', NOW()),
  ('10', '7232', NOW()),
  ('11', '5633', NOW()),
  ('12', '5242', NOW());

INSERT INTO `harga`(barang_id, nilai, tgl) VALUES
  ('1', '5000', '2019-01-01'),
  ('1', '4100', '2019-05-01'),
  ('1', '4500', NOW()),
  ('2', '1000', NOW()),
  ('3', '8000', NOW()),
  ('4', '1000', NOW()),
  ('5', '3400', NOW()),
  ('6', '5000', NOW()),
  ('7', '5000', NOW()),
  ('8', '9800', NOW()),
  ('9', '6700', NOW()),
  ('10', '6800', NOW()),
  ('11', '2000', NOW()),
  ('12', '1200', NOW());

-- No 1) UPDATE di TABLE `BARANG` dari satuan 'Kaleng' ke 'Botol'
UPDATE `barang`
  SET `satuan` = 'Botol'
  WHERE `satuan` = 'Kaleng';

-- No 2) Tampilkan kode,merk,harga,stock dan total harga
SELECT
  `barang`.`id`,
  `barang`.`kode`,
  `barang`.`nama`,
  `barang`.`satuan`,
  SUM(`stock`.`jumlah`) AS `jumlah`,
  `harga`.`nilai` AS `harga`,
  `harga`.`nilai` * SUM(`stock`.`jumlah`)  AS `total harga`
  FROM
    `barang`
  JOIN
    `stock` ON `stock`.`barang_id` = `barang`.`id`
  JOIN
    `harga` ON
      `harga`.`barang_id` = `barang`.`id`
      AND
      `harga`.`tgl` = (
        SELECT MAX(`tgl`) FROM `harga`
        WHERE `barang_id` = `barang`.`id`
      )
  GROUP BY
    `barang`.`id`;

-- No 3) Tampilkan Merk dan Harga Yang memiliki satuan Botol dan Harganya di atas 2000
SELECT
  `nama` `Merk`,
  `harga`.`nilai` AS `harga`
  FROM
    `barang`
  JOIN
    `harga` ON
      `harga`.`barang_id` = `barang`.`id`
      AND
      `harga`.`tgl` = (
        SELECT MAX(`tgl`) FROM `harga`
        WHERE `barang_id` = `barang`.`id`
      )
  WHERE
    `barang`.`satuan` = 'Botol'
    AND
    `harga`.`nilai` > 2000
  GROUP BY
    `barang`.`id`;

-- No 4) Tampilkan merk dan jumlah stock paling sedikit
SELECT
  `nama` as `merk`,
  `satuan`,
  MIN(`stock`.`jumlah`) AS `jumlah`
  FROM
    `barang`
  JOIN
    `stock` ON `stock`.`barang_id` = `barang`.`id`;

-- No 5) Tampilkan Jumlah Semua Stock
SELECT SUM(`jumlah`) as `semua_stock` FROM `stock`;

-- No 6) Tamilkan Jumlah
SELECT SUM(`nilai`) as `total_semua_stock` FROM `harga`;

-- No 7) Tampilakn jumlah dari seluruh karakter merk

-- No 8) Tampilkan seluruh field yang jumlah karakternya < 10

-- No 9) Tampilkan seluruh field yang harganya diantara 3000 - 5000
SELECT
  `nama` `Merk`,
  `harga`.`nilai` AS `harga`
  FROM
    `barang`
  JOIN
    `harga` ON
      `harga`.`barang_id` = `barang`.`id`
      AND
      `harga`.`tgl` = (
        SELECT MAX(`tgl`) FROM `harga`
        WHERE `barang_id` = `barang`.`id`
      )
  WHERE
    `harga`.`nilai` BETWEEN 3000 AND 5000
  GROUP BY
    `barang`.`id`;
