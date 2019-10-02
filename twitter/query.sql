CREATE DATABASE IF NOT EXISTS `twitter`
USE `twitter`;

-- --------------------------------------------------------

--
-- Struktur dari tabel `account`
--

DROP TABLE IF EXISTS `account`;
CREATE TABLE `account` (
  `id` int(11) UNSIGNED NOT NULL,
  `name` varchar(50) NOT NULL,
  `picture_path` varchar(255) DEFAULT NULL,
  `username` varchar(45) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `password` varchar(225) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `join_date` datetime NOT NULL,
  `bio` varchar(160) NOT NULL,
  `location` varchar(30) DEFAULT NULL,
  `birth_date` date DEFAULT NULL
) 

-- --------------------------------------------------------

--
-- Struktur dari tabel `attachment`
--

DROP TABLE IF EXISTS `attachment`;
CREATE TABLE `attachment` (
  `id` int(11) UNSIGNED NOT NULL,
  `path` varchar(255) NOT NULL
) 

-- --------------------------------------------------------

--
-- Struktur dari tabel `chat`
--

DROP TABLE IF EXISTS `chat`;
CREATE TABLE `chat` (
  `id` int(11) UNSIGNED NOT NULL,
  `from_account_id` int(10) UNSIGNED NOT NULL,
  `to_account_id` int(10) UNSIGNED NOT NULL,
  `text` varchar(255) NOT NULL
) 

-- --------------------------------------------------------

--
-- Struktur dari tabel `chat_attachment`
--

DROP TABLE IF EXISTS `chat_attachment`;
CREATE TABLE `chat_attachment` (
  `chat_id` int(10) UNSIGNED NOT NULL,
  `attachment_id` int(10) UNSIGNED NOT NULL
) 

-- --------------------------------------------------------

--
-- Struktur dari tabel `follow`
--

DROP TABLE IF EXISTS `follow`;
CREATE TABLE `follow` (
  `id` int(11) NOT NULL,
  `from_account_id` int(10) UNSIGNED DEFAULT NULL,
  `to_account_id` int(10) UNSIGNED DEFAULT NULL
) 

-- --------------------------------------------------------

--
-- Struktur dari tabel `notif`
--

DROP TABLE IF EXISTS `notif`;
CREATE TABLE `notif` (
  `id` int(10) UNSIGNED NOT NULL,
  `account_id` int(10) UNSIGNED NOT NULL,
  `create_at` datetime NOT NULL
) 

-- --------------------------------------------------------

--
-- Struktur dari tabel `notif_post`
--

DROP TABLE IF EXISTS `notif_post`;
CREATE TABLE `notif_post` (
  `notif_id` int(10) UNSIGNED NOT NULL,
  `post_id` int(10) UNSIGNED NOT NULL
) 

-- --------------------------------------------------------

--
-- Struktur dari tabel `notif_post_like`
--

DROP TABLE IF EXISTS `notif_post_like`;
CREATE TABLE `notif_post_like` (
  `notif_id` int(10) UNSIGNED NOT NULL,
  `post_like_id` int(10) UNSIGNED NOT NULL
) 

-- --------------------------------------------------------

--
-- Struktur dari tabel `post`
--

DROP TABLE IF EXISTS `post`;
CREATE TABLE `post` (
  `id` int(11) UNSIGNED NOT NULL,
  `account_id` int(10) UNSIGNED NOT NULL,
  `create_at` datetime NOT NULL,
  `update_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) 

-- --------------------------------------------------------

--
-- Struktur dari tabel `post_attachment`
--

DROP TABLE IF EXISTS `post_attachment`;
CREATE TABLE `post_attachment` (
  `post_id` int(11) UNSIGNED NOT NULL,
  `attachment_id` int(255) UNSIGNED NOT NULL
) 

-- --------------------------------------------------------

--
-- Struktur dari tabel `post_comment`
--

DROP TABLE IF EXISTS `post_comment`;
CREATE TABLE `post_comment` (
  `from_post_id` int(10) UNSIGNED NOT NULL,
  `to_post_id` int(10) UNSIGNED NOT NULL
) 

-- --------------------------------------------------------

--
-- Struktur dari tabel `post_like`
--

DROP TABLE IF EXISTS `post_like`;
CREATE TABLE `post_like` (
  `id` int(10) UNSIGNED NOT NULL,
  `post_id` int(10) UNSIGNED NOT NULL,
  `account_id` int(10) UNSIGNED NOT NULL
) 

-- --------------------------------------------------------

--
-- Struktur dari tabel `post_polling`
--

DROP TABLE IF EXISTS `post_polling`;
CREATE TABLE `post_polling` (
  `id` int(11) UNSIGNED NOT NULL,
  `post_id` int(11) UNSIGNED NOT NULL,
  `timeout_at` date NOT NULL
) 

-- --------------------------------------------------------

--
-- Struktur dari tabel `post_polling_option`
--

DROP TABLE IF EXISTS `post_polling_option`;
CREATE TABLE `post_polling_option` (
  `id` int(10) UNSIGNED NOT NULL,
  `post_polling_id` int(10) UNSIGNED NOT NULL,
  `attribute` varchar(50) NOT NULL
) 

-- --------------------------------------------------------

--
-- Struktur dari tabel `post_polling_stats`
--

DROP TABLE IF EXISTS `post_polling_stats`;
CREATE TABLE `post_polling_stats` (
  `post_polling_option_id` int(10) UNSIGNED NOT NULL,
  `account_id` int(10) UNSIGNED NOT NULL
) 

-- --------------------------------------------------------

--
-- Struktur dari tabel `post_retweet`
--

DROP TABLE IF EXISTS `post_retweet`;
CREATE TABLE `post_retweet` (
  `from_post_id` int(10) UNSIGNED NOT NULL,
  `to_post_id` int(10) UNSIGNED NOT NULL
) 

-- --------------------------------------------------------

--
-- Struktur dari tabel `post_text`
--

DROP TABLE IF EXISTS `post_text`;
CREATE TABLE `post_text` (
  `post_id` int(10) UNSIGNED NOT NULL,
  `text` varchar(255) NOT NULL
) 

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `account`
--
ALTER TABLE `account`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `attachment`
--
ALTER TABLE `attachment`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `chat`
--
ALTER TABLE `chat`
  ADD PRIMARY KEY (`id`),
  ADD KEY `chat_ibfk_1` (`from_account_id`),
  ADD KEY `chat_ibfk_2` (`to_account_id`);

--
-- Indeks untuk tabel `chat_attachment`
--
ALTER TABLE `chat_attachment`
  ADD KEY `chat_id` (`chat_id`),
  ADD KEY `attachment_id` (`attachment_id`);

--
-- Indeks untuk tabel `follow`
--
ALTER TABLE `follow`
  ADD PRIMARY KEY (`id`),
  ADD KEY `from_account_id` (`from_account_id`),
  ADD KEY `follow_ibfk_2` (`to_account_id`);

--
-- Indeks untuk tabel `notif`
--
ALTER TABLE `notif`
  ADD PRIMARY KEY (`id`),
  ADD KEY `account_id` (`account_id`);

--
-- Indeks untuk tabel `notif_post`
--
ALTER TABLE `notif_post`
  ADD KEY `notif_id` (`notif_id`),
  ADD KEY `post_id` (`post_id`);

--
-- Indeks untuk tabel `notif_post_like`
--
ALTER TABLE `notif_post_like`
  ADD KEY `notif_id` (`notif_id`),
  ADD KEY `post_like_id` (`post_like_id`);

--
-- Indeks untuk tabel `post`
--
ALTER TABLE `post`
  ADD PRIMARY KEY (`id`),
  ADD KEY `account_id` (`account_id`);

--
-- Indeks untuk tabel `post_attachment`
--
ALTER TABLE `post_attachment`
  ADD KEY `post_media_ibfk_1` (`post_id`),
  ADD KEY `attachment_id` (`attachment_id`);

--
-- Indeks untuk tabel `post_comment`
--
ALTER TABLE `post_comment`
  ADD KEY `from_post_id` (`from_post_id`),
  ADD KEY `to_post_id` (`to_post_id`);

--
-- Indeks untuk tabel `post_like`
--
ALTER TABLE `post_like`
  ADD PRIMARY KEY (`id`),
  ADD KEY `account_id` (`account_id`),
  ADD KEY `post_id` (`post_id`);

--
-- Indeks untuk tabel `post_polling`
--
ALTER TABLE `post_polling`
  ADD PRIMARY KEY (`id`),
  ADD KEY `post_id` (`post_id`);

--
-- Indeks untuk tabel `post_polling_option`
--
ALTER TABLE `post_polling_option`
  ADD PRIMARY KEY (`id`),
  ADD KEY `post_polling_option_ibfk_1` (`post_polling_id`);

--
-- Indeks untuk tabel `post_polling_stats`
--
ALTER TABLE `post_polling_stats`
  ADD KEY `post_polling_stats_ibfk_1` (`post_polling_option_id`),
  ADD KEY `account_id` (`account_id`);

--
-- Indeks untuk tabel `post_retweet`
--
ALTER TABLE `post_retweet`
  ADD KEY `post_id` (`from_post_id`),
  ADD KEY `post_retweet_ibfk_1` (`to_post_id`);

--
-- Indeks untuk tabel `post_text`
--
ALTER TABLE `post_text`
  ADD KEY `post_text_ibfk_1` (`post_id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `account`
--
ALTER TABLE `account`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `attachment`
--
ALTER TABLE `attachment`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `chat`
--
ALTER TABLE `chat`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `follow`
--
ALTER TABLE `follow`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `notif`
--
ALTER TABLE `notif`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `post`
--
ALTER TABLE `post`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `post_like`
--
ALTER TABLE `post_like`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `post_polling`
--
ALTER TABLE `post_polling`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `post_polling_option`
--
ALTER TABLE `post_polling_option`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `chat`
--
ALTER TABLE `chat`
  ADD CONSTRAINT `chat_ibfk_1` FOREIGN KEY (`from_account_id`) REFERENCES `account` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `chat_ibfk_2` FOREIGN KEY (`to_account_id`) REFERENCES `account` (`id`) ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `chat_attachment`
--
ALTER TABLE `chat_attachment`
  ADD CONSTRAINT `chat_attachment_ibfk_1` FOREIGN KEY (`chat_id`) REFERENCES `chat` (`id`),
  ADD CONSTRAINT `chat_attachment_ibfk_2` FOREIGN KEY (`attachment_id`) REFERENCES `attachment` (`id`);

--
-- Ketidakleluasaan untuk tabel `follow`
--
ALTER TABLE `follow`
  ADD CONSTRAINT `follow_ibfk_1` FOREIGN KEY (`from_account_id`) REFERENCES `account` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `follow_ibfk_2` FOREIGN KEY (`to_account_id`) REFERENCES `account` (`id`) ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `notif`
--
ALTER TABLE `notif`
  ADD CONSTRAINT `notif_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`) ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `notif_post`
--
ALTER TABLE `notif_post`
  ADD CONSTRAINT `notif_post_ibfk_1` FOREIGN KEY (`notif_id`) REFERENCES `notif` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `notif_post_ibfk_2` FOREIGN KEY (`post_id`) REFERENCES `post` (`id`);

--
-- Ketidakleluasaan untuk tabel `notif_post_like`
--
ALTER TABLE `notif_post_like`
  ADD CONSTRAINT `notif_post_like_ibfk_1` FOREIGN KEY (`notif_id`) REFERENCES `notif` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `notif_post_like_ibfk_2` FOREIGN KEY (`post_like_id`) REFERENCES `post_like` (`id`) ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `post`
--
ALTER TABLE `post`
  ADD CONSTRAINT `post_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`) ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `post_attachment`
--
ALTER TABLE `post_attachment`
  ADD CONSTRAINT `post_attachment_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `post` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `post_attachment_ibfk_2` FOREIGN KEY (`attachment_id`) REFERENCES `attachment` (`id`) ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `post_comment`
--
ALTER TABLE `post_comment`
  ADD CONSTRAINT `post_comment_ibfk_1` FOREIGN KEY (`from_post_id`) REFERENCES `post` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `post_comment_ibfk_2` FOREIGN KEY (`to_post_id`) REFERENCES `post` (`id`) ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `post_like`
--
ALTER TABLE `post_like`
  ADD CONSTRAINT `post_like_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `post_like_ibfk_2` FOREIGN KEY (`post_id`) REFERENCES `post` (`id`) ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `post_polling`
--
ALTER TABLE `post_polling`
  ADD CONSTRAINT `post_polling_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `post` (`id`) ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `post_polling_option`
--
ALTER TABLE `post_polling_option`
  ADD CONSTRAINT `post_polling_option_ibfk_1` FOREIGN KEY (`post_polling_id`) REFERENCES `post_polling` (`id`) ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `post_polling_stats`
--
ALTER TABLE `post_polling_stats`
  ADD CONSTRAINT `post_polling_stats_ibfk_1` FOREIGN KEY (`post_polling_option_id`) REFERENCES `post_polling_option` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `post_polling_stats_ibfk_2` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`) ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `post_retweet`
--
ALTER TABLE `post_retweet`
  ADD CONSTRAINT `post_retweet_ibfk_1` FOREIGN KEY (`to_post_id`) REFERENCES `post` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `post_retweet_ibfk_2` FOREIGN KEY (`from_post_id`) REFERENCES `post` (`id`);

--
-- Ketidakleluasaan untuk tabel `post_text`
--
ALTER TABLE `post_text`
  ADD CONSTRAINT `post_text_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `post` (`id`) ON UPDATE CASCADE;
COMMIT;
