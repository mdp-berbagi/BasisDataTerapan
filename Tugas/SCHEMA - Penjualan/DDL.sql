CREATE TABLE mahasiswa(
	`id` int unsigned primary key,
	`npm` char(10),
	`nama` varchar(255)
);

CREATE TABLE dosen(
	`id` int unsigned primary key,
	`nidn` char(10),
	`nama` varchar(255)
);

CREATE TABLE matakuliah(
	`id` int unsigned primary key,
	`sks` int,
	`nama` varchar(255)
);

CREATE TABLE waktu(
	`id` int unsigned primary key,
	`jam` CHAR(5),
	`hari` VARCHAR(6)
);

CREATE TABLE `ruang`(
	`id` int unsigned primary key,
	`nama` CHAR(4)
);

DESC matakuliah;

ALTER TABLE waktu MODIFY `jam` TIME
ALTER TABLE mahasiswa ADD `created_at` TIMESTAMP