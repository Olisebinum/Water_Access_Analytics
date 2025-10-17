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
-- Table structure for table `data_dictionary`
--

DROP TABLE IF EXISTS `data_dictionary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `data_dictionary` (
  `table_name` varchar(255) NOT NULL,
  `column_name` varchar(255) NOT NULL,
  `description` text,
  `datatype` varchar(50) DEFAULT NULL,
  `related_to` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_dictionary`
--

LOCK TABLES `data_dictionary` WRITE;
/*!40000 ALTER TABLE `data_dictionary` DISABLE KEYS */;
INSERT INTO `data_dictionary` VALUES ('employee','assigned_employee_id','Unique ID assigned to each employee','INT','visits'),('employee','employee_name','Name of the employee','VARCHAR(255)',''),('employee','phone_number','Contact number of the employee','VARCHAR(15)',''),('employee','email','Email address of the employee','VARCHAR(255)',''),('employee','address','Residential address of the employee','VARCHAR(255)',''),('employee','town_name','Name of the town where the employee resides','VARCHAR(255)',''),('employee','province_name','Name of the province where the employee resides','VARCHAR(255)',''),('employee','position','Position or job title of the employee','VARCHAR(255)',''),('visits','record_id','Unique ID assigned to each visit','int','water_quality, water_source'),('visits','location_id','ID of the location visited','varchar(255)','location'),('visits','source_id','ID of the water source visited','varchar(510)','well_pollution'),('visits','time_of_record','Date and time of the visit','datetime',''),('visits','visit_count','Number of visits made to this location','int',''),('visits','time_in_queue','Time spent by people waiting for water in a queue at the location','int',''),('visits','assigned_employee_id','ID of the employee who visited the location','int','employee'),('water_quality','record_id','Unique ID assigned to each record','int',''),('water_quality','subjective_quality_score','Score representing the subjective quality of the water source','int',''),('water_quality','visit_count','Number of visits made for data collection','int',''),('water_source','source_id','Unique ID assigned to each water source','VARCHAR(510)','visits'),('water_source','type_of_water_source','Type or category of the water source. Can be : tap_in_home, tap_in_home_broken, well, shared_tap, river','VARCHAR(255)',''),('water_source','number_of_people_served','Number of people served by this water source','INT',''),('well_pollution','source_id','ID of the water source being tested for pollution','varchar(258)','visits'),('well_pollution','date','Date of the pollution test','datetime',''),('well_pollution','description','Description of the pollution test','varchar(255)',''),('well_pollution','pollutant_ppm','Result of the pollution test in parts per million','float',''),('well_pollution','biological','Biological contamination level','float',''),('well_pollution','results','Result of the pollution test. Can be \'dirty\', \'biologically contaminated\', or \'clean\'','varchar(255)',''),('location','location_id','Unique ID assigned to each location','varchar(255)','visits'),('location','address','Address of the location','varchar(255)',''),('location','province_name','Name of the province where the location is situated','varchar(255)',''),('location','town_name','Name of the town where the location is situated','varchar(255)',''),('location','location_type','Type or category of the location','varchar(255)',''),('global_water_access','name','The country or area name','varchar(255)',''),('global_water_access','region','Geographical region','varchar(255)',''),('global_water_access','year','Year of the data record','int',''),('global_water_access','pop_n','The national population size estimate in thousands','float',''),('global_water_access','pop_u','The urban population share estimate in percentage points (%)','float',''),('global_water_access','wat_bas_n','The estimated national share of people with at least basic service (%)','float',''),('global_water_access','wat_lim_n','The estimated national share of people with limited service (%)','float',''),('global_water_access','wat_unimp_n','The estimated national share of people with unimproved service (%)','float',''),('global_water_access','wat_sur_n','The estimated national share of people with surface service (%)','float',''),('global_water_access','wat_bas_r','The estimated rural share of people with at least basic service (%)','float',''),('global_water_access','wat_lim_r','The estimated rural share of people with limited service (%)','float',''),('global_water_access','wat_unimp_r','The estimated rural share of people with unimproved service (%)','float',''),('global_water_access','wat_sur_r','The estimated rural share of people with surface service (%)','float',''),('global_water_access','wat_bas_u','The estimated urban share of people with at least basic service (%)','float',''),('global_water_access','wat_lim_u','The estimated urban share of people with limited service (%)','float',''),('global_water_access','wat_unimp_u','The estimated urban share of people with unimproved service (%)','float',''),('global_water_access','wat_sur_u','The estimated urban share of people with surface service (%)','float','');
/*!40000 ALTER TABLE `data_dictionary` ENABLE KEYS */;
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
