CREATE DATABASE IF NOT EXISTS `aspect` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `aspect`;

CREATE TABLE `_account` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL DEFAULT 'Personal Account' COLLATE 'utf8mb4_general_ci',
    `account_type` INT(11) NULL DEFAULT NULL,
    `account_balance` INT(10) NULL DEFAULT '0',
    `is_frozen` TINYINT(1) NULL DEFAULT '0',
    `is_monitored` TINYINT(4) NULL DEFAULT '0',
    PRIMARY KEY (`id`) USING BTREE,
    INDEX `account_type_fk_idx` (`account_type`) USING BTREE,
    CONSTRAINT `account_type_fk` FOREIGN KEY (`account_type`) REFERENCES `aspect`.`_account_type` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION
)
COLLATE='utf8mb4_general_ci'
ENGINE=InnoDB
ROW_FORMAT=DYNAMIC
AUTO_INCREMENT=7
;