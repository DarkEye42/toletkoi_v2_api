-- ToletKoi Full Schema + Mock Data
-- Generated: 2025-08-30T11:32:32.207408

SET FOREIGN_KEY_CHECKS=0;

CREATE DATABASE IF NOT EXISTS `toletkoi` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `toletkoi`;

-- roles
DROP TABLE IF EXISTS roles;
CREATE TABLE roles (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(50) NOT NULL UNIQUE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  unique_id VARCHAR(100) NOT NULL UNIQUE,
  username VARCHAR(100) NOT NULL UNIQUE,
  first_name VARCHAR(100),
  last_name VARCHAR(100),
  profession VARCHAR(150),
  company VARCHAR(150),
  email VARCHAR(150) NOT NULL UNIQUE,
  phone VARCHAR(50),
  password VARCHAR(255) NOT NULL,
  nidNumber VARCHAR(50),
  birthDate DATE,
  gander ENUM('male','female','other') DEFAULT 'other',
  aboutMe TEXT,
  avatar VARCHAR(255),
  joinDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  village VARCHAR(150),
  policeStation VARCHAR(150),
  district VARCHAR(150),
  division VARCHAR(150),
  zipCode VARCHAR(20),
  latitude DECIMAL(10,8),
  longitude DECIMAL(11,8),
  isUpdated BOOLEAN DEFAULT 0,
  isRenter BOOLEAN DEFAULT 0,
  isVerified BOOLEAN DEFAULT 0,
  is_email_verified BOOLEAN DEFAULT 0,
  adminPower BOOLEAN DEFAULT 0,
  adminId INT DEFAULT NULL,
  balance DECIMAL(12,2) DEFAULT 0,
  is_owner BOOLEAN DEFAULT 0,
  last_seen TIMESTAMP NULL
);

-- tags
DROP TABLE IF EXISTS tags;
CREATE TABLE tags (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  slug VARCHAR(120) NOT NULL UNIQUE,
  color VARCHAR(20) DEFAULT NULL,
  icon VARCHAR(120) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS rental_posts;
CREATE TABLE rental_posts (
  id INT AUTO_INCREMENT PRIMARY KEY,
  uniqueId VARCHAR(100) NOT NULL UNIQUE,
  post_owner INT NOT NULL,
  description TEXT,
  category VARCHAR(100),
  takeOver DATE,
  shortAddress VARCHAR(255),
  street VARCHAR(255),
  house_no VARCHAR(50),
  policeStation VARCHAR(150),
  district VARCHAR(150),
  division VARCHAR(150),
  cost DECIMAL(12,2),
  negotiable BOOLEAN DEFAULT 0,
  cost_type VARCHAR(50),
  building_type VARCHAR(100),
  floorSize VARCHAR(50),
  contact VARCHAR(150),
  date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  latitude DECIMAL(10,8),
  longitude DECIMAL(11,8),
  electricity BOOLEAN DEFAULT 0,
  water BOOLEAN DEFAULT 0,
  gas BOOLEAN DEFAULT 0,
  internet BOOLEAN DEFAULT 0,
  ac BOOLEAN DEFAULT 0,
  elevator BOOLEAN DEFAULT 0,
  cc_camera BOOLEAN DEFAULT 0,
  floorLevel VARCHAR(50),
  rooms INT,
  bathroom INT,
  balcony INT,
  kitchen INT,
  parking BOOLEAN DEFAULT 0,
  security BOOLEAN DEFAULT 0,
  electricity_bill DECIMAL(10,2),
  gas_bill DECIMAL(10,2),
  water_bill DECIMAL(10,2),
  lift_bill DECIMAL(10,2),
  security_bill DECIMAL(10,2),
  active BOOLEAN DEFAULT 1,
  FOREIGN KEY (post_owner) REFERENCES users(id) ON DELETE CASCADE
);

-- ad_photos (up to 6 per ad)
DROP TABLE IF EXISTS ad_photos;
CREATE TABLE ad_photos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  ads_id INT NOT NULL,
  path VARCHAR(255) NOT NULL,
  sort_order INT DEFAULT 0,
  FOREIGN KEY (ads_id) REFERENCES rental_posts(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ad_tags pivot
DROP TABLE IF EXISTS ad_tags;
CREATE TABLE ad_tags (
  ad_id INT NOT NULL,
  tag_id INT NOT NULL,
  PRIMARY KEY(ad_id, tag_id),
  FOREIGN KEY (ad_id) REFERENCES rental_posts(id) ON DELETE CASCADE,
  FOREIGN KEY (tag_id) REFERENCES tags(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ad_views
DROP TABLE IF EXISTS ad_views;
CREATE TABLE ad_views (
  id INT AUTO_INCREMENT PRIMARY KEY,
  ad_id INT NOT NULL,
  user_id INT DEFAULT NULL,
  ip VARCHAR(45) DEFAULT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (ad_id) REFERENCES rental_posts(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- favorites / saved ads
DROP TABLE IF EXISTS favorites;
CREATE TABLE favorites (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  ad_id INT NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (ad_id) REFERENCES rental_posts(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- messages (chat)
DROP TABLE IF EXISTS messages;
CREATE TABLE messages (
  id INT AUTO_INCREMENT PRIMARY KEY,
  sender_id INT NOT NULL,
  receiver_id INT NOT NULL,
  message TEXT NOT NULL,
  seen TINYINT(1) DEFAULT 0,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (sender_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (receiver_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- products
DROP TABLE IF EXISTS products;
CREATE TABLE products (
  id INT AUTO_INCREMENT PRIMARY KEY,
  owner_id INT DEFAULT NULL,
  title VARCHAR(255) NOT NULL,
  slug VARCHAR(255) NOT NULL UNIQUE,
  description LONGTEXT,
  category VARCHAR(100) DEFAULT NULL,
  price DECIMAL(12,2) DEFAULT 0,
  stock INT DEFAULT 0,
  active TINYINT(1) DEFAULT 1,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (owner_id) REFERENCES users(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- product_photos (up to 6 per product)
DROP TABLE IF EXISTS product_photos;
CREATE TABLE product_photos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  product_id INT NOT NULL,
  path VARCHAR(255) NOT NULL,
  sort_order INT DEFAULT 0,
  FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- product_views
DROP TABLE IF EXISTS product_views;
CREATE TABLE product_views (
  id INT AUTO_INCREMENT PRIMARY KEY,
  product_id INT NOT NULL,
  user_id INT DEFAULT NULL,
  ip VARCHAR(45) DEFAULT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- blogs
DROP TABLE IF EXISTS blogs;
CREATE TABLE blogs (
  id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  slug VARCHAR(255) NOT NULL UNIQUE,
  content LONGTEXT,
  author_id INT DEFAULT NULL,
  published_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (author_id) REFERENCES users(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- blog_views
DROP TABLE IF EXISTS blog_views;
CREATE TABLE blog_views (
  id INT AUTO_INCREMENT PRIMARY KEY,
  blog_id INT NOT NULL,
  user_id INT DEFAULT NULL,
  ip VARCHAR(45) DEFAULT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (blog_id) REFERENCES blogs(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- pages (cms)
DROP TABLE IF EXISTS pages;
CREATE TABLE pages (
  id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  slug VARCHAR(255) NOT NULL UNIQUE,
  content LONGTEXT,
  published TINYINT(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ads_blocks (ad injection slots)
DROP TABLE IF EXISTS ads_blocks;
CREATE TABLE ads_blocks (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(150) NOT NULL,
  location VARCHAR(150) NOT NULL,
  html LONGTEXT,
  active TINYINT(1) DEFAULT 1,
  weight INT DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- email_logs
DROP TABLE IF EXISTS email_logs;
CREATE TABLE email_logs (
  id INT AUTO_INCREMENT PRIMARY KEY,
  type VARCHAR(100) NOT NULL,
  recipient VARCHAR(150) NOT NULL,
  status VARCHAR(50) DEFAULT 'queued',
  meta JSON DEFAULT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- recommendations (logs)
DROP TABLE IF EXISTS recommendations;
CREATE TABLE recommendations (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT DEFAULT NULL,
  entity_type VARCHAR(50) DEFAULT NULL,
  entity_id INT DEFAULT NULL,
  score DOUBLE DEFAULT 0,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- user_activity_log (search, view, favorite)
DROP TABLE IF EXISTS user_activity_log;
CREATE TABLE user_activity_log (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT DEFAULT NULL,
  action VARCHAR(50) NOT NULL,
  entity_type VARCHAR(50) DEFAULT NULL,
  entity_id INT DEFAULT NULL,
  meta JSON DEFAULT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- credits & transactions
DROP TABLE IF EXISTS credits;
CREATE TABLE credits (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  amount INT NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS transactions;
CREATE TABLE transactions (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  amount DECIMAL(12,2) NOT NULL,
  type VARCHAR(50) NOT NULL,
  meta JSON DEFAULT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- sponsored_ads
DROP TABLE IF EXISTS sponsored_ads;
CREATE TABLE sponsored_ads (
  id INT AUTO_INCREMENT PRIMARY KEY,
  ad_id INT NOT NULL,
  user_id INT NOT NULL,
  start_at DATETIME NOT NULL,
  end_at DATETIME NOT NULL,
  price DECIMAL(12,2) NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (ad_id) REFERENCES rental_posts(id) ON DELETE CASCADE,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- notifications
DROP TABLE IF EXISTS notifications;
CREATE TABLE notifications (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  type VARCHAR(100),
  data JSON,
  read_at DATETIME DEFAULT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Seed data (minimal but useful)
INSERT INTO roles (name) VALUES ('admin'),('tenant'),('home_owner'),('hotel_owner'),('land_owner'),('buyer');

INSERT INTO users (unique_id, username, first_name, last_name, profession, company, email, phone, password, nidNumber, birthDate, gander, aboutMe, avatar, joinDate, village, policeStation, district, division, zipCode, latitude, longitude, isUpdated, isRenter, isVerified, is_email_verified, adminPower, adminId, balance, is_owner, last_seen) VALUES
('u-admin','admin','Admin','User','Admin','ToletKoi','admin@toletkoi.com','01700000001','password','1234567890','1980-01-01','male','Super admin user','/avatars/admin.png','2020-01-01 10:00:00','Dhaka','Dhanmondi','Dhaka','Dhaka','1205',23.7461,90.3755,1,0,1,1,1,NULL,9999,0,'2025-08-31 10:00:00'),
('u-owner','owner1','Owner','Demo','Home Owner','Self','owner@toletkoi.com','01700000002','password','2345678901','1985-05-10','male','Flat owner','/avatars/owner1.png','2021-02-01 11:00:00','Dhaka','Banani','Dhaka','Dhaka','1213',23.7928,90.4090,1,0,1,1,0,1,200,1,'2025-08-31 10:05:00'),
('u-tenant','tenant1','Tenant','Demo','Tenant','N/A','tenant@toletkoi.com','01700000003','password','3456789012','1990-07-15','female','Looking for flat','/avatars/tenant1.png','2022-03-01 12:00:00','Dhaka','Mirpur','Dhaka','Dhaka','1216',23.8222,90.3650,1,1,1,1,0,2,50,0,'2025-08-31 10:10:00'),
('u-buyer','buyer1','Buyer','Demo','Buyer','N/A','buyer@toletkoi.com','01700000004','password','4567890123','1992-09-20','male','Interested in land','/avatars/buyer1.png','2023-04-01 13:00:00','Gazipur','Sadar','Gazipur','Gazipur','1700',24.0000,90.4200,1,0,1,1,0,3,30,0,'2025-08-31 10:15:00'),
('u-hotel','hotel1','Hotel','Owner','Hotel Owner','HotelBiz','hotel@toletkoi.com','01700000005','password','5678901234','1988-11-25','male','Hotel owner','/avatars/hotel1.png','2021-06-01 14:00:00','Dhaka','Gulshan','Dhaka','Dhaka','1212',23.7920,90.4060,1,0,1,1,0,4,100,1,'2025-08-31 10:20:00'),
('u-land','land1','Land','Owner','Land Owner','LandBiz','land@toletkoi.com','01700000006','password','6789012345','1983-12-30','male','Land owner','/avatars/land1.png','2020-08-01 15:00:00','Gazipur','Sadar','Gazipur','Gazipur','1700',24.0000,90.4200,1,0,1,1,0,5,150,1,'2025-08-31 10:25:00');

INSERT INTO tags (name, slug, color, icon) VALUES
('Family','family','#22c55e','bi bi-house'),
('Bachelor','bachelor','#3b82f6','bi bi-person'),
('Sublet','sublet','#a855f7','bi bi-arrow-repeat');

INSERT INTO rental_posts (uniqueId, post_owner, description, category, takeOver, shortAddress, street, house_no, policeStation, district, division, cost, negotiable, cost_type, building_type, floorSize, contact, date, latitude, longitude, electricity, water, gas, internet, ac, elevator, cc_camera, floorLevel, rooms, bathroom, balcony, kitchen, parking, security, electricity_bill, gas_bill, water_bill, lift_bill, security_bill, active) VALUES
('r-0001',2,'Cozy 2BR family flat','rental','2025-09-01','Dhanmondi Road 5','Dhanmondi St','12A','Dhanmondi','Dhaka','Dhaka',15000,0,'monthly','Apartment','1200 sqft','01700000002','2025-08-30 10:00:00',23.7461,90.3755,1,1,1,1,0,1,1,'3rd',2,1,1,1,1,1,500,200,100,50,100,1),
('r-0002',2,'Affordable bachelor studio','rental','2025-09-10','Mirpur-10','Mirpur Main','5B','Mirpur','Dhaka','Dhaka',7000,1,'monthly','Studio','400 sqft','01700000003','2025-08-30 11:00:00',23.8222,90.3650,1,1,0,1,0,0,0,'2nd',1,1,0,1,0,1,300,0,50,0,0,1),
('r-0003',2,'Short-term sublet in Gulshan','rental','2025-10-01','Gulshan 2','Gulshan Ave','8C','Gulshan','Dhaka','Dhaka',25000,0,'monthly','Apartment','1500 sqft','01700000004','2025-08-30 12:00:00',23.7925,90.4078,1,1,1,1,1,1,1,'5th',3,2,2,1,1,1,700,300,200,100,200,1),
('r-0004',2,'Spacious family flat in Banani','rental','2025-09-15','Banani Road 10','Banani St','15D','Banani','Dhaka','Dhaka',20000,1,'monthly','Apartment','1400 sqft','01700000005','2025-08-30 13:00:00',23.7928,90.4090,1,1,1,1,1,1,1,'4th',3,2,2,1,1,1,600,250,150,80,120,1),
('r-0005',5,'Hotel deluxe room','hotel','2025-09-05','Hotel Street','Hotel Lane','1A','Gulshan','Dhaka','Dhaka',4500,0,'night','Hotel','300 sqft','01700000005','2025-08-30 14:00:00',23.7920,90.4060,1,1,1,1,1,1,1,'1st',1,1,0,0,1,1,100,50,30,20,10,1),
('r-0006',6,'2 katha land for sale','land','2025-09-20','Gazipur Sadar','Land Lane','2B','Sadar','Gazipur','Gazipur',5000000,0,'sale','Land','2000 sqft','01700000006','2025-08-30 15:00:00',24.0000,90.4200,0,0,0,0,0,0,0,NULL,0,0,0,0,0,0,0,0,0,0,0,1);

INSERT INTO ad_photos (ads_id, path, sort_order) VALUES
(1,'uploads/ads/family-flat-dhanmondi-1/1.webp',1),
(1,'uploads/ads/family-flat-dhanmondi-1/2.webp',2),
(2,'uploads/ads/bachelor-studio-mirpur-2/1.webp',1),
(3,'uploads/ads/sublet-gulshan-3/1.webp',1);

INSERT INTO ad_tags (ad_id, tag_id) VALUES (1,1),(2,2),(3,3),(4,1);

INSERT INTO ad_views (ad_id, user_id, ip) VALUES (1,3,'103.55.12.11'),(1,NULL,'103.55.12.50'),(2,3,'103.55.12.11');

INSERT INTO favorites (user_id, ad_id) VALUES (3,1),(3,2);

INSERT INTO products (owner_id, title, slug, description, category, price, stock) VALUES
(2,'Cleaning Kit','cleaning-kit','Set of household cleaning supplies.','home',299.00,50),
(2,'Cooking Set','cooking-set','3-piece cookware.','home',1200.00,20),
(2,'Bed Sheet Set','bed-sheet-set','Double bed sheets set.','home',750.00,30);

INSERT INTO product_photos (product_id, path, sort_order) VALUES (1,'uploads/products/cleaning-kit/1.webp',1),(2,'uploads/products/cooking-set/1.webp',1);

INSERT INTO product_views (product_id, user_id, ip) VALUES (1,3,'103.55.12.11'),(2,4,'103.55.14.10');

INSERT INTO blogs (title, slug, content, author_id) VALUES ('How to find a good flat in Dhaka','find-flat-dhaka','Tips and tricks for searching flats in Dhaka.',1),('Decorating small spaces','decorate-small-spaces','Ideas to decorate small apartments.',1);

INSERT INTO blog_views (blog_id, user_id, ip) VALUES (1,3,'103.55.12.11');

INSERT INTO pages (title, slug, content, published) VALUES ('About Us','about-us','We connect renters with homeowners.',1),('Privacy Policy','privacy-policy','Your privacy matters.',1);

INSERT INTO ads_blocks (name, location, html, active, weight) VALUES ('Grid Card Ad','listing_grid','<div class="ad-card">Google Ad Placeholder</div>',1,1);

INSERT INTO email_logs (type, recipient, status) VALUES ('welcome','tenant@toletkoi.com','sent'),('password_reset','owner@toletkoi.com','queued');

INSERT INTO user_activity_log (user_id, action, entity_type, entity_id, meta) VALUES (3,'view','ad',1,NULL),(3,'favorite','ad',1,NULL),(3,'search','query',NULL,'{"q":"2 bedroom dhaka"}');

INSERT INTO recommendations (user_id, entity_type, entity_id, score) VALUES (3,'ad',1,0.95),(3,'product',1,0.78);

SET FOREIGN_KEY_CHECKS=1;
