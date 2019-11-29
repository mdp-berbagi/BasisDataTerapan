CREATE DATABASE `tugas_app`;
USE `tugas_app`;

CREATE TABLE `pembelian`(
	`id` INT UNSIGNED PRIMARY KEY,
	`kode` CHAR(5) NOT NULL,
	`tgl` DATE NOT NULL
);

CREATE TABLE `pembelian_barang`(
	`pembelian_id` INT UNSIGNED NOT NULL,
  	`barang_id` INT UNSIGNED NOT NULL,
  	`jumlah` INT NOT NULL,
  	`harga` INT NOT NULL
);

CREATE TABLE `barang`(
	`id` INT UNSIGNED PRIMARY KEY NOT NULL,
  	`kode` CHAR(5) NOT NULL,
  	`nama` VARCHAR(255) NOT NULL
);

CREATE TABLE `hpp`(
	`id` INT UNSIGNED PRIMARY KEY NOT NULL,
  	`barang_id` INT UNSIGNED NOT NULL,
  	`tgl` DATE NOT NULL,
  	`jumlah` INT NOT NULL,
  	`hpp` DOUBLE NOT NULL
);

CREATE TABLE `penjualan`(
	`id` INT UNSIGNED PRIMARY KEY NOT NULL,
  	`kode` CHAR(5) NOT NULL,
  	`tgl` DATE NOT NULL
);

CREATE TABLE `penjualan_barang`(
	`penjualan_id` INT UNSIGNED NOT NULL,
  	`barang_id` INT UNSIGNED NOT NULL,
  	`jumlah` INT NOT NULL,
  	`harga` INT NOT NULL,
  	`hpp_id` INT UNSIGNED NOT NULL
);

DROP DATABASE `tugas_app`;
