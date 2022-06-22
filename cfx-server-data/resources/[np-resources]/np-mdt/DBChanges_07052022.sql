ALTER TABLE `jobs_whitelist`
	ADD COLUMN `nickname` VARCHAR(50) NOT NULL DEFAULT '' AFTER `callsign`,
	ADD COLUMN `dept` INT(2) NOT NULL DEFAULT 0 AFTER `nickname`,
	ADD COLUMN `badgeImage` VARCHAR(250) NULL DEFAULT NULL AFTER `dept`;

UPDATE jobs_whitelist SET `rank`=7 WHERE `owner`='steam:1100001047cbbeb'