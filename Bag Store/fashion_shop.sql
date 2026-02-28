
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS `order_detail`;
DROP TABLE IF EXISTS `orders`;
DROP TABLE IF EXISTS `products`;
DROP TABLE IF EXISTS `categories`;
DROP TABLE IF EXISTS `blog`;
DROP TABLE IF EXISTS `users`;

SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE `blog` (
  `id` int(11) NOT NULL,
  `title` varchar(250) NOT NULL,
  `slug` varchar(250) NOT NULL,
  `img` varchar(100) NOT NULL,
  `small_content` mediumtext DEFAULT NULL,
  `content` longtext NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(191) NOT NULL,
  `slug` varchar(191) NOT NULL,
  `description` mediumtext DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 0,
  `image` varchar(191) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


INSERT INTO `categories` (`id`, `name`, `slug`, `description`, `status`, `image`, `created_at`) VALUES
(1, 'Túi xách nữ', 'tui-xach-nu', 'Các mẫu túi xách thời trang dành cho nữ với thiết kế hiện đại, sang trọng và đa dạng phong cách.', 0, 'tui-xach-nu.webp', NOW()),
(2, 'Túi đeo chéo', 'tui-deo-cheo', 'Túi đeo chéo tiện lợi, nhỏ gọn, phù hợp đi chơi, dạo phố hoặc du lịch.', 0, 'tui-deo-cheo.jpg', NOW()),
(3, 'Túi công sở', 'tui-cong-so', 'Các dòng túi cao cấp dành cho dân văn phòng, thanh lịch và chuyên nghiệp.', 0, 'tui-cong-so.jpg', NOW()),
(4, 'Balo thời trang', 'balo-thoi-trang', 'Balo phong cách trẻ trung, phù hợp học sinh, sinh viên.', 0, 'balo.jpg', NOW());

CREATE TABLE `orders` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `status` int(11) NOT NULL DEFAULT 2,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `order_detail` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `order_id` bigint(20) DEFAULT NULL,
  `selling_price` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1,
  `rate` tinyint(4) DEFAULT NULL,
  `comment` mediumtext DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


INSERT INTO order_detail 
(id, user_id, product_id, order_id, selling_price, quantity, status)
VALUES
(1, 48, 1, NULL, 990, 1, 1);

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `name` varchar(191) NOT NULL,
  `slug` varchar(191) NOT NULL,
  `small_description` mediumtext NOT NULL,
  `description` mediumtext NOT NULL,
  `original_price` int(11) NOT NULL,
  `selling_price` int(11) NOT NULL,
  `image` varchar(191) NOT NULL,
  `qty` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


INSERT INTO `products` 
(`id`, `category_id`, `name`, `slug`, `small_description`, `description`, `original_price`, `selling_price`, `image`, `qty`, `status`, `created_at`) VALUES

(1, 1, 'Túi xách nữ cao cấp LUXURY A1', 'tui-xach-nu-luxury-a1',
'Chất liệu da PU cao cấp, chống nước nhẹ.\nThiết kế sang trọng, phù hợp dự tiệc.',
'Túi xách nữ LUXURY A1 mang phong cách thanh lịch và hiện đại. Với chất liệu da PU cao cấp, đường may tinh tế và form túi cứng cáp, đây là lựa chọn hoàn hảo cho các buổi tiệc hoặc sự kiện quan trọng.',
1200, 990, 'tui1.jpg', 20, 0, NOW()),

(2, 2, 'Túi đeo chéo mini Hàn Quốc', 'tui-deo-cheo-mini-han-quoc',
'Thiết kế nhỏ gọn, phong cách trẻ trung.',
'Túi đeo chéo mini phong cách Hàn Quốc, phù hợp cho các bạn trẻ yêu thích sự năng động. Dây đeo có thể điều chỉnh linh hoạt.',
450, 350, 'tui2.jpg', 30, 0, NOW()),

(3, 3, 'Túi công sở da thật CLASSIC PRO', 'tui-cong-so-classic-pro',
'Da thật 100%, form đứng chuyên nghiệp.',
'Túi công sở CLASSIC PRO được làm từ da thật cao cấp, thiết kế nhiều ngăn tiện lợi, phù hợp cho laptop và tài liệu. Mang lại vẻ ngoài chuyên nghiệp và đẳng cấp.',
2500, 2100, 'tui3.jpg', 15, 0, NOW()),

(4, 4, 'Balo thời trang Urban Style', 'balo-urban-style',
'Phong cách trẻ trung, năng động.',
'Balo Urban Style với chất liệu vải canvas cao cấp, chống nước nhẹ. Phù hợp đi học, đi làm hoặc du lịch ngắn ngày.',
800, 650, 'balo1.jpg', 25, 0, NOW());


CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(191) NOT NULL,
  `email` varchar(191) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `address` varchar(191) DEFAULT NULL,
  `password` varchar(191) NOT NULL,
  `role_as` tinyint(4) NOT NULL DEFAULT 0,
  `creat_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



INSERT INTO `users` (`id`, `name`, `email`, `phone`, `address`, `password`, `role_as`, `creat_at`) VALUES
(48, 'admin', 'admin@gmail.com', '0123456789', 'Hà Nội', '123456', 0, '2023-05-05 13:02:43'),
(49, 'Công Dinh', 'congdinh@gmail.com', '0123456789', NULL, '$2y$10$pOa6TRuABtdkJRk9HXcIzOvJNNu1UReWe1rIM/Yn27rOkX4RlqaLG', 1, '2023-05-05 13:33:13');

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `blog`
--
ALTER TABLE `blog`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `order_detail`
--
ALTER TABLE `order_detail`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `order_id` (`order_id`);

--
-- Chỉ mục cho bảng `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`);

--
-- Chỉ mục cho bảng `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `blog`
--
ALTER TABLE `blog`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT cho bảng `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT cho bảng `orders`
--
ALTER TABLE `orders`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT cho bảng `order_detail`
--
ALTER TABLE `order_detail`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;

--
-- AUTO_INCREMENT cho bảng `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=62;

--
-- AUTO_INCREMENT cho bảng `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `order_detail`
--
ALTER TABLE `order_detail`
  ADD CONSTRAINT `order_detail_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  ADD CONSTRAINT `order_detail_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `order_detail_ibfk_3` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`);

--
-- Các ràng buộc cho bảng `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
