-- CREATE DATABASE
CREATE DATABASE IF NOT EXISTS `palembang_hujan`;

-- PILIH DATABASE
USE `palembang_hujan`;

-- BUAT TABLE
CREATE TABLE IF NOT EXISTS `mahasiswa`(
  `id` int unsigned primary key,
  `npm` char(10) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `create_at` TIMESTAMP
);

CREATE TABLE IF NOT EXISTS `dosen`(
  `id` int unsigned primary key,
  `nidn` char(10) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `create_at` TIMESTAMP
);

CREATE TABLE IF NOT EXISTS `ruang`(
  `id` int unsigned primary key,
  `nama` char(4) NOT NULL,
  `create_at` TIMESTAMP
);

CREATE TABLE IF NOT EXISTS `waktu`(
  `id` int unsigned primary key,
  `jam` char(5) NOT NULL,
  `hari` varchar(6) NOT NULL,
  `create_at` TIMESTAMP
);

CREATE TABLE IF NOT EXISTS `matakuliah`(
  `id` int unsigned primary key,
  `sks` int NOT NULL,
  `nama` varchar(255) NOT NULL,
  `create_at` TIMESTAMP
);


-- TABLE RELASI
CREATE TABLE IF NOT EXISTS `pengampuh`(
  `id` int unsigned primary key,
  `dosen_id` int unsigned NOT NULL,
  `matakuliah_id` int unsigned NOT NULL,

  -- RELASIKAN TABLE DOSEN
  FOREIGN KEY (`dosen_id`) REFERENCES dosen(`id`)
    ON UPDATE CASCADE
    ON DELETE RESTRICT,

  -- RELASIKAN TABLE MATAKULIAH
  FOREIGN KEY (`matakuliah_id`) REFERENCES `matakuliah`(`id`)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS `jadwal`(
  `id` int unsigned primary key,
  `waktu_id` int unsigned NOT NULL,
  `pengampuh_id` int unsigned NOT NULL,

  -- RELASIKAN TABLE WAKTU
  FOREIGN KEY (`waktu_id`) REFERENCES `waktu`(`id`)
    ON UPDATE CASCADE
    ON DELETE RESTRICT,

  -- RELASIKAN TABLE PENGAMPUN
  FOREIGN KEY (`pengampuh_id`) REFERENCES `pengampuh`(`id`)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS `krs`(
  `jadwal_id` int unsigned NOT NULL,
  `mahasiswa_id` int unsigned NOT NULL,

  -- RELASIKAN TABLE JADWAL
  FOREIGN KEY (`jadwal_id`) REFERENCES `jadwal`(`id`)
    ON UPDATE CASCADE
    ON DELETE RESTRICT,

  -- RELASIKAN TABLE JADWAL
  FOREIGN KEY (`mahasiswa_id`) REFERENCES `mahasiswa`(`id`)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
);
