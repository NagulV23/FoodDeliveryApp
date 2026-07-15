-- =========================================================
-- FOOD DELIVERY APPLICATION - DATABASE INITIALIZATION
-- =========================================================
-- This script runs automatically when the MySQL Docker
-- container starts for the first time.
-- =========================================================

CREATE DATABASE IF NOT EXISTS food_delivery_application;
USE food_delivery_application;

-- =========================================================
-- TABLE: restaurant
-- =========================================================
CREATE TABLE IF NOT EXISTS restaurant (
    restaurantId INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    cuisineType VARCHAR(100),
    deliveryTime INT,
    address VARCHAR(255),
    rating DOUBLE DEFAULT 0,
    isActive BOOLEAN DEFAULT TRUE,
    imagePath VARCHAR(255),
    UNIQUE INDEX idx_restaurant_name (name)
);

-- =========================================================
-- TABLE: menu
-- =========================================================
CREATE TABLE IF NOT EXISTS menu (
    menuId INT AUTO_INCREMENT PRIMARY KEY,
    restaurantId INT NOT NULL,
    itemName VARCHAR(100),
    description TEXT,
    price DOUBLE,
    isAvailable BOOLEAN DEFAULT TRUE,
    imagePath VARCHAR(255),
    FOREIGN KEY (restaurantId) REFERENCES restaurant(restaurantId),
    UNIQUE INDEX idx_menu_item (restaurantId, itemName)
);

-- =========================================================
-- TABLE: user
-- =========================================================
CREATE TABLE IF NOT EXISTS users (
    userId INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    username VARCHAR(50) UNIQUE,
    password VARCHAR(255),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    address TEXT,
    role VARCHAR(20) DEFAULT 'customer',
    createdDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    lastLoginDate TIMESTAMP NULL
);

-- =========================================================
-- TABLE: ordertable
-- =========================================================
CREATE TABLE IF NOT EXISTS ordertable (
    orderId INT AUTO_INCREMENT PRIMARY KEY,
    userId INT,
    orderDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    totalAmount DOUBLE,
    status VARCHAR(50) DEFAULT 'PLACED',
    paymentMethod VARCHAR(50),
    restaurantId INT,
    FOREIGN KEY (userId) REFERENCES users(userId),
    FOREIGN KEY (restaurantId) REFERENCES restaurant(restaurantId)
);

-- =========================================================
-- TABLE: orderitem
-- =========================================================
CREATE TABLE IF NOT EXISTS orderitem (
    orderItemId INT AUTO_INCREMENT PRIMARY KEY,
    orderId INT,
    menuId INT,
    quantity INT,
    itemTotal DOUBLE,
    FOREIGN KEY (orderId) REFERENCES ordertable(orderId),
    FOREIGN KEY (menuId) REFERENCES menu(menuId)
);

-- =========================================================
-- TABLE: coupons
-- =========================================================
CREATE TABLE IF NOT EXISTS coupons (
    couponId INT AUTO_INCREMENT PRIMARY KEY,
    code VARCHAR(50) NOT NULL UNIQUE,
    description VARCHAR(255),
    discountType ENUM('PERCENTAGE','FLAT') NOT NULL DEFAULT 'FLAT',
    discountValue DOUBLE NOT NULL,
    minOrderAmount DOUBLE DEFAULT 0,
    maxDiscount DOUBLE DEFAULT 0,
    usageLimit INT DEFAULT 0,
    usedCount INT DEFAULT 0,
    isActive BOOLEAN DEFAULT TRUE,
    validFrom TIMESTAMP NULL,
    validUntil TIMESTAMP NULL,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =========================================================
-- SAMPLE DATA: Coupons
-- =========================================================
INSERT IGNORE INTO coupons (code, description, discountType, discountValue, minOrderAmount, maxDiscount, usageLimit, usedCount, isActive, validFrom, validUntil) VALUES
('FOODIE50', 'Get ₹50 OFF on orders above ₹499', 'FLAT', 50, 499, 0, 500, 0, TRUE, '2026-01-01 00:00:00', '2027-12-31 23:59:59'),
('SAVE100', 'Save ₹100 on orders above ₹999', 'FLAT', 100, 999, 0, 200, 0, TRUE, '2026-01-01 00:00:00', '2027-12-31 23:59:59'),
('WELCOME20', '20% OFF up to ₹150 on your first order', 'PERCENTAGE', 20, 299, 150, 1000, 0, TRUE, '2026-01-01 00:00:00', '2027-12-31 23:59:59'),
('FREEDEL', 'Free delivery on any order', 'FLAT', 40, 0, 0, 300, 0, TRUE, '2026-01-01 00:00:00', '2027-12-31 23:59:59'),
('HUNGRY25', '25% OFF up to ₹200 on orders above ₹599', 'PERCENTAGE', 25, 599, 200, 150, 0, TRUE, '2026-01-01 00:00:00', '2027-12-31 23:59:59'),
('EXPIRED10', 'Expired coupon — 10% OFF (for testing)', 'PERCENTAGE', 10, 100, 50, 100, 0, TRUE, '2024-01-01 00:00:00', '2025-01-01 00:00:00'),
('MAXEDOUT', 'MAXED out coupon — used 100 times', 'FLAT', 30, 100, 0, 100, 100, TRUE, '2026-01-01 00:00:00', '2027-12-31 23:59:59'),
('INACTIVE', 'Inactive coupon (disabled)', 'FLAT', 20, 50, 0, 100, 0, FALSE, '2026-01-01 00:00:00', '2027-12-31 23:59:59');

-- =========================================================
-- SAMPLE DATA: Restaurants (12 restaurants)
-- Uses INSERT IGNORE to prevent duplicates if script runs again
-- =========================================================
INSERT IGNORE INTO restaurant (name, cuisineType, deliveryTime, address, rating, isActive, imagePath) VALUES
('McDonald''s', 'Burgers, Fast Food', 25, 'Indiranagar, Bangalore', 4.5, TRUE, 'images/mcd.jpg'),
('Pizza Hut', 'Pizza, Italian', 30, 'Koramangala, Bangalore', 4.3, TRUE, 'images/pizzahut.jpg'),
('Subway', 'Sandwiches, Salads', 20, 'MG Road, Bangalore', 4.4, TRUE, 'images/subway.jpg'),
('Biryani Blues', 'Biryani, Mughlai', 35, 'Jayanagar, Bangalore', 4.6, TRUE, 'images/bbk.jpg'),
('KFC', 'Fried Chicken, Fast Food', 20, 'BTM Layout, Bangalore', 4.2, TRUE, 'images/kfc.jpg'),
('Starbucks', 'Coffee, Beverages', 15, 'Whitefield, Bangalore', 4.5, TRUE, 'images/starbucks.jpg'),
('Baskin Robbins', 'Ice Cream, Desserts', 25, 'HSR Layout, Bangalore', 4.4, TRUE, 'images/baskinrobbins.jpg'),
('Chaipoint', 'Tea, Snacks, Fast Food', 18, 'Marathahalli, Bangalore', 4.1, TRUE, 'images/chaipoint.jpg'),
('Behrouz Biryani', 'Biryani, Mughlai', 30, 'Electronic City, Bangalore', 4.7, TRUE, 'images/behrouz.jpg'),
('Wow Momo', 'Momos, Chinese', 22, 'JP Nagar, Bangalore', 4.3, TRUE, 'images/wowmomo.jpg'),
('A2B Restaurant', 'South Indian, Chinese', 25, 'BTM Layout, Bangalore', 4.5, TRUE, 'images/a2b.jpg'),
('Burger King', 'Burgers, Fast Food', 20, 'Koramangala, Bangalore', 4.2, TRUE, 'images/burgerking.jpg');

-- =========================================================
-- SAMPLE DATA: Menu Items (60+ items across restaurants)
-- =========================================================

-- McDonald's (restaurantId = 1)
INSERT INTO menu (restaurantId, itemName, description, price, isAvailable, imagePath) VALUES
(1, 'McVeggie Burger', 'Crispy veggie patty with fresh lettuce and mayo', 129, TRUE, 'images/mcveggie.jpg'),
(1, 'McAloo Tikki', 'Golden fried potato patty with tomato ketchup', 79, TRUE, 'images/mcaloo.jpg'),
(1, 'Chicken Burger', 'Tender chicken patty with cheese and sauce', 149, TRUE, 'images/mcchicken.jpg'),
(1, 'French Fries (Large)', 'Crispy golden fries with salt', 99, TRUE, 'images/fries.jpg'),
(1, 'McFlurry', 'Creamy vanilla soft serve with chocolate sauce', 119, TRUE, 'images/mcflurry.jpg');

-- Pizza Hut (restaurantId = 2)
INSERT INTO menu (restaurantId, itemName, description, price, isAvailable, imagePath) VALUES
(2, 'Farmhouse Pizza', 'Fresh vegetables with mozzarella cheese', 349, TRUE, 'images/farmhouse.jpg'),
(2, 'Cheese Burst Pizza', 'Loaded with extra cheese in every bite', 399, TRUE, 'images/cheeseburst.jpg'),
(2, 'Veg Pizza', 'Classic veggie pizza with bell peppers and onions', 249, TRUE, 'images/vegpizza.jpg'),
(2, 'Chicken Pizza', 'Tender chicken chunks with BBQ sauce', 429, TRUE, 'images/chickenpizza.jpg'),
(2, 'Pasta in White Sauce', 'Creamy white sauce pasta with veggies', 199, TRUE, 'images/pasta.jpg');

-- Subway (restaurantId = 3)
INSERT INTO menu (restaurantId, itemName, description, price, isAvailable, imagePath) VALUES
(3, 'Paneer Sub', 'Fresh cottage cheese with garden veggies', 179, TRUE, 'images/paneersub.jpg'),
(3, 'Veggie Delite', 'Assorted fresh vegetables on whole wheat bread', 149, TRUE, 'images/subwayveg.jpg');

-- Biryani Blues (restaurantId = 4)
INSERT INTO menu (restaurantId, itemName, description, price, isAvailable, imagePath) VALUES
(4, 'Hyderabadi Biryani', 'Authentic hyderabadi dum biryani with tender meat', 299, TRUE, 'images/hydbiryani.jpg'),
(4, 'Chicken Biryani', 'Fragrant basmati rice with spiced chicken', 249, TRUE, 'images/biryani.jpg'),
(4, 'Mutton Biryani', 'Slow-cooked mutton with aromatic spices', 349, TRUE, 'images/mutton.jpg'),
(4, 'Paneer Biryani', 'Biryani with soft paneer cubes', 229, TRUE, 'images/paneerbiryani.jpg'),
(4, 'Royal Biryani', 'Special royal biryani with dry fruits', 399, TRUE, 'images/royalbiryani.jpg');

-- KFC (restaurantId = 5)
INSERT INTO menu (restaurantId, itemName, description, price, isAvailable, imagePath) VALUES
(5, 'Chicken Bucket', '8 pieces of crispy fried chicken', 499, TRUE, 'images/chickenbucket.jpg'),
(5, 'Zinger Burger', 'Crispy chicken fillet with spicy mayo', 189, TRUE, 'images/zinger.jpg'),
(5, 'Chicken Popcorn', 'Bite-sized crispy chicken pieces', 149, TRUE, 'images/chicken65.jpg'),
(5, 'Chicken Wings', 'Spicy buffalo chicken wings (6 pcs)', 249, TRUE, 'images/grillchicken.jpg');

-- Starbucks (restaurantId = 6)
INSERT INTO menu (restaurantId, itemName, description, price, isAvailable, imagePath) VALUES
(6, 'Cappuccino', 'Classic Italian cappuccino with frothy milk', 249, TRUE, 'images/cappuccino.jpg'),
(6, 'Coffee Mocha', 'Rich chocolate espresso with whipped cream', 299, TRUE, 'images/coffee.jpg'),
(6, 'Chai Latte', 'Spiced tea latte with cinnamon', 219, TRUE, 'images/chai.jpg'),
(6, 'Chocolate Muffin', 'Freshly baked chocolate muffin', 179, TRUE, 'images/muffin.jpg');

-- Baskin Robbins (restaurantId = 7)
INSERT INTO menu (restaurantId, itemName, description, price, isAvailable, imagePath) VALUES
(7, 'Chocolate Ice Cream', 'Rich Belgian chocolate ice cream scoop', 129, TRUE, 'images/chocolateicecream.jpg'),
(7, 'Strawberry Ice Cream', 'Fresh strawberry flavored ice cream', 129, TRUE, 'images/strawberryicecream.jpg'),
(7, 'Mango Milkshake', 'Thick mango milkshake with ice cream', 179, TRUE, 'images/mangomilkshake.jpg'),
(7, 'Hot Brownie Sundae', 'Warm brownie with vanilla ice cream', 199, TRUE, 'images/sundae.jpg');

-- Chaipoint (restaurantId = 8)
INSERT INTO menu (restaurantId, itemName, description, price, isAvailable, imagePath) VALUES
(8, 'Masala Chai', 'Traditional Indian spiced tea', 29, TRUE, 'images/chai.jpg'),
(8, 'Samosa (2 pcs)', 'Crispy fried samosa with potato filling', 39, TRUE, 'images/samosa.jpg'),
(8, 'Vada Pav', 'Spicy potato fritter in bun with chutney', 49, TRUE, 'images/poori.jpg');

-- Behrouz Biryani (restaurantId = 9)
INSERT INTO menu (restaurantId, itemName, description, price, isAvailable, imagePath) VALUES
(9, 'Chicken Dum Biryani', 'Authentic dum cooked chicken biryani', 319, TRUE, 'images/biryani.jpg'),
(9, 'Mutton Biryani', 'Tender mutton with saffron rice', 399, TRUE, 'images/biryani.jpg'),
(9, 'Boneless Biryani', 'Boneless chicken biryani with yogurt', 349, TRUE, 'images/bonelessbiryani.jpg'),
(9, 'Gulab Jamun', 'Soft milk dumplings in sugar syrup', 79, TRUE, 'images/gulabjamun.jpg');

-- Wow Momo (restaurantId = 10)
INSERT INTO menu (restaurantId, itemName, description, price, isAvailable, imagePath) VALUES
(10, 'Chicken Momo', 'Steamed chicken momos with spicy dip', 129, TRUE, 'images/chickenmomo.jpg'),
(10, 'Veg Momo', 'Fresh vegetable steamed momos', 99, TRUE, 'images/vegmomo.jpg'),
(10, 'Dragon Chicken', 'Spicy dragon chicken with fried rice', 229, TRUE, 'images/dragonchicken.jpg');

-- A2B Restaurant (restaurantId = 11)
INSERT INTO menu (restaurantId, itemName, description, price, isAvailable, imagePath) VALUES
(11, 'Masala Dosa', 'Crispy dosa with potato masala filling', 99, TRUE, 'images/dosa.jpg'),
(11, 'Idli (2 pcs)', 'Steamed rice cakes with sambar', 59, TRUE, 'images/idli.jpg'),
(11, 'Plain Dosa', 'Golden crispy plain dosa', 79, TRUE, 'images/plaindosa.jpg'),
(11, 'Rava Dosa', 'Crispy semolina dosa with onions', 109, TRUE, 'images/ravadosa.jpg'),
(11, 'Pongal', 'Comforting rice-lentil dish with ghee', 89, TRUE, 'images/pongal.jpg');

-- Burger King (restaurantId = 12)
INSERT INTO menu (restaurantId, itemName, description, price, isAvailable, imagePath) VALUES
(12, 'Whopper', 'Flame-grilled beef burger with veggies', 249, TRUE, 'images/whopper.jpg'),
(12, 'Chicken Burger', 'Crispy chicken patty with lettuce', 179, TRUE, 'images/chickenburger.jpg'),
(12, 'Veg Burger', 'Crispy veggie patty with cheese', 129, TRUE, 'images/vegburger.jpg'),
(12, 'French Fries', 'Salted crispy french fries', 89, TRUE, 'images/fries.jpg');
