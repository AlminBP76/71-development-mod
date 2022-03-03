-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.4.22-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for 71devmod
CREATE DATABASE IF NOT EXISTS `71devmod` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */;
USE `71devmod`;

-- Dumping structure for table 71devmod.addon_account
CREATE TABLE IF NOT EXISTS `addon_account` (
  `name` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `label` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `shared` int(11) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table 71devmod.addon_account: ~20 rows (approximately)
/*!40000 ALTER TABLE `addon_account` DISABLE KEYS */;
INSERT INTO `addon_account` (`name`, `label`, `shared`) VALUES
	('property_black_money', 'Money Sale Property', 0),
	('society_ambulance', 'EMS', 1),
	('society_automafija', 'Auto Mafija', 1),
	('society_ballas', 'Ballas', 1),
	('society_camorra', 'Camorra', 1),
	('society_cardealer', 'Cardealer', 1),
	('society_favela', 'Favela', 1),
	('society_gsf', 'Gsf', 1),
	('society_juzniv', 'Juzni Vetar', 1),
	('society_lazarevacki', 'Lazarevacki', 1),
	('society_lcn', 'Lcn', 1),
	('society_ludisrbi', 'Ludi Srbi', 1),
	('society_mechanic', 'Mechanic', 1),
	('society_peaky', 'Peaky', 1),
	('society_police', 'Police', 1),
	('society_stikla', 'Stikla', 1),
	('society_taxi', 'Taxi', 1),
	('society_vagos', 'Vagos', 1),
	('society_yakuza', 'Yakuza', 1),
	('society_zemunski', 'Zemunski', 1);
/*!40000 ALTER TABLE `addon_account` ENABLE KEYS */;

-- Dumping structure for table 71devmod.addon_account_data
CREATE TABLE IF NOT EXISTS `addon_account_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `money` int(11) NOT NULL,
  `owner` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_addon_account_data_account_name_owner` (`account_name`,`owner`),
  KEY `index_addon_account_data_account_name` (`account_name`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table 71devmod.addon_account_data: ~20 rows (approximately)
/*!40000 ALTER TABLE `addon_account_data` DISABLE KEYS */;
INSERT INTO `addon_account_data` (`id`, `account_name`, `money`, `owner`) VALUES
	(1, 'society_ambulance', 0, NULL),
	(2, 'society_cardealer', 0, NULL),
	(3, 'society_mechanic', 0, NULL),
	(4, 'society_police', 0, NULL),
	(5, 'society_taxi', 0, NULL),
	(6, 'property_black_money', 0, 'char1:192.168.0.171'),
	(7, 'property_black_money', 0, '192.168.0.171'),
	(8, 'society_automafija', 0, NULL),
	(9, 'society_ballas', 0, NULL),
	(10, 'society_camorra', 0, NULL),
	(11, 'society_favela', 0, NULL),
	(12, 'society_gsf', 0, NULL),
	(13, 'society_juzniv', 0, NULL),
	(14, 'society_lazarevacki', 0, NULL),
	(15, 'society_lcn', 0, NULL),
	(16, 'society_ludisrbi', 0, NULL),
	(17, 'society_peaky', 0, NULL),
	(18, 'society_stikla', 0, NULL),
	(19, 'society_vagos', 0, NULL),
	(20, 'society_yakuza', 0, NULL),
	(21, 'society_zemunski', 0, NULL),
	(24, 'property_black_money', 0, 'char3:192.168.0.171');
/*!40000 ALTER TABLE `addon_account_data` ENABLE KEYS */;

-- Dumping structure for table 71devmod.addon_inventory
CREATE TABLE IF NOT EXISTS `addon_inventory` (
  `name` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `label` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `shared` int(11) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table 71devmod.addon_inventory: ~20 rows (approximately)
/*!40000 ALTER TABLE `addon_inventory` DISABLE KEYS */;
INSERT INTO `addon_inventory` (`name`, `label`, `shared`) VALUES
	('property', 'Property', 0),
	('society_ambulance', 'EMS', 1),
	('society_automafija', 'Auto Mafija', 1),
	('society_ballas', 'Ballas', 1),
	('society_camorra', 'Camorra', 1),
	('society_cardealer', 'Cardealer', 1),
	('society_favela', 'Favela', 1),
	('society_gsf', 'Gsf', 1),
	('society_juzniv', 'Juzni Vetar', 1),
	('society_lazarevacki', 'Lazarevacki', 1),
	('society_lcn', 'Lcn', 1),
	('society_ludisrbi', 'Ludi Srbi', 1),
	('society_mechanic', 'Mechanic', 1),
	('society_peaky', 'Peaky', 1),
	('society_police', 'Police', 1),
	('society_stikla', 'Stikla', 1),
	('society_taxi', 'Taxi', 1),
	('society_vagos', 'Vagos', 1),
	('society_yakuza', 'Yakuza', 1),
	('society_zemunski', 'Zemunski', 1);
/*!40000 ALTER TABLE `addon_inventory` ENABLE KEYS */;

-- Dumping structure for table 71devmod.addon_inventory_items
CREATE TABLE IF NOT EXISTS `addon_inventory_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `inventory_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `count` int(11) NOT NULL,
  `owner` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_addon_inventory_items_inventory_name_name` (`inventory_name`,`name`),
  KEY `index_addon_inventory_items_inventory_name_name_owner` (`inventory_name`,`name`,`owner`),
  KEY `index_addon_inventory_inventory_name` (`inventory_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table 71devmod.addon_inventory_items: ~0 rows (approximately)
/*!40000 ALTER TABLE `addon_inventory_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `addon_inventory_items` ENABLE KEYS */;

-- Dumping structure for table 71devmod.billing
CREATE TABLE IF NOT EXISTS `billing` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sender` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `target_type` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `target` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `label` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table 71devmod.billing: ~0 rows (approximately)
/*!40000 ALTER TABLE `billing` DISABLE KEYS */;
/*!40000 ALTER TABLE `billing` ENABLE KEYS */;

CREATE TABLE `bwh_bans` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `receiver` text NOT NULL,
  `sender` varchar(60) NOT NULL,
  `length` datetime NULL,
  `reason` text NOT NULL,
  `unbanned` TINYINT NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
);
CREATE TABLE `bwh_warnings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `receiver` text NOT NULL,
  `sender` varchar(60) NOT NULL,
  `message` text NOT NULL,
  PRIMARY KEY (`id`)
);
CREATE TABLE `bwh_identifiers` (
  `steam` VARCHAR(60) NOT NULL,
  `license` VARCHAR(60) NOT NULL,
  `ip` VARCHAR(60) NOT NULL,
  `name` VARCHAR(128) NOT NULL,
  `xbl` VARCHAR(60) NULL,
  `live` VARCHAR(60) NULL,
  `discord` VARCHAR(60) NULL,
  `fivem` VARCHAR(60) NULL,
  PRIMARY KEY (`steam`)
);

-- Dumping structure for table 71devmod.cardealer_vehicles
CREATE TABLE IF NOT EXISTS `cardealer_vehicles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `vehicle` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table 71devmod.cardealer_vehicles: ~0 rows (approximately)
/*!40000 ALTER TABLE `cardealer_vehicles` DISABLE KEYS */;
/*!40000 ALTER TABLE `cardealer_vehicles` ENABLE KEYS */;

-- Dumping structure for table 71devmod.communityservice
CREATE TABLE IF NOT EXISTS `communityservice` (
  `identifier` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `actions_remaining` int(10) NOT NULL,
  PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table 71devmod.communityservice: ~0 rows (approximately)
/*!40000 ALTER TABLE `communityservice` DISABLE KEYS */;
/*!40000 ALTER TABLE `communityservice` ENABLE KEYS */;

-- Dumping structure for table 71devmod.crew_phone_bank
CREATE TABLE IF NOT EXISTS `crew_phone_bank` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` int(11) NOT NULL DEFAULT 1,
  `identifier` varchar(60) DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `price` int(11) NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table 71devmod.crew_phone_bank: ~0 rows (approximately)
/*!40000 ALTER TABLE `crew_phone_bank` DISABLE KEYS */;
/*!40000 ALTER TABLE `crew_phone_bank` ENABLE KEYS */;

-- Dumping structure for table 71devmod.crew_phone_news
CREATE TABLE IF NOT EXISTS `crew_phone_news` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `data` longtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- Dumping data for table 71devmod.crew_phone_news: ~0 rows (approximately)
/*!40000 ALTER TABLE `crew_phone_news` DISABLE KEYS */;
/*!40000 ALTER TABLE `crew_phone_news` ENABLE KEYS */;

-- Dumping structure for table 71devmod.datastore
CREATE TABLE IF NOT EXISTS `datastore` (
  `name` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `label` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `shared` int(11) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table 71devmod.datastore: ~19 rows (approximately)
/*!40000 ALTER TABLE `datastore` DISABLE KEYS */;
INSERT INTO `datastore` (`name`, `label`, `shared`) VALUES
	('property', 'Property', 0),
	('society_ambulance', 'EMS', 1),
	('society_automafija', 'Auto Mafija', 1),
	('society_ballas', 'Ballas', 1),
	('society_camorra', 'Camorra', 1),
	('society_favela', 'Favela', 1),
	('society_gsf', 'Gsf', 1),
	('society_juzniv', 'Juzni Vetar', 1),
	('society_lazarevacki', 'Lazarevacki', 1),
	('society_lcn', 'Lcn', 1),
	('society_ludisrbi', 'Ludi Srbi', 1),
	('society_mechanic', 'Mechanic', 1),
	('society_peaky', 'Peaky', 1),
	('society_police', 'Police', 1),
	('society_stikla', 'Stikla', 1),
	('society_taxi', 'Taxi', 1),
	('society_vagos', 'Vagos', 1),
	('society_yakuza', 'Yakuza', 1),
	('society_zemunski', 'Zemunski', 1);
/*!40000 ALTER TABLE `datastore` ENABLE KEYS */;

-- Dumping structure for table 71devmod.datastore_data
CREATE TABLE IF NOT EXISTS `datastore_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `data` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_datastore_data_name_owner` (`name`,`owner`),
  KEY `index_datastore_data_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table 71devmod.datastore_data: ~21 rows (approximately)
/*!40000 ALTER TABLE `datastore_data` DISABLE KEYS */;
INSERT INTO `datastore_data` (`id`, `name`, `owner`, `data`) VALUES
	(1, 'society_ambulance', NULL, '\'{}\''),
	(2, 'society_mechanic', NULL, '\'{}\''),
	(3, 'society_police', NULL, '\'{}\''),
	(4, 'society_taxi', NULL, '\'{}\''),
	(5, 'property', 'char1:192.168.0.171', '{}'),
	(6, 'property', '192.168.0.171', '{}'),
	(7, 'society_automafija', NULL, '\'{}\''),
	(8, 'society_ballas', NULL, '\'{}\''),
	(9, 'society_camorra', NULL, '\'{}\''),
	(10, 'society_favela', NULL, '\'{}\''),
	(11, 'society_gsf', NULL, '\'{}\''),
	(12, 'society_juzniv', NULL, '\'{}\''),
	(13, 'society_lazarevacki', NULL, '\'{}\''),
	(14, 'society_lcn', NULL, '\'{}\''),
	(15, 'society_ludisrbi', NULL, '\'{}\''),
	(16, 'society_peaky', NULL, '\'{}\''),
	(17, 'society_stikla', NULL, '\'{}\''),
	(18, 'society_vagos', NULL, '\'{}\''),
	(19, 'society_yakuza', NULL, '\'{}\''),
	(20, 'society_zemunski', NULL, '\'{}\''),
	(23, 'property', 'char3:192.168.0.171', '{}');
/*!40000 ALTER TABLE `datastore_data` ENABLE KEYS */;

-- Dumping structure for table 71devmod.fine_types
CREATE TABLE IF NOT EXISTS `fine_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `label` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  `category` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table 71devmod.fine_types: ~52 rows (approximately)
/*!40000 ALTER TABLE `fine_types` DISABLE KEYS */;
INSERT INTO `fine_types` (`id`, `label`, `amount`, `category`) VALUES
	(1, 'Misuse of a horn', 30, 0),
	(2, 'Illegally Crossing a continuous Line', 40, 0),
	(3, 'Driving on the wrong side of the road', 250, 0),
	(4, 'Illegal U-Turn', 250, 0),
	(5, 'Illegally Driving Off-road', 170, 0),
	(6, 'Refusing a Lawful Command', 30, 0),
	(7, 'Illegally Stopping a Vehicle', 150, 0),
	(8, 'Illegal Parking', 70, 0),
	(9, 'Failing to Yield to the right', 70, 0),
	(10, 'Failure to comply with Vehicle Information', 90, 0),
	(11, 'Failing to stop at a Stop Sign ', 105, 0),
	(12, 'Failing to stop at a Red Light', 130, 0),
	(13, 'Illegal Passing', 100, 0),
	(14, 'Driving an illegal Vehicle', 100, 0),
	(15, 'Driving without a License', 1500, 0),
	(16, 'Hit and Run', 800, 0),
	(17, 'Exceeding Speeds Over < 5 mph', 90, 0),
	(18, 'Exceeding Speeds Over 5-15 mph', 120, 0),
	(19, 'Exceeding Speeds Over 15-30 mph', 180, 0),
	(20, 'Exceeding Speeds Over > 30 mph', 300, 0),
	(21, 'Impeding traffic flow', 110, 1),
	(22, 'Public INToxication', 90, 1),
	(23, 'Disorderly conduct', 90, 1),
	(24, 'Obstruction of Justice', 130, 1),
	(25, 'Insults towards Civilans', 75, 1),
	(26, 'Disrespecting of an LEO', 110, 1),
	(27, 'Verbal Threat towards a Civilan', 90, 1),
	(28, 'Verbal Threat towards an LEO', 150, 1),
	(29, 'Providing False Information', 250, 1),
	(30, 'Attempt of Corruption', 1500, 1),
	(31, 'Brandishing a weapon in city Limits', 120, 2),
	(32, 'Brandishing a Lethal Weapon in city Limits', 300, 2),
	(33, 'No Firearms License', 600, 2),
	(34, 'Possession of an Illegal Weapon', 700, 2),
	(35, 'Possession of Burglary Tools', 300, 2),
	(36, 'Grand Theft Auto', 1800, 2),
	(37, 'INTent to Sell/Distrube of an illegal Substance', 1500, 2),
	(38, 'Frabrication of an Illegal Substance', 1500, 2),
	(39, 'Possession of an Illegal Substance ', 650, 2),
	(40, 'Kidnapping of a Civilan', 1500, 2),
	(41, 'Kidnapping of an LEO', 2000, 2),
	(42, 'Robbery', 650, 2),
	(43, 'Armed Robbery of a Store', 650, 2),
	(44, 'Armed Robbery of a Bank', 1500, 2),
	(45, 'Assault on a Civilian', 2000, 3),
	(46, 'Assault of an LEO', 2500, 3),
	(47, 'Attempt of Murder of a Civilian', 3000, 3),
	(48, 'Attempt of Murder of an LEO', 5000, 3),
	(49, 'Murder of a Civilian', 10000, 3),
	(50, 'Murder of an LEO', 30000, 3),
	(51, 'Involuntary manslaughter', 1800, 3),
	(52, 'Fraud', 2000, 2);
/*!40000 ALTER TABLE `fine_types` ENABLE KEYS */;

-- Dumping structure for table 71devmod.items
CREATE TABLE IF NOT EXISTS `items` (
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `label` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `weight` int(11) NOT NULL DEFAULT 1,
  `rare` tinyint(4) NOT NULL DEFAULT 0,
  `can_remove` tinyint(4) NOT NULL DEFAULT 1,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table 71devmod.items: ~0 rows (approximately)
/*!40000 ALTER TABLE `items` DISABLE KEYS */;
/*!40000 ALTER TABLE `items` ENABLE KEYS */;

-- Dumping structure for table 71devmod.jobs
CREATE TABLE IF NOT EXISTS `jobs` (
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `label` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `whitelisted` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table 71devmod.jobs: ~20 rows (approximately)
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES
	('ambulance', 'EMS', 0),
	('automafija', 'Auto Mafija', 1),
	('ballas', 'Ballas', 1),
	('camorra', 'Camorra', 1),
	('cardealer', 'Cardealer', 0),
	('favela', 'Favela', 1),
	('gsf', 'Gsf', 1),
	('juzniv', 'Juzni Vetar', 1),
	('lazarevacki', 'Lazarevacki Klan', 1),
	('lcn', 'Lcn', 1),
	('ludisrbi', 'Ludi Srbi', 1),
	('mechanic', 'Mechanic', 0),
	('peaky', 'Peaky', 1),
	('police', 'Police', 0),
	('stikla', 'Stikla', 1),
	('taxi', 'Taxi', 0),
	('unemployed', 'Unemployed', 0),
	('vagos', 'Vagos', 1),
	('yakuza', 'Yakuza', 1),
	('zemunski', 'Zemunski Klan', 1);
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;

-- Dumping structure for table 71devmod.job_grades
CREATE TABLE IF NOT EXISTS `job_grades` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job_name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `grade` int(11) NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `label` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `salary` int(11) NOT NULL,
  `skin_male` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `skin_female` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table 71devmod.job_grades: ~86 rows (approximately)
/*!40000 ALTER TABLE `job_grades` DISABLE KEYS */;
INSERT INTO `job_grades` (`id`, `job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
	(1, 'unemployed', 0, 'unemployed', 'Unemployed', 200, '{}', '{}'),
	(2, 'ambulance', 0, 'ambulance', 'Jr. EMT', 20, '{"tshirt_2":0, "hair_color_1":5, "glasses_2":3, "shoes":9, "torso_2":3, "hair_color_2":0, "pants_1":24, "glasses_1":4, "hair_1":2, "sex":0, "decals_2":0, "tshirt_1":15, "helmet_1":8, "helmet_2":0, "arms":92, "face":19, "decals_1":60, "torso_1":13, "hair_2":0, "skin":34, "pants_2":5}', '{"tshirt_2":3, "decals_2":0, "glasses":0, "hair_1":2, "torso_1":73, "shoes":1, "hair_color_2":0, "glasses_1":19, "skin":13, "face":6, "pants_2":5, "tshirt_1":75, "pants_1":37, "helmet_1":57, "torso_2":0, "arms":14, "sex":1, "glasses_2":0, "decals_1":0, "hair_2":0, "helmet_2":0, "hair_color_1":0}'),
	(3, 'ambulance', 1, 'doctor', 'EMT', 40, '{"tshirt_2":0, "hair_color_1":5, "glasses_2":3, "shoes":9, "torso_2":3, "hair_color_2":0, "pants_1":24, "glasses_1":4, "hair_1":2, "sex":0, "decals_2":0, "tshirt_1":15, "helmet_1":8, "helmet_2":0, "arms":92, "face":19, "decals_1":60, "torso_1":13, "hair_2":0, "skin":34, "pants_2":5}', '{"tshirt_2":3, "decals_2":0, "glasses":0, "hair_1":2, "torso_1":73, "shoes":1, "hair_color_2":0, "glasses_1":19, "skin":13, "face":6, "pants_2":5, "tshirt_1":75, "pants_1":37, "helmet_1":57, "torso_2":0, "arms":14, "sex":1, "glasses_2":0, "decals_1":0, "hair_2":0, "helmet_2":0, "hair_color_1":0}'),
	(4, 'ambulance', 2, 'chief_doctor', 'Sr. EMT', 60, '{"tshirt_2":0, "hair_color_1":5, "glasses_2":3, "shoes":9, "torso_2":3, "hair_color_2":0, "pants_1":24, "glasses_1":4, "hair_1":2, "sex":0, "decals_2":0, "tshirt_1":15, "helmet_1":8, "helmet_2":0, "arms":92, "face":19, "decals_1":60, "torso_1":13, "hair_2":0, "skin":34, "pants_2":5}', '{"tshirt_2":3, "decals_2":0, "glasses":0, "hair_1":2, "torso_1":73, "shoes":1, "hair_color_2":0, "glasses_1":19, "skin":13, "face":6, "pants_2":5, "tshirt_1":75, "pants_1":37, "helmet_1":57, "torso_2":0, "arms":14, "sex":1, "glasses_2":0, "decals_1":0, "hair_2":0, "helmet_2":0, "hair_color_1":0}'),
	(5, 'ambulance', 3, 'boss', 'EMT Supervisor', 80, '{"tshirt_2":0, "hair_color_1":5, "glasses_2":3, "shoes":9, "torso_2":3, "hair_color_2":0, "pants_1":24, "glasses_1":4, "hair_1":2, "sex":0, "decals_2":0, "tshirt_1":15, "helmet_1":8, "helmet_2":0, "arms":92, "face":19, "decals_1":60, "torso_1":13, "hair_2":0, "skin":34, "pants_2":5}', '{"tshirt_2":3, "decals_2":0, "glasses":0, "hair_1":2, "torso_1":73, "shoes":1, "hair_color_2":0, "glasses_1":19, "skin":13, "face":6, "pants_2":5, "tshirt_1":75, "pants_1":37, "helmet_1":57, "torso_2":0, "arms":14, "sex":1, "glasses_2":0, "decals_1":0, "hair_2":0, "helmet_2":0, "hair_color_1":0}'),
	(6, 'mechanic', 0, 'recruit', 'Recruit', 12, '{}', '{}'),
	(7, 'mechanic', 1, 'novice', 'Novice', 24, '{}', '{}'),
	(8, 'mechanic', 2, 'experienced', 'Experienced', 36, '{}', '{}'),
	(9, 'mechanic', 3, 'leader', 'Leader', 48, '{}', '{}'),
	(10, 'mechanic', 4, 'boss', 'Boss', 0, '{}', '{}'),
	(11, 'police', 0, 'policajac', 'Saobracajac', 600, '{}', '{}'),
	(12, 'police', 1, 'oficir', 'Oficir', 850, '{}', '{}'),
	(13, 'police', 2, 'kobra', 'Kobra', 1100, '{}', '{}'),
	(14, 'police', 3, 'zamenik', 'Zamjenik', 3500, '{}', '{}'),
	(15, 'police', 4, 'boss', 'Nacelnik', 4000, '{}', '{}'),
	(16, 'taxi', 0, 'recruit', 'Recruit', 12, '{"hair_2":0, "hair_color_2":0, "torso_1":32, "bags_1":0, "helmet_2":0, "chain_2":0, "eyebrows_3":0, "makeup_3":0, "makeup_2":0, "tshirt_1":31, "makeup_1":0, "bags_2":0, "makeup_4":0, "eyebrows_4":0, "chain_1":0, "lipstick_4":0, "bproof_2":0, "hair_color_1":0, "decals_2":0, "pants_2":0, "age_2":0, "glasses_2":0, "ears_2":0, "arms":27, "lipstick_1":0, "ears_1":-1, "mask_2":0, "sex":0, "lipstick_3":0, "helmet_1":-1, "shoes_2":0, "beard_2":0, "beard_1":0, "lipstick_2":0, "beard_4":0, "glasses_1":0, "bproof_1":0, "mask_1":0, "decals_1":1, "hair_1":0, "eyebrows_2":0, "beard_3":0, "age_1":0, "tshirt_2":0, "skin":0, "torso_2":0, "eyebrows_1":0, "face":0, "shoes_1":10, "pants_1":24}', '{"hair_2":0, "hair_color_2":0, "torso_1":57, "bags_1":0, "helmet_2":0, "chain_2":0, "eyebrows_3":0, "makeup_3":0, "makeup_2":0, "tshirt_1":38, "makeup_1":0, "bags_2":0, "makeup_4":0, "eyebrows_4":0, "chain_1":0, "lipstick_4":0, "bproof_2":0, "hair_color_1":0, "decals_2":0, "pants_2":1, "age_2":0, "glasses_2":0, "ears_2":0, "arms":21, "lipstick_1":0, "ears_1":-1, "mask_2":0, "sex":1, "lipstick_3":0, "helmet_1":-1, "shoes_2":0, "beard_2":0, "beard_1":0, "lipstick_2":0, "beard_4":0, "glasses_1":5, "bproof_1":0, "mask_1":0, "decals_1":1, "hair_1":0, "eyebrows_2":0, "beard_3":0, "age_1":0, "tshirt_2":0, "skin":0, "torso_2":0, "eyebrows_1":0, "face":0, "shoes_1":49, "pants_1":11}'),
	(17, 'taxi', 1, 'novice', 'Cabby', 24, '{"hair_2":0, "hair_color_2":0, "torso_1":32, "bags_1":0, "helmet_2":0, "chain_2":0, "eyebrows_3":0, "makeup_3":0, "makeup_2":0, "tshirt_1":31, "makeup_1":0, "bags_2":0, "makeup_4":0, "eyebrows_4":0, "chain_1":0, "lipstick_4":0, "bproof_2":0, "hair_color_1":0, "decals_2":0, "pants_2":0, "age_2":0, "glasses_2":0, "ears_2":0, "arms":27, "lipstick_1":0, "ears_1":-1, "mask_2":0, "sex":0, "lipstick_3":0, "helmet_1":-1, "shoes_2":0, "beard_2":0, "beard_1":0, "lipstick_2":0, "beard_4":0, "glasses_1":0, "bproof_1":0, "mask_1":0, "decals_1":1, "hair_1":0, "eyebrows_2":0, "beard_3":0, "age_1":0, "tshirt_2":0, "skin":0, "torso_2":0, "eyebrows_1":0, "face":0, "shoes_1":10, "pants_1":24}', '{"hair_2":0, "hair_color_2":0, "torso_1":57, "bags_1":0, "helmet_2":0, "chain_2":0, "eyebrows_3":0, "makeup_3":0, "makeup_2":0, "tshirt_1":38, "makeup_1":0, "bags_2":0, "makeup_4":0, "eyebrows_4":0, "chain_1":0, "lipstick_4":0, "bproof_2":0, "hair_color_1":0, "decals_2":0, "pants_2":1, "age_2":0, "glasses_2":0, "ears_2":0, "arms":21, "lipstick_1":0, "ears_1":-1, "mask_2":0, "sex":1, "lipstick_3":0, "helmet_1":-1, "shoes_2":0, "beard_2":0, "beard_1":0, "lipstick_2":0, "beard_4":0, "glasses_1":5, "bproof_1":0, "mask_1":0, "decals_1":1, "hair_1":0, "eyebrows_2":0, "beard_3":0, "age_1":0, "tshirt_2":0, "skin":0, "torso_2":0, "eyebrows_1":0, "face":0, "shoes_1":49, "pants_1":11}'),
	(18, 'taxi', 2, 'experienced', 'Experienced', 36, '{"hair_2":0, "hair_color_2":0, "torso_1":26, "bags_1":0, "helmet_2":0, "chain_2":0, "eyebrows_3":0, "makeup_3":0, "makeup_2":0, "tshirt_1":57, "makeup_1":0, "bags_2":0, "makeup_4":0, "eyebrows_4":0, "chain_1":0, "lipstick_4":0, "bproof_2":0, "hair_color_1":0, "decals_2":0, "pants_2":4, "age_2":0, "glasses_2":0, "ears_2":0, "arms":11, "lipstick_1":0, "ears_1":-1, "mask_2":0, "sex":0, "lipstick_3":0, "helmet_1":-1, "shoes_2":0, "beard_2":0, "beard_1":0, "lipstick_2":0, "beard_4":0, "glasses_1":0, "bproof_1":0, "mask_1":0, "decals_1":0, "hair_1":0, "eyebrows_2":0, "beard_3":0, "age_1":0, "tshirt_2":0, "skin":0, "torso_2":0, "eyebrows_1":0, "face":0, "shoes_1":10, "pants_1":24}', '{"hair_2":0, "hair_color_2":0, "torso_1":57, "bags_1":0, "helmet_2":0, "chain_2":0, "eyebrows_3":0, "makeup_3":0, "makeup_2":0, "tshirt_1":38, "makeup_1":0, "bags_2":0, "makeup_4":0, "eyebrows_4":0, "chain_1":0, "lipstick_4":0, "bproof_2":0, "hair_color_1":0, "decals_2":0, "pants_2":1, "age_2":0, "glasses_2":0, "ears_2":0, "arms":21, "lipstick_1":0, "ears_1":-1, "mask_2":0, "sex":1, "lipstick_3":0, "helmet_1":-1, "shoes_2":0, "beard_2":0, "beard_1":0, "lipstick_2":0, "beard_4":0, "glasses_1":5, "bproof_1":0, "mask_1":0, "decals_1":1, "hair_1":0, "eyebrows_2":0, "beard_3":0, "age_1":0, "tshirt_2":0, "skin":0, "torso_2":0, "eyebrows_1":0, "face":0, "shoes_1":49, "pants_1":11}'),
	(19, 'taxi', 3, 'uber', 'Uber Cabby', 48, '{"hair_2":0, "hair_color_2":0, "torso_1":26, "bags_1":0, "helmet_2":0, "chain_2":0, "eyebrows_3":0, "makeup_3":0, "makeup_2":0, "tshirt_1":57, "makeup_1":0, "bags_2":0, "makeup_4":0, "eyebrows_4":0, "chain_1":0, "lipstick_4":0, "bproof_2":0, "hair_color_1":0, "decals_2":0, "pants_2":4, "age_2":0, "glasses_2":0, "ears_2":0, "arms":11, "lipstick_1":0, "ears_1":-1, "mask_2":0, "sex":0, "lipstick_3":0, "helmet_1":-1, "shoes_2":0, "beard_2":0, "beard_1":0, "lipstick_2":0, "beard_4":0, "glasses_1":0, "bproof_1":0, "mask_1":0, "decals_1":0, "hair_1":0, "eyebrows_2":0, "beard_3":0, "age_1":0, "tshirt_2":0, "skin":0, "torso_2":0, "eyebrows_1":0, "face":0, "shoes_1":10, "pants_1":24}', '{"hair_2":0, "hair_color_2":0, "torso_1":57, "bags_1":0, "helmet_2":0, "chain_2":0, "eyebrows_3":0, "makeup_3":0, "makeup_2":0, "tshirt_1":38, "makeup_1":0, "bags_2":0, "makeup_4":0, "eyebrows_4":0, "chain_1":0, "lipstick_4":0, "bproof_2":0, "hair_color_1":0, "decals_2":0, "pants_2":1, "age_2":0, "glasses_2":0, "ears_2":0, "arms":21, "lipstick_1":0, "ears_1":-1, "mask_2":0, "sex":1, "lipstick_3":0, "helmet_1":-1, "shoes_2":0, "beard_2":0, "beard_1":0, "lipstick_2":0, "beard_4":0, "glasses_1":5, "bproof_1":0, "mask_1":0, "decals_1":1, "hair_1":0, "eyebrows_2":0, "beard_3":0, "age_1":0, "tshirt_2":0, "skin":0, "torso_2":0, "eyebrows_1":0, "face":0, "shoes_1":49, "pants_1":11}'),
	(20, 'taxi', 4, 'boss', 'Lead Cabby', 0, '{"hair_2":0, "hair_color_2":0, "torso_1":29, "bags_1":0, "helmet_2":0, "chain_2":0, "eyebrows_3":0, "makeup_3":0, "makeup_2":0, "tshirt_1":31, "makeup_1":0, "bags_2":0, "makeup_4":0, "eyebrows_4":0, "chain_1":0, "lipstick_4":0, "bproof_2":0, "hair_color_1":0, "decals_2":0, "pants_2":4, "age_2":0, "glasses_2":0, "ears_2":0, "arms":1, "lipstick_1":0, "ears_1":-1, "mask_2":0, "sex":0, "lipstick_3":0, "helmet_1":-1, "shoes_2":0, "beard_2":0, "beard_1":0, "lipstick_2":0, "beard_4":0, "glasses_1":0, "bproof_1":0, "mask_1":0, "decals_1":0, "hair_1":0, "eyebrows_2":0, "beard_3":0, "age_1":0, "tshirt_2":0, "skin":0, "torso_2":4, "eyebrows_1":0, "face":0, "shoes_1":10, "pants_1":24}', '{"hair_2":0, "hair_color_2":0, "torso_1":57, "bags_1":0, "helmet_2":0, "chain_2":0, "eyebrows_3":0, "makeup_3":0, "makeup_2":0, "tshirt_1":38, "makeup_1":0, "bags_2":0, "makeup_4":0, "eyebrows_4":0, "chain_1":0, "lipstick_4":0, "bproof_2":0, "hair_color_1":0, "decals_2":0, "pants_2":1, "age_2":0, "glasses_2":0, "ears_2":0, "arms":21, "lipstick_1":0, "ears_1":-1, "mask_2":0, "sex":1, "lipstick_3":0, "helmet_1":-1, "shoes_2":0, "beard_2":0, "beard_1":0, "lipstick_2":0, "beard_4":0, "glasses_1":5, "bproof_1":0, "mask_1":0, "decals_1":1, "hair_1":0, "eyebrows_2":0, "beard_3":0, "age_1":0, "tshirt_2":0, "skin":0, "torso_2":0, "eyebrows_1":0, "face":0, "shoes_1":49, "pants_1":11}'),
	(21, 'cardealer', 0, 'recruit', 'Recruit', 10, '{}', '{}'),
	(22, 'cardealer', 1, 'novice', 'Novice', 25, '{}', '{}'),
	(23, 'cardealer', 2, 'experienced', 'Experienced', 40, '{}', '{}'),
	(24, 'cardealer', 3, 'boss', 'Boss', 0, '{}', '{}'),
	(25, 'zemunski', 0, 'novi', 'Novi', 0, '{}', '{}'),
	(26, 'zemunski', 1, 'radnik', 'Radnik', 0, '{}', '{}'),
	(27, 'zemunski', 2, 'zamenik', 'Zamenik Sefa', 0, '{}', '{}'),
	(28, 'zemunski', 3, 'boss', 'Sef', 0, '{}', '{}'),
	(29, 'vagos', 0, 'novi', 'Novi', 0, '{}', '{}'),
	(30, 'vagos', 1, 'radnik', 'Radnik', 0, '{}', '{}'),
	(31, 'vagos', 2, 'zamenik', 'Zamenik Sefa', 0, '{}', '{}'),
	(32, 'vagos', 3, 'boss', 'Sef', 0, '{}', '{}'),
	(33, 'peaky', 0, 'novi', 'Novi', 0, '{}', '{}'),
	(34, 'peaky', 1, 'radnik', 'Radnik', 0, '{}', '{}'),
	(35, 'peaky', 2, 'zamenik', 'Zamenik Sefa', 0, '{}', '{}'),
	(36, 'peaky', 3, 'boss', 'Sef', 0, '{}', '{}'),
	(37, 'stikla', 0, 'novi', 'Novi', 0, '{}', '{}'),
	(38, 'stikla', 1, 'radnik', 'Radnik', 0, '{}', '{}'),
	(39, 'stikla', 2, 'zamenik', 'Zamenik Sefa', 0, '{}', '{}'),
	(40, 'stikla', 3, 'boss', 'Sef', 0, '{}', '{}'),
	(41, 'ludisrbi', 0, 'novi', 'Novi', 0, '{}', '{}'),
	(42, 'ludisrbi', 1, 'radnik', 'Radnik', 0, '{}', '{}'),
	(43, 'ludisrbi', 2, 'zamenik', 'Zamenik Sefa', 0, '{}', '{}'),
	(44, 'ludisrbi', 3, 'boss', 'Sef', 0, '{}', '{}'),
	(45, 'lcn', 0, 'novi', 'Novi', 0, '{}', '{}'),
	(46, 'lcn', 1, 'radnik', 'Radnik', 0, '{}', '{}'),
	(47, 'lcn', 2, 'zamenik', 'Zamenik Sefa', 0, '{}', '{}'),
	(48, 'lcn', 3, 'boss', 'Sef', 0, '{}', '{}'),
	(49, 'lazarevacki', 0, 'novi', 'Novi', 0, '{}', '{}'),
	(50, 'lazarevacki', 1, 'radnik', 'Radnik', 0, '{}', '{}'),
	(51, 'lazarevacki', 2, 'zamenik', 'Zamenik Sefa', 0, '{}', '{}'),
	(52, 'lazarevacki', 3, 'boss', 'Sef', 0, '{}', '{}'),
	(53, 'juzniv', 0, 'novi', 'Novi', 0, '{}', '{}'),
	(54, 'juzniv', 1, 'radnik', 'Radnik', 0, '{}', '{}'),
	(55, 'juzniv', 2, 'zamenik', 'Zamenik Sefa', 0, '{}', '{}'),
	(56, 'juzniv', 3, 'boss', 'Sef', 0, '{}', '{}'),
	(57, 'gsf', 0, 'novi', 'Novi', 0, '{}', '{}'),
	(58, 'gsf', 1, 'radnik', 'Radnik', 0, '{}', '{}'),
	(59, 'gsf', 2, 'zamenik', 'Zamenik Sefa', 0, '{}', '{}'),
	(60, 'gsf', 3, 'boss', 'Sef', 0, '{}', '{}'),
	(61, 'favela', 0, 'novi', 'Novi', 0, '{}', '{}'),
	(62, 'favela', 1, 'radnik', 'Radnik', 0, '{}', '{}'),
	(63, 'favela', 2, 'zamenik', 'Zamenik Sefa', 0, '{}', '{}'),
	(64, 'favela', 3, 'boss', 'Sef', 0, '{}', '{}'),
	(65, 'camorra', 0, 'novi', 'Novi', 0, '{}', '{}'),
	(66, 'camorra', 1, 'radnik', 'Radnik', 0, '{}', '{}'),
	(67, 'camorra', 2, 'zamenik', 'Zamenik Sefa', 0, '{}', '{}'),
	(68, 'camorra', 3, 'boss', 'Sef', 0, '{}', '{}'),
	(69, 'ballas', 0, 'novi', 'Novi', 0, '{}', '{}'),
	(70, 'ballas', 1, 'radnik', 'Radnik', 0, '{}', '{}'),
	(71, 'ballas', 2, 'zamenik', 'Zamenik Sefa', 0, '{}', '{}'),
	(72, 'ballas', 3, 'boss', 'Sef', 0, '{}', '{}'),
	(73, 'automafija', 0, 'novi', 'Novi', 0, '{}', '{}'),
	(74, 'automafija', 1, 'radnik', 'Radnik', 0, '{}', '{}'),
	(75, 'automafija', 2, 'zamenik', 'Zamenik Sefa', 0, '{}', '{}'),
	(76, 'automafija', 3, 'boss', 'Sef', 0, '{}', '{}'),
	(77, 'yakuza', 0, 'novi', 'Novi', 0, '{}', '{}'),
	(78, 'yakuza', 1, 'radnik', 'Radnik', 0, '{}', '{}'),
	(79, 'yakuza', 2, 'zamenik', 'Zamenik Sefa', 0, '{}', '{}'),
	(80, 'yakuza', 3, 'boss', 'Sef', 0, '{}', '{}'),
	(81, 'police', 0, 'recruit', 'Recrue', 20, '{}', '{}'),
	(82, 'police', 1, 'officer', 'Officier', 40, '{}', '{}'),
	(83, 'police', 2, 'sergeant', 'Sergent', 60, '{}', '{}'),
	(84, 'police', 3, 'lieutenant', 'Lieutenant', 85, '{}', '{}'),
	(85, 'police', 4, 'boss', 'Commandant', 100, '{}', '{}'),
	(86, 'police', 5, 'interventa', 'Interventna', 2500, '{}', '{}'),
	(87, 'police', 6, 'porucnik', 'Porucnik', 3000, '{}', '{}'),
	(88, 'police', 7, 'narednik', 'Narednik', 3200, '{}', '{}');
/*!40000 ALTER TABLE `job_grades` ENABLE KEYS */;

-- Dumping structure for table 71devmod.licenses
CREATE TABLE IF NOT EXISTS `licenses` (
  `type` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `label` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table 71devmod.licenses: ~5 rows (approximately)
/*!40000 ALTER TABLE `licenses` DISABLE KEYS */;
INSERT INTO `licenses` (`type`, `label`) VALUES
	('boat', 'Boat License'),
	('dmv', 'Driving Permit'),
	('drive', 'Drivers License'),
	('drive_bike', 'Motorcycle License'),
	('drive_truck', 'Commercial Drivers License');
/*!40000 ALTER TABLE `licenses` ENABLE KEYS */;

-- Dumping structure for table 71devmod.multicharacter_slots
CREATE TABLE IF NOT EXISTS `multicharacter_slots` (
  `identifier` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slots` int(11) NOT NULL,
  PRIMARY KEY (`identifier`) USING BTREE,
  KEY `slots` (`slots`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table 71devmod.multicharacter_slots: ~0 rows (approximately)
/*!40000 ALTER TABLE `multicharacter_slots` DISABLE KEYS */;
/*!40000 ALTER TABLE `multicharacter_slots` ENABLE KEYS */;

-- Dumping structure for table 71devmod.npwd_calls
CREATE TABLE IF NOT EXISTS `npwd_calls` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `transmitter` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `receiver` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_accepted` tinyint(4) DEFAULT 0,
  `start` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `end` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `identifier` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table 71devmod.npwd_calls: ~0 rows (approximately)
/*!40000 ALTER TABLE `npwd_calls` DISABLE KEYS */;
/*!40000 ALTER TABLE `npwd_calls` ENABLE KEYS */;

-- Dumping structure for table 71devmod.npwd_marketplace_listings
CREATE TABLE IF NOT EXISTS `npwd_marketplace_listings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `username` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `updatedAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `reported` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `identifier` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table 71devmod.npwd_marketplace_listings: ~0 rows (approximately)
/*!40000 ALTER TABLE `npwd_marketplace_listings` DISABLE KEYS */;
/*!40000 ALTER TABLE `npwd_marketplace_listings` ENABLE KEYS */;

-- Dumping structure for table 71devmod.npwd_match_profiles
CREATE TABLE IF NOT EXISTS `npwd_match_profiles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(90) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `bio` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `location` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `job` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tags` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `updatedAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`),
  UNIQUE KEY `identifier_UNIQUE` (`identifier`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table 71devmod.npwd_match_profiles: ~0 rows (approximately)
/*!40000 ALTER TABLE `npwd_match_profiles` DISABLE KEYS */;
INSERT INTO `npwd_match_profiles` (`id`, `identifier`, `name`, `image`, `bio`, `location`, `job`, `tags`, `createdAt`, `updatedAt`) VALUES
	(1, 'char1:192.168.0.171', 'Veliki Otac', 'https://upload.wikimedia.org/wikipedia/commons/a/ac/No_image_available.svg', '', '', '', '', '2022-01-19 13:28:29', '2022-01-19 13:28:29');
/*!40000 ALTER TABLE `npwd_match_profiles` ENABLE KEYS */;

-- Dumping structure for table 71devmod.npwd_match_views
CREATE TABLE IF NOT EXISTS `npwd_match_views` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `profile` int(11) NOT NULL,
  `liked` tinyint(4) DEFAULT 0,
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `updatedAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `match_profile_idx` (`profile`),
  KEY `identifier` (`identifier`),
  CONSTRAINT `match_profile` FOREIGN KEY (`profile`) REFERENCES `npwd_match_profiles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table 71devmod.npwd_match_views: ~0 rows (approximately)
/*!40000 ALTER TABLE `npwd_match_views` DISABLE KEYS */;
/*!40000 ALTER TABLE `npwd_match_views` ENABLE KEYS */;

-- Dumping structure for table 71devmod.npwd_messages
CREATE TABLE IF NOT EXISTS `npwd_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `message` varchar(512) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_identifier` varchar(48) COLLATE utf8mb4_unicode_ci NOT NULL,
  `conversation_id` varchar(512) COLLATE utf8mb4_unicode_ci NOT NULL,
  `isRead` tinyint(4) NOT NULL DEFAULT 0,
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `updatedAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `visible` tinyint(4) NOT NULL DEFAULT 1,
  `author` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_embed` tinyint(4) NOT NULL DEFAULT 0,
  `embed` varchar(512) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `user_identifier` (`user_identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table 71devmod.npwd_messages: ~0 rows (approximately)
/*!40000 ALTER TABLE `npwd_messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `npwd_messages` ENABLE KEYS */;

-- Dumping structure for table 71devmod.npwd_messages_conversations
CREATE TABLE IF NOT EXISTS `npwd_messages_conversations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_identifier` varchar(48) COLLATE utf8mb4_unicode_ci NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `updatedAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `conversation_id` varchar(512) COLLATE utf8mb4_unicode_ci NOT NULL,
  `participant_identifier` varchar(48) COLLATE utf8mb4_unicode_ci NOT NULL,
  `label` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `unreadCount` int(11) NOT NULL DEFAULT 0,
  `unread` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_identifier` (`user_identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table 71devmod.npwd_messages_conversations: ~0 rows (approximately)
/*!40000 ALTER TABLE `npwd_messages_conversations` DISABLE KEYS */;
/*!40000 ALTER TABLE `npwd_messages_conversations` ENABLE KEYS */;

-- Dumping structure for table 71devmod.npwd_notes
CREATE TABLE IF NOT EXISTS `npwd_notes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `identifier` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table 71devmod.npwd_notes: ~0 rows (approximately)
/*!40000 ALTER TABLE `npwd_notes` DISABLE KEYS */;
/*!40000 ALTER TABLE `npwd_notes` ENABLE KEYS */;

-- Dumping structure for table 71devmod.npwd_phone_contacts
CREATE TABLE IF NOT EXISTS `npwd_phone_contacts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `number` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `display` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `identifier` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table 71devmod.npwd_phone_contacts: ~0 rows (approximately)
/*!40000 ALTER TABLE `npwd_phone_contacts` DISABLE KEYS */;
/*!40000 ALTER TABLE `npwd_phone_contacts` ENABLE KEYS */;

-- Dumping structure for table 71devmod.npwd_phone_gallery
CREATE TABLE IF NOT EXISTS `npwd_phone_gallery` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `identifier` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table 71devmod.npwd_phone_gallery: ~0 rows (approximately)
/*!40000 ALTER TABLE `npwd_phone_gallery` DISABLE KEYS */;
/*!40000 ALTER TABLE `npwd_phone_gallery` ENABLE KEYS */;

-- Dumping structure for table 71devmod.npwd_twitter_likes
CREATE TABLE IF NOT EXISTS `npwd_twitter_likes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `profile_id` int(11) NOT NULL,
  `tweet_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_combination` (`profile_id`,`tweet_id`),
  KEY `profile_idx` (`profile_id`),
  KEY `tweet_idx` (`tweet_id`),
  CONSTRAINT `profile` FOREIGN KEY (`profile_id`) REFERENCES `npwd_twitter_profiles` (`id`),
  CONSTRAINT `tweet` FOREIGN KEY (`tweet_id`) REFERENCES `npwd_twitter_tweets` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table 71devmod.npwd_twitter_likes: ~0 rows (approximately)
/*!40000 ALTER TABLE `npwd_twitter_likes` DISABLE KEYS */;
/*!40000 ALTER TABLE `npwd_twitter_likes` ENABLE KEYS */;

-- Dumping structure for table 71devmod.npwd_twitter_profiles
CREATE TABLE IF NOT EXISTS `npwd_twitter_profiles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `profile_name` varchar(90) COLLATE utf8mb4_unicode_ci NOT NULL,
  `identifier` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `avatar_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'https://i.file.glass/QrEvq.png',
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `updatedAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `profile_name_UNIQUE` (`profile_name`),
  KEY `identifier` (`identifier`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table 71devmod.npwd_twitter_profiles: ~4 rows (approximately)
/*!40000 ALTER TABLE `npwd_twitter_profiles` DISABLE KEYS */;
INSERT INTO `npwd_twitter_profiles` (`id`, `profile_name`, `identifier`, `avatar_url`, `createdAt`, `updatedAt`) VALUES
	(1, 'Veliki_Otac', 'char1:192.168.0.171', 'https://i.file.glass/QrEvq.png', '2022-01-19 13:08:38', '2022-01-19 13:08:38'),
	(2, '3765029822', '192.168.0.171', 'https://i.file.glass/QrEvq.png', '2022-01-19 13:22:37', '2022-01-19 13:22:37'),
	(5, 'Bog_Almin', 'char2:192.168.0.171', 'https://i.file.glass/QrEvq.png', '2022-01-26 22:01:52', '2022-01-26 22:01:52'),
	(6, 'Test_Almin', 'char3:192.168.0.171', 'https://i.file.glass/QrEvq.png', '2022-01-26 22:06:35', '2022-01-26 22:06:35');
/*!40000 ALTER TABLE `npwd_twitter_profiles` ENABLE KEYS */;

-- Dumping structure for table 71devmod.npwd_twitter_reports
CREATE TABLE IF NOT EXISTS `npwd_twitter_reports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `profile_id` int(11) NOT NULL,
  `tweet_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_combination` (`profile_id`,`tweet_id`),
  KEY `profile_idx` (`profile_id`),
  KEY `tweet_idx` (`tweet_id`),
  CONSTRAINT `report_profile` FOREIGN KEY (`profile_id`) REFERENCES `npwd_twitter_profiles` (`id`),
  CONSTRAINT `report_tweet` FOREIGN KEY (`tweet_id`) REFERENCES `npwd_twitter_tweets` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table 71devmod.npwd_twitter_reports: ~0 rows (approximately)
/*!40000 ALTER TABLE `npwd_twitter_reports` DISABLE KEYS */;
/*!40000 ALTER TABLE `npwd_twitter_reports` ENABLE KEYS */;

-- Dumping structure for table 71devmod.npwd_twitter_tweets
CREATE TABLE IF NOT EXISTS `npwd_twitter_tweets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `message` varchar(1000) COLLATE utf8mb4_unicode_ci NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `updatedAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `likes` int(11) NOT NULL DEFAULT 0,
  `identifier` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `visible` tinyint(4) NOT NULL DEFAULT 1,
  `images` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `retweet` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `identifier` (`identifier`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table 71devmod.npwd_twitter_tweets: ~1 rows (approximately)
/*!40000 ALTER TABLE `npwd_twitter_tweets` DISABLE KEYS */;
INSERT INTO `npwd_twitter_tweets` (`id`, `message`, `createdAt`, `updatedAt`, `likes`, `identifier`, `visible`, `images`, `retweet`) VALUES
	(1, 'almin je otac, ovo ce svi vidjeti koji skinu mod', '2022-01-26 20:16:25', '2022-01-26 20:16:25', 0, 'char1:192.168.0.171', 1, '', NULL);
/*!40000 ALTER TABLE `npwd_twitter_tweets` ENABLE KEYS */;

-- Dumping structure for table 71devmod.okokbanking_societies
CREATE TABLE IF NOT EXISTS `okokbanking_societies` (
  `society` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `society_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` int(50) DEFAULT NULL,
  `iban` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_withdrawing` int(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table 71devmod.okokbanking_societies: ~0 rows (approximately)
/*!40000 ALTER TABLE `okokbanking_societies` DISABLE KEYS */;
INSERT INTO `okokbanking_societies` (`society`, `society_name`, `value`, `iban`, `is_withdrawing`) VALUES
	('society_police', 'Police', 1000, 'BAPOLICE', NULL);
/*!40000 ALTER TABLE `okokbanking_societies` ENABLE KEYS */;

-- Dumping structure for table 71devmod.okokbanking_transactions
CREATE TABLE IF NOT EXISTS `okokbanking_transactions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `receiver_identifier` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `receiver_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sender_identifier` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sender_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` int(50) NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table 71devmod.okokbanking_transactions: ~3 rows (approximately)
/*!40000 ALTER TABLE `okokbanking_transactions` DISABLE KEYS */;
INSERT INTO `okokbanking_transactions` (`id`, `receiver_identifier`, `receiver_name`, `sender_identifier`, `sender_name`, `date`, `value`, `type`) VALUES
	(1, 'bank', 'Bank (PIN)', 'char1:192.168.0.171', 'Koreli Almin', '2022-01-22 16:36:53', 0, 'transfer'),
	(2, 'bank', 'Bank (IBAN)', 'char1:192.168.0.171', 'Koreli Almin', '2022-01-22 16:37:41', 5000, 'transfer'),
	(3, 'society_police', 'Police', 'char1:192.168.0.171', 'Koreli Almin', '2022-01-22 17:31:17', 1000, 'deposit');
/*!40000 ALTER TABLE `okokbanking_transactions` ENABLE KEYS */;

-- Dumping structure for table 71devmod.outfits
CREATE TABLE IF NOT EXISTS `outfits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ped` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `components` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `props` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table 71devmod.outfits: ~0 rows (approximately)
/*!40000 ALTER TABLE `outfits` DISABLE KEYS */;
/*!40000 ALTER TABLE `outfits` ENABLE KEYS */;

-- Dumping structure for table 71devmod.owned_properties
CREATE TABLE IF NOT EXISTS `owned_properties` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` double NOT NULL,
  `rented` int(11) NOT NULL,
  `owner` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table 71devmod.owned_properties: ~0 rows (approximately)
/*!40000 ALTER TABLE `owned_properties` DISABLE KEYS */;
/*!40000 ALTER TABLE `owned_properties` ENABLE KEYS */;

-- Dumping structure for table 71devmod.owned_vehicles
CREATE TABLE IF NOT EXISTS `owned_vehicles` (
  `owner` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `plate` varchar(12) COLLATE utf8mb4_unicode_ci NOT NULL,
  `vehicle` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'car',
  `job` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `stored` tinyint(1) NOT NULL DEFAULT 0,
  `trunk` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `glovebox` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `health` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `garage` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`plate`),
  KEY `owner` (`owner`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table 71devmod.owned_vehicles: ~8 rows (approximately)
/*!40000 ALTER TABLE `owned_vehicles` DISABLE KEYS */;
INSERT INTO `owned_vehicles` (`owner`, `plate`, `vehicle`, `type`, `job`, `stored`, `trunk`, `glovebox`, `health`, `garage`) VALUES
	('char1:192.168.0.171', 'CGYE8538', '{"modRearBumper":-1,"modDoorR":-1,"modStruts":-1,"tyreSmokeColor":[255,255,255],"modExhaust":-1,"modFrame":-1,"modFrontWheels":-1,"modEngine":-1,"modBackWheels":-1,"customSecondaryColor":[255,255,255],"modLivery":-1,"xenonColor":255,"modSmokeEnabled":false,"modSteeringWheel":-1,"fuelLevel":55.5,"modShifterLeavers":-1,"modRightFender":-1,"modGrille":-1,"modHood":-1,"modTrimA":-1,"modSeats":-1,"modWindows":-1,"modFrontBumper":-1,"pearlescentColor":18,"neonEnabled":[false,false,false,false],"modOrnaments":-1,"modVanityPlate":-1,"neonColor":[255,0,255],"modFender":-1,"modSuspension":-1,"color2":118,"modAirFilter":-1,"modTrunk":-1,"dirtLevel":3.4,"modTrimB":-1,"bodyHealth":809.6,"windowTint":-1,"plateIndex":0,"modTurbo":false,"extras":[],"customPrimaryColor":[255,255,255],"modTank":-1,"modSideSkirt":-1,"wheelColor":156,"wheels":0,"modSpoilers":-1,"modDoorSpeaker":-1,"modPlateHolder":-1,"modSpeakers":-1,"modLightbar":-1,"modEngineBlock":-1,"engineHealth":990.7,"modAerials":-1,"plate":"CGYE8538","modHorns":-1,"model":-1758137366,"modArchCover":-1,"modTransmission":-1,"modBrakes":-1,"modDashboard":-1,"color1":64,"modRoof":-1,"modAPlate":-1,"modDial":-1,"tankHealth":978.4,"modHydrolic":-1,"modArmor":-1,"modXenon":false}', 'car', NULL, 0, NULL, NULL, '{"body":809.58,"engine":990.67,"parts":{"tires":[],"windows":[1,2,3,4,5,6,7],"doors":[4]}}', 'none'),
	('char1:192.168.0.171', 'DGJL3646', '{"model":1265391242,"wheels":6,"modOrnaments":-1,"modTrimA":-1,"modSeats":-1,"modHydrolic":-1,"modBackWheels":-1,"windowTint":-1,"modHorns":-1,"modSpeakers":-1,"tyreSmokeColor":[255,255,255],"modEngine":-1,"modRightFender":-1,"neonEnabled":[false,false,false,false],"modExhaust":-1,"fuelLevel":63.7,"modDashboard":-1,"modShifterLeavers":-1,"modFrame":-1,"customPrimaryColor":[0,255,255],"modArmor":-1,"modLightbar":-1,"modRoof":-1,"modSuspension":-1,"pearlescentColor":27,"color2":27,"plate":"DGJL3646","modDoorR":-1,"neonColor":[255,0,255],"plateIndex":0,"modAPlate":-1,"wheelColor":27,"modTank":-1,"modRearBumper":-1,"modXenon":false,"modFender":-1,"modFrontWheels":-1,"modHood":-1,"modWindows":-1,"dirtLevel":4.1,"bodyHealth":878.4,"modArchCover":-1,"modSpoilers":-1,"modSmokeEnabled":false,"modSteeringWheel":-1,"modVanityPlate":-1,"modTrunk":-1,"modStruts":-1,"modDial":-1,"modTransmission":-1,"modFrontBumper":-1,"modTrimB":-1,"modPlateHolder":-1,"modAirFilter":-1,"modLivery":-1,"modDoorSpeaker":-1,"modGrille":-1,"engineHealth":942.8,"color1":27,"customSecondaryColor":[0,255,255],"modAerials":-1,"xenonColor":255,"modEngineBlock":-1,"modTurbo":false,"modSideSkirt":-1,"tankHealth":959.5,"extras":[],"modBrakes":-1}', 'car', NULL, 1, NULL, NULL, '{"engine":942.77,"parts":{"tires":[],"doors":[],"windows":[0,1,2,3,4,5,6,7]},"body":878.43}', 'legion'),
	('char1:192.168.0.171', 'EFXQ4109', '{"modVanityPlate":-1,"customPrimaryColor":[255,255,255],"modTrunk":-1,"color2":29,"modLightbar":-1,"modFender":-1,"modSmokeEnabled":false,"modRearBumper":-1,"modDoorSpeaker":-1,"modFrontWheels":-1,"dirtLevel":0.1,"modOrnaments":-1,"modSteeringWheel":-1,"modHood":-1,"modEngineBlock":-1,"extras":[],"modSpoilers":-1,"modEngine":-1,"modTurbo":false,"modHydrolic":-1,"modPlateHolder":-1,"modTrimB":-1,"engineHealth":990.4,"modRightFender":-1,"wheels":1,"modFrame":-1,"modWindows":-1,"modAPlate":-1,"modShifterLeavers":-1,"pearlescentColor":6,"modRoof":-1,"modDashboard":-1,"modLivery":-1,"modTransmission":-1,"modDoorR":-1,"modBrakes":-1,"modDial":-1,"neonEnabled":[false,false,false,false],"modSideSkirt":-1,"modAerials":-1,"modTrimA":-1,"modSeats":-1,"modSpeakers":-1,"plateIndex":0,"fuelLevel":62.8,"xenonColor":255,"wheelColor":0,"modBackWheels":-1,"modAirFilter":-1,"modFrontBumper":-1,"modStruts":-1,"bodyHealth":998.0,"windowTint":-1,"modTank":-1,"modGrille":-1,"plate":"EFXQ4109","customSecondaryColor":[255,255,255],"modExhaust":-1,"model":1644055914,"modXenon":false,"modArchCover":-1,"color1":29,"modSuspension":-1,"modHorns":-1,"tyreSmokeColor":[255,255,255],"neonColor":[255,0,255],"modArmor":-1,"tankHealth":999.5}', 'car', NULL, 1, NULL, NULL, '{"parts":{"windows":[2,3,4,5,6,7],"doors":[],"tires":[]},"body":998.0,"engine":990.4}', 'legion'),
	('char1:192.168.0.171', 'EHSC0233', '{"modHood":-1,"modFrontBumper":-1,"modFrontWheels":-1,"modSteeringWheel":-1,"model":1934384720,"modStruts":-1,"modAerials":-1,"modSpeakers":-1,"windowTint":-1,"modRoof":-1,"tyreSmokeColor":[255,255,255],"modTrimB":-1,"modAPlate":-1,"modSpoilers":-1,"modSideSkirt":-1,"dirtLevel":5.1,"modSuspension":-1,"wheelColor":0,"modGrille":-1,"pearlescentColor":29,"modLivery":-1,"modEngine":-1,"modTurbo":false,"modShifterLeavers":-1,"color1":28,"customSecondaryColor":[255,255,255],"bodyHealth":632.6,"modEngineBlock":-1,"customPrimaryColor":[255,255,255],"fuelLevel":62.8,"modDashboard":-1,"engineHealth":889.5,"modArchCover":-1,"modHydrolic":-1,"modXenon":false,"modBrakes":-1,"neonEnabled":[false,false,false,false],"modPlateHolder":-1,"modSmokeEnabled":false,"modDoorR":-1,"modFender":-1,"modHorns":-1,"wheels":1,"modExhaust":-1,"modTank":-1,"xenonColor":255,"modTrunk":-1,"plate":"EHSC0233","modWindows":-1,"neonColor":[255,0,255],"modTransmission":-1,"modFrame":-1,"modDial":-1,"modOrnaments":-1,"plateIndex":0,"tankHealth":1000.0,"modAirFilter":-1,"modTrimA":-1,"modArmor":-1,"modVanityPlate":-1,"modRightFender":-1,"modLightbar":-1,"modRearBumper":-1,"color2":28,"modBackWheels":-1,"modSeats":-1,"extras":[],"modDoorSpeaker":-1}', 'car', NULL, 1, NULL, NULL, '{"body":632.59,"engine":889.48,"parts":{"tires":[],"windows":[2,3,4,5,6,7],"doors":[]}}', 'legion'),
	('char1:192.168.0.171', 'GYCK5361', '{"neonEnabled":[false,false,false,false],"modTrunk":-1,"modHydrolic":-1,"plate":"GYCK5361","color2":111,"pearlescentColor":3,"modEngineBlock":-1,"customPrimaryColor":[255,255,255],"wheels":6,"modDoorSpeaker":-1,"modSpoilers":-1,"bodyHealth":1000.0,"modLightbar":-1,"neonColor":[255,0,255],"modSmokeEnabled":false,"color1":1,"model":-186537451,"modTank":-1,"wheelColor":156,"engineHealth":1000.0,"tankHealth":1000.0,"modFender":-1,"modAirFilter":-1,"modDashboard":-1,"modTurbo":false,"modGrille":-1,"modTrimB":-1,"modSideSkirt":-1,"customSecondaryColor":[255,255,255],"modFrontWheels":-1,"modRoof":-1,"modDoorR":-1,"modSpeakers":-1,"dirtLevel":8.0,"modXenon":false,"modRearBumper":-1,"modVanityPlate":-1,"modExhaust":-1,"modWindows":-1,"plateIndex":0,"modDial":-1,"modFrame":-1,"modRightFender":-1,"modArmor":-1,"modSteeringWheel":-1,"modPlateHolder":-1,"modEngine":-1,"modTransmission":-1,"windowTint":-1,"modHood":-1,"modTrimA":-1,"modAerials":-1,"modLivery":-1,"modFrontBumper":-1,"modBrakes":-1,"modSeats":-1,"modShifterLeavers":-1,"modHorns":-1,"xenonColor":255,"modOrnaments":-1,"modBackWheels":-1,"fuelLevel":0.0,"modStruts":-1,"tyreSmokeColor":[255,255,255],"modAPlate":-1,"modSuspension":-1,"modArchCover":-1,"extras":{"2":true,"1":true}}', 'car', NULL, 1, NULL, NULL, '{"parts":{"windows":[0,1,2,3,4,5,6,7],"doors":[],"tires":[]},"engine":1000.0,"body":1000.0}', 'legion'),
	('char1:192.168.0.171', 'NIFX8114', '{"modFrontBumper":-1,"wheels":3,"modSideSkirt":-1,"modShifterLeavers":-1,"tyreSmokeColor":[255,255,255],"modSeats":-1,"color2":30,"modAPlate":-1,"modHorns":-1,"modDashboard":-1,"modGrille":-1,"modStruts":-1,"color1":22,"modXenon":false,"modLightbar":-1,"customPrimaryColor":[255,255,255],"model":83136452,"modArchCover":-1,"modAerials":-1,"modAirFilter":-1,"modPlateHolder":-1,"modBackWheels":-1,"modHood":-1,"modVanityPlate":-1,"neonColor":[255,0,255],"modRearBumper":-1,"bodyHealth":996.3,"modSuspension":-1,"modDoorSpeaker":-1,"fuelLevel":78.1,"modTrimA":-1,"modTank":-1,"modSpeakers":-1,"modTurbo":false,"plate":"NIFX8114","modBrakes":-1,"modTrimB":-1,"modHydrolic":-1,"modFender":-1,"modSteeringWheel":-1,"modFrame":-1,"modSmokeEnabled":false,"modRightFender":-1,"neonEnabled":[false,false,false,false],"dirtLevel":0.1,"modEngine":-1,"modSpoilers":-1,"windowTint":-1,"modExhaust":-1,"modDial":-1,"customSecondaryColor":[255,255,255],"modEngineBlock":-1,"tankHealth":999.6,"wheelColor":0,"modOrnaments":-1,"extras":[],"modLivery":-1,"modFrontWheels":-1,"plateIndex":0,"modTrunk":-1,"modDoorR":-1,"modTransmission":-1,"pearlescentColor":4,"xenonColor":255,"engineHealth":994.4,"modWindows":-1,"modRoof":-1,"modArmor":-1}', 'car', NULL, 1, NULL, NULL, '{"engine":994.38,"body":996.25,"parts":{"doors":[],"tires":[],"windows":[4,5,6,7]}}', 'legion'),
	('char1:192.168.0.171', 'RVZV7718', '{"modFrontBumper":-1,"wheels":7,"modSideSkirt":-1,"modShifterLeavers":-1,"tyreSmokeColor":[255,255,255],"modSeats":-1,"color2":0,"modAPlate":-1,"modHorns":-1,"modDashboard":-1,"modGrille":-1,"modStruts":-1,"color1":0,"modXenon":false,"modLightbar":-1,"customPrimaryColor":[255,255,255],"model":-591610296,"modArchCover":-1,"modAerials":-1,"modAirFilter":-1,"modPlateHolder":-1,"modBackWheels":-1,"modHood":-1,"modVanityPlate":-1,"neonColor":[255,0,255],"modRearBumper":-1,"bodyHealth":997.5,"modSuspension":-1,"modDoorSpeaker":-1,"fuelLevel":62.3,"modTrimA":-1,"modTank":-1,"modSpeakers":-1,"modTurbo":false,"plate":"RVZV7718","modBrakes":-1,"modTrimB":-1,"modHydrolic":-1,"modFender":-1,"modSteeringWheel":-1,"modFrame":-1,"modSmokeEnabled":false,"modRightFender":-1,"neonEnabled":[false,false,false,false],"dirtLevel":3.1,"modEngine":-1,"modSpoilers":-1,"windowTint":-1,"modExhaust":-1,"modDial":-1,"customSecondaryColor":[255,255,255],"modEngineBlock":-1,"tankHealth":999.4,"wheelColor":156,"modOrnaments":-1,"extras":{"12":false,"10":false},"modLivery":-1,"modFrontWheels":-1,"plateIndex":0,"modTrunk":-1,"modDoorR":-1,"modTransmission":-1,"pearlescentColor":3,"xenonColor":255,"engineHealth":998.5,"modWindows":-1,"modRoof":-1,"modArmor":-1}', 'car', NULL, 1, NULL, NULL, '{"engine":998.5,"body":997.5,"parts":{"doors":[],"tires":[],"windows":[2,3,4,5,6,7]}}', 'legion'),
	('char1:192.168.0.171', 'SIKS9404', '{"modFrontWheels":-1,"modTurbo":false,"tyreSmokeColor":[255,255,255],"bodyHealth":997.3,"modLightbar":-1,"modBackWheels":-1,"modArchCover":-1,"modFender":-1,"modEngineBlock":-1,"modWindows":-1,"modFrontBumper":-1,"modAerials":-1,"modStruts":-1,"modFrame":-1,"modPlateHolder":-1,"modRightFender":-1,"modRearBumper":-1,"wheels":4,"modHorns":-1,"modTrunk":-1,"color2":0,"modSmokeEnabled":false,"pearlescentColor":28,"modTrimB":-1,"modLivery":-1,"modAirFilter":-1,"modSeats":-1,"modTank":-1,"wheelColor":156,"modSpoilers":-1,"modTrimA":-1,"modRoof":-1,"modOrnaments":-1,"modDial":-1,"neonEnabled":[false,false,false,false],"plate":"SIKS9404","neonColor":[255,0,255],"windowTint":-1,"extras":{"1":true,"2":true},"fuelLevel":7.8,"modArmor":-1,"modGrille":-1,"customPrimaryColor":[255,255,255],"modSideSkirt":-1,"modHood":-1,"customSecondaryColor":[255,255,255],"modBrakes":-1,"modXenon":false,"engineHealth":1000.0,"modEngine":-1,"modHydrolic":-1,"modDashboard":-1,"plateIndex":0,"modExhaust":-1,"modAPlate":-1,"modVanityPlate":-1,"tankHealth":998.4,"modShifterLeavers":-1,"modSuspension":-1,"modDoorR":-1,"model":-48031959,"modTransmission":-1,"dirtLevel":5.1,"color1":132,"xenonColor":255,"modSteeringWheel":-1,"modSpeakers":-1,"modDoorSpeaker":-1}', 'car', NULL, 1, NULL, NULL, '{"engine":1000.0,"body":997.25,"parts":{"windows":[0,1,2,3,4,5,6,7],"tires":[],"doors":[]}}', 'legion');
/*!40000 ALTER TABLE `owned_vehicles` ENABLE KEYS */;

-- Dumping structure for table 71devmod.ox_inventory
CREATE TABLE IF NOT EXISTS `ox_inventory` (
  `owner` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `data` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lastupdated` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  UNIQUE KEY `owner` (`owner`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table 71devmod.ox_inventory: ~1 rows (approximately)
/*!40000 ALTER TABLE `ox_inventory` DISABLE KEYS */;
INSERT INTO `ox_inventory` (`owner`, `name`, `data`, `lastupdated`) VALUES
	('', 'society_ambulance', '[{"count":4,"name":"medikit","slot":1},{"count":4,"name":"bandage","slot":2}]', '2022-01-26 17:21:14');
/*!40000 ALTER TABLE `ox_inventory` ENABLE KEYS */;

-- Dumping structure for table 71devmod.phone_app_chat
CREATE TABLE IF NOT EXISTS `phone_app_chat` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `channel` varchar(20) NOT NULL,
  `message` varchar(255) NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=268 DEFAULT CHARSET=utf8;

-- Dumping data for table 71devmod.phone_app_chat: ~0 rows (approximately)
/*!40000 ALTER TABLE `phone_app_chat` DISABLE KEYS */;
/*!40000 ALTER TABLE `phone_app_chat` ENABLE KEYS */;

-- Dumping structure for table 71devmod.phone_calls
CREATE TABLE IF NOT EXISTS `phone_calls` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner` varchar(10) NOT NULL,
  `num` varchar(10) NOT NULL,
  `incoming` int(11) NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `accepts` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16291 DEFAULT CHARSET=utf8;

-- Dumping data for table 71devmod.phone_calls: ~0 rows (approximately)
/*!40000 ALTER TABLE `phone_calls` DISABLE KEYS */;
/*!40000 ALTER TABLE `phone_calls` ENABLE KEYS */;

-- Dumping structure for table 71devmod.phone_messages
CREATE TABLE IF NOT EXISTS `phone_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `transmitter` varchar(10) NOT NULL,
  `receiver` varchar(10) NOT NULL,
  `message` varchar(255) NOT NULL DEFAULT '0',
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `isRead` int(11) NOT NULL DEFAULT 0,
  `owner` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=45221 DEFAULT CHARSET=utf8;

-- Dumping data for table 71devmod.phone_messages: 2 rows
/*!40000 ALTER TABLE `phone_messages` DISABLE KEYS */;
INSERT INTO `phone_messages` (`id`, `transmitter`, `receiver`, `message`, `time`, `isRead`, `owner`) VALUES
	(45219, 'ambulance', '942-401-18', 'De #942-401-1818 : Hitna pomoc potrebam, gradjanin u nesvesti! 263.02304077148, -842.26098632812', '2022-01-26 23:00:47', 0, 0),
	(45220, 'ambulance', '942-401-18', 'De #942-401-1818 : Hitna pomoc potrebam, gradjanin u nesvesti! 298.76272583008, -860.46606445312', '2022-01-26 23:01:18', 0, 0);
/*!40000 ALTER TABLE `phone_messages` ENABLE KEYS */;

-- Dumping structure for table 71devmod.phone_users_contacts
CREATE TABLE IF NOT EXISTS `phone_users_contacts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(60) CHARACTER SET utf8mb4 DEFAULT NULL,
  `number` varchar(10) CHARACTER SET utf8mb4 DEFAULT NULL,
  `display` varchar(64) CHARACTER SET utf8mb4 NOT NULL DEFAULT '-1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=992 DEFAULT CHARSET=utf8;

-- Dumping data for table 71devmod.phone_users_contacts: 0 rows
/*!40000 ALTER TABLE `phone_users_contacts` DISABLE KEYS */;
/*!40000 ALTER TABLE `phone_users_contacts` ENABLE KEYS */;

-- Dumping structure for table 71devmod.properties
CREATE TABLE IF NOT EXISTS `properties` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `label` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `entering` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `exit` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `inside` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `outside` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ipls` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '[]',
  `gateway` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_single` int(11) DEFAULT NULL,
  `is_room` int(11) DEFAULT NULL,
  `is_gateway` int(11) DEFAULT NULL,
  `room_menu` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table 71devmod.properties: ~42 rows (approximately)
/*!40000 ALTER TABLE `properties` DISABLE KEYS */;
INSERT INTO `properties` (`id`, `name`, `label`, `entering`, `exit`, `inside`, `outside`, `ipls`, `gateway`, `is_single`, `is_room`, `is_gateway`, `room_menu`, `price`) VALUES
	(1, 'WhispymoundDrive', '2677 Whispymound Drive', '{"y":564.89, "z":182.959, "x":119.384}', '{"x":117.347, "y":559.506, "z":183.304}', '{"y":557.032, "z":183.301, "x":118.037}', '{"y":567.798, "z":182.131, "x":119.249}', '[]', NULL, 1, 1, 0, '{"x":118.748, "y":566.573, "z":175.697}', 1500000),
	(2, 'NorthConkerAvenue2045', '2045 North Conker Avenue', '{"x":372.796, "y":428.327, "z":144.685}', '{"x":373.548, "y":422.982, "z":144.907}', '{"y":420.075, "z":145.904, "x":372.161}', '{"x":372.454, "y":432.886, "z":143.443}', '[]', NULL, 1, 1, 0, '{"x":377.349, "y":429.422, "z":137.3}', 1500000),
	(3, 'RichardMajesticApt2', 'Richard Majestic, Apt 2', '{"y":-379.165, "z":37.961, "x":-936.363}', '{"y":-365.476, "z":113.274, "x":-913.097}', '{"y":-367.637, "z":113.274, "x":-918.022}', '{"y":-382.023, "z":37.961, "x":-943.626}', '[]', NULL, 1, 1, 0, '{"x":-927.554, "y":-377.744, "z":112.674}', 1700000),
	(4, 'NorthConkerAvenue2044', '2044 North Conker Avenue', '{"y":440.8, "z":146.702, "x":346.964}', '{"y":437.456, "z":148.394, "x":341.683}', '{"y":435.626, "z":148.394, "x":339.595}', '{"x":350.535, "y":443.329, "z":145.764}', '[]', NULL, 1, 1, 0, '{"x":337.726, "y":436.985, "z":140.77}', 1500000),
	(5, 'WildOatsDrive', '3655 Wild Oats Drive', '{"y":502.696, "z":136.421, "x":-176.003}', '{"y":497.817, "z":136.653, "x":-174.349}', '{"y":495.069, "z":136.666, "x":-173.331}', '{"y":506.412, "z":135.0664, "x":-177.927}', '[]', NULL, 1, 1, 0, '{"x":-174.725, "y":493.095, "z":129.043}', 1500000),
	(6, 'HillcrestAvenue2862', '2862 Hillcrest Avenue', '{"y":596.58, "z":142.641, "x":-686.554}', '{"y":591.988, "z":144.392, "x":-681.728}', '{"y":590.608, "z":144.392, "x":-680.124}', '{"y":599.019, "z":142.059, "x":-689.492}', '[]', NULL, 1, 1, 0, '{"x":-680.46, "y":588.6, "z":136.769}', 1500000),
	(7, 'LowEndApartment', 'Basic apartment', '{"y":-1078.735, "z":28.4031, "x":292.528}', '{"y":-1007.152, "z":-102.002, "x":265.845}', '{"y":-1002.802, "z":-100.008, "x":265.307}', '{"y":-1078.669, "z":28.401, "x":296.738}', '[]', NULL, 1, 1, 0, '{"x":265.916, "y":-999.38, "z":-100.008}', 562500),
	(8, 'MadWayneThunder', '2113 Mad Wayne Thunder', '{"y":454.955, "z":96.462, "x":-1294.433}', '{"x":-1289.917, "y":449.541, "z":96.902}', '{"y":446.322, "z":96.899, "x":-1289.642}', '{"y":455.453, "z":96.517, "x":-1298.851}', '[]', NULL, 1, 1, 0, '{"x":-1287.306, "y":455.901, "z":89.294}', 1500000),
	(9, 'HillcrestAvenue2874', '2874 Hillcrest Avenue', '{"x":-853.346, "y":696.678, "z":147.782}', '{"y":690.875, "z":151.86, "x":-859.961}', '{"y":688.361, "z":151.857, "x":-859.395}', '{"y":701.628, "z":147.773, "x":-855.007}', '[]', NULL, 1, 1, 0, '{"x":-858.543, "y":697.514, "z":144.253}', 1500000),
	(10, 'HillcrestAvenue2868', '2868 Hillcrest Avenue', '{"y":620.494, "z":141.588, "x":-752.82}', '{"y":618.62, "z":143.153, "x":-759.317}', '{"y":617.629, "z":143.153, "x":-760.789}', '{"y":621.281, "z":141.254, "x":-750.919}', '[]', NULL, 1, 1, 0, '{"x":-762.504, "y":618.992, "z":135.53}', 1500000),
	(11, 'TinselTowersApt12', 'Tinsel Towers, Apt 42', '{"y":37.025, "z":42.58, "x":-618.299}', '{"y":58.898, "z":97.2, "x":-603.301}', '{"y":58.941, "z":97.2, "x":-608.741}', '{"y":30.603, "z":42.524, "x":-620.017}', '[]', NULL, 1, 1, 0, '{"x":-622.173, "y":54.585, "z":96.599}', 1700000),
	(12, 'MiltonDrive', 'Milton Drive', '{"x":-775.17, "y":312.01, "z":84.658}', NULL, NULL, '{"x":-775.346, "y":306.776, "z":84.7}', '[]', NULL, 0, 0, 1, NULL, 0),
	(13, 'Modern1Apartment', 'Modern Apartment 1', NULL, '{"x":-784.194, "y":323.636, "z":210.997}', '{"x":-779.751, "y":323.385, "z":210.997}', NULL, '["apa_v_mp_h_01_a"]', 'MiltonDrive', 0, 1, 0, '{"x":-766.661, "y":327.672, "z":210.396}', 1300000),
	(14, 'Modern2Apartment', 'Modern Apartment 2', NULL, '{"x":-786.8663, "y":315.764, "z":186.913}', '{"x":-781.808, "y":315.866, "z":186.913}', NULL, '["apa_v_mp_h_01_c"]', 'MiltonDrive', 0, 1, 0, '{"x":-795.735, "y":326.757, "z":186.313}', 1300000),
	(15, 'Modern3Apartment', 'Modern Apartment 3', NULL, '{"x":-774.012, "y":342.042, "z":195.686}', '{"x":-779.057, "y":342.063, "z":195.686}', NULL, '["apa_v_mp_h_01_b"]', 'MiltonDrive', 0, 1, 0, '{"x":-765.386, "y":330.782, "z":195.08}', 1300000),
	(16, 'Mody1Apartment', 'Mody Apartment 1', NULL, '{"x":-784.194, "y":323.636, "z":210.997}', '{"x":-779.751, "y":323.385, "z":210.997}', NULL, '["apa_v_mp_h_02_a"]', 'MiltonDrive', 0, 1, 0, '{"x":-766.615, "y":327.878, "z":210.396}', 1300000),
	(17, 'Mody2Apartment', 'Mody Apartment 2', NULL, '{"x":-786.8663, "y":315.764, "z":186.913}', '{"x":-781.808, "y":315.866, "z":186.913}', NULL, '["apa_v_mp_h_02_c"]', 'MiltonDrive', 0, 1, 0, '{"x":-795.297, "y":327.092, "z":186.313}', 1300000),
	(18, 'Mody3Apartment', 'Mody Apartment 3', NULL, '{"x":-774.012, "y":342.042, "z":195.686}', '{"x":-779.057, "y":342.063, "z":195.686}', NULL, '["apa_v_mp_h_02_b"]', 'MiltonDrive', 0, 1, 0, '{"x":-765.303, "y":330.932, "z":195.085}', 1300000),
	(19, 'Vibrant1Apartment', 'Vibrant Apartment 1', NULL, '{"x":-784.194, "y":323.636, "z":210.997}', '{"x":-779.751, "y":323.385, "z":210.997}', NULL, '["apa_v_mp_h_03_a"]', 'MiltonDrive', 0, 1, 0, '{"x":-765.885, "y":327.641, "z":210.396}', 1300000),
	(20, 'Vibrant2Apartment', 'Vibrant Apartment 2', NULL, '{"x":-786.8663, "y":315.764, "z":186.913}', '{"x":-781.808, "y":315.866, "z":186.913}', NULL, '["apa_v_mp_h_03_c"]', 'MiltonDrive', 0, 1, 0, '{"x":-795.607, "y":327.344, "z":186.313}', 1300000),
	(21, 'Vibrant3Apartment', 'Vibrant Apartment 3', NULL, '{"x":-774.012, "y":342.042, "z":195.686}', '{"x":-779.057, "y":342.063, "z":195.686}', NULL, '["apa_v_mp_h_03_b"]', 'MiltonDrive', 0, 1, 0, '{"x":-765.525, "y":330.851, "z":195.085}', 1300000),
	(22, 'Sharp1Apartment', 'Sharp Apartment 1', NULL, '{"x":-784.194, "y":323.636, "z":210.997}', '{"x":-779.751, "y":323.385, "z":210.997}', NULL, '["apa_v_mp_h_04_a"]', 'MiltonDrive', 0, 1, 0, '{"x":-766.527, "y":327.89, "z":210.396}', 1300000),
	(23, 'Sharp2Apartment', 'Sharp Apartment 2', NULL, '{"x":-786.8663, "y":315.764, "z":186.913}', '{"x":-781.808, "y":315.866, "z":186.913}', NULL, '["apa_v_mp_h_04_c"]', 'MiltonDrive', 0, 1, 0, '{"x":-795.642, "y":326.497, "z":186.313}', 1300000),
	(24, 'Sharp3Apartment', 'Sharp Apartment 3', NULL, '{"x":-774.012, "y":342.042, "z":195.686}', '{"x":-779.057, "y":342.063, "z":195.686}', NULL, '["apa_v_mp_h_04_b"]', 'MiltonDrive', 0, 1, 0, '{"x":-765.503, "y":331.318, "z":195.085}', 1300000),
	(25, 'Monochrome1Apartment', 'Monochrome Apartment 1', NULL, '{"x":-784.194, "y":323.636, "z":210.997}', '{"x":-779.751, "y":323.385, "z":210.997}', NULL, '["apa_v_mp_h_05_a"]', 'MiltonDrive', 0, 1, 0, '{"x":-766.289, "y":328.086, "z":210.396}', 1300000),
	(26, 'Monochrome2Apartment', 'Monochrome Apartment 2', NULL, '{"x":-786.8663, "y":315.764, "z":186.913}', '{"x":-781.808, "y":315.866, "z":186.913}', NULL, '["apa_v_mp_h_05_c"]', 'MiltonDrive', 0, 1, 0, '{"x":-795.692, "y":326.762, "z":186.313}', 1300000),
	(27, 'Monochrome3Apartment', 'Monochrome Apartment 3', NULL, '{"x":-774.012, "y":342.042, "z":195.686}', '{"x":-779.057, "y":342.063, "z":195.686}', NULL, '["apa_v_mp_h_05_b"]', 'MiltonDrive', 0, 1, 0, '{"x":-765.094, "y":330.976, "z":195.085}', 1300000),
	(28, 'Seductive1Apartment', 'Seductive Apartment 1', NULL, '{"x":-784.194, "y":323.636, "z":210.997}', '{"x":-779.751, "y":323.385, "z":210.997}', NULL, '["apa_v_mp_h_06_a"]', 'MiltonDrive', 0, 1, 0, '{"x":-766.263, "y":328.104, "z":210.396}', 1300000),
	(29, 'Seductive2Apartment', 'Seductive Apartment 2', NULL, '{"x":-786.8663, "y":315.764, "z":186.913}', '{"x":-781.808, "y":315.866, "z":186.913}', NULL, '["apa_v_mp_h_06_c"]', 'MiltonDrive', 0, 1, 0, '{"x":-795.655, "y":326.611, "z":186.313}', 1300000),
	(30, 'Seductive3Apartment', 'Seductive Apartment 3', NULL, '{"x":-774.012, "y":342.042, "z":195.686}', '{"x":-779.057, "y":342.063, "z":195.686}', NULL, '["apa_v_mp_h_06_b"]', 'MiltonDrive', 0, 1, 0, '{"x":-765.3, "y":331.414, "z":195.085}', 1300000),
	(31, 'Regal1Apartment', 'Regal Apartment 1', NULL, '{"x":-784.194, "y":323.636, "z":210.997}', '{"x":-779.751, "y":323.385, "z":210.997}', NULL, '["apa_v_mp_h_07_a"]', 'MiltonDrive', 0, 1, 0, '{"x":-765.956, "y":328.257, "z":210.396}', 1300000),
	(32, 'Regal2Apartment', 'Regal Apartment 2', NULL, '{"x":-786.8663, "y":315.764, "z":186.913}', '{"x":-781.808, "y":315.866, "z":186.913}', NULL, '["apa_v_mp_h_07_c"]', 'MiltonDrive', 0, 1, 0, '{"x":-795.545, "y":326.659, "z":186.313}', 1300000),
	(33, 'Regal3Apartment', 'Regal Apartment 3', NULL, '{"x":-774.012, "y":342.042, "z":195.686}', '{"x":-779.057, "y":342.063, "z":195.686}', NULL, '["apa_v_mp_h_07_b"]', 'MiltonDrive', 0, 1, 0, '{"x":-765.087, "y":331.429, "z":195.123}', 1300000),
	(34, 'Aqua1Apartment', 'Aqua Apartment 1', NULL, '{"x":-784.194, "y":323.636, "z":210.997}', '{"x":-779.751, "y":323.385, "z":210.997}', NULL, '["apa_v_mp_h_08_a"]', 'MiltonDrive', 0, 1, 0, '{"x":-766.187, "y":328.47, "z":210.396}', 1300000),
	(35, 'Aqua2Apartment', 'Aqua Apartment 2', NULL, '{"x":-786.8663, "y":315.764, "z":186.913}', '{"x":-781.808, "y":315.866, "z":186.913}', NULL, '["apa_v_mp_h_08_c"]', 'MiltonDrive', 0, 1, 0, '{"x":-795.658, "y":326.563, "z":186.313}', 1300000),
	(36, 'Aqua3Apartment', 'Aqua Apartment 3', NULL, '{"x":-774.012, "y":342.042, "z":195.686}', '{"x":-779.057, "y":342.063, "z":195.686}', NULL, '["apa_v_mp_h_08_b"]', 'MiltonDrive', 0, 1, 0, '{"x":-765.287, "y":331.084, "z":195.086}', 1300000),
	(37, 'IntegrityWay', '4 Integrity Way', '{"x":-47.804, "y":-585.867, "z":36.956}', NULL, NULL, '{"x":-54.178, "y":-583.762, "z":35.798}', '[]', NULL, 0, 0, 1, NULL, 0),
	(38, 'IntegrityWay28', '4 Integrity Way - Apt 28', NULL, '{"x":-31.409, "y":-594.927, "z":79.03}', '{"x":-26.098, "y":-596.909, "z":79.03}', NULL, '[]', 'IntegrityWay', 0, 1, 0, '{"x":-11.923, "y":-597.083, "z":78.43}', 1700000),
	(39, 'IntegrityWay30', '4 Integrity Way - Apt 30', NULL, '{"x":-17.702, "y":-588.524, "z":89.114}', '{"x":-16.21, "y":-582.569, "z":89.114}', NULL, '[]', 'IntegrityWay', 0, 1, 0, '{"x":-26.327, "y":-588.384, "z":89.123}', 1700000),
	(40, 'DellPerroHeights', 'Dell Perro Heights', '{"x":-1447.06, "y":-538.28, "z":33.74}', NULL, NULL, '{"x":-1440.022, "y":-548.696, "z":33.74}', '[]', NULL, 0, 0, 1, NULL, 0),
	(41, 'DellPerroHeightst4', 'Dell Perro Heights - Apt 28', NULL, '{"x":-1452.125, "y":-540.591, "z":73.044}', '{"x":-1455.435, "y":-535.79, "z":73.044}', NULL, '[]', 'DellPerroHeights', 0, 1, 0, '{"x":-1467.058, "y":-527.571, "z":72.443}', 1700000),
	(42, 'DellPerroHeightst7', 'Dell Perro Heights - Apt 30', NULL, '{"x":-1451.562, "y":-523.535, "z":55.928}', '{"x":-1456.02, "y":-519.209, "z":55.929}', NULL, '[]', 'DellPerroHeights', 0, 1, 0, '{"x":-1457.026, "y":-530.219, "z":55.937}', 1700000);
/*!40000 ALTER TABLE `properties` ENABLE KEYS */;

-- Dumping structure for table 71devmod.rented_vehicles
CREATE TABLE IF NOT EXISTS `rented_vehicles` (
  `vehicle` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `plate` varchar(12) COLLATE utf8mb4_unicode_ci NOT NULL,
  `player_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `base_price` int(11) NOT NULL,
  `rent_price` int(11) NOT NULL,
  `owner` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`plate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table 71devmod.rented_vehicles: ~0 rows (approximately)
/*!40000 ALTER TABLE `rented_vehicles` DISABLE KEYS */;
/*!40000 ALTER TABLE `rented_vehicles` ENABLE KEYS */;

-- Dumping structure for table 71devmod.roda_modernhud
CREATE TABLE IF NOT EXISTS `roda_modernhud` (
  `license` varchar(250) NOT NULL,
  `UID` int(250) NOT NULL,
  PRIMARY KEY (`license`,`UID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table 71devmod.roda_modernhud: ~0 rows (approximately)
/*!40000 ALTER TABLE `roda_modernhud` DISABLE KEYS */;
/*!40000 ALTER TABLE `roda_modernhud` ENABLE KEYS */;

-- Dumping structure for table 71devmod.society_moneywash
CREATE TABLE IF NOT EXISTS `society_moneywash` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `society` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table 71devmod.society_moneywash: ~0 rows (approximately)
/*!40000 ALTER TABLE `society_moneywash` DISABLE KEYS */;
/*!40000 ALTER TABLE `society_moneywash` ENABLE KEYS */;

-- Dumping structure for table 71devmod.tomic_teritorije
CREATE TABLE IF NOT EXISTS `tomic_teritorije` (
  `id` int(11) DEFAULT NULL,
  `teritorija` varchar(60) NOT NULL,
  `pripada` varchar(50) DEFAULT NULL,
  `time` int(10) NOT NULL,
  KEY `time` (`time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table 71devmod.tomic_teritorije: ~7 rows (approximately)
/*!40000 ALTER TABLE `tomic_teritorije` DISABLE KEYS */;
INSERT INTO `tomic_teritorije` (`id`, `teritorija`, `pripada`, `time`) VALUES
	(1, 'T1', 'society_nil', 524),
	(2, 'T2', 'society_nil', 524),
	(3, 'T3', 'society_nil', 524),
	(4, 'T4', 'society_nil', 423),
	(5, 'T5', 'society_nil', 524),
	(6, 'T6', 'society_nil', 524),
	(7, 'T7', 'society_nil', 524);
/*!40000 ALTER TABLE `tomic_teritorije` ENABLE KEYS */;

-- Dumping structure for table 71devmod.twitter_accounts
CREATE TABLE IF NOT EXISTS `twitter_accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8 NOT NULL DEFAULT '0',
  `password` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT '0',
  `avatar_url` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `identifier` varchar(60) COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=1624 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table 71devmod.twitter_accounts: ~0 rows (approximately)
/*!40000 ALTER TABLE `twitter_accounts` DISABLE KEYS */;
/*!40000 ALTER TABLE `twitter_accounts` ENABLE KEYS */;

-- Dumping structure for table 71devmod.twitter_likes
CREATE TABLE IF NOT EXISTS `twitter_likes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `authorId` int(11) DEFAULT NULL,
  `tweetId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_twitter_likes_twitter_accounts` (`authorId`),
  KEY `FK_twitter_likes_twitter_tweets` (`tweetId`),
  CONSTRAINT `FK_twitter_likes_twitter_accounts` FOREIGN KEY (`authorId`) REFERENCES `twitter_accounts` (`id`),
  CONSTRAINT `FK_twitter_likes_twitter_tweets` FOREIGN KEY (`tweetId`) REFERENCES `twitter_tweets` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=605 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table 71devmod.twitter_likes: ~0 rows (approximately)
/*!40000 ALTER TABLE `twitter_likes` DISABLE KEYS */;
/*!40000 ALTER TABLE `twitter_likes` ENABLE KEYS */;

-- Dumping structure for table 71devmod.twitter_tweets
CREATE TABLE IF NOT EXISTS `twitter_tweets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `authorId` int(11) NOT NULL,
  `realUser` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `message` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `likes` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `FK_twitter_tweets_twitter_accounts` (`authorId`),
  CONSTRAINT `FK_twitter_tweets_twitter_accounts` FOREIGN KEY (`authorId`) REFERENCES `twitter_accounts` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10712 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table 71devmod.twitter_tweets: ~0 rows (approximately)
/*!40000 ALTER TABLE `twitter_tweets` DISABLE KEYS */;
/*!40000 ALTER TABLE `twitter_tweets` ENABLE KEYS */;

-- Dumping structure for table 71devmod.users
CREATE TABLE IF NOT EXISTS `users` (
  `identifier` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `accounts` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `group` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT 'user',
  `inventory` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `job` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT 'unemployed',
  `job_grade` int(11) DEFAULT 0,
  `position` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '{"x":-269.4,"y":-955.3,"z":31.2,"heading":205.8}',
  `firstname` varchar(16) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lastname` varchar(16) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dateofbirth` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sex` varchar(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  `skin` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone_number` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_property` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_dead` tinyint(1) DEFAULT 0,
  `disabled` tinyint(1) DEFAULT 0,
  `iban` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pincode` int(50) DEFAULT NULL,
  `wanted` tinyint(1) DEFAULT 0,
  `tCoin` int(11) DEFAULT 0,
  `danikredita` int(120) DEFAULT 0,
  `kredit` int(120) DEFAULT 0,
  PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table 71devmod.users: ~3 rows (approximately)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`identifier`, `accounts`, `group`, `inventory`, `job`, `job_grade`, `position`, `firstname`, `lastname`, `dateofbirth`, `sex`, `height`, `skin`, `phone_number`, `status`, `last_property`, `is_dead`, `disabled`, `iban`, `pincode`, `wanted`, `tCoin`, `danikredita`, `kredit`) VALUES
	('char1:192.168.0.171', '{"money":139000,"bank":6860,"black_money":0}', 'superadmin', '[{"name":"money","slot":1,"count":139000},{"metadata":{"type":"Koreli Almin","lastName":"Almin","citizenid":"0.171","sex":"m","height":190,"description":"Sex: male | DOB: 2000/11/01","mugshoturl":"","firstName":"Koreli","expireson":"02 / 24 / 2022","issuedon":"01 / 24 / 2022","dateofbirth":"2000/11/01","cardtype":"identification"},"name":"identification","slot":2,"count":1},{"metadata":{"durability":98.00000000000004},"name":"WEAPON_KNIFE","slot":3,"count":1},{"metadata":{"ammo":12,"serial":"935407ZDW702365","durability":98.2,"components":[]},"name":"WEAPON_PISTOL","slot":4,"count":1},{"name":"burger","slot":5,"count":2},{"metadata":{"ammo":0,"serial":"183695WGJ909942","durability":100,"components":[]},"name":"WEAPON_PISTOL","slot":6,"count":1},{"metadata":{"durability":100},"name":"WEAPON_BAT","slot":7,"count":1},{"name":"contract","slot":8,"count":1},{"name":"ammo-9","slot":9,"count":371},{"name":"lockpick","slot":10,"count":1},{"metadata":{"ammo":0,"serial":"427917LPV481928","durability":100,"components":[]},"name":"WEAPON_PISTOL","slot":11,"count":1},{"name":"acetone","slot":12,"count":5},{"name":"lithium","slot":13,"count":8},{"name":"methlab","slot":14,"count":10},{"name":"mustard","slot":15,"count":1},{"metadata":{"type":"Koreli Almin","citizenid":"0.171","sex":"m","lastName":"Almin","mugshoturl":"https://www.71-development.de/-_-/res/4a5a1b5b-bcec-4c5e-8ddd-f36d8582d4fd/images/files/4a5a1b5b-bcec-4c5e-8ddd-f36d8582d4fd/b504bc7c-ffb6-49ef-977c-06408fe2c4ca/320-320/2db9b9266aea142a0a2107b75284fa5de3864f0a.jpg","issuedon":"01 / 24 / 2022","firstName":"Koreli","expireson":"02 / 24 / 2022","height":190,"dateofbirth":"2000/11/01","cardtype":"drivers_license"},"name":"drivers_license","slot":16,"count":1},{"name":"meth","slot":17,"count":63},{"name":"jabuka","slot":18,"count":4},{"name":"jabuka","slot":19,"count":3},{"name":"jabuka","slot":20,"count":3},{"name":"jabuka","slot":21,"count":4},{"name":"jabuka","slot":22,"count":4},{"name":"jabuka","slot":23,"count":3},{"name":"jabuka","slot":24,"count":4},{"name":"blue_phone","slot":25,"count":1}]', 'ambulance', 3, '{"y":-897.1,"x":292.2,"heading":120.8,"z":29.1}', 'Koreli', 'Almin', '2000/11/01', 'm', 190, '{"headOverlays":{"complexion":{"opacity":0,"color":0,"style":0},"beard":{"opacity":0,"color":0,"style":0},"lipstick":{"opacity":0,"color":0,"style":0},"bodyBlemishes":{"opacity":0,"color":0,"style":0},"ageing":{"opacity":0,"color":0,"style":0},"makeUp":{"opacity":0,"color":0,"style":0},"moleAndFreckles":{"opacity":0,"color":0,"style":0},"eyebrows":{"opacity":0,"color":0,"style":0},"blemishes":{"opacity":0,"color":0,"style":0},"chestHair":{"opacity":0,"color":0,"style":0},"blush":{"opacity":0,"color":0,"style":0},"sunDamage":{"opacity":0,"color":0,"style":0}},"components":[{"component_id":0,"drawable":0,"texture":0},{"component_id":2,"drawable":0,"texture":0},{"component_id":5,"drawable":0,"texture":0},{"component_id":8,"drawable":0,"texture":0},{"component_id":9,"drawable":0,"texture":0},{"component_id":10,"drawable":0,"texture":0},{"component_id":11,"drawable":0,"texture":0},{"component_id":1,"drawable":4,"texture":0},{"component_id":3,"drawable":19,"texture":0},{"component_id":6,"drawable":6,"texture":0},{"component_id":4,"drawable":12,"texture":0},{"component_id":7,"drawable":151,"texture":0}],"faceFeatures":{"noseWidth":0,"chinHole":0,"cheeksWidth":0,"neckThickness":0,"cheeksBoneWidth":0,"chinBoneSize":0,"jawBoneBackSize":0,"eyeBrownHigh":0,"jawBoneWidth":0,"chinBoneLowering":0,"noseBoneHigh":0,"eyeBrownForward":0,"chinBoneLenght":0,"nosePeakSize":0,"lipsThickness":0,"nosePeakLowering":0,"nosePeakHigh":0,"eyesOpening":0,"noseBoneTwist":0,"cheeksBoneHigh":0},"props":[{"drawable":-1,"texture":-1,"prop_id":0},{"drawable":-1,"texture":-1,"prop_id":1},{"drawable":-1,"texture":-1,"prop_id":2},{"drawable":-1,"texture":-1,"prop_id":6},{"drawable":-1,"texture":-1,"prop_id":7}],"hair":{"color":0,"style":0,"highlight":0},"headBlend":{"shapeFirst":0,"shapeSecond":0,"skinMix":0,"skinSecond":0,"skinFirst":0,"shapeMix":0},"eyeColor":-1,"model":"mp_m_freemode_01"}', '942-401-1818', '[{"val":998700,"percent":99.87,"name":"hunger"},{"val":999025,"percent":99.9025,"name":"thirst"},{"val":0,"percent":0.0,"name":"stress"},{"val":0,"percent":0.0,"name":"drunk"}]', NULL, 0, 0, 'BA194671', 1946, 0, 2, 0, 75000),
	('char2:192.168.0.171', '{"money":0,"bank":5000,"black_money":0}', 'admin', '[]', 'unemployed', 0, '{"z":31.2,"heading":207.0,"x":-267.9,"y":-960.1}', 'Bog', 'Almin', '2000/11/01', 'm', 190, '{"eyebrows_2":0,"skin_md_weight":50,"eyebrows_6":0,"bproof_2":0,"watches_1":-1,"beard_2":0,"dad":0,"chin_2":0,"chest_1":0,"lipstick_2":0,"tshirt_2":0,"torso_2":0,"lipstick_3":0,"bodyb_4":0,"makeup_3":0,"chest_2":0,"arms":0,"nose_1":0,"bodyb_2":0,"skin":0,"nose_3":0,"bracelets_1":-1,"nose_4":0,"lip_thickness":0,"chain_1":0,"tshirt_1":0,"pants_2":0,"nose_2":0,"age_2":0,"hair_1":0,"pants_1":0,"beard_1":0,"hair_color_1":0,"bags_2":0,"eye_color":0,"nose_6":0,"bags_1":0,"chin_13":0,"jaw_1":0,"eye_squint":0,"chain_2":0,"makeup_4":0,"cheeks_3":0,"makeup_1":0,"bracelets_2":0,"mask_2":0,"hair_2":0,"blemishes_1":0,"arms_2":0,"nose_5":0,"cheeks_1":0,"complexion_2":0,"bproof_1":0,"decals_2":0,"eyebrows_4":0,"bodyb_1":-1,"bodyb_3":-1,"ears_2":0,"sun_2":0,"blush_1":0,"shoes_1":0,"blush_2":0,"sex":0,"face_md_weight":50,"age_1":0,"decals_1":0,"ears_1":-1,"neck_thickness":0,"helmet_1":-1,"complexion_1":0,"helmet_2":0,"moles_2":0,"mask_1":0,"chest_3":0,"beard_4":0,"blush_3":0,"glasses_2":0,"hair_color_2":0,"blemishes_2":0,"mom":21,"eyebrows_5":0,"torso_1":0,"makeup_2":0,"sun_1":0,"eyebrows_3":0,"shoes_2":0,"moles_1":0,"cheeks_2":0,"glasses_1":0,"lipstick_1":0,"eyebrows_1":0,"chin_1":0,"face":0,"watches_2":0,"lipstick_4":0,"jaw_2":0,"beard_3":0,"chin_4":0}', '374-955-0191', '[]', NULL, 0, 0, NULL, NULL, 0, 0, 0, 0),
	('char3:192.168.0.171', '{"bank":5300,"black_money":0,"money":0}', 'admin', '[{"name":"WEAPON_STUNGUN","slot":1,"count":1,"metadata":{"durability":100}}]', 'police', 4, '{"x":475.5,"heading":272.9,"z":25.7,"y":-981.1}', 'Test', 'Almin', '2000/11/01', 'm', 190, '{"props":[{"texture":-1,"drawable":-1,"prop_id":0},{"texture":0,"drawable":0,"prop_id":1},{"texture":-1,"drawable":-1,"prop_id":2},{"texture":-1,"drawable":-1,"prop_id":6},{"texture":-1,"drawable":-1,"prop_id":7}],"model":"mp_m_freemode_01","faceFeatures":{"jawBoneBackSize":0,"cheeksBoneWidth":0,"chinBoneLowering":0,"eyeBrownForward":0,"nosePeakHigh":0,"nosePeakLowering":0,"chinBoneSize":0,"chinHole":0,"lipsThickness":0,"noseWidth":0,"neckThickness":0,"cheeksBoneHigh":0,"cheeksWidth":0,"nosePeakSize":0,"noseBoneHigh":0,"noseBoneTwist":0,"chinBoneLenght":0,"eyesOpening":0,"eyeBrownHigh":0,"jawBoneWidth":0},"headOverlays":{"lipstick":{"color":0,"style":0,"opacity":0},"beard":{"color":0,"style":0,"opacity":0},"eyebrows":{"color":0,"style":0,"opacity":0},"sunDamage":{"color":0,"style":0,"opacity":0},"complexion":{"color":0,"style":0,"opacity":0},"chestHair":{"color":0,"style":0,"opacity":0},"blemishes":{"color":0,"style":0,"opacity":0},"bodyBlemishes":{"color":0,"style":0,"opacity":0},"moleAndFreckles":{"color":0,"style":0,"opacity":0},"blush":{"color":0,"style":0,"opacity":0},"ageing":{"color":0,"style":0,"opacity":0},"makeUp":{"color":0,"style":0,"opacity":0}},"hair":{"highlight":0,"style":0,"color":0},"components":[{"texture":0,"drawable":0,"component_id":0},{"texture":0,"drawable":0,"component_id":2},{"texture":0,"drawable":0,"component_id":3},{"texture":0,"drawable":0,"component_id":4},{"texture":0,"drawable":0,"component_id":5},{"texture":0,"drawable":0,"component_id":6},{"texture":0,"drawable":0,"component_id":7},{"texture":1,"drawable":59,"component_id":8},{"texture":1,"drawable":11,"component_id":9},{"texture":0,"drawable":0,"component_id":10},{"texture":0,"drawable":0,"component_id":11},{"texture":0,"drawable":1,"component_id":1}],"headBlend":{"skinFirst":0,"skinMix":1,"shapeSecond":0,"skinSecond":0,"shapeFirst":0,"shapeMix":1},"eyeColor":0}', '384-724-4755', '[{"percent":87.98,"val":879800,"name":"hunger"},{"percent":90.985,"val":909850,"name":"thirst"},{"percent":0.0,"val":0,"name":"stress"},{"percent":0.0,"val":0,"name":"drunk"}]', NULL, 0, 0, NULL, NULL, 0, 0, 0, 0);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

-- Dumping structure for table 71devmod.user_licenses
CREATE TABLE IF NOT EXISTS `user_licenses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `owner` (`owner`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table 71devmod.user_licenses: ~0 rows (approximately)
/*!40000 ALTER TABLE `user_licenses` DISABLE KEYS */;
INSERT INTO `user_licenses` (`id`, `type`, `owner`) VALUES
	(1, 'weapon', 'char1:192.168.0.171'),
	(2, 'drive', 'char1:192.168.0.171');
/*!40000 ALTER TABLE `user_licenses` ENABLE KEYS */;

-- Dumping structure for table 71devmod.vehicles
CREATE TABLE IF NOT EXISTS `vehicles` (
  `name` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` int(11) NOT NULL,
  `category` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`model`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table 71devmod.vehicles: ~240 rows (approximately)
/*!40000 ALTER TABLE `vehicles` DISABLE KEYS */;
INSERT INTO `vehicles` (`name`, `model`, `price`, `category`) VALUES
	('Adder', 'adder', 900000, 'super'),
	('Akuma', 'AKUMA', 7500, 'motorcycles'),
	('Alpha', 'alpha', 60000, 'sports'),
	('Ardent', 'ardent', 1150000, 'sportsclassics'),
	('Asea', 'asea', 5500, 'sedans'),
	('Autarch', 'autarch', 1955000, 'super'),
	('Avarus', 'avarus', 18000, 'motorcycles'),
	('Bagger', 'bagger', 13500, 'motorcycles'),
	('Baller', 'baller2', 40000, 'suvs'),
	('Baller Sport', 'baller3', 60000, 'suvs'),
	('Banshee', 'banshee', 70000, 'sports'),
	('Banshee 900R', 'banshee2', 255000, 'super'),
	('Bati 801', 'bati', 12000, 'motorcycles'),
	('Bati 801RR', 'bati2', 19000, 'motorcycles'),
	('Bestia GTS', 'bestiagts', 55000, 'sports'),
	('BF400', 'bf400', 6500, 'motorcycles'),
	('Bf Injection', 'bfinjection', 16000, 'offroad'),
	('Bifta', 'bifta', 12000, 'offroad'),
	('Bison', 'bison', 45000, 'vans'),
	('Blade', 'blade', 15000, 'muscle'),
	('Blazer', 'blazer', 6500, 'offroad'),
	('Blazer Sport', 'blazer4', 8500, 'offroad'),
	('blazer5', 'blazer5', 1755600, 'offroad'),
	('Blista', 'blista', 8000, 'compacts'),
	('BMX (velo)', 'bmx', 160, 'motorcycles'),
	('Bobcat XL', 'bobcatxl', 32000, 'vans'),
	('Brawler', 'brawler', 45000, 'offroad'),
	('Brioso R/A', 'brioso', 18000, 'compacts'),
	('Btype', 'btype', 62000, 'sportsclassics'),
	('Btype Hotroad', 'btype2', 155000, 'sportsclassics'),
	('Btype Luxe', 'btype3', 85000, 'sportsclassics'),
	('Buccaneer', 'buccaneer', 18000, 'muscle'),
	('Buccaneer Rider', 'buccaneer2', 24000, 'muscle'),
	('Buffalo', 'buffalo', 12000, 'sports'),
	('Buffalo S', 'buffalo2', 20000, 'sports'),
	('Bullet', 'bullet', 90000, 'super'),
	('Burrito', 'burrito3', 19000, 'vans'),
	('Camper', 'camper', 42000, 'vans'),
	('Carbonizzare', 'carbonizzare', 75000, 'sports'),
	('Carbon RS', 'carbonrs', 18000, 'motorcycles'),
	('Casco', 'casco', 30000, 'sportsclassics'),
	('Cavalcade', 'cavalcade2', 55000, 'suvs'),
	('Cheetah', 'cheetah', 375000, 'super'),
	('Chimera', 'chimera', 38000, 'motorcycles'),
	('Chino', 'chino', 15000, 'muscle'),
	('Chino Luxe', 'chino2', 19000, 'muscle'),
	('Cliffhanger', 'cliffhanger', 9500, 'motorcycles'),
	('Cognoscenti Cabrio', 'cogcabrio', 55000, 'coupes'),
	('Cognoscenti', 'cognoscenti', 55000, 'sedans'),
	('Comet', 'comet2', 65000, 'sports'),
	('Comet 5', 'comet5', 1145000, 'sports'),
	('Contender', 'contender', 70000, 'suvs'),
	('Coquette', 'coquette', 65000, 'sports'),
	('Coquette Classic', 'coquette2', 40000, 'sportsclassics'),
	('Coquette BlackFin', 'coquette3', 55000, 'muscle'),
	('Cruiser (velo)', 'cruiser', 510, 'motorcycles'),
	('Cyclone', 'cyclone', 1890000, 'super'),
	('Daemon', 'daemon', 11500, 'motorcycles'),
	('Daemon High', 'daemon2', 13500, 'motorcycles'),
	('Defiler', 'defiler', 9800, 'motorcycles'),
	('Deluxo', 'deluxo', 4721500, 'sportsclassics'),
	('Dominator', 'dominator', 35000, 'muscle'),
	('DOUBLE T', 'DOUBLE', 28000, 'motorcycles'),
	('Dubsta', 'dubsta', 45000, 'suvs'),
	('Dubsta Luxuary', 'dubsta2', 60000, 'suvs'),
	('Bubsta 6x6', 'dubsta3', 120000, 'offroad'),
	('Dukes', 'dukes', 28000, 'muscle'),
	('Dune Buggy', 'dune', 8000, 'offroad'),
	('Elegy', 'elegy2', 38500, 'sports'),
	('Emperor', 'emperor', 8500, 'sedans'),
	('Enduro', 'enduro', 5500, 'motorcycles'),
	('Entity XF', 'entityxf', 425000, 'super'),
	('Esskey', 'esskey', 4200, 'motorcycles'),
	('Exemplar', 'exemplar', 32000, 'coupes'),
	('F620', 'f620', 40000, 'coupes'),
	('Faction', 'faction', 20000, 'muscle'),
	('Faction Rider', 'faction2', 30000, 'muscle'),
	('Faction XL', 'faction3', 40000, 'muscle'),
	('Faggio', 'faggio', 1900, 'motorcycles'),
	('Vespa', 'faggio2', 2800, 'motorcycles'),
	('Felon', 'felon', 42000, 'coupes'),
	('Felon GT', 'felon2', 55000, 'coupes'),
	('Feltzer', 'feltzer2', 55000, 'sports'),
	('Stirling GT', 'feltzer3', 65000, 'sportsclassics'),
	('Fixter (velo)', 'fixter', 225, 'motorcycles'),
	('FMJ', 'fmj', 185000, 'super'),
	('Fhantom', 'fq2', 17000, 'suvs'),
	('Fugitive', 'fugitive', 12000, 'sedans'),
	('Furore GT', 'furoregt', 45000, 'sports'),
	('Fusilade', 'fusilade', 40000, 'sports'),
	('Gargoyle', 'gargoyle', 16500, 'motorcycles'),
	('Gauntlet', 'gauntlet', 30000, 'muscle'),
	('Gang Burrito', 'gburrito', 45000, 'vans'),
	('Burrito', 'gburrito2', 29000, 'vans'),
	('Glendale', 'glendale', 6500, 'sedans'),
	('Grabger', 'granger', 50000, 'suvs'),
	('Gresley', 'gresley', 47500, 'suvs'),
	('GT 500', 'gt500', 785000, 'sportsclassics'),
	('Guardian', 'guardian', 45000, 'offroad'),
	('Hakuchou', 'hakuchou', 31000, 'motorcycles'),
	('Hakuchou Sport', 'hakuchou2', 55000, 'motorcycles'),
	('Hermes', 'hermes', 535000, 'muscle'),
	('Hexer', 'hexer', 12000, 'motorcycles'),
	('Hotknife', 'hotknife', 125000, 'muscle'),
	('Huntley S', 'huntley', 40000, 'suvs'),
	('Hustler', 'hustler', 625000, 'muscle'),
	('Infernus', 'infernus', 180000, 'super'),
	('Innovation', 'innovation', 23500, 'motorcycles'),
	('INTruder', 'INTruder', 7500, 'sedans'),
	('Issi', 'issi2', 10000, 'compacts'),
	('Jackal', 'jackal', 38000, 'coupes'),
	('Jester', 'jester', 65000, 'sports'),
	('Jester(Racecar)', 'jester2', 135000, 'sports'),
	('Journey', 'journey', 6500, 'vans'),
	('Kamacho', 'kamacho', 345000, 'offroad'),
	('Khamelion', 'khamelion', 38000, 'sports'),
	('Kuruma', 'kuruma', 30000, 'sports'),
	('Landstalker', 'landstalker', 35000, 'suvs'),
	('RE-7B', 'le7b', 325000, 'super'),
	('Lynx', 'lynx', 40000, 'sports'),
	('Mamba', 'mamba', 70000, 'sports'),
	('Manana', 'manana', 12800, 'sportsclassics'),
	('Manchez', 'manchez', 5300, 'motorcycles'),
	('Massacro', 'massacro', 65000, 'sports'),
	('Massacro(Racecar)', 'massacro2', 130000, 'sports'),
	('Mesa', 'mesa', 16000, 'suvs'),
	('Mesa Trail', 'mesa3', 40000, 'suvs'),
	('Minivan', 'minivan', 13000, 'vans'),
	('Monroe', 'monroe', 55000, 'sportsclassics'),
	('The Liberator', 'monster', 210000, 'offroad'),
	('Moonbeam', 'moonbeam', 18000, 'vans'),
	('Moonbeam Rider', 'moonbeam2', 35000, 'vans'),
	('Nemesis', 'nemesis', 5800, 'motorcycles'),
	('Neon', 'neon', 1500000, 'sports'),
	('Nightblade', 'nightblade', 35000, 'motorcycles'),
	('Nightshade', 'nightshade', 65000, 'muscle'),
	('9F', 'ninef', 65000, 'sports'),
	('9F Cabrio', 'ninef2', 80000, 'sports'),
	('Omnis', 'omnis', 35000, 'sports'),
	('Oppressor', 'oppressor', 3524500, 'super'),
	('Oracle XS', 'oracle2', 35000, 'coupes'),
	('Osiris', 'osiris', 160000, 'super'),
	('Panto', 'panto', 10000, 'compacts'),
	('Paradise', 'paradise', 19000, 'vans'),
	('Pariah', 'pariah', 1420000, 'sports'),
	('Patriot', 'patriot', 55000, 'suvs'),
	('PCJ-600', 'pcj', 6200, 'motorcycles'),
	('Penumbra', 'penumbra', 28000, 'sports'),
	('Pfister', 'pfister811', 85000, 'super'),
	('Phoenix', 'phoenix', 12500, 'muscle'),
	('Picador', 'picador', 18000, 'muscle'),
	('Pigalle', 'pigalle', 20000, 'sportsclassics'),
	('Prairie', 'prairie', 12000, 'compacts'),
	('Premier', 'premier', 8000, 'sedans'),
	('Primo Custom', 'primo2', 14000, 'sedans'),
	('X80 Proto', 'prototipo', 2500000, 'super'),
	('Radius', 'radi', 29000, 'suvs'),
	('raiden', 'raiden', 1375000, 'sports'),
	('Rapid GT', 'rapidgt', 35000, 'sports'),
	('Rapid GT Convertible', 'rapidgt2', 45000, 'sports'),
	('Rapid GT3', 'rapidgt3', 885000, 'sportsclassics'),
	('Reaper', 'reaper', 150000, 'super'),
	('Rebel', 'rebel2', 35000, 'offroad'),
	('Regina', 'regina', 5000, 'sedans'),
	('Retinue', 'retinue', 615000, 'sportsclassics'),
	('Revolter', 'revolter', 1610000, 'sports'),
	('riata', 'riata', 380000, 'offroad'),
	('Rocoto', 'rocoto', 45000, 'suvs'),
	('Ruffian', 'ruffian', 6800, 'motorcycles'),
	('Ruiner 2', 'ruiner2', 5745600, 'muscle'),
	('Rumpo', 'rumpo', 15000, 'vans'),
	('Rumpo Trail', 'rumpo3', 19500, 'vans'),
	('Sabre Turbo', 'sabregt', 20000, 'muscle'),
	('Sabre GT', 'sabregt2', 25000, 'muscle'),
	('Sanchez', 'sanchez', 5300, 'motorcycles'),
	('Sanchez Sport', 'sanchez2', 5300, 'motorcycles'),
	('Sanctus', 'sanctus', 25000, 'motorcycles'),
	('Sandking', 'sandking', 55000, 'offroad'),
	('Savestra', 'savestra', 990000, 'sportsclassics'),
	('SC 1', 'sc1', 1603000, 'super'),
	('Schafter', 'schafter2', 25000, 'sedans'),
	('Schafter V12', 'schafter3', 50000, 'sports'),
	('Scorcher (velo)', 'scorcher', 280, 'motorcycles'),
	('Seminole', 'seminole', 25000, 'suvs'),
	('Sentinel', 'sentinel', 32000, 'coupes'),
	('Sentinel XS', 'sentinel2', 40000, 'coupes'),
	('Sentinel3', 'sentinel3', 650000, 'sports'),
	('Seven 70', 'seven70', 39500, 'sports'),
	('ETR1', 'sheava', 220000, 'super'),
	('Shotaro Concept', 'shotaro', 320000, 'motorcycles'),
	('Slam Van', 'slamvan3', 11500, 'muscle'),
	('Sovereign', 'sovereign', 22000, 'motorcycles'),
	('Stinger', 'stinger', 80000, 'sportsclassics'),
	('Stinger GT', 'stingergt', 75000, 'sportsclassics'),
	('Streiter', 'streiter', 500000, 'sports'),
	('Stretch', 'stretch', 90000, 'sedans'),
	('Stromberg', 'stromberg', 3185350, 'sports'),
	('Sultan', 'sultan', 15000, 'sports'),
	('Sultan RS', 'sultanrs', 65000, 'super'),
	('Super Diamond', 'superd', 130000, 'sedans'),
	('Surano', 'surano', 50000, 'sports'),
	('Surfer', 'surfer', 12000, 'vans'),
	('T20', 't20', 300000, 'super'),
	('Tailgater', 'tailgater', 30000, 'sedans'),
	('Tampa', 'tampa', 16000, 'muscle'),
	('Drift Tampa', 'tampa2', 80000, 'sports'),
	('Thrust', 'thrust', 24000, 'motorcycles'),
	('Tri bike (velo)', 'tribike3', 520, 'motorcycles'),
	('Trophy Truck', 'trophytruck', 60000, 'offroad'),
	('Trophy Truck Limited', 'trophytruck2', 80000, 'offroad'),
	('Tropos', 'tropos', 40000, 'sports'),
	('Turismo R', 'turismor', 350000, 'super'),
	('Tyrus', 'tyrus', 600000, 'super'),
	('Vacca', 'vacca', 120000, 'super'),
	('Vader', 'vader', 7200, 'motorcycles'),
	('Verlierer', 'verlierer2', 70000, 'sports'),
	('Vigero', 'vigero', 12500, 'muscle'),
	('Virgo', 'virgo', 14000, 'muscle'),
	('Viseris', 'viseris', 875000, 'sportsclassics'),
	('Visione', 'visione', 2250000, 'super'),
	('Voltic', 'voltic', 90000, 'super'),
	('Voltic 2', 'voltic2', 3830400, 'super'),
	('Voodoo', 'voodoo', 7200, 'muscle'),
	('Vortex', 'vortex', 9800, 'motorcycles'),
	('Warrener', 'warrener', 4000, 'sedans'),
	('Washington', 'washington', 9000, 'sedans'),
	('Windsor', 'windsor', 95000, 'coupes'),
	('Windsor Drop', 'windsor2', 125000, 'coupes'),
	('Woflsbane', 'wolfsbane', 9000, 'motorcycles'),
	('XLS', 'xls', 32000, 'suvs'),
	('Yosemite', 'yosemite', 485000, 'muscle'),
	('Youga', 'youga', 10800, 'vans'),
	('Youga Luxuary', 'youga2', 14500, 'vans'),
	('Z190', 'z190', 900000, 'sportsclassics'),
	('Zentorno', 'zentorno', 1500000, 'super'),
	('Zion', 'zion', 36000, 'coupes'),
	('Zion Cabrio', 'zion2', 45000, 'coupes'),
	('Zombie', 'zombiea', 9500, 'motorcycles'),
	('Zombie Luxuary', 'zombieb', 12000, 'motorcycles'),
	('Z-Type', 'ztype', 220000, 'sportsclassics');
/*!40000 ALTER TABLE `vehicles` ENABLE KEYS */;

-- Dumping structure for table 71devmod.vehicle_categories
CREATE TABLE IF NOT EXISTS `vehicle_categories` (
  `name` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `label` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table 71devmod.vehicle_categories: ~11 rows (approximately)
/*!40000 ALTER TABLE `vehicle_categories` DISABLE KEYS */;
INSERT INTO `vehicle_categories` (`name`, `label`) VALUES
	('compacts', 'Compacts'),
	('coupes', 'Coupes'),
	('motorcycles', 'Motos'),
	('muscle', 'Muscle'),
	('offroad', 'Off Road'),
	('sedans', 'Sedans'),
	('sports', 'Sports'),
	('sportsclassics', 'Sports Classics'),
	('super', 'Super'),
	('suvs', 'SUVs'),
	('vans', 'Vans');
/*!40000 ALTER TABLE `vehicle_categories` ENABLE KEYS */;

-- Dumping structure for table 71devmod.vehicle_sold
CREATE TABLE IF NOT EXISTS `vehicle_sold` (
  `client` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `plate` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `soldby` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`plate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table 71devmod.vehicle_sold: ~0 rows (approximately)
/*!40000 ALTER TABLE `vehicle_sold` DISABLE KEYS */;
/*!40000 ALTER TABLE `vehicle_sold` ENABLE KEYS */;

-- Dumping structure for table 71devmod.yellowpages_posts
CREATE TABLE IF NOT EXISTS `yellowpages_posts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `authorId` int(11) NOT NULL,
  `realUser` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `message` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `phone` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `likes` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `FK_yellowpages_posts_twitter_accounts` (`authorId`),
  CONSTRAINT `FK_yellowpages_posts_twitter_accounts` FOREIGN KEY (`authorId`) REFERENCES `twitter_accounts` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=225 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table 71devmod.yellowpages_posts: ~0 rows (approximately)
/*!40000 ALTER TABLE `yellowpages_posts` DISABLE KEYS */;
/*!40000 ALTER TABLE `yellowpages_posts` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
