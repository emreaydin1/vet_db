-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- Anamakine: 127.0.0.1:3306
-- Üretim Zamanı: 05 May 2023, 14:24:42
-- Sunucu sürümü: 5.7.36
-- PHP Sürümü: 7.4.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Veritabanı: `emre_2020469115`
--

DELIMITER $$
--
-- Yordamlar
--
DROP PROCEDURE IF EXISTS `soru_3_1`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `soru_3_1` (IN `hayvan_id` INT, IN `hayvan_ad` VARCHAR(50), IN `hayvan_yas` INT(2), IN `tur_id` INT, IN `sahip_adi` VARCHAR(50), IN `sahip_soyadi` VARCHAR(50), IN `sahip_tel` VARCHAR(11))  NO SQL
INSERT INTO hayvanlar(hayvan_id,hayvan_ad,hayvan_yas,tur_id,sahip_adi,sahip_soyadi,sahip_tel)
VALUES
(hayvan_id,hayvan_ad,hayvan_yas,tur_id,sahip_adi,sahip_soyadi,sahip_tel)$$

DROP PROCEDURE IF EXISTS `soru_3_10`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `soru_3_10` (IN `tur_id` INT)  NO SQL
SELECT turler.tur_ad,ROUND(hayvanlar.hayvan_yas) as yas_ortalamasi
FROM turler,hayvanlar
WHERE turler.tur_id=hayvanlar.tur_id
AND turler.tur_id=tur_id
GROUP by turler.tur_id$$

DROP PROCEDURE IF EXISTS `soru_3_2`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `soru_3_2` (IN `silinecek_hastalik_id` INT)  NO SQL
DELETE FROM hastalik
WHERE hastalik.hastalik_id=silinecek_hastalik_id$$

DROP PROCEDURE IF EXISTS `soru_3_3`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `soru_3_3` (IN `hayvan_id` INT)  NO SQL
UPDATE hayvanlar
SET hayvanlar.hayvan_yas=hayvan_yas+1
WHERE hayvanlar.hayvan_id= hayvan_id$$

DROP PROCEDURE IF EXISTS `soru_3_4`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `soru_3_4` (IN `tur_adi` VARCHAR(50))  NO SQL
SELECT turler.tur_ad as tur_adi,COUNT(hayvanlar.hayvan_id) as hayvan_sayisi FROM turler,hayvanlar
WHERE turler.tur_id=hayvanlar.tur_id and turler.tur_ad=tur_adi$$

DROP PROCEDURE IF EXISTS `soru_3_5`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `soru_3_5` (IN `bu_sayida_asi_olan_hayvanlar` INT)  NO SQL
SELECT hayvanlar.hayvan_ad,COUNT(hayvan_asi.hayvan_id) as asi_sayisi
FROM asilar,hayvanlar,hayvan_asi
WHERE hayvanlar.hayvan_id=hayvan_asi.hayvan_id AND asilar.asi_id=hayvan_asi.asi_id
GROUP BY hayvanlar.hayvan_id
HAVING asi_sayisi=bu_sayida_asi_olan_hayvanlar$$

DROP PROCEDURE IF EXISTS `soru_3_6`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `soru_3_6` ()  NO SQL
CREATE VIEW kediler
AS
SELECT hayvanlar.hayvan_id,hayvanlar.hayvan_ad,hayvanlar.hayvan_yas
FROM hayvanlar,turler
WHERE hayvanlar.tur_id=turler.tur_id AND turler.tur_id=1$$

DROP PROCEDURE IF EXISTS `soru_3_7`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `soru_3_7` (IN `tur_id_no` INT)  NO SQL
SELECT hayvanlar.hayvan_ad,turler.tur_ad,hayvanlar.hayvan_yas
FROM turler,hayvanlar
WHERE hayvanlar.tur_id=turler.tur_id AND hayvanlar.hayvan_yas>ALL(SELECT hayvanlar.hayvan_yas FROM hayvanlar,turler WHERE turler.tur_id=hayvanlar.tur_id and turler.tur_id=tur_id_no)$$

DROP PROCEDURE IF EXISTS `soru_3_8`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `soru_3_8` (IN `asi_id_1` INT, IN `asi_id_2` INT, IN `yas_aralik_1` INT, IN `yas_aralik_2` INT)  NO SQL
SELECT hayvanlar.hayvan_ad,turler.tur_ad,hayvanlar.hayvan_yas,asilar.asi_ismi
FROM asilar,hayvanlar,turler,hayvan_asi
WHERE asilar.asi_id=hayvan_asi.asi_id AND turler.tur_id=hayvanlar.tur_id and hayvanlar.hayvan_id=hayvan_asi.hayvan_id AND asilar.asi_id not IN (asi_id_1,asi_id_2) and hayvanlar.hayvan_yas BETWEEN yas_aralik_1 and yas_aralik_2$$

DROP PROCEDURE IF EXISTS `soru_3_9`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `soru_3_9` ()  NO SQL
SELECT * FROM asilar,hastalik,hayvanlar,hayvan_asi,hayvan_hastalik,turler
WHERE hayvanlar.tur_id=turler.tur_id
AND asilar.asi_id=hayvan_asi.asi_id
AND hayvanlar.hayvan_id=hayvan_asi.hayvan_id
AND hastalik.hastalik_id=hayvan_hastalik.hastalik_id
AND hayvanlar.hayvan_id=hayvan_hastalik.hayvan_id$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `asilar`
--

DROP TABLE IF EXISTS `asilar`;
CREATE TABLE IF NOT EXISTS `asilar` (
  `asi_id` int(11) NOT NULL AUTO_INCREMENT,
  `asi_ismi` varchar(50) COLLATE utf8_turkish_ci NOT NULL,
  PRIMARY KEY (`asi_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `asilar`
--

INSERT INTO `asilar` (`asi_id`, `asi_ismi`) VALUES
(1, 'Brucellosis'),
(2, 'Lösemi Aşısı'),
(3, 'İç Parazit Aşısı'),
(4, 'Dış Parazit Aşısı'),
(5, 'Puppy DP Aşısı'),
(6, 'Bronchine Aşısı'),
(7, 'Karma Aşı'),
(8, 'Lyme Aşısı'),
(9, 'Kuduz Aşısı'),
(10, 'Şap Aşısı');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `hastalik`
--

DROP TABLE IF EXISTS `hastalik`;
CREATE TABLE IF NOT EXISTS `hastalik` (
  `hastalik_id` int(11) NOT NULL AUTO_INCREMENT,
  `hastalik_adi` varchar(50) COLLATE utf8_turkish_ci NOT NULL,
  PRIMARY KEY (`hastalik_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `hastalik`
--

INSERT INTO `hastalik` (`hastalik_id`, `hastalik_adi`) VALUES
(1, 'Kuduz'),
(2, 'Yaralanma'),
(3, 'Zehirlenme'),
(4, 'Kırık'),
(5, 'Doğum'),
(6, 'Beyaz Kas Hastalığı'),
(7, 'Canine Parvovirus'),
(8, 'Kennel Öksürüğü');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `hayvanlar`
--

DROP TABLE IF EXISTS `hayvanlar`;
CREATE TABLE IF NOT EXISTS `hayvanlar` (
  `hayvan_id` int(11) NOT NULL AUTO_INCREMENT,
  `hayvan_ad` varchar(50) COLLATE utf8_turkish_ci NOT NULL,
  `hayvan_yas` int(2) NOT NULL,
  `tur_id` int(11) NOT NULL,
  `sahip_adi` varchar(100) COLLATE utf8_turkish_ci NOT NULL,
  `sahip_soyadi` varchar(100) COLLATE utf8_turkish_ci NOT NULL,
  `sahip_tel` varchar(11) COLLATE utf8_turkish_ci NOT NULL,
  PRIMARY KEY (`hayvan_id`),
  KEY `tur_id` (`tur_id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `hayvanlar`
--

INSERT INTO `hayvanlar` (`hayvan_id`, `hayvan_ad`, `hayvan_yas`, `tur_id`, `sahip_adi`, `sahip_soyadi`, `sahip_tel`) VALUES
(1, 'Zeytin', 3, 1, 'Ayşe', 'Aktuğ', '53255384711'),
(2, 'Hera', 2, 1, 'Ekrem', 'Özcan', '51410759616'),
(3, 'Pamuk', 7, 4, 'Ziya', 'Yılmaz', '50506903242'),
(4, 'Alex', 5, 2, 'Ali', 'Barut', '50699509438'),
(5, 'Boncuk', 3, 6, 'Ebru', 'Öztürk', '52369572808'),
(6, 'Şahbatur', 15, 5, 'Süleyman', 'Çakır', '52897207368'),
(7, 'İsimsiz', 12, 8, 'Emine', 'Yaşar', '52511070575'),
(8, 'İsimsiz', 5, 9, 'Ahmet', 'Özkan', '50674303619'),
(9, 'Tekir', 6, 1, 'Elif', 'Duran', '51994591965'),
(10, 'Şakir', 3, 7, 'Merve', 'Korkmaz', '53875121114'),
(11, 'Garip', 8, 2, 'Mesut', 'Güneri', '50001745689'),
(12, 'Rıfkı', 5, 2, 'Ali', 'Maraz', '50902819806'),
(13, 'Pastel', 4, 7, 'Mustafa', 'Nakışlı', '50021863120'),
(14, 'Suşi', 19, 3, 'Ömercan', 'Bilveran', '52840355347'),
(15, 'Pulsar', 3, 2, 'Emre', 'Aydın', '52422213643'),
(16, 'Beyazsaray', 17, 5, 'Selahattin', 'Korkmaz', '52160206693'),
(17, 'Sarıkız', 9, 8, 'Mehmet', 'Karahanlı', '52316715343'),
(18, 'Bold Pilot', 12, 5, 'Halis', 'Karataş', '53237621168'),
(19, 'Kehribar', 1, 9, 'Hüseyin', 'Avcı', '50734971770'),
(20, 'Max', 4, 6, 'Aslı', 'Enver', '54026210828'),
(21, 'Jack', 25, 3, 'Hamit', 'Altıntop', '50763141488'),
(22, 'Pamuk', 7, 4, 'Arda', 'Turan', '52826016801'),
(23, 'Karabaş', 11, 2, 'Aslan', 'Akbey', '50079534917'),
(24, 'Dayı', 6, 1, 'Abbas', 'Ustaoğlu', '54127107822'),
(25, 'Limon', 29, 7, 'Ali', 'Candan', '53086983187'),
(26, 'Tosun', 18, 8, 'Elif', 'Eylül', '52231485000'),
(27, 'Honey', 12, 2, 'Eyşan', 'Tezcan', '51387185308'),
(28, 'Dayı', 5, 1, 'Ramiz', 'Karaeski', '53412029414'),
(29, 'Duman', 7, 2, 'Refik', 'Aydın', '53299615301'),
(30, 'Karakız', 20, 8, 'Hatice', 'Mercan', '50524006236'),
(31, 'Gülbatur', 3, 5, 'Ömer', 'Uçar', '54524006236'),
(32, 'Bulut', 1, 6, 'Ezel', 'Bayraktar', '54527006236'),
(33, 'Gölge', 4, 1, 'Zeynep', 'Kaya', '54346577122'),
(35, 'Gölge', 3, 1, 'Ali', 'Dursun', '54374984362');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `hayvan_asi`
--

DROP TABLE IF EXISTS `hayvan_asi`;
CREATE TABLE IF NOT EXISTS `hayvan_asi` (
  `hayvan_id` int(11) DEFAULT NULL,
  `asi_id` int(11) DEFAULT NULL,
  KEY `hayvan_id` (`hayvan_id`,`asi_id`),
  KEY `asi_hayvan` (`asi_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `hayvan_asi`
--

INSERT INTO `hayvan_asi` (`hayvan_id`, `asi_id`) VALUES
(1, 2),
(1, 9),
(2, 3),
(2, 7),
(3, 4),
(4, 3),
(4, 4),
(4, 9),
(5, 8),
(6, NULL),
(7, 9),
(8, NULL),
(9, 7),
(10, NULL),
(11, 9),
(12, NULL),
(13, NULL),
(14, NULL),
(15, 2),
(16, 4),
(17, 10),
(18, NULL),
(19, 7),
(20, 5),
(21, NULL),
(22, 10),
(23, 5),
(23, 6),
(24, NULL),
(25, NULL),
(26, 10),
(27, NULL),
(28, NULL),
(29, NULL),
(30, 1),
(31, 1),
(32, 1),
(33, NULL);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `hayvan_hastalik`
--

DROP TABLE IF EXISTS `hayvan_hastalik`;
CREATE TABLE IF NOT EXISTS `hayvan_hastalik` (
  `hayvan_id` int(11) DEFAULT NULL,
  `hastalik_id` int(11) DEFAULT NULL,
  KEY `hayvan_id` (`hayvan_id`,`hastalik_id`),
  KEY `hastalik_hayvan` (`hastalik_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `hayvan_hastalik`
--

INSERT INTO `hayvan_hastalik` (`hayvan_id`, `hastalik_id`) VALUES
(1, NULL),
(2, NULL),
(3, NULL),
(4, NULL),
(5, NULL),
(6, 5),
(7, NULL),
(8, 2),
(8, 6),
(9, NULL),
(10, 4),
(11, NULL),
(12, 1),
(13, 2),
(14, 2),
(15, NULL),
(16, NULL),
(17, 5),
(18, 6),
(20, 2),
(21, 8),
(22, NULL),
(23, 1),
(24, 4),
(25, 7),
(26, 6),
(27, 5),
(28, 6),
(29, 3),
(29, 7),
(30, NULL),
(31, NULL),
(32, NULL),
(33, NULL);

-- --------------------------------------------------------

--
-- Görünüm yapısı durumu `kediler`
-- (Asıl görünüm için aşağıya bakın)
--
DROP VIEW IF EXISTS `kediler`;
CREATE TABLE IF NOT EXISTS `kediler` (
`hayvan_id` int(11)
,`hayvan_ad` varchar(50)
,`hayvan_yas` int(2)
);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `turler`
--

DROP TABLE IF EXISTS `turler`;
CREATE TABLE IF NOT EXISTS `turler` (
  `tur_id` int(11) NOT NULL AUTO_INCREMENT,
  `tur_ad` varchar(50) COLLATE utf8_turkish_ci NOT NULL,
  PRIMARY KEY (`tur_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `turler`
--

INSERT INTO `turler` (`tur_id`, `tur_ad`) VALUES
(1, 'Kedi'),
(2, 'Köpek'),
(3, 'Kaplumbağa'),
(4, 'Koyun'),
(5, 'At'),
(6, 'Tavşan'),
(7, 'Kuş'),
(8, 'İnek'),
(9, 'Keçi');

-- --------------------------------------------------------

--
-- Görünüm yapısı `kediler`
--
DROP TABLE IF EXISTS `kediler`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `kediler`  AS SELECT `hayvanlar`.`hayvan_id` AS `hayvan_id`, `hayvanlar`.`hayvan_ad` AS `hayvan_ad`, `hayvanlar`.`hayvan_yas` AS `hayvan_yas` FROM (`hayvanlar` join `turler`) WHERE ((`hayvanlar`.`tur_id` = `turler`.`tur_id`) AND (`turler`.`tur_id` = 1)) ;

--
-- Dökümü yapılmış tablolar için kısıtlamalar
--

--
-- Tablo kısıtlamaları `hayvanlar`
--
ALTER TABLE `hayvanlar`
  ADD CONSTRAINT `tur` FOREIGN KEY (`tur_id`) REFERENCES `turler` (`tur_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Tablo kısıtlamaları `hayvan_asi`
--
ALTER TABLE `hayvan_asi`
  ADD CONSTRAINT `asi_hayvan` FOREIGN KEY (`asi_id`) REFERENCES `asilar` (`asi_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `hayvan_asi_ibfk_1` FOREIGN KEY (`hayvan_id`) REFERENCES `hayvanlar` (`hayvan_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Tablo kısıtlamaları `hayvan_hastalik`
--
ALTER TABLE `hayvan_hastalik`
  ADD CONSTRAINT `hastalik_hayvan` FOREIGN KEY (`hastalik_id`) REFERENCES `hastalik` (`hastalik_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `hayvan_hastalik_ibfk_1` FOREIGN KEY (`hayvan_id`) REFERENCES `hayvanlar` (`hayvan_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
