-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 10, 2026 at 01:13 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `troubleshoot_ai`
--

-- --------------------------------------------------------

--
-- Table structure for table `answers_log`
--

CREATE TABLE `answers_log` (
  `id` int(11) NOT NULL,
  `session_id` varchar(100) NOT NULL,
  `module_id` varchar(100) NOT NULL,
  `node_id` varchar(100) NOT NULL,
  `answer_id` varchar(100) NOT NULL,
  `answer_label` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `answers_log`
--

INSERT INTO `answers_log` (`id`, `session_id`, `module_id`, `node_id`, `answer_id`, `answer_label`, `created_at`) VALUES
(1, 'S_f1de5c43', 'power_no_boot_v1', 'intro', 'continue', 'Continue', '2026-01-19 09:08:59'),
(2, 'S_a903fa9d', 'power_no_boot_v1', 'intro', 'continue', 'Continue', '2026-01-19 12:59:39'),
(3, 'S_a903fa9d', 'power_no_boot_v1', 'n1', 'no', 'No', '2026-01-19 12:59:45'),
(4, 'S_a903fa9d', 'power_no_boot_v1', 'n3', 'still_no', 'No', '2026-01-19 12:59:56'),
(5, 'S_fcec058e', 'power_no_boot_v1', 'intro', 'continue', 'Continue', '2026-01-19 14:01:05'),
(6, 'S_fcec058e', 'power_no_boot_v1', 'n1', 'yes', 'Yes', '2026-01-19 14:01:18'),
(7, 'S_fcec058e', 'power_no_boot_v1', 'n2', 'fan_yes', 'Yes', '2026-01-19 14:01:26'),
(8, 'S_d94852fd', 'power_no_boot_v1', 'intro', 'continue', 'Continue', '2026-01-19 14:17:09'),
(9, 'S_d94852fd', 'power_no_boot_v1', 'n1', 'yes', 'Yes', '2026-01-19 14:17:19'),
(10, 'S_d94852fd', 'power_no_boot_v1', 'n2', 'fan_no', 'No', '2026-01-19 14:17:24'),
(11, 'S_d6d9b957', 'power_no_boot_v1', 'intro', 'continue', 'Continue', '2026-01-19 14:18:10'),
(12, 'S_d6d9b957', 'power_no_boot_v1', 'n1', 'no', 'No', '2026-01-19 14:18:18'),
(13, 'S_d6d9b957', 'power_no_boot_v1', 'n3', 'still_no', 'No', '2026-01-19 14:18:25'),
(14, 'S_f4acaddd', 'power_no_boot_v1', 'intro', 'continue', 'Continue', '2026-01-19 16:16:50'),
(15, 'S_f4acaddd', 'power_no_boot_v1', 'n1', 'no', 'No', '2026-01-19 16:16:55'),
(16, 'S_e35010d9', 'power_no_boot_v1', 'intro', 'continue', 'Continue', '2026-01-19 16:17:33'),
(17, 'S_e35010d9', 'power_no_boot_v1', 'n1', 'yes', 'Yes', '2026-01-19 16:17:36'),
(18, 'S_e35010d9', 'power_no_boot_v1', 'n2', 'no', 'No', '2026-01-19 16:17:43'),
(19, 'S_6a3594b7', 'app_crash_v1', 'intro', 'continue', 'Continue', '2026-01-19 17:09:00'),
(20, 'S_6a3594b7', 'app_crash_v1', 'n1', 'many', 'Many apps', '2026-01-19 17:09:12'),
(21, 'S_6a3594b7', 'app_crash_v1', 'n2_many', 'not_sure', 'Not sure', '2026-01-19 17:09:20'),
(22, 'S_45bf1673', 'app_crash_v1', 'intro', 'continue', 'Continue', '2026-01-19 17:20:01'),
(23, 'S_42e689f6', 'bsod_v1', 'intro', 'continue', 'Continue', '2026-01-19 17:20:36'),
(24, 'S_42e689f6', 'bsod_v1', 'n1', 'yes', 'Yes, I can see it', '2026-01-19 17:20:48'),
(25, 'S_42e689f6', 'bsod_v1', 'n2', 'while_using', 'While using Windows', '2026-01-19 17:20:58'),
(26, 'S_42e689f6', 'bsod_v1', 'n3', 'no_change', 'No recent change', '2026-01-19 17:21:11'),
(27, 'S_42e689f6', 'bsod_v1', 'n4', 'yes', 'Yes', '2026-01-19 17:21:18'),
(28, 'S_42e689f6', 'bsod_v1', 'n5', 'no', 'No', '2026-01-19 17:21:26'),
(29, 'S_3d118092', 'beeping_sound_v1', 'intro', 'continue', 'Continue', '2026-01-19 17:24:46'),
(30, 'S_3d118092', 'beeping_sound_v1', 'n1', 'laptop', 'Laptop', '2026-01-19 17:24:51'),
(31, 'S_3d118092', 'beeping_sound_v1', 'n2_laptop', 'single', 'Just one short beep', '2026-01-19 17:25:24'),
(32, 'S_3d118092', 'beeping_sound_v1', 'n4_display', 'no', 'No display at all', '2026-01-19 17:25:30'),
(33, 'S_3d118092', 'beeping_sound_v1', 'n5_recent', 'no', 'No', '2026-01-19 17:25:40'),
(34, 'S_e5ed840c', 'slow_dragging_v1', 'intro', 'continue', 'Continue', '2026-01-19 17:29:02'),
(35, 'S_e5ed840c', 'slow_dragging_v1', 'n1', 'weeks', 'Some weeks/months', '2026-01-19 17:29:11'),
(36, 'S_e5ed840c', 'slow_dragging_v1', 'n2', 'no', 'No', '2026-01-19 17:29:17'),
(37, 'S_e5ed840c', 'slow_dragging_v1', 'n3', 'hdd', 'HDD (hard disk)', '2026-01-19 17:29:24'),
(38, 'S_e5ed840c', 'slow_dragging_v1', 'n4', 'low_space_no', 'No', '2026-01-19 17:29:31'),
(39, 'S_e5ed840c', 'slow_dragging_v1', 'n5', 'slow_boot', 'Very slow boot/login', '2026-01-19 17:29:47'),
(40, 'S_d37ff2f7', 'beeping_sound_v1', 'intro', 'continue', 'Continue', '2026-01-19 17:30:50'),
(41, 'S_56dccff0', 'slow_dragging_v1', 'intro', 'continue', 'Continue', '2026-01-19 17:39:02'),
(42, 'S_9f7971fb', 'virus_popups_v1', 'intro', 'continue', 'Continue', '2026-01-19 18:04:38'),
(43, 'S_9f7971fb', 'virus_popups_v1', 'n1', 'yes', 'Yes', '2026-01-19 18:04:54'),
(44, 'S_9f7971fb', 'virus_popups_v1', 'n2', 'yes', 'Yes', '2026-01-19 18:04:59'),
(45, 'S_4fd67a98', 'no_internet_on_pc_v1', 'intro', 'continue', 'Continue', '2026-01-19 18:05:40'),
(46, 'S_4fd67a98', 'no_internet_on_pc_v1', 'n1', 'yes', 'Yes, others work', '2026-01-19 18:05:47'),
(47, 'S_4fd67a98', 'no_internet_on_pc_v1', 'n2', 'wifi', 'Wi-Fi', '2026-01-19 18:06:03'),
(48, 'S_4fd67a98', 'no_internet_on_pc_v1', 'n3', 'yes', 'Yes', '2026-01-19 18:06:14'),
(49, 'S_ae8555b1', 'keyboard_not_working_v1', 'intro', 'continue', 'Continue', '2026-01-19 18:06:51'),
(50, 'S_ae8555b1', 'keyboard_not_working_v1', 'n1', 'laptop', 'Laptop built-in', '2026-01-19 18:07:05'),
(51, 'S_ae8555b1', 'keyboard_not_working_v1', 'n2', 'some', 'Some keys', '2026-01-19 18:07:11'),
(52, 'S_173cc911', 'keyboard_not_working_v1', 'intro', 'continue', 'Continue', '2026-01-19 18:09:58'),
(53, 'S_173cc911', 'keyboard_not_working_v1', 'n1', 'external', 'External keyboard', '2026-01-19 18:10:02'),
(54, 'S_173cc911', 'keyboard_not_working_v1', 'n2', 'none', 'None', '2026-01-19 18:10:04'),
(55, 'S_1c8ba49c', 'overheating_v1', 'intro', 'continue', 'Continue', '2026-01-19 18:28:27'),
(56, 'S_1c8ba49c', 'overheating_v1', 'n1', 'anytime', 'Anytime', '2026-01-19 18:28:33'),
(57, 'S_1c8ba49c', 'overheating_v1', 'n2', 'no', 'No / not sure', '2026-01-19 18:28:37'),
(58, 'S_ef919bc3', 'virus_popups_v1', 'intro', 'continue', 'Continue', '2026-01-19 18:39:20'),
(59, 'S_ef919bc3', 'virus_popups_v1', 'n1', 'yes', 'Yes', '2026-01-19 18:39:24'),
(60, 'S_ef919bc3', 'virus_popups_v1', 'n2', 'no', 'No / not sure', '2026-01-19 18:39:28'),
(61, 'S_5fa6148b', 'battery_not_charging_v1', 'intro', 'continue', 'Continue', '2026-01-19 18:51:05'),
(62, 'S_5fa6148b', 'battery_not_charging_v1', 'n1', 'no', 'No', '2026-01-19 18:51:54'),
(63, 'S_d5162e23', 'power_no_boot_v1', 'intro', 'continue', 'Continue', '2026-01-19 20:07:56'),
(64, 'S_d5162e23', 'power_no_boot_v1', 'n1', 'no', 'No', '2026-01-19 20:07:59'),
(65, 'S_d5162e23', 'power_no_boot_v1', 'n2', 'yes', 'Yes', '2026-01-19 20:08:04'),
(66, 'S_d5162e23', 'power_no_boot_v1', 'n3', 'no', 'No', '2026-01-19 20:08:08'),
(67, 'S_0b7f426c', 'power_no_boot_v1', 'intro', 'continue', 'Continue', '2026-01-19 20:09:59'),
(68, 'S_0b7f426c', 'power_no_boot_v1', 'n1', 'no', 'No', '2026-01-19 20:10:02'),
(69, 'S_0b7f426c', 'power_no_boot_v1', 'n2', 'yes', 'Yes', '2026-01-19 20:10:06'),
(70, 'S_0b7f426c', 'power_no_boot_v1', 'n3', 'yes', 'Yes', '2026-01-19 20:10:09'),
(71, 'S_a035c2fb', 'stuck_logo_v1', 'intro', 'continue', 'Continue', '2026-01-19 20:10:22'),
(72, 'S_a035c2fb', 'stuck_logo_v1', 'n1', 'no', 'No', '2026-01-19 20:10:27'),
(73, 'S_a035c2fb', 'stuck_logo_v1', 'n2', 'no', 'No / Not sure', '2026-01-19 20:10:31'),
(74, 'S_a035c2fb', 'stuck_logo_v1', 'n3', 'no', 'No', '2026-01-19 20:10:35'),
(75, 'S_e6297a98', 'keyboard_not_working_v1', 'intro', 'continue', 'Continue', '2026-01-19 20:28:53'),
(76, 'S_e6297a98', 'keyboard_not_working_v1', 'n1', 'external', 'External keyboard', '2026-01-19 20:29:07'),
(77, 'S_e6297a98', 'keyboard_not_working_v1', 'n2', 'none', 'None', '2026-01-19 20:29:11'),
(78, 'S_fd481153', 'power_no_boot_v1', 'intro', 'continue', 'Continue', '2026-01-19 20:35:28'),
(79, 'S_b08f9382', 'bsod_v1', 'intro', 'continue', 'Continue', '2026-01-20 10:51:37'),
(80, 'S_b08f9382', 'bsod_v1', 'n1', 'in_windows', 'Inside Windows', '2026-01-20 10:51:42'),
(81, 'S_b08f9382', 'bsod_v1', 'n2', 'no', 'No / Not sure', '2026-01-20 10:51:54'),
(82, 'S_b08f9382', 'bsod_v1', 'n3', 'has_code', 'Yes, I see a code', '2026-01-20 10:52:00'),
(83, 'S_c59df007', 'overheating_v1', 'intro', 'continue', 'Continue', '2026-01-20 10:55:28'),
(84, 'S_c59df007', 'overheating_v1', 'n1', 'anytime', 'Anytime', '2026-01-20 10:55:34'),
(85, 'S_c59df007', 'overheating_v1', 'n2', 'no', 'No / not sure', '2026-01-20 10:55:36'),
(86, 'S_6c78a9e0', 'app_crash_v1', 'intro', 'continue', 'Continue', '2026-01-20 19:09:17'),
(87, 'S_6c78a9e0', 'app_crash_v1', 'n1', 'many', 'Many apps', '2026-01-20 19:09:21'),
(88, 'S_6c78a9e0', 'app_crash_v1', 'n2', 'no', 'No / not sure', '2026-01-20 19:09:27'),
(89, 'S_bf61aadd', 'fan_noise_v1', 'intro', 'continue', 'Continue', '2026-01-20 19:17:43'),
(90, 'S_bf61aadd', 'fan_noise_v1', 'n1', 'air', 'Just loud airflow', '2026-01-20 19:17:57'),
(91, 'S_bf61aadd', 'fan_noise_v1', 'n2', 'yes', 'Yes', '2026-01-20 19:18:02'),
(92, 'S_42720029', 'virus_popups_v1', 'intro', 'continue', 'Continue', '2026-01-20 19:31:28'),
(93, 'S_42720029', 'virus_popups_v1', 'n1', 'no', 'No (only in browser)', '2026-01-20 19:31:33'),
(94, 'S_42720029', 'virus_popups_v1', 'n2', 'no', 'No / not sure', '2026-01-20 19:31:36'),
(95, 'S_66d77845', 'overheating_v1', 'intro', 'continue', 'Continue', '2026-01-20 19:32:14'),
(96, 'S_66d77845', 'overheating_v1', 'n1', 'anytime', 'Anytime', '2026-01-20 19:32:24'),
(97, 'S_66d77845', 'overheating_v1', 'n2', 'yes', 'Yes', '2026-01-20 19:32:27'),
(98, 'S_14361351', 'overheating_v1', 'intro', 'continue', 'Continue', '2026-01-20 19:32:54'),
(99, 'S_14361351', 'overheating_v1', 'n1', 'heavy', 'Heavy use', '2026-01-20 19:33:01'),
(100, 'S_14361351', 'overheating_v1', 'n2', 'no', 'No / not sure', '2026-01-20 19:33:04'),
(101, 'S_306bb8e3', 'bsod_v1', 'intro', 'continue', 'Continue', '2026-01-20 19:35:27'),
(102, 'S_306bb8e3', 'bsod_v1', 'n1', 'startup', 'Startup', '2026-01-20 19:35:31'),
(103, 'S_306bb8e3', 'bsod_v1', 'n2', 'no', 'No / Not sure', '2026-01-20 19:35:34'),
(104, 'S_306bb8e3', 'bsod_v1', 'n3', 'has_code', 'Yes, I see a code', '2026-01-20 19:35:40'),
(105, 'S_d171943f', 'power_no_boot_v1', 'intro', 'continue', 'Continue', '2026-01-20 19:41:54'),
(106, 'S_d171943f', 'power_no_boot_v1', 'n1', 'no', 'No', '2026-01-20 19:42:07'),
(107, 'S_d171943f', 'power_no_boot_v1', 'n2', 'no', 'No / Not sure', '2026-01-20 19:42:09'),
(108, 'S_0382872e', 'power_no_boot_v1', 'intro', 'continue', 'Continue', '2026-01-20 20:00:14'),
(109, 'S_0382872e', 'power_no_boot_v1', 'n1', 'no', 'No', '2026-01-20 20:00:18'),
(110, 'S_0382872e', 'power_no_boot_v1', 'n2', 'no', 'No / Not sure', '2026-01-20 20:00:31'),
(111, 'S_e1fa0e42', 'power_no_boot_v1', 'intro', 'continue', 'Continue', '2026-01-20 20:02:14'),
(112, 'S_277c6819', 'bsod_v1', 'intro', 'continue', 'Continue', '2026-01-20 20:02:29'),
(113, 'S_277c6819', 'bsod_v1', 'n1', 'in_windows', 'Inside Windows', '2026-01-20 20:02:32'),
(114, 'S_277c6819', 'bsod_v1', 'n2', 'no', 'No / Not sure', '2026-01-20 20:02:35'),
(115, 'S_277c6819', 'bsod_v1', 'n3', 'has_code', 'Yes, I see a code', '2026-01-20 20:02:37'),
(116, 'S_13d01393', 'power_no_boot_v1', 'intro', 'continue', 'Continue', '2026-01-20 20:27:13'),
(117, 'S_13d01393', 'power_no_boot_v1', 'n1', 'yes', 'Yes', '2026-01-20 20:27:17'),
(118, 'S_13d01393', 'power_no_boot_v1', 'n2', 'yes', 'Yes', '2026-01-20 20:27:23'),
(119, 'S_13d01393', 'power_no_boot_v1', 'n3', 'no', 'No', '2026-01-20 20:27:25'),
(120, 'S_950106a4', 'keyboard_not_working_v1', 'intro', 'continue', 'Continue', '2026-01-20 20:30:34'),
(121, 'S_950106a4', 'keyboard_not_working_v1', 'n1', 'laptop', 'Laptop built-in', '2026-01-20 20:30:54'),
(122, 'S_950106a4', 'keyboard_not_working_v1', 'n2', 'none', 'None', '2026-01-20 20:30:57'),
(123, 'S_15313435', 'no_internet_on_pc_v1', 'intro', 'continue', 'Continue', '2026-01-20 20:41:02'),
(124, 'S_15313435', 'no_internet_on_pc_v1', 'n1', 'yes', 'Yes, others work', '2026-01-20 20:41:11'),
(125, 'S_15313435', 'no_internet_on_pc_v1', 'n2', 'lan', 'LAN cable', '2026-01-20 20:41:16'),
(126, 'S_15313435', 'no_internet_on_pc_v1', 'n3', 'no', 'No / not sure', '2026-01-20 20:41:21'),
(127, 'S_52a19673', 'beeping_sound_v1', 'intro', 'continue', 'Continue', '2026-01-20 20:41:59'),
(128, 'S_52a19673', 'beeping_sound_v1', 'n1', 'no', 'No', '2026-01-20 20:42:03'),
(129, 'S_52a19673', 'beeping_sound_v1', 'n3', 'no_display', 'No display', '2026-01-20 20:42:10'),
(130, 'S_c53f98c3', 'power_no_boot_v1', 'intro', 'continue', 'Continue', '2026-01-20 21:14:35'),
(131, 'S_c53f98c3', 'power_no_boot_v1', 'n1', 'yes', 'Yes', '2026-01-20 21:14:36'),
(132, 'S_c53f98c3', 'power_no_boot_v1', 'n2', 'yes', 'Yes', '2026-01-20 21:14:40'),
(133, 'S_c53f98c3', 'power_no_boot_v1', 'n3', 'yes', 'Yes', '2026-01-20 21:14:44'),
(134, 'S_6ddaf6f4', 'power_no_boot_v1', 'intro', 'continue', 'Continue', '2026-01-20 21:14:56'),
(135, 'S_6ddaf6f4', 'power_no_boot_v1', 'n1', 'no', 'No', '2026-01-20 21:15:02'),
(136, 'S_6ddaf6f4', 'power_no_boot_v1', 'n2', 'yes', 'Yes', '2026-01-20 21:15:06'),
(137, 'S_6ddaf6f4', 'power_no_boot_v1', 'n3', 'no', 'No', '2026-01-20 21:15:10'),
(138, 'S_ea97d7dc', 'power_no_boot_v1', 'intro', 'continue', 'Continue', '2026-01-20 21:16:03'),
(139, 'S_ea97d7dc', 'power_no_boot_v1', 'n1', 'yes', 'Yes', '2026-01-20 21:16:08'),
(140, 'S_ea97d7dc', 'power_no_boot_v1', 'n2', 'no', 'No / Not sure', '2026-01-20 21:16:10'),
(141, 'S_bd7984cf', 'power_no_boot_v1', 'intro', 'continue', 'Continue', '2026-01-21 05:11:26'),
(142, 'S_bd7984cf', 'power_no_boot_v1', 'n1', 'no', 'No', '2026-01-21 05:11:28'),
(143, 'S_bd7984cf', 'power_no_boot_v1', 'n2', 'yes', 'Yes', '2026-01-21 05:11:33'),
(144, 'S_bd7984cf', 'power_no_boot_v1', 'n3', 'no', 'No', '2026-01-21 05:11:37'),
(145, 'S_94c5b128', 'no_boot_device_v1', 'intro', 'continue', 'Continue', '2026-01-21 05:13:19'),
(146, 'S_94c5b128', 'no_boot_device_v1', 'n1', 'yes', 'Yes, suddenly', '2026-01-21 05:13:27'),
(147, 'S_94c5b128', 'no_boot_device_v1', 'n2', 'no', 'No', '2026-01-21 05:13:33'),
(148, 'S_56417c39', 'power_no_boot_v1', 'intro', 'continue', 'Continue', '2026-01-21 05:32:28'),
(149, 'S_56417c39', 'power_no_boot_v1', 'n1', 'no', 'No', '2026-01-21 05:32:33'),
(150, 'S_56417c39', 'power_no_boot_v1', 'n2', 'yes', 'Yes', '2026-01-21 05:32:38'),
(151, 'S_56417c39', 'power_no_boot_v1', 'n3', 'no', 'No', '2026-01-21 05:32:41'),
(152, 'S_bb541bd4', 'fan_noise_v1', 'intro', 'continue', 'Continue', '2026-01-21 05:33:10'),
(153, 'S_bb541bd4', 'fan_noise_v1', 'n1', 'grind', 'Grinding/clicking', '2026-01-21 05:33:16'),
(154, 'S_bb541bd4', 'fan_noise_v1', 'n2', 'yes', 'Yes', '2026-01-21 05:33:20'),
(155, 'S_d29dd5c7', 'power_no_boot_v1', 'intro', 'continue', 'Continue', '2026-01-21 06:01:59'),
(156, 'S_d29dd5c7', 'power_no_boot_v1', 'n1', 'no', 'No', '2026-01-21 06:02:00'),
(157, 'S_d29dd5c7', 'power_no_boot_v1', 'n2', 'yes', 'Yes', '2026-01-21 06:02:05'),
(158, 'S_d29dd5c7', 'power_no_boot_v1', 'n3', 'no', 'No', '2026-01-21 06:02:08'),
(159, 'S_f6fa0926', 'power_no_boot_v1', 'intro', 'continue', 'Continue', '2026-01-21 10:29:03'),
(160, 'S_f6fa0926', 'power_no_boot_v1', 'n1', 'no', 'No', '2026-01-21 10:29:05'),
(161, 'S_f6fa0926', 'power_no_boot_v1', 'n2', 'yes', 'Yes', '2026-01-21 10:29:13'),
(162, 'S_f6fa0926', 'power_no_boot_v1', 'n3', 'no', 'No', '2026-01-21 10:29:20'),
(163, 'S_6b20e6b9', 'power_no_boot_v1', 'intro', 'continue', 'Continue', '2026-01-21 10:29:31'),
(164, 'S_6b20e6b9', 'power_no_boot_v1', 'n1', 'yes', 'Yes', '2026-01-21 10:29:35'),
(165, 'S_96be4c4b', 'power_no_boot_v1', 'intro', 'continue', 'Continue', '2026-01-21 10:29:47'),
(166, 'S_96be4c4b', 'power_no_boot_v1', 'n1', 'no', 'No', '2026-01-21 10:29:52'),
(167, 'S_96be4c4b', 'power_no_boot_v1', 'n2', 'yes', 'Yes', '2026-01-21 10:30:00'),
(168, 'S_96be4c4b', 'power_no_boot_v1', 'n3', 'no', 'No', '2026-01-21 10:30:10'),
(169, 'S_95c9aee1', 'power_no_boot_v1', 'intro', 'continue', 'Continue', '2026-01-21 10:30:55'),
(170, 'S_95c9aee1', 'power_no_boot_v1', 'n1', 'no', 'No', '2026-01-21 10:30:58'),
(171, 'S_95c9aee1', 'power_no_boot_v1', 'n2', 'yes', 'Yes', '2026-01-21 10:31:02'),
(172, 'S_95c9aee1', 'power_no_boot_v1', 'n3', 'yes', 'Yes', '2026-01-21 10:31:05'),
(173, 'S_27c9ecfe', 'no_boot_device_v1', 'intro', 'continue', 'Continue', '2026-01-21 10:31:37'),
(174, 'S_27c9ecfe', 'no_boot_device_v1', 'n1', 'yes', 'Yes, suddenly', '2026-01-21 10:31:43'),
(175, 'S_27c9ecfe', 'no_boot_device_v1', 'n2', 'no', 'No', '2026-01-21 10:31:48'),
(176, 'S_46d6fe47', 'no_boot_device_v1', 'intro', 'continue', 'Continue', '2026-01-21 11:02:34'),
(177, 'S_5598e6f6', 'battery_not_charging_v1', 'intro', 'continue', 'Continue', '2026-01-21 14:33:52'),
(178, 'S_5598e6f6', 'battery_not_charging_v1', 'n1', 'no', 'No', '2026-01-21 14:33:56'),
(179, 'S_4e61ae86', 'power_no_boot_v1', 'intro', 'continue', 'Continue', '2026-01-22 13:07:44'),
(180, 'S_4e61ae86', 'power_no_boot_v1', 'n1', 'no', 'No', '2026-01-22 13:07:47'),
(181, 'S_4e61ae86', 'power_no_boot_v1', 'n2', 'yes', 'Yes', '2026-01-22 13:07:51'),
(182, 'S_4e61ae86', 'power_no_boot_v1', 'n3', 'yes', 'Yes', '2026-01-22 13:07:54'),
(183, 'S_0049552d', 'overheating_v1', 'intro', 'continue', 'Continue', '2026-01-22 13:08:09'),
(184, 'S_0049552d', 'overheating_v1', 'n1', 'anytime', 'Anytime', '2026-01-22 13:08:15'),
(185, 'S_0049552d', 'overheating_v1', 'n2', 'no', 'No / not sure', '2026-01-22 13:08:20');

-- --------------------------------------------------------

--
-- Table structure for table `answer_logs`
--

CREATE TABLE `answer_logs` (
  `id` int(11) NOT NULL,
  `session_id` varchar(100) NOT NULL,
  `module_id` varchar(100) NOT NULL,
  `node_id` varchar(100) NOT NULL,
  `answer_id` varchar(100) NOT NULL,
  `answer_label` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `answer_logs`
--

INSERT INTO `answer_logs` (`id`, `session_id`, `module_id`, `node_id`, `answer_id`, `answer_label`, `created_at`) VALUES
(1, 'S_1208d075', 'power_no_boot_v1', 'intro', 'continue', 'Continue', '2026-01-22 18:42:33'),
(2, 'S_1208d075', 'power_no_boot_v1', 'n1', 'no', 'No', '2026-01-22 18:42:34'),
(3, 'S_1208d075', 'power_no_boot_v1', 'n2', 'no', 'No / Not sure', '2026-01-22 18:42:35'),
(4, 'S_af8cfa74', 'power_no_boot_v1', 'intro', 'continue', 'Continue', '2026-01-22 20:00:52'),
(5, 'S_af8cfa74', 'power_no_boot_v1', 'n1', 'yes', 'Yes', '2026-01-22 20:01:00'),
(6, 'S_af8cfa74', 'power_no_boot_v1', 'n2', 'no', 'No / Not sure', '2026-01-22 20:01:01'),
(7, 'S_6b5c34cf', 'power_no_boot_v1', 'intro', 'continue', 'Continue', '2026-01-22 20:21:36'),
(8, 'S_6b5c34cf', 'power_no_boot_v1', 'n1', 'no', 'No', '2026-01-22 20:21:38'),
(9, 'S_6b5c34cf', 'power_no_boot_v1', 'n2', 'yes', 'Yes', '2026-01-22 20:21:39'),
(10, 'S_6b5c34cf', 'power_no_boot_v1', 'n3', 'yes', 'Yes', '2026-01-22 20:21:41'),
(11, 'S_34ccf4dd', 'overheating_v1', 'intro', 'continue', 'Continue', '2026-01-23 07:04:17'),
(12, 'S_34ccf4dd', 'overheating_v1', 'n1', 'anytime', 'Anytime', '2026-01-23 07:04:28'),
(13, 'S_34ccf4dd', 'overheating_v1', 'n2', 'yes', 'Yes', '2026-01-23 07:04:34'),
(14, 'S_b83b8a27', 'power_no_boot_v1', 'intro', 'continue', 'Continue', '2026-01-23 07:07:16'),
(15, 'S_b83b8a27', 'power_no_boot_v1', 'n1', 'no', 'No', '2026-01-23 07:07:18'),
(16, 'S_b83b8a27', 'power_no_boot_v1', 'n2', 'yes', 'Yes', '2026-01-23 07:07:21'),
(17, 'S_b83b8a27', 'power_no_boot_v1', 'n3', 'yes', 'Yes', '2026-01-23 07:07:26'),
(18, 'S_baea787c', 'bsod_v1', 'intro', 'continue', 'Continue', '2026-01-23 07:07:53'),
(19, 'S_baea787c', 'bsod_v1', 'n1', 'in_windows', 'Inside Windows', '2026-01-23 07:08:05'),
(20, 'S_baea787c', 'bsod_v1', 'n2', 'no', 'No / Not sure', '2026-01-23 07:08:09'),
(21, 'S_baea787c', 'bsod_v1', 'n3', 'has_code', 'Yes, I see a code', '2026-01-23 07:08:15'),
(22, 'S_41cbf088', 'bsod_v1', 'intro', 'continue', 'Continue', '2026-01-23 07:08:24'),
(23, 'S_41cbf088', 'bsod_v1', 'n1', 'in_windows', 'Inside Windows', '2026-01-23 07:08:26'),
(24, 'S_41cbf088', 'bsod_v1', 'n2', 'no', 'No / Not sure', '2026-01-23 07:08:28'),
(25, 'S_41cbf088', 'bsod_v1', 'n3', 'no_code', 'No / unsure', '2026-01-23 07:08:31'),
(26, 'S_f8a816cc', 'keyboard_not_working_v1', 'intro', 'continue', 'Continue', '2026-01-26 16:14:57'),
(27, 'S_f8a816cc', 'keyboard_not_working_v1', 'n1', 'laptop', 'Laptop built-in', '2026-01-26 16:15:02'),
(28, 'S_f8a816cc', 'keyboard_not_working_v1', 'n2', 'some', 'Some keys', '2026-01-26 16:15:07'),
(29, 'S_cbe3dd45', 'power_no_boot_v1', 'intro', 'continue', 'Continue', '2026-01-26 17:19:02'),
(30, 'S_cbe3dd45', 'power_no_boot_v1', 'n1', 'no', 'No', '2026-01-26 17:19:05'),
(31, 'S_cbe3dd45', 'power_no_boot_v1', 'n2', 'yes', 'Yes', '2026-01-26 17:19:10'),
(32, 'S_cbe3dd45', 'power_no_boot_v1', 'n3', 'yes', 'Yes', '2026-01-26 17:19:13'),
(33, 'S_26d98433', 'bsod_v1', 'intro', 'continue', 'Continue', '2026-01-26 17:19:21'),
(34, 'S_26d98433', 'bsod_v1', 'n1', 'startup', 'Startup', '2026-01-26 17:19:29'),
(35, 'S_26d98433', 'bsod_v1', 'n2', 'no', 'No / Not sure', '2026-01-26 17:19:46'),
(36, 'S_26d98433', 'bsod_v1', 'n3', 'has_code', 'Yes, I see a code', '2026-01-26 17:19:53'),
(37, 'S_93f94f0a', 'bsod_v1', 'intro', 'continue', 'Continue', '2026-01-26 17:20:02'),
(38, 'S_93f94f0a', 'bsod_v1', 'n1', 'startup', 'Startup', '2026-01-26 17:20:04'),
(39, 'S_93f94f0a', 'bsod_v1', 'n2', 'no', 'No / Not sure', '2026-01-26 17:20:07'),
(40, 'S_93f94f0a', 'bsod_v1', 'n3', 'no_code', 'No / unsure', '2026-01-26 17:20:09'),
(41, 'S_a6e71aae', 'overheating_v1', 'intro', 'continue', 'Continue', '2026-01-26 18:21:21'),
(42, 'S_a6e71aae', 'overheating_v1', 'n1', 'anytime', 'Anytime', '2026-01-26 18:21:37'),
(43, 'S_a6e71aae', 'overheating_v1', 'n2', 'no', 'No / not sure', '2026-01-26 18:21:40'),
(44, 'S_d6899bf0', 'battery_not_charging_v1', 'intro', 'continue', 'Continue', '2026-01-28 18:56:50'),
(45, 'S_d6899bf0', 'battery_not_charging_v1', 'n1', 'no', 'No', '2026-01-28 18:56:56'),
(46, 'S_c415bcb0', 'power_no_boot_v1', 'intro', 'continue', 'Continue', '2026-02-15 18:44:39'),
(47, 'S_c415bcb0', 'power_no_boot_v1', 'n1', 'yes', 'Yes', '2026-02-15 18:44:41'),
(48, 'S_c415bcb0', 'power_no_boot_v1', 'n2', 'no', 'No / Not sure', '2026-02-15 18:44:43'),
(49, 'S_593bfdee', 'overheating_v1', 'intro', 'continue', 'Continue', '2026-02-15 18:52:14'),
(50, 'S_593bfdee', 'overheating_v1', 'n1', 'heavy', 'Heavy use', '2026-02-15 18:52:20'),
(51, 'S_593bfdee', 'overheating_v1', 'n2', 'no', 'No / not sure', '2026-02-15 18:52:24'),
(52, 'S_1b026851', 'overheating_v1', 'intro', 'continue', 'Continue', '2026-02-15 19:25:16'),
(53, 'S_1b026851', 'overheating_v1', 'n1', 'heavy', 'Heavy use', '2026-02-15 19:25:19'),
(54, 'S_1b026851', 'overheating_v1', 'n2', 'no', 'No / not sure', '2026-02-15 19:25:20'),
(55, 'S_6e91a2a5', 'virus_popups_v1', 'intro', 'continue', 'Continue', '2026-02-15 19:45:26'),
(56, 'S_6e91a2a5', 'virus_popups_v1', 'n1', 'no', 'No (only in browser)', '2026-02-15 19:45:34'),
(57, 'S_6e91a2a5', 'virus_popups_v1', 'n2', 'no', 'No / not sure', '2026-02-15 19:45:37'),
(58, 'S_3595baff', 'overheating_v1', 'intro', 'continue', 'Continue', '2026-02-15 19:45:58'),
(59, 'S_3595baff', 'overheating_v1', 'n1', 'anytime', 'Anytime', '2026-02-15 19:46:02'),
(60, 'S_3595baff', 'overheating_v1', 'n2', 'no', 'No / not sure', '2026-02-15 19:46:05'),
(61, 'S_de6a1b3f', 'overheating_v1', 'intro', 'continue', 'Continue', '2026-02-15 21:25:26'),
(62, 'S_de6a1b3f', 'overheating_v1', 'n1', 'heavy', 'Heavy use', '2026-02-15 21:25:34'),
(63, 'S_de6a1b3f', 'overheating_v1', 'n2', 'no', 'No / not sure', '2026-02-15 21:25:37'),
(64, 'S_7dd8c249', 'overheating_v1', 'intro', 'continue', 'Continue', '2026-02-15 21:39:10'),
(65, 'S_7dd8c249', 'overheating_v1', 'n1', 'anytime', 'Anytime', '2026-02-15 21:39:12'),
(66, 'S_7dd8c249', 'overheating_v1', 'n2', 'no', 'No / not sure', '2026-02-15 21:39:14'),
(67, 'S_fc35d458', 'power_no_boot_v1', 'intro', 'continue', 'Continue', '2026-02-15 21:44:08'),
(68, 'S_fc35d458', 'power_no_boot_v1', 'n1', 'yes', 'Yes', '2026-02-15 21:44:11'),
(69, 'S_fc35d458', 'power_no_boot_v1', 'n2', 'no', 'No / Not sure', '2026-02-15 21:44:12'),
(70, 'S_98b37bf0', 'fan_noise_v1', 'intro', 'continue', 'Continue', '2026-02-15 22:28:11'),
(71, 'S_98b37bf0', 'fan_noise_v1', 'n1', 'air', 'Just loud airflow', '2026-02-15 22:28:22'),
(72, 'S_98b37bf0', 'fan_noise_v1', 'n2', 'no', 'No', '2026-02-15 22:28:28'),
(73, 'S_a8e36067', 'battery_not_charging_v1', 'intro', 'continue', 'Continue', '2026-02-15 22:28:54'),
(74, 'S_a8e36067', 'battery_not_charging_v1', 'n1', 'no', 'No', '2026-02-15 22:29:01'),
(75, 'S_bedc5ec4', 'fan_noise_v1', 'intro', 'continue', 'Continue', '2026-02-15 23:21:35'),
(76, 'S_bedc5ec4', 'fan_noise_v1', 'n1', 'air', 'Just loud airflow', '2026-02-15 23:21:37'),
(77, 'S_bedc5ec4', 'fan_noise_v1', 'n2', 'yes', 'Yes', '2026-02-15 23:21:40'),
(78, 'S_b0f4b53d', 'power_no_boot_v1', 'intro', 'continue', 'Continue', '2026-02-15 23:35:00'),
(79, 'S_b0f4b53d', 'power_no_boot_v1', 'n1', 'no', 'No', '2026-02-15 23:35:01'),
(80, 'S_b0f4b53d', 'power_no_boot_v1', 'n2', 'no', 'No / Not sure', '2026-02-15 23:35:03'),
(81, 'S_0b8269f0', 'power_no_boot_v1', 'intro', 'continue', 'Continue', '2026-02-16 17:40:18'),
(82, 'S_0b8269f0', 'power_no_boot_v1', 'n1', 'no', 'No', '2026-02-16 17:40:25'),
(83, 'S_0b8269f0', 'power_no_boot_v1', 'n2', 'yes', 'Yes', '2026-02-16 17:40:31'),
(84, 'S_0b8269f0', 'power_no_boot_v1', 'n3', 'no', 'No', '2026-02-16 17:40:36'),
(85, 'S_4adde245', 'fan_noise_v1', 'intro', 'continue', 'Continue', '2026-02-16 17:40:47'),
(86, 'S_4adde245', 'fan_noise_v1', 'n1', 'air', 'Just loud airflow', '2026-02-16 17:40:52'),
(87, 'S_4adde245', 'fan_noise_v1', 'n2', 'yes', 'Yes', '2026-02-16 17:40:56'),
(88, 'S_915e7ef1', 'overheating_v1', 'intro', 'continue', 'Continue', '2026-02-16 17:59:37'),
(89, 'S_915e7ef1', 'overheating_v1', 'n1', 'anytime', 'Anytime', '2026-02-16 17:59:39'),
(90, 'S_915e7ef1', 'overheating_v1', 'n2', 'yes', 'Yes', '2026-02-16 17:59:43'),
(91, 'S_7ba7a24f', 'overheating_v1', 'intro', 'continue', 'Continue', '2026-02-16 18:00:01'),
(92, 'S_7ba7a24f', 'overheating_v1', 'n1', 'heavy', 'Heavy use', '2026-02-16 18:00:06'),
(93, 'S_7ba7a24f', 'overheating_v1', 'n2', 'no', 'No / not sure', '2026-02-16 18:00:10'),
(94, 'S_466c7698', 'power_no_boot_v1', 'intro', 'continue', 'Continue', '2026-02-16 18:00:50'),
(95, 'S_466c7698', 'power_no_boot_v1', 'n1', 'no', 'No', '2026-02-16 18:00:56'),
(96, 'S_466c7698', 'power_no_boot_v1', 'n2', 'yes', 'Yes', '2026-02-16 18:00:59'),
(97, 'S_466c7698', 'power_no_boot_v1', 'n3', 'yes', 'Yes', '2026-02-16 18:01:02'),
(98, 'S_c93507d6', 'overheating_v1', 'intro', 'continue', 'Continue', '2026-02-16 19:46:45'),
(99, 'S_c93507d6', 'overheating_v1', 'n1', 'heavy', 'Heavy use', '2026-02-16 19:46:48'),
(100, 'S_c93507d6', 'overheating_v1', 'n2', 'no', 'No / not sure', '2026-02-16 19:47:00'),
(101, 'S_99368dab', 'power_no_boot_v1', 'intro', 'continue', 'Continue', '2026-02-16 21:17:33'),
(102, 'S_8b68288f', 'overheating_v1', 'intro', 'continue', 'Continue', '2026-02-16 21:22:55'),
(103, 'S_8b68288f', 'overheating_v1', 'n1', 'anytime', 'Anytime', '2026-02-16 21:22:59'),
(104, 'S_8b68288f', 'overheating_v1', 'n2', 'no', 'No / not sure', '2026-02-16 21:23:02'),
(105, 'S_c94e1d9e', 'power_no_boot_v1', 'intro', 'continue', 'Continue', '2026-02-16 21:23:52'),
(106, 'S_c94e1d9e', 'power_no_boot_v1', 'n1', 'no', 'No', '2026-02-16 21:23:53'),
(107, 'S_c94e1d9e', 'power_no_boot_v1', 'n2', 'no', 'No / Not sure', '2026-02-16 21:23:55'),
(108, 'S_84c5e48f', 'fan_noise_v1', 'intro', 'continue', 'Continue', '2026-03-03 13:20:58'),
(109, 'S_84c5e48f', 'fan_noise_v1', 'n1', 'grind', 'Grinding/clicking', '2026-03-03 13:21:04'),
(110, 'S_84c5e48f', 'fan_noise_v1', 'n2', 'yes', 'Yes', '2026-03-03 13:21:09');

-- --------------------------------------------------------

--
-- Table structure for table `modules`
--

CREATE TABLE `modules` (
  `id` int(11) NOT NULL,
  `module_id` varchar(100) NOT NULL,
  `title` varchar(255) NOT NULL,
  `category_id` varchar(100) NOT NULL,
  `category_title` varchar(255) NOT NULL,
  `start_node_id` varchar(100) NOT NULL DEFAULT 'n1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `modules`
--

INSERT INTO `modules` (`id`, `module_id`, `title`, `category_id`, `category_title`, `start_node_id`) VALUES
(1, 'power_no_boot_v1', 'System Not Powering On', 'laptops_desktops', 'Laptops / Desktops', 'intro'),
(3, 'power_on_no_display_v1', 'Powers On But No Display', 'laptops_desktops', 'Laptops / Desktops', 'intro'),
(4, 'boot_loop_v1', 'Boot Loop / Keeps Restarting', 'laptops_desktops', 'Laptops / Desktops', 'intro'),
(5, 'no_boot_device_v1', 'No Bootable Device / Disk Not Found', 'laptops_desktops', 'Laptops / Desktops', 'intro'),
(6, 'stuck_logo_v1', 'Stuck on Logo / Loading Screen', 'laptops_desktops', 'Laptops / Desktops', 'intro'),
(7, 'beeping_sound_v1', 'Beeping / Sound on Startup', 'laptops_desktops', 'Laptops / Desktops', 'intro'),
(8, 'bsod_v1', 'Windows Blue Screen (BSOD)', 'laptops_desktops', 'Laptops / Desktops', 'intro'),
(9, 'slow_dragging_v1', 'Slow / Hanging / Dragging', 'laptops_desktops', 'Laptops / Desktops', 'intro'),
(10, 'no_internet_on_pc_v1', 'Internet Not Working on PC', 'laptops_desktops', 'Laptops / Desktops', 'intro'),
(11, 'windows_update_fail_v1', 'Windows Update Stuck / Failing', 'laptops_desktops', 'Laptops / Desktops', 'intro'),
(12, 'app_crash_v1', 'Apps Not Opening / Crashing', 'laptops_desktops', 'Laptops / Desktops', 'intro'),
(13, 'virus_popups_v1', 'Virus / Pop-ups / Redirects', 'laptops_desktops', 'Laptops / Desktops', 'intro'),
(14, 'overheating_v1', 'Overheating / Auto Shutdown', 'laptops_desktops', 'Laptops / Desktops', 'intro'),
(15, 'fan_noise_v1', 'Loud Fan / Strange Noise', 'laptops_desktops', 'Laptops / Desktops', 'intro'),
(16, 'battery_not_charging_v1', 'Battery Not Charging', 'laptops_desktops', 'Laptops / Desktops', 'intro'),
(17, 'keyboard_not_working_v1', 'Keyboard Issues', 'laptops_desktops', 'Laptops / Desktops', 'intro'),
(18, 'no_audio_v1', 'No Sound / Audio Issues', 'laptops_desktops', 'Laptops / Desktops', 'intro'),
(19, 'usb_ports_v1', 'USB Ports Not Working', 'laptops_desktops', 'Laptops / Desktops', 'intro');

-- --------------------------------------------------------

--
-- Table structure for table `nodes`
--

CREATE TABLE `nodes` (
  `id` int(11) NOT NULL,
  `module_id` varchar(100) NOT NULL,
  `node_id` varchar(100) NOT NULL,
  `message` text NOT NULL,
  `is_final` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `nodes`
--

INSERT INTO `nodes` (`id`, `module_id`, `node_id`, `message`, `is_final`) VALUES
(239, 'power_no_boot_v1', 'intro', 'Welcome 👋 I will help diagnose why the system is not powering on. Click Continue to start.', 0),
(240, 'power_no_boot_v1', 'n1', 'Do you see any power light or sign of life?', 0),
(241, 'power_no_boot_v1', 'n2', 'Is the charger/adapter plugged in firmly and working?', 0),
(242, 'power_no_boot_v1', 'n3', 'Is the battery removable?', 0),
(243, 'power_no_boot_v1', 'f_free', 'Try basic power reset steps.', 1),
(244, 'power_no_boot_v1', 'f_refer', 'Likely DC jack/motherboard power rail/adapter fault. Technician recommended.', 1),
(245, 'power_on_no_display_v1', 'intro', 'Welcome 👋 Let’s troubleshoot “powers on but no display”. Click Continue.', 0),
(246, 'power_on_no_display_v1', 'n1', 'Is it a laptop or desktop?', 0),
(247, 'power_on_no_display_v1', 'n2', 'Do you see faint image/backlight or any logo?', 0),
(248, 'power_on_no_display_v1', 'n3', 'Have you tested with an external monitor (HDMI/VGA)?', 0),
(249, 'power_on_no_display_v1', 'f_backlight', 'Backlight/brightness issue suspected.', 1),
(250, 'power_on_no_display_v1', 'f_screen', 'Laptop screen/cable issue likely.', 1),
(251, 'power_on_no_display_v1', 'f_ram', 'RAM/init issue suspected.', 1),
(252, 'boot_loop_v1', 'intro', 'Welcome 👋 We’ll diagnose why the PC keeps restarting/boot looping. Click Continue.', 0),
(253, 'boot_loop_v1', 'n1', 'Does it restart before Windows loads?', 0),
(254, 'boot_loop_v1', 'n2', 'Did this start after an update/driver install?', 0),
(255, 'boot_loop_v1', 'n3', 'Can you enter Safe Mode?', 0),
(256, 'boot_loop_v1', 'f_free', 'Try safe mode + repair steps.', 1),
(257, 'boot_loop_v1', 'f_refer', 'Possible hardware (overheat/RAM/SSD) issue. Technician recommended.', 1),
(258, 'no_boot_device_v1', 'intro', 'Welcome 👋 “No bootable device” usually means the system can’t see the OS drive. Click Continue.', 0),
(259, 'no_boot_device_v1', 'n1', 'Did it work before and suddenly started?', 0),
(260, 'no_boot_device_v1', 'n2', 'Can you see the SSD/HDD in BIOS?', 0),
(261, 'no_boot_device_v1', 'f_bios_fix', 'Try BIOS boot order/basic checks.', 1),
(262, 'no_boot_device_v1', 'f_refer', 'Drive/cable/OS repair needed (technician).', 1),
(263, 'stuck_logo_v1', 'intro', 'Welcome 👋 Let’s fix “stuck on logo/loading screen”. Click Continue.', 0),
(264, 'stuck_logo_v1', 'n1', 'Does it reach Windows login screen?', 0),
(265, 'stuck_logo_v1', 'n2', 'Did it start after update/new software?', 0),
(266, 'stuck_logo_v1', 'n3', 'Can you enter Safe Mode?', 0),
(267, 'stuck_logo_v1', 'f_free', 'Try Safe Mode + repair.', 1),
(268, 'stuck_logo_v1', 'f_refer', 'Possible disk/RAM issue. Technician recommended.', 1),
(269, 'beeping_sound_v1', 'intro', 'Welcome 👋 Startup beeps usually indicate a hardware warning. Click Continue.', 0),
(270, 'beeping_sound_v1', 'n1', 'Can the system boot into Windows?', 0),
(271, 'beeping_sound_v1', 'n2', 'Do keyboard keys act strange / typing by itself?', 0),
(272, 'beeping_sound_v1', 'n3', 'Do you have any display at all?', 0),
(273, 'beeping_sound_v1', 'f_keyboard', 'Likely keyboard stuck key / fault (common laptop).', 1),
(274, 'beeping_sound_v1', 'f_ram', 'Possible RAM seating/failure.', 1),
(275, 'beeping_sound_v1', 'f_refer', 'Needs hardware diagnosis (beep pattern).', 1),
(276, 'bsod_v1', 'intro', 'Welcome 👋 Let’s diagnose Windows Blue Screen (BSOD). Click Continue.', 0),
(277, 'bsod_v1', 'n1', 'Is the BSOD happening during startup or while using Windows?', 0),
(278, 'bsod_v1', 'n2', 'Did it start after a driver/update install?', 0),
(279, 'bsod_v1', 'n3', 'Do you see a specific stop code (e.g., MEMORY_MANAGEMENT)?', 0),
(280, 'bsod_v1', 'f_free', 'Try driver/update rollback and system repair.', 1),
(281, 'bsod_v1', 'f_refer', 'Possible RAM/SSD/hardware issue. Technician recommended.', 1),
(282, 'slow_dragging_v1', 'intro', 'Welcome 👋 Let’s find out why the PC is slow/hanging. Click Continue.', 0),
(283, 'slow_dragging_v1', 'n1', 'When did the slowness start?', 0),
(284, 'slow_dragging_v1', 'n2', 'Does Task Manager show 100% Disk often?', 0),
(285, 'slow_dragging_v1', 'n3', 'Is storage SSD or HDD?', 0),
(286, 'slow_dragging_v1', 'n4', 'Any pop-ups/unknown programs?', 0),
(287, 'slow_dragging_v1', 'f_free', 'General speed-up steps.', 1),
(288, 'slow_dragging_v1', 'f_upgrade', 'HDD bottleneck—SSD upgrade recommended.', 1),
(289, 'slow_dragging_v1', 'f_malware', 'Possible malware/adware.', 1),
(290, 'no_internet_on_pc_v1', 'intro', 'Welcome 👋 Let’s fix “Internet not working on PC”. Click Continue.', 0),
(291, 'no_internet_on_pc_v1', 'n1', 'Are other devices on the same Wi-Fi/LAN working?', 0),
(292, 'no_internet_on_pc_v1', 'n2', 'Is it Wi-Fi or LAN cable?', 0),
(293, 'no_internet_on_pc_v1', 'n3', 'Do you see “No internet” or “Limited” on the PC?', 0),
(294, 'no_internet_on_pc_v1', 'f_router', 'Router/ISP issue likely.', 1),
(295, 'no_internet_on_pc_v1', 'f_pc_fix', 'PC network reset steps.', 1),
(296, 'windows_update_fail_v1', 'intro', 'Welcome 👋 Let’s fix Windows Update stuck/failing. Click Continue.', 0),
(297, 'windows_update_fail_v1', 'n1', 'Is it stuck downloading, installing, or reboot loop?', 0),
(298, 'windows_update_fail_v1', 'n2', 'Do you have enough free space (15GB+)?', 0),
(299, 'windows_update_fail_v1', 'f_free', 'Try Windows Update repair steps.', 1),
(300, 'windows_update_fail_v1', 'f_refer', 'If corruption persists, technician repair install may be needed.', 1),
(301, 'app_crash_v1', 'intro', 'Welcome 👋 I’ll help diagnose why apps are not opening or crashing. Click Continue.', 0),
(302, 'app_crash_v1', 'n1', 'Is it one app only, or many apps?', 0),
(303, 'app_crash_v1', 'n2', 'Did it start after update/new install?', 0),
(304, 'app_crash_v1', 'f_app_fix', 'App-level fixes.', 1),
(305, 'app_crash_v1', 'f_system_fix', 'System-level repair needed.', 1),
(306, 'virus_popups_v1', 'intro', 'Welcome 👋 Let’s handle pop-ups/redirects safely. Click Continue.', 0),
(307, 'virus_popups_v1', 'n1', 'Are you seeing pop-ups even when browser is closed?', 0),
(308, 'virus_popups_v1', 'n2', 'Did you install any free software recently?', 0),
(309, 'virus_popups_v1', 'f_free', 'Basic malware cleanup steps.', 1),
(310, 'virus_popups_v1', 'f_refer', 'If it persists, technician cleanup/reinstall recommended.', 1),
(311, 'overheating_v1', 'intro', 'Welcome 👋 Let’s check overheating/auto shutdown. Click Continue.', 0),
(312, 'overheating_v1', 'n1', 'Does it shut down during heavy use (games/video) or anytime?', 0),
(313, 'overheating_v1', 'n2', 'Is the fan loud / vents hot?', 0),
(314, 'overheating_v1', 'f_free', 'Cooling and dust-clean steps.', 1),
(315, 'overheating_v1', 'f_refer', 'Thermal paste/fan service recommended.', 1),
(316, 'fan_noise_v1', 'intro', 'Welcome 👋 Let’s diagnose loud fan/strange noise. Click Continue.', 0),
(317, 'fan_noise_v1', 'n1', 'Is the noise grinding/clicking or just loud airflow?', 0),
(318, 'fan_noise_v1', 'n2', 'Does the noise get worse over time?', 0),
(319, 'fan_noise_v1', 'f_free', 'Basic cleaning and airflow steps.', 1),
(320, 'fan_noise_v1', 'f_refer', 'Fan may be failing. Technician replacement recommended.', 1),
(321, 'battery_not_charging_v1', 'intro', 'Welcome 👋 Let’s troubleshoot battery not charging. Click Continue.', 0),
(322, 'battery_not_charging_v1', 'n1', 'Does the laptop work fine on charger alone?', 0),
(323, 'battery_not_charging_v1', 'n2', 'Does it show “plugged in, not charging”?', 0),
(324, 'battery_not_charging_v1', 'f_free', 'Driver/power reset steps.', 1),
(325, 'battery_not_charging_v1', 'f_refer', 'Battery/DC jack/charging circuit issue.', 1),
(326, 'keyboard_not_working_v1', 'intro', 'Welcome 👋 Let’s troubleshoot keyboard issues. Click Continue.', 0),
(327, 'keyboard_not_working_v1', 'n1', 'Is it an external keyboard or laptop built-in keyboard?', 0),
(328, 'keyboard_not_working_v1', 'n2', 'Do some keys work or none at all?', 0),
(329, 'keyboard_not_working_v1', 'f_free', 'Basic keyboard fixes.', 1),
(330, 'keyboard_not_working_v1', 'f_refer', 'Likely hardware replacement needed.', 1),
(331, 'no_audio_v1', 'intro', 'Welcome 👋 Let’s fix “no sound/audio”. Click Continue.', 0),
(332, 'no_audio_v1', 'n1', 'Is audio missing on speakers, headphones, or both?', 0),
(333, 'no_audio_v1', 'n2', 'Is the correct output device selected?', 0),
(334, 'no_audio_v1', 'f_free', 'Audio settings/driver fix.', 1),
(335, 'no_audio_v1', 'f_refer', 'Hardware audio issue suspected.', 1),
(336, 'usb_ports_v1', 'intro', 'Welcome 👋 Let’s troubleshoot USB ports not working. Click Continue.', 0),
(337, 'usb_ports_v1', 'n1', 'Is it one USB port or all ports?', 0),
(338, 'usb_ports_v1', 'n2', 'Does the device work on another computer?', 0),
(339, 'usb_ports_v1', 'f_free', 'USB driver/power fix.', 1),
(340, 'usb_ports_v1', 'f_refer', 'Hardware USB port/controller issue.', 1);

-- --------------------------------------------------------

--
-- Table structure for table `options`
--

CREATE TABLE `options` (
  `id` int(11) NOT NULL,
  `module_id` varchar(100) NOT NULL,
  `node_id` varchar(100) NOT NULL,
  `option_id` varchar(100) NOT NULL,
  `label` varchar(255) NOT NULL,
  `next_node_id` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `options`
--

INSERT INTO `options` (`id`, `module_id`, `node_id`, `option_id`, `label`, `next_node_id`) VALUES
(279, 'power_no_boot_v1', 'intro', 'continue', 'Continue', 'n1'),
(280, 'power_no_boot_v1', 'n1', 'no', 'No', 'n2'),
(281, 'power_no_boot_v1', 'n1', 'yes', 'Yes', 'n2'),
(282, 'power_no_boot_v1', 'n2', 'yes', 'Yes', 'n3'),
(283, 'power_no_boot_v1', 'n2', 'no', 'No / Not sure', 'f_refer'),
(284, 'power_no_boot_v1', 'n3', 'yes', 'Yes', 'f_free'),
(285, 'power_no_boot_v1', 'n3', 'no', 'No', 'f_free'),
(286, 'power_on_no_display_v1', 'intro', 'continue', 'Continue', 'n1'),
(287, 'power_on_no_display_v1', 'n1', 'laptop', 'Laptop', 'n2'),
(288, 'power_on_no_display_v1', 'n1', 'desktop', 'Desktop', 'n2'),
(289, 'power_on_no_display_v1', 'n2', 'faint', 'Yes (faint/backlight)', 'f_backlight'),
(290, 'power_on_no_display_v1', 'n2', 'none', 'No display at all', 'n3'),
(291, 'power_on_no_display_v1', 'n3', 'ext_works', 'External works', 'f_screen'),
(292, 'power_on_no_display_v1', 'n3', 'ext_blank', 'External also blank', 'f_ram'),
(293, 'power_on_no_display_v1', 'n3', 'not_tested', 'Not tested', 'f_ram'),
(294, 'boot_loop_v1', 'intro', 'continue', 'Continue', 'n1'),
(295, 'boot_loop_v1', 'n1', 'yes', 'Yes (before Windows)', 'n2'),
(296, 'boot_loop_v1', 'n1', 'no', 'No (inside Windows)', 'n2'),
(297, 'boot_loop_v1', 'n2', 'yes', 'Yes', 'n3'),
(298, 'boot_loop_v1', 'n2', 'no', 'No / Not sure', 'n3'),
(299, 'boot_loop_v1', 'n3', 'yes', 'Yes', 'f_free'),
(300, 'boot_loop_v1', 'n3', 'no', 'No', 'f_refer'),
(301, 'no_boot_device_v1', 'intro', 'continue', 'Continue', 'n1'),
(302, 'no_boot_device_v1', 'n1', 'yes', 'Yes, suddenly', 'n2'),
(303, 'no_boot_device_v1', 'n1', 'no', 'Not sure / after repair', 'n2'),
(304, 'no_boot_device_v1', 'n2', 'yes', 'Yes', 'f_bios_fix'),
(305, 'no_boot_device_v1', 'n2', 'no', 'No', 'f_refer'),
(306, 'stuck_logo_v1', 'intro', 'continue', 'Continue', 'n1'),
(307, 'stuck_logo_v1', 'n1', 'yes', 'Yes', 'n2'),
(308, 'stuck_logo_v1', 'n1', 'no', 'No', 'n2'),
(309, 'stuck_logo_v1', 'n2', 'yes', 'Yes', 'n3'),
(310, 'stuck_logo_v1', 'n2', 'no', 'No / Not sure', 'n3'),
(311, 'stuck_logo_v1', 'n3', 'yes', 'Yes', 'f_free'),
(312, 'stuck_logo_v1', 'n3', 'no', 'No', 'f_refer'),
(313, 'beeping_sound_v1', 'intro', 'continue', 'Continue', 'n1'),
(314, 'beeping_sound_v1', 'n1', 'yes', 'Yes', 'n2'),
(315, 'beeping_sound_v1', 'n1', 'no', 'No', 'n3'),
(316, 'beeping_sound_v1', 'n2', 'yes', 'Yes', 'f_keyboard'),
(317, 'beeping_sound_v1', 'n2', 'no', 'No', 'f_refer'),
(318, 'beeping_sound_v1', 'n3', 'no_display', 'No display', 'f_ram'),
(319, 'beeping_sound_v1', 'n3', 'has_display', 'Has display/logo', 'f_ram'),
(320, 'bsod_v1', 'intro', 'continue', 'Continue', 'n1'),
(321, 'bsod_v1', 'n1', 'startup', 'Startup', 'n2'),
(322, 'bsod_v1', 'n1', 'in_windows', 'Inside Windows', 'n2'),
(323, 'bsod_v1', 'n2', 'yes', 'Yes', 'n3'),
(324, 'bsod_v1', 'n2', 'no', 'No / Not sure', 'n3'),
(325, 'bsod_v1', 'n3', 'has_code', 'Yes, I see a code', 'f_free'),
(326, 'bsod_v1', 'n3', 'no_code', 'No / unsure', 'f_refer'),
(327, 'slow_dragging_v1', 'intro', 'continue', 'Continue', 'n1'),
(328, 'slow_dragging_v1', 'n1', 'recent', 'Recently', 'n2'),
(329, 'slow_dragging_v1', 'n1', 'long', 'Long time', 'n2'),
(330, 'slow_dragging_v1', 'n2', 'yes', 'Yes', 'n3'),
(331, 'slow_dragging_v1', 'n2', 'no', 'No', 'n3'),
(332, 'slow_dragging_v1', 'n3', 'ssd', 'SSD', 'n4'),
(333, 'slow_dragging_v1', 'n3', 'hdd', 'HDD', 'n4'),
(334, 'slow_dragging_v1', 'n3', 'dont_know', 'Don’t know', 'n4'),
(335, 'slow_dragging_v1', 'n4', 'yes', 'Yes', 'f_malware'),
(336, 'slow_dragging_v1', 'n4', 'no', 'No', 'f_free'),
(337, 'no_internet_on_pc_v1', 'intro', 'continue', 'Continue', 'n1'),
(338, 'no_internet_on_pc_v1', 'n1', 'yes', 'Yes, others work', 'n2'),
(339, 'no_internet_on_pc_v1', 'n1', 'no', 'No, none work', 'f_router'),
(340, 'no_internet_on_pc_v1', 'n2', 'wifi', 'Wi-Fi', 'n3'),
(341, 'no_internet_on_pc_v1', 'n2', 'lan', 'LAN cable', 'n3'),
(342, 'no_internet_on_pc_v1', 'n3', 'yes', 'Yes', 'f_pc_fix'),
(343, 'no_internet_on_pc_v1', 'n3', 'no', 'No / not sure', 'f_pc_fix'),
(344, 'windows_update_fail_v1', 'intro', 'continue', 'Continue', 'n1'),
(345, 'windows_update_fail_v1', 'n1', 'download', 'Downloading', 'n2'),
(346, 'windows_update_fail_v1', 'n1', 'install', 'Installing', 'n2'),
(347, 'windows_update_fail_v1', 'n1', 'reboot', 'Reboot loop', 'n2'),
(348, 'windows_update_fail_v1', 'n2', 'yes', 'Yes', 'f_free'),
(349, 'windows_update_fail_v1', 'n2', 'no', 'No', 'f_free'),
(350, 'app_crash_v1', 'intro', 'continue', 'Continue', 'n1'),
(351, 'app_crash_v1', 'n1', 'one', 'One app only', 'f_app_fix'),
(352, 'app_crash_v1', 'n1', 'many', 'Many apps', 'n2'),
(353, 'app_crash_v1', 'n2', 'yes', 'Yes', 'f_system_fix'),
(354, 'app_crash_v1', 'n2', 'no', 'No / not sure', 'f_system_fix'),
(355, 'virus_popups_v1', 'intro', 'continue', 'Continue', 'n1'),
(356, 'virus_popups_v1', 'n1', 'yes', 'Yes', 'n2'),
(357, 'virus_popups_v1', 'n1', 'no', 'No (only in browser)', 'n2'),
(358, 'virus_popups_v1', 'n2', 'yes', 'Yes', 'f_free'),
(359, 'virus_popups_v1', 'n2', 'no', 'No / not sure', 'f_free'),
(360, 'overheating_v1', 'intro', 'continue', 'Continue', 'n1'),
(361, 'overheating_v1', 'n1', 'heavy', 'Heavy use', 'n2'),
(362, 'overheating_v1', 'n1', 'anytime', 'Anytime', 'n2'),
(363, 'overheating_v1', 'n2', 'yes', 'Yes', 'f_free'),
(364, 'overheating_v1', 'n2', 'no', 'No / not sure', 'f_refer'),
(365, 'fan_noise_v1', 'intro', 'continue', 'Continue', 'n1'),
(366, 'fan_noise_v1', 'n1', 'grind', 'Grinding/clicking', 'n2'),
(367, 'fan_noise_v1', 'n1', 'air', 'Just loud airflow', 'n2'),
(368, 'fan_noise_v1', 'n2', 'yes', 'Yes', 'f_refer'),
(369, 'fan_noise_v1', 'n2', 'no', 'No', 'f_free'),
(370, 'battery_not_charging_v1', 'intro', 'continue', 'Continue', 'n1'),
(371, 'battery_not_charging_v1', 'n1', 'yes', 'Yes', 'n2'),
(372, 'battery_not_charging_v1', 'n1', 'no', 'No', 'f_refer'),
(373, 'battery_not_charging_v1', 'n2', 'yes', 'Yes', 'f_free'),
(374, 'battery_not_charging_v1', 'n2', 'no', 'No / not sure', 'f_refer'),
(375, 'keyboard_not_working_v1', 'intro', 'continue', 'Continue', 'n1'),
(376, 'keyboard_not_working_v1', 'n1', 'external', 'External keyboard', 'n2'),
(377, 'keyboard_not_working_v1', 'n1', 'laptop', 'Laptop built-in', 'n2'),
(378, 'keyboard_not_working_v1', 'n2', 'some', 'Some keys', 'f_free'),
(379, 'keyboard_not_working_v1', 'n2', 'none', 'None', 'f_refer'),
(380, 'no_audio_v1', 'intro', 'continue', 'Continue', 'n1'),
(381, 'no_audio_v1', 'n1', 'both', 'Both', 'n2'),
(382, 'no_audio_v1', 'n1', 'speaker', 'Speakers only', 'n2'),
(383, 'no_audio_v1', 'n1', 'headset', 'Headphones only', 'n2'),
(384, 'no_audio_v1', 'n2', 'yes', 'Yes', 'f_free'),
(385, 'no_audio_v1', 'n2', 'no', 'No / not sure', 'f_free'),
(386, 'usb_ports_v1', 'intro', 'continue', 'Continue', 'n1'),
(387, 'usb_ports_v1', 'n1', 'one', 'One port', 'n2'),
(388, 'usb_ports_v1', 'n1', 'all', 'All ports', 'n2'),
(389, 'usb_ports_v1', 'n2', 'yes', 'Yes', 'f_free'),
(390, 'usb_ports_v1', 'n2', 'no', 'No / not sure', 'f_free');

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `token` varchar(200) NOT NULL,
  `expires_at` datetime NOT NULL,
  `used` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `password_reset_tokens`
--

INSERT INTO `password_reset_tokens` (`id`, `user_id`, `token`, `expires_at`, `used`, `created_at`) VALUES
(1, 3, '3qMLmQCr7LFI4uGA6PIxyC1_UjR85IP2MaOUOfZJ9Qs', '2026-01-23 10:59:21', 0, '2026-01-23 11:29:21'),
(2, 1, '6OjFx3UOHieuTTnEqKJwmwY_bCWf87zqR3AuSR2sYpk', '2026-01-23 10:59:51', 0, '2026-01-23 11:29:51');

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `provider` varchar(50) NOT NULL,
  `reference` varchar(150) NOT NULL,
  `amount_kobo` int(11) NOT NULL,
  `status` varchar(30) NOT NULL DEFAULT 'pending',
  `paid_at` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `plan` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`id`, `user_id`, `provider`, `reference`, `amount_kobo`, `status`, `paid_at`, `created_at`, `plan`) VALUES
(1, 1, 'paystack', 'si0sadvnk6', 150000, 'success', '2026-02-15 22:23:14', '2026-02-15 21:21:39', 'weekly'),
(2, 1, 'paystack', 'y0g3jcjw3t', 150000, 'pending', NULL, '2026-02-15 21:23:29', 'weekly'),
(3, 1, 'paystack', 'hl2epm07i5', 150000, 'pending', NULL, '2026-02-15 21:29:21', 'weekly'),
(4, 1, 'paystack', 'vb7jgxbmul', 150000, 'pending', NULL, '2026-02-15 21:30:42', 'weekly'),
(5, 1, 'paystack', '53uiz2dh77', 600000, 'pending', NULL, '2026-02-15 22:02:04', 'monthly'),
(6, 1, 'paystack', 'd76b52xgil', 6000000, 'success', '2026-02-15 23:22:12', '2026-02-15 22:21:59', 'yearly'),
(7, 1, 'paystack', 'tor5s90bfz', 150000, 'success', '2026-02-15 23:27:49', '2026-02-15 22:27:38', 'weekly'),
(8, 1, 'paystack', 'i67h8dze57', 150000, 'success', '2026-02-15 23:36:27', '2026-02-15 22:36:18', 'weekly'),
(9, 3, 'paystack', 'ge423ghcbj', 150000, 'success', '2026-02-16 17:41:22', '2026-02-16 16:41:05', 'weekly'),
(10, 3, 'paystack', '281kvv3xqu', 600000, 'pending', NULL, '2026-02-16 16:41:50', 'monthly'),
(11, 3, 'paystack', 'eqdcsxitgj', 600000, 'success', '2026-02-16 18:00:27', '2026-02-16 17:00:17', 'monthly'),
(12, 3, 'paystack', 'v9ljzgzv0e', 150000, 'pending', NULL, '2026-02-16 17:10:30', 'weekly'),
(13, 3, 'paystack', 'z802mh9of9', 600000, 'success', '2026-02-16 18:11:11', '2026-02-16 17:10:59', 'monthly'),
(14, 3, 'paystack', 'boe0bu3hz1', 600000, 'pending', NULL, '2026-02-16 18:47:12', 'monthly'),
(15, 3, 'paystack', 'i6wqe8z7v1', 150000, 'success', '2026-02-16 21:05:54', '2026-02-16 20:05:37', 'weekly'),
(16, 3, 'paystack', 'gdo7qqx8fi', 600000, 'success', '2026-02-16 21:16:30', '2026-02-16 20:06:44', 'monthly'),
(17, 3, 'paystack', 'tea1sf4v4k', 150000, 'success', '2026-02-16 21:17:16', '2026-02-16 20:17:02', 'weekly'),
(18, 9, 'paystack', 'hw03aw4udm', 6000000, 'success', '2026-02-16 21:23:41', '2026-02-16 20:23:12', 'yearly'),
(19, 9, 'paystack', 'ut9al1scon', 150000, 'pending', NULL, '2026-02-16 20:25:28', 'weekly'),
(20, 3, 'paystack', 'hqbylffcrr', 150000, 'success', '2026-03-03 13:47:02', '2026-03-03 12:46:49', 'weekly'),
(21, 8, 'paystack', 'kojm953ofh', 600000, 'success', '2026-03-03 13:54:44', '2026-03-03 12:54:32', 'monthly');

-- --------------------------------------------------------

--
-- Table structure for table `results`
--

CREATE TABLE `results` (
  `id` int(11) NOT NULL,
  `module_id` varchar(100) NOT NULL,
  `node_id` varchar(100) NOT NULL,
  `type` varchar(50) NOT NULL,
  `title` varchar(255) NOT NULL,
  `summary` text NOT NULL,
  `next_action` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `results`
--

INSERT INTO `results` (`id`, `module_id`, `node_id`, `type`, `title`, `summary`, `next_action`) VALUES
(96, 'power_no_boot_v1', 'f_free', 'free_fix', 'Power reset / basic checks', 'This is often caused by static power, loose adapter, or battery/charger issues.', '1) Unplug charger.\n2) If battery removable: remove'),
(97, 'power_no_boot_v1', 'f_refer', 'refer_technician', 'Hardware power fault suspected', 'If adapter/charging is uncertain or no response after reset, it may be DC jack, charging circuit, or motherboard power rail.', 'Next action: test known-good adapter, check DC jac'),
(98, 'power_on_no_display_v1', 'f_backlight', 'free_fix', 'Backlight/brightness issue', 'Faint image usually means LCD backlight/brightness issue.', '1) Increase brightness keys.\n2) Shine flashlight t'),
(99, 'power_on_no_display_v1', 'f_screen', 'refer_technician', 'Internal screen/cable issue', 'If external monitor works but internal is blank, it’s likely LCD cable/backlight/screen.', 'Next action: inspect display cable/hinge damage, t'),
(100, 'power_on_no_display_v1', 'f_ram', 'refer_technician', 'RAM/initialization issue', 'If both internal and external show nothing, RAM seating or board init failure is likely.', 'Next action: reseat RAM, test one stick at a time,'),
(101, 'boot_loop_v1', 'f_free', 'free_fix', 'Safe Mode + repair', 'Most boot loops are caused by bad updates/drivers, corrupted system files, or startup conflicts.', '1) Boot Safe Mode.\n2) Uninstall recent update/driv'),
(102, 'boot_loop_v1', 'f_refer', 'refer_technician', 'Hardware fault suspected', 'If Safe Mode is impossible, it may be RAM/SSD failure, overheating, or power instability.', 'Next action: test RAM, check SSD SMART, monitor te'),
(103, 'no_boot_device_v1', 'f_bios_fix', 'free_fix', 'BIOS boot order / OS not detected', 'If the drive is visible in BIOS, boot order or bootloader may be wrong.', '1) Set correct boot drive in BIOS.\n2) Disable/enab'),
(104, 'no_boot_device_v1', 'f_refer', 'refer_technician', 'Drive not detected / hardware issue', 'If the drive is not visible in BIOS, it may be loose, dead, or cable/controller issue.', 'Next action: reseat SSD/HDD, test with another dri'),
(105, 'stuck_logo_v1', 'f_free', 'free_fix', 'Startup repair steps', 'Often caused by corrupted startup files, updates, or drivers.', '1) Boot Safe Mode.\n2) Uninstall recent updates/dri'),
(106, 'stuck_logo_v1', 'f_refer', 'refer_technician', 'Hardware/disk issue suspected', 'If repair tools can’t run or it never reaches recovery, disk/RAM issues are likely.', 'Next action: test disk health (SMART), run RAM tes'),
(107, 'beeping_sound_v1', 'f_keyboard', 'free_fix', 'Keyboard stuck key suspected', 'Continuous beeping on laptops can be caused by stuck keys or keyboard short.', '1) Check any stuck key.\n2) Disconnect external key'),
(108, 'beeping_sound_v1', 'f_ram', 'refer_technician', 'Possible RAM issue', 'Beep codes often point to RAM not seated properly or failing.', 'Next action: power off, reseat RAM, test one stick'),
(109, 'beeping_sound_v1', 'f_refer', 'refer_technician', 'Hardware warning needs diagnosis', 'Without exact beep pattern, safest is hardware checks.', 'Next action: record beep pattern, check model beep'),
(110, 'bsod_v1', 'f_free', 'free_fix', 'BSOD software/driver repair', 'Most BSOD issues are caused by drivers, updates, or corrupted system files.', '1) Boot Safe Mode.\n2) Uninstall recent drivers/upd'),
(111, 'bsod_v1', 'f_refer', 'refer_technician', 'Hardware suspected', 'If BSOD is random and no clear code, RAM/SSD/overheating can be the cause.', 'Next action: RAM test, SSD SMART test, temperature'),
(112, 'slow_dragging_v1', 'f_free', 'free_fix', 'Performance tune-up', 'Likely startup/background load, low space, or Windows maintenance needed.', '1) Disable startup apps.\n2) Uninstall unused apps.'),
(113, 'slow_dragging_v1', 'f_upgrade', 'premium_fix', 'HDD bottleneck (upgrade to SSD)', 'HDD commonly causes slow boot and freezing. SSD upgrade is best fix.', 'Next action: install SSD (256/512GB), reinstall/cl'),
(114, 'slow_dragging_v1', 'f_malware', 'free_fix', 'Possible malware/adware', 'Pop-ups and unknown programs often slow PCs and cause instability.', '1) Defender full scan.\n2) Malwarebytes scan.\n3) Re'),
(115, 'no_internet_on_pc_v1', 'f_router', 'refer_technician', 'Router/ISP issue', 'If no device can browse, the problem is likely router/ISP.', 'Next action: reboot router, check WAN light, confi'),
(116, 'no_internet_on_pc_v1', 'f_pc_fix', 'free_fix', 'PC network reset', 'If other devices work, your PC network settings/driver may be the issue.', '1) Restart PC.\n2) Forget Wi-Fi and reconnect / rep'),
(117, 'windows_update_fail_v1', 'f_free', 'free_fix', 'Windows Update repair', 'Update failures are commonly caused by low space, service cache corruption, or system file issues.', '1) Free up space (Disk Cleanup).\n2) Restart.\n3) Ru'),
(118, 'windows_update_fail_v1', 'f_refer', 'refer_technician', 'Repair install may be needed', 'If updates keep failing after repairs, Windows components may be badly corrupted.', 'Next action: technician can do in-place repair ins'),
(119, 'app_crash_v1', 'f_app_fix', 'free_fix', 'App repair/reinstall', 'Usually corrupted app cache/settings or missing dependencies.', '1) Restart.\n2) Run as Admin.\n3) Settings → Apps → '),
(120, 'app_crash_v1', 'f_system_fix', 'premium_fix', 'Windows/system repair', 'If many apps fail, Windows components may be corrupted or update-related.', '1) Windows Update fully.\n2) sfc /scannow\n3) DISM R'),
(121, 'virus_popups_v1', 'f_free', 'free_fix', 'Malware/adware cleanup', 'Pop-ups/redirects often come from adware, extensions, or unwanted apps.', '1) Uninstall suspicious apps.\n2) Remove bad browse'),
(122, 'virus_popups_v1', 'f_refer', 'refer_technician', 'Deep cleanup needed', 'If pop-ups persist after scans, cleanup may require advanced tools or reinstall.', 'Next action: technician cleanup, data backup, and '),
(123, 'overheating_v1', 'f_free', 'free_fix', 'Overheating basic fixes', 'Overheating is commonly due to dust, blocked vents, or poor airflow.', '1) Use hard surface.\n2) Clean vents.\n3) Reduce bac'),
(124, 'overheating_v1', 'f_refer', 'refer_technician', 'Cooling service needed', 'If overheating persists, fan/heatsink cleaning and thermal paste replacement may be needed.', 'Next action: technician cleaning, thermal paste re'),
(125, 'fan_noise_v1', 'f_free', 'free_fix', 'Clean vents and reduce heat', 'Loud airflow usually means the system is hot or vents are dusty.', '1) Clean vents.\n2) Use hard surface.\n3) Close heav'),
(126, 'fan_noise_v1', 'f_refer', 'refer_technician', 'Fan hardware issue suspected', 'Grinding/clicking often means fan bearings are failing.', 'Next action: technician fan replacement and intern'),
(127, 'battery_not_charging_v1', 'f_free', 'free_fix', 'Battery driver/power reset', 'This can be caused by battery drivers, calibration, or power settings.', '1) Power off.\n2) Unplug charger.\n3) Hold power 20s'),
(128, 'battery_not_charging_v1', 'f_refer', 'refer_technician', 'Hardware charging issue', 'If it can’t run on charger alone or charging behaves abnormal, check DC jack/battery/charging circuit.', 'Next action: test known-good charger, inspect DC j'),
(129, 'keyboard_not_working_v1', 'f_free', 'free_fix', 'Keyboard troubleshooting', 'Often caused by driver issues, dirt, or wrong settings.', '1) Restart.\n2) Try another USB port.\n3) Check Stic'),
(130, 'keyboard_not_working_v1', 'f_refer', 'refer_technician', 'Keyboard hardware fault', 'If none of the keys work, it may be cable/keyboard failure (common after liquid).', 'Next action: technician replacement/repair; test w'),
(131, 'no_audio_v1', 'f_free', 'free_fix', 'Audio restore steps', 'Most audio issues are output selection, mute, or driver problems.', '1) Check volume/mute.\n2) Select correct output dev'),
(132, 'no_audio_v1', 'f_refer', 'refer_technician', 'Possible audio hardware fault', 'If drivers/settings are correct but no sound, speaker/jack/audio IC may be faulty.', 'Next action: test with external USB sound card, ch'),
(133, 'usb_ports_v1', 'f_free', 'free_fix', 'USB restore steps', 'USB issues can be from drivers or power management.', '1) Restart.\n2) Try different ports.\n3) Disable USB'),
(134, 'usb_ports_v1', 'f_refer', 'refer_technician', 'USB hardware fault', 'If ports are physically damaged or controller failed, repair is needed.', 'Next action: inspect port solder joints, replace p');

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` int(11) NOT NULL,
  `session_id` varchar(100) NOT NULL,
  `module_id` varchar(100) NOT NULL,
  `node_id` varchar(100) NOT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `session_id`, `module_id`, `node_id`, `status`, `created_at`, `updated_at`) VALUES
(1, 'S_dd2b8f48', 'power_no_boot_v1', 'n1', 'active', '2026-01-19 07:32:08', '2026-01-19 07:32:08'),
(2, 'S_f1de5c43', 'power_no_boot_v1', 'n1', 'active', '2026-01-19 09:05:08', '2026-01-19 09:08:59'),
(3, 'S_a903fa9d', 'power_no_boot_v1', 'final_tech', 'done', '2026-01-19 12:59:15', '2026-01-19 12:59:56'),
(4, 'S_fcec058e', 'power_no_boot_v1', 'final_free', 'done', '2026-01-19 14:00:50', '2026-01-19 14:01:26'),
(5, 'S_0409318e', 'power_no_boot_v1', 'intro', 'active', '2026-01-19 14:01:47', '2026-01-19 14:01:47'),
(6, 'S_f469c4a0', 'power_no_boot_v1', 'intro', 'active', '2026-01-19 14:02:15', '2026-01-19 14:02:15'),
(7, 'S_d94852fd', 'power_no_boot_v1', 'final_tech', 'done', '2026-01-19 14:16:54', '2026-01-19 14:17:24'),
(8, 'S_d6d9b957', 'power_no_boot_v1', 'final_tech', 'done', '2026-01-19 14:18:04', '2026-01-19 14:18:25'),
(9, 'S_4cac8eb9', 'power_no_boot_v1', 'intro', 'active', '2026-01-19 14:50:48', '2026-01-19 14:50:48'),
(10, 'S_4f893eed', 'power_no_boot_v1', 'intro', 'active', '2026-01-19 15:33:53', '2026-01-19 15:33:53'),
(11, 'S_3268d404', 'power_no_boot_v1', 'intro', 'active', '2026-01-19 16:16:38', '2026-01-19 16:16:38'),
(12, 'S_f4acaddd', 'power_no_boot_v1', 'f_no_power_free', 'done', '2026-01-19 16:16:49', '2026-01-19 16:16:55'),
(13, 'S_e35010d9', 'power_no_boot_v1', 'f_no_fan_refer', 'done', '2026-01-19 16:17:31', '2026-01-19 16:17:43'),
(14, 'S_6dac891a', 'power_no_boot_v1', 'intro', 'active', '2026-01-19 16:20:37', '2026-01-19 16:20:37'),
(15, 'S_6a3594b7', 'app_crash_v1', 'n4_system_fix', 'done', '2026-01-19 17:08:52', '2026-01-19 17:09:21'),
(16, 'S_a412fad0', 'app_crash_v1', 'intro', 'active', '2026-01-19 17:14:32', '2026-01-19 17:14:32'),
(17, 'S_85605304', 'bsod_v1', 'intro', 'active', '2026-01-19 17:14:57', '2026-01-19 17:14:57'),
(18, 'S_a07cde23', 'app_crash_v1', 'intro', 'active', '2026-01-19 17:15:44', '2026-01-19 17:15:44'),
(19, 'S_945063f8', 'power_no_boot_v1', 'intro', 'active', '2026-01-19 17:16:13', '2026-01-19 17:16:13'),
(20, 'S_54a5355c', 'slow_dragging_v1', 'intro', 'active', '2026-01-19 17:18:37', '2026-01-19 17:18:37'),
(21, 'S_45bf1673', 'app_crash_v1', 'n1', 'active', '2026-01-19 17:19:56', '2026-01-19 17:20:01'),
(22, 'S_42e689f6', 'bsod_v1', 'f_safe_fix', 'done', '2026-01-19 17:20:33', '2026-01-19 17:21:26'),
(23, 'S_828d6c83', 'bsod_v1', 'intro', 'active', '2026-01-19 17:24:31', '2026-01-19 17:24:31'),
(24, 'S_3d118092', 'beeping_sound_v1', 'f_ram', 'done', '2026-01-19 17:24:37', '2026-01-19 17:25:41'),
(25, 'S_e5ed840c', 'slow_dragging_v1', 'f_hdd_upgrade', 'done', '2026-01-19 17:28:57', '2026-01-19 17:29:47'),
(26, 'S_d37ff2f7', 'beeping_sound_v1', 'n1', 'active', '2026-01-19 17:30:44', '2026-01-19 17:30:50'),
(27, 'S_af53ac22', 'power_on_no_display_v1', 'intro', 'active', '2026-01-19 17:31:10', '2026-01-19 17:31:10'),
(28, 'S_bb2fd123', 'power_no_boot_v1', 'intro', 'active', '2026-01-19 17:31:21', '2026-01-19 17:31:21'),
(29, 'S_56dccff0', 'slow_dragging_v1', 'n1', 'active', '2026-01-19 17:38:56', '2026-01-19 17:39:02'),
(30, 'S_9f7971fb', 'virus_popups_v1', 'f_free', 'done', '2026-01-19 18:04:31', '2026-01-19 18:04:59'),
(31, 'S_4fd67a98', 'no_internet_on_pc_v1', 'f_pc_fix', 'done', '2026-01-19 18:05:34', '2026-01-19 18:06:14'),
(32, 'S_ae8555b1', 'keyboard_not_working_v1', 'f_free', 'done', '2026-01-19 18:06:48', '2026-01-19 18:07:11'),
(33, 'S_173cc911', 'keyboard_not_working_v1', 'f_refer', 'done', '2026-01-19 18:09:54', '2026-01-19 18:10:04'),
(34, 'S_1c8ba49c', 'overheating_v1', 'f_refer', 'done', '2026-01-19 18:28:24', '2026-01-19 18:28:37'),
(35, 'S_ef919bc3', 'virus_popups_v1', 'f_free', 'done', '2026-01-19 18:39:19', '2026-01-19 18:39:28'),
(36, 'S_5fa6148b', 'battery_not_charging_v1', 'f_refer', 'done', '2026-01-19 18:51:03', '2026-01-19 18:51:54'),
(37, 'S_d5162e23', 'power_no_boot_v1', 'f_free', 'done', '2026-01-19 20:07:54', '2026-01-19 20:08:08'),
(38, 'S_0b7f426c', 'power_no_boot_v1', 'f_free', 'done', '2026-01-19 20:09:57', '2026-01-19 20:10:09'),
(39, 'S_a035c2fb', 'stuck_logo_v1', 'f_refer', 'done', '2026-01-19 20:10:21', '2026-01-19 20:10:35'),
(40, 'S_e6297a98', 'keyboard_not_working_v1', 'f_refer', 'done', '2026-01-19 20:28:48', '2026-01-19 20:29:11'),
(41, 'S_c4c6951b', 'power_no_boot_v1', 'intro', 'active', '2026-01-19 20:30:32', '2026-01-19 20:30:32'),
(42, 'S_fd481153', 'power_no_boot_v1', 'n1', 'active', '2026-01-19 20:34:54', '2026-01-19 20:35:28'),
(43, 'S_476b4713', 'power_no_boot_v1', 'intro', 'active', '2026-01-19 20:41:58', '2026-01-19 20:41:58'),
(44, 'S_cd7389c5', 'power_no_boot_v1', 'intro', 'active', '2026-01-19 20:56:09', '2026-01-19 20:56:09'),
(45, 'S_e509aac7', 'virus_popups_v1', 'intro', 'active', '2026-01-19 21:11:29', '2026-01-19 21:11:29'),
(46, 'S_b08f9382', 'bsod_v1', 'f_free', 'done', '2026-01-20 10:49:33', '2026-01-20 10:52:00'),
(47, 'S_c59df007', 'overheating_v1', 'f_refer', 'done', '2026-01-20 10:55:25', '2026-01-20 10:55:37'),
(48, 'S_8141ac31', 'overheating_v1', 'intro', 'active', '2026-01-20 17:28:58', '2026-01-20 17:28:58'),
(49, 'S_6c78a9e0', 'app_crash_v1', 'f_system_fix', 'done', '2026-01-20 19:09:09', '2026-01-20 19:09:27'),
(50, 'S_bf61aadd', 'fan_noise_v1', 'f_refer', 'done', '2026-01-20 19:17:29', '2026-01-20 19:18:02'),
(51, 'S_42720029', 'virus_popups_v1', 'f_free', 'done', '2026-01-20 19:31:26', '2026-01-20 19:31:36'),
(52, 'S_66d77845', 'overheating_v1', 'f_free', 'done', '2026-01-20 19:32:12', '2026-01-20 19:32:27'),
(53, 'S_14361351', 'overheating_v1', 'f_refer', 'done', '2026-01-20 19:32:53', '2026-01-20 19:33:04'),
(54, 'S_306bb8e3', 'bsod_v1', 'f_free', 'done', '2026-01-20 19:35:26', '2026-01-20 19:35:40'),
(55, 'S_d171943f', 'power_no_boot_v1', 'f_refer', 'done', '2026-01-20 19:41:52', '2026-01-20 19:42:09'),
(56, 'S_0382872e', 'power_no_boot_v1', 'f_refer', 'done', '2026-01-20 19:59:04', '2026-01-20 20:00:31'),
(57, 'S_e1fa0e42', 'power_no_boot_v1', 'n1', 'active', '2026-01-20 20:01:33', '2026-01-20 20:02:14'),
(58, 'S_277c6819', 'bsod_v1', 'f_free', 'done', '2026-01-20 20:02:25', '2026-01-20 20:02:37'),
(59, 'S_13d01393', 'power_no_boot_v1', 'f_free', 'done', '2026-01-20 20:27:08', '2026-01-20 20:27:25'),
(60, 'S_950106a4', 'keyboard_not_working_v1', 'f_refer', 'done', '2026-01-20 20:30:30', '2026-01-20 20:30:57'),
(61, 'S_ca7426c7', 'virus_popups_v1', 'intro', 'active', '2026-01-20 20:31:58', '2026-01-20 20:31:58'),
(62, 'S_15313435', 'no_internet_on_pc_v1', 'f_pc_fix', 'done', '2026-01-20 20:40:58', '2026-01-20 20:41:21'),
(63, 'S_52a19673', 'beeping_sound_v1', 'f_ram', 'done', '2026-01-20 20:41:56', '2026-01-20 20:42:10'),
(64, 'S_e2300eb1', 'power_no_boot_v1', 'intro', 'active', '2026-01-20 20:45:16', '2026-01-20 20:45:16'),
(65, 'S_73f023b5', 'virus_popups_v1', 'intro', 'active', '2026-01-20 21:02:34', '2026-01-20 21:02:34'),
(66, 'S_18420515', 'power_no_boot_v1', 'intro', 'active', '2026-01-20 21:14:01', '2026-01-20 21:14:01'),
(67, 'S_c53f98c3', 'power_no_boot_v1', 'f_free', 'done', '2026-01-20 21:14:32', '2026-01-20 21:14:44'),
(68, 'S_6ddaf6f4', 'power_no_boot_v1', 'f_free', 'done', '2026-01-20 21:14:55', '2026-01-20 21:15:10'),
(69, 'S_ea97d7dc', 'power_no_boot_v1', 'f_refer', 'done', '2026-01-20 21:16:01', '2026-01-20 21:16:10'),
(70, 'S_bd7984cf', 'power_no_boot_v1', 'f_free', 'done', '2026-01-21 05:11:22', '2026-01-21 05:11:37'),
(71, 'S_94c5b128', 'no_boot_device_v1', 'f_refer', 'done', '2026-01-21 05:13:03', '2026-01-21 05:13:33'),
(72, 'S_56417c39', 'power_no_boot_v1', 'f_free', 'done', '2026-01-21 05:32:21', '2026-01-21 05:32:41'),
(73, 'S_bb541bd4', 'fan_noise_v1', 'f_refer', 'done', '2026-01-21 05:33:07', '2026-01-21 05:33:20'),
(74, 'S_92720e6f', 'windows_update_fail_v1', 'intro', 'active', '2026-01-21 05:44:04', '2026-01-21 05:44:04'),
(75, 'S_9bcbffda', 'power_no_boot_v1', 'intro', 'active', '2026-01-21 05:46:35', '2026-01-21 05:46:35'),
(76, 'S_d29dd5c7', 'power_no_boot_v1', 'f_free', 'done', '2026-01-21 06:01:57', '2026-01-21 06:02:08'),
(77, 'S_4bdb5410', 'power_no_boot_v1', 'intro', 'active', '2026-01-21 07:49:48', '2026-01-21 07:49:48'),
(78, 'S_04c913a7', 'power_no_boot_v1', 'intro', 'active', '2026-01-21 10:00:17', '2026-01-21 10:00:17'),
(79, 'S_f6fa0926', 'power_no_boot_v1', 'f_free', 'done', '2026-01-21 10:28:06', '2026-01-21 10:29:20'),
(80, 'S_6b20e6b9', 'power_no_boot_v1', 'n2', 'active', '2026-01-21 10:29:28', '2026-01-21 10:29:35'),
(81, 'S_96be4c4b', 'power_no_boot_v1', 'f_free', 'done', '2026-01-21 10:29:45', '2026-01-21 10:30:10'),
(82, 'S_95c9aee1', 'power_no_boot_v1', 'f_free', 'done', '2026-01-21 10:30:53', '2026-01-21 10:31:05'),
(83, 'S_27c9ecfe', 'no_boot_device_v1', 'f_refer', 'done', '2026-01-21 10:31:34', '2026-01-21 10:31:48'),
(84, 'S_46d6fe47', 'no_boot_device_v1', 'n1', 'active', '2026-01-21 11:02:32', '2026-01-21 11:02:34'),
(85, 'S_5598e6f6', 'battery_not_charging_v1', 'f_refer', 'done', '2026-01-21 14:33:39', '2026-01-21 14:33:56'),
(86, 'S_4e61ae86', 'power_no_boot_v1', 'f_free', 'done', '2026-01-22 13:07:41', '2026-01-22 13:07:54'),
(87, 'S_0049552d', 'overheating_v1', 'f_refer', 'done', '2026-01-22 13:08:07', '2026-01-22 13:08:20'),
(88, 'S_1208d075', 'power_no_boot_v1', 'f_refer', 'done', '2026-01-22 17:42:31', '2026-01-22 17:42:35'),
(89, 'S_3255e056', 'power_no_boot_v1', 'intro', 'active', '2026-01-22 19:00:33', '2026-01-22 19:00:33'),
(90, 'S_2afaecad', 'power_no_boot_v1', 'intro', 'active', '2026-01-22 19:00:37', '2026-01-22 19:00:37'),
(91, 'S_af8cfa74', 'power_no_boot_v1', 'f_refer', 'done', '2026-01-22 19:00:49', '2026-01-22 19:01:01'),
(92, 'S_6b5c34cf', 'power_no_boot_v1', 'f_free', 'done', '2026-01-22 19:21:31', '2026-01-22 19:21:41'),
(93, 'S_34ccf4dd', 'overheating_v1', 'f_free', 'done', '2026-01-23 06:04:15', '2026-01-23 06:04:34'),
(94, 'S_b83b8a27', 'power_no_boot_v1', 'f_free', 'done', '2026-01-23 06:06:57', '2026-01-23 06:07:26'),
(95, 'S_baea787c', 'bsod_v1', 'f_free', 'done', '2026-01-23 06:07:51', '2026-01-23 06:08:15'),
(96, 'S_41cbf088', 'bsod_v1', 'f_refer', 'done', '2026-01-23 06:08:23', '2026-01-23 06:08:31'),
(97, 'S_0729232c', 'power_no_boot_v1', 'intro', 'active', '2026-01-23 09:49:24', '2026-01-23 09:49:24'),
(98, 'S_f8a816cc', 'keyboard_not_working_v1', 'f_free', 'done', '2026-01-26 15:14:47', '2026-01-26 15:15:07'),
(99, 'S_cbe3dd45', 'power_no_boot_v1', 'f_free', 'done', '2026-01-26 16:18:59', '2026-01-26 16:19:13'),
(100, 'S_26d98433', 'bsod_v1', 'f_free', 'done', '2026-01-26 16:19:19', '2026-01-26 16:19:53'),
(101, 'S_93f94f0a', 'bsod_v1', 'f_refer', 'done', '2026-01-26 16:20:00', '2026-01-26 16:20:09'),
(102, 'S_a6e71aae', 'overheating_v1', 'f_refer', 'done', '2026-01-26 17:20:45', '2026-01-26 17:21:40'),
(103, 'S_6cd00ade', 'power_no_boot_v1', 'intro', 'active', '2026-01-26 17:29:34', '2026-01-26 17:29:34'),
(104, 'S_d6899bf0', 'battery_not_charging_v1', 'f_refer', 'done', '2026-01-28 17:56:46', '2026-01-28 17:56:56'),
(105, 'S_c415bcb0', 'power_no_boot_v1', 'f_refer', 'done', '2026-02-15 17:44:37', '2026-02-15 17:44:43'),
(106, 'S_593bfdee', 'overheating_v1', 'f_refer', 'done', '2026-02-15 17:52:11', '2026-02-15 17:52:24'),
(107, 'S_1b026851', 'overheating_v1', 'f_refer', 'done', '2026-02-15 18:25:11', '2026-02-15 18:25:20'),
(108, 'S_6e91a2a5', 'virus_popups_v1', 'f_free', 'done', '2026-02-15 18:45:12', '2026-02-15 18:45:37'),
(109, 'S_3595baff', 'overheating_v1', 'f_refer', 'done', '2026-02-15 18:45:54', '2026-02-15 18:46:05'),
(110, 'S_de6a1b3f', 'overheating_v1', 'f_refer', 'done', '2026-02-15 20:25:23', '2026-02-15 20:25:37'),
(111, 'S_7dd8c249', 'overheating_v1', 'f_refer', 'done', '2026-02-15 20:39:07', '2026-02-15 20:39:14'),
(112, 'S_fc35d458', 'power_no_boot_v1', 'f_refer', 'done', '2026-02-15 20:44:06', '2026-02-15 20:44:12'),
(113, 'S_98b37bf0', 'fan_noise_v1', 'f_free', 'done', '2026-02-15 21:28:09', '2026-02-15 21:28:28'),
(114, 'S_a8e36067', 'battery_not_charging_v1', 'f_refer', 'done', '2026-02-15 21:28:52', '2026-02-15 21:29:01'),
(115, 'S_bedc5ec4', 'fan_noise_v1', 'f_refer', 'done', '2026-02-15 22:21:31', '2026-02-15 22:21:40'),
(116, 'S_b0f4b53d', 'power_no_boot_v1', 'f_refer', 'done', '2026-02-15 22:34:58', '2026-02-15 22:35:03'),
(117, 'S_0b8269f0', 'power_no_boot_v1', 'f_free', 'done', '2026-02-16 16:40:11', '2026-02-16 16:40:36'),
(118, 'S_4adde245', 'fan_noise_v1', 'f_refer', 'done', '2026-02-16 16:40:44', '2026-02-16 16:40:56'),
(119, 'S_915e7ef1', 'overheating_v1', 'f_free', 'done', '2026-02-16 16:59:35', '2026-02-16 16:59:43'),
(120, 'S_7ba7a24f', 'overheating_v1', 'f_refer', 'done', '2026-02-16 16:59:58', '2026-02-16 17:00:10'),
(121, 'S_466c7698', 'power_no_boot_v1', 'f_free', 'done', '2026-02-16 17:00:47', '2026-02-16 17:01:02'),
(122, 'S_29885356', 'power_no_boot_v1', 'intro', 'active', '2026-02-16 17:11:25', '2026-02-16 17:11:25'),
(123, 'S_c93507d6', 'overheating_v1', 'f_refer', 'done', '2026-02-16 18:46:43', '2026-02-16 18:47:00'),
(124, 'S_99368dab', 'power_no_boot_v1', 'n1', 'active', '2026-02-16 20:17:31', '2026-02-16 20:17:33'),
(125, 'S_8b68288f', 'overheating_v1', 'f_refer', 'done', '2026-02-16 20:22:53', '2026-02-16 20:23:02'),
(126, 'S_c94e1d9e', 'power_no_boot_v1', 'f_refer', 'done', '2026-02-16 20:23:49', '2026-02-16 20:23:55'),
(127, 'S_84c5e48f', 'fan_noise_v1', 'f_refer', 'done', '2026-03-03 12:20:51', '2026-03-03 12:21:09');

-- --------------------------------------------------------

--
-- Table structure for table `technician_profiles`
--

CREATE TABLE `technician_profiles` (
  `user_id` bigint(20) NOT NULL,
  `city` varchar(80) NOT NULL,
  `skills_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`skills_json`)),
  `rating` decimal(3,2) DEFAULT 0.00,
  `is_available` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `technician_profiles`
--

INSERT INTO `technician_profiles` (`user_id`, `city`, `skills_json`, `rating`, `is_available`) VALUES
(1, 'mowe', '[\"laptop repair\"]', 5.00, 1);

-- --------------------------------------------------------

--
-- Table structure for table `tickets`
--

CREATE TABLE `tickets` (
  `id` bigint(20) NOT NULL,
  `created_by_user_id` bigint(20) NOT NULL,
  `session_id` varchar(80) DEFAULT NULL,
  `module_id` varchar(120) NOT NULL,
  `issue_summary` text NOT NULL,
  `user_city` varchar(80) NOT NULL,
  `preferred_contact` enum('whatsapp','call','email') NOT NULL DEFAULT 'whatsapp',
  `status` enum('pending','assigned','accepted','in_progress','resolved','cancelled') NOT NULL DEFAULT 'pending',
  `assigned_tech_user_id` bigint(20) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tickets`
--

INSERT INTO `tickets` (`id`, `created_by_user_id`, `session_id`, `module_id`, `issue_summary`, `user_city`, `preferred_contact`, `status`, `assigned_tech_user_id`, `created_at`, `updated_at`) VALUES
(1, 3, 'S_bf61aadd', 'fan_noise_v1', 'Fan hardware issue suspected: Grinding/clicking often means fan bearings are failing.', 'Mowe', 'call', '', 1, '2026-01-20 19:20:43', '2026-01-23 09:46:29'),
(2, 3, 'S_bf61aadd', 'fan_noise_v1', 'Fan hardware issue suspected: Grinding/clicking often means fan bearings are failing.', 'Mowe', 'call', '', 1, '2026-01-20 19:20:54', '2026-01-23 09:46:26'),
(3, 1, 'S_d171943f', 'power_no_boot_v1', 'Hardware power fault suspected: If adapter/charging is uncertain or no response after reset, it may be DC jack, charging circuit, or motherboard power rail.', 'Mowe', 'whatsapp', '', 1, '2026-01-20 19:42:21', '2026-01-23 09:46:24'),
(4, 1, 'S_0382872e', 'power_no_boot_v1', 'Hardware power fault suspected: If adapter/charging is uncertain or no response after reset, it may be DC jack, charging circuit, or motherboard power rail.', 'Mowe', 'whatsapp', '', 1, '2026-01-20 20:00:53', '2026-01-23 09:46:22'),
(5, 1, 'S_0382872e', 'power_no_boot_v1', 'Hardware power fault suspected: If adapter/charging is uncertain or no response after reset, it may be DC jack, charging circuit, or motherboard power rail.', 'Mowe', 'whatsapp', '', 1, '2026-01-20 20:01:01', '2026-01-23 09:46:21'),
(6, 1, 'S_0382872e', 'power_no_boot_v1', 'Hardware power fault suspected: If adapter/charging is uncertain or no response after reset, it may be DC jack, charging circuit, or motherboard power rail.', 'Mowe', 'whatsapp', '', 1, '2026-01-20 20:01:17', '2026-01-23 09:46:19'),
(7, 1, 'S_52a19673', 'beeping_sound_v1', 'Possible RAM issue: Beep codes often point to RAM not seated properly or failing.', 'Mowe', 'whatsapp', '', 1, '2026-01-20 20:42:26', '2026-01-23 09:46:17'),
(8, 1, 'S_52a19673', 'beeping_sound_v1', 'Possible RAM issue: Beep codes often point to RAM not seated properly or failing.', 'Mowe', 'whatsapp', '', 1, '2026-01-20 20:42:53', '2026-01-23 09:46:15'),
(9, 1, 'S_52a19673', 'beeping_sound_v1', 'Possible RAM issue: Beep codes often point to RAM not seated properly or failing.', 'Mowe', 'whatsapp', 'pending', NULL, '2026-01-20 20:42:54', '2026-01-20 20:42:54'),
(10, 1, 'S_52a19673', 'beeping_sound_v1', 'Possible RAM issue: Beep codes often point to RAM not seated properly or failing.', 'Mowe', 'whatsapp', '', 1, '2026-01-20 20:42:55', '2026-01-23 09:46:14'),
(11, 1, 'S_52a19673', 'beeping_sound_v1', 'Possible RAM issue: Beep codes often point to RAM not seated properly or failing.', 'Mowe', 'whatsapp', '', 1, '2026-01-20 20:42:56', '2026-01-23 09:46:12'),
(12, 1, 'S_52a19673', 'beeping_sound_v1', 'Possible RAM issue: Beep codes often point to RAM not seated properly or failing.', 'Mowe', 'whatsapp', '', 1, '2026-01-20 20:43:09', '2026-01-23 09:46:11'),
(13, 1, 'S_52a19673', 'beeping_sound_v1', 'Possible RAM issue: Beep codes often point to RAM not seated properly or failing.', 'Mowe', 'whatsapp', '', 1, '2026-01-20 20:43:28', '2026-01-23 09:46:09'),
(14, 1, 'S_bb541bd4', 'fan_noise_v1', 'Fan hardware issue suspected: Grinding/clicking often means fan bearings are failing.', 'Mowe', 'whatsapp', 'accepted', 1, '2026-01-21 05:34:42', '2026-01-23 09:46:08'),
(15, 1, 'S_bb541bd4', 'fan_noise_v1', 'Fan hardware issue suspected: Grinding/clicking often means fan bearings are failing.', 'Mowe', 'whatsapp', '', 1, '2026-01-21 05:34:49', '2026-01-23 09:46:06'),
(16, 1, 'S_bb541bd4', 'fan_noise_v1', 'Fan hardware issue suspected: Grinding/clicking often means fan bearings are failing.', 'Mowe', 'whatsapp', '', 1, '2026-01-21 05:34:49', '2026-01-23 09:46:04'),
(17, 1, 'S_bb541bd4', 'fan_noise_v1', 'Fan hardware issue suspected: Grinding/clicking often means fan bearings are failing.', 'Mowe', 'whatsapp', 'accepted', 1, '2026-01-21 05:34:50', '2026-01-23 09:46:02'),
(18, 1, 'S_bb541bd4', 'fan_noise_v1', 'Fan hardware issue suspected: Grinding/clicking often means fan bearings are failing.', 'Mowe', 'whatsapp', '', 1, '2026-01-21 05:34:50', '2026-01-23 09:45:59'),
(19, 1, 'S_bb541bd4', 'fan_noise_v1', 'Fan hardware issue suspected: Grinding/clicking often means fan bearings are failing.', 'Mowe', 'whatsapp', '', 1, '2026-01-21 05:34:51', '2026-01-23 09:45:56'),
(20, 1, 'S_bb541bd4', 'fan_noise_v1', 'Fan hardware issue suspected: Grinding/clicking often means fan bearings are failing.', 'Mowe', 'whatsapp', '', 1, '2026-01-21 05:34:57', '2026-01-23 09:45:55'),
(21, 1, 'S_bb541bd4', 'fan_noise_v1', 'Fan hardware issue suspected: Grinding/clicking often means fan bearings are failing.', 'Mowe', 'whatsapp', '', 1, '2026-01-21 05:34:57', '2026-01-23 09:45:52'),
(22, 1, 'S_bb541bd4', 'fan_noise_v1', 'Fan hardware issue suspected: Grinding/clicking often means fan bearings are failing.', 'Mowe', 'whatsapp', '', 1, '2026-01-21 05:35:20', '2026-01-23 09:45:50'),
(23, 1, 'S_bb541bd4', 'fan_noise_v1', 'Fan hardware issue suspected: Grinding/clicking often means fan bearings are failing.', 'Mowe', 'whatsapp', '', 1, '2026-01-21 05:35:21', '2026-01-23 09:45:48'),
(24, 1, 'S_bb541bd4', 'fan_noise_v1', 'Fan hardware issue suspected: Grinding/clicking often means fan bearings are failing.', 'Mowe', 'whatsapp', '', 1, '2026-01-21 05:43:42', '2026-01-23 09:45:45'),
(25, 1, 'S_27c9ecfe', 'no_boot_device_v1', 'Drive not detected / hardware issue: If the drive is not visible in BIOS, it may be loose, dead, or cable/controller issue.', 'Mowe', 'whatsapp', '', 1, '2026-01-21 09:31:58', '2026-01-23 09:45:44'),
(26, 1, 'S_27c9ecfe', 'no_boot_device_v1', 'Drive not detected / hardware issue: If the drive is not visible in BIOS, it may be loose, dead, or cable/controller issue.', 'Mowe', 'whatsapp', '', 1, '2026-01-21 09:44:35', '2026-01-23 09:45:41'),
(27, 8, 'S_93f94f0a', 'bsod_v1', 'Hardware suspected: If BSOD is random and no clear code, RAM/SSD/overheating can be the cause.', 'Mowe', 'whatsapp', 'assigned', 1, '2026-01-26 16:20:34', '2026-01-26 17:31:16');

-- --------------------------------------------------------

--
-- Table structure for table `ticket_attachments`
--

CREATE TABLE `ticket_attachments` (
  `id` bigint(20) NOT NULL,
  `ticket_id` bigint(20) NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `file_path` varchar(500) NOT NULL,
  `mime_type` varchar(100) NOT NULL,
  `file_size` int(11) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ticket_attachments`
--

INSERT INTO `ticket_attachments` (`id`, `ticket_id`, `file_name`, `file_path`, `mime_type`, `file_size`, `created_at`) VALUES
(1, 27, 'happy new month.png', 'uploads/4149ed1f2d544cd19070cc4760cca5e5.png', 'image/png', 909926, '2026-01-28 18:36:26');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) NOT NULL,
  `full_name` varchar(120) NOT NULL,
  `email` varchar(190) NOT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `password_hash` varchar(255) NOT NULL,
  `role` enum('user','technician','admin') NOT NULL DEFAULT 'user',
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_premium` tinyint(1) NOT NULL DEFAULT 0,
  `premium_expires_at` datetime DEFAULT NULL,
  `premium_plan` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `full_name`, `email`, `phone`, `password_hash`, `role`, `is_active`, `created_at`, `is_premium`, `premium_expires_at`, `premium_plan`) VALUES
(1, 'Atie Oriyomi', 'atieoriyomi@gmail.com', '+2340818935744', '$argon2id$v=19$m=65536,t=3,p=4$EmLsfa/V2jundI4R4vy/1w$OJd38/rQbWg1/hE8t/CTld6F6b6tqYBjlRw1k+r15X0', 'technician', 1, '2026-01-19 21:10:52', 1, '2026-02-22 22:36:27', 'weekly'),
(3, 'Atie Busayo', 'atieoriyomi1@gmail.com', '+2340818935749', '$argon2id$v=19$m=65536,t=3,p=4$wRhDaO1d613r3fvf2/t/Lw$Na/SqIuPjFUtdrxPjjgV9Ut1ZfnpBWtwhcqv+Vo7UTI', 'user', 1, '2026-01-20 19:17:05', 1, '2026-03-10 12:47:02', 'weekly'),
(4, 'System Admin', 'admin@troubleshoot.ai', '09000000000', '$2b$12$Fcap70qJBkw66Ht.GBvVp.aatZmTv1HuV53bF0UaDmNHKocYEYSr2', 'admin', 1, '2026-01-22 19:10:21', 0, NULL, NULL),
(8, 'Busayo Atie', 'busa@gmail.com', '+234818935749', '$argon2id$v=19$m=65536,t=3,p=4$d05pDeHc+x9jzBnjnPN+bw$IF3sU/4vG1YO+ZLGag96AkV7X44L7n+NIkA83VxKRB4', 'user', 1, '2026-01-26 16:16:08', 1, '2026-04-02 12:54:44', 'monthly'),
(9, 'dupe gold', 'dupe@gmail.com', '+2349067921361', '$argon2id$v=19$m=65536,t=3,p=4$FYKwlnJOiREiZKx1DgFAiA$6PJvoxC+IOKW+H5LrAx3wp4Q0yH0CyO84/jaYc9Z7rQ', 'user', 1, '2026-02-16 20:22:39', 1, '2027-02-16 20:23:41', 'yearly');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `answers_log`
--
ALTER TABLE `answers_log`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `answer_logs`
--
ALTER TABLE `answer_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ix_answer_logs_module_id` (`module_id`),
  ADD KEY `ix_answer_logs_id` (`id`),
  ADD KEY `ix_answer_logs_session_id` (`session_id`),
  ADD KEY `ix_answer_logs_node_id` (`node_id`);

--
-- Indexes for table `modules`
--
ALTER TABLE `modules`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `module_id` (`module_id`);

--
-- Indexes for table `nodes`
--
ALTER TABLE `nodes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uniq_node` (`module_id`,`node_id`);

--
-- Indexes for table `options`
--
ALTER TABLE `options`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uniq_opt` (`module_id`,`node_id`,`option_id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_prt_token` (`token`),
  ADD KEY `idx_prt_user_id` (`user_id`),
  ADD KEY `idx_prt_user_expires` (`user_id`,`expires_at`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `reference` (`reference`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `results`
--
ALTER TABLE `results`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uniq_res` (`module_id`,`node_id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `session_id` (`session_id`);

--
-- Indexes for table `technician_profiles`
--
ALTER TABLE `technician_profiles`
  ADD UNIQUE KEY `uq_technician_user` (`user_id`);

--
-- Indexes for table `tickets`
--
ALTER TABLE `tickets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `created_by_user_id` (`created_by_user_id`),
  ADD KEY `assigned_tech_user_id` (`assigned_tech_user_id`);

--
-- Indexes for table `ticket_attachments`
--
ALTER TABLE `ticket_attachments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_ticket_id` (`ticket_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `answers_log`
--
ALTER TABLE `answers_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=186;

--
-- AUTO_INCREMENT for table `answer_logs`
--
ALTER TABLE `answer_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=111;

--
-- AUTO_INCREMENT for table `modules`
--
ALTER TABLE `modules`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `nodes`
--
ALTER TABLE `nodes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=341;

--
-- AUTO_INCREMENT for table `options`
--
ALTER TABLE `options`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=391;

--
-- AUTO_INCREMENT for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `results`
--
ALTER TABLE `results`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=135;

--
-- AUTO_INCREMENT for table `sessions`
--
ALTER TABLE `sessions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=128;

--
-- AUTO_INCREMENT for table `tickets`
--
ALTER TABLE `tickets`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `ticket_attachments`
--
ALTER TABLE `ticket_attachments`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD CONSTRAINT `fk_prt_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `fk_payments_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `technician_profiles`
--
ALTER TABLE `technician_profiles`
  ADD CONSTRAINT `technician_profiles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `tickets`
--
ALTER TABLE `tickets`
  ADD CONSTRAINT `tickets_ibfk_1` FOREIGN KEY (`created_by_user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `tickets_ibfk_2` FOREIGN KEY (`assigned_tech_user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `ticket_attachments`
--
ALTER TABLE `ticket_attachments`
  ADD CONSTRAINT `fk_ticket_attachments_ticket` FOREIGN KEY (`ticket_id`) REFERENCES `tickets` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
