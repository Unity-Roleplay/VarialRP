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
) ENGINE=InnoDB AUTO_INCREMENT=403186 DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Data exporting was unselected.

-- Dumping structure for table aspect.boost_queue
CREATE TABLE IF NOT EXISTS `boost_queue` (
  `identifier` varchar(60) NOT NULL,
  `pSrc` int(11) DEFAULT NULL,
  PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table aspect.characters
CREATE TABLE IF NOT EXISTS `characters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner` varchar(50) DEFAULT NULL,
  `first_name` varchar(50) NOT NULL DEFAULT 'John',
  `last_name` varchar(50) NOT NULL DEFAULT 'Doe',
  `date_created` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `dob` varchar(50) DEFAULT 'NULL',
  `cash` int(9) DEFAULT 500,
  `bank` int(9) NOT NULL DEFAULT 5000,
  `phone_number` varchar(15) DEFAULT NULL,
  `story` text NOT NULL,
  `new` int(1) NOT NULL DEFAULT 1,
  `deleted` int(11) NOT NULL DEFAULT 0,
  `gender` int(1) NOT NULL DEFAULT 0,
  `job` varchar(50) DEFAULT 'unemployed',
  `jail_time` int(11) NOT NULL DEFAULT 0,
  `dirty_money` int(11) NOT NULL DEFAULT 0,
  `gang_type` int(11) NOT NULL DEFAULT 0,
  `jail_time_mobster` int(11) unsigned zerofill NOT NULL DEFAULT 00000000000,
  `judge_type` int(11) NOT NULL DEFAULT 0,
  `iswjob` int(11) NOT NULL DEFAULT 0,
  `metaData` varchar(1520) DEFAULT '{}',
  `stress_level` int(11) DEFAULT 0,
  `bones` mediumtext DEFAULT '{}',
  `emotes` varchar(4160) DEFAULT '{}',
  `paycheck` int(11) DEFAULT 0,
  `stocks` mediumtext DEFAULT NULL,
  `rehab` int(12) DEFAULT 0,
  `meta` text DEFAULT 'move_m@casual@d',
  `dna` text DEFAULT '{}',
  `contacts` longtext DEFAULT NULL,
  `messages` longtext DEFAULT NULL,
  `accounts` longtext DEFAULT NULL,
  `gallery` longtext DEFAULT NULL,
  `wallpaper` longtext DEFAULT NULL,
  `ammo` longtext DEFAULT NULL,
  `licenses` longtext NOT NULL DEFAULT '[{"license":"Weapon","issuedDate":"","issuedBy":"","issued":0},{"license":"Hunting","issuedDate":"","issuedBy":"","issued":0},{"license":"Business","issuedDate":"","issuedBy":"","issued":0},{"license":"Drivers","issuedDate":"","issuedBy":"","issued":1},{"license":"Fishing","issuedDate":"","issuedBy":"","issued":0},{"license":"Bar","issuedDate":"","issuedBy":"","issued":0},{"license":"Pilot","issuedDate":"","issuedBy":"","issued":0}]',
  `Shungite` longtext NOT NULL DEFAULT '0',
  `tgb` longtext NOT NULL DEFAULT '0',
  `dvd` longtext NOT NULL DEFAULT '0',
  `chips` tinytext NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=856 DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table aspect.characters_cars
CREATE TABLE IF NOT EXISTS `characters_cars` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `character_name` varchar(50) DEFAULT NULL,
  `cid` int(11) DEFAULT NULL,
  `purchase_price` float DEFAULT NULL,
  `model` varchar(50) DEFAULT NULL,
  `data` text NOT NULL,
  `wheelfitment` text NOT NULL,
  `vehicle_state` text DEFAULT NULL,
  `fuel` int(11) DEFAULT 100,
  `name` varchar(50) DEFAULT NULL,
  `engine_damage` bigint(19) DEFAULT 1000,
  `body_damage` bigint(20) DEFAULT 1000,
  `degredation` longtext DEFAULT '100,100,100,100,100,100,100,100',
  `current_garage` varchar(50) DEFAULT NULL,
  `server_number` varchar(50) DEFAULT NULL,
  `vin` varchar(50) DEFAULT '0',
  `financed` int(11) DEFAULT 0,
  `isfinanced` int(11) DEFAULT 0,
  `isTuner` int(11) DEFAULT 0,
  `last_payment` int(11) DEFAULT 0,
  `phone_number` text DEFAULT NULL,
  `coords` varchar(255) DEFAULT NULL,
  `license_plate` varchar(255) NOT NULL DEFAULT '',
  `harness` varchar(50) DEFAULT '0',
  `nitrous` varchar(50) DEFAULT '0',
  `payments_left` int(3) DEFAULT 0,
  `StrikeTime` int(3) DEFAULT 0,
  `strikes` int(3) DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1294 DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table aspect.characters_clothes
CREATE TABLE IF NOT EXISTS `characters_clothes` (
  `cid` int(11) DEFAULT NULL,
  `assExist` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table aspect.characters_gangs
CREATE TABLE IF NOT EXISTS `characters_gangs` (
  `owner` varchar(50) NOT NULL,
  `cid` int(11) NOT NULL,
  `gang` varchar(50) DEFAULT 'none',
  `rank` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table aspect.characters_houses
CREATE TABLE IF NOT EXISTS `characters_houses` (
  `id` int(11) NOT NULL,
  `citizenid` varchar(50) DEFAULT '[]',
  `name` varchar(50) DEFAULT NULL,
  `label` varchar(50) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `tier` int(11) DEFAULT NULL,
  `owned` varchar(50) DEFAULT NULL,
  `coords` text DEFAULT NULL,
  `hasgarage` varchar(50) DEFAULT 'false',
  `garage` varchar(200) DEFAULT '[]',
  `keyholders` text DEFAULT NULL,
  `decorations` longtext DEFAULT NULL,
  `stash` text DEFAULT NULL,
  `outfit` text DEFAULT NULL,
  `logout` text DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table aspect.characters_house_plants
CREATE TABLE IF NOT EXISTS `characters_house_plants` (
  `id` int(11) NOT NULL,
  `houseid` varchar(50) DEFAULT '11111',
  `plants` varchar(65000) DEFAULT '[]'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table aspect.characters_weapons
CREATE TABLE IF NOT EXISTS `characters_weapons` (
  `id` int(11) NOT NULL DEFAULT 0,
  `type` varchar(255) DEFAULT NULL,
  `ammo` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table aspect.character_carkeys
CREATE TABLE IF NOT EXISTS `character_carkeys` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) NOT NULL,
  `plate` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

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

-- Data exporting was unselected.

-- Dumping structure for table aspect.character_face
CREATE TABLE IF NOT EXISTS `character_face` (
  `cid` int(11) DEFAULT NULL,
  `hairColor` mediumtext DEFAULT NULL,
  `headBlend` mediumtext DEFAULT NULL,
  `headOverlay` mediumtext DEFAULT NULL,
  `headStructure` mediumtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table aspect.character_hospital_patients
CREATE TABLE IF NOT EXISTS `character_hospital_patients` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) NOT NULL,
  `illness` varchar(50) NOT NULL DEFAULT 'none',
  `level` int(11) NOT NULL DEFAULT 0,
  `time` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table aspect.character_housing
CREATE TABLE IF NOT EXISTS `character_housing` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) NOT NULL,
  `housing_id` int(11) NOT NULL,
  `Street` text NOT NULL,
  `assigned` int(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table aspect.character_housing_keys
CREATE TABLE IF NOT EXISTS `character_housing_keys` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) NOT NULL,
  `housing_id` int(11) NOT NULL,
  `giver` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table aspect.character_motel
CREATE TABLE IF NOT EXISTS `character_motel` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) NOT NULL,
  `building_type` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1288 DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

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

-- Data exporting was unselected.

-- Dumping structure for table aspect.character_passes
CREATE TABLE IF NOT EXISTS `character_passes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) NOT NULL,
  `rank` int(11) NOT NULL DEFAULT 1,
  `name` text NOT NULL,
  `giver` text NOT NULL,
  `pass_type` text NOT NULL,
  `business_name` text NOT NULL,
  `bank` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=830 DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table aspect.character_presets
CREATE TABLE IF NOT EXISTS `character_presets` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `price` int(255) DEFAULT NULL,
  `drawables` mediumtext DEFAULT NULL,
  `props` mediumtext DEFAULT NULL,
  `drawtextures` mediumtext DEFAULT NULL,
  `proptextures` mediumtext DEFAULT NULL,
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table aspect.character_tattoos
CREATE TABLE IF NOT EXISTS `character_tattoos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) NOT NULL DEFAULT 0,
  `tattoos` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3750 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table aspect.dares_boosting
CREATE TABLE IF NOT EXISTS `dares_boosting` (
  `#` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(255) NOT NULL,
  `BNE` text NOT NULL DEFAULT '0',
  `background` varchar(255) DEFAULT NULL,
  `vin` int(11) DEFAULT NULL,
  `exp` int(11) DEFAULT 0,
  PRIMARY KEY (`#`),
  KEY `citizenid` (`citizenid`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

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
) ENGINE=InnoDB AUTO_INCREMENT=856 DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table aspect.delivery_job
CREATE TABLE IF NOT EXISTS `delivery_job` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `active` float DEFAULT NULL,
  `jobType` varchar(50) DEFAULT NULL,
  `dropAmount` int(2) DEFAULT NULL,
  `pickup` varchar(255) DEFAULT NULL,
  `drop` varchar(255) DEFAULT NULL,
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table aspect.dispatch_code
CREATE TABLE IF NOT EXISTS `dispatch_code` (
  `id` int(11) DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `display_code` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `is_important` varchar(255) DEFAULT NULL,
  `priority` varchar(255) DEFAULT NULL,
  `playsound` varchar(255) DEFAULT NULL,
  `soundname` varchar(255) DEFAULT NULL,
  `blip_color` varchar(255) DEFAULT NULL,
  `is_police` varchar(255) DEFAULT NULL,
  `is_ems` varchar(255) DEFAULT NULL,
  `is_news` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table aspect.dispatch_log
CREATE TABLE IF NOT EXISTS `dispatch_log` (
  `dispatch_id` varchar(255) DEFAULT NULL,
  `cid` varchar(255) DEFAULT NULL,
  `first_street` varchar(255) DEFAULT NULL,
  `second_street` varchar(255) DEFAULT NULL,
  `gender` varchar(255) DEFAULT NULL,
  `event_id` varchar(255) DEFAULT NULL,
  `origin_x` varchar(255) DEFAULT NULL,
  `origin_y` varchar(255) DEFAULT NULL,
  `origin_z` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table aspect.dispatch_vehicle
CREATE TABLE IF NOT EXISTS `dispatch_vehicle` (
  `id` int(11) DEFAULT NULL,
  `model` varchar(255) DEFAULT NULL,
  `first_color` varchar(255) DEFAULT NULL,
  `second_color` varchar(255) DEFAULT NULL,
  `plate` varchar(255) DEFAULT NULL,
  `heading` varchar(255) DEFAULT NULL,
  `event_id` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table aspect.driving_tests
CREATE TABLE IF NOT EXISTS `driving_tests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) DEFAULT NULL,
  `icid` int(11) DEFAULT NULL,
  `instructor` varchar(255) DEFAULT NULL,
  `timestamp` text DEFAULT NULL,
  `points` varchar(255) DEFAULT '0',
  `passed` varchar(255) DEFAULT 'false',
  `results` text DEFAULT '{}',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table aspect.financials_taxes
CREATE TABLE IF NOT EXISTS `financials_taxes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tax` varchar(255) NOT NULL,
  `porcentage` int(11) NOT NULL DEFAULT 0,
  `total` int(11) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `tax_UNIQUE` (`tax`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table aspect.fine_types
CREATE TABLE IF NOT EXISTS `fine_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `label` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  `jailtime` int(11) DEFAULT 0,
  `category` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=113 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table aspect.garbage_crews
CREATE TABLE IF NOT EXISTS `garbage_crews` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `crew_name` varchar(50) NOT NULL,
  `pin` int(255) NOT NULL,
  `cid` int(255) NOT NULL,
  `cid2` int(255) NOT NULL,
  `cid3` int(255) NOT NULL,
  `cid4` int(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table aspect.general_variables
CREATE TABLE IF NOT EXISTS `general_variables` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `value` text DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table aspect.group_banking
CREATE TABLE IF NOT EXISTS `group_banking` (
  `group_type` mediumtext DEFAULT NULL,
  `bank` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table aspect.hospital_patients
CREATE TABLE IF NOT EXISTS `hospital_patients` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) NOT NULL,
  `level` int(11) NOT NULL,
  `illness` text NOT NULL DEFAULT '',
  `time` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1288 DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table aspect.houses
CREATE TABLE IF NOT EXISTS `houses` (
  `id` int(11) NOT NULL DEFAULT 0,
  `cid` int(11) NOT NULL DEFAULT 0,
  `model` text DEFAULT '',
  `data` text DEFAULT '{}',
  `furniture` text DEFAULT '{}',
  `mykeys` text NOT NULL DEFAULT '{}',
  `house_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table aspect.jobs_whitelist
CREATE TABLE IF NOT EXISTS `jobs_whitelist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner` varchar(50) DEFAULT NULL,
  `cid` int(11) DEFAULT NULL,
  `job` varchar(50) DEFAULT 'unemployed',
  `rank` int(11) DEFAULT 0,
  `callsign` varchar(255) DEFAULT NULL,
  `nickname` varchar(50) NOT NULL DEFAULT '',
  `dept` int(2) NOT NULL DEFAULT 0,
  `badgeImage` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=108 DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table aspect.mech_materials
CREATE TABLE IF NOT EXISTS `mech_materials` (
  `garage` text DEFAULT 'Tow Garage',
  `Scrap` int(11) DEFAULT 0,
  `Plastic` int(11) DEFAULT 0,
  `Glass` int(11) DEFAULT 0,
  `Steel` int(11) DEFAULT 0,
  `Aluminium` int(11) DEFAULT 0,
  `Rubber` int(11) DEFAULT 0,
  `Copper` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table aspect.modded_cars
CREATE TABLE IF NOT EXISTS `modded_cars` (
  `id` int(11) DEFAULT NULL,
  `license_plate` varchar(255) DEFAULT NULL,
  `Extractors` varchar(255) DEFAULT '{}',
  `Filter` varchar(255) DEFAULT '{}',
  `Suspension` varchar(255) DEFAULT '{}',
  `Rollbars` varchar(255) DEFAULT '{}',
  `Bored` varchar(255) DEFAULT '{}',
  `Carbon` varchar(255) DEFAULT '{}',
  `LFront` varchar(255) DEFAULT '{}',
  `RFront` varchar(255) DEFAULT '{}',
  `LBack` varchar(255) DEFAULT '{}',
  `RBack` varchar(255) DEFAULT '{}'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table aspect.phone_yp
CREATE TABLE IF NOT EXISTS `phone_yp` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `job` varchar(500) DEFAULT NULL,
  `phonenumber` varchar(50) DEFAULT NULL,
  `company` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1446 DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table aspect.playerstattoos
CREATE TABLE IF NOT EXISTS `playerstattoos` (
  `identifier` int(11) DEFAULT NULL,
  `tattoos` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

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

-- Data exporting was unselected.

-- Dumping structure for table aspect.stash
CREATE TABLE IF NOT EXISTS `stash` (
  `owner_cid` int(11) DEFAULT NULL,
  `admin` int(11) DEFAULT NULL,
  `x` int(122) DEFAULT NULL,
  `y` int(122) DEFAULT NULL,
  `z` int(122) DEFAULT NULL,
  `g_x` int(122) DEFAULT NULL,
  `g_y` int(122) DEFAULT NULL,
  `g_z` int(122) DEFAULT NULL,
  `owner_pin` int(11) DEFAULT NULL,
  `guest_pin` int(11) DEFAULT NULL,
  `useGarage` int(11) DEFAULT NULL,
  `tier` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table aspect.stocks
CREATE TABLE IF NOT EXISTS `stocks` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` decimal(10,2) NOT NULL DEFAULT 0.00,
  `change` decimal(10,2) NOT NULL DEFAULT 0.00,
  `amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table aspect.stocks_characters
CREATE TABLE IF NOT EXISTS `stocks_characters` (
  `cid` int(11) NOT NULL,
  `SHUNG` decimal(10,2) NOT NULL DEFAULT 0.00,
  `STRAMM` decimal(10,2) DEFAULT 0.00,
  `STRLSC` decimal(10,2) DEFAULT 0.00,
  `STR711` decimal(10,2) DEFAULT 0.00,
  `STRBOA` decimal(10,2) DEFAULT 0.00,
  `STRCLS` decimal(10,2) DEFAULT 0.00,
  PRIMARY KEY (`cid`),
  UNIQUE KEY `cid` (`cid`),
  CONSTRAINT `cid_stocks_characters_fk` FOREIGN KEY (`cid`) REFERENCES `characters` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table aspect.storage_units
CREATE TABLE IF NOT EXISTS `storage_units` (
  `id` longtext COLLATE utf8mb4_bin NOT NULL,
  `data` longtext COLLATE utf8mb4_bin NOT NULL,
  `given_access` longtext COLLATE utf8mb4_bin DEFAULT '{}'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Data exporting was unselected.

-- Dumping structure for table aspect.tablet_queue
CREATE TABLE IF NOT EXISTS `tablet_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) DEFAULT 0,
  `type` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table aspect.transaction_history
CREATE TABLE IF NOT EXISTS `transaction_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` text NOT NULL,
  `trans_id` int(11) NOT NULL,
  `account` text NOT NULL,
  `amount` int(11) NOT NULL,
  `trans_type` text NOT NULL,
  `receiver` text NOT NULL,
  `message` text NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table aspect.tweets
CREATE TABLE IF NOT EXISTS `tweets` (
  `handle` longtext NOT NULL,
  `message` varchar(500) NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `attachment` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=702 DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table aspect.user_apartment
CREATE TABLE IF NOT EXISTS `user_apartment` (
  `room` int(11) NOT NULL AUTO_INCREMENT,
  `roomType` int(1) DEFAULT NULL,
  `cid` mediumtext NOT NULL,
  `mykeys` varchar(50) NOT NULL DEFAULT '[]',
  `ilness` mediumtext NOT NULL DEFAULT 'Alive',
  `isImprisoned` mediumtext NOT NULL DEFAULT '0',
  `isClothesSpawn` mediumtext NOT NULL DEFAULT 'true',
  `cash` int(11) DEFAULT 0,
  PRIMARY KEY (`room`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table aspect.user_bans
CREATE TABLE IF NOT EXISTS `user_bans` (
  `name` longtext NOT NULL DEFAULT '',
  `license` longtext NOT NULL DEFAULT '',
  `discord` longtext NOT NULL DEFAULT '',
  `ip` longtext NOT NULL DEFAULT '',
  `reason` longtext NOT NULL,
  `expire` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `bannedby` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table aspect.user_boat
CREATE TABLE IF NOT EXISTS `user_boat` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) DEFAULT '{}',
  `boat_name` varchar(255) DEFAULT '{}',
  `boat_model` varchar(255) DEFAULT '{}',
  `boat_price` varchar(255) DEFAULT '{}',
  `boat_plate` varchar(255) DEFAULT '{}',
  `boat_state` varchar(255) DEFAULT '{}',
  `boat_colorprimary` varchar(255) DEFAULT '{}',
  `boat_colorsecondary` varchar(255) DEFAULT '{}',
  `boat_pearlescentcolor` varchar(255) DEFAULT '{}',
  `boat_wheelcolor` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table aspect.user_contacts
CREATE TABLE IF NOT EXISTS `user_contacts` (
  `identifier` varchar(40) NOT NULL,
  `name` longtext NOT NULL,
  `number` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table aspect.user_inventory2
CREATE TABLE IF NOT EXISTS `user_inventory2` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(500) CHARACTER SET utf8 NOT NULL DEFAULT '0',
  `item_id` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `quality` int(11) NOT NULL DEFAULT 100,
  `information` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '0',
  `slot` int(11) NOT NULL,
  `dropped` tinyint(4) NOT NULL DEFAULT 0,
  `creationDate` bigint(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=321200 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table aspect.user_messages
CREATE TABLE IF NOT EXISTS `user_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sender` varchar(10) NOT NULL,
  `receiver` varchar(10) NOT NULL,
  `message` varchar(255) NOT NULL DEFAULT '0',
  `date` timestamp NOT NULL DEFAULT current_timestamp(),
  `isRead` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1066 DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table aspect.user_settings
CREATE TABLE IF NOT EXISTS `user_settings` (
  `hex_id` varchar(255) NOT NULL DEFAULT '',
  `settings` varchar(255) DEFAULT '{}',
  PRIMARY KEY (`hex_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table aspect.variables
CREATE TABLE IF NOT EXISTS `variables` (
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

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

-- Data exporting was unselected.

-- Dumping structure for table aspect.vehicle_mdt
CREATE TABLE IF NOT EXISTS `vehicle_mdt` (
  `dbid` int(11) NOT NULL,
  `plate` varchar(255) DEFAULT NULL,
  `notes` varchar(50) DEFAULT NULL,
  `image` varchar(255) DEFAULT 'https://cdn.discordapp.com/attachments/832371566859124821/881624386317201498/Screenshot_1607.png',
  `code` int(11) DEFAULT 0,
  `stolen` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table aspect.vip_list
CREATE TABLE IF NOT EXISTS `vip_list` (
  `id` int(11) DEFAULT NULL,
  `steamid` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table aspect.weed
CREATE TABLE IF NOT EXISTS `weed` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `x` int(11) DEFAULT 0,
  `y` int(11) DEFAULT 0,
  `z` int(11) DEFAULT 0,
  `growth` int(11) DEFAULT 0,
  `type` varchar(50) DEFAULT NULL,
  `time` longtext DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table aspect.weed_plants
CREATE TABLE IF NOT EXISTS `weed_plants` (
  `id` int(11) DEFAULT 0,
  `coords` varchar(500) DEFAULT '',
  `seed` varchar(255) DEFAULT NULL,
  `growth` varchar(50) DEFAULT '0',
  `owner` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

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
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table aspect._behives
CREATE TABLE IF NOT EXISTS `_behives` (
  `coords` int(11) NOT NULL DEFAULT 0,
  `id` int(11) NOT NULL DEFAULT 0,
  `has_queen` varchar(50) NOT NULL DEFAULT '0',
  `last_harvest` int(11) NOT NULL DEFAULT 0,
  `heading` int(11) DEFAULT 0,
  `timestamp` int(11) DEFAULT 0,
  PRIMARY KEY (`coords`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table aspect._character_crypto_wallet
CREATE TABLE IF NOT EXISTS `_character_crypto_wallet` (
  `id` int(11) DEFAULT NULL,
  `amount` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table aspect._phone_contact
CREATE TABLE IF NOT EXISTS `_phone_contact` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `character_id` int(10) unsigned NOT NULL,
  `name` varchar(70) DEFAULT NULL,
  `number` char(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table aspect._phone_message
CREATE TABLE IF NOT EXISTS `_phone_message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `number_from` char(50) NOT NULL DEFAULT '0',
  `number_to` char(50) NOT NULL DEFAULT '0',
  `message` varchar(255) DEFAULT '',
  `timestamp` int(11) NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table aspect._scenes
CREATE TABLE IF NOT EXISTS `_scenes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `coords` varchar(1020) CHARACTER SET utf8mb4 NOT NULL,
  `text` varchar(255) CHARACTER SET utf8mb4 NOT NULL,
  `color` varchar(100) CHARACTER SET utf8mb4 NOT NULL,
  `distance` float NOT NULL,
  `font` varchar(50) NOT NULL,
  `caret` varchar(50) NOT NULL,
  `solid` varchar(50) NOT NULL,
  `background` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table aspect._twats
CREATE TABLE IF NOT EXISTS `_twats` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `character_id` int(11) DEFAULT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `text` text DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table aspect._weed
CREATE TABLE IF NOT EXISTS `_weed` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `coords` varchar(1020) COLLATE utf8mb4_bin NOT NULL,
  `strain` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `gender` tinyint(4) NOT NULL DEFAULT 0,
  `last_harvest` int(11) NOT NULL DEFAULT 0,
  `timestamp` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Data exporting was unselected.

-- Dumping structure for table aspect._yellowpages
CREATE TABLE IF NOT EXISTS `_yellowpages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `character_id` int(11) DEFAULT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `number` int(11) DEFAULT NULL,
  `text` text DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table aspect.__banking_logs
CREATE TABLE IF NOT EXISTS `__banking_logs` (
  `cid` int(11) DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  `reason` longtext NOT NULL,
  `withdraw` int(11) DEFAULT NULL,
  `business` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table aspect.__housedata
CREATE TABLE IF NOT EXISTS `__housedata` (
  `cid` int(11) DEFAULT NULL,
  `house_id` int(11) DEFAULT NULL,
  `house_model` int(11) DEFAULT NULL,
  `data` longtext COLLATE utf8mb4_bin NOT NULL DEFAULT '{}',
  `upfront` int(11) DEFAULT NULL,
  `housename` longtext COLLATE utf8mb4_bin DEFAULT NULL,
  `garages` longtext COLLATE utf8mb4_bin NOT NULL DEFAULT '{}',
  `furniture` longtext COLLATE utf8mb4_bin NOT NULL DEFAULT '{}',
  `status` mediumtext COLLATE utf8mb4_bin NOT NULL DEFAULT 'locked',
  `force_locked` mediumtext COLLATE utf8mb4_bin NOT NULL DEFAULT 'unlocked',
  `due` int(11) DEFAULT NULL,
  `overall` int(11) DEFAULT NULL,
  `payments` int(11) DEFAULT NULL,
  `days` int(11) DEFAULT NULL,
  `can_pay` mediumtext COLLATE utf8mb4_bin NOT NULL DEFAULT 'true'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Data exporting was unselected.

-- Dumping structure for table aspect.__housekeys
CREATE TABLE IF NOT EXISTS `__housekeys` (
  `cid` int(11) DEFAULT NULL,
  `house_id` int(11) DEFAULT NULL,
  `house_model` int(11) DEFAULT NULL,
  `housename` longtext COLLATE utf8mb4_bin DEFAULT NULL,
  `name` mediumtext COLLATE utf8mb4_bin NOT NULL,
  `garages` longtext COLLATE utf8mb4_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;

-- Data exporting was unselected.

-- Dumping structure for table aspect.__old_user_licenses
CREATE TABLE IF NOT EXISTS `__old_user_licenses` (
  `cid` longtext NOT NULL,
  `type` longtext NOT NULL,
  `status` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table aspect.__vehiclemods
CREATE TABLE IF NOT EXISTS `__vehiclemods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `durability` int(11) DEFAULT NULL,
  `license_plate` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=166 DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table aspect.___mdw_bulletin
CREATE TABLE IF NOT EXISTS `___mdw_bulletin` (
  `id` bigint(20) NOT NULL DEFAULT 0,
  `title` longtext NOT NULL,
  `info` longtext NOT NULL,
  `time` varchar(50) NOT NULL DEFAULT '0',
  `src` mediumtext NOT NULL,
  `author` mediumtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table aspect.___mdw_incidents
CREATE TABLE IF NOT EXISTS `___mdw_incidents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `author` varchar(100) NOT NULL,
  `time` varchar(100) NOT NULL,
  `details` longtext NOT NULL,
  `tags` longtext NOT NULL,
  `officers` longtext NOT NULL,
  `civilians` longtext NOT NULL,
  `evidence` longtext NOT NULL,
  `associated` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=80 DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table aspect.___mdw_logs
CREATE TABLE IF NOT EXISTS `___mdw_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `text` longtext NOT NULL,
  `time` mediumtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=150 DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table aspect.___mdw_messages
CREATE TABLE IF NOT EXISTS `___mdw_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job` varchar(255) NOT NULL DEFAULT 'police',
  `name` varchar(255) DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL,
  `time` varchar(255) DEFAULT NULL,
  `profilepic` mediumtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table aspect.___mdw_profiles
CREATE TABLE IF NOT EXISTS `___mdw_profiles` (
  `idP` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) DEFAULT NULL,
  `image` longtext DEFAULT NULL,
  `description` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `tags` longtext NOT NULL DEFAULT '{}',
  `gallery` longtext NOT NULL DEFAULT '{}',
  PRIMARY KEY (`idP`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

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

-- Data exporting was unselected.

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

-- Data exporting was unselected.

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
