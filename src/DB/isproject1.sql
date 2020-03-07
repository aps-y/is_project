-- MySQL dump 10.13  Distrib 5.7.29, for Linux (x86_64)
--
-- Host: localhost    Database: isproject
-- ------------------------------------------------------
-- Server version	5.7.29-0ubuntu0.18.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `dac`
--

DROP TABLE IF EXISTS `dac`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dac` (
  `fid` varchar(6) NOT NULL,
  `rights` varchar(3) DEFAULT NULL,
  PRIMARY KEY (`fid`),
  CONSTRAINT `dac_ibfk_1` FOREIGN KEY (`fid`) REFERENCES `files_dir` (`fid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dac`
--

LOCK TABLES `dac` WRITE;
/*!40000 ALTER TABLE `dac` DISABLE KEYS */;
INSERT INTO `dac` VALUES ('1','677');
/*!40000 ALTER TABLE `dac` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `domains`
--

DROP TABLE IF EXISTS `domains`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `domains` (
  `did` varchar(6) NOT NULL,
  `dname` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`did`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `domains`
--

LOCK TABLES `domains` WRITE;
/*!40000 ALTER TABLE `domains` DISABLE KEYS */;
INSERT INTO `domains` VALUES ('1','Dom1'),('2','Dom2'),('3','Dom3'),('4','Dom4'),('5','Dom5');
/*!40000 ALTER TABLE `domains` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `file_domains`
--

DROP TABLE IF EXISTS `file_domains`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `file_domains` (
  `fid` varchar(6) NOT NULL,
  `did` varchar(6) NOT NULL,
  PRIMARY KEY (`fid`,`did`),
  KEY `did` (`did`),
  CONSTRAINT `file_domains_ibfk_1` FOREIGN KEY (`fid`) REFERENCES `files_dir` (`fid`),
  CONSTRAINT `file_domains_ibfk_2` FOREIGN KEY (`did`) REFERENCES `domains` (`did`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `file_domains`
--

LOCK TABLES `file_domains` WRITE;
/*!40000 ALTER TABLE `file_domains` DISABLE KEYS */;
/*!40000 ALTER TABLE `file_domains` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `files_dir`
--

DROP TABLE IF EXISTS `files_dir`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `files_dir` (
  `fid` varchar(6) NOT NULL,
  `fname` varchar(30) DEFAULT NULL,
  `type` enum('f','d') DEFAULT NULL,
  `parent` varchar(6) DEFAULT NULL,
  `own` varchar(6) DEFAULT NULL,
  `lvl_from` int(2) DEFAULT NULL,
  `lvl_to` int(2) DEFAULT NULL,
  PRIMARY KEY (`fid`),
  KEY `fd_par_fk` (`parent`),
  KEY `fd_own_fk` (`own`),
  KEY `lvl_from` (`lvl_from`),
  KEY `lvl_to` (`lvl_to`),
  CONSTRAINT `fd_own_fk` FOREIGN KEY (`own`) REFERENCES `user` (`uid`),
  CONSTRAINT `fd_par_fk` FOREIGN KEY (`parent`) REFERENCES `files_dir` (`fid`),
  CONSTRAINT `files_dir_ibfk_1` FOREIGN KEY (`lvl_from`) REFERENCES `levels` (`lid`),
  CONSTRAINT `files_dir_ibfk_2` FOREIGN KEY (`lvl_to`) REFERENCES `levels` (`lid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `files_dir`
--

LOCK TABLES `files_dir` WRITE;
/*!40000 ALTER TABLE `files_dir` DISABLE KEYS */;
INSERT INTO `files_dir` VALUES ('0','root','d','0','0',2,3),('1','rde','f','0','1',4,5);
/*!40000 ALTER TABLE `files_dir` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `groups`
--

DROP TABLE IF EXISTS `groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `groups` (
  `gid` varchar(6) NOT NULL,
  `gname` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`gid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `groups`
--

LOCK TABLES `groups` WRITE;
/*!40000 ALTER TABLE `groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `levels`
--

DROP TABLE IF EXISTS `levels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `levels` (
  `lid` int(2) NOT NULL,
  `lname` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`lid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `levels`
--

LOCK TABLES `levels` WRITE;
/*!40000 ALTER TABLE `levels` DISABLE KEYS */;
INSERT INTO `levels` VALUES (1,'Level1'),(2,'Level2'),(3,'Level3'),(4,'Level4'),(5,'Level5');
/*!40000 ALTER TABLE `levels` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `test`
--

DROP TABLE IF EXISTS `test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `test` (
  `name` varchar(30) DEFAULT NULL,
  `age` int(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `test`
--

LOCK TABLES `test` WRITE;
/*!40000 ALTER TABLE `test` DISABLE KEYS */;
INSERT INTO `test` VALUES ('mai',23);
/*!40000 ALTER TABLE `test` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `uid` varchar(6) NOT NULL,
  `uname` varchar(20) DEFAULT NULL,
  `lvl_from` int(2) DEFAULT NULL,
  `lvl_to` int(2) DEFAULT NULL,
  PRIMARY KEY (`uid`),
  KEY `lvl_from` (`lvl_from`),
  KEY `lvl_to` (`lvl_to`),
  CONSTRAINT `user_ibfk_1` FOREIGN KEY (`lvl_from`) REFERENCES `levels` (`lid`),
  CONSTRAINT `user_ibfk_2` FOREIGN KEY (`lvl_to`) REFERENCES `levels` (`lid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('0','dlkafj',4,5),('1','fdad',1,2);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_domains`
--

DROP TABLE IF EXISTS `user_domains`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_domains` (
  `uid` varchar(6) NOT NULL,
  `did` varchar(6) NOT NULL,
  PRIMARY KEY (`uid`,`did`),
  KEY `did` (`did`),
  CONSTRAINT `user_domains_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `user` (`uid`),
  CONSTRAINT `user_domains_ibfk_2` FOREIGN KEY (`did`) REFERENCES `domains` (`did`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_domains`
--

LOCK TABLES `user_domains` WRITE;
/*!40000 ALTER TABLE `user_domains` DISABLE KEYS */;
INSERT INTO `user_domains` VALUES ('1','1'),('1','2');
/*!40000 ALTER TABLE `user_domains` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_groups`
--

DROP TABLE IF EXISTS `user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_groups` (
  `uid` varchar(6) NOT NULL,
  `gid` varchar(6) NOT NULL,
  PRIMARY KEY (`uid`,`gid`),
  KEY `gid` (`gid`),
  CONSTRAINT `user_groups_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `user` (`uid`),
  CONSTRAINT `user_groups_ibfk_2` FOREIGN KEY (`gid`) REFERENCES `groups` (`gid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_groups`
--

LOCK TABLES `user_groups` WRITE;
/*!40000 ALTER TABLE `user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_groups` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-03-08  1:32:07
