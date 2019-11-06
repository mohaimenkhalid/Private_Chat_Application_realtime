-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Sep 04, 2019 at 08:49 PM
-- Server version: 10.4.6-MariaDB
-- PHP Version: 7.3.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `private_chat`
--

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'mohaimen', 'mohaimen707@gmail.com', NULL, '$2y$10$5yoeKleHzczDyBa97aMwEu7h5OTzFDDQLM5HNJIRYouTTRSk8gXKy', NULL, '2019-09-01 05:08:41', '2019-09-01 05:08:41'),
(2, 'Garry Medhurst', 'trantow.colin@example.org', '2019-09-01 08:36:24', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '38fJ0pC8aH', '2019-09-01 08:36:24', '2019-09-01 08:36:24'),
(3, 'Prof. Thora Lueilwitz', 'brando.kassulke@example.org', '2019-09-01 08:36:24', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '8VWkbp3uXF', '2019-09-01 08:36:24', '2019-09-01 08:36:24'),
(4, 'Mabelle O\'Reilly', 'hblock@example.com', '2019-09-01 08:36:24', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'CgXVg1Nl1c', '2019-09-01 08:36:24', '2019-09-01 08:36:24'),
(5, 'Lawson Koelpin', 'bbrown@example.org', '2019-09-01 08:36:24', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'HRWUJ7RFn4', '2019-09-01 08:36:24', '2019-09-01 08:36:24'),
(6, 'Skylar Sanford', 'buster.crist@example.net', '2019-09-01 08:36:24', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'A92hgXYydd', '2019-09-01 08:36:24', '2019-09-01 08:36:24'),
(7, 'Bernadette Parker', 'douglas.dorian@example.net', '2019-09-01 08:36:24', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '8Xzclx7PtQ', '2019-09-01 08:36:24', '2019-09-01 08:36:24'),
(8, 'Dr. Mossie Crooks', 'conroy.burnice@example.net', '2019-09-01 08:36:24', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '0LTAcTYEmN', '2019-09-01 08:36:24', '2019-09-01 08:36:24'),
(9, 'Miss Stefanie Gerhold II', 'lourdes80@example.com', '2019-09-01 08:36:24', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '4d7EuyXZPA', '2019-09-01 08:36:24', '2019-09-01 08:36:24'),
(10, 'Joannie Barrows', 'durgan.tyshawn@example.org', '2019-09-01 08:36:24', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'OY7qd37MOj', '2019-09-01 08:36:24', '2019-09-01 08:36:24'),
(11, 'Prof. Camryn Rau', 'helga95@example.net', '2019-09-01 08:36:24', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'cVwMU3DHDy', '2019-09-01 08:36:24', '2019-09-01 08:36:24'),
(12, 'mamun', 'mamun@gmail.com', NULL, '$2y$10$fM7qrKgSmJWvIMJic0dHoegOo99as.ENEmW27YMsdTvEGT2lhO2Qe', NULL, '2019-09-01 15:48:00', '2019-09-01 15:48:00');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
