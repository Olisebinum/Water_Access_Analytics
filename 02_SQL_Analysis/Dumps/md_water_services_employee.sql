-- MySQL dump 10.13  Distrib 8.0.41, for macos15 (x86_64)
--
-- Host: localhost    Database: md_water_services
-- ------------------------------------------------------
-- Server version	8.0.41

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee` (
  `assigned_employee_id` int NOT NULL,
  `employee_name` varchar(255) DEFAULT NULL,
  `phone_number` varchar(15) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `province_name` varchar(255) DEFAULT NULL,
  `town_name` varchar(255) DEFAULT NULL,
  `position` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`assigned_employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` VALUES (0,'Amara Jengo','+99637993287','amara.jengongodowater.gov','36 Pwani Mchangani Road','Sokoto','Ilanga','Field Surveyor'),(1,'Bello Azibo','+99643864786','bello.azibongodowater.gov','129 Ziwa La Kioo Road','Kilimani','Rural','Field Surveyor'),(2,'Bakari Iniko','+99222599041','bakari.inikongodowater.gov','18 Mlima Tazama Avenue','Hawassa','Rural','Field Surveyor'),(3,'Malachi Mavuso','+99945849900','malachi.mavusongodowater.gov','100 Mogadishu Road','Akatsi','Lusaka','Field Surveyor'),(4,'Cheche Buhle','+99381679640','cheche.buhlengodowater.gov','1 Savanna Street','Akatsi','Rural','Field Surveyor'),(5,'Zuriel Matembo','+99034075111','zuriel.matembongodowater.gov','26 Bahari Ya Faraja Road','Kilimani','Rural','Field Surveyor'),(6,'Deka Osumare','+99379364631','deka.osumarengodowater.gov','104 Kenyatta Street','Akatsi','Rural','Field Surveyor'),(7,'Lalitha Kaburi','+99681623240','lalitha.kaburingodowater.gov','145 Sungura Amanpour Road','Kilimani','Rural','Field Surveyor'),(8,'Enitan Zuri','+99248509202','enitan.zuringodowater.gov','117 Kampala Road','Hawassa','Zanzibar','Field Surveyor'),(10,'Farai Nia','+99570082739','farai.niangodowater.gov','33 Angélique Kidjo Avenue','Amanzi','Dahabu','Field Surveyor'),(12,'Gamba Shani','+99438283153','gamba.shaningodowater.gov','38 Mlima Tazama Avenue','Hawassa','Rural','Field Surveyor'),(14,'Harith Nyota','+99917230124','harith.nyotangodowater.gov','42 Malabo Drive','Kilimani','Rural','Field Surveyor'),(16,'Isoke Amani','+99313603182','isoke.amaningodowater.gov','55 Fennec Way','Sokoto','Rural','Field Surveyor'),(18,'Jengo Tumaini','+99820596465','jengo.tumainingodowater.gov','17 Port Harcourt Boulevard','Akatsi','Kintampo','Field Surveyor'),(20,'Kunto Asha','+99176320477','kunto.ashangodowater.gov','30 Nyoka Achebe Street','Amanzi','Dahabu','Field Surveyor'),(22,'Lesedi Kofi','+99611183730','lesedi.kofingodowater.gov','52 Moroni Avenue','Sokoto','Rural','Field Surveyor'),(24,'Makena Thabo','+99690308755','makena.thabongodowater.gov','81 Rhodes Street','Hawassa','Rural','Field Surveyor'),(26,'Nia Furaha','+99522694997','nia.furahangodowater.gov','51 Addis Ababa Road','Akatsi','Harare','Field Surveyor'),(28,'Ona Sefu','+99797494944','ona.sefungodowater.gov','67 Wimbi Dira Avenue','Akatsi','Harare','Field Surveyor'),(30,'Pili Zola','+99822478933','pili.zolangodowater.gov','46 Stone Town Street','Hawassa','Zanzibar','Field Surveyor'),(32,'Quibilah Akua','+99533195846','quibilah.akuangodowater.gov','77 Kinshasa Boulevard','Sokoto','Rural','Field Surveyor'),(34,'Rudo Imani','+99046972648','rudo.imaningodowater.gov','15 Lake Malawi Avenue','Kilimani','Ilanga','Field Surveyor'),(36,'Sanaa Tendaji','+99477692836','sanaa.tendajingodowater.gov','88 Elephantine Boulevard','Amanzi','Dahabu','Field Surveyor'),(38,'Thandiwe Kito','+99895654233','thandiwe.kitongodowater.gov','106 Dakar Road','Hawassa','Zanzibar','Field Surveyor'),(40,'Usafi Ayo','+99613194771','usafi.ayongodowater.gov','76 Kenyatta Street','Sokoto','Rural','Field Surveyor'),(42,'Vuyisile Kwame','+99489752164','vuyisile.kwamengodowater.gov','1 Zambezi Way','Kilimani','Rural','Field Surveyor'),(44,'Wambui Jabali','+99269319001','wambui.jabalingodowater.gov','31 Mandela Road','Hawassa','Rural','Field Surveyor'),(46,'Xola Uzuri','+99239172440','xola.uzuringodowater.gov','50 Enkare Narok Avenue','Amanzi','Dahabu','Field Surveyor'),(48,'Yewande Ebele','+99239164858','yewande.ebelengodowater.gov','119 Moroni Avenue','Hawassa','Rural','Field Surveyor'),(49,'Nadia Zalika','+99578401238','nadia.zalikangodowater.gov','26 Bahari Ya Faraja Road','Kilimani','Rural','Project Manager'),(50,'Ayo Deka','+99345162378','ayo.dekangodowater.gov','18 Mlima Tazama Avenue','Hawassa','Rural','UI/UX Designer'),(52,'Bahira Jamila','+99239271483','bahira.jamilangodowater.gov','30 Nyoka Achebe Street','Amanzi','Dahabu','Front-end Developer'),(53,'Chidi Kunto','+99738251476','chidi.kuntongodowater.gov','146 Okapi Road','Hawassa','Yaounde','Data Analyst'),(54,'Dalila Lesedi','+99471523698','dalila.lesedingodowater.gov','18 Casablanca Road','Sokoto','Rural','Data Analyst'),(56,'Eshe Makena','+99381254763','eshe.makenangodowater.gov','45 Umqombothi Avenue','Hawassa','Serowe','Human Resources Specialist'),(58,'Faridah Khalida','+99142537684','faridah.khalidangodowater.gov','176 Port Said Street','Kilimani','Harare','Pioneer'),(62,'Gavivi Ona','+99924513876','gavivi.onangodowater.gov','51 Addis Ababa Road','Akatsi','Harare','Financial Analyst'),(64,'Hasani Pili','+99568247135','hasani.pilingodowater.gov','33 Afro Beat Road','Hawassa','Serowe','Deputy Project Manager'),(68,'Iniko Quibilah','+99735681472','iniko.quibilahngodowater.gov','93 Afro Beat Road','Hawassa','Serowe','Financial Manager'),(71,'Jengo Rudo','+99317854629','jengo.rudongodowater.gov','33 Angélique Kidjo Avenue','Amanzi','Dahabu','Civil Engineer'),(73,'Kofi Sanaa','+99874512369','kofi.sanaangodowater.gov','42 Malabo Drive','Kilimani','Rural','Creative Designer'),(75,'Lulu Thandiwe','+99127436598','lulu.thandiwengodowater.gov','117 Kampala Road','Hawassa','Zanzibar','Team Leader'),(79,'Makena Usafi','+99583124796','makena.usafingodowater.gov','55 Fennec Way','Sokoto','Rural','Quality Assurance Analyst'),(81,'Nia Vuyisile','+99273841596','nia.vuyisilengodowater.gov','52 Moroni Avenue','Sokoto','Rural','Civil Engineer'),(83,'Ona Wambui','+99968217435','ona.wambuingodowater.gov','81 Rhodes Street','Hawassa','Rural','Public Relations Specialist'),(87,'Pili Xola','+99682314579','pili.xolangodowater.gov','31 Samora Machel Road','Kilimani','Harare','Civil Engineer'),(89,'Quibilah Yewande','+99721534698','quibilah.yewandengodowater.gov','110 Nyerere Road','Kilimani','Rural','Supervisor'),(93,'Rudo Zalika','+99578123469','rudo.zalikangodowater.gov','7 Dakar Drive','Akatsi','Lusaka','Field Engineer'),(94,'Sanaa Ayo','+99375418692','sanaa.ayongodowater.gov','172 Fisi Nkrumah Street','Akatsi','Rural','Data Scientist'),(96,'Thabo Akida','+99178325649','thabo.akidangodowater.gov','24 Okonjo-Iweala Street','Akatsi','Lusaka','Engineering Department Head'),(98,'Usafi Bahir','+99234156789','usafi.bahirngodowater.gov','1 Savanna Street','Akatsi','Rural','Analytical Chemist'),(102,'Vuyisile Ghadir','+99712584936','vuyisile.ghadirngodowater.gov','104 Kenyatta Street','Akatsi','Rural','Micro Biologist'),(104,'Wambui Hadiya','+99634157892','wambui.hadiyangodowater.gov','145 Sungura Amanpour Road','Kilimani','Rural','Compliance Officer'),(105,'Xola Inaya','+99231569847','xola.inayangodowater.gov','100 Mogadishu Road','Akatsi','Lusaka','Field Engineer'),(108,'Yewande Jengo','+99123456978','yewande.jengongodowater.gov','25 Selassie Drive','Amanzi','Rural','Construction Manager'),(110,'Zuri Kofi','+99412356789','zuri.kofingodowater.gov','36 Pwani Mchangani Road','Sokoto','Ilanga','Graphic Designer');
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-10-17 22:11:11
