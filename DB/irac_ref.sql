-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 15, 2026 at 10:41 PM
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
-- Database: `irac_ref`
--

-- --------------------------------------------------------

--
-- Table structure for table `active_ingredient`
--

CREATE TABLE `active_ingredient` (
  `c_id` int(11) NOT NULL,
  `c_name` varchar(255) DEFAULT NULL,
  `g_id` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `active_ingredient`
--

INSERT INTO `active_ingredient` (`c_id`, `c_name`, `g_id`) VALUES
(1, 'เมโทมิล (Methomyl)', '1A'),
(2, 'คาร์โบซัลแฟน (Carbosulfan)', '1A'),
(3, 'ฟีโนบูคาร์บ (Fenobucarb)', '1A'),
(4, 'คลอร์ไพริฟอส (Chlorpyrifos)', '1B'),
(5, 'อิมิดาโคลพริด (Imidacloprid)', '4A'),
(6, 'ฟลูเบนไดอะไมด์ (Flubendiamide)', '28'),
(7, 'คลอแรนทรานิลิโพรล (Chlorantraniliprole)', '28'),
(8, 'สไปนีโทแรม (Spinetoram)', '5'),
(9, 'สไปโรมีซิเฟน (Spiromesifen)', '23'),
(10, 'ไพเมโทรซีน (Pymetrozine)', '9B'),
(11, 'เฟนไพโรซิเมต', '21'),
(13, 'โพแทสเซียม ฟอสไฟต์', '33'),
(14, 'ไดเมโทมอร์ฟ', '40'),
(15, 'ไดฟีโนโคนาโซล', '3'),
(16, 'อะซอกซีสโตรบิน', '11'),
(17, 'ไซแอนทรานิลิโพรล', '28'),
(18, 'สไปโรเททราแมต', '23'),
(19, 'คอปเปอร์ ออกซีคลอไรด์', '100'),
(20, 'ฟีโนบูคาร์บ', '101'),
(21, 'คลอแรนทรานิลิโพรล', '28');

-- --------------------------------------------------------

--
-- Table structure for table `durian_calendar`
--

CREATE TABLE `durian_calendar` (
  `cal_id` int(11) NOT NULL,
  `month_range` varchar(50) DEFAULT NULL,
  `stage_name` varchar(100) DEFAULT NULL,
  `risk_pests` text DEFAULT NULL,
  `recommendation` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `durian_calendar`
--

INSERT INTO `durian_calendar` (`cal_id`, `month_range`, `stage_name`, `risk_pests`, `recommendation`) VALUES
(1, 'พฤศจิกายน - กุมภาพันธ์', 'ระยะสะสมอาหารและออกดอก', 'เพลี้ยไฟ, ไรแดง, หนอนกินดอก', 'เน่าตรวจสอบความชื้นในสวน อย่าปล่อยให้แห้งเกินไป พ่นสารป้องกันเพลี้ยไฟช่วงดอกตูม'),
(2, 'มีนาคม - พฤษภาคม', 'ระยะพัฒนาผลและติดผล', 'หนอนเจาะผล, หนอนเจาะเมล็ด, เพลี้ยแป้ง', 'ตัดแต่งผลที่ซ้อนทับกัน พ่นสารป้องกันหนอนเจาะผลตามวงรอบอายุผล'),
(3, 'มิถุนายน - ตุลาคม', 'ฤดูฝน / ระยะฟื้นฟูต้น', 'รากเน่าโคนเน่า, ใบติด, เพลี้ยไก่แจ้', 'ปรับสภาพดินด้วยปูนขาว ระบายน้ำออกจากโคนต้นให้ดี และพ่นยาป้องกันเชื้อราในช่วงฝนชุก');

-- --------------------------------------------------------

--
-- Table structure for table `ingredient_pest_control`
--

CREATE TABLE `ingredient_pest_control` (
  `c_id` int(11) NOT NULL,
  `pest_id` int(11) NOT NULL,
  `recommended_note` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ingredient_pest_control`
--

INSERT INTO `ingredient_pest_control` (`c_id`, `pest_id`, `recommended_note`) VALUES
(1, 1, 'พ่นช่วงแตกใบอ่อน (กลุ่ม 4A)'),
(1, 7, 'พ่นช่วงติดผลอ่อน (กลุ่ม 4A)'),
(1, 8, 'พ่นช่วงดอกบาน (กลุ่ม 4A)'),
(1, 9, 'พ่นยาผสมไวท์ออยล์'),
(1, 10, 'ฉีดพ่นหรือทาที่ลำต้น'),
(1, 11, 'ใช้ฟิโพรนิลฉีดเข้าเข็ม'),
(1, 16, 'พ่นเมื่อพบหนอนกัดกินใบ'),
(1, 17, 'พ่นระยะแตกใบอ่อน'),
(1, 19, 'พ่นกิ่งที่พบรูเจาะ (กลุ่ม 4A)'),
(5, 1, 'สลับกลุ่มเพื่อป้องกันการดื้อยา'),
(5, 9, 'กลุ่ม 4A พ่นซ้ำทุก 7 วัน'),
(5, 12, 'กลุ่ม FRAC 3 (เฮกซะโคนาโซล)'),
(5, 13, 'พ่นช่วงดอกตูม'),
(5, 14, 'กลุ่ม FRAC 11 หรือ 3'),
(6, 2, 'พ่นเมื่อผลอายุ 1 เดือน (กลุ่ม 28)'),
(8, 2, 'เน้นฉีดพ่นที่ผล (กลุ่ม 5)'),
(8, 6, 'สลับกลุ่มยา (กลุ่ม 5)'),
(10, 3, 'พ่นเมื่อพบการระบาด (กลุ่ม 20)'),
(11, 3, 'สลับกลุ่มยาเพื่อป้องกันการดื้อยา (กลุ่ม 21)'),
(13, 4, 'ฉีดเข้าลำต้นกระตุ้นภูมิ (กลุ่ม 33)'),
(14, 4, 'พ่นใบในช่วงฝนชุก (กลุ่ม 40)'),
(15, 5, 'พ่นป้องกันช่วงใบอ่อน (กลุ่ม 3)'),
(16, 5, 'ใช้ระยะดอกและผล (กลุ่ม 11)'),
(16, 15, 'พ่นป้องกันในช่วงฤดูฝน'),
(17, 6, 'พ่นเมื่อผลอายุ 6-8 สัปดาห์'),
(18, 7, 'สารดูดซึมออกฤทธิ์นาน (กลุ่ม 23)'),
(18, 20, 'กำจัดแมลงปากดูดที่เป็นต้นเหตุ (กลุ่ม 23)'),
(19, 21, 'พ่นล้างต้นด้วยคอปเปอร์ (กลุ่ม M1)'),
(20, 22, 'พ่นเมื่อพบการระบาดที่ยอดอ่อน (กลุ่ม 1B)'),
(21, 18, 'พ่นช่วงดอกตูมและดอกบาน (กลุ่ม 28)');

-- --------------------------------------------------------

--
-- Table structure for table `irac_moa_group`
--

CREATE TABLE `irac_moa_group` (
  `g_id` varchar(10) NOT NULL,
  `g_name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `irac_moa_group`
--

INSERT INTO `irac_moa_group` (`g_id`, `g_name`) VALUES
('100', 'FRAC M1: สารประกอบทองแดง (Copper)'),
('101', 'Group 1B: ฟีโนบูคาร์บ (Fenobucarb)'),
('11', 'FRAC 11: อะซอกซีสโตรบิน (Azoxystrobin)'),
('1A', 'กลุ่ม 1A: คาร์บาเมต (Carbamates)'),
('1B', 'กลุ่ม 1B: ออร์กาโนฟอสเฟต (Organophosphates)'),
('20', 'Group 20: ไซเอนโนไพราเฟน (Cyenopyrafen)'),
('21', 'Group 21: เฟนไพโรซิเมต (Fenpyroximate)'),
('23', 'กลุ่ม 23: อนุพันธ์กรดเตโทรนิก (Tetronic acid derivatives)'),
('25', 'Group 25: สไปโรดิโคลเฟน (Spirodiclofen)'),
('28', 'กลุ่ม 28: ไดอะไมด์ (Diamides)'),
('3', 'FRAC 3: ไดฟีโนโคนาโซล (Difenoconazole)'),
('33', 'FRAC 33: กรดฟอสโฟนิก (Phosphorous acid)'),
('40', 'FRAC 40: ไดเมโทมอร์ฟ (Dimethomorph)'),
('4A', 'กลุ่ม 4A: นีโอนิโคตินอยด์ (Neonicotinoids)'),
('5', 'กลุ่ม 5: สไปโนซิน (Spinosyns)'),
('9B', 'กลุ่ม 9B: ไพเมโทรซีน (Pymetrozine)');

-- --------------------------------------------------------

--
-- Table structure for table `pest`
--

CREATE TABLE `pest` (
  `pest_id` int(11) NOT NULL,
  `pest_name` varchar(100) DEFAULT NULL,
  `image_url` text DEFAULT NULL,
  `description` text DEFAULT NULL,
  `category` enum('pest','disease') DEFAULT 'pest'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pest`
--

INSERT INTO `pest` (`pest_id`, `pest_name`, `image_url`, `description`, `category`) VALUES
(1, 'เพลี้ยไก่แจ้ทุเรียน', '/pests/psyllid.jpg', 'ตัวอ่อนดูดกินน้ำเลี้ยงใบอ่อน มีปุยขาวคล้ายหางไก่แจ้ ใบหงิกงอแห้ง', 'pest'),
(2, 'หนอนเจาะผลทุเรียน', '/pests/fruit_borer.jpg', 'เจาะผลกินเนื้อใน สังเกตเห็นมูลหนอนที่ผิวผล ทำให้ผลเน่าร่วง', 'pest'),
(3, 'ไรแดงแอฟริกัน', '/pests/red_mite.jpg', 'ดูดกินน้ำเลี้ยงใต้ใบ ใบจะเป็นจุดขาวซีดจนเป็นสีบรอนซ์เทา', 'pest'),
(4, 'โรครากเน่าโคนเน่า', '/pests/root_rot.jpg', 'เปลือกต้นเยิ้มเป็นน้ำสีน้ำตาล ใบเหลืองร่วง เกิดจากเชื้อราไฟทอปโธร่า', 'disease'),
(5, 'โรคแอนแทรคโนส', '/pests/anthracnose.jpg', 'ใบไหม้เป็นวงซ้อนกันสีน้ำตาล เริ่มจากปลายใบเข้าหาโคนใบ', 'disease'),
(6, 'หนอนเจาะเมล็ด', '/pests/seed_borer.jpg', 'เจาะกินเมล็ดในผล ไม่เห็นรูที่ผิวผลชัดเจน รู้ตัวเมื่อทุเรียนสุก', 'pest'),
(7, 'เพลี้ยแป้งทุเรียน', '/pests/mealybug.jpg', 'เกาะตามร่องหนาม ดูดน้ำเลี้ยงและขับถ่ายมูลหวานจนเกิดราดำ', 'pest'),
(8, 'เพลี้ยไฟทุเรียน', '/pests/thrips.jpg', 'ระบาดช่วงดอกและผลอ่อน ทำให้หนามจีบ/หนามแดง ผิวผลเสีย', 'pest'),
(9, 'เพลี้ยหอย', '/pests/scale_insect.jpg', 'เกาะดูดน้ำเลี้ยงตามกิ่งและใบ เห็นเป็นสะเก็ดสีน้ำตาล/ขาว ทำให้กิ่งแห้งตาย', 'pest'),
(10, 'มอดเจาะลำต้น', '/pests/stem_borer.jpg', 'เจาะรูเล็กๆ ตามลำต้นและกิ่ง มีขุยไม้และน้ำเลี้ยงเยิ้ม ต้นจะแห้งตายกะทันหัน', 'pest'),
(11, 'ด้วงบ่าหนาม', '/pests/longhorn_beetle.jpg', 'ตัวอ่อนเจาะกินใต้เปลือกไม้เป็นทางยาวรอบต้น ทำให้ท่อน้ำเลี้ยงถูกทำลาย', 'pest'),
(12, 'โรคราสีชมพู', '/pests/pink_disease.jpg', 'พบตามง่ามกิ่ง มีเส้นใยราสีขาวชมพู ทำให้เปลือกปริและกิ่งแห้งตาย', 'disease'),
(13, 'โรคราแป้ง', '/pests/powdery_mildew.jpg', 'พบที่ดอกและผลอ่อน มีผงสีขาวคล้ายแป้งคลุม ดอกร่วง ผลแคระแกร็น', 'disease'),
(14, 'โรคใบจุดตากบ', '/pests/leaf_spot.jpg', 'ใบเป็นจุดวงกลมสีน้ำตาล ขอบเข้ม กลางแผลสีซีดคล้ายตากบ พบมากช่วงฝนชุก', 'disease'),
(15, 'โรคใบติด (Rhizoctonia)', '/pests/leaf_blight.jpg', 'ใบเน่าเป็นจุดคล้ายน้ำร้อนลวก เส้นใยราทำให้ใบติดกันเป็นแผง ระบาดหนักช่วงฝนชุก', 'disease'),
(16, 'หนอนหน้าแมว', '/pests/cat_caterpillar.jpg', 'หนอนตัวแบนมีขนพิษ กัดกินใบจนเหลือแต่เส้นใบ ทำให้ต้นชะงักการเติบโต', 'pest'),
(17, 'เพลี้ยจักจั่นฝอย', '/pests/leafhopper.jpg', 'ตัวเล็กสีเขียวอ่อน กระโดดเร็ว ดูดกินน้ำเลี้ยงยอดอ่อน ทำให้ยอดแห้งไม้กวาด', 'pest'),
(18, 'หนอนกินดอกทุเรียน', '/pests/flower_caterpillar.jpg', 'กัดกินส่วนต่าง ๆ ของดอกทุเรียน โดยเฉพาะเกสร ทำให้ดอกร่วงหรือติดผลไม่สมบูรณ์', 'pest'),
(19, 'มอดเจาะกิ่งทุเรียน', '/pests/twig_borer.jpg', 'เจาะรูขนาดเล็กตามกิ่งทำให้กิ่งแห้งตาย มักพบระบาดรุนแรงในกิ่งขนาดเล็ก', 'pest'),
(20, 'โรคราดำ', '/pests/sooty_mold.jpg', 'คราบราสีดำปกคลุมใบและผล ขัดขวางการสังเคราะห์แสง เกิดจากมูลหวานของเพลี้ย', 'disease'),
(21, 'โรคจุดสนิม (สาหร่าย)', '/pests/algal_spot.jpg', 'จุดสีส้มคล้ายสนิมบนหน้าใบ เกิดจากสาหร่ายชนิดหนึ่ง พบมากในสวนที่ทรงพุ่มทึบ', 'disease'),
(22, 'เพลี้ยอ่อน', '/pests/aphids.jpg', 'ดูดกินน้ำเลี้ยงยอดอ่อนและใบอ่อน ทำให้ใบหงิกงอและเป็นแหล่งแพร่เชื้อไวรัส', 'pest'),
(23, 'โรคราเมล็ดผักกาด', '/pests/sclerotium.jpg', 'เน่าบริเวณโคนต้นหรือวัสดุปลูก มีเส้นใยขาวและเม็ดกลมเล็ก ๆ สีน้ำตาลคล้ายเมล็ดผักกาด', 'disease');

-- --------------------------------------------------------

--
-- Table structure for table `product_trade`
--

CREATE TABLE `product_trade` (
  `p_id` int(11) NOT NULL,
  `p_name` varchar(255) DEFAULT NULL,
  `c_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `spray_history`
--

CREATE TABLE `spray_history` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `pest_name` varchar(100) DEFAULT NULL,
  `moa_group` varchar(50) DEFAULT NULL,
  `spray_date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `usage_history`
--

CREATE TABLE `usage_history` (
  `log_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `pest_id` int(11) DEFAULT NULL,
  `g_id` varchar(10) DEFAULT NULL,
  `c_id` int(11) DEFAULT NULL,
  `p_id` int(11) DEFAULT NULL,
  `usage_date` date DEFAULT NULL,
  `location_note` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `name`) VALUES
(1, 'Admin', 'Admin', 'Admin');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `active_ingredient`
--
ALTER TABLE `active_ingredient`
  ADD PRIMARY KEY (`c_id`),
  ADD KEY `g_id` (`g_id`);

--
-- Indexes for table `durian_calendar`
--
ALTER TABLE `durian_calendar`
  ADD PRIMARY KEY (`cal_id`);

--
-- Indexes for table `ingredient_pest_control`
--
ALTER TABLE `ingredient_pest_control`
  ADD PRIMARY KEY (`c_id`,`pest_id`),
  ADD KEY `pest_id` (`pest_id`);

--
-- Indexes for table `irac_moa_group`
--
ALTER TABLE `irac_moa_group`
  ADD PRIMARY KEY (`g_id`);

--
-- Indexes for table `pest`
--
ALTER TABLE `pest`
  ADD PRIMARY KEY (`pest_id`);

--
-- Indexes for table `product_trade`
--
ALTER TABLE `product_trade`
  ADD PRIMARY KEY (`p_id`),
  ADD KEY `c_id` (`c_id`);

--
-- Indexes for table `spray_history`
--
ALTER TABLE `spray_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `usage_history`
--
ALTER TABLE `usage_history`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `pest_id` (`pest_id`),
  ADD KEY `c_id` (`c_id`),
  ADD KEY `p_id` (`p_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `active_ingredient`
--
ALTER TABLE `active_ingredient`
  MODIFY `c_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `durian_calendar`
--
ALTER TABLE `durian_calendar`
  MODIFY `cal_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `pest`
--
ALTER TABLE `pest`
  MODIFY `pest_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `product_trade`
--
ALTER TABLE `product_trade`
  MODIFY `p_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `spray_history`
--
ALTER TABLE `spray_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `usage_history`
--
ALTER TABLE `usage_history`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `active_ingredient`
--
ALTER TABLE `active_ingredient`
  ADD CONSTRAINT `active_ingredient_ibfk_1` FOREIGN KEY (`g_id`) REFERENCES `irac_moa_group` (`g_id`);

--
-- Constraints for table `ingredient_pest_control`
--
ALTER TABLE `ingredient_pest_control`
  ADD CONSTRAINT `ingredient_pest_control_ibfk_1` FOREIGN KEY (`c_id`) REFERENCES `active_ingredient` (`c_id`),
  ADD CONSTRAINT `ingredient_pest_control_ibfk_2` FOREIGN KEY (`pest_id`) REFERENCES `pest` (`pest_id`);

--
-- Constraints for table `product_trade`
--
ALTER TABLE `product_trade`
  ADD CONSTRAINT `product_trade_ibfk_1` FOREIGN KEY (`c_id`) REFERENCES `active_ingredient` (`c_id`);

--
-- Constraints for table `spray_history`
--
ALTER TABLE `spray_history`
  ADD CONSTRAINT `spray_history_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `usage_history`
--
ALTER TABLE `usage_history`
  ADD CONSTRAINT `usage_history_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `usage_history_ibfk_2` FOREIGN KEY (`pest_id`) REFERENCES `pest` (`pest_id`),
  ADD CONSTRAINT `usage_history_ibfk_3` FOREIGN KEY (`c_id`) REFERENCES `active_ingredient` (`c_id`),
  ADD CONSTRAINT `usage_history_ibfk_4` FOREIGN KEY (`p_id`) REFERENCES `product_trade` (`p_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
