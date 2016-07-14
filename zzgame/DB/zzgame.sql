/*
MySQL Backup
Source Server Version: 5.5.9
Source Database: zzgame
Date: 2016-07-13 20:56:46
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
INSERT INTO `user` VALUES ('123','123','123','0','31','0','0','0'), ('admin','admin','admin','0','50','25','270','371'), ('admin1','admin','laosiji','50','0','0','0','0'), ('Liao','liao','Liao','56','50','0','300','9999999'), ('zyw','zyw','good','50','50','50','258','408');
