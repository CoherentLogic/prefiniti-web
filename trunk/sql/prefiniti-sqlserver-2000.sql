-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	5.5.13

-- Prefiniti Database Script
-- Copyright (C) 2011 Prefiniti Inc.
-- $Id: prefiniti-mysql-5.sql 66 2011-07-22 21:49:01Z chocolatejollis38@gmail.com $

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


--
-- Create schema prefiniti
--

CREATE DATABASE IF NOT EXISTS prefiniti;
USE prefiniti;

--
-- Definition of table `association_types`
--

DROP TABLE IF EXISTS `association_types`;
CREATE TABLE `association_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `association_type` int(11) NOT NULL,
  `association_type_name` varchar(255) NOT NULL,
  `permission_order` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `association_types`
--

/*!40000 ALTER TABLE `association_types` DISABLE KEYS */;
INSERT INTO `association_types` (`id`,`association_type`,`association_type_name`,`permission_order`) VALUES 
 (1,0,'Customer',1),
 (2,1,'Employee',2),
 (3,2,'Friend',0);
/*!40000 ALTER TABLE `association_types` ENABLE KEYS */;


DROP TABLE IF EXISTS `industries`;
CREATE TABLE `industries` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `industry_name` varchar(255) NOT NULL,
  `om_uuid` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `industries`
--

/*!40000 ALTER TABLE `industries` DISABLE KEYS */;
INSERT INTO `industries` (`id`,`industry_name`,`om_uuid`) VALUES 
 (1,'Land Survey',NULL),
 (2,'Medical',NULL),
 (3,'Retail',NULL),
 (4,'Restaurant',NULL),
 (5,'Groceries',NULL),
 (6,'Delivery',NULL),
 (7,'Software',NULL),
 (8,'CAD Drafting',NULL),
 (9,'Civil Engineering',NULL),
 (10,'Advertising',NULL),
 (11,'Music',NULL),
 (12,'Entertainment',NULL),
 (13,'Woodworking',NULL),
 (14,'Social Profile',NULL),
 (15,'Construction',NULL),
 (16,'IT Services',NULL),
 (17,'Education',NULL),
 (18,'Religious Institution',NULL),
 (19,'Charity',NULL),
 (20,'General Services',NULL),
 (21,'Legal Services',NULL),
 (22,'Financial Services',NULL),
 (23,'Escrow/Title Services',NULL),
 (24,'Real Estate Sales',NULL),
 (25,'Real Estate Appraisal',NULL),
 (26,'Other/Not Selected',NULL);
/*!40000 ALTER TABLE `industries` ENABLE KEYS */;


--
-- Definition of table `permission_entries`
--

DROP TABLE IF EXISTS `permission_entries`;
CREATE TABLE `permission_entries` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `assoc_id` bigint(20) unsigned NOT NULL,
  `perm_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

--
-- Definition of table `permission_sets`
--

DROP TABLE IF EXISTS `permission_sets`;
CREATE TABLE `permission_sets` (
  `id` varchar(45) NOT NULL,
  `permission_list` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `permission_sets`
--

/*!40000 ALTER TABLE `permission_sets` DISABLE KEYS */;
INSERT INTO `permission_sets` (`id`,`permission_list`) VALUES 
 ('Basic User','AS_LOGIN,MA_VIEW,MA_WRITE,SC_VIEW'),
 ('Customer','WF_VIEW,AS_LOGIN,SC_VIEW,WF_VIEWRFP,MA_VIEW,MA_WRITE,WF_SEARCH'),
 ('Employee','TS_VIEW,TS_CREATE,TS_EDIT,WF_VIEW,WF_CREATE,WF_EDIT,AS_LOGIN,SC_VIEW,AS_VIEW,TS_VIEW_TC,WF_VIEWRFP,MA_VIEW,MA_WRITE,GIS_VIEWSUBDIVISION,WF_SEARCH'),
 ('Manager','TS_VIEW,TS_CREATE,TS_EDIT,TS_DELETE,TS_APPROVE,WF_VIEW,WF_CREATE,WF_EDIT,WF_DELETE,WF_PROCESSORDER,WF_PROCESSRFP,AS_CREATE,AS_EDIT,AS_DELETE,AS_LOGIN,SC_VIEW,SC_DISPATCH,SC_MANAGECREW,AS_VIEW,TS_VIEW_TC,TS_EDIT_TC,TS_DELETE_TC,TS_CREATE_C,TS_REVERSE,WF_VIEWRFP,TS_VIEWALL,MA_VIEW,MA_WRITE,RSS_CREATE,GIS_VIEWSUBDIVISION,GIS_CREATESUBDIVISION,GIS_EDITSUBDIVISION,WF_SEARCH'),
 ('Site Administrator','TS_VIEW,TS_CREATE,TS_EDIT,TS_DELETE,TS_APPROVE,WF_VIEW,WF_CREATE,WF_EDIT,WF_DELETE,WF_PROCESSORDER,WF_PROCESSRFP,AS_CREATE,AS_EDIT,AS_DELETE,WW_SITEMAINTAINER,AS_LOGIN,SC_VIEW,SC_DISPATCH,SC_MANAGECREW,AS_VIEW,TS_VIEW_TC,TS_EDIT_TC,TS_DELETE_TC,TS_CREATE_TC,TS_REVERSE,WF_VIEWRFP,TS_VIEWALL,MA_VIEW,MA_WRITE,RSS_CREATE,GIS_VIEWSUBDIVISION,GIS_CREATESUBDIVISION,GIS_EDITSUBDIVISION,WF_SEARCH');
/*!40000 ALTER TABLE `permission_sets` ENABLE KEYS */;


--
-- Definition of table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
CREATE TABLE `permissions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `perm_key` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `permissions`
--

/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
INSERT INTO `permissions` (`id`,`name`,`perm_key`) VALUES 
 (1,'View Timesheet','TS_VIEW'),
 (2,'Create Timesheet','TS_CREATE'),
 (3,'Edit Timesheet','TS_EDIT'),
 (4,'Delete Timesheet','TS_DELETE'),
 (5,'Approve Timesheet','TS_APPROVE'),
 (6,'View Project','WF_VIEW'),
 (7,'Create Project','WF_CREATE'),
 (8,'Edit Project','WF_EDIT'),
 (9,'Delete Project','WF_DELETE'),
 (10,'Process Order','WF_PROCESSORDER'),
 (11,'Process RFP','WF_PROCESSRFP'),
 (12,'Create Member','AS_CREATE'),
 (13,'Edit Member','AS_EDIT'),
 (14,'Delete Member','AS_DELETE'),
 (15,'Site Maintainer','WW_SITEMAINTAINER'),
 (16,'Login','AS_LOGIN'),
 (17,'View Schedule','SC_VIEW'),
 (18,'Dispatch Crew','SC_DISPATCH'),
 (19,'Manage Crew','SC_MANAGECREW'),
 (20,'View Memberships','AS_VIEW'),
 (21,'Upload File','CM_UPLOAD'),
 (22,'Download File','CM_DOWNLOAD'),
 (23,'Delete File','CM_DELETE'),
 (24,'View Task Codes','TS_VIEW_TC'),
 (25,'Edit Task Codes','TS_EDIT_TC'),
 (26,'Delete Task Codes','TS_DELETE_TC'),
 (27,'Create Task Codes','TS_CREATE_TC'),
 (28,'Reverse Timesheet','TS_REVERSE'),
 (29,'View RFP','WF_VIEWRFP'),
 (30,'Assign Drafter','WF_ASSIGNDRAFTER'),
 (31,'Assign Surveyor','WF_ASSIGNSURVEYOR'),
 (32,'Browse Files','CM_BROWSE'),
 (33,'Timesheet Administrator','TS_VIEWALL'),
 (34,'View Mail Message','MA_VIEW'),
 (35,'Write Mail Message','MA_WRITE'),
 (36,'Create News Article','RSS_CREATE'),
 (37,'View Subdivision','GIS_VIEWSUBDIVISION'),
 (38,'Create Subdivision','GIS_CREATESUBDIVISION'),
 (39,'Edit Subdivision','GIS_EDITSUBDIVISION'),
 (40,'Search Projects','WF_SEARCH'),
 (41,'Stage Files to Site','CM_STAGE'),
 (42,'View Staged Files','CM_VIEW_STAGED'),
 (43,'Delete Staged Files','CM_DELETE_STAGED'),
 (44,'Manage Delinquent Accounts','WF_MANAGE_DELINQUENT'),
 (45,'Assign Project Manager','WF_ASSIGN_PROJECTMANAGER'),
 (46,'Associate File to GIS Map','CM_ASSOCIATE_MAP'),
 (47,'Global Scheduler','SC_GLOBAL_SCHEDULER'),
 (48,'Manage Product Catalog','WW_MANAGECATALOG'),
 (49,'Process Customer Payments','CT_PROCESSPAYMENTS'),
 (50,'Fulfill Orders','CT_FULFILLORDERS'),
 (51,'Deliver Orders','CT_DELIVERORDERS'),
 (52,'Close Orders','CT_CLOSEORDERS');
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;


--
-- Definition of table `site_associations`
--

DROP TABLE IF EXISTS `site_associations`;
CREATE TABLE `site_associations` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `site_id` bigint(20) unsigned NOT NULL,
  `assoc_type` smallint(5) unsigned NOT NULL,
  `conf_id` varchar(255) DEFAULT NULL,
  `billing_company` varchar(255) DEFAULT NULL,
  `billing_address` varchar(255) DEFAULT NULL,
  `billing_city` varchar(255) DEFAULT NULL,
  `billing_state` varchar(255) DEFAULT NULL,
  `billing_zip` varchar(255) DEFAULT NULL,
  `billing_phone` varchar(255) DEFAULT NULL,
  `billing_fax` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- Definition of table `sites`
--

DROP TABLE IF EXISTS `sites`;
CREATE TABLE `sites` (
  `SiteID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `SiteName` text NOT NULL,
  `admin_id` bigint(20) unsigned DEFAULT NULL,
  `enabled` tinyint(3) unsigned NOT NULL,
  `summary` text,
  `about` text,
  `industry` bigint(20) unsigned DEFAULT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `mission_statement` text,
  `vision_statement` text,
  `slogan` text,
  `billing_plan` bigint(20) unsigned DEFAULT NULL,
  `conf_id` varchar(45) DEFAULT NULL,
  `catalog_name` varchar(45) DEFAULT NULL,
  `salestax_rate` float NOT NULL DEFAULT '0',
  `logo_invoice` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`SiteID`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


--
-- Definition of table `auth_tokens`
--

DROP TABLE IF EXISTS `auth_tokens`;
CREATE TABLE `auth_tokens` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `login_date` datetime DEFAULT NULL,
  `logout_date` datetime DEFAULT NULL,
  `active` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `ip_address` varchar(255) DEFAULT '',
  `last_event` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;




--
-- Definition of table `configuration`
--

DROP TABLE IF EXISTS `configuration`;
CREATE TABLE `configuration` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `conf_key` varchar(255) NOT NULL,
  `conf_value` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


--
-- Definition of table `error_codes`
--

DROP TABLE IF EXISTS `error_codes`;
CREATE TABLE `error_codes` (
  `error_code` varchar(45) NOT NULL,
  `error_summary` varchar(45) NOT NULL,
  `error_description` varchar(255) NOT NULL,
  `subsystem` varchar(45) NOT NULL,
  `flag_revalidate` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`error_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `error_codes`
--

/*!40000 ALTER TABLE `error_codes` DISABLE KEYS */;
INSERT INTO `error_codes` (`error_code`,`error_summary`,`error_description`,`subsystem`,`flag_revalidate`) VALUES 
 ('ORMS001','Object record does not exist.','This error occurs when a Prefiniti application attempts to access an object record that does not exist. This error will cause the current Prefiniti instance to be flagged for ORMS re-validation.','ORMS',1),
 ('ORMS002','Invalid OTPK selector.','This error occurs when a Prefiniti application attempts to access an object record using an invalid object type/primary key selector.','ORMS',0),
 ('SEC001','This login session is no longer valid.','This error occurs when a user attempts to access Prefiniti with an invalid or expired session key.','SECURITY',0),
 ('SEC002','Access denied.','This error occurs when a user attempts to access a Prefiniti site without the appropriate permissions.','SECURITY',0),
 ('SEC003','Invalid username or password.','This error occurs when a user attempts to login with invalid credentials.','SECURITY',0);
/*!40000 ALTER TABLE `error_codes` ENABLE KEYS */;

--
-- Definition of table `friends`
--

DROP TABLE IF EXISTS `friends`;
CREATE TABLE `friends` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `source_id` bigint(20) unsigned NOT NULL,
  `target_id` bigint(20) unsigned NOT NULL,
  `confirmed` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `request_date` datetime NOT NULL,
  `om_uuid` varchar(45) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;






--
-- Definition of table `images`
--

DROP TABLE IF EXISTS `images`;
CREATE TABLE `images` (
  `ID` varchar(255) NOT NULL,
  `InputURL` varchar(255) NOT NULL,
  `Width` bigint(20) unsigned NOT NULL,
  `Height` bigint(20) unsigned NOT NULL,
  `LastAccess` datetime NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



--
-- Definition of table `messageinbox`
--

DROP TABLE IF EXISTS `messageinbox`;
CREATE TABLE `messageinbox` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fromuser` bigint(20) unsigned DEFAULT NULL,
  `touser` bigint(20) unsigned DEFAULT NULL,
  `tsubject` text,
  `tbody` text,
  `tdate` datetime DEFAULT NULL,
  `tread` varchar(45) DEFAULT NULL,
  `refJobID` bigint(20) unsigned DEFAULT NULL,
  `readReceipt` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_inbox` smallint(5) unsigned NOT NULL DEFAULT '0',
  `deleted_outbox` smallint(5) unsigned NOT NULL DEFAULT '0',
  `req_id` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

--
-- Definition of table `mobile_providers`
--

DROP TABLE IF EXISTS `mobile_providers`;
CREATE TABLE `mobile_providers` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `carrier` varchar(255) NOT NULL,
  `gateway` varchar(255) NOT NULL,
  `mms` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `mobile_providers`
--

/*!40000 ALTER TABLE `mobile_providers` DISABLE KEYS */;
INSERT INTO `mobile_providers` (`id`,`carrier`,`gateway`,`mms`) VALUES 
 (1,'Alltel','message.alltel.com',0),
 (2,'AT&T','mms.att.net',1),
 (3,'Boost Mobile','myboostmobile.com',0),
 (4,'Nextel','messaging.nextel.com',0),
 (5,'Sprint','pm.sprint.com',1),
 (6,'T-Mobile','tmomail.net',0),
 (7,'US Cellular','mms.uscc.net',1),
 (8,'Verizon','vzwpix.com',1),
 (9,'Virgin Mobile USA','vmobl.com',0),
 (10,'7-11 Speakout','cingularme.com',0),
 (11,'Airtel Wireless','sms.airtelmontana.com',0),
 (12,'Alaska Communications Systems','msg.acsalaska.com',0),
 (13,'Aql','text.aql.com',0),
 (14,'AT&T Enterprise Paging','page.att.net',0),
 (15,'BigRedGiant Mobile Solutions','tachyonsms.co.uk',0),
 (16,'Bell Mobility & Solo Mobile','txt.bell.ca',0),
 (17,'Cellular One','mobile.celloneusa.com',0),
 (18,'Centennial Wireless','cwemail.com',0),
 (19,'Comcel','comcel.com.co',0),
 (20,'Cricket','sms.mycricket.com',0),
 (21,'Fido','fido.ca',0),
 (22,'General Communications','msg.gci.net',0),
 (23,'Globalstar','msg.globalstarusa.com',0),
 (24,'Helio','messaging.sprintpcs.com',0),
 (25,'Illinois Valley Cellular','ivctext.com',0),
 (26,'Iridium','msg.iridium.com',0),
 (27,'Iusacell','rek2.com.mx',0),
 (28,'i wireless','iwspcs.net',0),
 (29,'Koodo Mobile','msg.koodomobile.com',0),
 (30,'MetroPCS','mymetropcs.com',0),
 (31,'Suncom','tms.suncom.com',0),
 (32,'Telus Mobility','msg.telus.com',0),
 (33,'Thumb Cellular','sms.thumbcellular.com',0),
 (34,'Unicel','utext.com',0),
 (36,'Consumer Cellular','cingularme.com',0);
/*!40000 ALTER TABLE `mobile_providers` ENABLE KEYS */;




--
-- Definition of table `orms`
--

DROP TABLE IF EXISTS `orms`;
CREATE TABLE `orms` (
  `id` varchar(255) NOT NULL,
  `r_type` varchar(255) NOT NULL,
  `r_owner` bigint(20) unsigned NOT NULL,
  `r_site` bigint(20) unsigned NOT NULL,
  `r_name` varchar(255) NOT NULL,
  `r_edit` varchar(255) NOT NULL DEFAULT 'javascript:ORMSNoAction();',
  `r_view` varchar(255) NOT NULL DEFAULT 'javascript:ORMSNoAction();',
  `r_delete` varchar(255) NOT NULL DEFAULT 'javascript:ORMSNoAction();',
  `r_thumb` varchar(255) NOT NULL DEFAULT '/graphics/error.png',
  `r_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `r_pk` bigint(20) unsigned NOT NULL,
  `r_status` varchar(255) DEFAULT NULL,
  `r_parent` varchar(255) NOT NULL DEFAULT 'NONE',
  `r_type_version` int(10) unsigned NOT NULL DEFAULT '1',
  `r_latitude` double DEFAULT NULL,
  `r_longitude` double DEFAULT NULL,
  `r_ask_location` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `r_has_location` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Definition of table `orms_access_log`
--

DROP TABLE IF EXISTS `orms_access_log`;
CREATE TABLE `orms_access_log` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `r_id` varchar(255) NOT NULL,
  `a_type` varchar(45) NOT NULL,
  `a_date` datetime NOT NULL,
  `a_user_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


--
-- Definition of table `orms_app_sections`
--

DROP TABLE IF EXISTS `orms_app_sections`;
CREATE TABLE `orms_app_sections` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `r_type` varchar(255) NOT NULL,
  `industry` bigint(20) unsigned NOT NULL,
  `section_name` varchar(255) NOT NULL,
  `section_loader` varchar(255) NOT NULL,
  `section_file` varchar(255) NOT NULL,
  `display_order` int(10) unsigned NOT NULL,
  `r_type_version` int(10) unsigned NOT NULL DEFAULT '1',
  `section_icon` varchar(255) NOT NULL DEFAULT '/graphics/AppIconResources/crystal_project/256x256/apps/kwikdisk.png',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `orms_app_sections`
--

/*!40000 ALTER TABLE `orms_app_sections` DISABLE KEYS */;
INSERT INTO `orms_app_sections` (`id`,`r_type`,`industry`,`section_name`,`section_loader`,`section_file`,`display_order`,`r_type_version`,`section_icon`) VALUES 
 (1,'User Account',0,'Basic Information','/socialnet/sections/basic_information_loader.cfm','/socialnet/sections/basic_information.cfm',0,1,'/graphics/AppIconResources/crystal_project/256x256/apps/kwikdisk.png'),
 (2,'User Account',0,'Common Ground','/socialnet/sections/interests_loader.cfm','/socialnet/sections/interests.cfm',1,1,'/graphics/AppIconResources/crystal_project/256x256/apps/kwikdisk.png'),
 (3,'User Account',0,'Locations','/socialnet/sections/locations_loader.cfm','/socialnet/sections/locations.cfm',2,1,'/graphics/AppIconResources/crystal_project/256x256/apps/kwikdisk.png'),
 (4,'User Account',0,'Memberships','/socialnet/sections/memberships_loader.cfm','/socialnet/sections/memberships.cfm',3,1,'/graphics/AppIconResources/crystal_project/256x256/apps/kwikdisk.png'),
 (5,'User Account',0,'Notifications','/socialnet/sections/notifications_loader.cfm','/socialnet/sections/notifications.cfm',4,1,'/graphics/AppIconResources/crystal_project/256x256/apps/kwikdisk.png'),
 (6,'Project',0,'Project Status','/workFlow/sections/project_status_loader.cfm','/workFlow/sections/project_status.cfm',4,1,'/graphics/AppIconResources/crystal_project/256x256/apps/kwikdisk.png'),
 (7,'Project',0,'Milestones','/workFlow/sections/milestones_loader.cfm','/workFlow/sections/milestones.cfm',6,1,'/graphics/AppIconResources/crystal_project/256x256/apps/kwikdisk.png');
/*!40000 ALTER TABLE `orms_app_sections` ENABLE KEYS */;



--
-- Definition of table `orms_ratings`
--

DROP TABLE IF EXISTS `orms_ratings`;
CREATE TABLE `orms_ratings` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `r_id` varchar(255) NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `post_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `comment_body` text NOT NULL,
  `rating` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;



--
-- Definition of table `orms_creators`
--

DROP TABLE IF EXISTS `orms_creators`;
CREATE TABLE `orms_creators` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `r_type` varchar(255) NOT NULL,
  `file_path` varchar(255) NOT NULL,
  `icon` varchar(255) NOT NULL,
  `r_creatable` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `sidebar` varchar(255) NOT NULL DEFAULT '',
  `db_table` varchar(255) NOT NULL DEFAULT '',
  `db_pkfield` varchar(255) NOT NULL DEFAULT '',
  `db_dsn` varchar(255) NOT NULL DEFAULT 'webwarecl',
  `updater` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `orms_creators`
--

/*!40000 ALTER TABLE `orms_creators` DISABLE KEYS */;
INSERT INTO `orms_creators` (`id`,`r_type`,`file_path`,`icon`,`r_creatable`,`sidebar`,`db_table`,`db_pkfield`,`db_dsn`,`updater`) VALUES 
 (1,'Site','/authentication/Sites/creator/create_site.cfm','',1,'','sites','SiteID','sites','/authentication/Sites/orms_do.cfm'),
 (2,'User Account','/authentication/Users/creator/create_user.cfm','',1,'/socialnet/sections/sidebar.cfm','users','id','webwarecl','/authentication/Users/orms_do.cfm');
/*!40000 ALTER TABLE `orms_creators` ENABLE KEYS */;


--
-- Definition of table `orms_event_comments`
--

DROP TABLE IF EXISTS `orms_event_comments`;
CREATE TABLE `orms_event_comments` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `event_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `comment_date` datetime NOT NULL,
  `body_copy` text NOT NULL,
  `om_uuid` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;



--
-- Definition of table `orms_events`
--

DROP TABLE IF EXISTS `orms_events`;
CREATE TABLE `orms_events` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `target_uuid` varchar(45) NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `event_date` datetime NOT NULL,
  `om_uuid` varchar(45) NOT NULL,
  `event_name` varchar(255) NOT NULL,
  `body_copy` text,
  `file_uuid` varchar(255) NOT NULL DEFAULT 'NO FILE',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;



--
-- Definition of table `orms_files`
--

DROP TABLE IF EXISTS `orms_files`;
CREATE TABLE `orms_files` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'r_pk',
  `om_uuid` varchar(255) NOT NULL COMMENT 'om_uuid of object this file was posted to',
  `poster_id` bigint(20) unsigned NOT NULL COMMENT 'r_pk of user this file was posted by',
  `post_date` datetime NOT NULL COMMENT 'post date',
  `original_filename` varchar(255) NOT NULL COMMENT 'original filename',
  `new_filename` varchar(255) NOT NULL COMMENT 'renamed filename',
  `file_uuid` varchar(255) NOT NULL COMMENT 'orms ID of this file',
  `mime_type` varchar(255) NOT NULL,
  `mime_subtype` varchar(255) NOT NULL,
  `file_size` bigint(20) unsigned NOT NULL,
  `keywords` text NOT NULL,
  `file_extension` varchar(45) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;



--
-- Definition of table `orms_keywords`
--

DROP TABLE IF EXISTS `orms_keywords`;
CREATE TABLE `orms_keywords` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `k_word` varchar(255) NOT NULL,
  `k_value` text NOT NULL,
  `r_id` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


--
-- Definition of table `orms_relations`
--

DROP TABLE IF EXISTS `orms_relations`;
CREATE TABLE `orms_relations` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `rel_source` varchar(255) NOT NULL,
  `rel_target` varchar(255) NOT NULL,
  `rel_type` varchar(255) NOT NULL,
  `rel_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `rel_expires` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


--
-- Definition of table `orms_site_notifications`
--

DROP TABLE IF EXISTS `orms_site_notifications`;
CREATE TABLE `orms_site_notifications` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `notify_text` varchar(255) NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `orms_id` varchar(255) NOT NULL,
  `received` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `acknowledged` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `event_id` bigint(20) unsigned NOT NULL,
  `event_date` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


--
-- Definition of table `orms_subscriptions`
--

DROP TABLE IF EXISTS `orms_subscriptions`;
CREATE TABLE `orms_subscriptions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `target_uuid` varchar(255) NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;




--
-- Definition of table `site_errors`
--

DROP TABLE IF EXISTS `site_errors`;
CREATE TABLE `site_errors` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `error_code` varchar(45) NOT NULL,
  `error_summary` varchar(255) NOT NULL,
  `error_description` varchar(255) NOT NULL,
  `error_timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `error_template` varchar(255) NOT NULL,
  `session_key` varchar(255) NOT NULL,
  `current_object` varchar(255) NOT NULL,
  `extended_info` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

--
-- Definition of table `time_lookup`
--

DROP TABLE IF EXISTS `time_lookup`;
CREATE TABLE `time_lookup` (
  `block_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `time_12hour` varchar(45) NOT NULL,
  `time_24hour` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`block_id`)
) ENGINE=InnoDB AUTO_INCREMENT=97 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `time_lookup`
--

/*!40000 ALTER TABLE `time_lookup` DISABLE KEYS */;
INSERT INTO `time_lookup` (`block_id`,`time_12hour`,`time_24hour`) VALUES 
 (1,'12:00 AM',NULL),
 (2,'12:15 AM',NULL),
 (3,'12:30 AM',NULL),
 (4,'12:45 AM',NULL),
 (5,'1:00 AM',NULL),
 (6,'1:15 AM',NULL),
 (7,'1:30 AM',NULL),
 (8,'1:45 AM',NULL),
 (9,'2:00 AM',NULL),
 (10,'2:15 AM',NULL),
 (11,'2:30 AM',NULL),
 (12,'2:45 AM',NULL),
 (13,'3:00 AM',NULL),
 (14,'3:15 AM',NULL),
 (15,'3:30 AM',NULL),
 (16,'3:45 AM',NULL),
 (17,'4:00 AM',NULL),
 (18,'4:15 AM',NULL),
 (19,'4:30 AM',NULL),
 (20,'4:45 AM',NULL),
 (21,'5:00 AM',NULL),
 (22,'5:15 AM',NULL),
 (23,'5:30 AM',NULL),
 (24,'5:45 AM',NULL),
 (25,'6:00 AM',NULL),
 (26,'6:15 AM',NULL),
 (27,'6:30 AM',NULL),
 (28,'6:45 AM',NULL),
 (29,'7:00 AM',NULL),
 (30,'7:15 AM',NULL),
 (31,'7:30 AM',NULL),
 (32,'7:45 AM',NULL),
 (33,'8:00 AM',NULL),
 (34,'8:15 AM',NULL),
 (35,'8:30 AM',NULL),
 (36,'8:45 AM',NULL),
 (37,'9:00 AM',NULL),
 (38,'9:15 AM',NULL),
 (39,'9:30 AM',NULL),
 (40,'9:45 AM',NULL),
 (41,'10:00 AM',NULL),
 (42,'10:15 AM',NULL),
 (43,'10:30 AM',NULL),
 (44,'10:45 AM',NULL),
 (45,'11:00 AM',NULL),
 (46,'11:15 AM',NULL),
 (47,'11:30 AM',NULL),
 (48,'11:45 AM',NULL),
 (49,'12:00 PM',NULL),
 (50,'12:15 PM',NULL),
 (51,'12:30 PM',NULL),
 (52,'12:45 PM',NULL),
 (53,'1:00 PM',NULL),
 (54,'1:15 PM',NULL),
 (55,'1:30 PM',NULL),
 (56,'1:45 PM',NULL),
 (57,'2:00 PM',NULL),
 (58,'2:15 PM',NULL),
 (59,'2:30 PM',NULL),
 (60,'2:45 PM',NULL),
 (61,'3:00 PM',NULL),
 (62,'3:15 PM',NULL),
 (63,'3:30 PM',NULL),
 (64,'3:45 PM',NULL),
 (65,'4:00 PM',NULL),
 (66,'4:15 PM',NULL),
 (67,'4:30 PM',NULL),
 (68,'4:45 PM',NULL),
 (69,'5:00 PM',NULL),
 (70,'5:15 PM',NULL),
 (71,'5:30 PM',NULL),
 (72,'5:45 PM',NULL),
 (73,'6:00 PM',NULL),
 (74,'6:15 PM',NULL),
 (75,'6:30 PM',NULL),
 (76,'6:45 PM',NULL),
 (77,'7:00 PM',NULL),
 (78,'7:15 PM',NULL),
 (79,'7:30 PM',NULL),
 (80,'7:45 PM',NULL),
 (81,'8:00 PM',NULL),
 (82,'8:15 PM',NULL),
 (83,'8:30 PM',NULL),
 (84,'8:45 PM',NULL),
 (85,'9:00 PM',NULL),
 (86,'9:15 PM',NULL),
 (87,'9:30 PM',NULL),
 (88,'9:45 PM',NULL),
 (89,'10:00 PM',NULL),
 (90,'10:15 PM',NULL),
 (91,'10:30 PM',NULL),
 (92,'10:45 PM',NULL),
 (93,'11:00 PM',NULL),
 (94,'11:15 PM',NULL),
 (95,'11:30 PM',NULL),
 (96,'11:45 PM',NULL);
/*!40000 ALTER TABLE `time_lookup` ENABLE KEYS */;



--
-- Definition of table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(45) NOT NULL DEFAULT '',
  `password` varchar(45) NOT NULL DEFAULT '',
  `longName` varchar(255) NOT NULL,
  `email` text NOT NULL,
  `smsNumber` varchar(45) DEFAULT NULL,
  `picture` text,
  `account_enabled` int(10) unsigned DEFAULT NULL,
  `gender` char(1) DEFAULT NULL,
  `confirm_id` varchar(255) NOT NULL DEFAULT '',
  `phone` varchar(45) DEFAULT NULL,
  `fax` varchar(45) DEFAULT NULL,
  `email_billing` int(10) unsigned NOT NULL DEFAULT '0',
  `confirmed` int(10) unsigned NOT NULL DEFAULT '0',
  `sms_conf` varchar(45) DEFAULT NULL,
  `sms_confirmed` int(10) unsigned NOT NULL DEFAULT '0',
  `last_pwchange` datetime DEFAULT NULL,
  `expired` int(10) unsigned DEFAULT NULL,
  `firstName` varchar(255) DEFAULT NULL,
  `lastName` varchar(255) DEFAULT NULL,
  `webware_admin` tinyint(3) unsigned NOT NULL,
  `middleInitial` varchar(1) NOT NULL,
  `allowSearch` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `birthday` date DEFAULT NULL,
  `relationship_status` varchar(255) DEFAULT NULL,
  `so_id` bigint(20) unsigned DEFAULT '0',
  `zip_code` varchar(45) NOT NULL DEFAULT '88001',
  `password_question` varchar(255) DEFAULT NULL,
  `password_answer` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `CreationDate` datetime DEFAULT NULL,
  `location_url` varchar(255) DEFAULT NULL,
  `last_site_id` bigint(20) unsigned DEFAULT NULL,
  `first_login` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

--
-- Definition of table `web_resource_ratings`
--

DROP TABLE IF EXISTS `web_resource_ratings`;
CREATE TABLE `web_resource_ratings` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `wr_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `rating` tinyint(3) unsigned NOT NULL,
  `category` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;



--
-- Definition of table `web_resources`
--

DROP TABLE IF EXISTS `web_resources`;
CREATE TABLE `web_resources` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `url` varchar(255) NOT NULL,
  `registrar` varchar(255) DEFAULT NULL,
  `pd_enhanced` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;



--
-- Definition of table `webresource_hits`
--

DROP TABLE IF EXISTS `webresource_hits`;
CREATE TABLE `webresource_hits` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `wr_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `hit_date` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


--
-- Create user account for web access
--
CREATE USER 'prefiniti'@'localhost' IDENTIFIED BY 'gat4$rePR29ub+a';
GRANT SELECT,INSERT,DELETE,EXECUTE ON prefiniti.* TO 'prefiniti'@'localhost';


/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
