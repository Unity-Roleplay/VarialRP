-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.4.19-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Dumping data for table aspect.adminlogs: ~0 rows (approximately)
/*!40000 ALTER TABLE `adminlogs` DISABLE KEYS */;
/*!40000 ALTER TABLE `adminlogs` ENABLE KEYS */;

-- Dumping data for table aspect.banlisthistory: ~0 rows (approximately)
/*!40000 ALTER TABLE `banlisthistory` DISABLE KEYS */;
/*!40000 ALTER TABLE `banlisthistory` ENABLE KEYS */;

-- Dumping data for table aspect.boost_queue: ~0 rows (approximately)
/*!40000 ALTER TABLE `boost_queue` DISABLE KEYS */;
/*!40000 ALTER TABLE `boost_queue` ENABLE KEYS */;

-- Dumping data for table aspect.characters: ~1 rows (approximately)
/*!40000 ALTER TABLE `characters` DISABLE KEYS */;
INSERT INTO `characters` (`id`, `owner`, `first_name`, `last_name`, `date_created`, `dob`, `cash`, `bank`, `phone_number`, `story`, `new`, `deleted`, `gender`, `job`, `jail_time`, `dirty_money`, `gang_type`, `jail_time_mobster`, `judge_type`, `iswjob`, `metaData`, `stress_level`, `bones`, `emotes`, `paycheck`, `stocks`, `rehab`, `meta`, `dna`, `contacts`, `messages`, `accounts`, `gallery`, `wallpaper`, `ammo`, `licenses`, `Shungite`, `tgb`, `dvd`, `chips`) VALUES
	(856, 'steam:110000134210df5', 'Johnathan', 'Bean', '2022-06-26 23:39:18', '1999-08-21', 52534, 5000, '4962768554', 'Default story - new char system', 1, 0, 0, 'unemployed', 0, 0, 0, 00000000000, 0, 0, '{"armour":60,"thirst":21,"health":200,"hunger":55}', 0, '{}', '{}', 7100, NULL, 0, 'move_m@casual@d', '{}', NULL, NULL, NULL, NULL, NULL, NULL, '[{"license":"Weapon","issuedDate":"","issuedBy":"","issued":0},{"license":"Hunting","issuedDate":"","issuedBy":"","issued":0},{"license":"Business","issuedDate":"","issuedBy":"","issued":0},{"license":"Drivers","issuedDate":"","issuedBy":"","issued":1},{"license":"Fishing","issuedDate":"","issuedBy":"","issued":0},{"license":"Bar","issuedDate":"","issuedBy":"","issued":0},{"license":"Pilot","issuedDate":"","issuedBy":"","issued":0}]', '0', '0', '0', '0');
/*!40000 ALTER TABLE `characters` ENABLE KEYS */;

-- Dumping data for table aspect.characters_cars: ~1 rows (approximately)
/*!40000 ALTER TABLE `characters_cars` DISABLE KEYS */;
INSERT INTO `characters_cars` (`id`, `character_name`, `cid`, `purchase_price`, `model`, `data`, `wheelfitment`, `vehicle_state`, `fuel`, `name`, `engine_damage`, `body_damage`, `degredation`, `current_garage`, `server_number`, `vin`, `financed`, `isfinanced`, `isTuner`, `last_payment`, `phone_number`, `coords`, `license_plate`, `harness`, `nitrous`, `payments_left`, `StrikeTime`, `strikes`) VALUES
	(1294, NULL, 856, 0, 'npolchar', '{"extracolors":[0,0],"neon":{"1":false,"2":false,"3":false,"0":false},"lights":[255,0,255],"xenonColor":255,"plateIndex":4,"tint":-1,"extras":[0,1,1,1,1,1,1,0,0,0,0,0],"colors":[0,0],"oldLiveries":-1,"interColour":112,"mods":{"1":1,"2":-1,"3":-1,"4":0,"5":-1,"6":-1,"7":-1,"8":-1,"9":-1,"10":1,"11":-1,"12":-1,"13":-1,"14":-1,"15":-1,"16":-1,"17":false,"18":false,"19":false,"20":false,"21":false,"22":false,"23":-1,"24":-1,"25":-1,"26":-1,"27":-1,"28":0,"29":0,"30":0,"31":-1,"32":-1,"33":-1,"34":-1,"35":-1,"36":-1,"37":-1,"38":-1,"39":-1,"40":-1,"41":-1,"42":2,"43":-1,"44":0,"45":1,"46":-1,"47":-1,"48":5,"0":2},"wheeltype":0,"smokecolor":[255,255,255],"platestyle":4,"dashColour":112}', '', 'In', 65, 'npolchar', 1000, 986, '100,100,100,100,100,100,100,99', 'Police Shared', NULL, '0', 0, 0, 0, 0, NULL, '[446.0755615234375,-994.7713012695313,25.17877006530761]', '08DLL346', '0', '0', 0, 0, 0);
/*!40000 ALTER TABLE `characters_cars` ENABLE KEYS */;

-- Dumping data for table aspect.characters_clothes: ~0 rows (approximately)
/*!40000 ALTER TABLE `characters_clothes` DISABLE KEYS */;
/*!40000 ALTER TABLE `characters_clothes` ENABLE KEYS */;

-- Dumping data for table aspect.characters_gangs: ~0 rows (approximately)
/*!40000 ALTER TABLE `characters_gangs` DISABLE KEYS */;
/*!40000 ALTER TABLE `characters_gangs` ENABLE KEYS */;

-- Dumping data for table aspect.characters_houses: 0 rows
/*!40000 ALTER TABLE `characters_houses` DISABLE KEYS */;
/*!40000 ALTER TABLE `characters_houses` ENABLE KEYS */;

-- Dumping data for table aspect.characters_house_plants: 0 rows
/*!40000 ALTER TABLE `characters_house_plants` DISABLE KEYS */;
/*!40000 ALTER TABLE `characters_house_plants` ENABLE KEYS */;

-- Dumping data for table aspect.characters_weapons: ~0 rows (approximately)
/*!40000 ALTER TABLE `characters_weapons` DISABLE KEYS */;
/*!40000 ALTER TABLE `characters_weapons` ENABLE KEYS */;

-- Dumping data for table aspect.character_carkeys: ~0 rows (approximately)
/*!40000 ALTER TABLE `character_carkeys` DISABLE KEYS */;
/*!40000 ALTER TABLE `character_carkeys` ENABLE KEYS */;

-- Dumping data for table aspect.character_current: ~1 rows (approximately)
/*!40000 ALTER TABLE `character_current` DISABLE KEYS */;
INSERT INTO `character_current` (`cid`, `model`, `drawables`, `props`, `drawtextures`, `proptextures`, `assExists`) VALUES
	(856, '1461287021', '{"1":["masks",0],"2":["hair",0],"3":["torsos",0],"4":["legs",0],"5":["bags",0],"6":["shoes",0],"7":["neck",0],"8":["undershirts",0],"9":["vest",0],"10":["decals",0],"11":["jackets",0],"0":["face",0]}', '{"1":["glasses",-1],"2":["earrings",-1],"3":["mouth",-1],"4":["lhand",-1],"5":["rhand",-1],"6":["watches",-1],"7":["braclets",-1],"0":["hats",-1]}', '[["face",0],["masks",0],["hair",0],["torsos",0],["legs",0],["bags",0],["shoes",0],["neck",0],["undershirts",0],["vest",0],["decals",0],["jackets",0]]', '[["hats",-1],["glasses",-1],["earrings",-1],["mouth",-1],["lhand",-1],["rhand",-1],["watches",-1],["braclets",-1]]', NULL);
/*!40000 ALTER TABLE `character_current` ENABLE KEYS */;

-- Dumping data for table aspect.character_face: ~1 rows (approximately)
/*!40000 ALTER TABLE `character_face` DISABLE KEYS */;
INSERT INTO `character_face` (`cid`, `hairColor`, `headBlend`, `headOverlay`, `headStructure`) VALUES
	(856, '[-1,-1]', '[]', '[]', '[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]');
/*!40000 ALTER TABLE `character_face` ENABLE KEYS */;

-- Dumping data for table aspect.character_hospital_patients: ~0 rows (approximately)
/*!40000 ALTER TABLE `character_hospital_patients` DISABLE KEYS */;
/*!40000 ALTER TABLE `character_hospital_patients` ENABLE KEYS */;

-- Dumping data for table aspect.character_housing: ~0 rows (approximately)
/*!40000 ALTER TABLE `character_housing` DISABLE KEYS */;
/*!40000 ALTER TABLE `character_housing` ENABLE KEYS */;

-- Dumping data for table aspect.character_housing_keys: ~0 rows (approximately)
/*!40000 ALTER TABLE `character_housing_keys` DISABLE KEYS */;
/*!40000 ALTER TABLE `character_housing_keys` ENABLE KEYS */;

-- Dumping data for table aspect.character_motel: ~1 rows (approximately)
/*!40000 ALTER TABLE `character_motel` DISABLE KEYS */;
INSERT INTO `character_motel` (`id`, `cid`, `building_type`) VALUES
	(1, 856, 1);
/*!40000 ALTER TABLE `character_motel` ENABLE KEYS */;

-- Dumping data for table aspect.character_outfits: ~0 rows (approximately)
/*!40000 ALTER TABLE `character_outfits` DISABLE KEYS */;
/*!40000 ALTER TABLE `character_outfits` ENABLE KEYS */;

-- Dumping data for table aspect.character_passes: ~1 rows (approximately)
/*!40000 ALTER TABLE `character_passes` DISABLE KEYS */;
INSERT INTO `character_passes` (`id`, `cid`, `rank`, `name`, `giver`, `pass_type`, `business_name`, `bank`) VALUES
	(830, 856, 5, '', 'Admin', 'police', 'police', 0);
/*!40000 ALTER TABLE `character_passes` ENABLE KEYS */;

-- Dumping data for table aspect.character_presets: ~0 rows (approximately)
/*!40000 ALTER TABLE `character_presets` DISABLE KEYS */;
/*!40000 ALTER TABLE `character_presets` ENABLE KEYS */;

-- Dumping data for table aspect.character_tattoos: ~0 rows (approximately)
/*!40000 ALTER TABLE `character_tattoos` DISABLE KEYS */;
/*!40000 ALTER TABLE `character_tattoos` ENABLE KEYS */;

-- Dumping data for table aspect.dares_boosting: ~0 rows (approximately)
/*!40000 ALTER TABLE `dares_boosting` DISABLE KEYS */;
/*!40000 ALTER TABLE `dares_boosting` ENABLE KEYS */;

-- Dumping data for table aspect.debt_logs: ~0 rows (approximately)
/*!40000 ALTER TABLE `debt_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `debt_logs` ENABLE KEYS */;

-- Dumping data for table aspect.delivery_job: ~0 rows (approximately)
/*!40000 ALTER TABLE `delivery_job` DISABLE KEYS */;
/*!40000 ALTER TABLE `delivery_job` ENABLE KEYS */;

-- Dumping data for table aspect.dispatch_code: ~0 rows (approximately)
/*!40000 ALTER TABLE `dispatch_code` DISABLE KEYS */;
/*!40000 ALTER TABLE `dispatch_code` ENABLE KEYS */;

-- Dumping data for table aspect.dispatch_log: ~0 rows (approximately)
/*!40000 ALTER TABLE `dispatch_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `dispatch_log` ENABLE KEYS */;

-- Dumping data for table aspect.dispatch_vehicle: ~0 rows (approximately)
/*!40000 ALTER TABLE `dispatch_vehicle` DISABLE KEYS */;
/*!40000 ALTER TABLE `dispatch_vehicle` ENABLE KEYS */;

-- Dumping data for table aspect.driving_tests: ~0 rows (approximately)
/*!40000 ALTER TABLE `driving_tests` DISABLE KEYS */;
/*!40000 ALTER TABLE `driving_tests` ENABLE KEYS */;

-- Dumping data for table aspect.financials_taxes: ~0 rows (approximately)
/*!40000 ALTER TABLE `financials_taxes` DISABLE KEYS */;
/*!40000 ALTER TABLE `financials_taxes` ENABLE KEYS */;

-- Dumping data for table aspect.fine_types: ~0 rows (approximately)
/*!40000 ALTER TABLE `fine_types` DISABLE KEYS */;
/*!40000 ALTER TABLE `fine_types` ENABLE KEYS */;

-- Dumping data for table aspect.garbage_crews: ~0 rows (approximately)
/*!40000 ALTER TABLE `garbage_crews` DISABLE KEYS */;
/*!40000 ALTER TABLE `garbage_crews` ENABLE KEYS */;

-- Dumping data for table aspect.general_variables: ~0 rows (approximately)
/*!40000 ALTER TABLE `general_variables` DISABLE KEYS */;
/*!40000 ALTER TABLE `general_variables` ENABLE KEYS */;

-- Dumping data for table aspect.group_banking: ~0 rows (approximately)
/*!40000 ALTER TABLE `group_banking` DISABLE KEYS */;
/*!40000 ALTER TABLE `group_banking` ENABLE KEYS */;

-- Dumping data for table aspect.hospital_patients: ~2 rows (approximately)
/*!40000 ALTER TABLE `hospital_patients` DISABLE KEYS */;
INSERT INTO `hospital_patients` (`id`, `cid`, `level`, `illness`, `time`) VALUES
	(1288, 856, 0, 'none', 0),
	(1289, 856, 0, 'none', 0);
/*!40000 ALTER TABLE `hospital_patients` ENABLE KEYS */;

-- Dumping data for table aspect.houses: ~0 rows (approximately)
/*!40000 ALTER TABLE `houses` DISABLE KEYS */;
/*!40000 ALTER TABLE `houses` ENABLE KEYS */;

-- Dumping data for table aspect.jobs_whitelist: ~1 rows (approximately)
/*!40000 ALTER TABLE `jobs_whitelist` DISABLE KEYS */;
INSERT INTO `jobs_whitelist` (`id`, `owner`, `cid`, `job`, `rank`, `callsign`, `nickname`, `dept`, `badgeImage`) VALUES
	(108, 'steam:110000134210df5', 856, 'police', 5, '911', 'awdawdawdwa', 1, NULL);
/*!40000 ALTER TABLE `jobs_whitelist` ENABLE KEYS */;

-- Dumping data for table aspect.mech_materials: ~0 rows (approximately)
/*!40000 ALTER TABLE `mech_materials` DISABLE KEYS */;
/*!40000 ALTER TABLE `mech_materials` ENABLE KEYS */;

-- Dumping data for table aspect.modded_cars: ~0 rows (approximately)
/*!40000 ALTER TABLE `modded_cars` DISABLE KEYS */;
/*!40000 ALTER TABLE `modded_cars` ENABLE KEYS */;

-- Dumping data for table aspect.phone_yp: ~0 rows (approximately)
/*!40000 ALTER TABLE `phone_yp` DISABLE KEYS */;
/*!40000 ALTER TABLE `phone_yp` ENABLE KEYS */;

-- Dumping data for table aspect.playerstattoos: ~76 rows (approximately)
/*!40000 ALTER TABLE `playerstattoos` DISABLE KEYS */;
INSERT INTO `playerstattoos` (`identifier`, `tattoos`) VALUES
	(856, '[]'),
	(856, '[]'),
	(856, '[]'),
	(856, '[]'),
	(856, '[]'),
	(856, '[]'),
	(856, '[]'),
	(856, '[]'),
	(856, '[]'),
	(856, '[]'),
	(856, '[]'),
	(856, '[]'),
	(856, '[]'),
	(856, '[]'),
	(856, '[]'),
	(856, '[]'),
	(856, '[]'),
	(856, '[]'),
	(856, '[]'),
	(856, '[]'),
	(856, '[]'),
	(856, '[]'),
	(856, '[]'),
	(856, '[]'),
	(856, '[]'),
	(856, '[]'),
	(856, '[]'),
	(856, '[]'),
	(856, '[]'),
	(856, '[]'),
	(856, '[]'),
	(856, '[]'),
	(856, '[]'),
	(856, '[]'),
	(856, '[]'),
	(856, '[]'),
	(856, '[]'),
	(856, '[]'),
	(856, '[]'),
	(856, '[]'),
	(856, '[]'),
	(856, '[]'),
	(856, '[]'),
	(856, '[]'),
	(856, '[]'),
	(856, '[]'),
	(856, '[]'),
	(856, '[]'),
	(856, '[]'),
	(856, '[]'),
	(856, '[]'),
	(856, '[]'),
	(856, '[]'),
	(856, '[]'),
	(856, '[]'),
	(856, '[]'),
	(856, '[]'),
	(856, '[]'),
	(856, '{}'),
	(856, '{}'),
	(856, '{}'),
	(856, '{}'),
	(856, '{}'),
	(856, '{}'),
	(856, '{}'),
	(856, '{}'),
	(856, '{}'),
	(856, '{}'),
	(856, '{}'),
	(856, '{}'),
	(856, '{}'),
	(856, '{}'),
	(856, '{}'),
	(856, '{}'),
	(856, '{}'),
	(856, '{}');
/*!40000 ALTER TABLE `playerstattoos` ENABLE KEYS */;

-- Dumping data for table aspect.racing_tracks: ~0 rows (approximately)
/*!40000 ALTER TABLE `racing_tracks` DISABLE KEYS */;
/*!40000 ALTER TABLE `racing_tracks` ENABLE KEYS */;

-- Dumping data for table aspect.stash: ~0 rows (approximately)
/*!40000 ALTER TABLE `stash` DISABLE KEYS */;
/*!40000 ALTER TABLE `stash` ENABLE KEYS */;

-- Dumping data for table aspect.stocks: ~0 rows (approximately)
/*!40000 ALTER TABLE `stocks` DISABLE KEYS */;
/*!40000 ALTER TABLE `stocks` ENABLE KEYS */;

-- Dumping data for table aspect.stocks_characters: ~0 rows (approximately)
/*!40000 ALTER TABLE `stocks_characters` DISABLE KEYS */;
/*!40000 ALTER TABLE `stocks_characters` ENABLE KEYS */;

-- Dumping data for table aspect.storage_units: ~0 rows (approximately)
/*!40000 ALTER TABLE `storage_units` DISABLE KEYS */;
/*!40000 ALTER TABLE `storage_units` ENABLE KEYS */;

-- Dumping data for table aspect.tablet_queue: ~0 rows (approximately)
/*!40000 ALTER TABLE `tablet_queue` DISABLE KEYS */;
/*!40000 ALTER TABLE `tablet_queue` ENABLE KEYS */;

-- Dumping data for table aspect.transaction_history: ~0 rows (approximately)
/*!40000 ALTER TABLE `transaction_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `transaction_history` ENABLE KEYS */;

-- Dumping data for table aspect.tweets: ~0 rows (approximately)
/*!40000 ALTER TABLE `tweets` DISABLE KEYS */;
/*!40000 ALTER TABLE `tweets` ENABLE KEYS */;

-- Dumping data for table aspect.users: ~1 rows (approximately)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `hex_id`, `steam_id`, `community_id`, `license`, `name`, `ip`, `rank`, `date_created`, `controls`, `settings`) VALUES
	(856, 'steam:110000134210df5', 'STEAM_0:1:437290746', '76561198834847220', 'license:4c1be3ad9ed7a7e9277de4dce6295052b5505337', 'hyperfno', 'Uknown', 'dev', '2022-06-26 18:18:09', '{"vehicleSnavigate":"R","tokoptt":"CAPS","generalScoreboard":"U","devnoclip":"F2","movementCrawl":"Z","vehicleSsound":"LEFTALT","generalUseSecondary":"ENTER","generalPhone":"P","devcloak":"F3","helivision":"INPUTAIM","generalUseThird":"G","newsNormal":"E","vehicleDoors":"L","actionBar":"Z","housingSecondary":"G","generalMenu":"F1","loudSpeaker":"-","radiovolumeup":"]","generalTackle":"LEFTSHIFT+E","vehicleHotwire":"H","vehicleCruise":"X","generalUseSecondaryWorld":"F","handheld":"LEFTSHIFT+P","helispotlight":"G","vehicleBelt":"B","vehicleSlights":"Q","devmenu":"F5","housingMain":"H","generalProp":"7","generalEscapeMenu":"ESC","vehicleSearch":"G","newsTools":"H","distanceChange":"G","radiovolumedown":"[","showDispatchLog":"z","generalUse":"E","movementCrouch":"X","heliCam":"E","switchRadioEmergency":"9","carStereo":"LEFTALT+P","helirappel":"X","tokoToggle":"LEFTCTRL","devmarker":"F6","newsMovie":"M","helilockon":"SPACE","radiotoggle":",","generalChat":"T","generalInventory":"TAB"}', '{"hud":[],"tokovoip":{"remoteClickOn":true,"localClickOn":true,"radioVolume":0.8,"stereoAudio":true,"releaseDelay":200,"localClickOff":true,"phoneVolume":0.8,"clickVolume":0.8,"remoteClickOff":true}}');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

-- Dumping data for table aspect.user_apartment: ~0 rows (approximately)
/*!40000 ALTER TABLE `user_apartment` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_apartment` ENABLE KEYS */;

-- Dumping data for table aspect.user_bans: ~0 rows (approximately)
/*!40000 ALTER TABLE `user_bans` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_bans` ENABLE KEYS */;

-- Dumping data for table aspect.user_boat: ~0 rows (approximately)
/*!40000 ALTER TABLE `user_boat` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_boat` ENABLE KEYS */;

-- Dumping data for table aspect.user_contacts: ~0 rows (approximately)
/*!40000 ALTER TABLE `user_contacts` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_contacts` ENABLE KEYS */;

-- Dumping data for table aspect.user_inventory2: ~22 rows (approximately)
/*!40000 ALTER TABLE `user_inventory2` DISABLE KEYS */;
INSERT INTO `user_inventory2` (`id`, `name`, `item_id`, `quality`, `information`, `slot`, `dropped`, `creationDate`) VALUES
	(321200, 'ply-856', 'mobilephone', 100, '{}', 1, 0, 1656284986646),
	(321201, 'ply-856', 'water', 100, '{}', 5, 0, 1656284986649),
	(321202, 'ply-856', 'water', 100, '{}', 5, 0, 1656284986649),
	(321203, 'ply-856', 'water', 100, '{}', 5, 0, 1656284986649),
	(321205, 'ply-856', 'sandwich', 100, '{}', 4, 0, 1656284986648),
	(321206, 'ply-856', 'sandwich', 100, '{}', 4, 0, 1656284986648),
	(321207, 'ply-856', 'repairkit', 100, '{}', 6, 0, 1656284986649),
	(321208, 'ply-856', 'lockpick', 100, '{}', 3, 0, 1656284986648),
	(321209, 'ply-856', 'lockpick', 100, '{}', 3, 0, 1656284986648),
	(321210, 'ply-856', 'lockpick', 100, '{}', 3, 0, 1656284986650),
	(321211, 'ply-856', 'lockpick', 100, '{}', 3, 0, 1656284986650),
	(321212, 'ply-856', 'sandwich', 100, '{}', 4, 0, 1656284986650),
	(321213, 'ply-856', 'sandwich', 100, '{}', 4, 0, 1656284986650),
	(321214, 'ply-856', 'sandwich', 100, '{}', 4, 0, 1656284986650),
	(321215, 'ply-856', 'repairkit', 100, '{}', 6, 0, 1656284986651),
	(321216, 'ply-856', 'mobilephone', 100, '{}', 7, 0, 1656284986649),
	(321217, 'ply-856', 'water', 100, '{}', 5, 0, 1656284986650),
	(321218, 'ply-856', 'water', 100, '{}', 5, 0, 1656284986650),
	(321219, 'ply-856', 'water', 100, '{}', 5, 0, 1656284986650),
	(321220, 'ply-856', 'idcard', 100, '{"Identifier":"856","Name":"Johnathan","Surname":"Bean","Sex":"M","DOB":"1999-08-21"}', 8, 0, 1656284986649),
	(321221, 'Drop-1', 'idcard', 100, '{"Identifier":"856","Name":"Johnathan","Surname":"Bean","Sex":"M","DOB":"1999-08-21"}', 3, 0, 1656284986648),
	(321222, 'ply-856', 'idcard', 100, '{"Identifier":"856","Name":"Johnathan","Surname":"Bean","Sex":"M","DOB":"1999-08-21"}', 9, 0, 1656300318491);
/*!40000 ALTER TABLE `user_inventory2` ENABLE KEYS */;

-- Dumping data for table aspect.user_messages: 0 rows
/*!40000 ALTER TABLE `user_messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_messages` ENABLE KEYS */;

-- Dumping data for table aspect.user_settings: ~0 rows (approximately)
/*!40000 ALTER TABLE `user_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_settings` ENABLE KEYS */;

-- Dumping data for table aspect.variables: ~0 rows (approximately)
/*!40000 ALTER TABLE `variables` DISABLE KEYS */;
/*!40000 ALTER TABLE `variables` ENABLE KEYS */;

-- Dumping data for table aspect.vehicle_display: ~0 rows (approximately)
/*!40000 ALTER TABLE `vehicle_display` DISABLE KEYS */;
/*!40000 ALTER TABLE `vehicle_display` ENABLE KEYS */;

-- Dumping data for table aspect.vehicle_mdt: ~0 rows (approximately)
/*!40000 ALTER TABLE `vehicle_mdt` DISABLE KEYS */;
/*!40000 ALTER TABLE `vehicle_mdt` ENABLE KEYS */;

-- Dumping data for table aspect.vip_list: ~0 rows (approximately)
/*!40000 ALTER TABLE `vip_list` DISABLE KEYS */;
/*!40000 ALTER TABLE `vip_list` ENABLE KEYS */;

-- Dumping data for table aspect.weed: ~0 rows (approximately)
/*!40000 ALTER TABLE `weed` DISABLE KEYS */;
/*!40000 ALTER TABLE `weed` ENABLE KEYS */;

-- Dumping data for table aspect.weed_plants: ~0 rows (approximately)
/*!40000 ALTER TABLE `weed_plants` DISABLE KEYS */;
/*!40000 ALTER TABLE `weed_plants` ENABLE KEYS */;

-- Dumping data for table aspect.wenmo_logs: ~0 rows (approximately)
/*!40000 ALTER TABLE `wenmo_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `wenmo_logs` ENABLE KEYS */;

-- Dumping data for table aspect._account: ~11 rows (approximately)
/*!40000 ALTER TABLE `_account` DISABLE KEYS */;
INSERT INTO `_account` (`id`, `name`, `account_type`, `account_balance`, `is_frozen`, `is_monitored`) VALUES
	(1, 'State Account', 3, 1006753, 0, 0),
	(2, 'Mayor Account', 3, 20000, 0, 0),
	(3, 'ss', 3, 50000, 0, 0),
	(4, 'Personal Account', 1, 30687, 0, 0),
	(5, 'Personal Account', 1, 194, 0, 0),
	(6, 'Los Santos Federal Reserve', 3, 16541, 0, 0),
	(7, 'Illegal Drugs', 4, 9012, 0, 0),
	(8, 'Burgershot', 4, 99988, 0, 0),
	(9, 'Burgershot', 5, 100000, 0, 0),
	(10, 'Savings', 2, 100000, 0, 0),
	(856, 'Personal Account', 2, 12414412, 0, 0);
/*!40000 ALTER TABLE `_account` ENABLE KEYS */;

-- Dumping data for table aspect._account_access: ~9 rows (approximately)
/*!40000 ALTER TABLE `_account_access` DISABLE KEYS */;
INSERT INTO `_account_access` (`id`, `account_id`, `character_id`, `access_level`, `is_owner`) VALUES
	(4, 44, 1001, 16, 1),
	(5, 1, 1001, 31, 0),
	(6, 5, 1005, 31, 1),
	(7, 6, 1001, 31, 0),
	(8, 4, 856, 31, 1),
	(9, 7, 856, 31, 1),
	(10, 8, 856, 31, 1),
	(11, 9, 856, 31, 1),
	(12, 10, 856, 31, 1);
/*!40000 ALTER TABLE `_account_access` ENABLE KEYS */;

-- Dumping data for table aspect._account_type: ~5 rows (approximately)
/*!40000 ALTER TABLE `_account_type` DISABLE KEYS */;
INSERT INTO `_account_type` (`id`, `name`, `public_permission`) VALUES
	(1, 'Default', 0),
	(2, 'Savings Account', 1),
	(3, 'State Account', 0),
	(4, 'Business Account', 0),
	(5, 'State Entity Account', 0);
/*!40000 ALTER TABLE `_account_type` ENABLE KEYS */;

-- Dumping data for table aspect._behives: ~0 rows (approximately)
/*!40000 ALTER TABLE `_behives` DISABLE KEYS */;
/*!40000 ALTER TABLE `_behives` ENABLE KEYS */;

-- Dumping data for table aspect._character_crypto_wallet: ~0 rows (approximately)
/*!40000 ALTER TABLE `_character_crypto_wallet` DISABLE KEYS */;
/*!40000 ALTER TABLE `_character_crypto_wallet` ENABLE KEYS */;

-- Dumping data for table aspect._phone_contact: ~0 rows (approximately)
/*!40000 ALTER TABLE `_phone_contact` DISABLE KEYS */;
/*!40000 ALTER TABLE `_phone_contact` ENABLE KEYS */;

-- Dumping data for table aspect._phone_message: ~0 rows (approximately)
/*!40000 ALTER TABLE `_phone_message` DISABLE KEYS */;
/*!40000 ALTER TABLE `_phone_message` ENABLE KEYS */;

-- Dumping data for table aspect._scenes: ~0 rows (approximately)
/*!40000 ALTER TABLE `_scenes` DISABLE KEYS */;
/*!40000 ALTER TABLE `_scenes` ENABLE KEYS */;

-- Dumping data for table aspect._tax_asset: ~0 rows (approximately)
/*!40000 ALTER TABLE `_tax_asset` DISABLE KEYS */;
/*!40000 ALTER TABLE `_tax_asset` ENABLE KEYS */;

-- Dumping data for table aspect._tax_category: ~8 rows (approximately)
/*!40000 ALTER TABLE `_tax_category` DISABLE KEYS */;
INSERT INTO `_tax_category` (`id`, `name`) VALUES
	(1, 'No Tax'),
	(2, 'Services'),
	(3, 'Vehicle Sales'),
	(4, 'Goods'),
	(5, 'Gas'),
	(6, 'Personal Income'),
	(7, 'Vehicle Registration Tax'),
	(8, 'Property Tax');
/*!40000 ALTER TABLE `_tax_category` ENABLE KEYS */;

-- Dumping data for table aspect._tax_history: ~0 rows (approximately)
/*!40000 ALTER TABLE `_tax_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `_tax_history` ENABLE KEYS */;

-- Dumping data for table aspect._tax_level: ~8 rows (approximately)
/*!40000 ALTER TABLE `_tax_level` DISABLE KEYS */;
INSERT INTO `_tax_level` (`tax_category_id`, `tax_level`, `tax_new_level`, `is_editable`) VALUES
	(1, 0, NULL, 0),
	(2, 15, NULL, 1),
	(3, 15, NULL, 1),
	(4, 15, NULL, 1),
	(5, 15, NULL, 1),
	(6, 20, NULL, 1),
	(7, 20, NULL, 1),
	(8, 20, NULL, 1);
/*!40000 ALTER TABLE `_tax_level` ENABLE KEYS */;

-- Dumping data for table aspect._tax_payment: ~0 rows (approximately)
/*!40000 ALTER TABLE `_tax_payment` DISABLE KEYS */;
/*!40000 ALTER TABLE `_tax_payment` ENABLE KEYS */;

-- Dumping data for table aspect._transaction_log: ~9 rows (approximately)
/*!40000 ALTER TABLE `_transaction_log` DISABLE KEYS */;
INSERT INTO `_transaction_log` (`id`, `transaction_id`, `payee_account_id`, `receiver_account_id`, `change`, `comment`, `triggered_by`, `updated_at`, `tax_level`, `tax_category`, `transaction_type`) VALUES
	(182, '137664e9-9f35-4411-87db-2db43eabf590', 4, 4, 12, '12', 3, 1656296077, 0, 1, 'transfer'),
	(183, '4e64b9ea-f2ca-4cf5-8150-9459ceb5d07f', 4, 4, 12, '12', 3, 1656296078, 0, 1, 'transfer'),
	(184, '9479b1a4-f0f3-44eb-8bc1-b8c3baaa7624', 4, 4, 12313, '131312312', 856, 1656296146, 0, 1, 'withdraw'),
	(185, '30ddbfba-88b6-49ac-8463-3a13016ea3dc', 4, 4, 12000, '', 856, 1656296152, 0, 1, 'deposit'),
	(186, '85bafac1-659b-436f-a1e5-7cc5965f1616', 4, 4, 111, '', 856, 1656296182, 0, 1, 'withdraw'),
	(187, 'af2821df-5563-4792-9c35-d91466bbd1d5', 8, 7, 12, 'test', 2, 1656299771, 0, 1, 'transfer'),
	(188, '0c8ae2d9-ffb1-45e7-9421-d0f6562ca001', 7, 7, 1000, '', 856, 1656302946, 0, 1, 'withdraw'),
	(189, '32c0de6a-161a-4dcf-8e83-b88a52e46ccf', 7, 7, 10000, '', 856, 1656302949, 0, 1, 'withdraw'),
	(190, '101f0ee9-d0be-45ab-882b-8ef89e75f46e', 7, 7, 80000, '', 856, 1656302956, 0, 1, 'withdraw');
/*!40000 ALTER TABLE `_transaction_log` ENABLE KEYS */;

-- Dumping data for table aspect._twats: ~0 rows (approximately)
/*!40000 ALTER TABLE `_twats` DISABLE KEYS */;
/*!40000 ALTER TABLE `_twats` ENABLE KEYS */;

-- Dumping data for table aspect._weed: ~0 rows (approximately)
/*!40000 ALTER TABLE `_weed` DISABLE KEYS */;
/*!40000 ALTER TABLE `_weed` ENABLE KEYS */;

-- Dumping data for table aspect._yellowpages: ~0 rows (approximately)
/*!40000 ALTER TABLE `_yellowpages` DISABLE KEYS */;
/*!40000 ALTER TABLE `_yellowpages` ENABLE KEYS */;

-- Dumping data for table aspect.__banking_logs: ~0 rows (approximately)
/*!40000 ALTER TABLE `__banking_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `__banking_logs` ENABLE KEYS */;

-- Dumping data for table aspect.__housedata: ~0 rows (approximately)
/*!40000 ALTER TABLE `__housedata` DISABLE KEYS */;
/*!40000 ALTER TABLE `__housedata` ENABLE KEYS */;

-- Dumping data for table aspect.__housekeys: ~0 rows (approximately)
/*!40000 ALTER TABLE `__housekeys` DISABLE KEYS */;
/*!40000 ALTER TABLE `__housekeys` ENABLE KEYS */;

-- Dumping data for table aspect.__old_user_licenses: ~0 rows (approximately)
/*!40000 ALTER TABLE `__old_user_licenses` DISABLE KEYS */;
/*!40000 ALTER TABLE `__old_user_licenses` ENABLE KEYS */;

-- Dumping data for table aspect.__vehiclemods: ~0 rows (approximately)
/*!40000 ALTER TABLE `__vehiclemods` DISABLE KEYS */;
/*!40000 ALTER TABLE `__vehiclemods` ENABLE KEYS */;

-- Dumping data for table aspect.___mdw_bulletin: ~0 rows (approximately)
/*!40000 ALTER TABLE `___mdw_bulletin` DISABLE KEYS */;
/*!40000 ALTER TABLE `___mdw_bulletin` ENABLE KEYS */;

-- Dumping data for table aspect.___mdw_incidents: ~2 rows (approximately)
/*!40000 ALTER TABLE `___mdw_incidents` DISABLE KEYS */;
INSERT INTO `___mdw_incidents` (`id`, `title`, `author`, `time`, `details`, `tags`, `officers`, `civilians`, `evidence`, `associated`) VALUES
	(80, '', 'Johnathan Bean', '1656287078453', '', '[]', '[]', '[]', '[]', '[]'),
	(81, 'Name - Charge - undefined', 'Johnathan Bean', '1656287086196', 'LSPD Report4\n\nDate:    Time:\nedfsfsdf\nReporting Officedfsffr: [Name Here]\nfsfsdfs\nAssisting Officer/s: [Name Here]\ndfsdfsfs\nSuspect/s: [Name Here]\nfsf\nWitnesses: [Nsfsfame Here]\nsf\nLocation:\nsfs\nDebrief: fsfssfsfsfsfsfsf', '[]', '[]', '[]', '[]', '[]');
/*!40000 ALTER TABLE `___mdw_incidents` ENABLE KEYS */;

-- Dumping data for table aspect.___mdw_logs: ~0 rows (approximately)
/*!40000 ALTER TABLE `___mdw_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `___mdw_logs` ENABLE KEYS */;

-- Dumping data for table aspect.___mdw_messages: ~0 rows (approximately)
/*!40000 ALTER TABLE `___mdw_messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `___mdw_messages` ENABLE KEYS */;

-- Dumping data for table aspect.___mdw_profiles: ~0 rows (approximately)
/*!40000 ALTER TABLE `___mdw_profiles` DISABLE KEYS */;
/*!40000 ALTER TABLE `___mdw_profiles` ENABLE KEYS */;

-- Dumping data for table aspect.____mdw_bolos: ~0 rows (approximately)
/*!40000 ALTER TABLE `____mdw_bolos` DISABLE KEYS */;
/*!40000 ALTER TABLE `____mdw_bolos` ENABLE KEYS */;

-- Dumping data for table aspect.____mdw_reports: ~0 rows (approximately)
/*!40000 ALTER TABLE `____mdw_reports` DISABLE KEYS */;
/*!40000 ALTER TABLE `____mdw_reports` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
