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
DESC `KartuPesanan`;

CREATE TABLE `RincianBiaya`(
    NomorPesanan INT UNSIGNED NOT NULL,
    Tanggal DATE NOT NULL,
    Kelompok VARCHAR(50) NOT NULL,
    SubKelompok VARCHAR(50) NOT NULL,
    Jumlah INT
);
DESC `RincianBiaya`;


-- INSERT DATA
INSERT INTO 
    `KartuPesanan`(NomorPesanan, JenisProduk, JmlPesanan, TglPesanan, TglSelesai, DipesanOleh)
    VALUES
        (1, 'Sepatu', 4000, '2004-01-01', '2004-01-30', 'PT Karya'),
        (2, 'Sandal', 3000, '2004-02-02', '2004-02-28', 'PT Abdi'),
        (3, 'Sandal', 3000, '2004-03-03', '2004-03-30', 'PT Maju');

-- CHECK DATA KartuPesanan
SELECT * FROM `KartuPesanan`;


INSERT 
	INTO 
	`RincianBiaya`(
      NomorPesanan, 
      Tanggal,
      Kelompok,
      SubKelompok,
      Jumlah
    )
    VALUES
   	(1, '2004-01-15', 'Material', 'Kulit', 10000000),
    (1, '2004-01-15', 'Material', 'Kain', 5000000),
    
    (2, '2004-02-15', 'Material', 'Kulit', 20000000),
    (2, '2004-02-15', 'Material', 'Kain', 10000000),
    (2, '2004-02-15', 'Tenaga Kerja', 'Upah Buruh', 60000000),
    (2, '2004-02-15', 'Tenaga Kerja', 'Upah Tenaga Ahli', 13000000),
    
    (3, '2004-03-15', 'Material', 'Kulit', 15000000),
    (3, '2004-03-15', 'Material', 'Kain', 14000000),
    (3, '2004-03-15', 'Tenaga Kerja', 'Upah Buruh', 8000000);

SELECT * FROM `RincianBiaya`;

/* Laporan Biaya Langsung Per Pesanan Diperinci Sampai Kelompok Biaya */

SELECT 
	pesanan.NomorPesanan,
    pesanan.JenisProduk,
    pesanan.JmlPesanan,
    SUM(rincian.Jumlah) as `Kelompok Biaya`,
    (SUM(rincian.Jumlah) * pesanan.JmlPesanan) as `Jumlah Biaya`
FROM 
	RincianBiaya as rincian
	JOIN
    	KartuPesanan as pesanan ON 
            pesanan.NomorPesanan = rincian.NomorPesanan
GROUP BY
	rincian.NomorPesanan,
    rincian.Kelompok