-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
  `CATEGORY_ID` int NOT NULL AUTO_INCREMENT,
  `NAME` varchar(255) NULL DEFAULT NULL,
  PRIMARY KEY (`CATEGORY_ID`) USING BTREE
);

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES (1, 'medical');
INSERT INTO `category` VALUES (2, 'education');
INSERT INTO `category` VALUES (3, 'social impact');
INSERT INTO `category` VALUES (4, 'crisis relief');

-- ----------------------------
-- Table structure for fundraiser
-- ----------------------------
DROP TABLE IF EXISTS `fundraiser`;
CREATE TABLE `fundraiser`  (
  `FUNDRAISER_ID` int NOT NULL AUTO_INCREMENT,
  `ORGANIZER` varchar(100) NULL DEFAULT NULL,
  `CAPTION` varchar(200) NULL DEFAULT NULL,
  `TARGET_FUNDING` int NULL DEFAULT NULL,
  `CURRENT_FUNDING` int NULL DEFAULT NULL,
  `CITY` varchar(100) NULL DEFAULT NULL,
  `ACTIVE` tinyint NULL DEFAULT NULL,
  `CATEGORY_ID` int NULL DEFAULT NULL,
  PRIMARY KEY (`FUNDRAISER_ID`) USING BTREE,
  INDEX `CATEGORY_ID`(`CATEGORY_ID` ASC) USING BTREE,
  CONSTRAINT `fundraiser_category_fk` FOREIGN KEY (`CATEGORY_ID`) REFERENCES `category` (`CATEGORY_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
);

-- ----------------------------
-- Records of fundraiser
-- ----------------------------
INSERT INTO `fundraiser` VALUES (1, 'Michael Johnson', 'Help us build a new community center', 10000, 5000, 'New York', 1, 1);
INSERT INTO `fundraiser` VALUES (2, 'Emily Davis', 'Support the local animal shelter', 5000, 3000, 'San Francisco', 1, 2);
INSERT INTO `fundraiser` VALUES (3, 'Olivia Martinez', 'Aid for hurricane victims', 20000, 15000, 'Houston', 1, 3);
INSERT INTO `fundraiser` VALUES (4, 'William Clark', 'School supplies for children', 1500, 1000, 'Los Angeles', 1, 4);
INSERT INTO `fundraiser` VALUES (5, 'Sophia Anderson', 'Healthcare for all campaign', 12000, 6000, 'Miami', 0, 1);
INSERT INTO `fundraiser` VALUES (6, 'James Robinson', 'Food drive for the homeless', 8000, 4000, 'Chicago', 0, 2);
INSERT INTO `fundraiser` VALUES (7, 'Ava Wright', 'Clean water initiative', 6000, 3000, 'Boston', 1, 3);
