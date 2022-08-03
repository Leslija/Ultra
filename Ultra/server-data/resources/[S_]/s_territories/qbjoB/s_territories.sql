CREATE TABLE `s_territories` (
  `name` varchar(50) NOT NULL,
  `gang` varchar(50) NOT NULL DEFAULT '',
  `amount` int(30) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `s_territories` (`name`, `gang`, `amount`) VALUES ('DESRT', '', 0);
INSERT INTO `s_territories` (`name`, `gang`, `amount`) VALUES ('HUMLAB', '', 0);
INSERT INTO `s_territories` (`name`, `gang`, `amount`) VALUES ('TERMINA', '', 0);
