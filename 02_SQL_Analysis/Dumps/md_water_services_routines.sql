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
-- Temporary view structure for view `combined_analysis_table`
--

DROP TABLE IF EXISTS `combined_analysis_table`;
/*!50001 DROP VIEW IF EXISTS `combined_analysis_table`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `combined_analysis_table` AS SELECT 
 1 AS `source_type`,
 1 AS `town_name`,
 1 AS `province_name`,
 1 AS `location_type`,
 1 AS `people_served`,
 1 AS `time_in_queue`,
 1 AS `results`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `incorrect_records`
--

DROP TABLE IF EXISTS `incorrect_records`;
/*!50001 DROP VIEW IF EXISTS `incorrect_records`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `incorrect_records` AS SELECT 
 1 AS `location_id`,
 1 AS `record_id`,
 1 AS `employee_name`,
 1 AS `auditor_score`,
 1 AS `surveyor_score`,
 1 AS `statements`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `combined_analysis_table`
--

/*!50001 DROP VIEW IF EXISTS `combined_analysis_table`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `combined_analysis_table` AS select `water_source`.`type_of_water_source` AS `source_type`,`location`.`town_name` AS `town_name`,`location`.`province_name` AS `province_name`,`location`.`location_type` AS `location_type`,`water_source`.`number_of_people_served` AS `people_served`,`visits`.`time_in_queue` AS `time_in_queue`,`well_pollution`.`results` AS `results` from (((`visits` left join `well_pollution` on((`well_pollution`.`source_id` = `visits`.`source_id`))) join `location` on((`location`.`location_id` = `visits`.`location_id`))) join `water_source` on((`water_source`.`source_id` = `visits`.`source_id`))) where (`visits`.`visit_count` = 1) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `incorrect_records`
--

/*!50001 DROP VIEW IF EXISTS `incorrect_records`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `incorrect_records` AS select `auditor_report`.`location_id` AS `location_id`,`visits`.`record_id` AS `record_id`,`employee`.`employee_name` AS `employee_name`,`auditor_report`.`true_water_source_score` AS `auditor_score`,`wq`.`subjective_quality_score` AS `surveyor_score`,`auditor_report`.`statements` AS `statements` from (((`auditor_report` join `visits` on((`auditor_report`.`location_id` = `visits`.`location_id`))) join `water_quality` `wq` on((`visits`.`record_id` = `wq`.`record_id`))) join `employee` on((`employee`.`assigned_employee_id` = `visits`.`assigned_employee_id`))) where ((`visits`.`visit_count` = 1) and (`auditor_report`.`true_water_source_score` <> `wq`.`subjective_quality_score`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-10-17 22:11:11
