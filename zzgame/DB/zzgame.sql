/*
MySQL Backup
Source Server Version: 5.5.9
Source Database: zzgame
Date: 2016-07-08 16:57:49
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
--  Table structure for `user`
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `nickname` varchar(255) NOT NULL,
  `game1_score` int(11) DEFAULT NULL,
  `game2_score` int(11) DEFAULT NULL,
  `game3_score` int(11) DEFAULT NULL,
  `game4_score` int(11) DEFAULT NULL,
  `score` int(11) DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records 
-- ----------------------------
INSERT INTO `user` VALUES ('admin','admin','admin','0','0','0','0','0'), ('admin1','admin','laosiji','0','0','0','0','0');
