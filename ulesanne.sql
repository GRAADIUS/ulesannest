-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Loomise aeg: Jaan 17, 2024 kell 03:45 PL
-- Serveri versioon: 10.4.27-MariaDB
-- PHP versioon: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Andmebaas: `ulesanne`
--

DELIMITER $$
--
-- Toimingud
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete` (IN `id` INT)   DELETE FROM klass WHERE klass_id = id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert` (IN `mahutavus` INT, IN `korpus` VARCHAR(5), IN `olek` VARCHAR(30), IN `oppeaine` INT)   insert into klass(mahutavus, korpus, olek, oppeaine) VALUES (mahutavus, korpus, olek, oppeaine)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `select on oppeaine` (IN `oppeaine_` INT)   SELECT * from klass where oppeaine = oppeaine_$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `klass`
--

CREATE TABLE `klass` (
  `klass_id` int(11) NOT NULL,
  `mahutavus` int(11) DEFAULT NULL,
  `korpus` varchar(5) DEFAULT NULL,
  `olek` varchar(30) DEFAULT NULL,
  `oppeaine` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `klass`
--

INSERT INTO `klass` (`klass_id`, `mahutavus`, `korpus`, `olek`, `oppeaine`) VALUES
(4, 0, '[valu', '[value-4]', 2);

--
-- Päästikud `klass`
--
DELIMITER $$
CREATE TRIGGER `delete` BEFORE DELETE ON `klass` FOR EACH ROW insert into logi(kuupäev, toiming, andmed) 
VALUES(NOW(), 'Delete', CONCAT(old.klass_id, ', ', old.mahutavus, ', ', old.korpus, ', ', old.olek, ', ', old.oppeaine))
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `insert` AFTER INSERT ON `klass` FOR EACH ROW insert into logi(kuupäev, toiming, andmed) 
VALUES(NOW(), 'Insert', CONCAT(NEW.klass_id, ', ', NEW.mahutavus, ', ', NEW.korpus, ', ', NEW.olek, ', ', NEW.oppeaine))
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `logi`
--

CREATE TABLE `logi` (
  `logi_id` int(11) NOT NULL,
  `kuupäev` date DEFAULT NULL,
  `toiming` varchar(20) DEFAULT NULL,
  `andmed` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `logi`
--

INSERT INTO `logi` (`logi_id`, `kuupäev`, `toiming`, `andmed`) VALUES
(1, '2024-01-17', 'Insert', '2, 0, [valu, [value-4], 1'),
(2, '2024-01-17', 'Delete', '2, 0, [valu, [value-4], 1'),
(3, '2024-01-17', 'Insert', '3, 1, qwe, qwe, 1'),
(4, '2024-01-17', 'Insert', '4, 0, [valu, [value-4], 2'),
(5, '2024-01-17', 'Delete', '3, 1, qwe, qwe, 1');

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `õppeaine`
--

CREATE TABLE `õppeaine` (
  `oppeaine_id` int(11) NOT NULL,
  `nimetus` varchar(30) DEFAULT NULL,
  `oppekeel` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `õppeaine`
--

INSERT INTO `õppeaine` (`oppeaine_id`, `nimetus`, `oppekeel`) VALUES
(1, '[value-2]', '[value-3]'),
(2, '[value-2]', '[value-3]');

--
-- Indeksid tõmmistatud tabelitele
--

--
-- Indeksid tabelile `klass`
--
ALTER TABLE `klass`
  ADD PRIMARY KEY (`klass_id`),
  ADD KEY `õppeaine` (`oppeaine`);

--
-- Indeksid tabelile `logi`
--
ALTER TABLE `logi`
  ADD PRIMARY KEY (`logi_id`);

--
-- Indeksid tabelile `õppeaine`
--
ALTER TABLE `õppeaine`
  ADD PRIMARY KEY (`oppeaine_id`);

--
-- AUTO_INCREMENT tõmmistatud tabelitele
--

--
-- AUTO_INCREMENT tabelile `klass`
--
ALTER TABLE `klass`
  MODIFY `klass_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT tabelile `logi`
--
ALTER TABLE `logi`
  MODIFY `logi_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT tabelile `õppeaine`
--
ALTER TABLE `õppeaine`
  MODIFY `oppeaine_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Tõmmistatud tabelite piirangud
--

--
-- Piirangud tabelile `klass`
--
ALTER TABLE `klass`
  ADD CONSTRAINT `klass_ibfk_1` FOREIGN KEY (`oppeaine`) REFERENCES `õppeaine` (`oppeaine_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
