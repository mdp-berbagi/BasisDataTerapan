DROP DATABASE IF EXISTS `contoh_fungsi`;
CREATE DATABASE `contoh_fungsi`;
USE `contoh_fungsi`;

DELIMITER |
CREATE FUNCTION ambilTotalHarga(tglMsk DATE, tglKlr DATE, id_kamar INT) RETURNS INT
    BEGIN
        DECLARE jumlahHari INT;
        DECLARE hargaKamar INT;
        DECLARE totalHarga INT;

        SET jumlahHari = datediff(tglKlr, tglMsk);
        SET hargaKamar = (SELECT harga FROM `kamar` WHERE id = id_kamar);
        SET totalHarga = hargaKamar * jumlahHari;

        RETURN IF(jumlahHari > 2, totalHarga - (totalHarga * 0.1) , totalHarga);
    END
| DELIMITER ;

CREATE TABLE `pelanggan`(
    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    nama VARCHAR(30) NOT NULL
);

CREATE TABLE `kamar`(
    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    nama VARCHAR(30) NOT NULL,
    harga INT UNSIGNED NOT NULL
);

CREATE TABLE `inap`(
    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    pelanggan_id INT UNSIGNED NOT NULL,
    kamar_id INT UNSIGNED NOT NULL,
    tgl_masuk DATE NOT NULL,
    tgl_keluar DATE NOT NULL,
    biaya INT UNSIGNED NOT NULL
);

INSERT INTO `pelanggan`(nama) 
    VALUES ('Budi'), ('Iwan');

INSERT INTO `kamar`(nama,harga) 
    VALUES ('Melati', 1000000), ('Mawar', 2000000);

INSERT INTO `inap`(pelanggan_id, kamar_id, tgl_masuk, tgl_keluar, biaya) 
    VALUES 
        (1, 1, '2019-11-10', '2019-11-12', ambilTotalHarga(tgl_masuk, tgl_keluar, kamar_id)),
        (2, 2, '2019-11-10', '2019-11-15', ambilTotalHarga(tgl_masuk, tgl_keluar, kamar_id));

SELECT * FROM `inap`;