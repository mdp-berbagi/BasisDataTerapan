-- HAPUS dan BUAT DATABASE
DROP DATABASE IF EXISTS database_stock;

-- BUAT TABLE BARU
CREATE DATABASE database_stock;
use database_stock;


-- CREATE TABLE BARANG
CREATE TABLE `barang`(
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  kode VARCHAR(25) NOT NULL,
  nama VARCHAR(50) NOT NULL,
  satuan VARCHAR(10) NOT NULL
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
  harga_mati INT NOT NULL,
  tgl DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- INSERT TABLE `barang`
INSERT INTO `barang`(kode,nama,satuan) VALUES
  ('BM001', 'Minyak Bimolo 1 KG', 'Botol'),
  ('BM001', 'Minyak Bimolo 2 KG', 'Botol');
