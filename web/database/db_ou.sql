-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:4306
-- Generation Time: Feb 07, 2023 at 10:56 AM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 7.4.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_ou`
--

-- --------------------------------------------------------

--
-- Table structure for table `ou_orderupload`
--

CREATE TABLE `ou_orderupload` (
  `order_id` int(10) NOT NULL,
  `doc_id` int(10) NOT NULL,
  `receipt_id` int(10) NOT NULL,
  `order_cms_id` varchar(10) NOT NULL,
  `order_cms_fullname` varchar(200) NOT NULL,
  `order_cms_company` varchar(100) NOT NULL,
  `order_cms_department` varchar(100) NOT NULL,
  `order_product_id` varchar(20) NOT NULL,
  `order_product_barcode` varchar(200) NOT NULL,
  `order_product_name` varchar(200) NOT NULL,
  `order_mat_group` varchar(20) NOT NULL,
  `order_mat_name` varchar(20) NOT NULL,
  `order_product_qty` varchar(20) NOT NULL,
  `order_price_exc_vat` varchar(10) NOT NULL,
  `order_price_inc_vat` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `ou_orderupload`
--

INSERT INTO `ou_orderupload` (`order_id`, `doc_id`, `receipt_id`, `order_cms_id`, `order_cms_fullname`, `order_cms_company`, `order_cms_department`, `order_product_id`, `order_product_barcode`, `order_product_name`, `order_mat_group`, `order_mat_name`, `order_product_qty`, `order_price_exc_vat`, `order_price_inc_vat`) VALUES
(99, 0, 0, '', '', '', '', '', '', '', '', '', '', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `ou_transaction`
--

CREATE TABLE `ou_transaction` (
  `doc_id` int(10) NOT NULL,
  `doc_name` varchar(50) NOT NULL,
  `date_create` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `ou_transaction`
--

INSERT INTO `ou_transaction` (`doc_id`, `doc_name`, `date_create`) VALUES
(99, '0', '0000-00-00 00:00:00');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `ou_orderupload`
--
ALTER TABLE `ou_orderupload`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `doc_id` (`doc_id`);

--
-- Indexes for table `ou_transaction`
--
ALTER TABLE `ou_transaction`
  ADD PRIMARY KEY (`doc_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
