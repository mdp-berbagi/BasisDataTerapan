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
    Jumlah INT,

    -- EXAMPLE FOREIGN KEY HERE !!
    FOREIGN KEY (NomorPesanan) REFERENCES KartuPesanan(NomorPesanan)
);
DESC `RincianBiaya`;


-- INSERT DATA
INSERT INTO 
    `KartuPesanan`(NomorPesanan, JenisProduk, JmlPesanan, TglPesanan, TglSelesai, DipesanOleh)
    VALUES
        (1, 'Sepatu', 4000, '2004-01-01', '2004-01-30', 'PT Karya'),
        (2, 'Sandal', 3000, '2004-02-02', '2004-02-28', 'PT Abdi'),
        (3, 'Tas', 3000, '2004-03-03', '2004-03-30', 'PT Maju');

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
    (1, '2004-02-15', 'Tenaga Kerja', 'Upah Buruh', 30000000),
    
    (2, '2004-02-15', 'Material', 'Kulit', 20000000),
    (2, '2004-02-15', 'Material', 'Kain', 10000000),
    (2, '2004-02-15', 'Tenaga Kerja', 'Upah Buruh', 60000000),
    (2, '2004-02-15', 'Tenaga Kerja', 'Upah Tenaga Ahli', 13000000),
    
    (3, '2004-03-15', 'Material', 'Kulit', 15000000),
    (3, '2004-03-15', 'Material', 'Kain', 14000000),
    (3, '2004-03-15', 'Tenaga Kerja', 'Upah Buruh', 8000000);

SELECT * FROM `RincianBiaya`;


/*
 * STUDI KASUS
 */

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
    rincian.Kelompok;

/*  Laporan Biaya Langsung Per Bulan */
SELECT 
	DATE_FORMAT(TglPesanan, '%Y') as Tahun, -- OY! EXAMPLE TANGGAL HERE!!
    DATE_FORMAT(TglPesanan, '%m') as Bulan, 
    SUM(rincian.Jumlah) as `Kelompok Biaya`,
    (SUM(rincian.Jumlah) * pesanan.JmlPesanan) as `Jumlah Biaya`
FROM 
	RincianBiaya as rincian
	JOIN
    	KartuPesanan as pesanan ON 
            pesanan.NomorPesanan = rincian.NomorPesanan
GROUP BY
    Tahun,
    Bulan;


/*  Laporan Biaya Langsung Per Produk */
SELECT 
	pesanan.JenisProduk as Produk,
    SUM(rincian.Jumlah) as `Kelompok Biaya`,
    (SUM(rincian.Jumlah) * pesanan.JmlPesanan) as `Jumlah Biaya`
FROM 
	RincianBiaya as rincian
	JOIN
    	KartuPesanan as pesanan ON 
            pesanan.NomorPesanan = rincian.NomorPesanan
GROUP BY
    Produk;


/* Penghitungan Biaya Produk Per Pesanan */
SELECT 
	pesanan.NomorPesanan,
    pesanan.JenisProduk,
    pesanan.JmlPesanan,
    (SUM(rincian.Jumlah) * pesanan.JmlPesanan) as `Biaya Langsung`,
    (
        SUM(rincian.Jumlah) * pesanan.JmlPesanan + (SUM(rincian.Jumlah) * pesanan.JmlPesanan * 30 / 100)
    ) 
    as `Biaya Langsung`,
    (
        (SUM(rincian.Jumlah) * pesanan.JmlPesanan) +
        SUM(rincian.Jumlah) * pesanan.JmlPesanan + (SUM(rincian.Jumlah) * pesanan.JmlPesanan * 30 / 100)
    ) as `Total Biaya`,
    SUM(rincian.Jumlah) as `BiayaPerUnit`
FROM 
	RincianBiaya as rincian
	JOIN
    	KartuPesanan as pesanan ON 
            pesanan.NomorPesanan = rincian.NomorPesanan
GROUP BY
	rincian.NomorPesanan;

/* 
 * 
 * Laporan Total Biaya, Rata-rata, Jumlah Tertinggi, Jumlah Terkecil, serta Jumlah Pesanan yang menggunakan biaya 
 */

/*
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
    rincian.Kelompok;
*/

/*
 * Laporan biaya langsug per pesanan yang diperinci sampai kelompok untuk jenis sepatu saja
 */

SELECT 
	pesanan.NomorPesanan,
    pesanan.JenisProduk,
    pesanan.JmlPesanan,
    rincian.Kelompok,
    SUM(rincian.Jumlah) as `Kelompok Biaya`
FROM 
	RincianBiaya as rincian
	JOIN
    	KartuPesanan as pesanan ON 
            pesanan.NomorPesanan = rincian.NomorPesanan
WHERE
    pesanan.JenisProduk = 'Sepatu'
GROUP BY
	rincian.NomorPesanan,
    pesanan.JenisProduk,
    rincian.Kelompok;

/*
 * Laporan biaya langsug per pesanan yang diperinci sampai kelompok untuk jumlah biaya yang lebih besar dari 20JT
 */

SELECT 
	pesanan.NomorPesanan,
    pesanan.JenisProduk,
    pesanan.JmlPesanan,
    rincian.Kelompok,
    SUM(rincian.Jumlah) as `Kelompok Biaya`
FROM 
	RincianBiaya as rincian
	JOIN
    	KartuPesanan as pesanan ON 
            pesanan.NomorPesanan = rincian.NomorPesanan
GROUP BY
	rincian.NomorPesanan,
    rincian.Kelompok
HAVING
    SUM(rincian.Jumlah) > 20000000;


/*
 * Daftar 3 terbesar menggunakan kelompok biaya
 */

 SELECT 
	pesanan.NomorPesanan,
    pesanan.JenisProduk,
    pesanan.JmlPesanan,
    rincian.Kelompok,
    SUM(rincian.Jumlah) as `Kelompok Biaya`
FROM 
	RincianBiaya as rincian
	JOIN
    	KartuPesanan as pesanan ON 
            pesanan.NomorPesanan = rincian.NomorPesanan
GROUP BY
	rincian.NomorPesanan,
    rincian.kelompok
ORDER BY
    `Kelompok Biaya` DESC
LIMIT 0,3;