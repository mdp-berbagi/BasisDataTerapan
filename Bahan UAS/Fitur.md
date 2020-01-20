# Fitur
Ini berisikan Penggunaan fitur Pada MySQL

## Trigger
Memberikan printah sesudah menerima perintah INSERT UPDATE DELETE di kondisi BEFORE atau AFTER 

### Penggunaan
Format :
```
DELIMITER ;;
CREATE TRIGGER [ Nama Pemicu ]
    [AFTER / BEFORE] [ INSERT / UPDATE / DELETE ]
    ON `namaTable`
    FOR EACH ROW
        BEGIN
          [ QUERY BEBAS ]
        END
;;
DELIMITER ;
```
Contoh :
```
DELIMITER ;;
CREATE TRIGGER `logging`
    AFTER INSERT
    ON `transaksi`
    FOR EACH ROW
        BEGIN
            INSERT log(transaksi_id, query)
            VALUES (NEW.id, CONCAT("INSERT INTO `transaksi`(`nominal`) VALUES ('",NEW.nominal,"')"));
        END
;;
DELIMITER ;
```

### Mengapus
`DROP TRIGGER trigger_name;`

## Event
Meberikan Perintah pada waktu yang ditentukan, bentuk waktu bisa berbentuk interval atau sekali jalan pada waktu tertentu (timeout), 
beberapa kasus tertentu Event wajib di aktifkan dengan cara `SET GLOBAL event_scheduler = ON`. 

### Penggunaan
Format :
```
DELIMITER ;;
CREATE EVENT [ Nama Jadwal ]
    ON SCHEDULE
    [ 
      AT : [ CURRENT_TIMESTAMP + *interval* ]
      EVERY : [ *interval* ]
    ] 
    -- STARTS [ CURRENT_TIMESTAMP + *interval* ]
    -- ENDS [ CURRENT_TIMESTAMP + *interval* ]
    DO
        [ QUERY DI SINI ]
;;
DELIMITER ;
```
*interval* : `jumlahInterval {
  YEAR | QUARTER | MONTH | DAY | HOUR | MINUTE | 
  WEEK | SECOND | YEAR_MONTH | DAY_HOUR | DAY_MINUTE |
  DAY_SECOND | HOUR_MINUTE | HOUR_SECOND | MINUTE_SECOND
}`

Contoh :
```
DELIMITER ;;
CREATE EVENT `reccuringEvent`
    ON SCHEDULE
    EVERY 1 SECOND
    STARTS [ CURRENT_TIMESTAMP + 1 YEAR ]
    DO
        DELETE FROM `log` WHERE `create_at` = `create_at` +  INTERVAL 1 MINUTE;
;;
DELIMITER ;
```

### Drop
`DROP EVENT namaEvent;`

## Procedure
Membuat kode panjangan menjadi pendek karna dapat di panggil ulang *tanpa nilai balik*

### Penggunaan
Format:
```
DELIMITER |
CREATE PROCEDURE [ nama prosedur ] ([ semua parameter :[ format : [nama parameter] [type] ] ])
BEGIN
    [ DECLARE ]
    [ QUERY BEBAS ]
END
```
Contoh :
```
DELIMITER |
CREATE PROCEDURE `mhs_creator`(namaInput VARCHAR(255), kode_jurusan CHAR(2))
BEGIN
    SELECT namaImput, kode_jurusan;
END |   
DELIMITER ;
```

### Drop
`DROP PROCEDURE namaProsedur;`

### Pemanggilan 
`CALL namaProsedur();`
Wajib dengan () di setiap pemanggilan prosedur walaupun prosedur tanpa parameter

## Fungsi
Membuat kode panjangan menjadi pendek karna dapat di panggil ulang dan *memiliki nilai balik*

### Penggunaan
Format:
```
DELIMITER |
CREATE FUNCTION `symbol_pattern_getter`(TEXTDATA TEXT, SYMBOL TEXT) 
RETURNS TEXT
BEGIN
    [ DECLARE ]
    [ QUERY BEBAS ]
    [ RETURN ]
END |   
DELIMITER ;
```
Contoh :
```
DELIMITER |
CREATE PROCEDURE `mhs_creator`(namaInput VARCHAR(255), kode_jurusan CHAR(2))
BEGIN
    SELECT namaImput, kode_jurusan;
END
```

### Drop
`DROP PROCEDURE namaProsedur;`

### Pemanggilan 
`SELECT namaFungsi()` atau `SELECT namaFungsi(akun.nama) from akun`
Wajib dengan () di setiap pemanggilan prosedur walaupun fungsi tanpa parameter
