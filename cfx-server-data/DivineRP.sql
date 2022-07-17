-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.4.24-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for aspect
CREATE DATABASE IF NOT EXISTS `aspect` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `aspect`;

-- Dumping structure for table aspect.bannedplayers
CREATE TABLE IF NOT EXISTS `bannedplayers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `steamid` varchar(50) DEFAULT NULL,
  `discord` varchar(50) DEFAULT NULL,
  `license` varchar(50) DEFAULT NULL,
  `ip` varchar(50) DEFAULT NULL,
  `fivem` varchar(50) DEFAULT 'Invalid',
  `reason` varchar(100) NOT NULL,
  `executioner` varchar(100) DEFAULT 'uNKNown',
  `date` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `id` (`id`) USING BTREE,
  KEY `discord` (`discord`) USING BTREE,
  KEY `license` (`license`) USING BTREE,
  KEY `ip` (`ip`) USING BTREE,
  KEY `steamid` (`steamid`) USING BTREE,
  KEY `fivem` (`fivem`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

-- Dumping data for table aspect.bannedplayers: ~0 rows (approximately)
/*!40000 ALTER TABLE `bannedplayers` DISABLE KEYS */;
/*!40000 ALTER TABLE `bannedplayers` ENABLE KEYS */;

-- Dumping structure for table aspect.boost_queue
CREATE TABLE IF NOT EXISTS `boost_queue` (
  `identifier` varchar(60) NOT NULL,
  `pSrc` int(11) DEFAULT NULL,
  PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table aspect.boost_queue: ~8 rows (approximately)
/*!40000 ALTER TABLE `boost_queue` DISABLE KEYS */;

-- Dumping structure for table aspect.characters
CREATE TABLE IF NOT EXISTS `characters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner` varchar(50) DEFAULT NULL,
  `first_name` varchar(50) NOT NULL DEFAULT 'John',
  `last_name` varchar(50) NOT NULL DEFAULT 'Doe',
  `dob` varchar(50) DEFAULT 'NULL',
  `cash` int(9) DEFAULT 500,
  `bank` int(9) NOT NULL DEFAULT 5000,
  `chips` int(11) DEFAULT 0,
  `phone_number` varchar(15) DEFAULT NULL,
  `new` int(1) NOT NULL DEFAULT 1,
  `iscreated` int(11) DEFAULT 0,
  `gender` varchar(50) NOT NULL DEFAULT '0',
  `jail_time` int(11) NOT NULL DEFAULT 0,
  `jail_time_mobster` int(11) unsigned zerofill NOT NULL DEFAULT 00000000000,
  `stress_level` int(11) DEFAULT 0,
  `bones` mediumtext DEFAULT '{}',
  `emotes` varchar(4160) DEFAULT '{}',
  `paycheck` int(11) DEFAULT 0,
  `meta` text DEFAULT 'move_m@casual@d',
  `dna` text DEFAULT '{}',
  `bankid` int(11) DEFAULT NULL,
  `wallpaper` longtext DEFAULT 'https://i.imgur.com/JVPavDg.jpg',
  `profilepic` longtext DEFAULT '',
  `date_created` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=486 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table aspect.characters: ~422 rows (approximately)
/*!40000 ALTER TABLE `characters` DISABLE KEYS */;

-- Dumping structure for table aspect.characters_ammo
CREATE TABLE IF NOT EXISTS `characters_ammo` (
  `id` int(11) NOT NULL DEFAULT 0,
  `type` varchar(255) DEFAULT NULL,
  `ammo` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table aspect.characters_ammo: ~322 rows (approximately)
/*!40000 ALTER TABLE `characters_ammo` DISABLE KEYS */;


-- Dumping structure for table aspect.characters_cars
CREATE TABLE IF NOT EXISTS `characters_cars` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) DEFAULT NULL,
  `purchase_price` float DEFAULT NULL,
  `model` varchar(50) DEFAULT NULL,
  `vehicle_state` longtext DEFAULT NULL,
  `fuel` int(11) DEFAULT 100,
  `name` varchar(50) DEFAULT NULL,
  `engine_damage` bigint(19) unsigned DEFAULT 1000,
  `body_damage` bigint(20) DEFAULT 1000,
  `degredation` longtext DEFAULT '100,100,100,100,100,100,100,100',
  `current_garage` varchar(50) DEFAULT 'C',
  `financed` int(11) DEFAULT 0,
  `last_payment` int(11) DEFAULT 0,
  `coords` longtext DEFAULT NULL,
  `license_plate` varchar(255) NOT NULL DEFAULT '',
  `payments_left` int(3) DEFAULT 0,
  `data` longtext DEFAULT NULL,
  `repoed` int(11) NOT NULL DEFAULT 0,
  `finance_time` int(11) NOT NULL DEFAULT 10080,
  `code` varchar(255) NOT NULL DEFAULT '0',
  `stolen` int(11) DEFAULT 0,
  `image` longtext DEFAULT '0',
  `vin` int(11) DEFAULT 0,
  `seizuredata` longtext DEFAULT '{}',
  `wheelfitment` longtext DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table aspect.characters_cars: ~53 rows (approximately)
/*!40000 ALTER TABLE `characters_cars` DISABLE KEYS */;


-- Dumping structure for table aspect.characters_clothes
CREATE TABLE IF NOT EXISTS `characters_clothes` (
  `cid` int(11) DEFAULT NULL,
  `assExist` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table aspect.characters_clothes: ~0 rows (approximately)
/*!40000 ALTER TABLE `characters_clothes` DISABLE KEYS */;
/*!40000 ALTER TABLE `characters_clothes` ENABLE KEYS */;

-- Dumping structure for table aspect.character_bank_statments
CREATE TABLE IF NOT EXISTS `character_bank_statments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) DEFAULT NULL,
  `sender` varchar(50) DEFAULT NULL,
  `target` varchar(50) DEFAULT NULL,
  `label` varchar(50) DEFAULT NULL,
  `iden` varchar(50) DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `date` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3000 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table aspect.character_bank_statments: ~2,997 rows (approximately)
/*!40000 ALTER TABLE `character_bank_statments` DISABLE KEYS */;

-- Dumping structure for table aspect.character_business_accounts
CREATE TABLE IF NOT EXISTS `character_business_accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) DEFAULT NULL,
  `biz_id` int(11) DEFAULT NULL,
  `biz_name` varchar(50) DEFAULT NULL,
  `biz_bank_id` int(11) DEFAULT NULL,
  `biz_bank` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table aspect.character_business_accounts: ~0 rows (approximately)
/*!40000 ALTER TABLE `character_business_accounts` DISABLE KEYS */;
/*!40000 ALTER TABLE `character_business_accounts` ENABLE KEYS */;

-- Dumping structure for table aspect.character_business_statments
CREATE TABLE IF NOT EXISTS `character_business_statments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bizname` varchar(50) DEFAULT NULL,
  `sender` varchar(50) DEFAULT NULL,
  `target` varchar(50) DEFAULT NULL,
  `label` varchar(50) DEFAULT NULL,
  `amount` int(11) NOT NULL DEFAULT 0,
  `iden` varchar(50) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `date` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=304 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table aspect.character_business_statments: ~302 rows (approximately)
/*!40000 ALTER TABLE `character_business_statments` DISABLE KEYS */;
-- Dumping structure for table aspect.character_contacts
CREATE TABLE IF NOT EXISTS `character_contacts` (
  `identifier` varchar(40) NOT NULL,
  `name` longtext NOT NULL,
  `number` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table aspect.character_contacts: ~0 rows (approximately)
/*!40000 ALTER TABLE `character_contacts` DISABLE KEYS */;
/*!40000 ALTER TABLE `character_contacts` ENABLE KEYS */;

-- Dumping structure for table aspect.character_current
CREATE TABLE IF NOT EXISTS `character_current` (
  `cid` int(11) DEFAULT NULL,
  `model` varchar(50) DEFAULT NULL,
  `drawables` mediumtext DEFAULT NULL,
  `props` mediumtext DEFAULT NULL,
  `drawtextures` mediumtext DEFAULT NULL,
  `proptextures` mediumtext DEFAULT NULL,
  `assExists` mediumtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table aspect.character_current: ~410 rows (approximately)
/*!40000 ALTER TABLE `character_current` DISABLE KEYS */;

-- Dumping structure for table aspect.character_face
CREATE TABLE IF NOT EXISTS `character_face` (
  `cid` int(11) DEFAULT NULL,
  `hairColor` mediumtext DEFAULT NULL,
  `headBlend` mediumtext DEFAULT NULL,
  `headOverlay` mediumtext DEFAULT NULL,
  `headStructure` mediumtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table aspect.character_face: ~386 rows (approximately)
-- Dumping structure for table aspect.character_inventory
CREATE TABLE IF NOT EXISTS `character_inventory` (
  `item_id` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(500) CHARACTER SET utf8 NOT NULL DEFAULT '0',
  `information` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '0',
  `slot` int(11) NOT NULL,
  `dropped` tinyint(4) NOT NULL DEFAULT 0,
  `creationDate` bigint(20) NOT NULL DEFAULT 0,
  `quality` int(11) DEFAULT 100,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=191904 DEFAULT CHARSET=latin1;


-- Dumping structure for table aspect.character_jobwhitelist
CREATE TABLE IF NOT EXISTS `character_jobwhitelist` (
  `cid` int(11) DEFAULT NULL,
  `job` varchar(50) DEFAULT 'unemployed',
  `rank` int(11) DEFAULT 0,
  `callsign` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- Dumping structure for table aspect.character_licenses
CREATE TABLE IF NOT EXISTS `character_licenses` (
  `cid` longtext NOT NULL,
  `type` longtext NOT NULL,
  `status` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table aspect.character_licenses: ~3,178 rows (approximately)
/*!40000 ALTER TABLE `character_licenses` DISABLE KEYS */;

-- Dumping structure for table aspect.character_motel
CREATE TABLE IF NOT EXISTS `character_motel` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) NOT NULL,
  `building_type` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=454 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table aspect.character_motel: ~453 rows (approximately)
/*!40000 ALTER TABLE `character_motel` DISABLE KEYS */;


-- Dumping structure for table aspect.character_outfits
CREATE TABLE IF NOT EXISTS `character_outfits` (
  `cid` int(11) DEFAULT NULL,
  `model` varchar(50) DEFAULT NULL,
  `name` text DEFAULT NULL,
  `slot` int(11) DEFAULT NULL,
  `drawables` text DEFAULT '{}',
  `props` text DEFAULT '{}',
  `drawtextures` text DEFAULT '{}',
  `proptextures` text DEFAULT '{}',
  `hairColor` text DEFAULT '{}'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table aspect.character_outfits: ~312 rows (approximately)
/*!40000 ALTER TABLE `character_outfits` DISABLE KEYS */;


-- Dumping structure for table aspect.character_passes
CREATE TABLE IF NOT EXISTS `character_passes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) NOT NULL,
  `rank` int(11) NOT NULL DEFAULT 1,
  `pass_type` text NOT NULL,
  `business_name` text NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table aspect.character_passes: ~5 rows (approximately)
/*!40000 ALTER TABLE `character_passes` DISABLE KEYS */;


-- Dumping structure for table aspect.character_tattoos
CREATE TABLE IF NOT EXISTS `character_tattoos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) NOT NULL DEFAULT 0,
  `tattoos` longtext NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=447 DEFAULT CHARSET=latin1;

-- Dumping data for table aspect.character_tattoos: ~446 rows (approximately)
/*!40000 ALTER TABLE `character_tattoos` DISABLE KEYS */;


-- Dumping structure for table aspect.character_weapons
CREATE TABLE IF NOT EXISTS `character_weapons` (
  `cid` int(11) DEFAULT NULL,
  `serial` mediumtext DEFAULT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table aspect.character_weapons: ~497 rows (approximately)


-- Dumping structure for table aspect.debt_logs
CREATE TABLE IF NOT EXISTS `debt_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) NOT NULL DEFAULT 0,
  `biller` int(11) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT 1,
  `number` int(11) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table aspect.debt_logs: ~11 rows (approximately)
/*!40000 ALTER TABLE `debt_logs` DISABLE KEYS */;


-- Dumping structure for table aspect.divine_boosting
CREATE TABLE IF NOT EXISTS `divine_boosting` (
  `#` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(255) NOT NULL,
  `BNE` text NOT NULL DEFAULT '0',
  `background` varchar(255) DEFAULT NULL,
  `vin` int(11) DEFAULT NULL,
  PRIMARY KEY (`#`),
  KEY `citizenid` (`citizenid`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;


-- Dumping structure for table aspect.doj_bulletin
CREATE TABLE IF NOT EXISTS `doj_bulletin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` text NOT NULL,
  `desc` mediumtext NOT NULL,
  `author` text NOT NULL,
  `time` longtext NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `id` (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table aspect.doj_bulletin: ~0 rows (approximately)
/*!40000 ALTER TABLE `doj_bulletin` DISABLE KEYS */;
/*!40000 ALTER TABLE `doj_bulletin` ENABLE KEYS */;

-- Dumping structure for table aspect.doj_reports
CREATE TABLE IF NOT EXISTS `doj_reports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `author` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `detail` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tags` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `officersinvolved` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `civsinvolved` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gallery` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `time` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `id` (`id`) USING BTREE,
  KEY `author` (`author`) USING BTREE,
  KEY `title` (`title`(768)) USING BTREE,
  KEY `type` (`type`(768)) USING BTREE,
  KEY `detail` (`detail`(768)) USING BTREE,
  KEY `tags` (`tags`(768)) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table aspect.doj_reports: ~0 rows (approximately)
/*!40000 ALTER TABLE `doj_reports` DISABLE KEYS */;
/*!40000 ALTER TABLE `doj_reports` ENABLE KEYS */;

-- Dumping structure for table aspect.emsmdtdata
CREATE TABLE IF NOT EXISTS `emsmdtdata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) DEFAULT NULL,
  `information` longtext DEFAULT NULL,
  `tags` longtext DEFAULT NULL,
  `gallery` longtext DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `cid` (`cid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;



-- Dumping structure for table aspect.ems_bulletin
CREATE TABLE IF NOT EXISTS `ems_bulletin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` text NOT NULL,
  `desc` mediumtext NOT NULL,
  `author` text NOT NULL,
  `time` longtext NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `id` (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table aspect.ems_bulletin: ~0 rows (approximately)
/*!40000 ALTER TABLE `ems_bulletin` DISABLE KEYS */;
/*!40000 ALTER TABLE `ems_bulletin` ENABLE KEYS */;

-- Dumping structure for table aspect.ems_icu
CREATE TABLE IF NOT EXISTS `ems_icu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `author` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `plate` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `individual` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `detail` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tags` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gallery` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `officersinvolved` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `time` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `title` (`title`(768)) USING BTREE,
  KEY `plate` (`plate`(768)) USING BTREE,
  KEY `owner` (`owner`(768)) USING BTREE,
  KEY `individual` (`individual`(768)) USING BTREE,
  KEY `detail` (`detail`(768)) USING BTREE,
  KEY `tags` (`tags`(768)) USING BTREE,
  KEY `officersinvolved` (`officersinvolved`(768)) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table aspect.ems_icu: ~0 rows (approximately)
/*!40000 ALTER TABLE `ems_icu` DISABLE KEYS */;
/*!40000 ALTER TABLE `ems_icu` ENABLE KEYS */;

-- Dumping structure for table aspect.ems_reports
CREATE TABLE IF NOT EXISTS `ems_reports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `author` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `detail` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tags` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `officersinvolved` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `civsinvolved` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gallery` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `time` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `id` (`id`) USING BTREE,
  KEY `author` (`author`) USING BTREE,
  KEY `title` (`title`(768)) USING BTREE,
  KEY `type` (`type`(768)) USING BTREE,
  KEY `detail` (`detail`(768)) USING BTREE,
  KEY `tags` (`tags`(768)) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table aspect.ems_reports: ~4 rows (approximately)


-- Dumping structure for table aspect.group_banking
CREATE TABLE IF NOT EXISTS `group_banking` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_type` mediumtext DEFAULT NULL,
  `bank` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table aspect.group_banking: ~5 rows (approximately)
/*!40000 ALTER TABLE `group_banking` DISABLE KEYS */;
INSERT INTO `group_banking` (`id`, `group_type`, `bank`) VALUES
	(1, 'police', 0),
	(2, 'pdm', 0),
	(3, 'badboy_customs', 0),
	(4, 'pizza', 815),
	(5, 'lostmc', 0);
/*!40000 ALTER TABLE `group_banking` ENABLE KEYS */;

-- Dumping structure for table aspect.group_members
CREATE TABLE IF NOT EXISTS `group_members` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) NOT NULL,
  `src` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `rank` int(11) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4;


-- Dumping structure for table aspect.hospital_patients
CREATE TABLE IF NOT EXISTS `hospital_patients` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) NOT NULL,
  `level` int(11) NOT NULL,
  `illness` text NOT NULL DEFAULT '',
  `time` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table aspect.hospital_patients: ~0 rows (approximately)
/*!40000 ALTER TABLE `hospital_patients` DISABLE KEYS */;
/*!40000 ALTER TABLE `hospital_patients` ENABLE KEYS */;

-- Dumping structure for table aspect.housing
CREATE TABLE IF NOT EXISTS `housing` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `hid` varchar(50) DEFAULT NULL,
  `cid` int(11) DEFAULT NULL,
  `information` text DEFAULT NULL,
  `objects` text DEFAULT NULL,
  `last_payment` int(11) DEFAULT NULL,
  `status` varchar(50) DEFAULT 'Lock',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;



-- Dumping structure for table aspect.housing_keys
CREATE TABLE IF NOT EXISTS `housing_keys` (
  `id` int(11) NOT NULL,
  `hid` varchar(50) DEFAULT NULL,
  `cid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table aspect.housing_keys: ~0 rows (approximately)
/*!40000 ALTER TABLE `housing_keys` DISABLE KEYS */;
/*!40000 ALTER TABLE `housing_keys` ENABLE KEYS */;

-- Dumping structure for table aspect.job_group
CREATE TABLE IF NOT EXISTS `job_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `src` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `members` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `status` int(2) NOT NULL,
  `job` varchar(50) DEFAULT NULL,
  `leader` int(11) DEFAULT NULL,
  `task_id` int(11) DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `src` (`src`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table aspect.job_group: ~0 rows (approximately)
/*!40000 ALTER TABLE `job_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `job_group` ENABLE KEYS */;

-- Dumping structure for table aspect.laptop_pickups
CREATE TABLE IF NOT EXISTS `laptop_pickups` (
  `cid` int(11) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table aspect.laptop_pickups: ~0 rows (approximately)
/*!40000 ALTER TABLE `laptop_pickups` DISABLE KEYS */;
/*!40000 ALTER TABLE `laptop_pickups` ENABLE KEYS */;

-- Dumping structure for table aspect.meth_table
CREATE TABLE IF NOT EXISTS `meth_table` (
  `cid` int(11) DEFAULT NULL,
  `model` varchar(50) DEFAULT NULL,
  `coords` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table aspect.meth_table: ~0 rows (approximately)
/*!40000 ALTER TABLE `meth_table` DISABLE KEYS */;
/*!40000 ALTER TABLE `meth_table` ENABLE KEYS */;

-- Dumping structure for table aspect.pd_bolos
CREATE TABLE IF NOT EXISTS `pd_bolos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `author` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `plate` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `individual` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `detail` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tags` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gallery` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `officersinvolved` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `time` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `author` (`author`(768)) USING BTREE,
  KEY `title` (`title`(768)) USING BTREE,
  KEY `plate` (`plate`(768)) USING BTREE,
  KEY `owner` (`owner`(768)) USING BTREE,
  KEY `individual` (`individual`(768)) USING BTREE,
  KEY `detail` (`detail`(768)) USING BTREE,
  KEY `tags` (`tags`(768)) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table aspect.pd_bolos: ~0 rows (approximately)
/*!40000 ALTER TABLE `pd_bolos` DISABLE KEYS */;
/*!40000 ALTER TABLE `pd_bolos` ENABLE KEYS */;

-- Dumping structure for table aspect.pd_bulletin
CREATE TABLE IF NOT EXISTS `pd_bulletin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` text DEFAULT NULL,
  `desc` mediumtext DEFAULT NULL,
  `author` text DEFAULT NULL,
  `time` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `id` (`id`) USING BTREE,
  KEY `title` (`title`(3072)) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Dumping data for table aspect.pd_bulletin: ~0 rows (approximately)
/*!40000 ALTER TABLE `pd_bulletin` DISABLE KEYS */;
INSERT INTO `pd_bulletin` (`id`, `title`, `desc`, `author`, `time`) VALUES
	(2, 'Pursuit Mode & Gun License Classes', 'Hello Everyone,As we all know our vehicles have been struggling lately with a select few vehicles. We are pleased to announce after speaking to the commissioner the use just A+ is now permitted. However we strongly emphasise the use of this must be used correctly. If we see officers not thinking about the severity of the crime committed and abusing this it will be taken away. On another note, gun licensing we be changing. They will be going to more of a class system. This change will be explained more in an announcement soon keep and eye out for that.Keep doing the great job you are doing!-High CommandÃ‚Â Ã‚Â ', 'Frankie Gee', '1652236948465');
/*!40000 ALTER TABLE `pd_bulletin` ENABLE KEYS */;

-- Dumping structure for table aspect.pd_convictions
CREATE TABLE IF NOT EXISTS `pd_convictions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) DEFAULT NULL,
  `linkedincident` int(11) NOT NULL DEFAULT 0,
  `warrant` varchar(50) DEFAULT NULL,
  `guilty` varchar(50) DEFAULT NULL,
  `processed` varchar(50) DEFAULT NULL,
  `associated` varchar(50) DEFAULT '0',
  `charges` longtext DEFAULT NULL,
  `fine` int(11) DEFAULT 0,
  `sentence` int(11) DEFAULT 0,
  `recfine` int(11) DEFAULT 0,
  `recsentence` int(11) DEFAULT 0,
  `time` longtext DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `warrant` (`warrant`) USING BTREE,
  KEY `cid` (`cid`) USING BTREE,
  KEY `linkedincident` (`linkedincident`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;


-- Dumping structure for table aspect.pd_incidents
CREATE TABLE IF NOT EXISTS `pd_incidents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `author` text NOT NULL DEFAULT '',
  `title` text NOT NULL DEFAULT '0',
  `details` longtext CHARACTER SET utf8mb4 NOT NULL,
  `tags` longtext NOT NULL,
  `officersinvolved` longtext NOT NULL,
  `civsinvolved` longtext NOT NULL,
  `evidence` longtext NOT NULL,
  `time` longtext DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `id` (`id`) USING BTREE,
  KEY `author` (`author`(3072)) USING BTREE,
  KEY `title` (`title`(3072)) USING BTREE,
  KEY `details` (`details`(768)) USING BTREE,
  KEY `tags` (`tags`(3072)) USING BTREE,
  KEY `officersinvolved` (`officersinvolved`(3072)) USING BTREE,
  KEY `civsinvolved` (`civsinvolved`(3072)) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;


-- Dumping structure for table aspect.pd_logs
CREATE TABLE IF NOT EXISTS `pd_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `text` longtext NOT NULL DEFAULT '',
  `time` longtext DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=110 DEFAULT CHARSET=latin1;

-- Dumping data for table aspect.pd_logs: ~109 rows (approximately)

-- Dumping structure for table aspect.pd_reports
CREATE TABLE IF NOT EXISTS `pd_reports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `author` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `detail` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tags` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `officersinvolved` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `civsinvolved` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gallery` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `time` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `id` (`id`) USING BTREE,
  KEY `author` (`author`(768)) USING BTREE,
  KEY `title` (`title`(768)) USING BTREE,
  KEY `type` (`type`(768)) USING BTREE,
  KEY `detail` (`detail`(768)) USING BTREE,
  KEY `tags` (`tags`(768)) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- Dumping structure for table aspect.pd_vehicleinfo
CREATE TABLE IF NOT EXISTS `pd_vehicleinfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `license_plate` varchar(50) DEFAULT NULL,
  `information` longtext NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `plate` (`license_plate`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- Dumping data for table aspect.pd_vehicleinfo: ~0 rows (approximately)
;

-- Dumping structure for table aspect.phone_yp
CREATE TABLE IF NOT EXISTS `phone_yp` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `job` varchar(500) DEFAULT NULL,
  `phonenumber` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table aspect.phone_yp: ~0 rows (approximately)
/*!40000 ALTER TABLE `phone_yp` DISABLE KEYS */;
/*!40000 ALTER TABLE `phone_yp` ENABLE KEYS */;

-- Dumping structure for table aspect.policemdtdata
CREATE TABLE IF NOT EXISTS `policemdtdata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) DEFAULT NULL,
  `information` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tags` longtext DEFAULT '[]',
  `gallery` longtext DEFAULT '[]',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `cid` (`cid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;



-- Dumping structure for table aspect.racing_tracks
CREATE TABLE IF NOT EXISTS `racing_tracks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `checkpoints` text DEFAULT NULL,
  `track_name` text DEFAULT NULL,
  `creator` text DEFAULT NULL,
  `distance` text DEFAULT NULL,
  `races` text DEFAULT NULL,
  `fastest_car` text DEFAULT NULL,
  `fastest_name` text DEFAULT NULL,
  `fastest_lap` int(11) DEFAULT NULL,
  `fastest_sprint` int(11) DEFAULT NULL,
  `fastest_sprint_name` text DEFAULT NULL,
  `description` text DEFAULT NULL,
  `data` text DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table aspect.racing_tracks: ~9 rows (approximately)
/*!40000 ALTER TABLE `racing_tracks` DISABLE KEYS */;
INSERT INTO `racing_tracks` (`id`, `checkpoints`, `track_name`, `creator`, `distance`, `races`, `fastest_car`, `fastest_name`, `fastest_lap`, `fastest_sprint`, `fastest_sprint_name`, `description`, `data`) VALUES
	(1, '[{"flare1z":47.68,"flare2x":1464.99,"flare1x":1438.35,"flare2z":47.21,"start":true,"y":-2578.67,"dist":30.0,"flare2y":-2551.57,"z":46.37,"flare1y":-2605.34,"x":1451.3},{"flare1z":58.14,"flare2x":1550.75,"flare1x":1557.06,"flare2z":58.4,"start":false,"y":-2555.42,"dist":5.5,"flare2y":-2550.59,"z":57.18,"flare1y":-2559.6,"x":1554.07},{"flare1z":92.82,"flare2x":1626.33,"flare1x":1636.42,"flare2z":93.03,"start":false,"y":-2407.14,"dist":5.5,"flare2y":-2404.79,"z":91.85,"flare1y":-2409.17,"x":1631.69},{"flare1z":108.64,"flare2x":1643.73,"flare1x":1661.11,"flare2z":108.71,"start":false,"y":-2212.39,"dist":9.0,"flare2y":-2214.77,"z":107.61,"flare1y":-2210.07,"x":1652.78},{"flare1z":113.93,"flare2x":1700.69,"flare1x":1718.65,"flare2z":114.1,"start":false,"y":-1988.16,"dist":9.0,"flare2y":-1987.67,"z":112.96,"flare1y":-1988.79,"x":1710.03},{"flare1z":112.34,"flare2x":1722.45,"flare1x":1739.28,"flare2z":112.38,"start":false,"y":-1759.28,"dist":9.0,"flare2y":-1756.07,"z":111.3,"flare1y":-1762.46,"x":1731.24},{"flare1z":112.15,"flare2x":1787.47,"flare1x":1804.67,"flare2z":112.26,"start":false,"y":-1551.56,"dist":9.0,"flare2y":-1548.87,"z":111.14,"flare1y":-1554.19,"x":1796.44},{"flare1z":134.1,"flare2x":1868.22,"flare1x":1884.38,"flare2z":133.97,"start":false,"y":-1408.39,"dist":9.0,"flare2y":-1404.3,"z":132.97,"flare1y":-1412.23,"x":1876.64},{"flare1z":115.55,"flare2x":1905.42,"flare1x":1921.63,"flare2z":115.93,"start":false,"y":-1202.99,"dist":9.0,"flare2y":-1199.14,"z":114.64,"flare1y":-1206.94,"x":1913.94},{"flare1z":78.27,"flare2x":1956.42,"flare1x":1947.39,"flare2z":78.33,"start":false,"y":-931.44,"dist":9.0,"flare2y":-939.6,"z":77.24,"flare1y":-924.03,"x":1951.83},{"flare1z":78.79,"flare2x":1842.7,"flare1x":1825.85,"flare2z":78.63,"start":false,"y":-1066.45,"dist":9.0,"flare2y":-1069.52,"z":77.65,"flare1y":-1063.2,"x":1833.86},{"flare1z":84.05,"flare2x":1759.27,"flare1x":1744.86,"flare2z":84.1,"start":false,"y":-1267.81,"dist":9.0,"flare2y":-1273.17,"z":83.02,"flare1y":-1262.38,"x":1751.59},{"flare1z":81.1,"flare2x":1618.78,"flare1x":1605.66,"flare2z":81.19,"start":false,"y":-1368.88,"dist":9.0,"flare2y":-1375.03,"z":80.08,"flare1y":-1362.7,"x":1611.7},{"flare1z":54.68,"flare2x":1397.01,"flare1x":1385.43,"flare2z":54.89,"start":false,"y":-1564.11,"dist":9.0,"flare2y":-1571.13,"z":53.7,"flare1y":-1557.35,"x":1390.82},{"flare1z":51.09,"flare2x":1302.66,"flare1x":1325.71,"flare2z":51.4,"start":false,"y":-1583.21,"dist":14.0,"flare2y":-1591.25,"z":50.18,"flare1y":-1575.36,"x":1314.56},{"flare1z":34.33,"flare2x":1229.97,"flare1x":1270.78,"flare2z":34.14,"start":false,"y":-1415.01,"dist":21.5,"flare2y":-1422.06,"z":33.17,"flare1y":-1408.5,"x":1250.66},{"flare1z":35.81,"flare2x":1239.61,"flare1x":1255.51,"flare2z":35.76,"start":false,"y":-1195.78,"dist":8.5,"flare2y":-1198.92,"z":34.72,"flare1y":-1192.89,"x":1247.9},{"flare1z":43.54,"flare2x":1160.98,"flare1x":1177.49,"flare2z":43.22,"start":false,"y":-1019.69,"dist":8.5,"flare2y":-1021.92,"z":42.33,"flare1y":-1017.89,"x":1169.55},{"flare1z":53.98,"flare2x":1170.71,"flare1x":1187.02,"flare2z":54.15,"start":false,"y":-836.36,"dist":8.5,"flare2y":-833.94,"z":53.0,"flare1y":-838.72,"x":1179.23},{"flare1z":60.19,"flare2x":1240.32,"flare1x":1247.82,"flare2z":59.94,"start":false,"y":-752.22,"dist":6.5,"flare2y":-746.57,"z":59.0,"flare1y":-757.19,"x":1244.21},{"flare1z":68.04,"flare2x":1273.92,"flare1x":1288.47,"flare2z":68.2,"start":false,"y":-624.58,"dist":8.0,"flare2y":-628.07,"z":67.05,"flare1y":-621.42,"x":1281.51},{"flare1z":68.09,"flare2x":1273.29,"flare1x":1288.33,"flare2z":68.39,"start":false,"y":-423.58,"dist":8.0,"flare2y":-426.49,"z":67.17,"flare1y":-421.05,"x":1281.13},{"flare1z":67.96,"flare2x":1191.12,"flare1x":1209.66,"flare2z":68.51,"start":false,"y":-279.96,"dist":11.5,"flare2y":-286.97,"z":67.16,"flare1y":-273.36,"x":1200.68},{"flare1z":71.3,"flare2x":990.86,"flare1x":999.2,"flare2z":71.13,"start":false,"y":-175.51,"dist":8.0,"flare2y":-182.7,"z":70.16,"flare1y":-169.04,"x":995.12},{"flare1z":79.56,"flare2x":821.26,"flare1x":832.46,"flare2z":79.81,"start":false,"y":-15.01,"dist":8.0,"flare2y":-9.0,"z":78.62,"flare1y":-20.43,"x":827.07},{"flare1z":79.79,"flare2x":940.61,"flare1x":953.11,"flare2z":80.08,"start":false,"y":123.72,"dist":8.0,"flare2y":128.73,"z":78.88,"flare1y":118.75,"x":947.31},{"flare1z":88.1,"flare2x":1111.95,"flare1x":1118.47,"flare2z":88.85,"start":false,"y":287.35,"dist":8.0,"flare2y":294.87,"z":87.4,"flare1y":280.29,"x":1115.58},{"flare1z":90.52,"flare2x":1144.28,"flare1x":1155.17,"flare2z":90.4,"start":false,"y":373.08,"dist":8.0,"flare2y":366.83,"z":89.39,"flare1y":378.55,"x":1149.85},{"flare1z":95.01,"flare2x":1007.26,"flare1x":992.91,"flare2z":94.6,"start":false,"y":460.02,"dist":8.0,"flare2y":456.37,"z":93.74,"flare1y":463.43,"x":999.75},{"flare1z":87.37,"flare2x":926.87,"flare1x":915.85,"flare2z":87.43,"start":false,"y":317.98,"dist":8.0,"flare2y":312.1,"z":86.33,"flare1y":323.7,"x":920.93},{"flare1z":80.63,"flare2x":795.33,"flare1x":791.93,"flare2z":80.01,"start":false,"y":188.35,"dist":4.5,"flare2y":183.89,"z":79.29,"flare1y":192.2,"x":793.43},{"flare1z":94.0,"flare2x":664.15,"flare1x":668.27,"flare2z":94.27,"start":false,"y":214.42,"dist":6.0,"flare2y":208.4,"z":93.08,"flare1y":219.67,"x":666.2},{"flare1z":99.78,"flare2x":547.24,"flare1x":539.72,"flare2z":100.12,"start":false,"y":187.83,"dist":4.0,"flare2y":186.29,"z":98.87,"flare1y":189.0,"x":543.17},{"flare1z":81.23,"flare2x":463.79,"flare1x":450.78,"flare2z":80.98,"start":false,"y":-15.45,"dist":7.5,"flare2y":-19.31,"z":80.04,"flare1y":-11.85,"x":456.95},{"flare1z":60.71,"flare2x":385.91,"flare1x":371.5,"flare2z":60.86,"start":false,"y":-177.14,"dist":7.5,"flare2y":-179.36,"z":59.72,"flare1y":-175.18,"x":378.37},{"flare1z":51.25,"flare2x":406.33,"flare1x":392.17,"flare2z":51.4,"start":false,"y":-290.93,"dist":21.5,"flare2y":-270.32,"z":50.27,"flare1y":-310.92,"x":399.03},{"flare1z":43.86,"flare2x":503.86,"flare1x":495.84,"flare2z":44.08,"start":false,"y":-328.62,"dist":9.5,"flare2y":-319.62,"z":42.89,"flare1y":-336.85,"x":499.82},{"flare1z":42.83,"flare2x":576.17,"flare1x":562.18,"flare2z":42.6,"start":false,"y":-360.7,"dist":17.0,"flare2y":-344.8,"z":41.65,"flare1y":-375.79,"x":569.2},{"flare1z":29.62,"flare2x":776.63,"flare1x":765.64,"flare2z":29.7,"start":false,"y":-584.42,"dist":5.5,"flare2y":-584.54,"z":28.58,"flare1y":-584.07,"x":770.77},{"flare1z":26.23,"flare2x":776.69,"flare1x":765.69,"flare2z":26.21,"start":false,"y":-751.87,"dist":5.5,"flare2y":-751.5,"z":25.14,"flare1y":-751.72,"x":770.84},{"flare1z":24.76,"flare2x":784.96,"flare1x":767.99,"flare2z":24.83,"start":false,"y":-936.01,"dist":8.5,"flare2y":-935.18,"z":23.74,"flare1y":-936.12,"x":776.13},{"flare1z":28.33,"flare2x":797.84,"flare1x":781.15,"flare2z":28.43,"start":false,"y":-1126.43,"dist":8.5,"flare2y":-1124.34,"z":27.3,"flare1y":-1127.56,"x":789.19},{"flare1z":25.55,"flare2x":802.48,"flare1x":785.48,"flare2z":25.48,"start":false,"y":-1281.3,"dist":8.5,"flare2y":-1280.85,"z":24.45,"flare1y":-1281.1,"x":793.63},{"flare1z":26.26,"flare2x":816.63,"flare1x":781.4,"flare2z":26.56,"start":false,"y":-1465.07,"dist":19.0,"flare2y":-1457.63,"z":25.34,"flare1y":-1471.85,"x":798.75},{"flare1z":28.48,"flare2x":834.91,"flare1x":809.93,"flare2z":28.47,"start":false,"y":-1715.91,"dist":12.5,"flare2y":-1716.49,"z":27.41,"flare1y":-1715.37,"x":822.06},{"flare1z":28.64,"flare2x":787.63,"flare1x":773.13,"flare2z":28.19,"start":false,"y":-1950.91,"dist":7.5,"flare2y":-1952.59,"z":27.36,"flare1y":-1948.79,"x":779.96},{"flare1z":29.5,"flare2x":876.73,"flare1x":874.84,"flare2z":29.81,"start":false,"y":-2083.08,"dist":6.5,"flare2y":-2076.29,"z":28.58,"flare1y":-2089.15,"x":875.72},{"flare1z":30.0,"flare2x":978.2,"flare1x":977.81,"flare2z":30.26,"start":false,"y":-2090.22,"dist":6.5,"flare2y":-2083.36,"z":29.06,"flare1y":-2096.35,"x":978.11},{"flare1z":38.18,"flare2x":1116.12,"flare1x":1115.7,"flare2z":38.39,"start":false,"y":-2085.41,"dist":6.5,"flare2y":-2078.54,"z":37.24,"flare1y":-2091.53,"x":1116.11},{"flare1z":45.54,"flare2x":1262.21,"flare1x":1246.35,"flare2z":45.5,"start":false,"y":-2120.48,"dist":8.5,"flare2y":-2117.33,"z":44.46,"flare1y":-2123.44,"x":1253.93},{"flare1z":51.59,"flare2x":1330.19,"flare1x":1318.32,"flare2z":51.59,"start":false,"y":-2308.19,"dist":6.0,"flare2y":-2307.01,"z":50.53,"flare1y":-2308.82,"x":1323.94},{"flare1z":43.71,"flare2x":1268.07,"flare1x":1260.19,"flare2z":43.59,"start":false,"y":-2498.2,"dist":6.0,"flare2y":-2502.88,"z":42.57,"flare1y":-2493.83,"x":1263.77},{"flare1z":37.59,"flare2x":1201.03,"flare1x":1192.07,"flare2z":37.88,"start":false,"y":-2592.18,"dist":6.0,"flare2y":-2587.99,"z":36.65,"flare1y":-2595.97,"x":1196.24},{"flare1z":47.87,"flare2x":1386.45,"flare1x":1388.01,"flare2z":47.92,"start":false,"y":-2574.03,"dist":6.0,"flare2y":-2567.72,"z":46.83,"flare1y":-2579.62,"x":1387.27}]', 'El Burro', 'Jon Smith', '9575', NULL, NULL, 'nil', 0, 319924, 'nil', 'El burro run', NULL),
	(2, '[{"flare1z":19.21,"flare2x":-969.3,"flare1x":-986.68,"flare2z":19.62,"start":true,"y":-2416.17,"dist":11.0,"flare2y":-2423.17,"z":18.44,"flare1y":-2409.69,"x":-978.33},{"flare1z":18.78,"flare2x":-885.49,"flare1x":-872.62,"flare2z":19.38,"start":false,"y":-2669.6,"dist":7.5,"flare2y":-2665.53,"z":18.09,"flare1y":-2673.22,"x":-878.68},{"flare1z":12.98,"flare2x":-815.71,"flare1x":-803.14,"flare2z":13.18,"start":false,"y":-2466.6,"dist":7.0,"flare2y":-2469.87,"z":12.1,"flare1y":-2463.71,"x":-809.03},{"flare1z":12.83,"flare2x":-693.95,"flare1x":-684.59,"flare2z":12.68,"start":false,"y":-2131.37,"dist":6.5,"flare2y":-2126.55,"z":11.79,"flare1y":-2135.58,"x":-688.97},{"flare1z":26.17,"flare2x":-570.19,"flare1x":-571.33,"flare2z":26.68,"start":false,"y":-2083.51,"dist":5.5,"flare2y":-2077.61,"z":25.43,"flare1y":-2088.54,"x":-570.81},{"flare1z":19.12,"flare2x":402.83,"flare1x":420.25,"flare2z":15.22,"start":false,"y":-2143.29,"dist":13.5,"flare2y":-2132.85,"z":16.25,"flare1y":-2153.1,"x":411.8},{"flare1z":26.16,"flare2x":741.59,"flare1x":732.74,"flare2z":31.19,"start":false,"y":-2060.44,"dist":21.5,"flare2y":-2039.12,"z":27.65,"flare1y":-2080.9,"x":737.07},{"flare1z":43.6,"flare2x":1208.02,"flare1x":1217.93,"flare2z":43.42,"start":false,"y":-2064.29,"dist":13.5,"flare2y":-2051.33,"z":42.54,"flare1y":-2076.44,"x":1213.13},{"flare1z":51.65,"flare2x":1341.28,"flare1x":1360.38,"flare2z":51.52,"start":false,"y":-1629.75,"dist":13.5,"flare2y":-1639.59,"z":50.62,"flare1y":-1620.51,"x":1351.14},{"flare1z":46.52,"flare2x":1145.38,"flare1x":1172.33,"flare2z":46.59,"start":false,"y":-963.9,"dist":13.5,"flare2y":-963.01,"z":45.58,"flare1y":-964.7,"x":1159.28},{"flare1z":69.4,"flare2x":1030.81,"flare1x":1043.79,"flare2z":69.48,"start":false,"y":-208.83,"dist":13.5,"flare2y":-221.05,"z":68.47,"flare1y":-197.37,"x":1037.51},{"flare1z":83.23,"flare2x":704.26,"flare1x":720.24,"flare2z":83.26,"start":false,"y":-1.25,"dist":16.0,"flare2y":-15.48,"z":82.27,"flare1y":12.24,"x":712.48},{"flare1z":104.83,"flare2x":217.43,"flare1x":228.78,"flare2z":104.68,"start":false,"y":191.07,"dist":16.0,"flare2y":175.7,"z":103.78,"flare1y":205.62,"x":223.24},{"flare1z":82.29,"flare2x":-521.63,"flare1x":-518.23,"flare2z":82.3,"start":false,"y":253.76,"dist":16.0,"flare2y":237.42,"z":81.33,"flare1y":269.24,"x":-519.89},{"flare1z":63.12,"flare2x":-1066.35,"flare1x":-1063.44,"flare2z":63.25,"start":false,"y":264.3,"dist":22.0,"flare2y":241.92,"z":62.21,"flare1y":285.82,"x":-1064.87},{"flare1z":51.81,"flare2x":-1403.7,"flare1x":-1439.68,"flare2z":51.87,"start":false,"y":-26.14,"dist":18.0,"flare2y":-25.61,"z":50.87,"flare1y":-26.65,"x":-1422.12},{"flare1z":52.97,"flare2x":-1513.1,"flare1x":-1539.92,"flare2z":52.56,"start":false,"y":-155.99,"dist":18.0,"flare2y":-168.3,"z":51.8,"flare1y":-144.28,"x":-1526.82},{"flare1z":36.74,"flare2x":-1386.44,"flare1x":-1414.1,"flare2z":36.68,"start":false,"y":-366.32,"dist":17.0,"flare2y":-356.18,"z":35.74,"flare1y":-375.95,"x":-1400.61},{"flare1z":23.18,"flare2x":-1174.6,"flare1x":-1203.45,"flare2z":22.82,"start":false,"y":-634.55,"dist":17.0,"flare2y":-625.32,"z":22.03,"flare1y":-643.3,"x":-1189.38},{"flare1z":10.03,"flare2x":-774.22,"flare1x":-795.64,"flare2z":10.14,"start":false,"y":-1088.27,"dist":13.5,"flare2y":-1079.77,"z":9.11,"flare1y":-1096.21,"x":-785.26},{"flare1z":27.75,"flare2x":-752.37,"flare1x":-769.75,"flare2z":28.1,"start":false,"y":-1795.32,"dist":9.0,"flare2y":-1792.87,"z":26.94,"flare1y":-1797.55,"x":-761.48},{"flare1z":24.89,"flare2x":-699.28,"flare1x":-711.09,"flare2z":24.87,"start":false,"y":-2006.21,"dist":6.0,"flare2y":-2005.05,"z":23.91,"flare1y":-2007.21,"x":-705.61},{"flare1z":16.43,"flare2x":-817.65,"flare1x":-831.26,"flare2z":16.74,"start":false,"y":-2218.87,"dist":12.0,"flare2y":-2229.11,"z":15.61,"flare1y":-2209.35,"x":-824.7}]', 'LS Underground', 'Charles Gonzales', '10129', NULL, NULL, 'nil', 0, 201281, 'nil', 'LSUnderground', NULL),
	(3, '[{"flare2y":3832.43,"y":3842.06,"dist":10.5,"flare1z":31.66,"z":30.7,"flare1y":3851.06,"flare2x":1900.73,"flare2z":31.57,"start":true,"flare1x":1891.03,"x":1895.69},{"flare2y":3668.16,"y":3677.44,"dist":10.5,"flare1z":33.73,"z":32.79,"flare1y":3686.12,"flare2x":1616.22,"flare2z":33.69,"start":false,"flare1x":1605.34,"x":1610.56},{"flare2y":3528.8,"y":3536.17,"dist":7.0,"flare1z":34.46,"z":33.53,"flare1y":3542.79,"flare2x":1257.69,"flare2z":34.43,"start":false,"flare1x":1258.18,"x":1257.92},{"flare2y":3367.12,"y":3370.47,"dist":7.0,"flare1z":37.95,"z":37.0,"flare1y":3373.53,"flare2x":264.81,"flare2z":37.89,"start":false,"flare1x":252.36,"x":258.25},{"flare2y":2963.05,"y":2966.27,"dist":7.0,"flare1z":42.25,"z":41.24,"flare1y":2969.2,"flare2x":220.62,"flare2z":42.06,"start":false,"flare1x":208.05,"x":214.0},{"flare2y":2834.28,"y":2839.62,"dist":7.0,"flare1z":37.84,"z":37.25,"flare1y":2844.46,"flare2x":-408.91,"flare2z":38.52,"start":false,"flare1x":-418.5,"x":-413.99},{"flare2y":2298.93,"y":2303.59,"dist":7.0,"flare1z":74.82,"z":73.79,"flare1y":2307.81,"flare2x":-770.78,"flare2z":74.57,"start":false,"flare1x":-781.6,"x":-776.47},{"flare2y":2003.89,"y":1997.35,"dist":7.0,"flare1z":127.51,"z":126.56,"flare1y":1991.47,"flare2x":-770.94,"flare2z":127.43,"start":false,"flare1x":-777.39,"x":-774.33},{"flare2y":1810.17,"y":1815.61,"dist":7.0,"flare1z":165.5,"z":164.55,"flare1y":1820.51,"flare2x":-804.37,"flare2z":165.42,"start":false,"flare1x":-813.81,"x":-809.35},{"flare2y":1530.62,"y":1534.38,"dist":7.0,"flare1z":221.57,"z":220.7,"flare1y":1537.75,"flare2x":-771.1,"flare2z":221.67,"start":false,"flare1x":-783.15,"x":-777.44},{"flare2y":1002.52,"y":995.24,"dist":7.0,"flare1z":237.65,"z":236.7,"flare1y":988.68,"flare2x":-686.67,"flare2z":237.58,"start":false,"flare1x":-684.55,"x":-685.53},{"flare2y":952.51,"y":955.82,"dist":6.5,"flare1z":232.76,"z":231.65,"flare1y":958.83,"flare2x":-331.13,"flare2z":232.35,"start":false,"flare1x":-342.48,"x":-337.13},{"flare2y":639.38,"y":633.02,"dist":6.0,"flare1z":206.52,"z":205.66,"flare1y":627.39,"flare2x":95.99,"flare2z":206.63,"start":false,"flare1x":95.52,"x":95.77},{"flare2y":844.05,"y":839.26,"dist":6.0,"flare1z":191.45,"z":190.92,"flare1y":835.03,"flare2x":291.89,"flare2z":192.27,"start":false,"flare1x":299.76,"x":296.09},{"flare2y":876.22,"y":868.62,"dist":7.5,"flare1z":197.3,"z":196.38,"flare1y":861.75,"flare2x":487.72,"flare2z":197.3,"start":false,"flare1x":483.77,"x":485.67},{"flare2y":818.24,"y":822.09,"dist":7.0,"flare1z":196.66,"z":195.84,"flare1y":825.66,"flare2x":959.75,"flare2z":196.89,"start":false,"flare1x":947.88,"x":953.47},{"flare2y":761.11,"y":753.97,"dist":7.0,"flare1z":152.13,"z":151.1,"flare1y":747.51,"flare2x":1095.01,"flare2z":151.9,"start":false,"flare1x":1098.32,"x":1096.8},{"flare2y":521.75,"y":527.79,"dist":7.0,"flare1z":94.31,"z":93.39,"flare1y":533.26,"flare2x":1071.61,"flare2z":94.3,"start":false,"flare1x":1063.64,"x":1067.4},{"flare2y":489.22,"y":483.79,"dist":7.0,"flare1z":95.15,"z":94.2,"flare1y":478.95,"flare2x":1036.05,"flare2z":95.08,"start":false,"flare1x":1026.54,"x":1031.08},{"flare2y":394.59,"y":389.5,"dist":7.0,"flare1z":90.6,"z":89.72,"flare1y":384.89,"flare2x":1141.23,"flare2z":90.68,"start":false,"flare1x":1151.32,"x":1146.55},{"flare2y":1321.56,"y":1318.41,"dist":7.0,"flare1z":85.97,"z":85.13,"flare1y":1315.54,"flare2x":1688.76,"flare2z":86.13,"start":false,"flare1x":1701.39,"x":1695.42},{"flare2y":1250.75,"y":1248.47,"dist":4.5,"flare1z":75.31,"z":74.33,"flare1y":1246.58,"flare2x":2182.62,"flare2z":75.18,"start":false,"flare1x":2174.64,"x":2178.32},{"flare2y":1692.63,"y":1692.74,"dist":7.5,"flare1z":26.8,"z":25.87,"flare1y":1692.78,"flare2x":2533.43,"flare2z":26.77,"start":false,"flare1x":2548.43,"x":2541.3},{"flare2y":3015.45,"y":3023.06,"dist":7.5,"flare1z":44.54,"z":43.67,"flare1y":3029.94,"flare2x":2181.97,"flare2z":44.63,"start":false,"flare1x":2185.82,"x":2183.96},{"flare2y":3527.29,"y":3520.6,"dist":7.5,"flare1z":35.64,"z":34.73,"flare1y":3514.51,"flare2x":1713.15,"flare2z":35.66,"start":false,"flare1x":1721.01,"x":1717.29},{"flare2y":3726.28,"y":3730.07,"dist":7.5,"flare1z":32.27,"z":31.36,"flare1y":3733.45,"flare2x":2050.86,"flare2z":32.28,"start":false,"flare1x":2064.04,"x":2057.76},{"flare2y":3852.46,"y":3862.72,"dist":11.5,"flare1z":31.71,"z":30.74,"flare1y":3872.38,"flare2x":1937.29,"flare2z":31.6,"start":false,"flare1x":1925.78,"x":1931.33}]', 'Bags to Bitches', 'Adam Foxx', '12028', NULL, NULL, 'nil', 0, 332201, 'nil', 'Little country, little rock and roll', NULL),
	(4, '[{"flare2y":-496.01,"z":63.77,"y":-492.93,"start":true,"flare2x":1191.06,"x":1177.97,"dist":13.0,"flare1z":64.8,"flare2z":64.81,"flare1x":1165.7,"flare1y":-490.26},{"flare2y":-567.36,"z":62.68,"y":-567.47,"start":false,"flare2x":1177.3,"x":1168.86,"dist":8.0,"flare1z":63.72,"flare2z":63.72,"flare1x":1161.3,"flare1y":-567.44},{"flare2y":-630.03,"z":61.2,"y":-631.64,"start":false,"flare2x":1184.49,"x":1176.21,"dist":8.0,"flare1z":62.22,"flare2z":62.27,"flare1x":1168.71,"flare1y":-632.69},{"flare2y":-728.64,"z":57.26,"y":-729.82,"start":false,"flare2x":1201.82,"x":1193.46,"dist":8.0,"flare1z":58.25,"flare2z":58.36,"flare1x":1185.93,"flare1y":-730.5},{"flare2y":-805.4,"z":54.4,"y":-802.35,"start":false,"flare2x":1191.58,"x":1183.71,"dist":8.0,"flare1z":55.5,"flare2z":55.38,"flare1x":1176.82,"flare1y":-799.22},{"flare2y":-903.4,"z":50.14,"y":-903.03,"start":false,"flare2x":1161.84,"x":1153.45,"dist":8.0,"flare1z":50.41,"flare2z":52.05,"flare1x":1145.95,"flare1y":-902.46},{"flare2y":-972.07,"z":44.9,"y":-972.64,"start":false,"flare2x":1161.14,"x":1152.72,"dist":8.0,"flare1z":45.71,"flare2z":46.22,"flare1x":1145.16,"flare1y":-972.7},{"flare2y":-1068.32,"z":39.58,"y":-1071.96,"start":false,"flare2x":1181.68,"x":1174.08,"dist":8.0,"flare1z":40.17,"flare2z":41.13,"flare1x":1167.16,"flare1y":-1074.97},{"flare2y":-1158.14,"z":35.19,"y":-1160.49,"start":false,"flare2x":1227.11,"x":1219.03,"dist":8.0,"flare1z":35.77,"flare2z":36.71,"flare1x":1211.69,"flare1y":-1162.29},{"flare2y":-1237.47,"z":33.56,"y":-1237.94,"start":false,"flare2x":1246.84,"x":1238.44,"dist":8.0,"flare1z":34.15,"flare2z":35.09,"flare1x":1230.88,"flare1y":-1237.92},{"flare2y":-1309.22,"z":33.25,"y":-1308.37,"start":false,"flare2x":1246.0,"x":1237.61,"dist":8.0,"flare1z":33.98,"flare2z":34.62,"flare1x":1230.14,"flare1y":-1307.26},{"flare2y":-1371.62,"z":33.39,"y":-1371.68,"start":false,"flare2x":1240.08,"x":1231.64,"dist":8.0,"flare1z":34.68,"flare2z":34.14,"flare1x":1224.09,"flare1y":-1371.41},{"flare2y":-1441.39,"z":33.48,"y":-1432.98,"start":false,"flare2x":1191.86,"x":1191.4,"dist":8.0,"flare1z":34.54,"flare2z":34.49,"flare1x":1191.17,"flare1y":-1425.41},{"flare2y":-1441.5,"z":34.44,"y":-1433.07,"start":false,"flare2x":1116.26,"x":1115.72,"dist":8.0,"flare1z":35.42,"flare2z":35.52,"flare1x":1115.54,"flare1y":-1425.52},{"flare2y":-1442.85,"z":34.99,"y":-1434.42,"start":false,"flare2x":1065.05,"x":1064.61,"dist":8.0,"flare1z":36.04,"flare2z":36.02,"flare1x":1064.61,"flare1y":-1426.86},{"flare2y":-1439.56,"z":29.94,"y":-1431.12,"start":false,"flare2x":982.58,"x":982.84,"dist":8.0,"flare1z":30.86,"flare2z":31.17,"flare1x":983.6,"flare1y":-1423.6},{"flare2y":-1437.13,"z":29.5,"y":-1428.71,"start":false,"flare2x":921.0,"x":920.64,"dist":8.0,"flare1z":30.25,"flare2z":30.86,"flare1x":920.73,"flare1y":-1421.15},{"flare2y":-1438.19,"z":26.9,"y":-1429.76,"start":false,"flare2x":856.45,"x":856.06,"dist":8.0,"flare1z":27.78,"flare2z":28.14,"flare1x":856.21,"flare1y":-1422.19},{"flare2y":-1440.24,"z":25.26,"y":-1431.85,"start":false,"flare2x":782.02,"x":781.11,"dist":8.0,"flare1z":26.23,"flare2z":26.38,"flare1x":780.6,"flare1y":-1424.31},{"flare2y":-1441.31,"z":28.42,"y":-1432.87,"start":false,"flare2x":742.28,"x":742.17,"dist":8.0,"flare1z":29.43,"flare2z":29.43,"flare1x":742.4,"flare1y":-1425.31},{"flare2y":-1440.39,"z":29.15,"y":-1431.95,"start":false,"flare2x":666.9,"x":666.88,"dist":8.0,"flare1z":30.09,"flare2z":30.31,"flare1x":667.29,"flare1y":-1424.39},{"flare2y":-1438.75,"z":28.37,"y":-1430.31,"start":false,"flare2x":609.43,"x":609.48,"dist":8.0,"flare1z":29.24,"flare2z":29.6,"flare1x":609.9,"flare1y":-1422.76},{"flare2y":-1434.58,"z":27.64,"y":-1426.14,"start":false,"flare2x":565.91,"x":565.83,"dist":8.0,"flare1z":28.39,"flare2z":29.01,"flare1x":565.9,"flare1y":-1418.59},{"flare2y":-1377.42,"z":27.56,"y":-1376.43,"start":false,"flare2x":528.1,"x":536.48,"dist":8.0,"flare1z":28.45,"flare2z":28.76,"flare1x":544.02,"flare1y":-1375.77},{"flare2y":-1327.74,"z":27.56,"y":-1323.99,"start":false,"flare2x":511.41,"x":518.97,"dist":8.0,"flare1z":28.41,"flare2z":28.8,"flare1x":525.9,"flare1y":-1320.95},{"flare2y":-1272.63,"z":27.5,"y":-1272.34,"start":false,"flare2x":496.39,"x":504.82,"dist":8.0,"flare1z":28.28,"flare2z":28.83,"flare1x":512.38,"flare1y":-1272.32},{"flare2y":-1225.76,"z":27.51,"y":-1225.63,"start":false,"flare2x":496.18,"x":504.62,"dist":8.0,"flare1z":28.24,"flare2z":28.89,"flare1x":512.17,"flare1y":-1225.83},{"flare2y":-1159.79,"z":27.54,"y":-1158.97,"start":false,"flare2x":495.01,"x":503.4,"dist":8.0,"flare1z":28.39,"flare2z":28.77,"flare1x":510.95,"flare1y":-1158.48},{"flare2y":-1102.98,"z":27.45,"y":-1102.94,"start":false,"flare2x":493.17,"x":501.61,"dist":8.0,"flare1z":28.33,"flare2z":28.68,"flare1x":509.17,"flare1y":-1103.28},{"flare2y":-1052.37,"z":26.74,"y":-1052.4,"start":false,"flare2x":494.23,"x":502.67,"dist":8.0,"flare1z":27.54,"flare2z":28.05,"flare1x":510.22,"flare1y":-1052.73},{"flare2y":-1004.31,"z":26.05,"y":-1004.33,"start":false,"flare2x":495.4,"x":503.83,"dist":8.0,"flare1z":26.72,"flare2z":27.51,"flare1x":511.38,"flare1y":-1004.67},{"flare2y":-970.39,"z":25.62,"y":-969.59,"start":false,"flare2x":494.41,"x":502.81,"dist":8.0,"flare1z":26.43,"flare2z":26.91,"flare1x":510.33,"flare1y":-968.93},{"flare2y":-959.59,"z":26.32,"y":-951.21,"start":false,"flare2x":462.32,"x":461.43,"dist":8.0,"flare1z":26.85,"flare2z":27.91,"flare1x":460.78,"flare1y":-943.7},{"flare2y":-959.84,"z":27.47,"y":-951.41,"start":false,"flare2x":424.92,"x":425.15,"dist":8.0,"flare1z":28.15,"flare2z":28.9,"flare1x":425.56,"flare1y":-943.87},{"flare2y":-936.7,"z":27.68,"y":-935.73,"start":false,"flare2x":395.74,"x":404.12,"dist":8.0,"flare1z":28.59,"flare2z":28.85,"flare1x":411.64,"flare1y":-934.92},{"flare2y":-892.74,"z":27.66,"y":-893.52,"start":false,"flare2x":398.51,"x":406.91,"dist":8.0,"flare1z":28.52,"flare2z":28.9,"flare1x":414.41,"flare1y":-894.46},{"flare2y":-859.72,"z":27.57,"y":-851.29,"start":false,"flare2x":378.23,"x":378.76,"dist":8.0,"flare1z":28.51,"flare2z":28.71,"flare1x":379.42,"flare1y":-843.76},{"flare2y":-857.62,"z":27.53,"y":-849.19,"start":false,"flare2x":334.05,"x":334.28,"dist":8.0,"flare1z":28.33,"flare2z":28.82,"flare1x":334.76,"flare1y":-841.65},{"flare2y":-848.26,"z":27.67,"y":-840.13,"start":false,"flare2x":258.94,"x":261.21,"dist":8.0,"flare1z":28.57,"flare2z":28.85,"flare1x":263.66,"flare1y":-832.97},{"flare2y":-828.94,"z":29.23,"y":-820.83,"start":false,"flare2x":198.0,"x":200.33,"dist":8.0,"flare1z":30.26,"flare2z":30.27,"flare1x":202.85,"flare1y":-813.69},{"flare2y":-811.41,"z":29.44,"y":-803.26,"start":false,"flare2x":141.38,"x":143.59,"dist":8.0,"flare1z":30.5,"flare2z":30.46,"flare1x":146.02,"flare1y":-796.09},{"flare2y":-787.92,"z":29.89,"y":-779.99,"start":false,"flare2x":75.98,"x":78.89,"dist":8.0,"flare1z":30.9,"flare2z":30.94,"flare1x":82.04,"flare1y":-773.11},{"flare2y":-769.57,"z":29.84,"y":-761.48,"start":false,"flare2x":24.34,"x":26.76,"dist":8.0,"flare1z":30.79,"flare2z":30.98,"flare1x":29.45,"flare1y":-754.41},{"flare2y":-749.29,"z":30.9,"y":-741.41,"start":false,"flare2x":-28.3,"x":-25.27,"dist":8.0,"flare1z":31.73,"flare2z":32.15,"flare1x":-22.04,"flare1y":-734.57},{"flare2y":-730.16,"z":32.17,"y":-722.3,"start":false,"flare2x":-73.19,"x":-70.11,"dist":8.0,"flare1z":33.12,"flare2z":33.29,"flare1x":-66.91,"flare1y":-715.45},{"flare2y":-708.48,"z":32.89,"y":-704.16,"start":false,"flare2x":-108.4,"x":-101.18,"dist":8.0,"flare1z":33.79,"flare2z":34.08,"flare1x":-94.59,"flare1y":-700.42},{"flare2y":-635.55,"z":34.54,"y":-637.99,"start":false,"flare2x":-97.35,"x":-89.26,"dist":8.0,"flare1z":35.49,"flare2z":35.68,"flare1x":-82.13,"flare1y":-640.5},{"flare2y":-594.13,"z":34.54,"y":-596.47,"start":false,"flare2x":-84.05,"x":-75.94,"dist":8.0,"flare1z":35.62,"flare2z":35.53,"flare1x":-68.8,"flare1y":-598.95},{"flare2y":-547.13,"z":38.25,"y":-549.45,"start":false,"flare2x":-69.23,"x":-61.11,"dist":8.0,"flare1z":39.26,"flare2z":39.31,"flare1x":-53.97,"flare1y":-551.93},{"flare2y":-503.15,"z":38.7,"y":-506.23,"start":false,"flare2x":-52.22,"x":-44.36,"dist":8.0,"flare1z":39.72,"flare2z":39.75,"flare1x":-37.47,"flare1y":-509.36},{"flare2y":-460.98,"z":38.69,"y":-463.33,"start":false,"flare2x":-37.28,"x":-29.17,"dist":8.0,"flare1z":39.71,"flare2z":39.75,"flare1x":-22.09,"flare1y":-466.01},{"flare2y":-421.1,"z":37.86,"y":-423.56,"start":false,"flare2x":-24.0,"x":-15.92,"dist":8.0,"flare1z":38.86,"flare2z":38.96,"flare1x":-8.83,"flare1y":-426.18},{"flare2y":-380.41,"z":37.7,"y":-382.93,"start":false,"flare2x":-10.33,"x":-2.28,"dist":8.0,"flare1z":38.63,"flare2z":38.85,"flare1x":4.83,"flare1y":-385.49},{"flare2y":-342.49,"z":40.98,"y":-346.0,"start":false,"flare2x":7.81,"x":15.48,"dist":8.0,"flare1z":41.57,"flare2z":42.48,"flare1x":22.2,"flare1y":-349.44},{"flare2y":-303.45,"z":45.34,"y":-305.64,"start":false,"flare2x":21.6,"x":29.75,"dist":8.0,"flare1z":46.23,"flare2z":46.52,"flare1x":36.98,"flare1y":-307.83},{"flare2y":-271.17,"z":45.77,"y":-271.62,"start":false,"flare2x":29.12,"x":37.55,"dist":8.0,"flare1z":46.57,"flare2z":47.08,"flare1x":45.06,"flare1y":-272.35},{"flare2y":-223.37,"z":49.06,"y":-226.54,"start":false,"flare2x":41.63,"x":49.46,"dist":8.0,"flare1z":49.86,"flare2z":50.29,"flare1x":56.3,"flare1y":-229.75},{"flare2y":-177.53,"z":53.47,"y":-179.82,"start":false,"flare2x":61.03,"x":69.16,"dist":8.0,"flare1z":54.21,"flare2z":54.84,"flare1x":76.28,"flare1y":-182.34},{"flare2y":-125.26,"z":54.08,"y":-128.32,"start":false,"flare2x":80.02,"x":87.88,"dist":8.0,"flare1z":55.15,"flare2z":55.04,"flare1x":94.77,"flare1y":-131.46},{"flare2y":-75.87,"z":62.21,"y":-79.01,"start":false,"flare2x":101.2,"x":109.02,"dist":8.0,"flare1z":62.75,"flare2z":63.74,"flare1x":115.9,"flare1y":-82.11},{"flare2y":-42.44,"z":65.82,"y":-39.19,"start":false,"flare2x":109.53,"x":117.34,"dist":8.0,"flare1z":66.53,"flare2z":67.22,"flare1x":124.35,"flare1y":-36.45},{"flare2y":-23.02,"z":66.31,"y":-15.16,"start":false,"flare2x":96.86,"x":99.98,"dist":8.0,"flare1z":67.05,"flare2z":67.68,"flare1x":102.94,"flare1y":-8.24},{"flare2y":-5.76,"z":67.59,"y":2.03,"start":false,"flare2x":49.61,"x":52.86,"dist":8.0,"flare1z":68.51,"flare2z":68.75,"flare1x":56.07,"flare1y":8.87},{"flare2y":10.15,"z":68.94,"y":18.25,"start":false,"flare2x":7.7,"x":10.12,"dist":8.0,"flare1z":69.74,"flare2z":70.23,"flare1x":12.92,"flare1y":25.27},{"flare2y":26.22,"z":70.33,"y":34.28,"start":false,"flare2x":-38.21,"x":-35.69,"dist":8.0,"flare1z":71.18,"flare2z":71.58,"flare1x":-32.86,"flare1y":41.29},{"flare2y":46.79,"z":69.98,"y":54.79,"start":false,"flare2x":-90.82,"x":-88.08,"dist":8.0,"flare1z":71.15,"flare2z":70.88,"flare1x":-84.76,"flare1y":61.6},{"flare2y":79.34,"z":69.03,"y":86.68,"start":false,"flare2x":-150.06,"x":-145.89,"dist":8.0,"flare1z":70.27,"flare2z":69.85,"flare1x":-141.72,"flare1y":92.99},{"flare2y":103.19,"z":68.27,"y":110.61,"start":false,"flare2x":-189.33,"x":-185.31,"dist":8.0,"flare1z":69.48,"flare2z":69.13,"flare1x":-181.09,"flare1y":116.9},{"flare2y":155.73,"z":70.4,"y":156.41,"start":false,"flare2x":-233.37,"x":-224.96,"dist":8.0,"flare1z":71.58,"flare2z":71.24,"flare1x":-217.41,"flare1y":156.81},{"flare2y":197.43,"z":80.11,"y":196.61,"start":false,"flare2x":-230.37,"x":-221.98,"dist":8.0,"flare1z":80.86,"flare2z":81.41,"flare1x":-214.48,"flare1y":195.66},{"flare2y":230.98,"z":88.08,"y":230.86,"start":false,"flare2x":-227.51,"x":-219.07,"dist":8.0,"flare1z":88.95,"flare2z":89.25,"flare1x":-211.52,"flare1y":230.56},{"flare2y":260.78,"z":90.76,"y":252.6,"start":false,"flare2x":-185.82,"x":-187.91,"dist":8.0,"flare1z":91.72,"flare2z":91.88,"flare1x":-189.98,"flare1y":245.33},{"flare2y":255.94,"z":92.88,"y":247.5,"start":false,"flare2x":-147.95,"x":-148.15,"dist":8.0,"flare1z":93.78,"flare2z":94.04,"flare1x":-148.7,"flare1y":239.96},{"flare2y":258.64,"z":97.28,"y":250.22,"start":false,"flare2x":-97.48,"x":-96.84,"dist":8.0,"flare1z":98.36,"flare2z":98.2,"flare1x":-96.79,"flare1y":242.65},{"flare2y":261.6,"z":102.9,"y":253.28,"start":false,"flare2x":-52.79,"x":-51.35,"dist":8.0,"flare1z":103.83,"flare2z":104.01,"flare1x":-50.35,"flare1y":245.78},{"flare2y":265.34,"z":107.25,"y":256.95,"start":false,"flare2x":-3.06,"x":-3.86,"dist":8.0,"flare1z":108.33,"flare2z":108.23,"flare1x":-4.82,"flare1y":249.44},{"flare2y":280.66,"z":107.83,"y":275.65,"start":false,"flare2x":32.4,"x":39.2,"dist":8.0,"flare1z":108.76,"flare2z":108.99,"flare1x":45.04,"flare1y":270.85},{"flare2y":310.33,"z":109.16,"y":306.41,"start":false,"flare2x":51.51,"x":58.98,"dist":8.0,"flare1z":110.06,"flare2z":110.33,"flare1x":65.49,"flare1y":302.55},{"flare2y":354.25,"z":110.8,"y":346.51,"start":false,"flare2x":108.15,"x":111.5,"dist":8.0,"flare1z":111.42,"flare2z":112.29,"flare1x":114.15,"flare1y":339.44},{"flare2y":368.85,"z":108.94,"y":360.75,"start":false,"flare2x":149.86,"x":152.17,"dist":8.0,"flare1z":109.42,"flare2z":110.64,"flare1x":153.76,"flare1y":353.38},{"flare2y":370.38,"z":105.78,"y":362.19,"start":false,"flare2x":191.62,"x":189.62,"dist":8.0,"flare1z":106.47,"flare2z":107.23,"flare1x":187.45,"flare1y":354.95},{"flare2y":356.52,"z":103.83,"y":348.34,"start":false,"flare2x":241.12,"x":239.01,"dist":8.0,"flare1z":104.86,"flare2z":104.87,"flare1x":236.63,"flare1y":341.16},{"flare2y":340.51,"z":103.85,"y":332.17,"start":false,"flare2x":286.02,"x":284.68,"dist":8.0,"flare1z":104.69,"flare2z":105.09,"flare1x":283.11,"flare1y":324.78},{"flare2y":325.5,"z":102.75,"y":317.38,"start":false,"flare2x":345.17,"x":342.87,"dist":8.0,"flare1z":103.62,"flare2z":104.0,"flare1x":340.29,"flare1y":310.27},{"flare2y":309.61,"z":101.27,"y":301.51,"start":false,"flare2x":405.93,"x":403.55,"dist":8.0,"flare1z":102.09,"flare2z":102.54,"flare1x":400.96,"flare1y":294.4},{"flare2y":290.46,"z":101.29,"y":282.37,"start":false,"flare2x":463.53,"x":461.14,"dist":8.0,"flare1z":102.46,"flare2z":102.18,"flare1x":458.45,"flare1y":275.29},{"flare2y":267.28,"z":101.33,"y":259.21,"start":false,"flare2x":523.87,"x":521.4,"dist":8.0,"flare1z":102.04,"flare2z":102.73,"flare1x":518.68,"flare1y":252.17},{"flare2y":251.19,"z":101.39,"y":243.05,"start":false,"flare2x":574.25,"x":571.99,"dist":8.0,"flare1z":102.5,"flare2z":102.33,"flare1x":569.49,"flare1y":235.91},{"flare2y":236.07,"z":99.24,"y":227.93,"start":false,"flare2x":622.53,"x":620.28,"dist":8.0,"flare1z":100.34,"flare2z":100.28,"flare1x":617.59,"flare1y":220.85},{"flare2y":216.03,"z":91.89,"y":208.23,"start":false,"flare2x":678.56,"x":675.34,"dist":8.0,"flare1z":92.98,"flare2z":92.92,"flare1x":672.05,"flare1y":201.42},{"flare2y":199.85,"z":85.88,"y":192.11,"start":false,"flare2x":721.77,"x":718.44,"dist":8.0,"flare1z":87.08,"flare2z":86.78,"flare1x":715.14,"flare1y":185.3},{"flare2y":177.26,"z":80.68,"y":171.32,"start":false,"flare2x":759.26,"x":753.31,"dist":8.0,"flare1z":82.24,"flare2z":81.15,"flare1x":747.77,"flare1y":166.18},{"flare2y":132.12,"z":77.82,"y":132.98,"start":false,"flare2x":778.56,"x":770.19,"dist":8.0,"flare1z":78.64,"flare2z":79.13,"flare1x":762.69,"flare1y":134.07},{"flare2y":94.17,"z":77.95,"y":98.68,"start":false,"flare2x":760.13,"x":752.99,"dist":8.0,"flare1z":78.94,"flare2z":79.01,"flare1x":746.84,"flare1y":103.08},{"flare2y":57.4,"z":81.42,"y":62.79,"start":false,"flare2x":733.45,"x":726.96,"dist":8.0,"flare1z":82.41,"flare2z":82.49,"flare1x":721.3,"flare1y":67.81},{"flare2y":35.65,"z":82.52,"y":40.32,"start":false,"flare2x":718.01,"x":710.98,"dist":8.0,"flare1z":83.55,"flare2z":83.56,"flare1x":704.77,"flare1y":44.63},{"flare2y":-15.15,"z":81.17,"y":-22.56,"start":false,"flare2x":732.85,"x":728.8,"dist":8.0,"flare1z":82.09,"flare2z":82.36,"flare1x":724.89,"flare1y":-29.03},{"flare2y":-49.57,"z":78.87,"y":-56.97,"start":false,"flare2x":788.2,"x":784.15,"dist":8.0,"flare1z":79.75,"flare2z":80.08,"flare1x":780.09,"flare1y":-63.35},{"flare2y":-74.96,"z":78.87,"y":-82.41,"start":false,"flare2x":831.36,"x":827.39,"dist":8.0,"flare1z":79.91,"flare2z":79.91,"flare1x":823.27,"flare1y":-88.76},{"flare2y":-102.37,"z":77.7,"y":-109.85,"start":false,"flare2x":877.91,"x":873.98,"dist":8.0,"flare1z":78.78,"flare2z":78.7,"flare1x":869.71,"flare1y":-116.11},{"flare2y":-143.93,"z":72.73,"y":-150.82,"start":false,"flare2x":945.02,"x":940.15,"dist":8.0,"flare1z":73.74,"flare2z":73.79,"flare1x":935.32,"flare1y":-156.65},{"flare2y":-174.52,"z":70.62,"y":-182.02,"start":false,"flare2x":987.34,"x":983.44,"dist":8.0,"flare1z":71.37,"flare2z":72.0,"flare1x":979.45,"flare1y":-188.43},{"flare2y":-203.57,"z":68.47,"y":-211.05,"start":false,"flare2x":1037.49,"x":1033.56,"dist":8.0,"flare1z":69.52,"flare2z":69.49,"flare1x":1029.49,"flare1y":-217.43},{"flare2y":-233.01,"z":67.56,"y":-241.19,"start":false,"flare2x":1099.33,"x":1097.22,"dist":8.0,"flare1z":68.27,"flare2z":68.95,"flare1x":1094.83,"flare1y":-248.34},{"flare2y":-249.97,"z":67.3,"y":-257.9,"start":false,"flare2x":1150.65,"x":1147.78,"dist":8.0,"flare1z":67.98,"flare2z":68.73,"flare1x":1144.72,"flare1y":-264.81},{"flare2y":-284.32,"z":67.35,"y":-288.8,"start":false,"flare2x":1199.19,"x":1192.08,"dist":8.0,"flare1z":68.59,"flare2z":68.16,"flare1x":1185.41,"flare1y":-292.44},{"flare2y":-322.38,"z":67.36,"y":-324.3,"start":false,"flare2x":1216.79,"x":1208.59,"dist":8.0,"flare1z":68.58,"flare2z":68.2,"flare1x":1201.11,"flare1y":-325.54},{"flare2y":-358.63,"z":67.36,"y":-356.56,"start":false,"flare2x":1216.22,"x":1208.04,"dist":8.0,"flare1z":68.35,"flare2z":68.44,"flare1x":1200.78,"flare1y":-354.43},{"flare2y":-391.52,"z":66.58,"y":-389.42,"start":false,"flare2x":1207.17,"x":1199.0,"dist":8.0,"flare1z":67.46,"flare2z":67.8,"flare1x":1191.77,"flare1y":-387.21},{"flare2y":-430.65,"z":65.48,"y":-429.29,"start":false,"flare2x":1197.96,"x":1189.63,"dist":8.0,"flare1z":66.34,"flare2z":66.73,"flare1x":1182.23,"flare1y":-427.73}]', 'Twisted Mirror', 'Zion Diaz', '5980', NULL, NULL, 'nil', 236590, NULL, NULL, '', NULL),
	(5, '[{"start":true,"flare1z":17.04,"flare2z":17.05,"flare2x":1034.03,"flare1y":-1790.99,"x":1026.58,"flare1x":1019.13,"y":-1791.9,"z":16.11,"dist":7.5,"flare2y":-1792.74},{"start":false,"flare1z":17.04,"flare2z":17.04,"flare2x":1031.1,"flare1y":-1824.3,"x":1023.62,"flare1x":1016.16,"y":-1825.13,"z":16.11,"dist":7.5,"flare2y":-1825.68},{"start":false,"flare1z":17.05,"flare2z":17.05,"flare2x":1015.38,"flare1y":-1850.3,"x":1010.4,"flare1x":1005.48,"y":-1855.96,"z":16.11,"dist":7.5,"flare2y":-1861.58},{"start":false,"flare1z":17.04,"flare2z":17.04,"flare2x":1000.47,"flare1y":-1868.81,"x":993.52,"flare1x":986.63,"y":-1871.79,"z":16.11,"dist":7.5,"flare2y":-1874.61},{"start":false,"flare1z":17.04,"flare2z":17.05,"flare2x":995.23,"flare1y":-1910.06,"x":989.68,"flare1x":984.08,"y":-1905.07,"z":16.11,"dist":7.5,"flare2y":-1900.03},{"start":false,"flare1z":17.04,"flare2z":17.05,"flare2x":1016.36,"flare1y":-1920.45,"x":1015.13,"flare1x":1013.84,"y":-1913.06,"z":16.11,"dist":7.5,"flare2y":-1905.66},{"start":false,"flare1z":17.04,"flare2z":17.05,"flare2x":1035.65,"flare1y":-1911.89,"x":1042.1,"flare1x":1048.52,"y":-1908.02,"z":16.11,"dist":7.5,"flare2y":-1904.2},{"start":false,"flare1z":17.04,"flare2z":17.04,"flare2x":1043.25,"flare1y":-1843.67,"x":1050.76,"flare1x":1058.22,"y":-1842.87,"z":16.1,"dist":7.5,"flare2y":-1842.63},{"start":false,"flare1z":17.05,"flare2z":17.05,"flare2x":1048.05,"flare1y":-1809.3,"x":1054.82,"flare1x":1061.57,"y":-1806.02,"z":16.11,"dist":7.5,"flare2y":-1802.81},{"start":false,"flare1z":17.0,"flare2z":17.1,"flare2x":1083.68,"flare1y":-1803.41,"x":1079.65,"flare1x":1075.56,"y":-1797.12,"z":16.11,"dist":7.5,"flare2y":-1790.8},{"start":false,"flare1z":17.06,"flare2z":17.06,"flare2x":1090.36,"flare1y":-1843.9,"x":1082.9,"flare1x":1075.48,"y":-1844.99,"z":16.12,"dist":7.5,"flare2y":-1845.77},{"start":false,"flare1z":17.05,"flare2z":17.05,"flare2x":1086.94,"flare1y":-1892.62,"x":1081.29,"flare1x":1075.59,"y":-1887.74,"z":16.11,"dist":7.5,"flare2y":-1882.8},{"start":false,"flare1z":17.04,"flare2z":17.04,"flare2x":1114.34,"flare1y":-1905.38,"x":1114.72,"flare1x":1114.63,"y":-1897.88,"z":16.1,"dist":7.5,"flare2y":-1890.39},{"start":false,"flare1z":17.04,"flare2z":17.04,"flare2x":1195.46,"flare1y":-1909.84,"x":1195.38,"flare1x":1194.96,"y":-1902.35,"z":16.1,"dist":7.5,"flare2y":-1894.85},{"start":false,"flare1z":17.05,"flare2z":17.04,"flare2x":1243.71,"flare1y":-1911.12,"x":1247.94,"flare1x":1252.11,"y":-1904.88,"z":16.11,"dist":7.5,"flare2y":-1898.69},{"start":false,"flare1z":17.05,"flare2z":17.05,"flare2x":1242.73,"flare1y":-1872.91,"x":1244.02,"flare1x":1245.34,"y":-1880.29,"z":16.11,"dist":7.5,"flare2y":-1887.68},{"start":false,"flare1z":17.06,"flare2z":17.06,"flare2x":1203.14,"flare1y":-1868.82,"x":1206.24,"flare1x":1209.66,"y":-1875.5,"z":16.12,"dist":7.5,"flare2y":-1882.33},{"start":false,"flare1z":17.05,"flare2z":17.05,"flare2x":1195.24,"flare1y":-1861.01,"x":1199.76,"flare1x":1204.21,"y":-1854.97,"z":16.11,"dist":7.5,"flare2y":-1848.99},{"start":false,"flare1z":17.04,"flare2z":17.04,"flare2x":1228.23,"flare1y":-1860.68,"x":1227.64,"flare1x":1226.69,"y":-1853.24,"z":16.11,"dist":7.5,"flare2y":-1845.76},{"start":false,"flare1z":17.04,"flare2z":17.05,"flare2x":1245.72,"flare1y":-1861.15,"x":1249.8,"flare1x":1253.82,"y":-1854.82,"z":16.11,"dist":7.5,"flare2y":-1848.53},{"start":false,"flare1z":17.04,"flare2z":17.05,"flare2x":1252.33,"flare1y":-1843.6,"x":1259.66,"flare1x":1266.95,"y":-1841.83,"z":16.11,"dist":7.5,"flare2y":-1840.24},{"start":false,"flare1z":17.04,"flare2z":17.04,"flare2x":1255.98,"flare1y":-1783.38,"x":1263.45,"flare1x":1270.88,"y":-1782.36,"z":16.1,"dist":7.5,"flare2y":-1781.62},{"start":false,"flare1z":17.05,"flare2z":17.04,"flare2x":1261.94,"flare1y":-1728.73,"x":1269.43,"flare1x":1276.93,"y":-1728.93,"z":16.11,"dist":7.5,"flare2y":-1729.32},{"start":false,"flare1z":17.04,"flare2z":17.04,"flare2x":1257.93,"flare1y":-1700.45,"x":1257.08,"flare1x":1256.36,"y":-1707.92,"z":16.11,"dist":7.5,"flare2y":-1715.37},{"start":false,"flare1z":17.04,"flare2z":17.04,"flare2x":1250.08,"flare1y":-1732.2,"x":1242.58,"flare1x":1235.1,"y":-1732.63,"z":16.11,"dist":7.5,"flare2y":-1732.79},{"start":false,"flare1z":17.04,"flare2z":17.05,"flare2x":1246.01,"flare1y":-1767.87,"x":1238.9,"flare1x":1231.81,"y":-1770.33,"z":16.11,"dist":7.5,"flare2y":-1772.72},{"start":false,"flare1z":17.04,"flare2z":17.04,"flare2x":1219.56,"flare1y":-1771.85,"x":1220.87,"flare1x":1222.37,"y":-1779.2,"z":16.11,"dist":7.5,"flare2y":-1786.58},{"start":false,"flare1z":17.05,"flare2z":17.05,"flare2x":1182.04,"flare1y":-1768.67,"x":1182.2,"flare1x":1182.51,"y":-1776.16,"z":16.11,"dist":7.5,"flare2y":-1783.66},{"start":false,"flare1z":17.07,"flare2z":17.01,"flare2x":1129.8,"flare1y":-1768.58,"x":1126.31,"flare1x":1123.06,"y":-1775.35,"z":16.11,"dist":7.5,"flare2y":-1781.98},{"start":false,"flare1z":17.04,"flare2z":17.04,"flare2x":1124.97,"flare1y":-1792.71,"x":1117.48,"flare1x":1110.0,"y":-1793.43,"z":16.1,"dist":7.5,"flare2y":-1793.75},{"start":false,"flare1z":17.03,"flare2z":17.05,"flare2x":1121.81,"flare1y":-1826.03,"x":1114.31,"flare1x":1106.81,"y":-1826.26,"z":16.11,"dist":7.5,"flare2y":-1826.23},{"start":false,"flare1z":17.05,"flare2z":17.05,"flare2x":1122.54,"flare1y":-1841.3,"x":1115.27,"flare1x":1107.99,"y":-1839.52,"z":16.11,"dist":7.5,"flare2y":-1837.67},{"start":false,"flare1z":17.04,"flare2z":17.04,"flare2x":1140.86,"flare1y":-1856.61,"x":1141.22,"flare1x":1141.34,"y":-1849.1,"z":16.11,"dist":7.5,"flare2y":-1841.61},{"start":false,"flare1z":17.04,"flare2z":17.04,"flare2x":1160.2,"flare1y":-1854.06,"x":1164.46,"flare1x":1168.55,"y":-1847.78,"z":16.11,"dist":7.5,"flare2y":-1841.6},{"start":false,"flare1z":17.06,"flare2z":17.02,"flare2x":1166.91,"flare1y":-1844.5,"x":1173.28,"flare1x":1179.43,"y":-1840.21,"z":16.1,"dist":7.5,"flare2y":-1836.24},{"start":false,"flare1z":17.04,"flare2z":17.05,"flare2x":1168.24,"flare1y":-1824.49,"x":1175.74,"flare1x":1183.24,"y":-1824.26,"z":16.11,"dist":7.5,"flare2y":-1824.19},{"start":false,"flare1z":17.05,"flare2z":17.05,"flare2x":1168.76,"flare1y":-1784.89,"x":1176.26,"flare1x":1183.76,"y":-1784.84,"z":16.11,"dist":7.5,"flare2y":-1784.86},{"start":false,"flare1z":17.05,"flare2z":17.05,"flare2x":1169.67,"flare1y":-1768.15,"x":1177.16,"flare1x":1184.64,"y":-1767.61,"z":16.11,"dist":7.5,"flare2y":-1767.14},{"start":false,"flare1z":17.04,"flare2z":17.04,"flare2x":1169.87,"flare1y":-1724.4,"x":1175.53,"flare1x":1181.27,"y":-1729.22,"z":16.11,"dist":7.5,"flare2y":-1734.14},{"start":false,"flare1z":17.04,"flare2z":17.04,"flare2x":1152.58,"flare1y":-1712.27,"x":1153.91,"flare1x":1155.65,"y":-1719.57,"z":16.11,"dist":7.5,"flare2y":-1726.96},{"start":false,"flare1z":17.07,"flare2z":17.01,"flare2x":1135.69,"flare1y":-1717.9,"x":1129.8,"flare1x":1124.04,"y":-1722.75,"z":16.11,"dist":7.5,"flare2y":-1727.35},{"start":false,"flare1z":17.04,"flare2z":17.05,"flare2x":1106.71,"flare1y":-1738.74,"x":1107.41,"flare1x":1108.17,"y":-1746.2,"z":16.11,"dist":7.5,"flare2y":-1753.66},{"start":false,"flare1z":17.04,"flare2z":17.04,"flare2x":1085.76,"flare1y":-1732.89,"x":1091.26,"flare1x":1096.93,"y":-1737.81,"z":16.11,"dist":7.5,"flare2y":-1742.91},{"start":false,"flare1z":17.04,"flare2z":17.04,"flare2x":1075.43,"flare1y":-1713.63,"x":1078.89,"flare1x":1082.57,"y":-1720.16,"z":16.11,"dist":7.5,"flare2y":-1726.82},{"start":false,"flare1z":17.07,"flare2z":17.01,"flare2x":1053.86,"flare1y":-1707.62,"x":1052.2,"flare1x":1050.92,"y":-1715.0,"z":16.11,"dist":7.5,"flare2y":-1722.33},{"start":false,"flare1z":17.02,"flare2z":17.06,"flare2x":1007.69,"flare1y":-1707.88,"x":1011.64,"flare1x":1015.86,"y":-1714.09,"z":16.11,"dist":7.5,"flare2y":-1720.47},{"start":false,"flare1z":17.05,"flare2z":17.04,"flare2x":994.98,"flare1y":-1698.22,"x":1000.93,"flare1x":1006.75,"y":-1693.49,"z":16.11,"dist":7.5,"flare2y":-1688.92},{"start":false,"flare1z":17.03,"flare2z":17.06,"flare2x":1021.08,"flare1y":-1691.89,"x":1018.12,"flare1x":1015.06,"y":-1685.04,"z":16.11,"dist":7.5,"flare2y":-1678.15},{"start":false,"flare1z":17.04,"flare2z":17.04,"flare2x":1040.64,"flare1y":-1696.18,"x":1033.22,"flare1x":1025.75,"y":-1695.37,"z":16.11,"dist":7.5,"flare2y":-1694.34},{"start":false,"flare1z":17.04,"flare2z":17.04,"flare2x":1039.81,"flare1y":-1726.0,"x":1032.31,"flare1x":1024.88,"y":-1727.01,"z":16.11,"dist":7.5,"flare2y":-1727.45},{"start":false,"flare1z":17.05,"flare2z":17.04,"flare2x":1038.89,"flare1y":-1754.72,"x":1031.43,"flare1x":1023.95,"y":-1755.34,"z":16.11,"dist":7.5,"flare2y":-1756.04},{"start":false,"flare1z":17.04,"flare2z":17.05,"flare2x":1035.66,"flare1y":-1776.39,"x":1028.31,"flare1x":1021.0,"y":-1778.06,"z":16.11,"dist":7.5,"flare2y":-1779.59}]', 'Underground', 'Rain Jaime', '1622', NULL, NULL, NULL, NULL, 86465, 'nil', 'Let&#39;s go undetected!', NULL),
	(6, '[{"flare1y":-562.03,"flare2x":-1191.63,"flare1z":26.59,"flare1x":-1202.65,"x":-1197.27,"y":-568.14,"z":25.57,"start":true,"dist":8.5,"flare2y":-574.97,"flare2z":26.54},{"flare1y":-675.68,"flare2x":-1344.55,"flare1z":24.9,"flare1x":-1356.75,"x":-1350.72,"y":-685.05,"z":23.8,"start":false,"dist":11.5,"flare2y":-695.18,"flare2z":24.67},{"flare1y":-690.87,"flare2x":-1509.25,"flare1z":25.82,"flare1x":-1476.67,"x":-1492.61,"y":-708.99,"z":24.96,"start":false,"dist":24.5,"flare2y":-727.47,"flare2z":26.12},{"flare1y":-534.13,"flare2x":-1697.18,"flare1z":34.66,"flare1x":-1666.03,"x":-1681.29,"y":-559.53,"z":33.39,"start":false,"dist":30.0,"flare2y":-585.4,"flare2z":34.13},{"flare1y":-499.61,"flare2x":-1833.71,"flare1z":28.24,"flare1x":-1821.97,"x":-1827.52,"y":-507.49,"z":27.12,"start":false,"dist":10.0,"flare2y":-515.8,"flare2z":27.98},{"flare1y":-325.22,"flare2x":-2241.92,"flare1z":12.7,"flare1x":-2237.88,"x":-2239.72,"y":-341.76,"z":11.72,"start":false,"dist":17.0,"flare2y":-358.98,"flare2z":12.75},{"flare1y":67.55,"flare2x":-2832.42,"flare1z":13.9,"flare1x":-2819.84,"x":-2825.87,"y":52.05,"z":12.89,"start":false,"dist":17.0,"flare2y":35.97,"flare2z":13.88},{"flare1y":237.32,"flare2x":-3047.81,"flare1z":15.49,"flare1x":-3048.32,"x":-3047.94,"y":227.19,"z":14.44,"start":false,"dist":10.5,"flare2y":216.33,"flare2z":15.41},{"flare1y":430.5,"flare2x":-3054.78,"flare1z":5.66,"flare1x":-3036.11,"x":-3045.18,"y":435.02,"z":4.68,"start":false,"dist":10.5,"flare2y":440.11,"flare2z":5.71},{"flare1y":811.46,"flare2x":-3121.79,"flare1z":17.56,"flare1x":-3091.32,"x":-3106.18,"y":800.21,"z":16.6,"start":false,"dist":19.0,"flare2y":788.75,"flare2z":17.62},{"flare1y":921.95,"flare2x":-3174.19,"flare1z":13.52,"flare1x":-3172.74,"x":-3173.31,"y":910.33,"z":12.75,"start":false,"dist":12.0,"flare2y":898.0,"flare2z":14.0},{"flare1y":1084.7,"flare2x":-3229.75,"flare1z":9.83,"flare1x":-3204.1,"x":-3216.65,"y":1090.04,"z":8.93,"start":false,"dist":14.0,"flare2y":1095.91,"flare2z":10.03},{"flare1y":1306.68,"flare2x":-3108.7,"flare1z":19.3,"flare1x":-3110.48,"x":-3109.75,"y":1320.3,"z":18.45,"start":false,"dist":14.0,"flare2y":1334.63,"flare2z":19.62},{"flare1y":1174.17,"flare2x":-3074.29,"flare1z":20.41,"flare1x":-3072.78,"x":-3073.64,"y":1187.78,"z":19.59,"start":false,"dist":14.0,"flare2y":1202.13,"flare2z":20.8},{"flare1y":1405.12,"flare2x":-2753.29,"flare1z":88.92,"flare1x":-2731.25,"x":-2741.97,"y":1408.16,"z":87.82,"start":false,"dist":11.5,"flare2y":1411.69,"flare2z":88.75},{"flare1y":1294.08,"flare2x":-2620.19,"flare1z":145.84,"flare1x":-2642.86,"x":-2631.86,"y":1292.33,"z":144.94,"start":false,"dist":11.5,"flare2y":1290.18,"flare2z":146.08},{"flare1y":1053.03,"flare2x":-2285.23,"flare1z":196.99,"flare1x":-2268.23,"x":-2276.55,"y":1060.44,"z":196.08,"start":false,"dist":11.5,"flare2y":1068.53,"flare2z":197.18},{"flare1y":810.1,"flare2x":-2013.36,"flare1z":160.13,"flare1x":-2030.25,"x":-2022.15,"y":809.33,"z":159.27,"start":false,"dist":8.5,"flare2y":808.23,"flare2z":160.39},{"flare1y":810.18,"flare2x":-1751.42,"flare1z":139.09,"flare1x":-1779.56,"x":-1765.65,"y":796.31,"z":138.14,"start":false,"dist":20.0,"flare2y":781.75,"flare2z":139.17},{"flare1y":139.06,"flare2x":-1838.04,"flare1z":76.28,"flare1x":-1819.35,"x":-1828.4,"y":142.3,"z":75.94,"start":false,"dist":10.0,"flare2y":146.05,"flare2z":77.65},{"flare1y":244.36,"flare2x":-1480.27,"flare1z":60.56,"flare1x":-1460.19,"x":-1470.06,"y":253.77,"z":59.88,"start":false,"dist":14.0,"flare2y":263.87,"flare2z":61.21},{"flare1y":358.71,"flare2x":-1063.09,"flare1z":67.35,"flare1x":-1091.07,"x":-1077.45,"y":359.34,"z":66.43,"start":false,"dist":14.0,"flare2y":359.73,"flare2z":67.5},{"flare1y":43.8,"flare2x":-970.18,"flare1z":50.62,"flare1x":-994.77,"x":-982.86,"y":50.43,"z":50.03,"start":false,"dist":14.0,"flare2y":57.17,"flare2z":51.44},{"flare1y":-359.01,"flare2x":-723.74,"flare1z":34.74,"flare1x":-737.59,"x":-730.93,"y":-343.76,"z":34.0,"start":false,"dist":17.0,"flare2y":-327.96,"flare2z":35.25},{"flare1y":-515.87,"flare2x":-188.51,"flare1z":34.02,"flare1x":-229.49,"x":-209.27,"y":-524.89,"z":33.02,"start":false,"dist":22.5,"flare2y":-534.45,"flare2z":34.02},{"flare1y":-635.68,"flare2x":-338.9,"flare1z":31.54,"flare1x":-338.81,"x":-338.72,"y":-657.82,"z":30.54,"start":false,"dist":22.5,"flare2y":-680.68,"flare2z":31.54},{"flare1y":-558.55,"flare2x":-907.01,"flare1z":31.44,"flare1x":-873.92,"x":-890.08,"y":-568.79,"z":30.69,"start":false,"dist":19.5,"flare2y":-579.18,"flare2z":31.99},{"flare1y":-435.05,"flare2x":-982.61,"flare1z":36.57,"flare1x":-997.56,"x":-990.15,"y":-447.67,"z":35.88,"start":false,"dist":15.0,"flare2y":-461.05,"flare2z":37.19},{"flare1y":-511.61,"flare2x":-1123.13,"flare1z":33.23,"flare1x":-1131.35,"x":-1127.3,"y":-518.67,"z":32.12,"start":false,"dist":8.5,"flare2y":-526.49,"flare2z":32.99}]', 'Lights Camera Action', 'Adam Foxx', '8997', NULL, NULL, 'nil', 0, 289799, 'nil', 'City Tour', NULL),
	(7, '[{"x":-1313.74,"flare1z":47.88,"flare2z":47.86,"flare1y":-77.32,"dist":20.5,"flare2x":-1309.7,"flare1x":-1318.23,"flare2y":-37.22,"start":true,"z":46.79,"y":-57.75},{"x":-1115.18,"flare1z":38.12,"flare2z":37.61,"flare1y":-179.4,"dist":22.5,"flare2x":-1105.37,"flare1x":-1125.2,"flare2y":-139.0,"start":false,"z":36.8,"y":-159.73},{"x":-1001.35,"flare1z":37.6,"flare2z":36.55,"flare1y":-188.31,"dist":22.0,"flare2x":-1011.88,"flare1x":-991.76,"flare2y":-149.19,"start":false,"z":36.03,"y":-168.98},{"x":-871.27,"flare1z":37.22,"flare2z":37.23,"flare1y":-143.67,"dist":16.0,"flare2x":-857.18,"flare1x":-884.93,"flare2y":-127.73,"start":false,"z":36.17,"y":-136.18},{"x":-794.92,"flare1z":36.27,"flare2z":36.3,"flare1y":-277.94,"dist":16.0,"flare2x":-778.59,"flare1x":-810.45,"flare2y":-274.92,"start":false,"z":35.23,"y":-276.79},{"x":-688.83,"flare1z":33.4,"flare2z":34.27,"flare1y":-377.52,"dist":21.0,"flare2x":-682.4,"flare1x":-695.6,"flare2y":-337.66,"start":false,"z":32.77,"y":-358.1},{"x":-465.93,"flare1z":33.25,"flare2z":33.33,"flare1y":-394.28,"dist":16.5,"flare2x":-464.1,"flare1x":-468.27,"flare2y":-361.54,"start":false,"z":32.23,"y":-378.37},{"x":-364.09,"flare1z":29.86,"flare2z":31.22,"flare1y":-405.87,"dist":16.0,"flare2x":-361.64,"flare1x":-367.02,"flare2y":-374.36,"start":false,"z":29.45,"y":-390.59},{"x":-226.82,"flare1z":28.96,"flare2z":31.23,"flare1y":-424.67,"dist":25.5,"flare2x":-205.34,"flare1x":-247.94,"flare2y":-396.71,"start":false,"z":29.02,"y":-411.19},{"x":-211.16,"flare1z":34.21,"flare2z":33.79,"flare1y":-524.29,"dist":16.5,"flare2x":-195.23,"flare1x":-226.06,"flare2y":-536.04,"start":false,"z":32.95,"y":-530.31},{"x":-264.92,"flare1z":32.57,"flare2z":32.49,"flare1y":-606.51,"dist":11.0,"flare2x":-264.66,"flare1x":-264.51,"flare2y":-628.51,"start":false,"z":31.47,"y":-617.08},{"x":-395.64,"flare1z":29.35,"flare2z":29.35,"flare1y":-645.7,"dist":13.0,"flare2x":-394.98,"flare1x":-395.65,"flare2y":-671.69,"start":false,"z":28.28,"y":-658.28},{"x":-493.54,"flare1z":32.26,"flare2z":32.17,"flare1y":-643.33,"dist":15.5,"flare2x":-494.25,"flare1x":-492.25,"flare2y":-674.26,"start":false,"z":31.16,"y":-658.35},{"x":-545.85,"flare1z":32.68,"flare2z":32.43,"flare1y":-698.52,"dist":12.5,"flare2x":-533.04,"flare1x":-557.89,"flare2y":-695.73,"start":false,"z":31.5,"y":-697.49},{"x":-500.1,"flare1z":30.05,"flare2z":30.03,"flare1y":-795.19,"dist":12.5,"flare2x":-487.3,"flare1x":-511.94,"flare2y":-799.36,"start":false,"z":28.98,"y":-797.52},{"x":-407.09,"flare1z":30.84,"flare2z":30.82,"flare1y":-854.17,"dist":13.0,"flare2x":-405.18,"flare1x":-409.49,"flare2y":-828.52,"start":false,"z":29.77,"y":-841.82},{"x":-326.6,"flare1z":30.84,"flare2z":30.96,"flare1y":-867.11,"dist":17.5,"flare2x":-323.09,"flare1x":-330.56,"flare2y":-832.92,"start":false,"z":29.84,"y":-850.5},{"x":-239.02,"flare1z":29.63,"flare2z":29.88,"flare1y":-891.31,"dist":17.5,"flare2x":-236.15,"flare1x":-242.37,"flare2y":-856.87,"start":false,"z":28.68,"y":-874.57},{"x":-168.28,"flare1z":29.82,"flare2z":29.78,"flare1y":-845.82,"dist":20.5,"flare2x":-188.12,"flare1x":-149.47,"flare2y":-832.13,"start":false,"z":28.75,"y":-838.82},{"x":-134.31,"flare1z":33.46,"flare2z":33.38,"flare1y":-754.97,"dist":17.5,"flare2x":-151.47,"flare1x":-118.16,"flare2y":-744.23,"start":false,"z":32.37,"y":-749.43},{"x":-111.3,"flare1z":34.19,"flare2z":34.34,"flare1y":-693.06,"dist":17.5,"flare2x":-127.94,"flare1x":-95.69,"flare2y":-679.46,"start":false,"z":33.21,"y":-686.13},{"x":-89.8,"flare1z":34.25,"flare2z":34.81,"flare1y":-683.16,"dist":9.0,"flare2x":-85.85,"flare1x":-93.93,"flare2y":-667.08,"start":false,"z":33.45,"y":-675.65},{"x":-37.37,"flare1z":31.56,"flare2z":31.64,"flare1y":-696.34,"dist":9.0,"flare2x":-39.26,"flare1x":-36.26,"flare2y":-678.59,"start":false,"z":30.53,"y":-687.84},{"x":3.81,"flare1z":31.59,"flare2z":31.59,"flare1y":-693.72,"dist":9.5,"flare2x":2.7,"flare1x":4.22,"flare2y":-674.78,"start":false,"z":30.53,"y":-684.65},{"x":28.61,"flare1z":30.89,"flare2z":30.88,"flare1y":-665.46,"dist":11.5,"flare2x":17.65,"flare1x":38.52,"flare2y":-655.8,"start":false,"z":29.82,"y":-660.52},{"x":62.37,"flare1z":30.95,"flare2z":30.96,"flare1y":-635.78,"dist":11.5,"flare2x":67.48,"flare1x":57.06,"flare2y":-615.27,"start":false,"z":29.9,"y":-626.05},{"x":83.12,"flare1z":31.09,"flare2z":30.66,"flare1y":-609.9,"dist":11.5,"flare2x":72.01,"flare1x":93.2,"flare2y":-600.96,"start":false,"z":29.82,"y":-605.3},{"x":137.52,"flare1z":30.57,"flare2z":30.84,"flare1y":-586.85,"dist":7.5,"flare2x":139.46,"flare1x":135.2,"flare2y":-572.47,"start":false,"z":29.63,"y":-580.16},{"x":293.17,"flare1z":28.68,"flare2z":28.42,"flare1y":-651.39,"dist":8.0,"flare2x":295.52,"flare1x":290.49,"flare2y":-636.2,"start":false,"z":27.5,"y":-644.3},{"x":345.27,"flare1z":28.61,"flare2z":28.59,"flare1y":-683.65,"dist":18.0,"flare2x":362.05,"flare1x":329.53,"flare2y":-699.08,"start":false,"z":27.54,"y":-691.47},{"x":308.23,"flare1z":28.61,"flare2z":28.58,"flare1y":-797.11,"dist":18.5,"flare2x":325.88,"flare1x":291.61,"flare2y":-811.05,"start":false,"z":27.54,"y":-804.22},{"x":260.06,"flare1z":28.64,"flare2z":28.73,"flare1y":-835.09,"dist":17.5,"flare2x":252.48,"flare1x":267.83,"flare2y":-866.54,"start":false,"z":27.63,"y":-850.29},{"x":194.99,"flare1z":30.29,"flare2z":30.33,"flare1y":-811.76,"dist":21.0,"flare2x":187.32,"flare1x":202.92,"flare2y":-850.75,"start":false,"z":29.26,"y":-830.74},{"x":183.43,"flare1z":30.87,"flare2z":31.03,"flare1y":-794.3,"dist":17.5,"flare2x":166.96,"flare1x":198.86,"flare2y":-779.89,"start":false,"z":29.9,"y":-786.98},{"x":225.23,"flare1z":36.64,"flare2z":36.51,"flare1y":-681.15,"dist":17.5,"flare2x":207.95,"flare1x":241.52,"flare2y":-671.23,"start":false,"z":35.53,"y":-676.0},{"x":209.46,"flare1z":41.33,"flare2z":40.98,"flare1y":-602.36,"dist":8.5,"flare2x":206.33,"flare1x":212.84,"flare2y":-618.06,"start":false,"z":40.12,"y":-609.7},{"x":135.04,"flare1z":43.14,"flare2z":43.33,"flare1y":-575.71,"dist":8.5,"flare2x":132.0,"flare1x":138.36,"flare2y":-591.48,"start":false,"z":42.16,"y":-583.08},{"x":117.23,"flare1z":42.36,"flare2z":42.61,"flare1y":-542.18,"dist":18.5,"flare2x":99.07,"flare1x":134.37,"flare2y":-531.11,"start":false,"z":41.42,"y":-536.47},{"x":169.25,"flare1z":41.8,"flare2z":41.95,"flare1y":-385.78,"dist":15.5,"flare2x":154.7,"flare1x":182.76,"flare2y":-372.59,"start":false,"z":40.83,"y":-379.08},{"x":220.85,"flare1z":43.45,"flare2z":43.53,"flare1y":-367.19,"dist":15.5,"flare2x":225.01,"flare1x":216.31,"flare2y":-337.43,"start":false,"z":42.44,"y":-352.81},{"x":269.34,"flare1z":44.12,"flare2z":44.3,"flare1y":-385.98,"dist":16.5,"flare2x":275.0,"flare1x":263.39,"flare2y":-355.09,"start":false,"z":43.15,"y":-371.05},{"x":328.64,"flare1z":44.5,"flare2z":44.5,"flare1y":-404.09,"dist":13.5,"flare2x":333.85,"flare1x":323.19,"flare2y":-379.28,"start":false,"z":43.44,"y":-392.2},{"x":414.74,"flare1z":46.63,"flare2z":46.16,"flare1y":-397.85,"dist":13.5,"flare2x":406.38,"flare1x":422.09,"flare2y":-375.9,"start":false,"z":45.34,"y":-387.03},{"x":455.3,"flare1z":46.36,"flare2z":47.1,"flare1y":-340.77,"dist":17.0,"flare2x":439.31,"flare1x":470.24,"flare2y":-326.67,"start":false,"z":45.66,"y":-333.6},{"x":492.57,"flare1z":45.01,"flare2z":46.65,"flare1y":-300.89,"dist":18.5,"flare2x":476.03,"flare1x":508.03,"flare2y":-282.39,"start":false,"z":44.77,"y":-291.56},{"x":521.5,"flare1z":50.55,"flare2z":51.04,"flare1y":-207.77,"dist":13.5,"flare2x":507.79,"flare1x":534.47,"flare2y":-211.87,"start":false,"z":49.74,"y":-209.44},{"x":521.99,"flare1z":60.65,"flare2z":61.16,"flare1y":-128.09,"dist":15.5,"flare2x":508.47,"flare1x":534.44,"flare2y":-111.17,"start":false,"z":59.89,"y":-119.6},{"x":566.4,"flare1z":66.04,"flare2z":70.29,"flare1y":-99.88,"dist":18.0,"flare2x":560.64,"flare1x":571.33,"flare2y":-65.76,"start":false,"z":67.09,"y":-83.14},{"x":669.12,"flare1z":82.03,"flare2z":82.19,"flare1y":-34.41,"dist":14.0,"flare2x":658.45,"flare1x":678.75,"flare2y":-15.12,"start":false,"z":81.09,"y":-24.84},{"x":709.57,"flare1z":83.48,"flare2z":83.52,"flare1y":26.56,"dist":16.0,"flare2x":695.7,"flare1x":722.38,"flare2y":44.22,"start":false,"z":82.44,"y":35.42},{"x":758.22,"flare1z":78.51,"flare2z":78.64,"flare1y":95.65,"dist":14.0,"flare2x":745.87,"flare1x":769.51,"flare2y":110.64,"start":false,"z":77.49,"y":103.19},{"x":725.22,"flare1z":85.17,"flare2z":86.73,"flare1y":202.71,"dist":11.5,"flare2x":719.86,"flare1x":730.71,"flare2y":182.49,"start":false,"z":84.91,"y":193.13},{"x":614.35,"flare1z":100.55,"flare2z":101.18,"flare1y":240.73,"dist":11.5,"flare2x":611.31,"flare1x":617.73,"flare2y":218.65,"start":false,"z":99.83,"y":230.18},{"x":538.95,"flare1z":102.3,"flare2z":102.47,"flare1y":264.1,"dist":11.5,"flare2x":535.04,"flare1x":543.21,"flare2y":242.6,"start":false,"z":101.32,"y":253.87},{"x":453.0,"flare1z":102.09,"flare2z":102.55,"flare1y":295.42,"dist":11.5,"flare2x":448.96,"flare1x":457.41,"flare2y":274.03,"start":false,"z":101.25,"y":285.26},{"x":429.57,"flare1z":103.46,"flare2z":102.79,"flare1y":326.57,"dist":10.5,"flare2x":418.65,"flare1x":439.64,"flare2y":326.42,"start":false,"z":102.11,"y":326.83},{"x":399.6,"flare1z":109.44,"flare2z":109.69,"flare1y":380.02,"dist":10.5,"flare2x":395.37,"flare1x":404.1,"flare2y":360.92,"start":false,"z":108.54,"y":371.0},{"x":310.07,"flare1z":117.15,"flare2z":117.37,"flare1y":413.15,"dist":10.5,"flare2x":305.49,"flare1x":314.84,"flare2y":394.35,"start":false,"z":116.21,"y":404.27},{"x":271.78,"flare1z":119.31,"flare2z":119.02,"flare1y":432.47,"dist":8.5,"flare2x":267.42,"flare1x":276.23,"flare2y":417.93,"start":false,"z":118.13,"y":425.73},{"x":227.51,"flare1z":119.3,"flare2z":119.29,"flare1y":444.93,"dist":8.5,"flare2x":230.08,"flare1x":225.76,"flare2y":428.48,"start":false,"z":118.21,"y":437.04},{"x":171.64,"flare1z":117.71,"flare2z":117.28,"flare1y":430.07,"dist":8.5,"flare2x":173.59,"flare1x":170.55,"flare2y":413.35,"start":false,"z":116.44,"y":422.06},{"x":112.23,"flare1z":115.2,"flare2z":114.73,"flare1y":402.86,"dist":8.5,"flare2x":117.43,"flare1x":108.13,"flare2y":388.64,"start":false,"z":113.9,"y":395.9},{"x":73.95,"flare1z":112.87,"flare2z":112.43,"flare1y":358.06,"dist":9.5,"flare2x":82.33,"flare1x":66.63,"flare2y":347.37,"start":false,"z":111.59,"y":352.69},{"x":52.35,"flare1z":110.44,"flare2z":110.05,"flare1y":310.14,"dist":10.0,"flare2x":62.09,"flare1x":43.64,"flare2y":302.42,"start":false,"z":109.18,"y":306.15},{"x":-10.71,"flare1z":107.89,"flare2z":107.87,"flare1y":278.96,"dist":17.0,"flare2x":-12.7,"flare1x":-8.19,"flare2y":245.26,"start":false,"z":106.8,"y":262.58},{"x":-122.27,"flare1z":97.44,"flare2z":94.47,"flare1y":267.42,"dist":14.5,"flare2x":-121.25,"flare1x":-122.6,"flare2y":238.6,"start":false,"z":94.91,"y":253.42},{"x":-238.38,"flare1z":91.35,"flare2z":91.34,"flare1y":277.61,"dist":14.5,"flare2x":-239.26,"flare1x":-236.93,"flare2y":248.7,"start":false,"z":90.29,"y":263.61},{"x":-360.98,"flare1z":83.76,"flare2z":84.28,"flare1y":256.41,"dist":14.5,"flare2x":-358.02,"flare1x":-363.03,"flare2y":227.84,"start":false,"z":82.93,"y":242.48},{"x":-560.91,"flare1z":82.31,"flare2z":82.32,"flare1y":270.59,"dist":16.5,"flare2x":-562.5,"flare1x":-558.85,"flare2y":237.79,"start":false,"z":81.26,"y":254.65},{"x":-687.2,"flare1z":81.65,"flare2z":82.02,"flare1y":300.53,"dist":12.5,"flare2x":-688.11,"flare1x":-685.71,"flare2y":275.65,"start":false,"z":80.79,"y":288.55},{"x":-782.3,"flare1z":85.31,"flare2z":84.82,"flare1y":296.37,"dist":10.5,"flare2x":-780.82,"flare1x":-783.06,"flare2y":275.49,"start":false,"z":84.02,"y":286.32},{"x":-855.12,"flare1z":85.8,"flare2z":85.46,"flare1y":339.75,"dist":10.5,"flare2x":-866.03,"flare1x":-845.04,"flare2y":339.08,"start":false,"z":84.59,"y":339.83},{"x":-877.78,"flare1z":85.84,"flare2z":86.86,"flare1y":445.29,"dist":9.5,"flare2x":-876.08,"flare1x":-878.73,"flare2y":426.5,"start":false,"z":85.26,"y":436.27},{"x":-934.65,"flare1z":79.4,"flare2z":79.87,"flare1y":431.91,"dist":7.5,"flare2x":-932.07,"flare1x":-936.37,"flare2y":417.55,"start":false,"z":78.53,"y":425.05},{"x":-1032.48,"flare1z":69.69,"flare2z":69.57,"flare1y":405.61,"dist":8.5,"flare2x":-1031.73,"flare1x":-1032.54,"flare2y":388.63,"start":false,"z":68.55,"y":397.53},{"x":-1077.36,"flare1z":68.18,"flare2z":68.23,"flare1y":375.77,"dist":8.5,"flare2x":-1068.44,"flare1x":-1085.43,"flare2y":375.97,"start":false,"z":67.14,"y":375.55},{"x":-1079.02,"flare1z":64.58,"flare2z":63.94,"flare1y":309.94,"dist":8.5,"flare2x":-1070.15,"flare1x":-1086.95,"flare2y":307.46,"start":false,"z":63.19,"y":308.44},{"x":-1124.47,"flare1z":65.37,"flare2z":64.8,"flare1y":283.33,"dist":18.0,"flare2x":-1120.2,"flare1x":-1127.94,"flare2y":248.18,"start":false,"z":64.04,"y":266.1},{"x":-1412.69,"flare1z":57.17,"flare2z":56.76,"flare1y":192.3,"dist":18.5,"flare2x":-1398.51,"flare1x":-1425.81,"flare2y":167.33,"start":false,"z":55.88,"y":179.87},{"x":-1427.41,"flare1z":52.0,"flare2z":52.01,"flare1y":16.14,"dist":16.5,"flare2x":-1410.56,"flare1x":-1443.45,"flare2y":18.83,"start":false,"z":50.94,"y":17.13}]', 'Concrete Corners', 'Charles Gonzales', '7474', NULL, NULL, 'nil', 0, 203199, 'nil', 'Concrete Corners', NULL),
	(8, '[{"flare1x":121.98,"x":126.0,"y":-1010.04,"z":27.65,"flare2y":-994.22,"flare1y":-1025.07,"start":true,"flare2x":130.47,"flare2z":28.7,"dist":16.0,"flare1z":28.67},{"flare1x":194.89,"x":198.11,"y":-1034.44,"z":27.61,"flare2y":-1025.22,"flare1y":-1042.91,"start":false,"flare2x":201.83,"flare2z":28.64,"dist":9.5,"flare1z":28.64},{"flare1x":242.37,"x":235.41,"y":-1023.15,"z":27.59,"flare2y":-1019.62,"flare1y":-1026.12,"start":false,"flare2x":227.75,"flare2z":28.63,"dist":8.0,"flare1z":28.62},{"flare1x":274.09,"x":266.95,"y":-933.13,"z":27.51,"flare2y":-930.31,"flare1y":-935.62,"start":false,"flare2x":259.0,"flare2z":28.54,"dist":8.0,"flare1z":28.54},{"flare1x":293.23,"x":286.04,"y":-883.35,"z":27.42,"flare2y":-880.83,"flare1y":-885.71,"start":false,"flare2x":277.99,"flare2z":28.65,"dist":8.0,"flare1z":28.29},{"flare1x":270.56,"x":267.92,"y":-848.07,"z":27.57,"flare2y":-855.98,"flare1y":-840.99,"start":false,"flare2x":264.97,"flare2z":28.61,"dist":8.0,"flare1z":28.6},{"flare1x":202.77,"x":199.94,"y":-821.68,"z":29.24,"flare2y":-829.5,"flare1y":-814.66,"start":false,"flare2x":196.77,"flare2z":30.27,"dist":8.0,"flare1z":30.27},{"flare1x":151.5,"x":158.41,"y":-836.98,"z":29.38,"flare2y":-840.42,"flare1y":-833.92,"start":false,"flare2x":166.12,"flare2z":30.5,"dist":8.0,"flare1z":30.35},{"flare1x":134.19,"x":141.22,"y":-880.83,"z":28.76,"flare2y":-883.7,"flare1y":-878.06,"start":false,"flare2x":149.15,"flare2z":29.99,"dist":8.0,"flare1z":29.62},{"flare1x":118.53,"x":125.6,"y":-925.94,"z":28.2,"flare2y":-928.69,"flare1y":-923.26,"start":false,"flare2x":133.58,"flare2z":29.17,"dist":8.0,"flare1z":29.3},{"flare1x":100.3,"x":107.78,"y":-991.55,"z":27.64,"flare2y":-990.35,"flare1y":-992.63,"start":false,"flare2x":116.13,"flare2z":28.73,"dist":8.0,"flare1z":28.63}]', 'Legion Square', 'Kevin White', '610', NULL, NULL, 'nil', 23432, NULL, NULL, 'This is only a test', NULL),
	(9, '[{"start":true,"flare2z":28.22,"flare2y":-995.99,"flare2x":160.69,"z":27.65,"flare1z":28.97,"dist":15.0,"y":-1002.56,"x":146.74,"flare1y":-1008.85,"flare1x":133.59},{"start":false,"flare2z":28.86,"flare2y":-1013.7,"flare2x":184.51,"z":27.69,"flare1z":28.44,"dist":15.0,"y":-1027.8,"x":178.21,"flare1y":-1040.94,"flare1x":171.94},{"start":false,"flare2z":29.21,"flare2y":-1010.39,"flare2x":215.53,"z":27.68,"flare1z":28.09,"dist":15.0,"y":-1021.57,"x":226.16,"flare1y":-1032.38,"flare1x":235.9},{"start":false,"flare2z":28.74,"flare2y":-971.63,"flare2x":234.19,"z":27.72,"flare1z":28.6,"dist":15.0,"y":-975.87,"x":249.03,"flare1y":-980.34,"flare1x":262.9}]', 'Kevin test', 'Kevin White', '246', NULL, NULL, NULL, NULL, NULL, NULL, 'teasdasdasd', NULL);
/*!40000 ALTER TABLE `racing_tracks` ENABLE KEYS */;

-- Dumping structure for table aspect.shared_vehicles
CREATE TABLE IF NOT EXISTS `shared_vehicles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job` varchar(50) DEFAULT NULL,
  `current_garage` varchar(50) DEFAULT 'C',
  `model` varchar(50) DEFAULT NULL,
  `vehicle_state` longtext DEFAULT 'Out',
  `fuel` int(11) DEFAULT 100,
  `name` varchar(50) DEFAULT NULL,
  `engine_damage` bigint(19) unsigned DEFAULT 1000,
  `body_damage` bigint(20) DEFAULT 1000,
  `degredation` longtext DEFAULT '100,100,100,100,100,100,100,100',
  `data` longtext DEFAULT NULL,
  `license_plate` varchar(255) NOT NULL DEFAULT '',
  `wheelfitment` longtext DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table aspect.shared_vehicles: ~26 rows (approximately)
/*!40000 ALTER TABLE `shared_vehicles` DISABLE KEYS */;
INSERT INTO `shared_vehicles` (`id`, `job`, `current_garage`, `model`, `vehicle_state`, `fuel`, `name`, `engine_damage`, `body_damage`, `degredation`, `data`, `license_plate`, `wheelfitment`) VALUES
	(1, 'state', 'Police Department', 'npolvic', 'In', 91, 'SASP Victoria 1', 1000, 1000, '90,94,92,95,95,98,95,96', '{"modTrunk":2,"plateIndex":4,"modArchCover":2,"modAirFilter":-1,"modRightFender":1,"neonEnabled":[false,false,false,false],"modInteriorColour":111,"modAerials":2,"modXenonColour":255,"modSideSkirt":-1,"neonColor":[255,0,255],"modArmor":-1,"plate":"SASP0001","wheelColor":0,"modRoof":-1,"dirtLevel":0.0,"modStruts":-1,"modoldLivery":-1,"modSmokeEnabled":1,"modEngineBlock":-1,"modEngine":2,"modHorns":-1,"pearlescentColor":0,"modLivery":4,"modShifterLeavers":-1,"modSpoilers":-1,"modFender":0,"modBrakes":2,"modAPlate":-1,"modXenon":1,"color2":0,"modFrame":1,"modTransmission":2,"modVanityPlate":-1,"tyreSmokeColor":[255,255,255],"modSpeakers":-1,"modRearBumper":-1,"modTank":6,"model":"NPOLVIC","modSuspension":-1,"modTrimB":0,"modPlateHolder":-1,"modGrille":-1,"extras":{"4":true,"5":true,"6":true,"7":true,"1":true,"2":true,"3":true},"bodyHealth":1000.0,"modDial":0,"modExhaust":-1,"windowTint":1,"modHydrolic":-1,"color1":0,"modDoorSpeaker":-1,"modFrontWheels":-1,"modSeats":0,"modWindows":-1,"wheels":1,"modDashboard":0,"modBackWheels":-1,"modTurbo":1,"modHood":-1,"modTrimA":-1,"modOrnaments":0,"engineHealth":1000.0,"modFrontBumper":2,"modSteeringWheel":-1,"fuelLevel":65.0,"modDashboardColour":111}', 'SASP0001', NULL),
	(2, 'state', 'Police Department', 'npolvic', 'In', 56, 'SASP Victoria 2', 1000, 902, '82,88,84,89,84,86,93,81', '{"modOrnaments":0,"modHood":-1,"modoldLivery":-1,"modEngineBlock":-1,"modDashboardColour":111,"modEngine":2,"modDial":0,"model":"NPOLVIC","modHydrolic":-1,"modTrimA":-1,"modSuspension":-1,"modTurbo":1,"extras":{"5":true,"4":true,"3":false,"2":true,"1":false,"7":true,"6":true},"dirtLevel":0.0,"modSeats":0,"color1":0,"engineHealth":1000.0,"modArmor":-1,"plate":"SASP0002","tyreSmokeColor":[255,255,255],"modSpeakers":-1,"bodyHealth":1000.0,"modRearBumper":-1,"modHorns":-1,"modLivery":-1,"modDoorSpeaker":-1,"wheels":1,"modRoof":-1,"modFrontBumper":0,"modAirFilter":-1,"modTrimB":-1,"modSpoilers":-1,"modDashboard":0,"modStruts":-1,"windowTint":1,"modTrunk":2,"modTank":-1,"modFender":-1,"modVanityPlate":-1,"modXenon":1,"modExhaust":-1,"modTransmission":2,"modRightFender":-1,"neonEnabled":[false,false,false,false],"modInteriorColour":111,"modBackWheels":-1,"modArchCover":-1,"modBrakes":2,"modXenonColour":255,"color2":0,"neonColor":[255,0,255],"modPlateHolder":-1,"modAPlate":-1,"modGrille":-1,"modFrontWheels":-1,"modShifterLeavers":-1,"modFrame":1,"pearlescentColor":0,"modSteeringWheel":-1,"modAerials":2,"fuelLevel":65.0,"modWindows":-1,"wheelColor":0,"modSmokeEnabled":1,"plateIndex":4,"modSideSkirt":-1}', 'SASP0002', NULL),
	(3, 'state', 'Police Department', 'npolvic', 'In', 74, 'SASP Victoria 3', 1000, 1000, '100,100,100,100,100,100,100,100', '{"neonEnabled":[false,false,false,false],"modHood":-1,"modoldLivery":-1,"modEngineBlock":-1,"modDashboardColour":111,"modEngine":2,"modDial":0,"model":"NPOLVIC","modHydrolic":-1,"modTrimA":-1,"modSuspension":-1,"modGrille":-1,"extras":{"5":true,"4":true,"3":true,"2":true,"1":false,"7":true,"6":true},"dirtLevel":2.3,"modSeats":0,"color1":0,"engineHealth":1000.0,"modArmor":-1,"plate":"SASP0003","modWindows":-1,"modSpeakers":-1,"bodyHealth":1000.0,"windowTint":1,"modHorns":-1,"modLivery":4,"modDoorSpeaker":-1,"modAPlate":-1,"modRoof":-1,"modFrontBumper":2,"modAirFilter":-1,"modTrimB":0,"modExhaust":-1,"modDashboard":0,"modStruts":-1,"modRearBumper":-1,"fuelLevel":65.0,"modFender":0,"wheels":1,"modVanityPlate":-1,"modXenon":1,"modBrakes":2,"modTransmission":2,"modRightFender":3,"modFrame":1,"modInteriorColour":111,"modBackWheels":-1,"modOrnaments":0,"color2":0,"modXenonColour":255,"modTank":2,"neonColor":[255,0,255],"modShifterLeavers":-1,"modTrunk":2,"modFrontWheels":-1,"wheelColor":0,"modSpoilers":-1,"modArchCover":2,"pearlescentColor":0,"modSteeringWheel":-1,"modAerials":2,"modTurbo":1,"modPlateHolder":-1,"tyreSmokeColor":[255,255,255],"modSmokeEnabled":1,"plateIndex":4,"modSideSkirt":-1}', 'SASP0003', NULL),
	(4, 'state', 'Police Department', 'npolchar', 'In', 0, 'SASP Charger 1', 1000, 992, '94,99,97,99,95,100,100,95', '{"wheels":0,"modExhaust":0,"windowTint":1,"plate":"SASP0004","modSuspension":2,"modAPlate":-1,"modSideSkirt":-1,"modStruts":-1,"modDashboard":0,"color1":62,"modRearBumper":-1,"modTrunk":-1,"modArchCover":2,"modRoof":-1,"modHood":-1,"pearlescentColor":0,"modSpoilers":2,"modSmokeEnabled":1,"fuelLevel":65.0,"modBackWheels":-1,"modOrnaments":0,"modArmor":-1,"modXenon":1,"modShifterLeavers":-1,"modBrakes":-1,"plateIndex":4,"modLivery":2,"engineHealth":1000.0,"modXenonColour":255,"modAerials":-1,"bodyHealth":1000.0,"modRightFender":-1,"modDoorSpeaker":-1,"modSteeringWheel":-1,"modInteriorColour":12,"neonColor":[255,0,255],"neonEnabled":[false,false,false,false],"color2":62,"modTank":5,"wheelColor":0,"modFender":-1,"modTrimA":-1,"tyreSmokeColor":[255,255,255],"modVanityPlate":-1,"modoldLivery":2,"modAirFilter":-1,"modPlateHolder":-1,"modDial":0,"modFrontWheels":7,"modTurbo":false,"modHorns":-1,"modWindows":-1,"modFrontBumper":1,"modHydrolic":-1,"extras":{"7":false,"5":true,"6":true,"3":false,"4":true,"1":false,"2":false},"modDashboardColour":111,"modSeats":-1,"modEngine":4,"modEngineBlock":-1,"modSpeakers":-1,"modFrame":-1,"modTransmission":-1,"modTrimB":0,"model":"NPOLCHAR","modGrille":-1,"dirtLevel":0.0}', 'SASP0004', ''),
	(5, 'state', 'Police Department', 'npolchar', 'In', 77, 'SASP Charger 2', 992, 888, '82,81,66,65,67,89,87,85', '{"wheels":0,"modExhaust":0,"windowTint":1,"plate":"SASP0005","modSuspension":2,"modAPlate":-1,"modSideSkirt":-1,"modEngine":4,"modDashboard":0,"color1":62,"modRearBumper":-1,"modTrunk":-1,"modArchCover":2,"modRoof":-1,"modHood":-1,"pearlescentColor":0,"modSpoilers":2,"modSmokeEnabled":1,"fuelLevel":65.0,"modBackWheels":-1,"modOrnaments":0,"modArmor":-1,"modXenon":1,"modShifterLeavers":-1,"modBrakes":-1,"plateIndex":4,"modLivery":2,"engineHealth":1000.0,"modXenonColour":255,"modAerials":-1,"bodyHealth":1000.0,"modRightFender":-1,"modDoorSpeaker":-1,"modSteeringWheel":-1,"modInteriorColour":12,"neonColor":[255,255,255],"neonEnabled":[false,false,false,false],"color2":62,"modTank":2,"wheelColor":0,"modSpeakers":-1,"modTrimA":-1,"tyreSmokeColor":[255,255,255],"modVanityPlate":-1,"modoldLivery":0,"modSeats":-1,"modPlateHolder":-1,"modDial":0,"modFrontWheels":7,"modTurbo":false,"modTrimB":0,"modFrontBumper":1,"extras":{"7":false,"5":true,"6":true,"3":false,"4":true,"1":true,"2":false},"modHydrolic":-1,"modAirFilter":-1,"modFender":-1,"modWindows":-1,"modStruts":-1,"model":"NPOLCHAR","modEngineBlock":-1,"modDashboardColour":111,"modTransmission":-1,"modFrame":-1,"modHorns":-1,"modGrille":-1,"dirtLevel":2.3}', 'SASP0005', NULL),
	(6, 'state', 'Police Department', 'npolexp', 'In', 73, 'SASP Explorer 1', 1000, 1000, '90,90,91,85,87,94,97,98', '{"modInteriorColour":12,"modSteeringWheel":-1,"bodyHealth":1000.0,"modSmokeEnabled":1,"modSuspension":2,"modStruts":-1,"modXenon":1,"modSeats":0,"color1":62,"neonEnabled":[false,false,false,false],"modFrontBumper":0,"modTrimA":-1,"modTrunk":-1,"windowTint":1,"plate":"SASP0006","modFrontWheels":-1,"fuelLevel":80.0,"modLivery":4,"modDial":0,"modBrakes":2,"modBackWheels":-1,"modXenonColour":255,"modTank":5,"modHorns":1,"modPlateHolder":0,"modDoorSpeaker":-1,"extras":{"3":true,"4":true,"1":false,"2":true,"7":true,"8":true,"5":false,"6":false},"modRoof":-1,"modRearBumper":-1,"modTurbo":1,"modArchCover":2,"wheels":0,"tyreSmokeColor":[255,255,255],"dirtLevel":0.0,"modArmor":-1,"color2":62,"model":"npolexp","modOrnaments":0,"modSpoilers":0,"modEngine":2,"plateIndex":4,"neonColor":[255,255,255],"modDashboardColour":111,"modSpeakers":-1,"modWindows":-1,"modSideSkirt":-1,"modAirFilter":-1,"modAPlate":-1,"modFrame":1,"modHood":-1,"modFender":-1,"modGrille":-1,"wheelColor":0,"modVanityPlate":-1,"modoldLivery":0,"modDashboard":0,"modHydrolic":-1,"modShifterLeavers":15,"modAerials":-1,"modTrimB":0,"modExhaust":-1,"modTransmission":2,"pearlescentColor":0,"modRightFender":-1,"modEngineBlock":-1,"engineHealth":1000.0}', 'SASP0006', NULL),
	(7, 'state', 'Police Department', 'npolexp', 'In', 86, 'SASP Explorer 2', 1000, 1000, '97,96,97,95,94,94,93,93', '{"modInteriorColour":12,"modSteeringWheel":-1,"bodyHealth":1000.0,"modSmokeEnabled":1,"modSuspension":2,"modStruts":-1,"modXenon":1,"modSeats":0,"color1":62,"neonEnabled":[false,false,false,false],"modFrontBumper":0,"modTrimA":-1,"modTrunk":-1,"windowTint":1,"plate":"SASP0007","modFrontWheels":7,"fuelLevel":80.0,"modLivery":4,"modDial":0,"modBrakes":-1,"modBackWheels":-1,"modXenonColour":255,"modTank":5,"modHorns":1,"modPlateHolder":0,"modDoorSpeaker":-1,"extras":{"3":false,"4":true,"1":false,"2":false,"7":true,"8":true,"5":true,"6":true},"modRoof":-1,"modRearBumper":-1,"modTurbo":1,"modArchCover":2,"wheels":0,"tyreSmokeColor":[255,255,255],"dirtLevel":0.0,"modArmor":-1,"color2":62,"model":"npolexp","modOrnaments":0,"modSpoilers":0,"modEngine":4,"plateIndex":4,"neonColor":[255,0,255],"modDashboardColour":111,"modSpeakers":-1,"modWindows":-1,"modSideSkirt":-1,"modAirFilter":-1,"modAPlate":-1,"modFrame":1,"modHood":-1,"modFender":-1,"modGrille":-1,"wheelColor":0,"modVanityPlate":-1,"modoldLivery":0,"modDashboard":0,"modHydrolic":-1,"modShifterLeavers":15,"modAerials":0,"modTrimB":0,"modExhaust":-1,"modTransmission":-1,"pearlescentColor":0,"modRightFender":-1,"modEngineBlock":-1,"engineHealth":1000.0}', 'SASP0007', NULL),
	(8, 'police', 'Police Department', 'npolvic', 'In', 46, 'LSPD Victoria 1', 1000, 746, '81,77,76,67,70,82,78,73', '{"wheels":1,"modExhaust":-1,"extras":{"7":true,"5":true,"6":true,"3":false,"4":true,"1":true,"2":false},"plate":"LSPD0001","modSuspension":-1,"modAPlate":-1,"modSideSkirt":-1,"modStruts":-1,"modDashboard":0,"color1":111,"modRearBumper":-1,"modTrunk":2,"modArchCover":5,"modWindows":-1,"modHood":-1,"pearlescentColor":0,"modSpoilers":-1,"modSmokeEnabled":1,"fuelLevel":65.0,"modBackWheels":-1,"modOrnaments":0,"modArmor":-1,"modXenon":1,"modShifterLeavers":-1,"modBrakes":2,"plateIndex":4,"modLivery":0,"engineHealth":1000.0,"modXenonColour":255,"modAerials":0,"bodyHealth":1000.0,"modRightFender":4,"modFrontBumper":0,"modSteeringWheel":-1,"modInteriorColour":111,"neonColor":[255,0,255],"neonEnabled":[false,false,false,false],"color2":0,"modTank":1,"wheelColor":0,"modSpeakers":-1,"modFrame":1,"tyreSmokeColor":[255,255,255],"modVanityPlate":-1,"modoldLivery":-1,"modSeats":0,"modHorns":-1,"modDial":0,"modFrontWheels":-1,"modTurbo":1,"modDoorSpeaker":-1,"windowTint":1,"modPlateHolder":-1,"modHydrolic":-1,"modEngine":2,"modRoof":-1,"modTrimB":0,"modFender":0,"modTrimA":-1,"modEngineBlock":-1,"modAirFilter":-1,"modTransmission":2,"modDashboardColour":0,"model":"NPOLVIC","modGrille":-1,"dirtLevel":0.0}', 'LSPD0001', NULL),
	(9, 'police', 'Police Department', 'npolvic', 'In', 74, 'BCSO Victoria 2', 280, 1000, '49,73,7,77,53,31,19,32', '{"modAirFilter":-1,"neonColor":[255,0,255],"modSpeakers":-1,"modWindows":-1,"color1":111,"wheels":1,"modFender":0,"modRightFender":2,"modHorns":-1,"modEngine":2,"modSmokeEnabled":1,"tyreSmokeColor":[255,255,255],"modVanityPlate":-1,"modTurbo":1,"pearlescentColor":0,"modInteriorColour":111,"engineHealth":1000.0,"modArchCover":1,"modAerials":0,"modAPlate":-1,"modTank":4,"modExhaust":-1,"modStruts":-1,"modHydrolic":-1,"modoldLivery":-1,"modTrimB":1,"modSteeringWheel":-1,"modOrnaments":0,"modXenonColour":255,"modArmor":-1,"modSpoilers":-1,"modRoof":-1,"modLivery":0,"modTrunk":2,"model":"NPOLVIC","modGrille":-1,"neonEnabled":[false,false,false,false],"modFrame":1,"modSeats":0,"modShifterLeavers":-1,"plateIndex":4,"modBrakes":2,"modEngineBlock":-1,"modPlateHolder":-1,"windowTint":1,"fuelLevel":65.0,"modTransmission":2,"modDashboardColour":0,"modFrontBumper":0,"extras":{"7":true,"2":true,"1":true,"4":true,"3":true,"6":true,"5":true},"modFrontWheels":-1,"modSideSkirt":-1,"modXenon":1,"modDashboard":0,"modRearBumper":-1,"bodyHealth":1000.0,"wheelColor":0,"modDial":0,"modDoorSpeaker":-1,"plate":"BCSO0002","color2":0,"modTrimA":-1,"modBackWheels":-1,"modHood":-1,"dirtLevel":0.0,"modSuspension":-1}', 'BCSO0002', NULL),
	(10, 'police', 'Police Department', 'npolvic', 'In', 100, 'LSPD Victoria 3', 982, 728, '72,88,79,70,72,72,68,49', '{"modAirFilter":-1,"modDashboard":0,"modHood":-1,"modFrontBumper":0,"modDial":0,"modArchCover":1,"modEngine":2,"plate":"LSPD0003","extras":{"4":true,"3":true,"2":true,"1":true,"7":true,"6":true,"5":true},"modDashboardColour":0,"modDoorSpeaker":-1,"modSteeringWheel":-1,"modBackWheels":-1,"modSpeakers":-1,"modAPlate":-1,"modLivery":0,"modTrimA":-1,"modPlateHolder":-1,"modFrame":1,"modInteriorColour":111,"modTransmission":2,"modArmor":-1,"modWindows":-1,"neonEnabled":[false,false,false,false],"modTrimB":6,"modXenon":1,"wheels":1,"modXenonColour":255,"neonColor":[255,0,255],"modEngineBlock":-1,"modSeats":0,"modOrnaments":0,"pearlescentColor":0,"modShifterLeavers":-1,"modBrakes":2,"modHorns":-1,"modSuspension":-1,"modTank":0,"modSpoilers":-1,"model":"NPOLVIC","dirtLevel":0.0,"fuelLevel":65.0,"modExhaust":-1,"modSmokeEnabled":1,"wheelColor":0,"tyreSmokeColor":[255,255,255],"color1":111,"modRoof":-1,"modHydrolic":-1,"modStruts":-1,"plateIndex":4,"modoldLivery":-1,"modRearBumper":-1,"modFender":0,"modAerials":0,"windowTint":1,"engineHealth":1000.0,"modFrontWheels":-1,"modSideSkirt":-1,"bodyHealth":1000.0,"modVanityPlate":-1,"modGrille":-1,"color2":0,"modRightFender":3,"modTrunk":2,"modTurbo":1}', 'LSPD0003', NULL),
	(11, 'police', 'Police Department', 'npolvic', 'In', 0, 'LSPD Victoria 4', 77, 0, '62,81,56,64,60,74,52,64', '{"modTrunk":2,"plateIndex":4,"modArchCover":1,"modAirFilter":-1,"modRightFender":4,"neonEnabled":[false,false,false,false],"modInteriorColour":111,"modAerials":0,"modXenonColour":255,"modTurbo":1,"neonColor":[255,255,255],"modArmor":-1,"plate":"LSPD0004","wheelColor":0,"modDial":0,"dirtLevel":0.0,"modStruts":-1,"modoldLivery":-1,"modHydrolic":-1,"modEngineBlock":-1,"modEngine":2,"modHorns":-1,"pearlescentColor":0,"modLivery":0,"modShifterLeavers":-1,"modSpoilers":-1,"modFender":0,"modBrakes":2,"modAPlate":-1,"modXenon":1,"modFrontWheels":-1,"modGrille":-1,"modSeats":0,"modVanityPlate":-1,"tyreSmokeColor":[255,255,255],"modSpeakers":-1,"modRearBumper":-1,"modTank":0,"model":"NPOLVIC","modSuspension":-1,"modDashboard":0,"modPlateHolder":-1,"modFrame":1,"modSideSkirt":-1,"bodyHealth":1000.0,"modTrimB":6,"modExhaust":-1,"windowTint":1,"extras":{"4":true,"5":true,"6":true,"7":true,"1":true,"2":true,"3":true},"color1":111,"modDoorSpeaker":-1,"modTransmission":2,"color2":0,"modWindows":-1,"modFrontBumper":0,"wheels":1,"modBackWheels":-1,"modSteeringWheel":-1,"modSmokeEnabled":1,"modTrimA":-1,"modOrnaments":0,"engineHealth":1000.0,"modHood":-1,"modDashboardColour":0,"fuelLevel":65.0,"modRoof":-1}', 'LSPD0004', NULL),
	(12, 'police', 'Police Department', 'npolvic', 'In', 79, 'LSPD Victoria 5', 1000, 1000, '100,100,100,100,100,100,100,100', '{"modDial":0,"modArchCover":1,"modXenonColour":255,"modTrimB":0,"modWindows":-1,"modArmor":-1,"plate":"LSPD0005","modSideSkirt":-1,"model":"NPOLVIC","modSmokeEnabled":1,"modRightFender":9,"modShifterLeavers":-1,"modHydrolic":-1,"modHorns":-1,"modFender":0,"modTrimA":-1,"modRearBumper":-1,"wheelColor":0,"modPlateHolder":-1,"modFrame":1,"windowTint":1,"modSpoilers":-1,"modBackWheels":-1,"pearlescentColor":0,"wheels":1,"modFrontBumper":0,"modOrnaments":0,"modEngine":2,"modInteriorColour":111,"modRoof":-1,"modAirFilter":-1,"modTank":1,"modHood":-1,"modAerials":0,"modLivery":11,"modSuspension":-1,"modXenon":1,"modDashboardColour":0,"modExhaust":-1,"neonEnabled":[false,false,false,false],"tyreSmokeColor":[255,255,255],"modDashboard":0,"engineHealth":1000.0,"bodyHealth":1000.0,"modoldLivery":-1,"fuelLevel":65.0,"modSeats":0,"modTransmission":2,"modTurbo":1,"color1":0,"modBrakes":2,"modEngineBlock":-1,"neonColor":[255,0,255],"modSpeakers":-1,"modVanityPlate":-1,"modSteeringWheel":-1,"color2":0,"modTrunk":2,"dirtLevel":0.0,"modGrille":-1,"extras":{"4":true,"3":true,"6":true,"5":true,"7":true,"2":true,"1":false},"modAPlate":-1,"modStruts":-1,"plateIndex":4,"modDoorSpeaker":-1,"modFrontWheels":-1}', 'LSPD0005', NULL),
	(13, 'police', 'Police Department', 'npolvic', 'In', 88, 'LSPD Victoria 6', 1000, 1000, '85,95,88,88,89,89,86,93', '{"fuelLevel":65.0,"pearlescentColor":0,"modFrontWheels":-1,"modDashboard":0,"modXenon":1,"modSmokeEnabled":1,"modBackWheels":-1,"modSuspension":-1,"modFender":0,"neonEnabled":[false,false,false,false],"modTank":0,"modOrnaments":0,"neonColor":[255,0,255],"modLivery":0,"modAPlate":-1,"engineHealth":1000.0,"modSpeakers":-1,"modArchCover":1,"modHood":-1,"model":"NPOLVIC","bodyHealth":960.9,"modAirFilter":-1,"modSteeringWheel":-1,"plateIndex":4,"modTrimB":6,"modFrontBumper":0,"modDial":0,"extras":{"5":true,"4":true,"7":true,"6":true,"1":true,"3":true,"2":true},"modDoorSpeaker":-1,"modPlateHolder":-1,"modExhaust":-1,"modDashboardColour":0,"modoldLivery":-1,"modEngineBlock":-1,"modSideSkirt":-1,"modHorns":-1,"modShifterLeavers":-1,"modBrakes":2,"modSpoilers":-1,"wheels":1,"modRearBumper":-1,"color2":0,"color1":111,"modArmor":-1,"modStruts":-1,"modTrunk":2,"modInteriorColour":111,"modWindows":-1,"modAerials":0,"modRoof":-1,"modRightFender":6,"windowTint":1,"modVanityPlate":-1,"modFrame":1,"modXenonColour":255,"modSeats":0,"modTrimA":-1,"modGrille":-1,"wheelColor":0,"plate":"LSPD0006","modTurbo":1,"modTransmission":2,"modHydrolic":-1,"tyreSmokeColor":[255,255,255],"dirtLevel":0.6,"modEngine":2}', 'LSPD0006', NULL),
	(14, 'police', 'Police Department', 'npolchar', 'In', 60, 'LSPD Charger 1', 1000, 1000, '78,89,83,85,84,86,74,81', '{"modSpoilers":2,"engineHealth":1000.0,"wheels":0,"windowTint":1,"fuelLevel":65.0,"modVanityPlate":-1,"modFrontWheels":22,"modTurbo":false,"modSideSkirt":-1,"modRightFender":-1,"modHydrolic":-1,"modInteriorColour":111,"modAPlate":-1,"neonEnabled":[false,false,false,false],"modDashboardColour":112,"modRearBumper":-1,"wheelColor":0,"modPlateHolder":-1,"modEngineBlock":-1,"modSuspension":2,"modWindows":-1,"modBrakes":-1,"color2":0,"modDoorSpeaker":-1,"modHorns":1,"modTrunk":-1,"modXenonColour":255,"modoldLivery":-1,"bodyHealth":1000.0,"pearlescentColor":0,"modDashboard":0,"modSeats":-1,"modLivery":0,"modTank":4,"modBackWheels":-1,"modEngine":4,"modExhaust":0,"modAirFilter":-1,"modGrille":-1,"modOrnaments":0,"modSmokeEnabled":1,"modFrame":-1,"color1":0,"modTransmission":-1,"neonColor":[255,0,255],"modStruts":-1,"dirtLevel":0.0,"modHood":-1,"modRoof":1,"modArmor":-1,"modAerials":-1,"modFrontBumper":1,"modFender":-1,"tyreSmokeColor":[255,255,255],"modDial":0,"modTrimB":0,"model":"NPOLCHAR","modSpeakers":-1,"extras":{"7":true,"6":true,"1":false,"3":false,"2":false,"5":true,"4":true},"plate":"LSPD0007","modSteeringWheel":-1,"plateIndex":4,"modArchCover":1,"modShifterLeavers":-1,"modTrimA":-1,"modXenon":1}', 'LSPD0007', NULL),
	(15, 'police', 'Police Department', 'npolchar', 'In', 50, 'LSPD Charger 2', 1000, 1000, '51,38,30,57,37,33,8,52', '{"modFender":-1,"modRoof":-1,"engineHealth":1000.0,"modTank":2,"pearlescentColor":0,"modArchCover":1,"modShifterLeavers":-1,"modDashboard":0,"modArmor":-1,"modRearBumper":-1,"modAirFilter":-1,"tyreSmokeColor":[255,255,255],"modBrakes":-1,"modVanityPlate":-1,"windowTint":1,"extras":{"3":false,"2":false,"1":false,"7":true,"6":true,"5":true,"4":true},"color2":0,"neonEnabled":[false,false,false,false],"modSuspension":2,"modGrille":-1,"modLivery":0,"color1":132,"modSeats":-1,"modEngine":4,"dirtLevel":0.0,"modXenon":1,"bodyHealth":1000.0,"modPlateHolder":-1,"modTrunk":-1,"modTurbo":false,"modTransmission":-1,"modFrontWheels":38,"modAerials":-1,"modoldLivery":-1,"modWindows":-1,"fuelLevel":65.0,"modSpeakers":-1,"modTrimA":-1,"plate":"LSPD0008","modTrimB":0,"modSpoilers":2,"wheels":7,"modExhaust":0,"modDial":0,"modBackWheels":-1,"modDoorSpeaker":-1,"model":"NPOLCHAR","wheelColor":0,"modInteriorColour":111,"modEngineBlock":-1,"modHydrolic":-1,"modSideSkirt":-1,"modHood":-1,"modRightFender":-1,"plateIndex":4,"modDashboardColour":147,"modStruts":-1,"modSteeringWheel":-1,"modXenonColour":255,"modFrame":-1,"modAPlate":-1,"modOrnaments":0,"neonColor":[255,0,255],"modSmokeEnabled":1,"modFrontBumper":1,"modHorns":-1}', 'LSPD0008', NULL),
	(16, 'police', 'Police Department', 'npolexp', 'In', 78, 'LSPD Explorer 1', 1000, 1000, '62,47,65,68,63,65,56,61', '{"modSpoilers":1,"engineHealth":1000.0,"wheels":0,"windowTint":1,"fuelLevel":80.0,"modVanityPlate":-1,"modFrontWheels":50,"modTurbo":false,"modSideSkirt":-1,"modRightFender":-1,"modHydrolic":-1,"extras":{"7":true,"6":false,"1":false,"8":false,"3":true,"2":true,"5":true,"4":true},"modAPlate":-1,"modFender":-1,"plate":"LSPD0009","modRearBumper":-1,"wheelColor":0,"modPlateHolder":0,"modEngineBlock":-1,"modSteeringWheel":-1,"modArchCover":1,"modBrakes":-1,"color2":12,"modDoorSpeaker":-1,"modHorns":-1,"neonColor":[255,0,255],"modXenonColour":255,"modoldLivery":-1,"bodyHealth":1000.0,"pearlescentColor":0,"modDashboard":0,"modSeats":-1,"modDial":0,"color1":12,"modBackWheels":-1,"modEngine":4,"modExhaust":-1,"modAirFilter":-1,"modGrille":-1,"modOrnaments":0,"modSmokeEnabled":1,"modFrame":-1,"modStruts":-1,"modTrunk":-1,"modSuspension":2,"modTrimA":-1,"dirtLevel":0.0,"modShifterLeavers":5,"modRoof":-1,"neonEnabled":[false,false,false,false],"modAerials":-1,"modTransmission":-1,"tyreSmokeColor":[255,255,255],"modLivery":9,"modTrimB":0,"modTank":4,"modFrontBumper":0,"modSpeakers":-1,"modDashboardColour":147,"modInteriorColour":111,"modHood":-1,"model":"npolexp","modArmor":-1,"modWindows":-1,"plateIndex":4,"modXenon":1}', 'LSPD0009', NULL),
	(17, 'police', 'Police Department', 'npolexp', 'In', 81, 'LSPD Explorer 2', 1000, 1000, '24,46,24,60,31,25,22,41', '{"modAirFilter":-1,"bodyHealth":1000.0,"modHood":-1,"modFrontBumper":0,"modDial":0,"modArchCover":1,"modEngine":4,"plate":"LSPD0010","extras":{"4":true,"3":false,"2":false,"1":false,"8":false,"7":true,"6":true,"5":true},"modDashboardColour":147,"modDoorSpeaker":-1,"modSteeringWheel":-1,"modBackWheels":-1,"modSpeakers":-1,"modAPlate":-1,"modLivery":0,"modHydrolic":-1,"modAerials":-1,"modFrame":-1,"modInteriorColour":111,"modTransmission":-1,"modArmor":-1,"modTurbo":false,"neonEnabled":[false,false,false,false],"wheelColor":0,"modXenon":1,"wheels":0,"modXenonColour":255,"neonColor":[255,0,255],"modFender":-1,"modSeats":-1,"modOrnaments":0,"pearlescentColor":0,"modRearBumper":-1,"modBrakes":0,"modHorns":-1,"modSuspension":2,"modTank":2,"modSpoilers":-1,"model":"npolexp","dirtLevel":0.0,"fuelLevel":80.0,"modExhaust":-1,"modSmokeEnabled":1,"modEngineBlock":-1,"tyreSmokeColor":[255,255,255],"modTrimB":0,"modRoof":-1,"modDashboard":0,"modStruts":-1,"plateIndex":4,"modoldLivery":-1,"modShifterLeavers":-1,"engineHealth":1000.0,"modPlateHolder":-1,"windowTint":1,"color1":132,"modFrontWheels":50,"modSideSkirt":-1,"modWindows":-1,"modVanityPlate":-1,"color2":0,"modTrimA":-1,"modRightFender":-1,"modTrunk":-1,"modGrille":-1}', 'LSPD0010', NULL),
	(18, 'ems', 'Police Department', 'emsnspeedo', 'In', 65, 'EMS Van 1', 1000, 1000, '68,84,81,73,61,71,83,77', '{"modDial":-1,"modXenon":1,"modArmor":-1,"modEngine":2,"modVanityPlate":-1,"modHydrolic":-1,"modTurbo":1,"modDashboard":-1,"model":"emsnspeedo","modHorns":-1,"modAPlate":-1,"modOrnaments":-1,"modRearBumper":-1,"modBrakes":2,"tyreSmokeColor":[255,255,255],"modShifterLeavers":-1,"wheelColor":0,"pearlescentColor":0,"modSeats":-1,"modStruts":-1,"modSideSkirt":-1,"color2":131,"modAirFilter":-1,"color1":112,"modTransmission":2,"modHood":-1,"modGrille":-1,"modBackWheels":-1,"windowTint":1,"modoldLivery":0,"wheels":1,"extras":{"2":true,"10":true},"modFrontWheels":-1,"modWindows":-1,"modInteriorColour":12,"dirtLevel":0.0,"modPlateHolder":-1,"modSpoilers":-1,"modRightFender":-1,"modDashboardColour":12,"modRoof":-1,"modSpeakers":-1,"modAerials":-1,"neonColor":[255,0,255],"engineHealth":1000.0,"modExhaust":-1,"modSuspension":-1,"modDoorSpeaker":-1,"plateIndex":4,"neonEnabled":[false,false,false,false],"modTank":-1,"modFrame":-1,"modSmokeEnabled":1,"modSteeringWheel":-1,"modTrimB":-1,"modArchCover":-1,"modFender":-1,"modTrimA":-1,"plate":"EMS00001","bodyHealth":1000.0,"modXenonColour":255,"modLivery":0,"modEngineBlock":-1,"fuelLevel":65.0,"modTrunk":-1,"modFrontBumper":-1}', 'EMS00001', NULL),
	(19, 'ems', 'Pillbox', 'emsnspeedo', 'In', 66, 'EMS Van 2', 999, 922, '84,95,96,95,89,92,96,92', '{"modFender":-1,"modRoof":-1,"engineHealth":1000.0,"modTank":-1,"pearlescentColor":0,"modArchCover":-1,"modShifterLeavers":-1,"modDashboard":-1,"modArmor":-1,"modRearBumper":-1,"modAirFilter":-1,"tyreSmokeColor":[255,255,255],"modBrakes":2,"modDoorSpeaker":-1,"windowTint":1,"extras":{"2":true,"10":true},"color2":131,"neonEnabled":[false,false,false,false],"modSmokeEnabled":1,"modGrille":-1,"modLivery":0,"color1":111,"modSeats":-1,"modEngine":2,"dirtLevel":0.0,"modXenon":1,"bodyHealth":1000.0,"modPlateHolder":-1,"modTrunk":-1,"modDashboardColour":12,"modTransmission":2,"modInteriorColour":12,"modAerials":-1,"modFrontBumper":-1,"modWindows":-1,"fuelLevel":65.0,"modSpeakers":-1,"modTrimA":-1,"plate":"EMS00002","modTrimB":-1,"modSpoilers":-1,"wheels":1,"modAPlate":-1,"wheelColor":0,"modBackWheels":-1,"model":"emsnspeedo","modSteeringWheel":-1,"modoldLivery":0,"modStruts":-1,"modEngineBlock":-1,"modHydrolic":-1,"modSideSkirt":-1,"modHood":-1,"modRightFender":-1,"plateIndex":4,"modTurbo":1,"neonColor":[255,0,255],"modFrontWheels":-1,"modXenonColour":255,"modFrame":-1,"modDial":-1,"modVanityPlate":-1,"modSuspension":-1,"modOrnaments":-1,"modExhaust":-1,"modHorns":-1}', 'EMS00002', NULL),
	(20, 'ems', 'Pillbox', 'emsnspeedo', 'In', 96, 'EMS Van 3', 1000, 991, '79,71,67,31,61,62,75,75', '{"bodyHealth":1000.0,"modSpeakers":-1,"neonColor":[255,0,255],"pearlescentColor":0,"modHydrolic":-1,"engineHealth":1000.0,"wheels":1,"fuelLevel":65.0,"modDashboard":-1,"color1":27,"plate":"EMS00003","modTurbo":1,"tyreSmokeColor":[255,255,255],"modSuspension":-1,"modAirFilter":-1,"modArmor":-1,"modStruts":-1,"wheelColor":0,"modDashboardColour":12,"color2":131,"modHood":-1,"modAPlate":-1,"modBrakes":2,"extras":{"2":true,"10":true},"plateIndex":4,"modFrontBumper":-1,"dirtLevel":0.0,"modTank":-1,"modRightFender":-1,"modFrame":-1,"modVanityPlate":-1,"modFrontWheels":-1,"modOrnaments":-1,"modInteriorColour":12,"modDoorSpeaker":-1,"modFender":-1,"modTransmission":2,"modXenon":1,"modSpoilers":-1,"modHorns":-1,"modExhaust":-1,"neonEnabled":[false,false,false,false],"modTrimA":-1,"modTrunk":-1,"modSmokeEnabled":1,"modArchCover":-1,"modGrille":-1,"model":"emsnspeedo","modSideSkirt":-1,"modTrimB":-1,"modRearBumper":-1,"modPlateHolder":-1,"modWindows":-1,"modoldLivery":0,"modAerials":-1,"modRoof":-1,"modLivery":-1,"modDial":-1,"windowTint":1,"modXenonColour":255,"modShifterLeavers":-1,"modEngine":2,"modSeats":-1,"modEngineBlock":-1,"modBackWheels":-1,"modSteeringWheel":-1}', 'EMS00003', NULL),
	(21, 'ems', 'Pillbox', 'emsnspeedo', 'In', 95, 'EMS Van 4', 1000, 1000, '100,100,100,100,100,100,100,100', '{"bodyHealth":1000.0,"modSpeakers":-1,"neonColor":[255,0,255],"pearlescentColor":0,"modHydrolic":-1,"engineHealth":1000.0,"wheels":1,"fuelLevel":65.0,"modDashboard":-1,"color1":27,"plate":"EMS00004","modTurbo":1,"tyreSmokeColor":[255,255,255],"modSuspension":-1,"modAirFilter":-1,"modArmor":-1,"modStruts":-1,"wheelColor":0,"modDashboardColour":12,"color2":131,"modHood":-1,"modAPlate":-1,"modBrakes":2,"extras":{"2":true,"10":true},"plateIndex":4,"modFrontBumper":-1,"dirtLevel":0.0,"modTank":-1,"modRightFender":-1,"modFrame":-1,"modVanityPlate":-1,"modFrontWheels":-1,"modOrnaments":-1,"modInteriorColour":12,"modDoorSpeaker":-1,"modFender":-1,"modTransmission":2,"modXenon":1,"modSpoilers":-1,"modHorns":-1,"modExhaust":-1,"neonEnabled":[false,false,false,false],"modTrimA":-1,"modTrunk":-1,"modSmokeEnabled":1,"modArchCover":-1,"modGrille":-1,"model":"emsnspeedo","modSideSkirt":-1,"modTrimB":-1,"modRearBumper":-1,"modPlateHolder":-1,"modWindows":-1,"modoldLivery":0,"modAerials":-1,"modRoof":-1,"modLivery":-1,"modDial":-1,"windowTint":1,"modXenonColour":255,"modShifterLeavers":-1,"modEngine":2,"modSeats":-1,"modEngineBlock":-1,"modBackWheels":-1,"modSteeringWheel":-1}', 'EMS00004', NULL),
	(22, 'sheriff', 'Police Department', 'npolvic', 'In', 100, 'Sheriff Victoria 2', 1000, 1000, '85,71,40,70,83,78,80,76', '{"modSmokeEnabled":1,"modAirFilter":-1,"model":"NPOLVIC","modSpoilers":-1,"modTurbo":1,"modLivery":2,"modExhaust":-1,"modArchCover":3,"plate":"BCSO0005","modHood":-1,"modAPlate":-1,"modFrontWheels":-1,"modDashboard":0,"modSuspension":-1,"wheelColor":0,"pearlescentColor":0,"tyreSmokeColor":[255,255,255],"modPlateHolder":-1,"modSeats":0,"modEngine":2,"modHydrolic":-1,"modTrimA":-1,"modFender":0,"modSteeringWheel":-1,"wheels":1,"modRoof":-1,"modSpeakers":-1,"color1":111,"modFrontBumper":0,"modBrakes":2,"modoldLivery":-1,"dirtLevel":0.0,"modSideSkirt":-1,"modStruts":-1,"engineHealth":1000.0,"modArmor":-1,"neonColor":[255,0,255],"modTrunk":2,"modGrille":-1,"modXenon":1,"modBackWheels":-1,"modOrnaments":0,"modShifterLeavers":-1,"modDial":0,"color2":0,"plateIndex":4,"extras":{"7":true,"6":true,"5":true,"4":true,"3":true,"2":true,"1":true},"fuelLevel":65.0,"modRightFender":2,"modTransmission":2,"windowTint":1,"modFrame":1,"modTrimB":6,"modDoorSpeaker":-1,"modEngineBlock":-1,"neonEnabled":[false,false,false,false],"modDashboardColour":0,"modTank":3,"modRearBumper":-1,"modWindows":-1,"bodyHealth":1000.0,"modInteriorColour":111,"modHorns":-1,"modVanityPlate":-1,"modXenonColour":255,"modAerials":0}', 'BCSO0005', NULL),
	(23, 'sheriff', 'Police Department', 'npolvic', 'In', 86, 'Sheriff Victoria 1', 1000, 1000, '62,58,60,76,67,50,40,65', '{"modSpoilers":-1,"neonEnabled":[false,false,false,false],"modSmokeEnabled":1,"modWindows":-1,"modFender":0,"windowTint":1,"modEngine":2,"dirtLevel":0.0,"modSideSkirt":-1,"modOrnaments":0,"color1":111,"modLivery":2,"modTrimB":3,"modRearBumper":-1,"modDashboardColour":0,"model":"NPOLVIC","modArmor":-1,"modStruts":-1,"pearlescentColor":0,"modSpeakers":-1,"modExhaust":-1,"modXenon":1,"fuelLevel":65.0,"tyreSmokeColor":[255,255,255],"modPlateHolder":-1,"modAerials":0,"modTrimA":-1,"plate":"BCSO0001","modSeats":0,"extras":{"7":true,"6":true,"1":true,"3":true,"2":true,"5":true,"4":true},"color2":0,"modDoorSpeaker":-1,"modRoof":-1,"modAirFilter":-1,"bodyHealth":1000.0,"modDashboard":0,"modShifterLeavers":-1,"modArchCover":3,"modFrontBumper":0,"modInteriorColour":111,"modBackWheels":-1,"modGrille":-1,"modRightFender":2,"modVanityPlate":-1,"modDial":0,"engineHealth":1000.0,"modFrame":1,"modHydrolic":-1,"modoldLivery":-1,"modHorns":-1,"modEngineBlock":-1,"modHood":-1,"modSteeringWheel":-1,"neonColor":[255,0,255],"modTurbo":1,"modTank":2,"modSuspension":-1,"modTrunk":2,"modBrakes":2,"modAPlate":-1,"modXenonColour":255,"modFrontWheels":-1,"wheelColor":0,"modTransmission":2,"plateIndex":4,"wheels":1}', 'BCSO0001', NULL),
	(24, 'sheriff', 'Police Department', 'npolexp', 'In', 80, 'Sheriff Explorer 1', 1000, 810, '92,98,93,94,84,95,92,92', '{"modAerials":-1,"modoldLivery":-1,"modFrame":1,"wheelColor":0,"modRightFender":-1,"modFrontWheels":50,"modXenon":1,"modSuspension":2,"modHydrolic":-1,"modRoof":-1,"bodyHealth":1000.0,"neonColor":[255,0,255],"modExhaust":-1,"modTrunk":-1,"modArchCover":3,"modSideSkirt":-1,"modSmokeEnabled":1,"modGrille":-1,"modSteeringWheel":-1,"dirtLevel":0.0,"modDial":0,"plate":"BCSO0003","modHood":-1,"pearlescentColor":0,"modTank":1,"modFender":-1,"modBrakes":0,"modFrontBumper":0,"color1":131,"wheels":0,"modHorns":-1,"modLivery":2,"modInteriorColour":111,"engineHealth":1000.0,"modRearBumper":-1,"extras":{"8":true,"1":true,"2":true,"3":true,"4":true,"5":true,"6":true,"7":true},"model":"npolexp","modArmor":-1,"modBackWheels":-1,"modWindows":-1,"modAirFilter":-1,"modEngineBlock":-1,"tyreSmokeColor":[255,255,255],"modDoorSpeaker":-1,"modTrimB":2,"modTurbo":false,"modOrnaments":0,"modStruts":-1,"fuelLevel":80.0,"modSpoilers":-1,"plateIndex":4,"modSpeakers":-1,"modVanityPlate":-1,"modTransmission":-1,"modXenonColour":255,"modDashboardColour":147,"color2":0,"modPlateHolder":-1,"modShifterLeavers":-1,"modAPlate":-1,"neonEnabled":[false,false,false,false],"windowTint":1,"modEngine":4,"modTrimA":-1,"modSeats":0,"modDashboard":0}', 'BCSO0003', NULL),
	(25, 'sheriff', 'Police Department', 'npolchar', 'In', 78, 'Sheriff Charger 1', 1000, 909, '99,99,100,100,98,100,96,98', '{"modXenonColour":255,"modXenon":1,"modArmor":-1,"modEngine":4,"modVanityPlate":-1,"modHydrolic":-1,"modTurbo":false,"modDashboard":0,"model":"NPOLCHAR","modHorns":-1,"modAPlate":-1,"modOrnaments":0,"modRearBumper":-1,"modBrakes":-1,"tyreSmokeColor":[255,255,255],"modShifterLeavers":-1,"wheelColor":0,"pearlescentColor":0,"modSeats":-1,"modStruts":-1,"modSideSkirt":-1,"color2":0,"modAirFilter":-1,"color1":132,"modTransmission":-1,"modHood":-1,"modGrille":-1,"modBackWheels":-1,"windowTint":1,"modSmokeEnabled":1,"modExhaust":-1,"extras":{"4":true,"3":true,"6":true,"5":true,"7":true,"2":true,"1":true},"modFrontWheels":-1,"modWindows":-1,"modInteriorColour":111,"dirtLevel":0.0,"modTrimB":0,"modRoof":-1,"modRightFender":-1,"modDashboardColour":147,"modPlateHolder":-1,"modDial":0,"modAerials":-1,"neonColor":[255,0,255],"modTrunk":-1,"engineHealth":1000.0,"modSpoilers":2,"modDoorSpeaker":-1,"plateIndex":4,"modSuspension":2,"modTank":5,"modFrame":-1,"wheels":0,"modSteeringWheel":-1,"modFrontBumper":1,"modArchCover":3,"modFender":-1,"modSpeakers":-1,"plate":"BCSO0004","bodyHealth":1000.0,"neonEnabled":[false,false,false,false],"modLivery":1,"modEngineBlock":-1,"fuelLevel":65.0,"modoldLivery":-1,"modTrimA":-1}', 'BCSO0004', NULL),
	(26, 'police', 'Police Department', 'npolvic', 'In', 27, 'LSPD Victoria 1', 699, 985, '46,55,26,54,54,42,51,45', '{"modXenonColour":255,"modXenon":1,"modTrunk":2,"engineHealth":1000.0,"modVanityPlate":-1,"modSuspension":-1,"modTurbo":1,"modDashboard":0,"model":"NPOLVIC","modHorns":-1,"modAPlate":-1,"modOrnaments":0,"neonEnabled":[false,false,false,false],"modBrakes":2,"tyreSmokeColor":[255,255,255],"modShifterLeavers":-1,"wheelColor":0,"pearlescentColor":0,"modSeats":0,"modStruts":-1,"modSideSkirt":-1,"color2":0,"modAirFilter":-1,"color1":111,"modTransmission":2,"modHood":-1,"modGrille":-1,"modBackWheels":-1,"windowTint":1,"modSmokeEnabled":1,"wheels":1,"extras":{"4":true,"3":false,"6":true,"5":true,"7":true,"2":false,"1":true},"modFrontWheels":-1,"modWindows":-1,"modInteriorColour":111,"dirtLevel":0.0,"modPlateHolder":-1,"modRoof":-1,"modRightFender":4,"modDashboardColour":0,"modTrimA":-1,"modExhaust":-1,"modAerials":0,"neonColor":[255,0,255],"modDial":0,"modArmor":-1,"modEngine":2,"modDoorSpeaker":-1,"plateIndex":4,"modHydrolic":-1,"modTank":6,"modFrame":1,"modoldLivery":-1,"modSteeringWheel":-1,"modFrontBumper":0,"modArchCover":1,"modFender":0,"modTrimB":1,"plate":"LSPD0002","modSpoilers":-1,"modSpeakers":-1,"modLivery":0,"modEngineBlock":-1,"fuelLevel":65.0,"modRearBumper":-1,"bodyHealth":1000.0}', 'LSPD0002', NULL);
/*!40000 ALTER TABLE `shared_vehicles` ENABLE KEYS */;

-- Dumping structure for table aspect.storage_units
CREATE TABLE IF NOT EXISTS `storage_units` (
  `id` longtext COLLATE utf8mb4_bin NOT NULL,
  `data` longtext COLLATE utf8mb4_bin NOT NULL,
  `given_access` longtext COLLATE utf8mb4_bin DEFAULT '{}'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping structure for table aspect.taxes
CREATE TABLE IF NOT EXISTS `taxes` (
  `paycheckTax` varchar(50) DEFAULT NULL,
  `salesTax` varchar(50) DEFAULT NULL,
  `assetTax` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table aspect.taxes: ~0 rows (approximately)
/*!40000 ALTER TABLE `taxes` DISABLE KEYS */;
INSERT INTO `taxes` (`paycheckTax`, `salesTax`, `assetTax`) VALUES
	('0.2', '0.15', NULL);
/*!40000 ALTER TABLE `taxes` ENABLE KEYS */;

-- Dumping structure for table aspect.tweets
CREATE TABLE IF NOT EXISTS `tweets` (
  `handle` longtext NOT NULL,
  `message` varchar(500) NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `attachment` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table aspect.tweets: ~0 rows (approximately)
/*!40000 ALTER TABLE `tweets` DISABLE KEYS */;
/*!40000 ALTER TABLE `tweets` ENABLE KEYS */;

-- Dumping structure for table aspect.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `hex_id` varchar(100) DEFAULT NULL,
  `steam_id` varchar(50) DEFAULT NULL,
  `community_id` varchar(100) DEFAULT NULL,
  `license` varchar(255) DEFAULT NULL,
  `name` varchar(255) NOT NULL DEFAULT 'Uknown',
  `ip` varchar(50) NOT NULL DEFAULT 'Uknown',
  `rank` varchar(50) NOT NULL DEFAULT 'user',
  `date_created` timestamp NOT NULL DEFAULT current_timestamp(),
  `controls` text DEFAULT '{}',
  `settings` text DEFAULT '{}',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=375 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table aspect.users: ~374 rows (approximately)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;


-- Dumping structure for table aspect.user_bans
CREATE TABLE IF NOT EXISTS `user_bans` (
  `steam_id` longtext NOT NULL DEFAULT '',
  `discord_id` longtext NOT NULL DEFAULT '',
  `steam_name` longtext NOT NULL DEFAULT '',
  `reason` longtext NOT NULL DEFAULT '',
  `details` longtext NOT NULL,
  `date_banned` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table aspect.user_bans: ~0 rows (approximately)
/*!40000 ALTER TABLE `user_bans` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_bans` ENABLE KEYS */;

-- Dumping structure for table aspect.user_contacts
CREATE TABLE IF NOT EXISTS `user_contacts` (
  `identifier` varchar(40) NOT NULL,
  `name` longtext NOT NULL,
  `number` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- Dumping structure for table aspect.user_licenses
CREATE TABLE IF NOT EXISTS `user_licenses` (
  `owner` longtext NOT NULL,
  `type` longtext NOT NULL,
  `status` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table aspect.user_licenses: ~0 rows (approximately)
/*!40000 ALTER TABLE `user_licenses` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_licenses` ENABLE KEYS */;

-- Dumping structure for table aspect.user_messages
CREATE TABLE IF NOT EXISTS `user_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sender` varchar(10) NOT NULL,
  `receiver` varchar(10) NOT NULL,
  `message` varchar(255) NOT NULL DEFAULT '0',
  `date` timestamp NOT NULL DEFAULT current_timestamp(),
  `isRead` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

-- Dumping data for table aspect.user_messages: 14 rows

/*!40000 ALTER TABLE `user_messages` ENABLE KEYS */;

-- Dumping structure for table aspect.vehicle_display
CREATE TABLE IF NOT EXISTS `vehicle_display` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `model` varchar(60) COLLATE utf8mb4_turkish_ci NOT NULL,
  `name` varchar(60) COLLATE utf8mb4_turkish_ci NOT NULL,
  `commission` int(11) NOT NULL DEFAULT 10,
  `baseprice` int(11) NOT NULL DEFAULT 25,
  `price` int(11) DEFAULT 25000,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;

-- Dumping data for table aspect.vehicle_display: ~5 rows (approximately)
/*!40000 ALTER TABLE `vehicle_display` DISABLE KEYS */;
INSERT INTO `vehicle_display` (`id`, `model`, `name`, `commission`, `baseprice`, `price`) VALUES
	(1, 'bati', 'Bati 801', 15, 45000, 35000),
	(2, 'massacro', 'Dewbauchee Massacro', 15, 235000, 100000),
	(3, 'jester3', 'Dinka Jester Retro', 15, 250000, 100000),
	(4, 'jugular', 'Ocelot Jugular', 15, 225000, 100000),
	(5, 'comet5', 'Pfister Comet SR', 15, 475000, 100000);
/*!40000 ALTER TABLE `vehicle_display` ENABLE KEYS */;

-- Dumping structure for table aspect.weed_plants
CREATE TABLE IF NOT EXISTS `weed_plants` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `properties` text NOT NULL,
  `plantid` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=298 DEFAULT CHARSET=utf8mb4;



-- Dumping structure for table aspect.wenmo_logs
CREATE TABLE IF NOT EXISTS `wenmo_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) DEFAULT 0,
  `numfrom` varchar(10) DEFAULT '0',
  `numto` varchar(10) DEFAULT '0',
  `amount` int(11) DEFAULT 0,
  `comment` varchar(255) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `date` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table aspect.wenmo_logs: ~34 rows (approximately)


-- Dumping structure for table aspect.__housedata
CREATE TABLE IF NOT EXISTS `__housedata` (
  `cid` int(11) DEFAULT NULL,
  `house_id` int(11) DEFAULT NULL,
  `house_model` int(11) DEFAULT NULL,
  `data` longtext COLLATE utf8mb4_bin DEFAULT '{}',
  `upfront` int(11) DEFAULT NULL,
  `housename` longtext COLLATE utf8mb4_bin DEFAULT NULL,
  `garages` longtext COLLATE utf8mb4_bin DEFAULT '{}',
  `furniture` longtext COLLATE utf8mb4_bin DEFAULT '{}',
  `status` mediumtext COLLATE utf8mb4_bin DEFAULT 'locked',
  `force_locked` mediumtext COLLATE utf8mb4_bin DEFAULT 'unlocked',
  `due` int(11) DEFAULT NULL,
  `overall` int(11) DEFAULT NULL,
  `payments` int(11) DEFAULT NULL,
  `days` int(11) DEFAULT NULL,
  `can_pay` mediumtext COLLATE utf8mb4_bin DEFAULT 'true'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table aspect.__housedata: ~0 rows (approximately)
/*!40000 ALTER TABLE `__housedata` DISABLE KEYS */;
/*!40000 ALTER TABLE `__housedata` ENABLE KEYS */;

-- Dumping structure for table aspect.__housekeys
CREATE TABLE IF NOT EXISTS `__housekeys` (
  `cid` int(11) DEFAULT NULL,
  `house_id` int(11) DEFAULT NULL,
  `house_model` int(11) DEFAULT NULL,
  `housename` longtext COLLATE utf8mb4_bin DEFAULT NULL,
  `name` mediumtext COLLATE utf8mb4_bin DEFAULT NULL,
  `garages` longtext COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;

-- Dumping structure for table aspect.adminlogs
CREATE TABLE IF NOT EXISTS `adminlogs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `PlayerName` varchar(50) NOT NULL,
  `PlayerHex` varchar(100) NOT NULL,
  `Module` varchar(100) NOT NULL,
  `Title` text NOT NULL,
  `MetaData` text DEFAULT NULL,
  `DTInserted` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=403084 DEFAULT CHARSET=utf8;

-- Dumping data for table aspect.adminlogs: ~30 rows (approximately)
/*!40000 ALTER TABLE `adminlogs` DISABLE KEYS */;
INSERT INTO `adminlogs` (`id`, `PlayerName`, `PlayerHex`, `Module`, `Title`, `MetaData`, `DTInserted`) VALUES

/*!40000 ALTER TABLE `adminlogs` ENABLE KEYS */;

-- Dumping structure for table aspect.banlisthistory
CREATE TABLE IF NOT EXISTS `banlisthistory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `license` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `identifier` varchar(25) COLLATE utf8mb4_bin DEFAULT NULL,
  `liveid` varchar(21) COLLATE utf8mb4_bin DEFAULT NULL,
  `xblid` varchar(21) COLLATE utf8mb4_bin DEFAULT NULL,
  `discord` varchar(30) COLLATE utf8mb4_bin DEFAULT NULL,
  `playerip` varchar(25) COLLATE utf8mb4_bin DEFAULT NULL,
  `targetplayername` varchar(32) COLLATE utf8mb4_bin DEFAULT NULL,
  `sourceplayername` varchar(32) COLLATE utf8mb4_bin DEFAULT NULL,
  `reason` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `timeat` int(11) NOT NULL,
  `added` varchar(40) COLLATE utf8mb4_bin NOT NULL,
  `expiration` int(11) NOT NULL,
  `permanent` int(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=UTF8MB4_BIN;

-- Dumping structure for table aspect.____mdw_bolos
CREATE TABLE IF NOT EXISTS `____mdw_bolos` (
  `dbid` int(11) NOT NULL AUTO_INCREMENT,
  `title` mediumtext DEFAULT NULL,
  `author` mediumtext DEFAULT NULL,
  `time` mediumtext DEFAULT NULL,
  `plate` mediumtext DEFAULT NULL,
  `owner` mediumtext DEFAULT NULL,
  `individual` mediumtext NOT NULL,
  `detail` longtext DEFAULT NULL,
  `tags` longtext DEFAULT NULL,
  `gallery` longtext DEFAULT NULL CHECK (json_valid(`gallery`)),
  `officers` longtext DEFAULT NULL,
  PRIMARY KEY (`dbid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table aspect.____mdw_bolos: ~0 rows (approximately)
/*!40000 ALTER TABLE `____mdw_bolos` DISABLE KEYS */;
INSERT INTO `____mdw_bolos` (`dbid`, `title`, `author`, `time`, `plate`, `owner`, `individual`, `detail`, `tags`, `gallery`, `officers`) VALUES

/*!40000 ALTER TABLE `____mdw_bolos` ENABLE KEYS */;

-- Dumping structure for table aspect.____mdw_reports
CREATE TABLE IF NOT EXISTS `____mdw_reports` (
  `dbid` int(11) NOT NULL AUTO_INCREMENT,
  `title` mediumtext DEFAULT NULL,
  `type` mediumtext DEFAULT NULL,
  `author` mediumtext DEFAULT NULL,
  `time` mediumtext DEFAULT NULL,
  `detail` longtext DEFAULT NULL,
  `tags` longtext DEFAULT '[]',
  `gallery` longtext DEFAULT '[]',
  `officers` longtext DEFAULT '[]',
  `civsinvolved` longtext DEFAULT '[]',
  PRIMARY KEY (`dbid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table aspect.____mdw_reports: ~6 rows (approximately)
/*!40000 ALTER TABLE `____mdw_reports` DISABLE KEYS */;
INSERT INTO `____mdw_reports` (`dbid`, `title`, `type`, `author`, `time`, `detail`, `tags`, `gallery`, `officers`, `civsinvolved`) VALUES
/*!40000 ALTER TABLE `____mdw_reports` ENABLE KEYS */;

-- Dumping data for table aspect.__housekeys: ~0 rows (approximately)
/*!40000 ALTER TABLE `__housekeys` DISABLE KEYS */;
/*!40000 ALTER TABLE `__housekeys` ENABLE KEYS */;

-- Dumping structure for table aspect.__vehiclemods
CREATE TABLE IF NOT EXISTS `__vehiclemods` (
  `license_plate` longtext DEFAULT NULL,
  `durability` decimal(2,1) DEFAULT NULL,
  `nitrous` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table aspect.__vehiclemods: ~16 rows (approximately)
/*!40000 ALTER TABLE `__vehiclemods` DISABLE KEYS */;
/*!40000 ALTER TABLE `__vehiclemods` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
