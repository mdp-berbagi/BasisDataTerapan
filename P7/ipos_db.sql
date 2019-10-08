DROP DATABASE IF EXISTS `ipos_db`;

CREATE DATABASE `ipos_db`;
USE `ipos_db`;

CREATE TABLE `pemasok`(
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  kode CHAR(5) NOT NULL,
  nama VARCHAR(255) NOT NULL,
  hp VARCHAR(15) NOT NULL,
  create_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  update_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE `brand`(
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  kode CHAR(5) NOT NULL,
  nama VARCHAR(255) NOT NULL,
  create_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  update_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE `produk`(
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  brand_id INT UNSIGNED,
  kode CHAR(5) NOT NULL,
  nama VARCHAR(255) NOT NULL,
  create_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  update_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

  FOREIGN KEY (brand_id) REFERENCES brand(id) ON UPDATE CASCADE
);

CREATE TABLE `pembelian`(
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  kode CHAR(5) NOT NULL,
  tgl DATE,
  pemasok_id INT UNSIGNED,
  create_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  update_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

  FOREIGN KEY (pemasok_id) REFERENCES pemasok(id) ON UPDATE CASCADE
);

CREATE TABLE `detail_pembelian`(
  pembelian_id INT UNSIGNED,
  produk_id INT UNSIGNED,
  jumlah INT UNSIGNED,
  harga DECIMAL(15,2),
  create_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  update_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

  FOREIGN KEY (pembelian_id) REFERENCES pembelian(id) ON UPDATE CASCADE,
  FOREIGN KEY (produk_id) REFERENCES produk(id) ON UPDATE CASCADE
);


CREATE TABLE `pelanggan` (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  kode CHAR(5) NOT NULL,
  nama VARCHAR(255) NOT NULL,
  hp VARCHAR(15) NOT NULL,
  create_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  update_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE `pembayaran` (
  id INT AUTO_INCREMENT PRIMARY KEY,
  kode CHAR(5) NOT NULL,
  tgl DATE,
  nominal DECIMAL(15,2) UNSIGNED,
  penjualan_id INT UNSIGNED,
  create_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  update_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
