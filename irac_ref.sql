-- --------------------------------------------------------
-- IRAC Durian DSS: Final Complete Data Restore
-- --------------------------------------------------------

-- 1. Table: irac_moa_group
CREATE TABLE IF NOT EXISTS `irac_moa_group` (
  `g_id` varchar(10) PRIMARY KEY NOT NULL,
  `g_name` varchar(255) DEFAULT NULL
);

INSERT OR IGNORE INTO `irac_moa_group` (`g_id`, `g_name`) VALUES
('100', 'FRAC M1: สารประกอบทองแดง (Copper)'), ('101', 'Group 1B: ฟีโนบูคาร์บ (Fenobucarb)'),
('11', 'FRAC 11: อะซอกซีสโตรบิน (Azoxystrobin)'), ('1A', 'กลุ่ม 1A: คาร์บาเมต (Carbamates)'),
('1B', 'กลุ่ม 1B: ออร์กาโนฟอสเฟต (Organophosphates)'), ('20', 'Group 20: ไซเอนโนไพราเฟน (Cyenopyrafen)'),
('21', 'Group 21: เฟนไพโรซิเมต (Fenpyroximate)'), ('23', 'กลุ่ม 23: อนุพันธ์กรดเตโทรนิก (Tetronic acid derivatives)'),
('28', 'กลุ่ม 28: ไดอะไมด์ (Diamides)'), ('3', 'FRAC 3: ไดฟีโนโคนาโซล (Difenoconazole)'),
('33', 'FRAC 33: กรดฟอสโฟนิก (Phosphorous acid)'), ('40', 'FRAC 40: ไดเมโทมอร์ฟ (Dimethomorph)'),
('4A', 'กลุ่ม 4A: นีโอนิโคตินอยด์ (Neonicotinoids)'), ('5', 'กลุ่ม 5: สไปโนซิน (Spinosyns)'),
('9B', 'กลุ่ม 9B: ไพเมโทรซีน (Pymetrozine)');

-- 2. Table: pest (ครบทั้ง 23 รายการ)
CREATE TABLE IF NOT EXISTS `pest` (
  `pest_id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `pest_name` varchar(100) DEFAULT NULL,
  `image_url` text DEFAULT NULL,
  `description` text DEFAULT NULL,
  `category` varchar(20) DEFAULT 'pest',
  `ipm_method` text DEFAULT NULL
);

INSERT OR IGNORE INTO `pest` (`pest_id`, `pest_name`, `image_url`, `description`, `category`, `ipm_method`) VALUES
(1, 'เพลี้ยไก่แจ้ทุเรียน', '/pests/psyllid.jpg', 'ใบหงิกงอแห้ง', 'pest', 'ใช้เชื้อบิวเวอเรีย'),
(2, 'หนอนเจาะผลทุเรียน', '/pests/fruit_borer.jpg', 'เจาะผลกินเนื้อใน', 'pest', 'ใช้เชื้อบีที (Bt)'),
(3, 'ไรแดงแอฟริกัน', '/pests/red_mite.jpg', 'ใบจุดขาวซีด', 'pest', 'พ่นน้ำเพิ่มความชื้น'),
(4, 'โรครากเน่าโคนเน่า', '/pests/root_rot.jpg', 'เปลือกต้นเยิ้มเป็นน้ำ', 'disease', 'ใช้ไตรโคเดอร์มา'),
(5, 'โรคแอนแทรคโนส', '/pests/anthracnose.jpg', 'ใบไหม้เป็นวงซ้อน', 'disease', 'ตัดแต่งกิ่งให้โปร่ง'),
(6, 'หนอนเจาะเมล็ด', '/pests/seed_borer.jpg', 'เจาะเมล็ดไม่เห็นรูผิว', 'pest', 'หุ้มผลทุเรียน'),
(7, 'เพลี้ยแป้งทุเรียน', '/pests/mealybug.jpg', 'ขับถ่ายมูลหวานเกิดราดำ', 'pest', 'ใช้น้ำเปล่าฉีดพ่น'),
(8, 'เพลี้ยไฟทุเรียน', '/pests/thrips.jpg', 'หนามจีบ ผิวผลเสีย', 'pest', 'พ่นน้ำเพิ่มความชื้น'),
(9, 'เพลี้ยหอย', '/pests/scale_insect.jpg', 'กิ่งแห้งตาย', 'pest', 'ใช้ไวท์ออยล์'),
(10, 'มอดเจาะลำต้น', '/pests/stem_borer.jpg', 'ขุยไม้เยิ้มโคนต้น', 'pest', 'ใช้ลวดเขี่ยตัวหนอน'),
(11, 'ด้วงบ่าหนาม', '/pests/longhorn_beetle.jpg', 'เจาะใต้เปลือกไม้', 'pest', 'ทำความสะอาดโคนต้น'),
(12, 'โรคราสีชมพู', '/pests/pink_disease.jpg', 'เส้นใยราสีชมพูตามง่ามกิ่ง', 'disease', 'ทาแผลด้วยคอปเปอร์'),
(13, 'โรคราแป้ง', '/pests/powdery_mildew.jpg', 'ผงขาวคล้ายแป้งคลุมดอก', 'disease', 'พ่นกำมะถันผง'),
(14, 'โรคใบจุดตากบ', '/pests/leaf_spot.jpg', 'จุดวงกลมคล้ายตากบ', 'disease', 'ลดปุ๋ยไนโตรเจนช่วงฝน'),
(15, 'โรคใบติด', '/pests/leaf_blight.jpg', 'ใบเน่าติดกันเป็นแผง', 'disease', 'ใช้ไตรโคเดอร์มา'),
(16, 'หนอนหน้าแมว', '/pests/cat_caterpillar.jpg', 'กัดกินใบเหลือแต่เส้น', 'pest', 'เก็บตัวหนอนทำลาย'),
(17, 'เพลี้ยจักจั่นฝอย', '/pests/leafhopper.jpg', 'ยอดแห้งไม้กวาด', 'pest', 'ใช้เชื้อบิวเวอเรีย'),
(18, 'หนอนกินดอกทุเรียน', '/pests/flower_caterpillar.jpg', 'กัดกินดอกร่วง', 'pest', 'ใช้เชื้อบีที (Bt)'),
(19, 'มอดเจาะกิ่งทุเรียน', '/pests/twig_borer.jpg', 'กิ่งขนาดเล็กแห้งตาย', 'pest', 'ตัดกิ่งเผาทำลาย'),
(20, 'โรคราดำ', '/pests/sooty_mold.jpg', 'คราบดำปกคลุมใบ', 'disease', 'กำจัดแมลงปากดูด'),
(21, 'โรคจุดสนิม', '/pests/algal_spot.jpg', 'จุดส้มบนหน้าใบ', 'disease', 'ฉีดพ่นน้ำล้างใบ'),
(22, 'เพลี้ยอ่อน', '/pests/aphids.jpg', 'ใบหงิกงอ ยอดแห้ง', 'pest', 'ใช้สารสกัดยาสูบ'),
(23, 'โรคราเมล็ดผักกาด', '/pests/sclerotium.jpg', 'เส้นใยขาวโคนต้น', 'disease', 'ใช้ปูนขาวโรยรอบโคน');

-- 3. Table: active_ingredient
CREATE TABLE IF NOT EXISTS `active_ingredient` (
  `c_id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `c_name` varchar(255) DEFAULT NULL,
  `g_id` varchar(10) DEFAULT NULL,
  FOREIGN KEY (`g_id`) REFERENCES `irac_moa_group` (`g_id`)
);

INSERT OR IGNORE INTO `active_ingredient` (`c_id`, `c_name`, `g_id`) VALUES
(1, 'เมโทมิล (Methomyl)', '1A'), (4, 'คลอร์ไพริฟอส', '1B'), (5, 'อิมิดาโคลพริด', '4A'),
(6, 'ฟลูเบนไดอะไมด์', '28'), (8, 'สไปนีโทแรม', '5'), (9, 'สไปโรมีซิเฟน', '23'),
(10, 'ไพเมโทรซีน', '9B'), (11, 'เฟนไพโรซิเมต', '21'), (13, 'โพแทสเซียม ฟอสไฟต์', '33'),
(14, 'ไดเมโทมอร์ฟ', '40'), (15, 'ไดฟีโนโคนาโซล', '3'), (16, 'อะซอกซีสโตรบิน', '11'),
(19, 'คอปเปอร์ ออกซีคลอไรด์', '100'), (20, 'ฟีโนบูคาร์บ', '101'), (21, 'คลอแรนทรานิลิโพรล', '28');

-- 4. Table: ingredient_pest_control (Mapping ครบทั้ง 23 รายการ)
CREATE TABLE IF NOT EXISTS `ingredient_pest_control` (
  `c_id` INTEGER NOT NULL,
  `pest_id` INTEGER NOT NULL,
  `recommended_note` text DEFAULT NULL,
  PRIMARY KEY (`c_id`, `pest_id`),
  FOREIGN KEY (`c_id`) REFERENCES `active_ingredient` (`c_id`),
  FOREIGN KEY (`pest_id`) REFERENCES `pest` (`pest_id`)
);

INSERT OR IGNORE INTO `ingredient_pest_control` (`c_id`, `pest_id`, `recommended_note`) VALUES
(5, 1, 'กลุ่ม 4A'), (6, 2, 'กลุ่ม 28'), (11, 3, 'กลุ่ม 21'), (13, 4, 'กลุ่ม 33'),
(15, 5, 'กลุ่ม 3'), (21, 6, 'กลุ่ม 28'), (9, 7, 'กลุ่ม 23'), (8, 8, 'กลุ่ม 5'),
(9, 9, 'กลุ่ม 23'), (4, 10, 'กลุ่ม 1B'), (1, 11, 'กลุ่ม 1A'), 
(19, 12, 'กลุ่ม 100'), (15, 13, 'กลุ่ม 3'), (16, 13, 'กลุ่ม 11'), (15, 14, 'กลุ่ม 3'), (16, 14, 'กลุ่ม 11'),
(16, 15, 'กลุ่ม 11'), (6, 16, 'กลุ่ม 28'), (5, 17, 'กลุ่ม 4A'), (21, 18, 'กลุ่ม 28'),
(4, 19, 'กลุ่ม 1B'), (9, 20, 'กลุ่ม 23'), (19, 21, 'กลุ่ม 100'), (20, 22, 'กลุ่ม 101'), (19, 23, 'กลุ่ม 100');

-- 5. Table: users
CREATE TABLE IF NOT EXISTS `users` (
  `id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `username` varchar(50) UNIQUE,
  `password` varchar(255),
  `name` varchar(100)
);

INSERT OR IGNORE INTO `users` (`id`, `username`, `password`, `name`) VALUES
(1, 'Admin', 'Admin', 'Admin'), (2, '66310045', '1234', 'ภูมิวิวัฒน์');

-- 6. Table: usage_history
CREATE TABLE IF NOT EXISTS `usage_history` (
  `log_id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `user_id` INTEGER,
  `pest_id` INTEGER,
  `g_id` varchar(10),
  `dosage` varchar(100),
  `image_path` text,
  `phi_days` INTEGER,
  `usage_date` DATETIME DEFAULT (datetime('now', 'localtime')),
  FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  FOREIGN KEY (`pest_id`) REFERENCES `pest` (`pest_id`)
);