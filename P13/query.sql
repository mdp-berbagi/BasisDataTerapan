DROP DATABASE IF EXISTS `Aziz_kasus_Kasir`;
CREATE DATABASE `Aziz_kasus_Kasir`;
USE `Aziz_kasus_Kasir`;

CREATE TABLE `KartuPesanan`(
    NomorPesanan INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    JenisProduk VARCHAR(50) NOT NULL,
    JmlPesanan INT NOT NULL,
    TglPesanan DATE NOT NULL,
    TglSelesai DATE NOT NULL,
    DipesanOleh VARCHAR(50) NOT NULL
);

CREATE TABLE `RincianBiaya`(
    NomorPesanan INT NOT NULL,
    Tanggal DATE NOT NULL,
    Kelompok VARCHAR(50) NOT NULL,
    SubKelompok VARCHAR(50) NOT NULL,
    Jumlah INT
);

INSERT INTO 
    `KartuPesanan`(NomorPesanan, JenisProduk, JmlPesanan, TglPesanan, TglSelesai, DipesanOleh)
    VALUES
        (1, 'Sepatu', 4000, '2004-01-01', '2004-01-30', 'PT Karya'),
        (1, 'Sandal', 3000, '2004-02-02', '2004-02-28', 'PT Abdi'),
        (1, 'Sandal', 3000, '2004-03-03', '2004-03-30', 'PT Maju');
