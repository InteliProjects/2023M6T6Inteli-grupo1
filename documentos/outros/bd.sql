-- sed.delivery_status definition

CREATE TABLE `delivery_status` (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `name` varchar(255) NOT NULL,
  `category` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- sed.`order` definition

CREATE TABLE `order` (
  `id` int NOT NULL AUTO_INCREMENT,
  `itemName` varchar(255) NOT NULL,
  `category` varchar(255) DEFAULT NULL,
  `quantity` int NOT NULL,
  `supplier_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- sed.school_board definition

CREATE TABLE `school_board` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- sed.seduc_user definition

CREATE TABLE `seduc_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(225) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `seduc_user_UN` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- sed.shipping_company definition

CREATE TABLE `shipping_company` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- sed.supplier_user definition

CREATE TABLE `supplier_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `supplier_user_UN` (`email`),
  UNIQUE KEY `supplier_user_UN_2` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- sed.school definition

CREATE TABLE `school` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `cep` varchar(255) NOT NULL,
  `complement` varchar(255) DEFAULT NULL,
  `street` varchar(255) NOT NULL,
  `number` varchar(255) NOT NULL,
  `district` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  `board_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `school_FK` (`board_id`),
  CONSTRAINT `school_FK` FOREIGN KEY (`board_id`) REFERENCES `school_board` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- sed.school_user definition

CREATE TABLE `school_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `school_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `school_user_FK` (`school_id`),
  CONSTRAINT `school_user_FK` FOREIGN KEY (`school_id`) REFERENCES `school` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- sed.delivery definition

CREATE TABLE `delivery` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `school_id` int NOT NULL,
  `shipping_company_id` int NOT NULL,
  `quantity` int NOT NULL,
  `status_id` int NOT NULL,
  `receipt_code` varchar(5) DEFAULT NULL,
  `initial_forecast` timestamp NULL DEFAULT NULL,
  `final_forecast` timestamp NULL DEFAULT NULL,
  `rating` int DEFAULT NULL,
  `received_quantity` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `delivery_FK` (`school_id`),
  KEY `delivery_FK_1` (`order_id`),
  KEY `delivery_FK_2` (`shipping_company_id`),
  CONSTRAINT `delivery_FK` FOREIGN KEY (`school_id`) REFERENCES `school` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `delivery_FK_1` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `delivery_FK_2` FOREIGN KEY (`shipping_company_id`) REFERENCES `shipping_company` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- sed.delivery_status_change definition

CREATE TABLE `delivery_status_change` (
  `delivery_id` int NOT NULL,
  `previous_status_id` varchar(255) NOT NULL,
  `next_status_id` varchar(255) NOT NULL,
  `moment` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  KEY `delivery_status_change_FK` (`delivery_id`),
  KEY `delivery_status_change_FK_1` (`previous_status_id`),
  KEY `delivery_status_change_FK_2` (`next_status_id`),
  CONSTRAINT `delivery_status_change_FK` FOREIGN KEY (`delivery_id`) REFERENCES `delivery` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `delivery_status_change_FK_1` FOREIGN KEY (`previous_status_id`) REFERENCES `delivery_status` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `delivery_status_change_FK_2` FOREIGN KEY (`next_status_id`) REFERENCES `delivery_status` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;