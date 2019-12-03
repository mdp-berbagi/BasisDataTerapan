CREATE DATABASE `tugas_app`;
USE `tugas_app`;

CREATE TABLE `pembelian`(
	`id` INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	`kode` CHAR(5),
	`tgl` DATE NOT NULL
);

CREATE TABLE `pembelian_barang`(
	`pembelian_id` INT UNSIGNED NOT NULL,
  	`barang_id` INT UNSIGNED NOT NULL,
  	`jumlah` INT NOT NULL,
  	`harga` INT NOT NULL
);

CREATE TABLE `barang`(
	`id` INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  	`kode` CHAR(5) NOT NULL,
  	`nama` VARCHAR(255) NOT NULL
);

CREATE TABLE `hpp`(
	`id` INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  	`barang_id` INT UNSIGNED NOT NULL,
  	`tgl` DATE NOT NULL,
  	`jumlah` INT NOT NULL,
  	`hpp` DOUBLE NOT NULL
);

CREATE TABLE `penjualan`(
	`id` INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  	`kode` CHAR(5),
  	`tgl` DATE NOT NULL
);

CREATE TABLE `penjualan_barang`(
	`penjualan_id` INT UNSIGNED NOT NULL,
  	`barang_id` INT UNSIGNED NOT NULL,
  	`jumlah` INT NOT NULL,
  	`harga` INT NOT NULL,
  	`hpp_id` INT UNSIGNED NOT NULL
);


INSERT 
	INTO `barang`(`kode`, `nama`)
    VALUES
    	('DRK01', 'Coca Cola'),
        ('DRK02', 'Spirt');



DELIMITER |
CREATE PROCEDURE `addpembelian`(
  tglbeli DATE, 
  kodePO CHAR(5),
  id_barang INT, 
  unit_dibeli INT, 
  harga_beli INT
)
	BEGIN
    	DECLARE ID_PEMBELIAN INT;
        DECLARE jumlahAkhir INT;
        DECLARE hppAkhir INT;
        DECLARE totalBiayaHppLama INT;
        DECLARE totalBiayaHppBaru INT;
        DECLARE hppBaru INT;
    	
        -- Buat Penbelian
    	INSERT 
        	INTO `pembelian`(`kode`, `tgl`) 
            VALUES
            	(kodePO, tglbeli);
        
        -- Ambil Id Pelbelian
        SET ID_PEMBELIAN = LAST_INSERT_ID();
    	
        -- Membuat barang dalam pembelian
    	INSERT 
        	INTO `pembelian_barang`(`pembelian_id`, `barang_id`, `jumlah`, `harga`)
            VALUES (ID_PEMBELIAN, id_barang, unit_dibeli, harga_beli);
        
        -- Ambil Hpp terakhir
        SELECT
        	jumlah,
            hpp
        INTO
        	@jumlah,
            @hpp
        FROM
        	`hpp`
        ORDER BY `tgl`
        LIMIT 1;
        
        -- Masukan ke variable tertentu
        SET jumlahAkhir = (SELECT IFNULL(@jumlah, 0) + unit_dibeli);
        SET totalBiayaHppLama = @jumlah * @hpp;
        SET totalBiayaHppBaru = unit_dibeli * harga_beli;
        SET hppBaru = (totalBiayaHppLama + totalBiayaHppBaru) /  jumlahAkhir;
        
        SET hppAkhir = IF(@hpp IS NULL, harga_beli, hppBaru);
            
        -- Masukan hpp baru
        INSERT
       		`hpp`(`barang_id`, `tgl`, `jumlah`, `hpp`)
            VALUES(id_barang, tglbeli, jumlahAkhir, hppAkhir);
             
     END
| DELIMITER ;



DELIMITER |
CREATE PROCEDURE `addpenjualan`(
	tglbeli DATE, 
  	kodePO CHAR(5),
	id_barang INT, 
    unit_dibeli INT, 
    harga_beli INT
)
	BEGIN
    	
    END
| DELIMITER ;



CALL `addpembelian`("2019-01-02", "beli1", 1, 200, 9000);
CALL `addpembelian`("2019-03-10", "beli2", 1, 300, 10000);
-- CALL `addpenjualan`("2019-01-02", "beli1", 1, 200, 11000);

SELECT * FROM pembelian;
SELECT * FROM pembelian_barang;
SELECT * FROM hpp;



DROP DATABASE `tugas_app`;











