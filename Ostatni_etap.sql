SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;
-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8mb4 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table Dzial
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Dzial` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Dzial` (
  `id_dzial` CHAR(2) NOT NULL,
  `nazwa_dzialu` ENUM('letni damski', 'zimowy damski', 'letni meski', 'zimowy meski') CHARACTER SET 'utf8' COLLATE 'utf8_polish_ci' NOT NULL,
  PRIMARY KEY (`id_dzial`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_polish_ci;


-- -----------------------------------------------------
-- Table `mydb`.`Faktura`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Faktura` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Faktura` (
  `id_faktura` INT NOT NULL AUTO_INCREMENT,
  `id_produkt` INT NOT NULL,
  `id_zamowienie` INT NOT NULL,
  `data_sprzedazy` DATETIME NOT NULL,
  `wartosc_brutto` DECIMAL(10,2) NOT NULL,
  `wartosc_netto` DECIMAL(10,2) NOT NULL,
  `wartosc_vat` DECIMAL(10,2) NOT NULL,
  `nazwa_banku` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_polish_ci' NOT NULL,
  `forma_platnosci` VARCHAR(30) CHARACTER SET 'utf8' COLLATE 'utf8_polish_ci' NOT NULL,
  PRIMARY KEY (`id_faktura`),
  CONSTRAINT `fk_Faktura_Zamowienia1`
    FOREIGN KEY (`id_zamowienie`)
    REFERENCES `mydb`.`zamowienia` (`id_zamowienie`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
CONSTRAINT `fk_Faktura_Produkty1`
    FOREIGN KEY (`id_produkt`)
    REFERENCES Produkty (`id_produkt`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_polish_ci;

CREATE INDEX `fk_Faktura_Klienci1_idx` ON `mydb`.`Faktura` (`id_zamowienie` ASC) VISIBLE;
CREATE INDEX `fk_Faktura_Produkty1` ON `mydb`.`Faktura` (`id_produkt` ASC) VISIBLE;

-- -----------------------------------------------------
-- Table Kategoria
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Kategoria` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Kategoria`(
  `id_kategoria` CHAR(3) NOT NULL,
  `id_dzial` CHAR(2) NOT NULL,
  `id_rodzaj` INT NOT NULL,
  PRIMARY KEY (`id_kategoria`),
  CONSTRAINT `fk_Kategoria_Dzial`
    FOREIGN KEY (`id_dzial`)
    REFERENCES Dzial (`id_dzial`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Kategoria_Rodzaj1`
    FOREIGN KEY (`id_rodzaj`)
    REFERENCES Rodzaj (`id_rodzaj`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_polish_ci;

CREATE INDEX `id_dzial` ON `mydb`.`Kategoria` (`id_dzial` ASC) VISIBLE;

CREATE INDEX `id_rodzaj` ON `mydb`.`Kategoria` (`id_rodzaj` ASC) VISIBLE;

-- -----------------------------------------------------
-- Table `mydb`.`Klienci`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Klienci` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Klienci` (
  `id_klient` INT NOT NULL AUTO_INCREMENT,
  `id_kontakt` INT NOT NULL,
  `imie` VARCHAR(20) CHARACTER SET 'utf8' COLLATE 'utf8_polish_ci' NOT NULL,
  `nazwisko` VARCHAR(20) CHARACTER SET 'utf8' COLLATE 'utf8_polish_ci' NOT NULL,
  `login` VARCHAR(20) CHARACTER SET 'utf8' COLLATE 'utf8_polish_ci' NOT NULL,
  `haslo` VARCHAR(10) CHARACTER SET 'utf8' COLLATE 'utf8_polish_ci' NOT NULL,
  `ostatnie_logowanie` DATETIME NOT NULL,
  `rodzaj_klienta` ENUM('OSOBA FIZYCZNA', 'FIRMA') CHARACTER SET 'utf8' COLLATE 'utf8_polish_ci' NOT NULL,
  `nazwa_firmy` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_polish_ci' NULL,
  `region` VARCHAR(10) CHARACTER SET 'utf8' COLLATE 'utf8_polish_ci' NULL,
  `nip` VARCHAR(10) CHARACTER SET 'utf8' COLLATE 'utf8_polish_ci' NULL,
  PRIMARY KEY (`id_klient`),
  CONSTRAINT `fk_Klienci_Kontakty1`
    FOREIGN KEY (`id_kontakt`)
    REFERENCES `mydb`.`Kontakty` (`id_kontakt`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_polish_ci;

CREATE INDEX `id_kontakt` ON `mydb`.`Klienci` (`id_kontakt` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `mydb`.`Kontakty`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Kontakty` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Kontakty` (
  `id_kontakt` INT NOT NULL AUTO_INCREMENT,
  `numer_telefonu` VARCHAR(20) CHARACTER SET 'utf8' COLLATE 'utf8_polish_ci' NOT NULL,
  `email` VARCHAR(40) CHARACTER SET 'utf8' COLLATE 'utf8_polish_ci' NOT NULL,
  `miejscowosc` VARCHAR(20) CHARACTER SET 'utf8' COLLATE 'utf8_polish_ci' NOT NULL,
  `powiat` VARCHAR(20) CHARACTER SET 'utf8' COLLATE 'utf8_polish_ci' NOT NULL,
  `wojewodztwo` VARCHAR(20) CHARACTER SET 'utf8' COLLATE 'utf8_polish_ci' NOT NULL,
  `kod_pocztowy` VARCHAR(6) CHARACTER SET 'utf8' COLLATE 'utf8_polish_ci' NOT NULL,
  `ulica` VARCHAR(20) CHARACTER SET 'utf8' COLLATE 'utf8_polish_ci' NOT NULL,
  `numer_domu` VARCHAR(10) CHARACTER SET 'utf8' COLLATE 'utf8_polish_ci' NOT NULL,
  `numer_lokalu` VARCHAR(10) CHARACTER SET 'utf8' COLLATE 'utf8_polish_ci' NULL,
  PRIMARY KEY (`id_kontakt`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_polish_ci;


-- -----------------------------------------------------
-- Table Model
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Model`;

CREATE TABLE IF NOT EXISTS `mydb`.`Model` (
  `id_model` INT NOT NULL AUTO_INCREMENT,
  `id_kategoria` CHAR(3) NOT NULL,
  `cena` DECIMAL(10,2) NOT NULL,
  `opis` LONGTEXT CHARACTER SET 'utf8' COLLATE 'utf8_polish_ci' NULL,
  PRIMARY KEY (`id_model`),
  CONSTRAINT `fk_Model_Kategoria1`
    FOREIGN KEY (`id_kategoria`)
    REFERENCES Kategoria (`id_kategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_polish_ci;

CREATE INDEX `id_kategoria` ON `mydb`.`Model` (`id_kategoria` ASC) INVISIBLE;


-- -----------------------------------------------------
-- Table `mydb`.`Pracownicy`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Pracownicy` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Pracownicy` (
  `id_pracownik` INT NOT NULL AUTO_INCREMENT,
  `id_kierownik` INT NULL,
  `id_kontakt` INT NOT NULL,
  `imie` VARCHAR(20) CHARACTER SET 'utf8' COLLATE 'utf8_polish_ci' NOT NULL,
  `nazwisko` VARCHAR(20) CHARACTER SET 'utf8' COLLATE 'utf8_polish_ci' NOT NULL,
  `login` VARCHAR(20) CHARACTER SET 'utf8' COLLATE 'utf8_polish_ci' NOT NULL,
  `haslo` VARCHAR(10) CHARACTER SET 'utf8' COLLATE 'utf8_polish_ci' NOT NULL,
  `uprawnienie` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_polish_ci' NOT NULL,
  `konto_aktywne` CHAR(3) NOT NULL,
  `pensja` INT NOT NULL,
  `data_zatrudnienia` DATETIME NOT NULL,
  `data_zwolnienia` DATETIME NULL,
  PRIMARY KEY (`id_pracownik`),
  CONSTRAINT `fk_Pracownicy_Kontakty1`
    FOREIGN KEY (`id_kontakt`)
    REFERENCES `mydb`.`Kontakty` (`id_kontakt`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pracownicy_Pracownicy1`
    FOREIGN KEY (`id_kierownik`)
    REFERENCES `mydb`.`Pracownicy` (`id_pracownik`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_polish_ci;

CREATE INDEX `id_kontakt` ON `mydb`.`Pracownicy` (`id_kontakt` ASC) VISIBLE;

CREATE INDEX `fk_Pracownicy_Pracownicy1_idx` ON `mydb`.`Pracownicy` (`id_kierownik` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table produkty
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`produkty`;

CREATE TABLE IF NOT EXISTS `mydb`.`produkty` (
  `id_produkt` INT NOT NULL AUTO_INCREMENT,
  `id_wyglad` INT NOT NULL,
  `rozmiar` ENUM('XS', 'S', 'M', 'L', 'XL', 'XXL') CHARACTER SET 'utf8' COLLATE 'utf8_polish_ci' DEFAULT 'XS',
  `liczba_sztuk` BIGINT DEFAULT 50,
  PRIMARY KEY (`id_produkt`),
  CONSTRAINT `fk_Produkty_Wyglad1`
    FOREIGN KEY (`id_wyglad`)
    REFERENCES Wyglad (`id_wyglad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_polish_ci;

-- -----------------------------------------------------
-- Table `mydb`.`Produkty_sprzedane`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Produkty_sprzedane` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Produkty_sprzedane` (
  `id_produkty_sprzedane` INT NOT NULL AUTO_INCREMENT,
  `id_produkt` INT not NULL,
  `id_faktura` INT NOT NULL,
  `cena_sprzedazy` DECIMAL(10,2) NOT NULL,
  `data_sprzedazy` DATETIME NOT NULL,
  PRIMARY KEY (`id_produkty_sprzedane`),
  CONSTRAINT `fk_Produkty_sprzedane_Produkt1`
    FOREIGN KEY (`id_produkt`)
    REFERENCES `mydb`.`Faktura` (`id_produkt`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Produkty_sprzedane_Faktura1`
    FOREIGN KEY (`id_faktura`)
    REFERENCES `mydb`.`Faktura` (`id_faktura`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_polish_ci;

CREATE INDEX `fk_Produkty_sprzedane_Faktura1_idx` ON `mydb`.`Produkty_sprzedane` (`id_faktura` ASC) VISIBLE;
CREATE INDEX `fk_Produkty_sprzedane_Produkt1_idx` ON `mydb`.`Produkty_sprzedane` (`id_produkt` ASC) VISIBLE;
-- -----------------------------------------------------
-- Table Rodzaj
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Rodzaj`;

CREATE TABLE IF NOT EXISTS `mydb`.`Rodzaj`(
  `id_rodzaj` INT NOT NULL AUTO_INCREMENT,
  `nazwa_rodzaju` VARCHAR(40) CHARACTER SET 'utf8' COLLATE 'utf8_polish_ci' NOT NULL,
  PRIMARY KEY (`id_rodzaj`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_polish_ci;


-- -----------------------------------------------------
-- Table `mydb`.`Szczegoly_zamowienia`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Szczegoly_zamowienia` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Szczegoly_zamowienia` (
  `id_szczegoly_zamowienia` INT NOT NULL AUTO_INCREMENT,
  `id_zamowienie` INT NOT NULL,
  `id_produkt` INT NOT NULL,
  PRIMARY KEY (`id_szczegoly_zamowienia`),
  CONSTRAINT `fk_Szczegoly_zamowienia_Zamowienia1`
    FOREIGN KEY (`id_zamowienie`)
    REFERENCES `mydb`.`Zamowienia` (`id_zamowienie`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Szczegoly_zamowienia_Produkty1`
    FOREIGN KEY (`id_produkt`)
    REFERENCES produkty (`id_produkt`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_polish_ci;

CREATE INDEX `id_zamowienie` ON `mydb`.`Szczegoly_zamowienia` (`id_zamowienie` ASC) VISIBLE;

CREATE INDEX `id_produkt` ON `mydb`.`Szczegoly_zamowienia` (`id_produkt` ASC) VISIBLE;

-- -----------------------------------------------------
-- Table Wyglad
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Wyglad`;

CREATE TABLE IF NOT EXISTS `mydb`.`Wyglad`(
  `id_wyglad` INT NOT NULL AUTO_INCREMENT,
  `id_model` INT NOT NULL,
  `kolor` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_polish_ci' NOT NULL,
  `nazwa_zdjecia` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_polish_ci' NULL,
  PRIMARY KEY (`id_wyglad`),
  CONSTRAINT `fk_Wyglad_Model1`
    FOREIGN KEY (`id_model`)
    REFERENCES Model (`id_model`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_polish_ci;

CREATE INDEX `id_model` ON `mydb`.`Wyglad` (`id_model` ASC) VISIBLE;

-- -----------------------------------------------------
-- Table `mydb`.`Zamowienia`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Zamowienia` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Zamowienia` (
  `id_zamowienie` INT NOT NULL AUTO_INCREMENT,
  `id_klient` INT,
  `status` ENUM('ZŁOZONO', 'PRZYJETO', 'WYSLANO', 'ZREALIZOWANO') CHARACTER SET 'utf8' COLLATE 'utf8_polish_ci' NOT NULL,
  `data_zlozenia` DATETIME NOT NULL,
  `czy_zaplacono` CHAR(3) NOT NULL,
  `data_przyjecia` DATETIME NULL,
  `data_wysylki` DATETIME NULL,
  `data_realizacji` DATETIME NULL,
  PRIMARY KEY (`id_zamowienie`),
  CONSTRAINT `fk_Zamowienia_Klienci1`
    FOREIGN KEY (`id_klient`)
    REFERENCES `mydb`.`Klienci` (`id_klient`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_polish_ci;

CREATE INDEX `id_klient` ON `mydb`.`Zamowienia` (`id_klient` ASC) VISIBLE;

SET SQL_MODE = '';
DROP USER IF EXISTS user1;
SET SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
CREATE USER 'user1';


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
SET GLOBAL log_bin_trust_function_creators = 1;
-- -----------------------------------------------------
-- `Widok Produkty`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `View_Produkt`;
CREATE VIEW `View_Produkt` AS 
	SELECT `id_produkt`, Wyglad.id_wyglad, `rozmiar`, `liczba_sztuk`, `kolor`, `cena`,
			`opis`, `nazwa_dzialu`, `nazwa_rodzaju`
	FROM produkty
    JOIN wyglad ON produkty.id_wyglad = wyglad.id_wyglad
    JOIN model ON model.id_model = wyglad.id_model
	JOIN kategoria ON kategoria.id_kategoria = model.id_kategoria
    JOIN rodzaj ON kategoria.id_rodzaj = rodzaj.id_rodzaj 
    JOIN dzial ON dzial.id_dzial = kategoria.id_dzial;
-- -----------------------------------------------------
-- `Widok Zamowienie`
-- -----------------------------------------------------   
DROP VIEW IF EXISTS `View_Zamowienie`;
CREATE VIEW `View_Zamowienie` AS
	SELECT `id_zamowienie`, `imie`, `nazwisko`, `rodzaj_klienta`, `status`, `data_zlozenia`, `czy_zaplacono`
	FROM `Zamowienia`
    JOIN `klienci` ON Zamowienia.id_klient = klienci.id_klient;
 -- -----------------------------------------------------
-- `Widok Klient`
-- -----------------------------------------------------  
DROP VIEW IF EXISTS `View_Klient`;
CREATE VIEW `View_Klient` AS
	SELECT `id_klient`, `imie`, `nazwisko`, `rodzaj_klienta`, `ostatnie_logowanie`, `numer_telefonu`, `email`
	FROM `Klienci`
    JOIN `Kontakty` ON Klienci.id_kontakt = Kontakty.id_kontakt;
  
-- -----------------------------------------------------
-- `Widok Pracownik`
-- -----------------------------------------------------  
DROP VIEW IF EXISTS `View_Pracownik`;
CREATE VIEW `View_Pracownik` AS
	SELECT `id_pracownik`, `id_kierownik`, `imie`, `nazwisko`, `uprawnienie`,
		   `konto_aktywne`, `pensja`, `data_zatrudnienia`
	FROM `Pracownicy`
    JOIN `Kontakty` ON Pracownicy.id_kontakt = Kontakty.id_kontakt;
-- -----------------------------------------------------
-- `Widok Produkt_sprzedany`
-- -----------------------------------------------------  
DROP VIEW IF EXISTS `View_Produkt_sprzedany`;
CREATE VIEW `View_Produkt_sprzedany` AS
	SELECT Produkty.id_produkt, `rozmiar`, `kolor`, `cena`, `opis`, `nazwa_dzialu`, `nazwa_rodzaju`, `cena_sprzedazy`,
		   Produkty_sprzedane.data_sprzedazy
	FROM `produkty_sprzedane`
    JOIN `Faktura` USING (id_faktura)
    JOIN `Produkty` ON produkty.id_produkt = faktura.id_produkt
    JOIN `Wyglad` ON wyglad.id_wyglad = produkty.id_wyglad
    JOIN `Model` ON wyglad.id_model = model.id_model
    JOIN `Kategoria` ON model.id_kategoria = kategoria.id_kategoria
    JOIN `Rodzaj` ON kategoria.id_rodzaj = rodzaj.id_rodzaj
    JOIN `Dzial` ON dzial.id_dzial = kategoria.id_dzial;

-- -----------------------------------------------------
-- `Wyzwalacz usuniecie_konta_klienta`
-- -----------------------------------------------------
DROP TRIGGER IF EXISTS `usuniecie_konta_klienta`;
delimiter //
CREATE TRIGGER usuniecie_konta_klienta
AFTER DELETE ON `klienci`
FOR EACH ROW
	BEGIN 
	DELETE FROM `Kontakty` WHERE id_kontakt = old.id_kontakt;
    UPDATE `Zamowienia` SET id_klient = NULL;
	END
	//
-- -----------------------------------------------------
-- `Wyzwalacz usuniecie_konta_pracownika`
-- -----------------------------------------------------
DROP TRIGGER IF EXISTS `usuniecie_konta_pracownika`;
delimiter //
CREATE TRIGGER `usuniecie_konta_pracownika`
AFTER DELETE ON `pracownicy`
FOR EACH ROW
	BEGIN 
	DELETE FROM `Kontakty` WHERE id_kontakt = old.id_kontakt;
	END
	//

-- -----------------------------------------------------
-- `Wyzwalacz sprzedaz_produktu`
-- -----------------------------------------------------
DROP TRIGGER IF EXISTS `sprzedaz_produktu`;
delimiter //
CREATE TRIGGER `sprzedaz_produktu`
AFTER INSERT ON `produkty_sprzedane`
FOR EACH ROW
	BEGIN 
	UPDATE `Produkty` SET liczba_sztuk = liczba_sztuk - 1 WHERE id_produkt = new.id_produkt;
	END
	//

SET GLOBAL log_bin_trust_function_creators = 1;
-- -----------------------------------------------------
-- `Funkcja dochod`
-- -----------------------------------------------------
DROP FUNCTION IF EXISTS `dochod`;
delimiter //
CREATE FUNCTION dochod() RETURNS DECIMAL(10,2)
	BEGIN
	RETURN (SELECT SUM(cena_sprzedazy) FROM produkty_sprzedane);
	END
	//

-- -----------------------------------------------------
-- `Funkcja stan magazynu`
-- -----------------------------------------------------
DROP FUNCTION IF EXISTS `stan_magazynu`;
delimiter //
CREATE FUNCTION stan_magazynu() RETURNS INT
	BEGIN
	RETURN (SELECT SUM(liczba_sztuk) FROM Produkty);
	END
	//
-- -----------------------------------------------------
-- `Funkcja vat`
-- -----------------------------------------------------
DROP FUNCTION IF EXISTS `vat`;
delimiter //
CREATE FUNCTION vat(cena DECIMAL(10,2)) RETURNS DECIMAL(10,2)
	BEGIN
	RETURN 0.23 * cena;
	END
    //
-- -----------------------------------------------------
-- `Funkcja netto`
-- -----------------------------------------------------
DROP FUNCTION IF EXISTS `netto`;
delimiter //
CREATE FUNCTION netto(cena DECIMAL(10,2)) RETURNS DECIMAL(10,2)
	BEGIN
	RETURN 0.77 * cena;
	END
    //   
-- -----------------------------------------------------
-- `Funkcja srednie_zarobki`
-- -----------------------------------------------------
DROP FUNCTION IF EXISTS `srednie_zarobki`;
delimiter //
CREATE FUNCTION srednie_zarobki() RETURNS INT
	BEGIN
    DECLARE zarobki INT;
    SET zarobki = (SELECT AVG(pensja) FROM pracownicy);
	RETURN zarobki;
	END
    //   

-- -----------------------------------------------------
-- Data for table Dzial
-- -----------------------------------------------------
START TRANSACTION;

INSERT INTO Dzial (`id_dzial`, `nazwa_dzialu`) VALUES ('LD', 'letni damski');
INSERT INTO Dzial (`id_dzial`, `nazwa_dzialu`) VALUES ('ZD', 'zimowy damski');
INSERT INTO Dzial (`id_dzial`, `nazwa_dzialu`) VALUES ('LM', 'letni meski');
INSERT INTO Dzial (`id_dzial`, `nazwa_dzialu`) VALUES ('ZM', 'zimowy meski');

COMMIT;
-- -----------------------------------------------------
-- Data for table Rodzaj
-- -----------------------------------------------------
START TRANSACTION;

INSERT INTO Rodzaj (`id_rodzaj`, `nazwa_rodzaju`) VALUES (1, 'koszulka');
INSERT INTO Rodzaj (`id_rodzaj`, `nazwa_rodzaju`) VALUES (2, 'spodnie');
INSERT INTO Rodzaj (`id_rodzaj`, `nazwa_rodzaju`) VALUES (3, 'sukienka');
INSERT INTO Rodzaj (`id_rodzaj`, `nazwa_rodzaju`) VALUES (4, 'kurtka');
INSERT INTO Rodzaj (`id_rodzaj`, `nazwa_rodzaju`) VALUES (5, 'bluza');
INSERT INTO Rodzaj (`id_rodzaj`, `nazwa_rodzaju`) VALUES (6, 'sweter');
INSERT INTO Rodzaj (`id_rodzaj`, `nazwa_rodzaju`) VALUES (7, 'koszula');
INSERT INTO Rodzaj (`id_rodzaj`, `nazwa_rodzaju`) VALUES (8, 'spódnica');

COMMIT;

-- -----------------------------------------------------
-- Data for table Kategoria
-- -----------------------------------------------------
START TRANSACTION;

INSERT INTO Kategoria (`id_kategoria`, `id_dzial`, `id_rodzaj`) VALUES ('K1', 'LD', 1);
INSERT INTO Kategoria (`id_kategoria`, `id_dzial`, `id_rodzaj`) VALUES ('K2', 'LD', 2);
INSERT INTO Kategoria (`id_kategoria`, `id_dzial`, `id_rodzaj`) VALUES ('K3', 'LD', 3);
INSERT INTO Kategoria (`id_kategoria`, `id_dzial`, `id_rodzaj`) VALUES ('K4', 'LD', 4);
INSERT INTO Kategoria (`id_kategoria`, `id_dzial`, `id_rodzaj`) VALUES ('K5', 'LD', 5);
INSERT INTO Kategoria (`id_kategoria`, `id_dzial`, `id_rodzaj`) VALUES ('K6', 'LD', 7);
INSERT INTO Kategoria (`id_kategoria`, `id_dzial`, `id_rodzaj`) VALUES ('K7', 'LD', 8);
INSERT INTO Kategoria (`id_kategoria`, `id_dzial`, `id_rodzaj`) VALUES ('K8', 'ZD', 1);
INSERT INTO Kategoria (`id_kategoria`, `id_dzial`, `id_rodzaj`) VALUES ('K9', 'ZD', 2);
INSERT INTO Kategoria (`id_kategoria`, `id_dzial`, `id_rodzaj`) VALUES ('K10', 'ZD', 4);
INSERT INTO Kategoria (`id_kategoria`, `id_dzial`, `id_rodzaj`) VALUES ('K11', 'ZD', 5);
INSERT INTO Kategoria (`id_kategoria`, `id_dzial`, `id_rodzaj`) VALUES ('K12', 'ZD', 6);
INSERT INTO Kategoria (`id_kategoria`, `id_dzial`, `id_rodzaj`) VALUES ('K13', 'ZD', 7);
INSERT INTO Kategoria (`id_kategoria`, `id_dzial`, `id_rodzaj`) VALUES ('K14', 'LM', 1);
INSERT INTO Kategoria (`id_kategoria`, `id_dzial`, `id_rodzaj`) VALUES ('K15', 'LM', 2);
INSERT INTO Kategoria (`id_kategoria`, `id_dzial`, `id_rodzaj`) VALUES ('K16', 'LM', 4);
INSERT INTO Kategoria (`id_kategoria`, `id_dzial`, `id_rodzaj`) VALUES ('K17', 'LM', 5);
INSERT INTO Kategoria (`id_kategoria`, `id_dzial`, `id_rodzaj`) VALUES ('K18', 'LM', 7);
INSERT INTO Kategoria (`id_kategoria`, `id_dzial`, `id_rodzaj`) VALUES ('K19', 'ZM', 1);
INSERT INTO Kategoria (`id_kategoria`, `id_dzial`, `id_rodzaj`) VALUES ('K20', 'ZM', 2);
INSERT INTO Kategoria (`id_kategoria`, `id_dzial`, `id_rodzaj`) VALUES ('K21', 'ZM', 4);
INSERT INTO Kategoria (`id_kategoria`, `id_dzial`, `id_rodzaj`) VALUES ('K22', 'ZM', 5);
INSERT INTO Kategoria (`id_kategoria`, `id_dzial`, `id_rodzaj`) VALUES ('K23', 'ZM', 6);
INSERT INTO Kategoria (`id_kategoria`, `id_dzial`, `id_rodzaj`) VALUES ('K24', 'ZM', 7);

COMMIT;

-- -----------------------------------------------------
-- Data for table Model
-- -----------------------------------------------------
START TRANSACTION;

INSERT INTO Model (`id_model`, `id_kategoria`, `cena`, `opis`) VALUES (10, 'K1', 29.99, NULL);
INSERT INTO Model (`id_model`, `id_kategoria`, `cena`, `opis`) VALUES (11, 'K1', 45.99, NULL);
INSERT INTO Model (`id_model`, `id_kategoria`, `cena`, `opis`) VALUES (12, 'K1', 18.99, NULL);
INSERT INTO Model (`id_model`, `id_kategoria`, `cena`, `opis`) VALUES (20, 'K2', 79.90, NULL);
INSERT INTO Model (`id_model`, `id_kategoria`, `cena`, `opis`) VALUES (21, 'K2', 89.99, NULL);
INSERT INTO Model (`id_model`, `id_kategoria`, `cena`, `opis`) VALUES (22, 'K2', 99.90, NULL);
INSERT INTO Model (`id_model`, `id_kategoria`, `cena`, `opis`) VALUES (30, 'K3', 44.99, NULL);
INSERT INTO Model (`id_model`, `id_kategoria`, `cena`, `opis`) VALUES (31, 'K3', 59.50, NULL);
INSERT INTO Model (`id_model`, `id_kategoria`, `cena`, `opis`) VALUES (32, 'K3', 62.99, NULL);
INSERT INTO Model (`id_model`, `id_kategoria`, `cena`, `opis`) VALUES (40, 'K4', 79.50, NULL);
INSERT INTO Model (`id_model`, `id_kategoria`, `cena`, `opis`) VALUES (41, 'K4', 89.99, NULL);
INSERT INTO Model (`id_model`, `id_kategoria`, `cena`, `opis`) VALUES (42, 'K4', 59.50, NULL);
INSERT INTO Model (`id_model`, `id_kategoria`, `cena`, `opis`) VALUES (50, 'K5', 56.99, NULL);
INSERT INTO Model (`id_model`, `id_kategoria`, `cena`, `opis`) VALUES (51, 'K5', 99.99, NULL);
INSERT INTO Model (`id_model`, `id_kategoria`, `cena`, `opis`) VALUES (52, 'K5', 45.99, NULL);
INSERT INTO Model (`id_model`, `id_kategoria`, `cena`, `opis`) VALUES (60, 'K6', 59.99, NULL);
INSERT INTO Model (`id_model`, `id_kategoria`, `cena`, `opis`) VALUES (61, 'K6', 69.99, NULL);
INSERT INTO Model (`id_model`, `id_kategoria`, `cena`, `opis`) VALUES (62, 'K6', 79.99, NULL);
INSERT INTO Model (`id_model`, `id_kategoria`, `cena`, `opis`) VALUES (70, 'K7', 39.50, NULL);
INSERT INTO Model (`id_model`, `id_kategoria`, `cena`, `opis`) VALUES (71, 'K7', 29.99, NULL);
INSERT INTO Model (`id_model`, `id_kategoria`, `cena`, `opis`) VALUES (72, 'K7', 49.90, NULL);
INSERT INTO Model (`id_model`, `id_kategoria`, `cena`, `opis`) VALUES (80, 'K8', 18.99, NULL);
INSERT INTO Model (`id_model`, `id_kategoria`, `cena`, `opis`) VALUES (81, 'K8', 24.99, NULL);
INSERT INTO Model (`id_model`, `id_kategoria`, `cena`, `opis`) VALUES (82, 'K8', 37.50, NULL);
INSERT INTO Model (`id_model`, `id_kategoria`, `cena`, `opis`) VALUES (90, 'K9', 89.99, NULL);
INSERT INTO Model (`id_model`, `id_kategoria`, `cena`, `opis`) VALUES (91, 'K9', 99.99, NULL);
INSERT INTO Model (`id_model`, `id_kategoria`, `cena`, `opis`) VALUES (92, 'K9', 79.50, NULL);
INSERT INTO Model (`id_model`, `id_kategoria`, `cena`, `opis`) VALUES (100, 'K10', 249.99, NULL);
INSERT INTO Model (`id_model`, `id_kategoria`, `cena`, `opis`) VALUES (101, 'K10', 199.50, NULL);
INSERT INTO Model (`id_model`, `id_kategoria`, `cena`, `opis`) VALUES (102, 'K10', 299.99, NULL);
INSERT INTO Model (`id_model`, `id_kategoria`, `cena`, `opis`) VALUES (110, 'K11', 89.99, NULL);
INSERT INTO Model (`id_model`, `id_kategoria`, `cena`, `opis`) VALUES (111, 'K11', 65.50, NULL);
INSERT INTO Model (`id_model`, `id_kategoria`, `cena`, `opis`) VALUES (112, 'K11', 74.99, NULL);
INSERT INTO Model (`id_model`, `id_kategoria`, `cena`, `opis`) VALUES (120, 'K12', 69.99, NULL);
INSERT INTO Model (`id_model`, `id_kategoria`, `cena`, `opis`) VALUES (121, 'K12', 62.99, NULL);
INSERT INTO Model (`id_model`, `id_kategoria`, `cena`, `opis`) VALUES (122, 'K12', 75.50, NULL);
INSERT INTO Model (`id_model`, `id_kategoria`, `cena`, `opis`) VALUES (130, 'K13', 64.99, NULL);
INSERT INTO Model (`id_model`, `id_kategoria`, `cena`, `opis`) VALUES (131, 'K13', 68.99, NULL);
INSERT INTO Model (`id_model`, `id_kategoria`, `cena`, `opis`) VALUES (132, 'K13', 79.50, NULL);
INSERT INTO Model (`id_model`, `id_kategoria`, `cena`, `opis`) VALUES (140, 'K14', 19.90, NULL);
INSERT INTO Model (`id_model`, `id_kategoria`, `cena`, `opis`) VALUES (141, 'K14', 39.99, NULL);
INSERT INTO Model (`id_model`, `id_kategoria`, `cena`, `opis`) VALUES (142, 'K14', 24.99, NULL);
INSERT INTO Model (`id_model`, `id_kategoria`, `cena`, `opis`) VALUES (150, 'K15', 99.99, NULL);
INSERT INTO Model (`id_model`, `id_kategoria`, `cena`, `opis`) VALUES (151, 'K15', 89.99, NULL);
INSERT INTO Model (`id_model`, `id_kategoria`, `cena`, `opis`) VALUES (152, 'K15', 109.99, NULL);
INSERT INTO Model (`id_model`, `id_kategoria`, `cena`, `opis`) VALUES (160, 'K16', 104.99, NULL);
INSERT INTO Model (`id_model`, `id_kategoria`, `cena`, `opis`) VALUES (161, 'K16', 119.99, NULL);
INSERT INTO Model (`id_model`, `id_kategoria`, `cena`, `opis`) VALUES (162, 'K16', 79.99, NULL);
INSERT INTO Model (`id_model`, `id_kategoria`, `cena`, `opis`) VALUES (170, 'K17', 68.99, NULL);
INSERT INTO Model (`id_model`, `id_kategoria`, `cena`, `opis`) VALUES (171, 'K17', 99.99, NULL);
INSERT INTO Model (`id_model`, `id_kategoria`, `cena`, `opis`) VALUES (172, 'K17', 71.50, NULL);
INSERT INTO Model (`id_model`, `id_kategoria`, `cena`, `opis`) VALUES (180, 'K18', 64.99, NULL);
INSERT INTO Model (`id_model`, `id_kategoria`, `cena`, `opis`) VALUES (181, 'K18', 75.99, NULL);
INSERT INTO Model (`id_model`, `id_kategoria`, `cena`, `opis`) VALUES (182, 'K18', 89.99, NULL);
INSERT INTO Model (`id_model`, `id_kategoria`, `cena`, `opis`) VALUES (190, 'K19', 25.99, NULL);
INSERT INTO Model (`id_model`, `id_kategoria`, `cena`, `opis`) VALUES (191, 'K19', 15.99, NULL);
INSERT INTO Model (`id_model`, `id_kategoria`, `cena`, `opis`) VALUES (192, 'K19', 45.99, NULL);
INSERT INTO Model (`id_model`, `id_kategoria`, `cena`, `opis`) VALUES (200, 'K20', 89.50, NULL);
INSERT INTO Model (`id_model`, `id_kategoria`, `cena`, `opis`) VALUES (201, 'K20', 119.90, NULL);
INSERT INTO Model (`id_model`, `id_kategoria`, `cena`, `opis`) VALUES (202, 'K20', 79.99, NULL);
INSERT INTO Model (`id_model`, `id_kategoria`, `cena`, `opis`) VALUES (210, 'K21', 159.99, NULL);
INSERT INTO Model (`id_model`, `id_kategoria`, `cena`, `opis`) VALUES (211, 'K21', 189.99, NULL);
INSERT INTO Model (`id_model`, `id_kategoria`, `cena`, `opis`) VALUES (212, 'K21', 201.99, NULL);
INSERT INTO Model (`id_model`, `id_kategoria`, `cena`, `opis`) VALUES (220, 'K22', 89.99, NULL);
INSERT INTO Model (`id_model`, `id_kategoria`, `cena`, `opis`) VALUES (221, 'K22', 67.50, NULL);
INSERT INTO Model (`id_model`, `id_kategoria`, `cena`, `opis`) VALUES (222, 'K22', 58.90, NULL);
INSERT INTO Model (`id_model`, `id_kategoria`, `cena`, `opis`) VALUES (230, 'K23', 79.99, NULL);
INSERT INTO Model (`id_model`, `id_kategoria`, `cena`, `opis`) VALUES (231, 'K23', 75.99, NULL);
INSERT INTO Model (`id_model`, `id_kategoria`, `cena`, `opis`) VALUES (232, 'K23', 69.90, NULL);
INSERT INTO Model (`id_model`, `id_kategoria`, `cena`, `opis`) VALUES (240, 'K24', 67.99, NULL);
INSERT INTO Model (`id_model`, `id_kategoria`, `cena`, `opis`) VALUES (241, 'K24', 79.99, NULL);
INSERT INTO Model (`id_model`, `id_kategoria`, `cena`, `opis`) VALUES (242, 'K24', 86.50, NULL);

COMMIT;

START TRANSACTION;
-- -----------------------------------------------------
-- Data for table Wyglad
-- -----------------------------------------------------
START TRANSACTION;

INSERT INTO Wyglad (`id_model`, `kolor`, `nazwa_zdjecia`) VALUES (10, 'biały', NULL);
INSERT INTO Wyglad (`id_model`, `kolor`, `nazwa_zdjecia`) VALUES (11, 'czarny', NULL);
INSERT INTO Wyglad (`id_model`, `kolor`, `nazwa_zdjecia`) VALUES (12, 'biały', NULL);
INSERT INTO Wyglad (`id_model`, `kolor`, `nazwa_zdjecia`) VALUES (20, 'czerwony', NULL);
INSERT INTO Wyglad (`id_model`, `kolor`, `nazwa_zdjecia`) VALUES (21, 'czarny', NULL);
INSERT INTO Wyglad (`id_model`, `kolor`, `nazwa_zdjecia`) VALUES (22, 'granatowy', NULL);
INSERT INTO Wyglad (`id_model`, `kolor`, `nazwa_zdjecia`) VALUES (30, 'granatowy', NULL);
INSERT INTO Wyglad (`id_model`, `kolor`, `nazwa_zdjecia`) VALUES (31, 'biały', NULL);
INSERT INTO Wyglad (`id_model`, `kolor`, `nazwa_zdjecia`) VALUES (32, 'czarny', NULL);
INSERT INTO Wyglad (`id_model`, `kolor`, `nazwa_zdjecia`) VALUES (242, 'żółty', NULL);
INSERT INTO Wyglad (`id_model`, `kolor`, `nazwa_zdjecia`) VALUES (40, 'beżowy', NULL);
INSERT INTO Wyglad (`id_model`, `kolor`, `nazwa_zdjecia`) VALUES (41, 'biały', NULL);
INSERT INTO Wyglad (`id_model`, `kolor`, `nazwa_zdjecia`) VALUES (42, 'zielony', NULL);
INSERT INTO Wyglad (`id_model`, `kolor`, `nazwa_zdjecia`) VALUES (50, 'niebieski', NULL);
INSERT INTO Wyglad (`id_model`, `kolor`, `nazwa_zdjecia`) VALUES (51, 'czarny', NULL);
INSERT INTO Wyglad (`id_model`, `kolor`, `nazwa_zdjecia`) VALUES (52, 'beżowy', NULL);
INSERT INTO Wyglad (`id_model`, `kolor`, `nazwa_zdjecia`) VALUES (60, 'granatowy', NULL);
INSERT INTO Wyglad (`id_model`, `kolor`, `nazwa_zdjecia`) VALUES (61, 'czarny', NULL);
INSERT INTO Wyglad (`id_model`, `kolor`, `nazwa_zdjecia`) VALUES (62, 'czerwony', NULL);
INSERT INTO Wyglad (`id_model`, `kolor`, `nazwa_zdjecia`) VALUES (70, 'czarny', NULL);
INSERT INTO Wyglad (`id_model`, `kolor`, `nazwa_zdjecia`) VALUES (71, 'biały', NULL);
INSERT INTO Wyglad (`id_model`, `kolor`, `nazwa_zdjecia`) VALUES (72, 'żółty', NULL);
INSERT INTO Wyglad (`id_model`, `kolor`, `nazwa_zdjecia`) VALUES (80, 'granatowy', NULL);
INSERT INTO Wyglad (`id_model`, `kolor`, `nazwa_zdjecia`) VALUES (81, 'czarny', NULL);
INSERT INTO Wyglad (`id_model`, `kolor`, `nazwa_zdjecia`) VALUES (82, 'biały', NULL);
INSERT INTO Wyglad (`id_model`, `kolor`, `nazwa_zdjecia`) VALUES (90, 'czerwony', NULL);
INSERT INTO Wyglad (`id_model`, `kolor`, `nazwa_zdjecia`) VALUES (91, 'beżowy', NULL);
INSERT INTO Wyglad (`id_model`, `kolor`, `nazwa_zdjecia`) VALUES (92, 'czarny', NULL);
INSERT INTO Wyglad (`id_model`, `kolor`, `nazwa_zdjecia`) VALUES (100, 'beżowy', NULL);
INSERT INTO Wyglad (`id_model`, `kolor`, `nazwa_zdjecia`) VALUES (101, 'szary', NULL);
INSERT INTO Wyglad (`id_model`, `kolor`, `nazwa_zdjecia`) VALUES (102, 'czerwony', NULL);
INSERT INTO Wyglad (`id_model`, `kolor`, `nazwa_zdjecia`) VALUES (110, 'granatowy', NULL);
INSERT INTO Wyglad (`id_model`, `kolor`, `nazwa_zdjecia`) VALUES (111, 'żółty', NULL);
INSERT INTO Wyglad (`id_model`, `kolor`, `nazwa_zdjecia`) VALUES (112, 'czarny', NULL);
INSERT INTO Wyglad (`id_model`, `kolor`, `nazwa_zdjecia`) VALUES (120, 'zielony', NULL);
INSERT INTO Wyglad (`id_model`, `kolor`, `nazwa_zdjecia`) VALUES (121, 'zielony', NULL);
INSERT INTO Wyglad (`id_model`, `kolor`, `nazwa_zdjecia`) VALUES (122, 'beżowy', NULL);
INSERT INTO Wyglad (`id_model`, `kolor`, `nazwa_zdjecia`) VALUES (130, 'czerwony', NULL);
INSERT INTO Wyglad (`id_model`, `kolor`, `nazwa_zdjecia`) VALUES (131, 'czarny', NULL);
INSERT INTO Wyglad (`id_model`, `kolor`, `nazwa_zdjecia`) VALUES (132, 'biały', NULL);
INSERT INTO Wyglad (`id_model`, `kolor`, `nazwa_zdjecia`) VALUES (140, 'beżowy', NULL);
INSERT INTO Wyglad (`id_model`, `kolor`, `nazwa_zdjecia`) VALUES (141, 'granatowy', NULL);
INSERT INTO Wyglad (`id_model`, `kolor`, `nazwa_zdjecia`) VALUES (142, 'czarny', NULL);
INSERT INTO Wyglad (`id_model`, `kolor`, `nazwa_zdjecia`) VALUES (150, 'szary', NULL);
INSERT INTO Wyglad (`id_model`, `kolor`, `nazwa_zdjecia`) VALUES (151, 'żółty', NULL);
INSERT INTO Wyglad (`id_model`, `kolor`, `nazwa_zdjecia`) VALUES (152, 'czerwony', NULL);
INSERT INTO Wyglad (`id_model`, `kolor`, `nazwa_zdjecia`) VALUES (160, 'szary', NULL);
INSERT INTO Wyglad (`id_model`, `kolor`, `nazwa_zdjecia`) VALUES (161, 'szary', NULL);
INSERT INTO Wyglad (`id_model`, `kolor`, `nazwa_zdjecia`) VALUES (162, 'beżowy', NULL);
INSERT INTO Wyglad (`id_model`, `kolor`, `nazwa_zdjecia`) VALUES (170, 'czerwony', NULL);
INSERT INTO Wyglad (`id_model`, `kolor`, `nazwa_zdjecia`) VALUES (171, 'czarny', NULL);
INSERT INTO Wyglad (`id_model`, `kolor`, `nazwa_zdjecia`) VALUES (172, 'żółty', NULL);
INSERT INTO Wyglad (`id_model`, `kolor`, `nazwa_zdjecia`) VALUES (180, 'biały', NULL);
INSERT INTO Wyglad (`id_model`, `kolor`, `nazwa_zdjecia`) VALUES (181, 'zielony', NULL);
INSERT INTO Wyglad (`id_model`, `kolor`, `nazwa_zdjecia`) VALUES (182, 'zielony', NULL);
INSERT INTO Wyglad (`id_model`, `kolor`, `nazwa_zdjecia`) VALUES (190, 'granatowy', NULL);
INSERT INTO Wyglad (`id_model`, `kolor`, `nazwa_zdjecia`) VALUES (191, 'czarny', NULL);
INSERT INTO Wyglad (`id_model`, `kolor`, `nazwa_zdjecia`) VALUES (192, 'czarny', NULL);
INSERT INTO Wyglad (`id_model`, `kolor`, `nazwa_zdjecia`) VALUES (200, 'szary', NULL);
INSERT INTO Wyglad (`id_model`, `kolor`, `nazwa_zdjecia`) VALUES (201, 'beżowy', NULL);
INSERT INTO Wyglad (`id_model`, `kolor`, `nazwa_zdjecia`) VALUES (202, 'czarny', NULL);
INSERT INTO Wyglad (`id_model`, `kolor`, `nazwa_zdjecia`) VALUES (210, 'biały', NULL);
INSERT INTO Wyglad (`id_model`, `kolor`, `nazwa_zdjecia`) VALUES (211, 'szary', NULL);
INSERT INTO Wyglad (`id_model`, `kolor`, `nazwa_zdjecia`) VALUES (212, 'szary', NULL);
INSERT INTO Wyglad (`id_model`, `kolor`, `nazwa_zdjecia`) VALUES (220, 'beżowy', NULL);
INSERT INTO Wyglad (`id_model`, `kolor`, `nazwa_zdjecia`) VALUES (221, 'szary', NULL);
INSERT INTO Wyglad (`id_model`, `kolor`, `nazwa_zdjecia`) VALUES (222, 'szary', NULL);
INSERT INTO Wyglad (`id_model`, `kolor`, `nazwa_zdjecia`) VALUES (230, 'granatowy', NULL);
INSERT INTO Wyglad (`id_model`, `kolor`, `nazwa_zdjecia`) VALUES (231, 'beżowy', NULL);
INSERT INTO Wyglad (`id_model`, `kolor`, `nazwa_zdjecia`) VALUES (232, 'biały', NULL);
INSERT INTO Wyglad (`id_model`, `kolor`, `nazwa_zdjecia`) VALUES (240, 'biały', NULL);
INSERT INTO Wyglad (`id_model`, `kolor`, `nazwa_zdjecia`) VALUES (241, 'czarny', NULL);

COMMIT;

-- -----------------------------------------------------
-- Data for table produkty
-- -----------------------------------------------------

START TRANSACTION;

alter table produkty auto_increment = 1;
INSERT INTO produkty (`id_wyglad`) SELECT id_wyglad FROM Wyglad;
alter table produkty alter column `rozmiar` set default 'S';
INSERT INTO produkty (`id_wyglad`) SELECT id_wyglad FROM Wyglad;
alter table produkty alter column `rozmiar` set default 'M';
INSERT INTO produkty (`id_wyglad`) SELECT id_wyglad FROM Wyglad;
alter table produkty alter column `rozmiar` set default 'L';
INSERT INTO produkty (`id_wyglad`) SELECT id_wyglad FROM Wyglad;
alter table produkty alter column `rozmiar` set default 'XL';
INSERT INTO produkty (`id_wyglad`) SELECT id_wyglad FROM Wyglad;
alter table produkty alter column `rozmiar` set default 'XXL';
INSERT INTO produkty (`id_wyglad`) SELECT id_wyglad FROM Wyglad;
alter table produkty alter column `rozmiar` set default 'XS';
COMMIT;

-- -----------------------------------------------------
-- Data for table `mydb`.`Kontakty`
-- -----------------------------------------------------
START TRANSACTION;

INSERT INTO kontakty
(`id_kontakt`, `numer_telefonu`, `email`, `miejscowosc`, `powiat`, `wojewodztwo`, `kod_pocztowy`, `ulica`, `numer_domu`, `numer_lokalu`)
VALUES (1000, 523121121, 'albert.nowak@gmail.com', 'Radom', 'radomski', 'mazowieckie', '26-600', 'Żeromskiego', 50, 8);
INSERT INTO kontakty
(`numer_telefonu`, `email`, `miejscowosc`, `powiat`, `wojewodztwo`, `kod_pocztowy`, `ulica`, `numer_domu`, `numer_lokalu`)
VALUES (224127121, 'aleksandra.wisniewska@gmail.com', 'Bolesławiec', 'bolesławiecki', 'dolnośląskie', '59-700', 'Staszica', 12, 4);
INSERT INTO kontakty
(`numer_telefonu`, `email`, `miejscowosc`, `powiat`, `wojewodztwo`, `kod_pocztowy`, `ulica`, `numer_domu`, `numer_lokalu`)
VALUES (921200191, 'tomasz.kunowski@gmail.com', 'Wrocław', 'wrocławski', 'dolnośląskie', '50-001', 'Pomorska', 6, 18);
INSERT INTO kontakty
(`numer_telefonu`, `email`, `miejscowosc`, `powiat`, `wojewodztwo`, `kod_pocztowy`, `ulica`, `numer_domu`, `numer_lokalu`)
VALUES (827203191, 'jan.kowalski@gmail.com', 'Gdańśk', 'gdański', 'pomorskie', '80-008', 'Krucza', 4, NULL);
INSERT INTO kontakty
(`numer_telefonu`, `email`, `miejscowosc`, `powiat`, `wojewodztwo`, `kod_pocztowy`, `ulica`, `numer_domu`, `numer_lokalu`)
VALUES (327203771, 'maciej.polak@gmail.com', 'Kraków', 'krakowski', 'małopolskie', '30-001', 'Olejna', 23, 9);
 INSERT INTO kontakty
(`numer_telefonu`, `email`, `miejscowosc`, `powiat`, `wojewodztwo`, `kod_pocztowy`, `ulica`, `numer_domu`, `numer_lokalu`)
VALUES (123456789, 'kamil.kowalski@gmail.com', 'Kraków', 'krakowski', 'małopolskie', '30-001', 'Jaskółcza', 92, 16);
 INSERT INTO kontakty
(`numer_telefonu`, `email`, `miejscowosc`, `powiat`, `wojewodztwo`, `kod_pocztowy`, `ulica`, `numer_domu`, `numer_lokalu`)
VALUES (978654321, 'Filip478@gmail.com', 'Poznan', 'poznanski', 'wielkopolskie', '60-001', 'Piwna', 71, 13);
 INSERT INTO kontakty
(`numer_telefonu`, `email`, `miejscowosc`, `powiat`, `wojewodztwo`, `kod_pocztowy`, `ulica`, `numer_domu`, `numer_lokalu`)
VALUES (777111222, 'Zofia.Nowak@onet.pl', 'Kraków', 'krakowski', 'małopolskie', '30-001', 'Witolda', 6, 18);
 INSERT INTO kontakty
(`numer_telefonu`, `email`, `miejscowosc`, `powiat`, `wojewodztwo`, `kod_pocztowy`, `ulica`, `numer_domu`, `numer_lokalu`)
VALUES (123001789, 'hubert.kowalski@gmail.com', 'Warszawa', 'warszawski', 'mazowieckie', '00-016', 'Jaskółcza', 92, 16);
 INSERT INTO kontakty
(`numer_telefonu`, `email`, `miejscowosc`, `powiat`, `wojewodztwo`, `kod_pocztowy`, `ulica`, `numer_domu`, `numer_lokalu`)
VALUES (895738789, 'jan.knopp@gmail.com', 'Polańczyk', 'leski', 'podkarpackie', '38-610', 'Kielecka', 12, NULL);
 INSERT INTO kontakty
(`numer_telefonu`, `email`, `miejscowosc`, `powiat`, `wojewodztwo`, `kod_pocztowy`, `ulica`, `numer_domu`, `numer_lokalu`)
VALUES (983450189, 'ewa.mech@gmail.com', 'Warka', 'grójecki', 'mazowieckie', '05-660', 'Kwiatowa', 3, 6);
 INSERT INTO kontakty
(`numer_telefonu`, `email`, `miejscowosc`, `powiat`, `wojewodztwo`, `kod_pocztowy`, `ulica`, `numer_domu`, `numer_lokalu`)
VALUES (150286889, 'stefan.pelc@gmail.com', 'Sanok', 'sanocki', 'podkarpackie', '38-500', 'Krakowska', 31, NULL);
 INSERT INTO kontakty
(`numer_telefonu`, `email`, `miejscowosc`, `powiat`, `wojewodztwo`, `kod_pocztowy`, `ulica`, `numer_domu`, `numer_lokalu`)
VALUES (710294759, 'ewelina.paluch@gmail.com', 'Zabrze', 'zabrze', 'śląskie', '42-222', 'Śląska', 125, 12);
 INSERT INTO kontakty
(`numer_telefonu`, `email`, `miejscowosc`, `powiat`, `wojewodztwo`, `kod_pocztowy`, `ulica`, `numer_domu`, `numer_lokalu`)
VALUES (666555444, 'ewa.troc@gmail.com', 'Gliwice', 'gliwicki', 'śląskie', '00-016', 'Powstańców', 76, 14);
 INSERT INTO kontakty
(`numer_telefonu`, `email`, `miejscowosc`, `powiat`, `wojewodztwo`, `kod_pocztowy`, `ulica`, `numer_domu`, `numer_lokalu`)
VALUES (661502444, 'jaroslaw.kowal@gmail.com', 'Zamość', 'zamojski', 'lubelskie', '22-417', 'Szwedzka', 26, 14);
COMMIT;
-- -----------------------------------------------------
-- Data for table `mydb`.`Klienci`
-- -----------------------------------------------------
START TRANSACTION;
use `mydb`;
INSERT INTO klienci
(`id_klient`, `id_kontakt`, `imie`, `nazwisko`, `login`, `haslo`, `ostatnie_logowanie`, `rodzaj_klienta`, `nazwa_firmy`, `region`, `nip`)
VALUES (500, 1000, 'Albert', 'Nowak', 'albert32', 'albert1991', '25.03.2020', 'OSOBA FIZYCZNA', NUll, NULL, NULL);
INSERT INTO klienci
(`id_kontakt`, `imie`, `nazwisko`, `login`, `haslo`, `ostatnie_logowanie`, `rodzaj_klienta`, `nazwa_firmy`, `region`, `nip`)
VALUES (1001, 'Aleksandra', 'Wiśniewska', 'Olcia123', '1123Ola45', '12.02.2020', 'OSOBA FIZYCZNA', NUll, NULL, NULL);
INSERT INTO klienci
(`id_kontakt`, `imie`, `nazwisko`, `login`, `haslo`, `ostatnie_logowanie`, `rodzaj_klienta`, `nazwa_firmy`, `region`, `nip`)
VALUES (1002, 'Tomasz', 'Kunowski', 'TomeK', 'dddfdas', '02.04.2020', 'OSOBA FIZYCZNA', NUll, NULL, NULL);
INSERT INTO klienci
(`id_kontakt`, `imie`, `nazwisko`, `login`, `haslo`, `ostatnie_logowanie`, `rodzaj_klienta`, `nazwa_firmy`, `region`, `nip`)
VALUES (1003, 'Jan', 'Kowalski', 'janek003', 'janek001', '23.10.2019', 'OSOBA FIZYCZNA', NUll, NULL, NULL);
INSERT INTO klienci
(`id_kontakt`, `imie`, `nazwisko`, `login`, `haslo`, `ostatnie_logowanie`, `rodzaj_klienta`, `nazwa_firmy`, `region`, `nip`)
VALUES (1009, 'Jan', 'Knopp', 'janEKp', 'janwl', '13.10.2019', 'OSOBA FIZYCZNA', NUll, NULL, NULL);
INSERT INTO klienci
(`id_kontakt`, `imie`, `nazwisko`, `login`, `haslo`, `ostatnie_logowanie`, `rodzaj_klienta`, `nazwa_firmy`, `region`, `nip`)
VALUES (1010, 'Ewa', 'Mech', 'ewcia', 'pudel12', '27.02.2020', 'OSOBA FIZYCZNA', NUll, NULL, NULL);
INSERT INTO klienci
(`id_kontakt`, `imie`, `nazwisko`, `login`, `haslo`, `ostatnie_logowanie`, `rodzaj_klienta`, `nazwa_firmy`, `region`, `nip`)
VALUES (1013, 'Ewa', 'Troć', 'ewaatrC', 'kominek27', '15.05.2020', 'OSOBA FIZYCZNA', NUll, NULL, NULL);
COMMIT;

-- -----------------------------------------------------
-- Data for table `mydb`.`Zamowienia`
-- -----------------------------------------------------
START TRANSACTION;

INSERT INTO Zamowienia(`id_klient`, `status`, `data_zlozenia`, `czy_zaplacono`, `data_przyjecia`, `data_wysylki`, `data_realizacji`)
VALUES (500, 'ZŁOZONO', '20.03.25', 'NIE', NULL,  NULL, NULL);
INSERT INTO Zamowienia(`id_klient`, `status`, `data_zlozenia`, `czy_zaplacono`, `data_przyjecia`, `data_wysylki`, `data_realizacji`)
VALUES (501, 'PRZYJETO', '20.02.12', 'NIE', '20.03.26',  NULL, NULL);
INSERT INTO Zamowienia(`id_klient`, `status`, `data_zlozenia`, `czy_zaplacono`, `data_przyjecia`, `data_wysylki`, `data_realizacji`)
VALUES (502, 'WYSLANO', '20.04.20', 'TAK', '20.04.03',  '20.04.05', NULL);
INSERT INTO Zamowienia(`id_klient`, `status`, `data_zlozenia`, `czy_zaplacono`, `data_przyjecia`, `data_wysylki`, `data_realizacji`)
VALUES (503, 'ZREALIZOWANO', '19.10.23', 'TAK', '19.10.24',  '19.10.25', '19.10.30');
INSERT INTO Zamowienia(`id_klient`, `status`, `data_zlozenia`, `czy_zaplacono`, `data_przyjecia`, `data_wysylki`, `data_realizacji`)
VALUES (502, 'ZREALIZOWANO', '19.06.01', 'TAK', '19.06.02',  '19.06.05', '19.06.12');
INSERT INTO Zamowienia(`id_klient`, `status`, `data_zlozenia`, `czy_zaplacono`, `data_przyjecia`, `data_wysylki`, `data_realizacji`)
VALUES (501, 'ZREALIZOWANO', '19.07.12', 'TAK', '19.07.13',  '19.07.15', '19.07.17');
COMMIT;

-- -----------------------------------------------------
-- Data for table `mydb`.`Faktura`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO Faktura(`id_zamowienie`, `id_produkt`, `data_sprzedazy`, `wartosc_brutto`, `wartosc_netto`, `wartosc_vat`, `nazwa_banku`, `forma_platnosci`)
	VALUES(1, 17, 
	(SELECT data_zlozenia FROM Zamowienia WHERE id_zamowienie = 1), 
    (SELECT cena FROM model WHERE id_model = 
    (SELECT id_model FROM wyglad WHERE id_wyglad = (SELECT id_wyglad FROM produkty WHERE id_produkt = 17))),
	netto(`wartosc_brutto`), vat(`wartosc_brutto`), 'Millenium', 'przelew');

INSERT INTO Faktura(`id_zamowienie`, `id_produkt`, `data_sprzedazy`, `wartosc_brutto`, `wartosc_netto`, `wartosc_vat`, `nazwa_banku`, `forma_platnosci`)
VALUES(2, 431,
	(SELECT data_zlozenia FROM Zamowienia WHERE id_zamowienie = 2),  
    (SELECT cena FROM model WHERE id_model = 
    (SELECT id_model FROM wyglad WHERE id_wyglad = (SELECT id_wyglad FROM produkty WHERE id_produkt = 431))),
    netto(`wartosc_brutto`), vat(`wartosc_brutto`), 'Santander', 'płatność przy odbiorze');
    
INSERT INTO Faktura(`id_zamowienie`, `id_produkt`, `data_sprzedazy`, `wartosc_brutto`, `wartosc_netto`, `wartosc_vat`, `nazwa_banku`, `forma_platnosci`)
	VALUES(3, 256,
	(SELECT data_zlozenia FROM Zamowienia WHERE id_zamowienie = 3), 
    (SELECT cena FROM model WHERE id_model = 
    (SELECT id_model FROM wyglad WHERE id_wyglad = (SELECT id_wyglad FROM produkty WHERE id_produkt = 256))),
    netto(`wartosc_brutto`), vat(`wartosc_brutto`), 'Credit Agricole', 'przelew');
    
INSERT INTO Faktura(`id_zamowienie`, `id_produkt`, `data_sprzedazy`, `wartosc_brutto`, `wartosc_netto`, `wartosc_vat`, `nazwa_banku`, `forma_platnosci`)
	VALUES(4, 53, 
    (SELECT data_zlozenia FROM Zamowienia WHERE id_zamowienie = 4), 
    (SELECT cena FROM model WHERE id_model = 
    (SELECT id_model FROM wyglad WHERE id_wyglad = (SELECT id_wyglad FROM produkty WHERE id_produkt = 53))),
    netto(`wartosc_brutto`), vat(`wartosc_brutto`), 'PKO', 'przelew');
    
INSERT INTO Faktura(`id_zamowienie`, `id_produkt`, `data_sprzedazy`, `wartosc_brutto`, `wartosc_netto`, `wartosc_vat`, `nazwa_banku`, `forma_platnosci`)
	VALUES(5, 129, 
    (SELECT data_zlozenia FROM Zamowienia WHERE id_zamowienie = 5),
    (SELECT cena FROM model WHERE id_model = 
    (SELECT id_model FROM wyglad WHERE id_wyglad = (SELECT id_wyglad FROM produkty WHERE id_produkt = 129))),
    netto(`wartosc_brutto`), vat(`wartosc_brutto`), 'Millenium', 'przelew');
    
INSERT INTO Faktura(`id_zamowienie`, `id_produkt`, `data_sprzedazy`, `wartosc_brutto`, `wartosc_netto`, `wartosc_vat`, `nazwa_banku`, `forma_platnosci`)
	VALUES(6, 2,
    (SELECT data_zlozenia FROM Zamowienia WHERE id_zamowienie = 6), 
    (SELECT cena FROM model WHERE id_model = 
    (SELECT id_model FROM wyglad WHERE id_wyglad = (SELECT id_wyglad FROM produkty WHERE id_produkt = 2))),
    netto(`wartosc_brutto`), vat(`wartosc_brutto`), 'Millenium', 'przelew');
COMMIT;

-- -----------------------------------------------------
-- Data for table `mydb`.`Produkty sprzedane`
-- -----------------------------------------------------
START TRANSACTION;
alter  table produkty_sprzedane auto_increment = 1;
INSERT INTO produkty_sprzedane(`id_produkt`, `id_faktura`, `cena_sprzedazy`, `data_sprzedazy`)
VALUES((SELECT `id_produkt` FROM Faktura WHERE id_faktura = 1), 1, (SELECT `wartosc_brutto` FROM Faktura WHERE id_faktura = 1), (SELECT `data_sprzedazy` FROM Faktura WHERE id_faktura = 1)); 
INSERT INTO produkty_sprzedane(`id_produkt`, `id_faktura`, `cena_sprzedazy`, `data_sprzedazy`)
VALUES((SELECT `id_produkt` FROM Faktura WHERE id_faktura = 2), 2, (SELECT `wartosc_brutto` FROM Faktura WHERE id_faktura = 2), (SELECT `data_sprzedazy` FROM Faktura WHERE id_faktura = 2)); 
INSERT INTO produkty_sprzedane(`id_produkt`, `id_faktura`, `cena_sprzedazy`, `data_sprzedazy`)
VALUES((SELECT `id_produkt` FROM Faktura WHERE id_faktura = 3), 3, (SELECT `wartosc_brutto` FROM Faktura WHERE id_faktura = 3), (SELECT `data_sprzedazy` FROM Faktura WHERE id_faktura = 3)); 
INSERT INTO produkty_sprzedane(`id_produkt`, `id_faktura`, `cena_sprzedazy`, `data_sprzedazy`)
VALUES((SELECT `id_produkt` FROM Faktura WHERE id_faktura = 4), 4, (SELECT `wartosc_brutto` FROM Faktura WHERE id_faktura = 4), (SELECT `data_sprzedazy` FROM Faktura WHERE id_faktura = 4)); 
INSERT INTO produkty_sprzedane(`id_produkt`, `id_faktura`, `cena_sprzedazy`, `data_sprzedazy`)
VALUES((SELECT `id_produkt` FROM Faktura WHERE id_faktura = 5), 5, (SELECT `wartosc_brutto` FROM Faktura WHERE id_faktura = 5), (SELECT `data_sprzedazy` FROM Faktura WHERE id_faktura = 5)); 
INSERT INTO produkty_sprzedane(`id_produkt`, `id_faktura`, `cena_sprzedazy`, `data_sprzedazy`)
VALUES((SELECT `id_produkt` FROM Faktura WHERE id_faktura = 6), 6, (SELECT `wartosc_brutto` FROM Faktura WHERE id_faktura = 6), (SELECT `data_sprzedazy` FROM Faktura WHERE id_faktura = 6)); 
COMMIT;

-- -----------------------------------------------------
-- Data for table `mydb`.`Szczegoly zamowienia`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO szczegoly_zamowienia (`id_szczegoly_zamowienia`, `id_zamowienie`, `id_produkt` )VALUES (1, 1, 17);
INSERT INTO szczegoly_zamowienia (`id_zamowienie`, `id_produkt` )VALUES (2, 431);
INSERT INTO szczegoly_zamowienia (`id_zamowienie`, `id_produkt` )VALUES (3, 256);
INSERT INTO szczegoly_zamowienia (`id_zamowienie`, `id_produkt` )VALUES (4, 53);
INSERT INTO szczegoly_zamowienia (`id_zamowienie`, `id_produkt` )VALUES (5, 129);
INSERT INTO szczegoly_zamowienia (`id_zamowienie`, `id_produkt` )VALUES (6, 2);
COMMIT;
-- -----------------------------------------------------
-- Data for table `mydb`.`Pracownicy`
-- -----------------------------------------------------
START TRANSACTION;

INSERT INTO pracownicy(`id_pracownik`, `id_kierownik`, `id_kontakt`, `imie`, `nazwisko`, `login`, `haslo`, `uprawnienie`, `konto_aktywne`, `pensja`, `data_zatrudnienia`, `data_zwolnienia`)
VALUES(1, NULL, 1004, 'Maciej', 'Polak', 'MaciejPolak', 'maciej134', 'kierownik', 'TAK', 10000, '19.05.25', NULL);
INSERT INTO pracownicy(`id_kierownik`, `id_kontakt`, `imie`, `nazwisko`, `login`, `haslo`, `uprawnienie`, `konto_aktywne`, `pensja`, `data_zatrudnienia`, `data_zwolnienia`)
VALUES(1, 1005, 'Kamil', 'Kowalski', 'KamilKowalski', 'kdsvsa76', 'kurier', 'TAK', 3000, '19.05.25', NULL);
INSERT INTO pracownicy(`id_kierownik`, `id_kontakt`, `imie`, `nazwisko`, `login`, `haslo`, `uprawnienie`, `konto_aktywne`, `pensja`, `data_zatrudnienia`, `data_zwolnienia`)
VALUES(1, 1006, 'Filip', 'Filipiak', 'FilipFilipiak', 'k5n34n7', 'magazynier', 'TAK', 2500, '19.02.12', NULL);
INSERT INTO pracownicy(`id_kierownik`, `id_kontakt`, `imie`, `nazwisko`, `login`, `haslo`, `uprawnienie`, `konto_aktywne`, `pensja`, `data_zatrudnienia`, `data_zwolnienia`)
VALUES(NULL, 1007, 'Zofia', 'Nowak', 'ZofiaNowak', 'vgnjj6', 'kierownik', 'TAK', 8000, '19.04.23', NULL);
INSERT INTO pracownicy(`id_kierownik`, `id_kontakt`, `imie`, `nazwisko`, `login`, `haslo`, `uprawnienie`, `konto_aktywne`, `pensja`, `data_zatrudnienia`, `data_zwolnienia`)
VALUES(1, 1008, 'Hubert', 'Kowalski', 'HubertKowalski', 'pasdcn', 'spacjalista ds. Marketingu', 'TAK', 4000, '19.03.18', NULL);
INSERT INTO pracownicy(`id_kierownik`, `id_kontakt`, `imie`, `nazwisko`, `login`, `haslo`, `uprawnienie`, `konto_aktywne`, `pensja`, `data_zatrudnienia`, `data_zwolnienia`)
VALUES(1, 1011, 'Stefan', 'Pelc', 'StefanPelc', 'pasdjslpa', 'magazynier', 'TAK', 4200, '19.03.17', NULL);
INSERT INTO pracownicy(`id_kierownik`, `id_kontakt`, `imie`, `nazwisko`, `login`, `haslo`, `uprawnienie`, `konto_aktywne`, `pensja`, `data_zatrudnienia`, `data_zwolnienia`)
VALUES(1, 1012, 'Ewelina', 'Paluch', 'EwelinaPaluch', 'pqowieumnj', 'sprzedawca', 'TAK', 3200, '30.05.19', NULL);
INSERT INTO pracownicy(`id_kierownik`, `id_kontakt`, `imie`, `nazwisko`, `login`, `haslo`, `uprawnienie`, `konto_aktywne`, `pensja`, `data_zatrudnienia`, `data_zwolnienia`)
VALUES(NULL, 1014, 'Jarosław', 'Kowalski', 'JaroslawKowalski', 'mzlaksjdi', 'asystent', 'TAK', 1200, '30.03.19', NULL);
COMMIT;



