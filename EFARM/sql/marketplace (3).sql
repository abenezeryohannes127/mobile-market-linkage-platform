-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 06, 2026 at 12:30 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `marketplace`
--

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `id` int(11) NOT NULL,
  `sender_id` int(11) NOT NULL,
  `receiver_id` int(11) NOT NULL,
  `message` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `messages`
--

INSERT INTO `messages` (`id`, `sender_id`, `receiver_id`, `message`, `created_at`) VALUES
(1, 1, 2, 'hay', '2026-03-25 19:33:57'),
(2, 2, 1, 'hi', '2026-03-25 19:33:57'),
(3, 2, 4, 'rr', '2026-03-25 19:34:38'),
(4, 3, 1, 'ff', '2026-03-25 19:34:38'),
(5, 1, 2, 'dbdb', '2026-03-29 15:21:39'),
(6, 2, 1, 'ok', '2026-03-29 15:31:18'),
(7, 11, 2, 'll', '2026-03-29 19:41:34'),
(8, 2, 11, 'qq', '2026-03-29 19:41:34'),
(9, 1, 2, 'hi', '2026-04-05 17:55:02'),
(10, 1, 2, 'hiii2', '2026-04-05 17:55:25');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `buyer_id` int(11) DEFAULT NULL,
  `driver_id` int(11) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `product_id`, `buyer_id`, `driver_id`, `status`) VALUES
(1, 1, 11, 10, 'on the way'),
(2, 2, 2, 10, 'on the way'),
(3, 3, 11, 3, 'on the way'),
(4, 1, 11, 3, 'on the way'),
(5, 4, 11, 3, 'on the way'),
(6, 3, 11, 10, 'on the way'),
(7, 1, 2, 15, 'on the way'),
(8, 12, 2, 15, 'on the way'),
(9, 12, 2, 15, 'on the way'),
(10, 12, 2, 10, 'on the way'),
(11, 11, 2, 15, 'on the way'),
(12, 1, 11, 3, 'on the way'),
(13, 6, 2, 10, 'on the way'),
(14, 11, 2, 15, 'on the way'),
(15, 12, 2, NULL, 'pending');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `name` varchar(200) DEFAULT NULL,
  `price` float DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `user_id` int(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `price`, `image`, `user_id`) VALUES
(1, 'product1', 222, '0045_1504205_744102945608035_280309272_o.jpg', 1),
(2, 'product2', 1333, '3.jpg', 4),
(3, 'product3', 444, '2302.w058.n003.249B.p1.249.jpg', 1),
(6, 'product5', 2232, '3.jpg', 4),
(10, 'p6', 22, '3.jpg', 1),
(11, 'p7', 7, '3.jpg', 1),
(12, 'p8', 88, '0045_1504205_744102945608035_280309272_o.jpg', 4);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(200) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `role` enum('buyer','seller','driver','admin') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `role`) VALUES
(1, 'k', 'k@gmail.com', 'k', 'seller'),
(2, 'b', 'b@gmail.com', 'b', 'buyer'),
(3, 'd', 'd@gmail.com', 'd', 'driver'),
(4, 'kk', 'kk@gmail.com', 'kk', 'seller'),
(10, 'driver', 'driver@gmail.com', 'driver', 'driver'),
(11, 'buyer', 'buyer@gmail.com', 'buyer', 'buyer'),
(15, 'driver3E', 'driver3@gmail.com', 'driver3', 'driver'),
(16, 'Admin', 'admin@gmail.com', '1234', 'admin');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
