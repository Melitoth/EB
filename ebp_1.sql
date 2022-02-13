-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2022. Feb 07. 22:35
-- Kiszolgáló verziója: 10.4.21-MariaDB
-- PHP verzió: 8.0.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Adatbázis: `ebp_1`
--

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `kutya`
--

CREATE TABLE `kutya` (
  `SORSZAM` int(11) NOT NULL,
  `NEV` varchar(20) COLLATE utf8_hungarian_ci NOT NULL,
  `NEME` varchar(15) COLLATE utf8_hungarian_ci NOT NULL,
  `SZUL_DATUM` varchar(10) COLLATE utf8_hungarian_ci NOT NULL,
  `BEKER_DATUM` date NOT NULL,
  `MERET` varchar(10) COLLATE utf8_hungarian_ci NOT NULL,
  `SZORHOSSZ` varchar(10) COLLATE utf8_hungarian_ci NOT NULL,
  `KOR` varchar(10) COLLATE utf8_hungarian_ci NOT NULL,
  `JELLEMZES` text COLLATE utf8_hungarian_ci NOT NULL,
  `KEP` text COLLATE utf8_hungarian_ci NOT NULL,
  `REG_MENH_USER` varchar(30) COLLATE utf8_hungarian_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `mentett`
--

CREATE TABLE `mentett` (
  `SORSZAM` int(11) NOT NULL,
  `REG_GAZD_USER` varchar(30) COLLATE utf8_hungarian_ci NOT NULL,
  `REG_MEN_USER` varchar(30) COLLATE utf8_hungarian_ci NOT NULL,
  `KUTYA_SORSZ` int(11) NOT NULL,
  `MENTETT` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `reg_gazdi`
--

CREATE TABLE `reg_gazdi` (
  `SORSZ` int(11) NOT NULL,
  `SZP_GAZDI` varchar(6) COLLATE utf8_hungarian_ci NOT NULL,
  `NAME` varchar(30) COLLATE utf8_hungarian_ci NOT NULL,
  `USERNAME` varchar(15) COLLATE utf8_hungarian_ci NOT NULL,
  `EMAIL` varchar(30) COLLATE utf8_hungarian_ci NOT NULL,
  `PASSWORD` varchar(20) COLLATE utf8_hungarian_ci NOT NULL,
  `VAROS` varchar(30) COLLATE utf8_hungarian_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `reg_menhely`
--

CREATE TABLE `reg_menhely` (
  `SORSZAM` int(11) NOT NULL,
  `SZP_MENHELY` varchar(11) COLLATE utf8_hungarian_ci NOT NULL,
  `NAME` varchar(50) COLLATE utf8_hungarian_ci NOT NULL,
  `USERNAME` varchar(15) COLLATE utf8_hungarian_ci NOT NULL,
  `EMAIL` varchar(30) COLLATE utf8_hungarian_ci NOT NULL,
  `PASSWORD` varchar(15) COLLATE utf8_hungarian_ci NOT NULL,
  `ADOSZAM` int(20) NOT NULL,
  `SZLA_SZAM` int(26) NOT NULL,
  `WEBLINK` varchar(100) COLLATE utf8_hungarian_ci NOT NULL,
  `VAROS` varchar(30) COLLATE utf8_hungarian_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `kutya`
--
ALTER TABLE `kutya`
  ADD PRIMARY KEY (`SORSZAM`),
  ADD KEY `REG_MENH_USER` (`REG_MENH_USER`);

--
-- A tábla indexei `mentett`
--
ALTER TABLE `mentett`
  ADD PRIMARY KEY (`SORSZAM`),
  ADD KEY `KUTYA_SORSZ` (`KUTYA_SORSZ`),
  ADD KEY `REG_GAZD_USER` (`REG_GAZD_USER`),
  ADD KEY `REG_MEN_USER` (`REG_MEN_USER`);

--
-- A tábla indexei `reg_gazdi`
--
ALTER TABLE `reg_gazdi`
  ADD PRIMARY KEY (`SORSZ`),
  ADD UNIQUE KEY `USERNAME_2` (`USERNAME`),
  ADD KEY `USERNAME` (`USERNAME`);

--
-- A tábla indexei `reg_menhely`
--
ALTER TABLE `reg_menhely`
  ADD PRIMARY KEY (`SORSZAM`),
  ADD UNIQUE KEY `USERNAME_2` (`USERNAME`),
  ADD KEY `USERNAME` (`USERNAME`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `kutya`
--
ALTER TABLE `kutya`
  MODIFY `SORSZAM` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `mentett`
--
ALTER TABLE `mentett`
  MODIFY `SORSZAM` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `reg_gazdi`
--
ALTER TABLE `reg_gazdi`
  MODIFY `SORSZ` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `reg_menhely`
--
ALTER TABLE `reg_menhely`
  MODIFY `SORSZAM` int(11) NOT NULL AUTO_INCREMENT;

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `kutya`
--
ALTER TABLE `kutya`
  ADD CONSTRAINT `kutya_ibfk_1` FOREIGN KEY (`REG_MENH_USER`) REFERENCES `reg_menhely` (`USERNAME`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Megkötések a táblához `mentett`
--
ALTER TABLE `mentett`
  ADD CONSTRAINT `mentett_ibfk_1` FOREIGN KEY (`KUTYA_SORSZ`) REFERENCES `kutya` (`SORSZAM`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mentett_ibfk_2` FOREIGN KEY (`REG_GAZD_USER`) REFERENCES `reg_gazdi` (`USERNAME`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mentett_ibfk_3` FOREIGN KEY (`REG_MEN_USER`) REFERENCES `reg_menhely` (`USERNAME`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
