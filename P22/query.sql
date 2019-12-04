-- DROP Database kalau pernah punya salah :-)
DROP DATABASE IF EXISTS `tugas_app`;

CREATE DATABASE `tugas_app`;
USE `tugas_app`;

SET sql_mode = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_ENGINE_SUBSTITUTION';

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
        DECLARE stokAkhir INT;
        DECLARE hppAkhir INT;
        DECLARE totalBiayaHppLama INT;
        DECLARE totalBiayaHppBaru INT;
    	
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
        ORDER BY `tgl` DESC
        LIMIT 1;
        
        IF @jumlah IS NULL THEN
        	-- Jika ini adalah inputan pertama
        	SET stokAkhir = unit_dibeli;
            SET hppAkhir = harga_beli;
        ELSE
        	-- Jika sudah bukan inputan pertama
        	SET stokAkhir = @jumlah + unit_dibeli;
            SET totalBiayaHppLama = @jumlah * @hpp;
            SET totalBiayaHppBaru = unit_dibeli * harga_beli;
            SET hppAkhir = (totalBiayaHppLama + totalBiayaHppBaru) /  stokAkhir;
        END IF;
       
            
        -- Masukan hpp baru
        INSERT
       		`hpp`(`barang_id`, `tgl`, `jumlah`, `hpp`)
            VALUES(id_barang, tglbeli, stokAkhir, hppAkhir);
             
     END
| DELIMITER ;



DELIMITER |
CREATE PROCEDURE `addpenjualan`(
	tgljual DATE, 
  	kodePO CHAR(5),
	id_barang INT, 
    unit_dijual INT, 
    harga_jual INT
)
	penjualan:BEGIN
    	DECLARE ID_PENJULAN INT;
        DECLARE stockAkhir INT;
        
        -- Ambil Hpp terakhir
        SELECT
        	id,
        	jumlah,
            hpp
        INTO
        	@id,
        	@jumlah,
            @hpp
        FROM
        	`hpp`
        ORDER BY `tgl` DESC
        LIMIT 1;
        
    	-- Buat Penjualan
    	INSERT 
        	INTO `penjualan`(`kode`, `tgl`) 
            VALUES
            	(kodePO, tgljual);
        
        -- Ambil Id Pembelian
        SET ID_PENJULAN = LAST_INSERT_ID();
        
         -- Membuat barang dalam penjualan
        
        INSERT 
        	INTO `penjualan_barang`(`penjualan_id`, `barang_id`, `jumlah`, `harga`, `hpp_id`)
            VALUES (ID_PENJULAN, id_barang, unit_dijual, @hpp, @id);
        
        IF @jumlah IS NULL THEN
        	-- Jika stok tidak ditemukan
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Tidak dapat menjual tanpa memiliki stok awal';
            
            LEAVE penjualan;
        ELSE
        	-- Jika stok ditemukan
        	SET stockAkhir = @jumlah - unit_dijual;
        END IF;
       
            
        -- Masukan hpp baru
        INSERT
       		`hpp`(`barang_id`, `tgl`, `jumlah`, `hpp`)
            VALUES(id_barang, tgljual, stockAkhir, @hpp);
    END
| DELIMITER ;

DELIMITER |
CREATE PROCEDURE `hpp`(id_barang INT)
	BEGIN
    	SELECT 
        	`hpp`.`tgl`, 
            
            IFNULL(`Xpembelian`.`jumlah`, ' -') as `Pembelian - Unit`,
            IFNULL(`Xpembelian`.`harga`, ' -') as `Pembelian - Harga /unit`,
            IFNULL(`Xpembelian`.`harga` * `Xpembelian`.`jumlah`, ' -') as `Pembelian - Total Harga`,
            
            IFNULL(`Xpenjualan`.`jumlah`, ' -') as `Penjualan - Unit`,
            IFNULL(`Xpenjualan`.`harga`, ' -') as `Penjualan - Harga /unit`,
            IFNULL(`Xpenjualan`.`harga` * `Xpenjualan`.`jumlah`, ' -') as `Penjualan - Total Harga`,
            
            `hpp`.`jumlah` as `HPP - unit`,
            `hpp`.`hpp` as  `HPP - Harga /unit`,
            `hpp`.`jumlah` * hpp.hpp as `HPP - Total harga`
        FROM
        	`hpp`
        LEFT JOIN 
        	(SELECT * FROM `pembelian_barang` JOIN pembelian ON pembelian.id = pembelian_barang.pembelian_id) as `Xpembelian`
            ON
            	`Xpembelian`.`barang_id` = `hpp`.`barang_id`
                AND
                `hpp`.`tgl` = `Xpembelian`.`tgl`
        LEFT JOIN
        	(SELECT * FROM `penjualan_barang` JOIN penjualan ON penjualan.id = penjualan_barang.penjualan_id) as `Xpenjualan`
            ON
              `Xpenjualan`.`barang_id` = `hpp`.`barang_id`
              AND
              `hpp`.`tgl` = `Xpenjualan`.`tgl`
        WHERE
        	`hpp`.`barang_id` = id_barang
        GROUP BY
        	`hpp`.`tgl`, `Xpembelian`.`tgl`, `Xpenjualan`.`tgl`
        ;
    END
| DELIMITER ;


-- Call insert prosedure
CALL `addpembelian`("2019-01-02", "beli1", 1, 200, 9000);
CALL `addpembelian`("2019-03-10", "beli2", 1, 300, 10000);

CALL `addpenjualan`("2019-04-05", "jual1", 1, 200, 11000);
CALL `addpenjualan`("2019-05-07", "jual2", 1, 100, 0);

CALL `addpembelian`("2019-09-21", "beli3", 1, 400, 11000);
CALL `addpembelian`("2019-11-18", "beli4", 1, 100, 12000); 

CALL `addpenjualan`("2019-11-20", "jual3", 1, 200, 0);
CALL `addpenjualan`("2019-12-10", "jual4", 1, 200, 0);

-- review data table
SELECT * FROM pembelian;
SELECT * FROM pembelian_barang;
SELECT * FROM hpp;
SELECT * FROM penjualan;
SELECT * FROM penjualan_barang;

-- Call report procedure
CALL `hpp`(1);

-- Clean DB
DROP DATABASE `tugas_app`;
