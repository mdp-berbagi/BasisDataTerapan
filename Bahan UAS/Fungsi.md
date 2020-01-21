# Fungsi
fungsi bawaan MySQL untuk proses data sesuai keinginan

### SUBSTRING_INDEX() - Substring / potong kata
`SELECT SUBSTRING_INDEX('Nama Saya Aziz Al-Basyir', '-', 1)` hasilnya "Nama Saya Aziz Al"
<br />
`SELECT SUBSTRING_INDEX('Nama Saya Aziz Al-Basyir', '-', -1)` hasilnya "Basyir"

### NOW() / CURRENT_TIMESTAMP - mengambil waktu sekarang
`SELECT NOW()` hasilnya jam sekarang, boleh dengan CURRENT_TIMESTAMP

### DATE_FORMAT() - Format Ulang Tanggal dan Jam
`SELECT DATE_FORMAT("2017-06-15", "%Y // %M")` hasilnya "2020 // January"
 <br />
Format :  <br />
%a	Abbreviated weekday name (Sun to Sat) <br />
%b	Abbreviated month name (Jan to Dec) <br />
%c	Numeric month name (0 to 12) <br />
%D	Day of the month as a numeric value, followed by suffix (1st, 2nd, 3rd, ...) <br />
%d	Day of the month as a numeric value (01 to 31) <br />
%e	Day of the month as a numeric value (0 to 31) <br />
%f	Microseconds (000000 to 999999) <br />
%H	Hour (00 to 23) <br />
%h	Hour (00 to 12) <br />
%I	Hour (00 to 12) <br />
%i	Minutes (00 to 59) <br />
%j	Day of the year (001 to 366) <br />
%k	Hour (0 to 23) <br />
%l	Hour (1 to 12) <br />
%M	Month name in full (January to December) <br />
%m	Month name as a numeric value (00 to 12) <br />
%p	AM or PM <br />
%r	Time in 12 hour AM or PM format (hh:mm:ss AM/PM) <br />
%S	Seconds (00 to 59) <br />
%s	Seconds (00 to 59) <br />
%T	Time in 24 hour format (hh:mm:ss) <br />
%U	Week where Sunday is the first day of the week (00 to 53) <br />
%u	Week where Monday is the first day of the week (00 to 53) <br />
%V	Week where Sunday is the first day of the week (01 to 53). Used with %X <br />
%v	Week where Monday is the first day of the week (01 to 53). Used with %X <br />
%W	Weekday name in full (Sunday to Saturday) <br />
%w	Day of the week where Sunday=0 and Saturday=6 <br />
%X	Year for the week where Sunday is the first day of the week. Used with %V <br />
%x	Year for the week where Monday is the first day of the week. Used with %V <br />
%Y	Year as a numeric, 4-digit value <br />
%y	Year as a numeric, 2-digit value <br />

### IF() - Logika berbentuk fungsi
`SELECT IF(500<1000, "YES", "NO");` hasilnya "YES"
