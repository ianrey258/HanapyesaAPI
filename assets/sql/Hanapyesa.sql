-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 25, 2020 at 11:50 AM
-- Server version: 10.1.40-MariaDB
-- PHP Version: 7.1.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hanapyesa`
--
CREATE DATABASE IF NOT EXISTS `hanapyesa` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `hanapyesa`;

-- --------------------------------------------------------

--
-- Table structure for table `bidders`
--

CREATE TABLE `bidders` (
  `id` int(11) NOT NULL,
  `bidsectionId` int(11) NOT NULL,
  `accountId` int(11) NOT NULL,
  `itemId` int(11) NOT NULL,
  `isWinner` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `bid_item`
--

CREATE TABLE `bid_item` (
  `id` int(11) NOT NULL,
  `accountId` int(11) NOT NULL,
  `bidItem` int(11) NOT NULL,
  `budgetMoney` int(11) NOT NULL,
  `bidStatus` int(11) NOT NULL,
  `datetime` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `gio_address`
--

CREATE TABLE `gio_address` (
  `id` int(11) NOT NULL,
  `storeId` int(11) NOT NULL,
  `longitude` varchar(255) NOT NULL,
  `latitude` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `gio_address`
--

INSERT INTO `gio_address` (`id`, `storeId`, `longitude`, `latitude`) VALUES
(1, 37, '59.19149', '129.60606'),
(15, 51, '0', '0');

-- --------------------------------------------------------

--
-- Table structure for table `item`
--

CREATE TABLE `item` (
  `id` int(11) NOT NULL,
  `itemName` varchar(255) NOT NULL,
  `itemPrice` varchar(255) NOT NULL,
  `itemDescription` varchar(255) NOT NULL,
  `itemStack` varchar(255) NOT NULL,
  `itemRating` double NOT NULL,
  `tagId` int(11) NOT NULL,
  `categoryId` int(11) NOT NULL,
  `topupId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Triggers `item`
--
DELIMITER $$
CREATE TRIGGER `deleteOtherConstraints` BEFORE DELETE ON `item` FOR EACH ROW BEGIN
 DELETE FROM `item_img` WHERE parentId = old.id;
 DELETE FROM `item_reviews` WHERE itemId = old.id;
 DELETE FROM `item_rating` WHERE itemId = old.id;
 DELETE FROM `storeitem` WHERE itemId = old.id;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `makedefaultRating` AFTER INSERT ON `item` FOR EACH ROW BEGIN
INSERT INTO item_rating VALUES (new.id,'0','0','0','0','0');
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `item_category`
--

CREATE TABLE `item_category` (
  `id` int(11) NOT NULL,
  `categoryName` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `item_category`
--

INSERT INTO `item_category` (`id`, `categoryName`) VALUES
(1, 'Other'),
(2, 'Motorcyle'),
(3, 'Bycicle'),
(4, 'Gadgets'),
(5, 'Computer'),
(6, 'Electronic'),
(7, 'Truck');

-- --------------------------------------------------------

--
-- Table structure for table `item_img`
--

CREATE TABLE `item_img` (
  `id` int(11) NOT NULL,
  `parentId` int(11) NOT NULL,
  `filename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `item_rating`
--

CREATE TABLE `item_rating` (
  `itemId` int(11) NOT NULL,
  `star5` int(11) NOT NULL DEFAULT '0',
  `star4` int(11) NOT NULL DEFAULT '0',
  `star3` int(11) NOT NULL DEFAULT '0',
  `star2` int(11) NOT NULL DEFAULT '0',
  `star1` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Triggers `item_rating`
--
DELIMITER $$
CREATE TRIGGER `updateItemRating` AFTER UPDATE ON `item_rating` FOR EACH ROW BEGIN 
UPDATE item SET itemRating = Round(((new.5_Star*5 + new.4_Star*4 + new.3_Star*3 + new.2_Star*2 + new.1_Star*1)/(new.5_Star+new.4_Star+new.3_Star+new.2_Star+new.1_Star)),1) WHERE id = new.itemId;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `item_reviews`
--

CREATE TABLE `item_reviews` (
  `itemId` int(11) NOT NULL,
  `useraccountId` int(11) NOT NULL,
  `comment` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `item_tags`
--

CREATE TABLE `item_tags` (
  `id` int(11) NOT NULL,
  `tagName` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `item_tags`
--

INSERT INTO `item_tags` (`id`, `tagName`) VALUES
(1, 'Other'),
(2, 'Dynamo'),
(3, 'Ram'),
(4, 'CPU'),
(5, 'Fan'),
(6, 'Bearing'),
(7, 'Motherboard'),
(8, 'Motor Chases'),
(9, 'iPhone Headset'),
(10, 'Mechanical Keyboard'),
(11, 'CPU FAN'),
(12, 'Motor cycle Headlight'),
(13, 'Side Mirror'),
(14, 'Motor Wheel'),
(15, 'Truck Wheel'),
(16, 'steering Wheel '),
(17, 'Computer Mouse'),
(18, 'Classic Keyboard'),
(19, 'Mouse Pad'),
(20, 'Center Bolt'),
(21, 'Radiator'),
(22, 'Drum Bolt'),
(23, 'Propeller'),
(24, 'Break Drum'),
(25, 'Computer Monitor'),
(26, 'Ignition'),
(27, 'Blowing Horn'),
(28, 'M.2'),
(29, 'CD ROM'),
(30, 'SSD'),
(31, 'Cellphone Screen'),
(32, 'Tempered Glass'),
(33, 'Cellphone Charger'),
(34, 'Vehicle Battery'),
(35, 'Cellphone Battery'),
(36, 'Cellphone Board');

-- --------------------------------------------------------

--
-- Table structure for table `notificationtype`
--

CREATE TABLE `notificationtype` (
  `id` int(11) NOT NULL,
  `notificationType` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `notificationtype`
--

INSERT INTO `notificationtype` (`id`, `notificationType`) VALUES
(1, 'Bid Chat'),
(2, 'New Store'),
(3, 'Item Reservation'),
(4, 'Request Item'),
(5, 'Admin');

-- --------------------------------------------------------

--
-- Table structure for table `order`
--

CREATE TABLE `order` (
  `id` int(11) NOT NULL,
  `customerId` int(11) NOT NULL,
  `datetime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `orderStatus` int(11) NOT NULL,
  `taxId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `order_list`
--

CREATE TABLE `order_list` (
  `orderId` int(11) NOT NULL,
  `itemId` int(11) NOT NULL,
  `orderQty` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `statustype`
--

CREATE TABLE `statustype` (
  `id` int(11) NOT NULL,
  `statusName` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `statustype`
--

INSERT INTO `statustype` (`id`, `statusName`) VALUES
(1, 'Active'),
(2, 'Inactive'),
(3, 'Banned'),
(4, 'Closed'),
(5, 'Opened'),
(6, 'Pending'),
(7, 'Received'),
(8, 'Sending'),
(9, 'Read'),
(10, 'Unread'),
(11, 'Abort'),
(12, 'Waiting'),
(13, 'Verify'),
(14, 'Reverify'),
(15, 'Verifying');

-- --------------------------------------------------------

--
-- Table structure for table `store`
--

CREATE TABLE `store` (
  `id` int(11) NOT NULL,
  `accountId` int(11) NOT NULL,
  `storeName` varchar(255) NOT NULL,
  `storeInfo` varchar(255) NOT NULL,
  `storeAddress` varchar(255) NOT NULL,
  `storeRating` double NOT NULL DEFAULT '0',
  `storeFollowers` int(11) NOT NULL DEFAULT '0',
  `storeVisited` int(11) NOT NULL DEFAULT '0',
  `storeStatus` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `store`
--

INSERT INTO `store` (`id`, `accountId`, `storeName`, `storeInfo`, `storeAddress`, `storeRating`, `storeFollowers`, `storeVisited`, `storeStatus`) VALUES
(37, 6, 'Ira Pyesa hanap', 'wala lang basta lang', 'kauswagan bongbongon', 0, 0, 0, 1),
(51, 7, 'jsjsj', 'jsjsj', 'jsjsj', 0, 0, 0, 15);

--
-- Triggers `store`
--
DELIMITER $$
CREATE TRIGGER `NotifyUserStore` AFTER UPDATE ON `store` FOR EACH ROW BEGIN
 IF old.storeStatus  = '15' AND new.storeStatus  = '1' THEN
	INSERT INTO user_notification VALUES (null,new.accountId,'Congratulations! you can now Sell your Scap Things Using this App.',CURRENT_DATE,'2','10');
    
 ELSEIF old.storeStatus = '15' AND new.storeStatus = '14' THEN
    INSERT INTO user_notification VALUES (null,new.accountId,'Sorry you cant manage your store yet due to your verification Image. Please check your Email Thank you!',CURRENT_DATE,'2','10');
 END IF;

END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `createVerificationAndLocation` AFTER INSERT ON `store` FOR EACH ROW BEGIN
 INSERT INTO store_veriification_img VALUES (null,new.id,'null');
 INSERT INTO gio_address VALUES (null,new.id,'0','0');
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `storefollowers`
--

CREATE TABLE `storefollowers` (
  `id` int(11) NOT NULL,
  `storeId` int(11) NOT NULL,
  `accountId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `storeitem`
--

CREATE TABLE `storeitem` (
  `storeId` int(11) NOT NULL,
  `itemId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `store_img`
--

CREATE TABLE `store_img` (
  `id` int(11) NOT NULL,
  `parentId` int(11) NOT NULL,
  `filename` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `store_img`
--

INSERT INTO `store_img` (`id`, `parentId`, `filename`) VALUES
(58, 37, '7583117_FB_IMG_1567424090399.jpg'),
(59, 37, '6861960_FB_IMG_1567424104552.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `store_rating`
--

CREATE TABLE `store_rating` (
  `storeId` int(11) NOT NULL,
  `star5` int(11) NOT NULL DEFAULT '0',
  `star4` int(11) NOT NULL DEFAULT '0',
  `star3` int(11) NOT NULL DEFAULT '0',
  `star2` int(11) NOT NULL DEFAULT '0',
  `star1` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `store_veriification_img`
--

CREATE TABLE `store_veriification_img` (
  `id` int(11) NOT NULL,
  `parentId` int(11) NOT NULL,
  `filename` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `store_veriification_img`
--

INSERT INTO `store_veriification_img` (`id`, `parentId`, `filename`) VALUES
(18, 51, '94274_FB_IMG_1567424104552.jpg'),
(32, 51, '94274_FB_IMG_1567424104552.jpg');

--
-- Triggers `store_veriification_img`
--
DELIMITER $$
CREATE TRIGGER `updateStoreStatus` AFTER UPDATE ON `store_veriification_img` FOR EACH ROW BEGIN
	UPDATE store SET storeStatus='15' WHERE id=new.parentId;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tax_percentage`
--

CREATE TABLE `tax_percentage` (
  `id` int(11) NOT NULL,
  `taxPercentage` int(11) NOT NULL,
  `effectivityDate` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tax_percentage`
--

INSERT INTO `tax_percentage` (`id`, `taxPercentage`, `effectivityDate`) VALUES
(1, 5, '2015-12-10');

-- --------------------------------------------------------

--
-- Table structure for table `topup_percentage`
--

CREATE TABLE `topup_percentage` (
  `id` int(11) NOT NULL,
  `topupPercentage` int(11) NOT NULL,
  `effectivityDate` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `topup_percentage`
--

INSERT INTO `topup_percentage` (`id`, `topupPercentage`, `effectivityDate`) VALUES
(1, 2, '2020-03-01');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `userType` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `username`, `password`, `userType`) VALUES
(7, 'ianreyqaz', '123456', 'User'),
(8, 'Admin', 'admin', 'User'),
(11, 'SampleData', 'SampleData', 'User');

-- --------------------------------------------------------

--
-- Table structure for table `user_account`
--

CREATE TABLE `user_account` (
  `id` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `firstname` varchar(255) NOT NULL,
  `lastname` varchar(255) NOT NULL,
  `contactNo` varchar(255) NOT NULL,
  `gender` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `accountStatus` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_account`
--

INSERT INTO `user_account` (`id`, `userId`, `firstname`, `lastname`, `contactNo`, `gender`, `email`, `accountStatus`) VALUES
(6, 7, 'Ianrey', 'Acampado', '09752662481', 'Male', 'ianreyinfinity@gmail.com', 1),
(7, 8, 'Beta ', 'Test', '8888', 'Female', 'secret', 1),
(26, 11, 'Ianrey', 'Acampado', '09752662481', 'male', 'email@gmail', 1);

--
-- Triggers `user_account`
--
DELIMITER $$
CREATE TRIGGER `Create_NullFilename` AFTER INSERT ON `user_account` FOR EACH ROW BEGIN
INSERT INTO user_img VALUES (null,new.id,'null');
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `user_img`
--

CREATE TABLE `user_img` (
  `id` int(11) NOT NULL,
  `parentId` int(11) NOT NULL,
  `filename` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_img`
--

INSERT INTO `user_img` (`id`, `parentId`, `filename`) VALUES
(2, 6, '177405_IMG_20180521_093119.jpg'),
(3, 7, '238247_2357d312-0096-44f0-b929-749ec0bc8a0e-1165095321.jpg'),
(5, 6, 'null'),
(6, 6, 'null'),
(7, 6, 'null'),
(8, 6, 'null'),
(9, 6, 'null'),
(10, 6, 'null'),
(11, 6, 'null'),
(12, 6, 'null'),
(13, 6, 'null'),
(14, 6, 'null'),
(15, 6, 'null'),
(16, 6, 'null'),
(17, 6, 'null'),
(18, 6, 'null'),
(19, 6, 'null'),
(20, 6, 'null'),
(21, 6, 'null'),
(22, 26, 'null');

-- --------------------------------------------------------

--
-- Table structure for table `user_notification`
--

CREATE TABLE `user_notification` (
  `id` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `message` varchar(255) NOT NULL,
  `dateRecieved` date NOT NULL,
  `notificationType` int(11) NOT NULL,
  `status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_notification`
--

INSERT INTO `user_notification` (`id`, `userId`, `message`, `dateRecieved`, `notificationType`, `status`) VALUES
(4, 6, 'Congrastulations! you can now Sell your Scap Things Using this App.', '2020-02-07', 2, 9),
(5, 6, 'Congrastulations! you can now Sell your Scap Things Using this App.', '2020-03-01', 2, 9),
(6, 6, 'Congrastulations! you can now Sell your Scap Things Using this App.', '2020-03-03', 2, 9),
(7, 6, 'Congrastulations! you can now Sell your Scap Things Using this App.', '2020-03-06', 2, 10),
(8, 6, 'Congrastulations! you can now Sell your Scap Things Using this App.', '2020-03-09', 2, 10),
(9, 6, 'Congrastulations! you can now Sell your Scap Things Using this App.', '2020-03-09', 2, 10),
(10, 6, 'Congrastulations! you can now Sell your Scap Things Using this App.', '2020-03-09', 2, 10),
(11, 6, 'Congrastulations! you can now Sell your Scap Things Using this App.', '2020-03-09', 2, 10),
(12, 6, 'Congrastulations! you can now Sell your Scap Things Using this App.', '2020-03-09', 2, 10),
(13, 6, 'Congrastulations! you can now Sell your Scap Things Using this App.', '2020-03-09', 2, 10),
(14, 6, 'Congrastulations! you can now Sell your Scap Things Using this App.', '2020-03-09', 2, 10),
(15, 6, 'Congrastulations! you can now Sell your Scap Things Using this App.', '2020-03-09', 2, 9),
(16, 6, 'Congrastulations! you can now Sell your Scap Things Using this App.', '2020-03-09', 2, 9),
(17, 6, 'Congrastulations! you can now Sell your Scap Things Using this App.', '2020-03-09', 2, 10),
(18, 6, 'Congratulations! you can now Sell your Scap Things Using this App.', '2020-03-09', 2, 9),
(20, 7, 'Sorry you cant manage your store yet due to your verification Image. Please check your Email Thank you!', '2020-03-12', 2, 10),
(21, 7, 'Sorry you cant manage your store yet due to your verification Image. Please check your Email Thank you!', '2020-03-12', 2, 10),
(22, 7, 'Sorry you cant manage your store yet due to your verification Image. Please check your Email Thank you!', '2020-03-12', 2, 9),
(23, 7, 'Sorry you cant manage your store yet due to your verification Image. Please check your Email Thank you!', '2020-03-12', 2, 10),
(24, 7, 'Sorry you cant manage your store yet due to your verification Image. Please check your Email Thank you!', '2020-03-12', 2, 10),
(25, 7, 'Sorry you cant manage your store yet due to your verification Image. Please check your Email Thank you!', '2020-03-12', 2, 10);

-- --------------------------------------------------------

--
-- Table structure for table `user_reports`
--

CREATE TABLE `user_reports` (
  `id` int(11) NOT NULL,
  `userAccountId` int(11) NOT NULL,
  `message` varchar(255) NOT NULL,
  `datetime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `reportStatus` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `zip_code`
--

CREATE TABLE `zip_code` (
  `id` int(11) NOT NULL,
  `province` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bidders`
--
ALTER TABLE `bidders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `accountId` (`accountId`),
  ADD KEY `bidsectionId` (`bidsectionId`);

--
-- Indexes for table `bid_item`
--
ALTER TABLE `bid_item`
  ADD PRIMARY KEY (`id`),
  ADD KEY `accountId` (`accountId`);

--
-- Indexes for table `gio_address`
--
ALTER TABLE `gio_address`
  ADD PRIMARY KEY (`id`),
  ADD KEY `storeId` (`storeId`);

--
-- Indexes for table `item`
--
ALTER TABLE `item`
  ADD PRIMARY KEY (`id`),
  ADD KEY `categoryId` (`categoryId`),
  ADD KEY `tagId` (`tagId`),
  ADD KEY `topupId` (`topupId`);

--
-- Indexes for table `item_category`
--
ALTER TABLE `item_category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `item_img`
--
ALTER TABLE `item_img`
  ADD PRIMARY KEY (`id`),
  ADD KEY `parentId` (`parentId`);

--
-- Indexes for table `item_rating`
--
ALTER TABLE `item_rating`
  ADD PRIMARY KEY (`itemId`);

--
-- Indexes for table `item_reviews`
--
ALTER TABLE `item_reviews`
  ADD KEY `itemId` (`itemId`);

--
-- Indexes for table `item_tags`
--
ALTER TABLE `item_tags`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notificationtype`
--
ALTER TABLE `notificationtype`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `order`
--
ALTER TABLE `order`
  ADD PRIMARY KEY (`id`),
  ADD KEY `customerId` (`customerId`),
  ADD KEY `taxId` (`taxId`);

--
-- Indexes for table `order_list`
--
ALTER TABLE `order_list`
  ADD KEY `itemId` (`itemId`),
  ADD KEY `orderId` (`orderId`);

--
-- Indexes for table `statustype`
--
ALTER TABLE `statustype`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `store`
--
ALTER TABLE `store`
  ADD PRIMARY KEY (`id`),
  ADD KEY `accountId` (`accountId`),
  ADD KEY `storeStatus` (`storeStatus`);

--
-- Indexes for table `storefollowers`
--
ALTER TABLE `storefollowers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `accountId` (`accountId`),
  ADD KEY `storeId` (`storeId`);

--
-- Indexes for table `storeitem`
--
ALTER TABLE `storeitem`
  ADD KEY `itemId` (`itemId`),
  ADD KEY `storeId` (`storeId`);

--
-- Indexes for table `store_img`
--
ALTER TABLE `store_img`
  ADD PRIMARY KEY (`id`),
  ADD KEY `storeId` (`parentId`);

--
-- Indexes for table `store_rating`
--
ALTER TABLE `store_rating`
  ADD KEY `storeId` (`storeId`);

--
-- Indexes for table `store_veriification_img`
--
ALTER TABLE `store_veriification_img`
  ADD PRIMARY KEY (`id`),
  ADD KEY `storeId` (`parentId`);

--
-- Indexes for table `tax_percentage`
--
ALTER TABLE `tax_percentage`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `topup_percentage`
--
ALTER TABLE `topup_percentage`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_account`
--
ALTER TABLE `user_account`
  ADD PRIMARY KEY (`id`),
  ADD KEY `accountStatus` (`accountStatus`),
  ADD KEY `userId` (`userId`);

--
-- Indexes for table `user_img`
--
ALTER TABLE `user_img`
  ADD PRIMARY KEY (`id`),
  ADD KEY `accountId` (`parentId`);

--
-- Indexes for table `user_notification`
--
ALTER TABLE `user_notification`
  ADD PRIMARY KEY (`id`),
  ADD KEY `status` (`status`),
  ADD KEY `notificationType` (`notificationType`),
  ADD KEY `userId` (`userId`);

--
-- Indexes for table `user_reports`
--
ALTER TABLE `user_reports`
  ADD PRIMARY KEY (`id`),
  ADD KEY `userId` (`userAccountId`);

--
-- Indexes for table `zip_code`
--
ALTER TABLE `zip_code`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bidders`
--
ALTER TABLE `bidders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `bid_item`
--
ALTER TABLE `bid_item`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `gio_address`
--
ALTER TABLE `gio_address`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `item`
--
ALTER TABLE `item`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `item_category`
--
ALTER TABLE `item_category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `item_img`
--
ALTER TABLE `item_img`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `item_tags`
--
ALTER TABLE `item_tags`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `notificationtype`
--
ALTER TABLE `notificationtype`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `order`
--
ALTER TABLE `order`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `statustype`
--
ALTER TABLE `statustype`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `store`
--
ALTER TABLE `store`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT for table `storefollowers`
--
ALTER TABLE `storefollowers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `store_img`
--
ALTER TABLE `store_img`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=60;

--
-- AUTO_INCREMENT for table `store_veriification_img`
--
ALTER TABLE `store_veriification_img`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `tax_percentage`
--
ALTER TABLE `tax_percentage`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `topup_percentage`
--
ALTER TABLE `topup_percentage`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `user_account`
--
ALTER TABLE `user_account`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `user_img`
--
ALTER TABLE `user_img`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `user_notification`
--
ALTER TABLE `user_notification`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `user_reports`
--
ALTER TABLE `user_reports`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `zip_code`
--
ALTER TABLE `zip_code`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bidders`
--
ALTER TABLE `bidders`
  ADD CONSTRAINT `bidders_ibfk_2` FOREIGN KEY (`bidsectionId`) REFERENCES `bid_item` (`id`);

--
-- Constraints for table `gio_address`
--
ALTER TABLE `gio_address`
  ADD CONSTRAINT `gio_address_ibfk_1` FOREIGN KEY (`storeId`) REFERENCES `store` (`id`);

--
-- Constraints for table `item`
--
ALTER TABLE `item`
  ADD CONSTRAINT `item_ibfk_1` FOREIGN KEY (`categoryId`) REFERENCES `item_category` (`id`),
  ADD CONSTRAINT `item_ibfk_2` FOREIGN KEY (`tagId`) REFERENCES `item_tags` (`id`),
  ADD CONSTRAINT `item_ibfk_3` FOREIGN KEY (`topupId`) REFERENCES `topup_percentage` (`id`);

--
-- Constraints for table `item_img`
--
ALTER TABLE `item_img`
  ADD CONSTRAINT `item_img_ibfk_1` FOREIGN KEY (`parentId`) REFERENCES `item` (`id`);

--
-- Constraints for table `item_rating`
--
ALTER TABLE `item_rating`
  ADD CONSTRAINT `item_rating_ibfk_1` FOREIGN KEY (`itemId`) REFERENCES `item` (`id`);

--
-- Constraints for table `item_reviews`
--
ALTER TABLE `item_reviews`
  ADD CONSTRAINT `item_reviews_ibfk_1` FOREIGN KEY (`itemId`) REFERENCES `item` (`id`);

--
-- Constraints for table `order`
--
ALTER TABLE `order`
  ADD CONSTRAINT `order_ibfk_2` FOREIGN KEY (`taxId`) REFERENCES `tax_percentage` (`id`);

--
-- Constraints for table `order_list`
--
ALTER TABLE `order_list`
  ADD CONSTRAINT `order_list_ibfk_1` FOREIGN KEY (`itemId`) REFERENCES `item` (`id`),
  ADD CONSTRAINT `order_list_ibfk_2` FOREIGN KEY (`orderId`) REFERENCES `order` (`id`);

--
-- Constraints for table `store`
--
ALTER TABLE `store`
  ADD CONSTRAINT `store_ibfk_2` FOREIGN KEY (`storeStatus`) REFERENCES `statustype` (`id`);

--
-- Constraints for table `storefollowers`
--
ALTER TABLE `storefollowers`
  ADD CONSTRAINT `storefollowers_ibfk_2` FOREIGN KEY (`storeId`) REFERENCES `store` (`id`);

--
-- Constraints for table `storeitem`
--
ALTER TABLE `storeitem`
  ADD CONSTRAINT `storeitem_ibfk_1` FOREIGN KEY (`itemId`) REFERENCES `item` (`id`),
  ADD CONSTRAINT `storeitem_ibfk_2` FOREIGN KEY (`storeId`) REFERENCES `store` (`id`);

--
-- Constraints for table `store_img`
--
ALTER TABLE `store_img`
  ADD CONSTRAINT `store_img_ibfk_1` FOREIGN KEY (`parentId`) REFERENCES `store` (`id`);

--
-- Constraints for table `store_rating`
--
ALTER TABLE `store_rating`
  ADD CONSTRAINT `store_rating_ibfk_1` FOREIGN KEY (`storeId`) REFERENCES `store` (`id`);

--
-- Constraints for table `store_veriification_img`
--
ALTER TABLE `store_veriification_img`
  ADD CONSTRAINT `store_veriification_img_ibfk_1` FOREIGN KEY (`parentId`) REFERENCES `store` (`id`);

--
-- Constraints for table `user_account`
--
ALTER TABLE `user_account`
  ADD CONSTRAINT `user_account_ibfk_1` FOREIGN KEY (`accountStatus`) REFERENCES `statustype` (`id`),
  ADD CONSTRAINT `user_account_ibfk_2` FOREIGN KEY (`userId`) REFERENCES `user` (`id`);

--
-- Constraints for table `user_notification`
--
ALTER TABLE `user_notification`
  ADD CONSTRAINT `user_notification_ibfk_1` FOREIGN KEY (`status`) REFERENCES `statustype` (`id`),
  ADD CONSTRAINT `user_notification_ibfk_2` FOREIGN KEY (`notificationType`) REFERENCES `notificationtype` (`id`),
  ADD CONSTRAINT `user_notification_ibfk_3` FOREIGN KEY (`userId`) REFERENCES `user_account` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
