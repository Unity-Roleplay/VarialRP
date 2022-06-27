CREATE DATABASE IF NOT EXISTS `gta_rp2` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `gta_rp2`;

CREATE TABLE IF NOT EXISTS `_account` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT 'Personal Account',
  `account_type` int(11) DEFAULT NULL,
  `account_balance` int(10) DEFAULT 0,
  `is_frozen` tinyint(1) DEFAULT 0,
  `is_monitored` tinyint(4) DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `account_type_fk_idx` (`account_type`) USING BTREE,
  CONSTRAINT `account_type_fk` FOREIGN KEY (`account_type`) REFERENCES `aspect`.`_account_type` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- gta_rp2._account: ~6 rows (yaklaşık) tablosu için veriler indiriliyor
/*!40000 ALTER TABLE `_account` DISABLE KEYS */;
INSERT INTO `_account` (`id`, `name`, `account_type`, `account_balance`, `is_frozen`, `is_monitored`) VALUES
	(1, 'State Account', 3, 1006753, 0, 0),
	(2, 'Mayor Account', 3, 20000, 0, 0),
	(3, 'DOJ Account', 3, 50000, 0, 0),
	(4, 'Personal Account', 1, 31111, 0, 0),
	(5, 'Personal Account', 1, 194, 0, 0),
	(6, 'Los Santos Federal Reserve', 3, 16541, 0, 0);
/*!40000 ALTER TABLE `_account` ENABLE KEYS */;

-- tablo yapısı dökülüyor gta_rp2._account_access
CREATE TABLE IF NOT EXISTS `_account_access` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) DEFAULT NULL,
  `character_id` int(11) unsigned DEFAULT NULL,
  `access_level` tinyint(5) DEFAULT NULL,
  `is_owner` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4;

-- gta_rp2._account_access: ~4 rows (yaklaşık) tablosu için veriler indiriliyor
/*!40000 ALTER TABLE `_account_access` DISABLE KEYS */;
INSERT INTO `_account_access` (`id`, `account_id`, `character_id`, `access_level`, `is_owner`) VALUES
	(4, 4, 1001, 16, 1),
	(5, 1, 1001, 31, 0),
	(6, 5, 1005, 31, 1),
	(7, 6, 1001, 31, 0);
/*!40000 ALTER TABLE `_account_access` ENABLE KEYS */;

-- tablo yapısı dökülüyor gta_rp2._account_type
CREATE TABLE IF NOT EXISTS `_account_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `public_permission` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

-- gta_rp2._account_type: ~5 rows (yaklaşık) tablosu için veriler indiriliyor
/*!40000 ALTER TABLE `_account_type` DISABLE KEYS */;
INSERT INTO `_account_type` (`id`, `name`, `public_permission`) VALUES
	(1, 'Default', 0),
	(2, 'Savings Account', 1),
	(3, 'State Account', 0),
	(4, 'Business Account', 0),
	(5, 'State Entity Account', 0);
/*!40000 ALTER TABLE `_account_type` ENABLE KEYS */;

-- tablo yapısı dökülüyor gta_rp2._tax_asset
CREATE TABLE IF NOT EXISTS `_tax_asset` (
  `id` int(11) NOT NULL,
  `base_price` int(11) NOT NULL,
  `tax_category_id` int(11) NOT NULL,
  `asset_type` enum('vehicle','property') NOT NULL DEFAULT 'vehicle',
  `asset_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- gta_rp2._tax_asset: ~0 rows (yaklaşık) tablosu için veriler indiriliyor
/*!40000 ALTER TABLE `_tax_asset` DISABLE KEYS */;
/*!40000 ALTER TABLE `_tax_asset` ENABLE KEYS */;

-- tablo yapısı dökülüyor gta_rp2._tax_category
CREATE TABLE IF NOT EXISTS `_tax_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=16384;

-- gta_rp2._tax_category: ~8 rows (yaklaşık) tablosu için veriler indiriliyor
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

-- tablo yapısı dökülüyor gta_rp2._tax_history
CREATE TABLE IF NOT EXISTS `_tax_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mayor_cid` int(11) unsigned NOT NULL,
  `end_date` int(11) DEFAULT unix_timestamp(current_timestamp()),
  `tax_level` int(11) DEFAULT NULL,
  `tax_category_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- gta_rp2._tax_history: ~0 rows (yaklaşık) tablosu için veriler indiriliyor
/*!40000 ALTER TABLE `_tax_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `_tax_history` ENABLE KEYS */;

-- tablo yapısı dökülüyor gta_rp2._tax_level
CREATE TABLE IF NOT EXISTS `_tax_level` (
  `tax_category_id` int(11) NOT NULL,
  `tax_level` int(11) NOT NULL,
  `tax_new_level` int(11) DEFAULT NULL,
  `is_editable` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`tax_category_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- gta_rp2._tax_level: ~8 rows (yaklaşık) tablosu için veriler indiriliyor
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

-- tablo yapısı dökülüyor gta_rp2._tax_payment
CREATE TABLE IF NOT EXISTS `_tax_payment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tax_payment_id` int(11) DEFAULT NULL,
  `amount` decimal(8,2) DEFAULT NULL,
  `due_date` int(11) DEFAULT NULL,
  `is_paid` bit(1) NOT NULL DEFAULT unix_timestamp(current_timestamp() + interval 7 day),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- gta_rp2._tax_payment: ~0 rows (yaklaşık) tablosu için veriler indiriliyor
/*!40000 ALTER TABLE `_tax_payment` DISABLE KEYS */;
/*!40000 ALTER TABLE `_tax_payment` ENABLE KEYS */;

-- tablo yapısı dökülüyor gta_rp2._transaction_log
CREATE TABLE IF NOT EXISTS `_transaction_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `transaction_id` varchar(36) NOT NULL DEFAULT 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxx',
  `payee_account_id` int(11) DEFAULT NULL,
  `receiver_account_id` int(11) DEFAULT NULL,
  `change` int(11) DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `triggered_by` int(11) DEFAULT NULL,
  `updated_at` int(11) DEFAULT unix_timestamp(),
  `tax_level` int(11) NOT NULL,
  `tax_category` int(11) NOT NULL,
  `transaction_type` enum('deposit','withdraw','transfer','payslip','venmo','purchase','forfeiture','grant') NOT NULL DEFAULT 'deposit',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `transaction_id` (`transaction_id`) USING BTREE,
  KEY `transaction_log_ibfk_3` (`payee_account_id`) USING BTREE,
  KEY `transaction_log_ibfk_2` (`payee_account_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=182 DEFAULT CHARSET=utf8mb4;