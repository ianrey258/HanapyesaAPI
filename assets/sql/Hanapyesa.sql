-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 29, 2020 at 09:17 AM
-- Server version: 10.1.40-MariaDB
-- PHP Version: 7.1.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
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
  `bidItemId` int(11) NOT NULL,
  `accountId` int(11) NOT NULL,
  `suggestedItemId` int(11) DEFAULT NULL,
  `requestStatus` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `bidders`
--

INSERT INTO `bidders` (`id`, `bidItemId`, `accountId`, `suggestedItemId`, `requestStatus`) VALUES
(16, 21, 26, 26, 12),
(17, 22, 26, 27, 12),
(18, 23, 26, 28, 17),
(19, 24, 26, 30, 16);

-- --------------------------------------------------------

--
-- Table structure for table `bid_chat_area`
--

CREATE TABLE `bid_chat_area` (
  `id` int(11) NOT NULL,
  `bidItemId` int(11) NOT NULL,
  `recieverId` int(11) NOT NULL,
  `senderId` int(11) NOT NULL,
  `message` varchar(255) NOT NULL,
  `datetime` datetime NOT NULL,
  `messageType` int(11) NOT NULL,
  `status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `bid_item`
--

CREATE TABLE `bid_item` (
  `id` int(11) NOT NULL,
  `bidItem` int(11) NOT NULL,
  `datetime` date NOT NULL,
  `sendLocation` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `bid_item`
--

INSERT INTO `bid_item` (`id`, `bidItem`, `datetime`, `sendLocation`) VALUES
(21, 26, '2020-06-23', 9000),
(22, 27, '2020-06-23', 9000),
(23, 28, '2020-06-23', 9000),
(24, 29, '2020-06-25', 9000);

-- --------------------------------------------------------

--
-- Table structure for table `bid_item_detail`
--

CREATE TABLE `bid_item_detail` (
  `id` int(11) NOT NULL,
  `itemName` varchar(255) NOT NULL,
  `itemPriceorBudget` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `bid_item_detail`
--

INSERT INTO `bid_item_detail` (`id`, `itemName`, `itemPriceorBudget`, `description`) VALUES
(26, 'iahrud', '600', 'hsud'),
(27, 'ianudud', '600', 'hdhx'),
(28, 'short', '100', 'bahalag 2nd hand'),
(29, 'Laptop', '2500', 'Bahalag 2nd hand'),
(30, 'Asus laptop - 9800', '2000', '1 year used');

-- --------------------------------------------------------

--
-- Table structure for table `bid_item_img`
--

CREATE TABLE `bid_item_img` (
  `id` int(11) NOT NULL,
  `parentId` int(11) NOT NULL,
  `filename` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `bid_item_img`
--

INSERT INTO `bid_item_img` (`id`, `parentId`, `filename`) VALUES
(2, 29, '527602_IMG_20200218_140238.jpg'),
(3, 29, '291386_IMG_20200218_140238.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `bid_manager`
--

CREATE TABLE `bid_manager` (
  `ownerId` int(11) NOT NULL,
  `bidItemId` int(11) NOT NULL,
  `bidStatus` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `bid_manager`
--

INSERT INTO `bid_manager` (`ownerId`, `bidItemId`, `bidStatus`) VALUES
(6, 21, 5),
(6, 22, 5),
(6, 23, 5),
(6, 24, 5);

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
(1, 37, '124.6318254', '8.505401'),
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
-- Dumping data for table `item`
--

INSERT INTO `item` (`id`, `itemName`, `itemPrice`, `itemDescription`, `itemStack`, `itemRating`, `tagId`, `categoryId`, `topupId`) VALUES
(1, 'Laptop (Asus)', '2500', 'Brand New', '5', 0, 1, 5, 1);

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

--
-- Dumping data for table `item_img`
--

INSERT INTO `item_img` (`id`, `parentId`, `filename`) VALUES
(1, 1, '353486_IMG_20200218_140238.jpg');

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
-- Dumping data for table `item_rating`
--

INSERT INTO `item_rating` (`itemId`, `star5`, `star4`, `star3`, `star2`, `star1`) VALUES
(1, 0, 0, 0, 0, 0);

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
-- Table structure for table `messagetype`
--

CREATE TABLE `messagetype` (
  `id` int(11) NOT NULL,
  `messageType` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `messagetype`
--

INSERT INTO `messagetype` (`id`, `messageType`) VALUES
(1, 'Text'),
(2, 'Picture'),
(3, 'Video'),
(4, 'File');

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
(4, 'Item Request'),
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
(5, 'Open'),
(6, 'Pending'),
(7, 'Received'),
(8, 'Sending'),
(9, 'Read'),
(10, 'Unread'),
(11, 'Abort'),
(12, 'Waiting'),
(13, 'Verify'),
(14, 'Reverify'),
(15, 'Verifying'),
(16, 'Accept'),
(17, 'Decline'),
(18, 'Delete');

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
(51, 7, 'jsjsj', 'jsjsj', 'jsjsj', 0, 0, 0, 14);

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

--
-- Dumping data for table `storeitem`
--

INSERT INTO `storeitem` (`storeId`, `itemId`) VALUES
(37, 1);

-- --------------------------------------------------------

--
-- Table structure for table `store_chat_area`
--

CREATE TABLE `store_chat_area` (
  `id` int(11) NOT NULL,
  `recieverId` int(11) NOT NULL,
  `senderId` int(11) NOT NULL,
  `message` varchar(255) NOT NULL,
  `datetime` datetime NOT NULL,
  `messageType` int(11) NOT NULL,
  `status` int(11) NOT NULL
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
(11, 'SampleData', 'SampleData', 'User'),
(12, 'Demo', 'demo', 'User');

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
  `zipCode` varchar(255) NOT NULL DEFAULT '0',
  `accountStatus` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_account`
--

INSERT INTO `user_account` (`id`, `userId`, `firstname`, `lastname`, `contactNo`, `gender`, `email`, `zipCode`, `accountStatus`) VALUES
(6, 7, 'Ianrey', 'Acampado', '09752662481', 'Male', 'ianreyinfinity@gmail.com', '9000', 1),
(7, 8, 'Beta ', 'Test', '8888', 'Female', 'secret', '0', 1),
(26, 11, 'Ianrey', 'Acampado', '09752662481', 'male', 'email@gmail', '9000', 1),
(27, 12, 'Beta', 'Testing', '09752662481', 'Male', 'mai.com', '9000', 1);

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
(22, 26, '555555_IMG_20180521_093119.jpg'),
(23, 27, '666666_IMG_20180521_093119.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `user_notification`
--

CREATE TABLE `user_notification` (
  `id` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `message` varchar(255) NOT NULL,
  `dateRecieved` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `notificationType` int(11) NOT NULL,
  `status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_notification`
--

INSERT INTO `user_notification` (`id`, `userId`, `message`, `dateRecieved`, `notificationType`, `status`) VALUES
(4, 6, 'Congrastulations! you can now Sell your Scap Things Using this App.', '2020-02-07 00:00:00', 2, 9),
(25, 7, 'Sorry you cant manage your store yet due to your verification Image. Please check your Email Thank you!', '2020-03-12 00:00:00', 2, 10),
(32, 7, 'this is admin men', '2019-08-08 00:00:00', 1, 9),
(45, 26, 'Hey Somebody is looking for iahrud on your Location with a Budget of P600', '2020-06-23 00:00:00', 4, 9),
(46, 26, 'Hey Somebody is looking for ianudud on your Location with a Budget of P600', '2020-06-23 00:00:00', 4, 10),
(47, 26, 'Hey Somebody is looking for short on your Location with a Budget of P100', '2020-06-23 00:00:00', 4, 10),
(48, 26, 'Hey Somebody is looking for laptop on your Location with a Budget of P2500', '2020-06-25 00:00:00', 4, 10),
(49, 7, 'Sorry you cant manage your store yet due to your verification Image. Please check your Email Thank you!', '2020-06-26 00:00:00', 2, 10);

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
  `location` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `zip_code`
--

INSERT INTO `zip_code` (`id`, `location`) VALUES
(0, 'None'),
(9000, 'Cagayan de Oro City'),
(9001, 'Tagoloan'),
(9002, 'Villanueva'),
(9003, 'Jasaan'),
(9004, 'Claveria'),
(9005, 'Balingasag'),
(9006, 'Lagonglong'),
(9007, 'Salay'),
(9008, 'Binuangan'),
(9009, 'Sugbongcogon'),
(9010, 'Kinogitan'),
(9011, 'Balinguan'),
(9012, 'Talisayan'),
(9013, 'Medina'),
(9014, 'Gingoog City'),
(9015, 'Magsaysay'),
(9016, 'Opol'),
(9017, 'El Salvador'),
(9018, 'Alubijid'),
(9019, 'Laguindingan'),
(9020, 'Gitagum'),
(9021, 'Libertad'),
(9022, 'Initao'),
(9023, 'Naawan'),
(9024, 'Manticao'),
(9025, 'Lugait');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bidders`
--
ALTER TABLE `bidders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `bidsectionId` (`bidItemId`),
  ADD KEY `accountId` (`accountId`),
  ADD KEY `bidders_ibfk_4` (`suggestedItemId`),
  ADD KEY `requestStatus` (`requestStatus`);

--
-- Indexes for table `bid_chat_area`
--
ALTER TABLE `bid_chat_area`
  ADD PRIMARY KEY (`id`),
  ADD KEY `status` (`status`),
  ADD KEY `bidItemId` (`bidItemId`),
  ADD KEY `bid_chat_area_ibfk_5` (`messageType`),
  ADD KEY `bid_chat_area_ibfk_2` (`recieverId`),
  ADD KEY `senderId` (`senderId`);

--
-- Indexes for table `bid_item`
--
ALTER TABLE `bid_item`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sendLoction` (`sendLocation`),
  ADD KEY `bidItem` (`bidItem`);

--
-- Indexes for table `bid_item_detail`
--
ALTER TABLE `bid_item_detail`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `bid_item_img`
--
ALTER TABLE `bid_item_img`
  ADD PRIMARY KEY (`id`),
  ADD KEY `bid_item_img_ibfk_1` (`parentId`);

--
-- Indexes for table `bid_manager`
--
ALTER TABLE `bid_manager`
  ADD KEY `ownerId` (`ownerId`),
  ADD KEY `bidItemId` (`bidItemId`),
  ADD KEY `bidStatus` (`bidStatus`);

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
-- Indexes for table `messagetype`
--
ALTER TABLE `messagetype`
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
-- Indexes for table `store_chat_area`
--
ALTER TABLE `store_chat_area`
  ADD PRIMARY KEY (`id`),
  ADD KEY `recieverId` (`recieverId`),
  ADD KEY `senderId` (`senderId`),
  ADD KEY `status` (`status`),
  ADD KEY `messageType` (`messageType`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `bid_chat_area`
--
ALTER TABLE `bid_chat_area`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `bid_item`
--
ALTER TABLE `bid_item`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `bid_item_detail`
--
ALTER TABLE `bid_item_detail`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `bid_item_img`
--
ALTER TABLE `bid_item_img`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `gio_address`
--
ALTER TABLE `gio_address`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `item`
--
ALTER TABLE `item`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `item_category`
--
ALTER TABLE `item_category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `item_img`
--
ALTER TABLE `item_img`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `item_tags`
--
ALTER TABLE `item_tags`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `messagetype`
--
ALTER TABLE `messagetype`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

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
-- AUTO_INCREMENT for table `store_chat_area`
--
ALTER TABLE `store_chat_area`
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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `user_account`
--
ALTER TABLE `user_account`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `user_img`
--
ALTER TABLE `user_img`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `user_notification`
--
ALTER TABLE `user_notification`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- AUTO_INCREMENT for table `user_reports`
--
ALTER TABLE `user_reports`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bidders`
--
ALTER TABLE `bidders`
  ADD CONSTRAINT `bidders_ibfk_2` FOREIGN KEY (`bidItemId`) REFERENCES `bid_item` (`id`),
  ADD CONSTRAINT `bidders_ibfk_3` FOREIGN KEY (`accountId`) REFERENCES `user_account` (`id`),
  ADD CONSTRAINT `bidders_ibfk_4` FOREIGN KEY (`suggestedItemId`) REFERENCES `bid_item_detail` (`id`),
  ADD CONSTRAINT `bidders_ibfk_5` FOREIGN KEY (`requestStatus`) REFERENCES `statustype` (`id`);

--
-- Constraints for table `bid_chat_area`
--
ALTER TABLE `bid_chat_area`
  ADD CONSTRAINT `bid_chat_area_ibfk_2` FOREIGN KEY (`recieverId`) REFERENCES `user_account` (`id`),
  ADD CONSTRAINT `bid_chat_area_ibfk_3` FOREIGN KEY (`status`) REFERENCES `statustype` (`id`),
  ADD CONSTRAINT `bid_chat_area_ibfk_4` FOREIGN KEY (`bidItemId`) REFERENCES `bid_item` (`id`),
  ADD CONSTRAINT `bid_chat_area_ibfk_5` FOREIGN KEY (`messageType`) REFERENCES `messagetype` (`id`),
  ADD CONSTRAINT `bid_chat_area_ibfk_6` FOREIGN KEY (`senderId`) REFERENCES `user_account` (`id`);

--
-- Constraints for table `bid_item`
--
ALTER TABLE `bid_item`
  ADD CONSTRAINT `bid_item_ibfk_3` FOREIGN KEY (`sendLocation`) REFERENCES `zip_code` (`id`),
  ADD CONSTRAINT `bid_item_ibfk_4` FOREIGN KEY (`bidItem`) REFERENCES `bid_item_detail` (`id`);

--
-- Constraints for table `bid_item_img`
--
ALTER TABLE `bid_item_img`
  ADD CONSTRAINT `bid_item_img_ibfk_1` FOREIGN KEY (`parentId`) REFERENCES `bid_item_detail` (`id`);

--
-- Constraints for table `bid_manager`
--
ALTER TABLE `bid_manager`
  ADD CONSTRAINT `bid_manager_ibfk_1` FOREIGN KEY (`ownerId`) REFERENCES `user_account` (`id`),
  ADD CONSTRAINT `bid_manager_ibfk_2` FOREIGN KEY (`bidItemId`) REFERENCES `bid_item` (`id`),
  ADD CONSTRAINT `bid_manager_ibfk_3` FOREIGN KEY (`bidStatus`) REFERENCES `statustype` (`id`);

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
-- Constraints for table `store_chat_area`
--
ALTER TABLE `store_chat_area`
  ADD CONSTRAINT `store_chat_area_ibfk_1` FOREIGN KEY (`recieverId`) REFERENCES `store` (`id`),
  ADD CONSTRAINT `store_chat_area_ibfk_2` FOREIGN KEY (`senderId`) REFERENCES `user_account` (`id`),
  ADD CONSTRAINT `store_chat_area_ibfk_3` FOREIGN KEY (`status`) REFERENCES `statustype` (`id`),
  ADD CONSTRAINT `store_chat_area_ibfk_4` FOREIGN KEY (`messageType`) REFERENCES `messagetype` (`id`);

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
