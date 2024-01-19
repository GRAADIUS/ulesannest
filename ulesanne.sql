-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Loomise aeg: Jaan 19, 2024 kell 08:46 EL
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
(5, 30, 'A251', 'hasti', 7),
(6, 25, 'A342', 'hasti', 6);

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
(7, '2024-01-19', 'Insert', '5, 30, A251, hasti, 7'),
(8, '2024-01-19', 'Insert', '6, 25, A342, hasti, 6'),
(9, '2024-01-19', 'Insert', '7, 40, A552, hasti, 8'),
(10, '2024-01-19', 'Delete', '7, 40, A552, hasti, 8');

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `seanssinimed`
--

CREATE TABLE `seanssinimed` (
  `id` int(11) NOT NULL,
  `seanssinimi` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `seanssinimed`
--

INSERT INTO `seanssinimed` (`id`, `seanssinimi`) VALUES
(2, 'root@localhost'),
(3, 'root@localhost'),
(4, 'root@localhost');

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
(6, 'Vene keel', 'Vene'),
(7, 'matemaatika', 'Vene'),
(8, 'Füüsika', 'Vene');

--
-- Päästikud `õppeaine`
--
DELIMITER $$
CREATE TRIGGER `trg_õppeaine_insert_update` AFTER INSERT ON `õppeaine` FOR EACH ROW INSERT INTO `seanssinimed` (`seanssinimi`) VALUES (USER()) 
ON DUPLICATE KEY UPDATE `seanssinimi` = USER()
$$
DELIMITER ;

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
-- Indeksid tabelile `seanssinimed`
--
ALTER TABLE `seanssinimed`
  ADD PRIMARY KEY (`id`);

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
  MODIFY `klass_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT tabelile `logi`
--
ALTER TABLE `logi`
  MODIFY `logi_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT tabelile `seanssinimed`
--
ALTER TABLE `seanssinimed`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT tabelile `õppeaine`
--
ALTER TABLE `õppeaine`
  MODIFY `oppeaine_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

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
