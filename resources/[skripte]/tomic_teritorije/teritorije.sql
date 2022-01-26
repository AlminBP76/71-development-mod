CREATE TABLE IF NOT EXISTS `tomic_teritorije` (
  `id` int(11) DEFAULT NULL,
  `teritorija` varchar(60) NOT NULL,
  `pripada` varchar(50) DEFAULT NULL,
  `time` int(10) NOT NULL,
  KEY `time` (`time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `tomic_teritorije` (`id`, `teritorija`, `pripada`, `time`) VALUES
	(1, 'T1', 'society_nil', 100),
	(2, 'T2', 'society_nil', 100),
	(3, 'T3', 'society_nil', 100),
	(4, 'T4', 'society_nil', 100),
	(5, 'T5', 'society_nil', 100),
	(6, 'T6', 'society_nil', 100),
	(7, 'T7', 'society_nil', 100);