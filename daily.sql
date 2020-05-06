/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 100309
 Source Host           : localhost:3306
 Source Schema         : daily

 Target Server Type    : MySQL
 Target Server Version : 100309
 File Encoding         : 65001

 Date: 06/05/2020 23:40:21
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for auth_group
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_group
-- ----------------------------
INSERT INTO `auth_group` VALUES (3, '普通员工');
INSERT INTO `auth_group` VALUES (2, '组长');
INSERT INTO `auth_group` VALUES (1, '超级管理员');

-- ----------------------------
-- Table structure for auth_group_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_group_permissions_group_id_permission_id_0cd325b0_uniq`(`group_id`, `permission_id`) USING BTREE,
  INDEX `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm`(`permission_id`) USING BTREE,
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 33 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_group_permissions
-- ----------------------------
INSERT INTO `auth_group_permissions` VALUES (1, 1, 1);
INSERT INTO `auth_group_permissions` VALUES (2, 1, 2);
INSERT INTO `auth_group_permissions` VALUES (3, 1, 3);
INSERT INTO `auth_group_permissions` VALUES (4, 1, 4);
INSERT INTO `auth_group_permissions` VALUES (5, 1, 5);
INSERT INTO `auth_group_permissions` VALUES (6, 1, 6);
INSERT INTO `auth_group_permissions` VALUES (7, 1, 7);
INSERT INTO `auth_group_permissions` VALUES (8, 1, 8);
INSERT INTO `auth_group_permissions` VALUES (9, 1, 9);
INSERT INTO `auth_group_permissions` VALUES (10, 1, 10);
INSERT INTO `auth_group_permissions` VALUES (11, 1, 11);
INSERT INTO `auth_group_permissions` VALUES (12, 1, 12);
INSERT INTO `auth_group_permissions` VALUES (13, 1, 17);
INSERT INTO `auth_group_permissions` VALUES (14, 1, 18);
INSERT INTO `auth_group_permissions` VALUES (15, 1, 19);
INSERT INTO `auth_group_permissions` VALUES (16, 1, 20);
INSERT INTO `auth_group_permissions` VALUES (17, 1, 21);
INSERT INTO `auth_group_permissions` VALUES (18, 1, 22);
INSERT INTO `auth_group_permissions` VALUES (19, 1, 23);
INSERT INTO `auth_group_permissions` VALUES (20, 1, 24);
INSERT INTO `auth_group_permissions` VALUES (21, 1, 25);
INSERT INTO `auth_group_permissions` VALUES (22, 1, 26);
INSERT INTO `auth_group_permissions` VALUES (23, 1, 27);
INSERT INTO `auth_group_permissions` VALUES (24, 1, 28);
INSERT INTO `auth_group_permissions` VALUES (26, 2, 13);
INSERT INTO `auth_group_permissions` VALUES (27, 2, 14);
INSERT INTO `auth_group_permissions` VALUES (28, 2, 15);
INSERT INTO `auth_group_permissions` VALUES (25, 2, 16);
INSERT INTO `auth_group_permissions` VALUES (30, 3, 13);
INSERT INTO `auth_group_permissions` VALUES (31, 3, 14);
INSERT INTO `auth_group_permissions` VALUES (32, 3, 15);
INSERT INTO `auth_group_permissions` VALUES (29, 3, 16);

-- ----------------------------
-- Table structure for auth_permission
-- ----------------------------
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_permission_content_type_id_codename_01ab375a_uniq`(`content_type_id`, `codename`) USING BTREE,
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 41 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_permission
-- ----------------------------
INSERT INTO `auth_permission` VALUES (1, 'Can add 部门', 1, 'add_department');
INSERT INTO `auth_permission` VALUES (2, 'Can change 部门', 1, 'change_department');
INSERT INTO `auth_permission` VALUES (3, 'Can delete 部门', 1, 'delete_department');
INSERT INTO `auth_permission` VALUES (4, 'Can view 部门', 1, 'view_department');
INSERT INTO `auth_permission` VALUES (5, 'Can add 方向', 2, 'add_direction');
INSERT INTO `auth_permission` VALUES (6, 'Can change 方向', 2, 'change_direction');
INSERT INTO `auth_permission` VALUES (7, 'Can delete 方向', 2, 'delete_direction');
INSERT INTO `auth_permission` VALUES (8, 'Can view 方向', 2, 'view_direction');
INSERT INTO `auth_permission` VALUES (9, 'Can add 业务组', 3, 'add_group');
INSERT INTO `auth_permission` VALUES (10, 'Can change 业务组', 3, 'change_group');
INSERT INTO `auth_permission` VALUES (11, 'Can delete 业务组', 3, 'delete_group');
INSERT INTO `auth_permission` VALUES (12, 'Can view 业务组', 3, 'view_group');
INSERT INTO `auth_permission` VALUES (13, 'Can add 日报', 4, 'add_record');
INSERT INTO `auth_permission` VALUES (14, 'Can change 日报', 4, 'change_record');
INSERT INTO `auth_permission` VALUES (15, 'Can delete 日报', 4, 'delete_record');
INSERT INTO `auth_permission` VALUES (16, 'Can view 日报', 4, 'view_record');
INSERT INTO `auth_permission` VALUES (17, 'Can add permission', 5, 'add_permission');
INSERT INTO `auth_permission` VALUES (18, 'Can change permission', 5, 'change_permission');
INSERT INTO `auth_permission` VALUES (19, 'Can delete permission', 5, 'delete_permission');
INSERT INTO `auth_permission` VALUES (20, 'Can view permission', 5, 'view_permission');
INSERT INTO `auth_permission` VALUES (21, 'Can add group', 6, 'add_group');
INSERT INTO `auth_permission` VALUES (22, 'Can change group', 6, 'change_group');
INSERT INTO `auth_permission` VALUES (23, 'Can delete group', 6, 'delete_group');
INSERT INTO `auth_permission` VALUES (24, 'Can view group', 6, 'view_group');
INSERT INTO `auth_permission` VALUES (25, 'Can add user', 7, 'add_user');
INSERT INTO `auth_permission` VALUES (26, 'Can change user', 7, 'change_user');
INSERT INTO `auth_permission` VALUES (27, 'Can delete user', 7, 'delete_user');
INSERT INTO `auth_permission` VALUES (28, 'Can view user', 7, 'view_user');
INSERT INTO `auth_permission` VALUES (29, 'Can add content type', 8, 'add_contenttype');
INSERT INTO `auth_permission` VALUES (30, 'Can change content type', 8, 'change_contenttype');
INSERT INTO `auth_permission` VALUES (31, 'Can delete content type', 8, 'delete_contenttype');
INSERT INTO `auth_permission` VALUES (32, 'Can view content type', 8, 'view_contenttype');
INSERT INTO `auth_permission` VALUES (33, 'Can add log entry', 9, 'add_logentry');
INSERT INTO `auth_permission` VALUES (34, 'Can change log entry', 9, 'change_logentry');
INSERT INTO `auth_permission` VALUES (35, 'Can delete log entry', 9, 'delete_logentry');
INSERT INTO `auth_permission` VALUES (36, 'Can view log entry', 9, 'view_logentry');
INSERT INTO `auth_permission` VALUES (37, 'Can add session', 10, 'add_session');
INSERT INTO `auth_permission` VALUES (38, 'Can change session', 10, 'change_session');
INSERT INTO `auth_permission` VALUES (39, 'Can delete session', 10, 'delete_session');
INSERT INTO `auth_permission` VALUES (40, 'Can view session', 10, 'view_session');

-- ----------------------------
-- Table structure for auth_user
-- ----------------------------
DROP TABLE IF EXISTS `auth_user`;
CREATE TABLE `auth_user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `last_login` datetime(6) NULL DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `first_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `last_name` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `email` varchar(254) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_user
-- ----------------------------
INSERT INTO `auth_user` VALUES (1, 'pbkdf2_sha256$180000$8Q4HMu9sQD1B$t7Ju4p8dvd9fL6MSmrf8B2IkcZ1fgfiS1aOT29amtDo=', '2020-05-06 21:36:32.733662', 1, 'admin', '', '', 'shinxu@163.com', 1, 1, '2020-05-06 21:34:15.336460');
INSERT INTO `auth_user` VALUES (2, 'pbkdf2_sha256$180000$FW8QHBRvXeQg$HsZyHSgpWQgDJfuRk5oxJqMSUe0xjm5P+tYefwWGPjM=', NULL, 0, '张晓艺', '', '', '', 1, 1, '2020-05-06 21:46:00.000000');
INSERT INTO `auth_user` VALUES (3, 'pbkdf2_sha256$180000$KhrnaJmCZ2wc$ovJYAA11KQgEo3fMqWaUZVUrr8638P6TF6/FNKoHwtM=', '2020-05-06 22:07:06.422054', 0, '何芬', '何芬', '', '', 1, 1, '2020-05-06 21:47:00.000000');

-- ----------------------------
-- Table structure for auth_user_groups
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_groups`;
CREATE TABLE `auth_user_groups`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_user_groups_user_id_group_id_94350c0c_uniq`(`user_id`, `group_id`) USING BTREE,
  INDEX `auth_user_groups_group_id_97559544_fk_auth_group_id`(`group_id`) USING BTREE,
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_user_groups
-- ----------------------------
INSERT INTO `auth_user_groups` VALUES (1, 2, 2);
INSERT INTO `auth_user_groups` VALUES (2, 3, 3);

-- ----------------------------
-- Table structure for auth_user_user_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_user_permissions`;
CREATE TABLE `auth_user_user_permissions`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq`(`user_id`, `permission_id`) USING BTREE,
  INDEX `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm`(`permission_id`) USING BTREE,
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_user_user_permissions
-- ----------------------------
INSERT INTO `auth_user_user_permissions` VALUES (2, 3, 13);
INSERT INTO `auth_user_user_permissions` VALUES (3, 3, 14);
INSERT INTO `auth_user_user_permissions` VALUES (4, 3, 15);
INSERT INTO `auth_user_user_permissions` VALUES (1, 3, 16);

-- ----------------------------
-- Table structure for django_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE `django_admin_log`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `object_repr` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL,
  `change_message` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `content_type_id` int(11) NULL DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `django_admin_log_content_type_id_c4bce8eb_fk_django_co`(`content_type_id`) USING BTREE,
  INDEX `django_admin_log_user_id_c564eba6_fk_auth_user_id`(`user_id`) USING BTREE,
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 30 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_admin_log
-- ----------------------------
INSERT INTO `django_admin_log` VALUES (1, '2020-05-06 21:37:56.509361', '1', 'python开发', 1, '[{\"added\": {}}]', 3, 1);
INSERT INTO `django_admin_log` VALUES (2, '2020-05-06 21:37:56.587359', '2', 'python开发', 1, '[{\"added\": {}}]', 3, 1);
INSERT INTO `django_admin_log` VALUES (3, '2020-05-06 21:38:08.433030', '3', 'c/c++开发', 1, '[{\"added\": {}}]', 3, 1);
INSERT INTO `django_admin_log` VALUES (4, '2020-05-06 21:38:29.357112', '2', 'Java开发', 2, '[{\"changed\": {\"fields\": [\"\\u540d\\u79f0\"]}}]', 3, 1);
INSERT INTO `django_admin_log` VALUES (5, '2020-05-06 21:40:03.223489', '1', 'Python开发', 1, '[{\"added\": {}}]', 2, 1);
INSERT INTO `django_admin_log` VALUES (6, '2020-05-06 21:40:11.264983', '2', 'Python测试', 1, '[{\"added\": {}}]', 2, 1);
INSERT INTO `django_admin_log` VALUES (7, '2020-05-06 21:40:33.477452', '3', 'c/c++', 1, '[{\"added\": {}}]', 2, 1);
INSERT INTO `django_admin_log` VALUES (8, '2020-05-06 21:40:45.627647', '1', 'python', 2, '[{\"changed\": {\"fields\": [\"\\u540d\\u79f0\"]}}]', 3, 1);
INSERT INTO `django_admin_log` VALUES (9, '2020-05-06 21:40:52.422273', '2', 'Java', 2, '[{\"changed\": {\"fields\": [\"\\u540d\\u79f0\"]}}]', 3, 1);
INSERT INTO `django_admin_log` VALUES (10, '2020-05-06 21:40:58.977687', '3', 'c/c++', 2, '[{\"changed\": {\"fields\": [\"\\u540d\\u79f0\"]}}]', 3, 1);
INSERT INTO `django_admin_log` VALUES (11, '2020-05-06 21:41:05.967477', '4', 'golang', 1, '[{\"added\": {}}]', 3, 1);
INSERT INTO `django_admin_log` VALUES (12, '2020-05-06 21:41:10.926798', '5', 'rust', 1, '[{\"added\": {}}]', 3, 1);
INSERT INTO `django_admin_log` VALUES (13, '2020-05-06 21:43:45.099421', '1', '超级管理员', 1, '[{\"added\": {}}]', 6, 1);
INSERT INTO `django_admin_log` VALUES (14, '2020-05-06 21:44:50.945367', '2', '组长', 1, '[{\"added\": {}}]', 6, 1);
INSERT INTO `django_admin_log` VALUES (15, '2020-05-06 21:45:16.877030', '3', '普通员工', 1, '[{\"added\": {}}]', 6, 1);
INSERT INTO `django_admin_log` VALUES (16, '2020-05-06 21:46:01.344140', '2', '张晓艺', 1, '[{\"added\": {}}]', 7, 1);
INSERT INTO `django_admin_log` VALUES (17, '2020-05-06 21:46:17.874082', '2', '张晓艺', 2, '[{\"changed\": {\"fields\": [\"Groups\"]}}]', 7, 1);
INSERT INTO `django_admin_log` VALUES (18, '2020-05-06 21:46:29.832082', '2', '张晓艺', 2, '[{\"changed\": {\"fields\": [\"Staff status\"]}}]', 7, 1);
INSERT INTO `django_admin_log` VALUES (19, '2020-05-06 21:47:04.860248', '3', '何芬', 1, '[{\"added\": {}}]', 7, 1);
INSERT INTO `django_admin_log` VALUES (20, '2020-05-06 21:47:15.876570', '3', '何芬', 2, '[{\"changed\": {\"fields\": [\"Staff status\", \"Groups\"]}}]', 7, 1);
INSERT INTO `django_admin_log` VALUES (21, '2020-05-06 22:00:24.118993', '3', '电商部', 1, '[{\"added\": {}}]', 1, 1);
INSERT INTO `django_admin_log` VALUES (22, '2020-05-06 22:00:37.928776', '4', '研发部', 1, '[{\"added\": {}}]', 1, 1);
INSERT INTO `django_admin_log` VALUES (23, '2020-05-06 22:00:54.319038', '5', '测试部', 1, '[{\"added\": {}}]', 1, 1);
INSERT INTO `django_admin_log` VALUES (24, '2020-05-06 22:01:55.496387', '3', '何芬', 2, '[{\"changed\": {\"fields\": [\"First name\"]}}]', 7, 1);
INSERT INTO `django_admin_log` VALUES (25, '2020-05-06 22:01:55.519386', '3', '何芬', 2, '[{\"changed\": {\"fields\": [\"First name\"]}}]', 7, 1);
INSERT INTO `django_admin_log` VALUES (26, '2020-05-06 22:04:32.865262', '1', '何芬', 1, '[{\"added\": {}}]', 4, 3);
INSERT INTO `django_admin_log` VALUES (27, '2020-05-06 22:06:18.525074', '3', '普通员工', 2, '[]', 6, 1);
INSERT INTO `django_admin_log` VALUES (28, '2020-05-06 22:06:49.537426', '3', '何芬', 2, '[{\"changed\": {\"fields\": [\"User permissions\", \"Last login\"]}}]', 7, 1);
INSERT INTO `django_admin_log` VALUES (29, '2020-05-06 22:09:06.104553', '1', '何芬', 2, '[{\"changed\": {\"fields\": [\"\\u90e8\\u95e8\"]}}]', 4, 1);

-- ----------------------------
-- Table structure for django_content_type
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `model` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `django_content_type_app_label_model_76bd3d3b_uniq`(`app_label`, `model`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_content_type
-- ----------------------------
INSERT INTO `django_content_type` VALUES (9, 'admin', 'logentry');
INSERT INTO `django_content_type` VALUES (6, 'auth', 'group');
INSERT INTO `django_content_type` VALUES (5, 'auth', 'permission');
INSERT INTO `django_content_type` VALUES (7, 'auth', 'user');
INSERT INTO `django_content_type` VALUES (8, 'contenttypes', 'contenttype');
INSERT INTO `django_content_type` VALUES (1, 'paper', 'department');
INSERT INTO `django_content_type` VALUES (2, 'paper', 'direction');
INSERT INTO `django_content_type` VALUES (3, 'paper', 'group');
INSERT INTO `django_content_type` VALUES (4, 'paper', 'record');
INSERT INTO `django_content_type` VALUES (10, 'sessions', 'session');

-- ----------------------------
-- Table structure for django_migrations
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_migrations
-- ----------------------------
INSERT INTO `django_migrations` VALUES (1, 'contenttypes', '0001_initial', '2020-05-06 21:32:52.192379');
INSERT INTO `django_migrations` VALUES (2, 'auth', '0001_initial', '2020-05-06 21:32:53.749119');
INSERT INTO `django_migrations` VALUES (3, 'paper', '0001_initial', '2020-05-06 21:33:00.789419');
INSERT INTO `django_migrations` VALUES (4, 'contenttypes', '0002_remove_content_type_name', '2020-05-06 21:33:41.193261');
INSERT INTO `django_migrations` VALUES (5, 'auth', '0002_alter_permission_name_max_length', '2020-05-06 21:33:42.052013');
INSERT INTO `django_migrations` VALUES (6, 'auth', '0003_alter_user_email_max_length', '2020-05-06 21:33:42.757668');
INSERT INTO `django_migrations` VALUES (7, 'auth', '0004_alter_user_username_opts', '2020-05-06 21:33:42.854649');
INSERT INTO `django_migrations` VALUES (8, 'auth', '0005_alter_user_last_login_null', '2020-05-06 21:33:43.360320');
INSERT INTO `django_migrations` VALUES (9, 'auth', '0006_require_contenttypes_0002', '2020-05-06 21:33:43.441256');
INSERT INTO `django_migrations` VALUES (10, 'auth', '0007_alter_validators_add_error_messages', '2020-05-06 21:33:43.500339');
INSERT INTO `django_migrations` VALUES (11, 'auth', '0008_alter_user_username_max_length', '2020-05-06 21:33:44.287468');
INSERT INTO `django_migrations` VALUES (12, 'auth', '0009_alter_user_last_name_max_length', '2020-05-06 21:33:45.110659');
INSERT INTO `django_migrations` VALUES (13, 'auth', '0010_alter_group_name_max_length', '2020-05-06 21:33:45.863751');
INSERT INTO `django_migrations` VALUES (14, 'auth', '0011_update_proxy_permissions', '2020-05-06 21:33:45.965153');
INSERT INTO `django_migrations` VALUES (15, 'admin', '0001_initial', '2020-05-06 21:35:46.936236');
INSERT INTO `django_migrations` VALUES (16, 'admin', '0002_logentry_remove_auto_add', '2020-05-06 21:35:48.321172');
INSERT INTO `django_migrations` VALUES (17, 'admin', '0003_logentry_add_action_flag_choices', '2020-05-06 21:35:48.417173');
INSERT INTO `django_migrations` VALUES (18, 'sessions', '0001_initial', '2020-05-06 21:35:48.724312');
INSERT INTO `django_migrations` VALUES (19, 'paper', '0002_auto_20200506_2139', '2020-05-06 21:39:20.877606');

-- ----------------------------
-- Table structure for django_session
-- ----------------------------
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session`  (
  `session_key` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `session_data` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`) USING BTREE,
  INDEX `django_session_expire_date_a5c62663`(`expire_date`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_session
-- ----------------------------
INSERT INTO `django_session` VALUES ('5vdulyc3gejsnlyy9fuhq3ptyo71qxhk', 'Njc1MGQxYjE2NDExZTg5M2Y5OTU0OGZkNGQyYzNiMmYyYmQyODZiMzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5ZjE4MDhmZjViYjNhOGQxNTg0ZDI4MDcxZjRkMmVkNmRiYTM3OTg1In0=', '2020-05-20 21:36:32.792661');
INSERT INTO `django_session` VALUES ('hxg4prhw5z1k12eete2txsqwqpu3wj2b', 'MmVlNzAxYzI1ZjVhYjQ1YzhjMWMwNTcxZGY3MTQ0ODk1Y2YxNDVmODp7Il9hdXRoX3VzZXJfaWQiOiIzIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJiN2ZiODM3NTg4ZGMwYjhlYjY4ODg1MTFkOTlhZmMwOWRmZDA3MjNiIn0=', '2020-05-20 22:07:06.480070');

-- ----------------------------
-- Table structure for paper_department
-- ----------------------------
DROP TABLE IF EXISTS `paper_department`;
CREATE TABLE `paper_department`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `leader_id` int(11) NOT NULL,
  `super_department_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE,
  INDEX `paper_department_leader_id_7b194a05_fk_auth_user_id`(`leader_id`) USING BTREE,
  INDEX `super_department_id`(`super_department_id`) USING BTREE,
  CONSTRAINT `paper_department_leader_id_7b194a05_fk_auth_user_id` FOREIGN KEY (`leader_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `paper_department_ibfk_1` FOREIGN KEY (`super_department_id`) REFERENCES `paper_department` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of paper_department
-- ----------------------------
INSERT INTO `paper_department` VALUES (2, '系统预置', '2020-05-06 21:59:16.000000', '2020-05-06 21:59:12.000000', 1, NULL);
INSERT INTO `paper_department` VALUES (3, '电商部', '2020-05-06 22:00:24.117993', '2020-05-06 22:00:24.117993', 3, 2);
INSERT INTO `paper_department` VALUES (4, '研发部', '2020-05-06 22:00:37.927776', '2020-05-06 22:00:37.927776', 2, 3);
INSERT INTO `paper_department` VALUES (5, '测试部', '2020-05-06 22:00:54.317037', '2020-05-06 22:00:54.317037', 3, 3);

-- ----------------------------
-- Table structure for paper_direction
-- ----------------------------
DROP TABLE IF EXISTS `paper_direction`;
CREATE TABLE `paper_direction`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `paper_direction_name_64d42f66_uniq`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of paper_direction
-- ----------------------------
INSERT INTO `paper_direction` VALUES (1, 'Python开发', '2020-05-06 21:40:03.222489', '2020-05-06 21:40:03.222489');
INSERT INTO `paper_direction` VALUES (2, 'Python测试', '2020-05-06 21:40:11.263982', '2020-05-06 21:40:11.263982');
INSERT INTO `paper_direction` VALUES (3, 'c/c++', '2020-05-06 21:40:33.476438', '2020-05-06 21:40:33.476438');

-- ----------------------------
-- Table structure for paper_group
-- ----------------------------
DROP TABLE IF EXISTS `paper_group`;
CREATE TABLE `paper_group`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `paper_group_name_e5a3fecf_uniq`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of paper_group
-- ----------------------------
INSERT INTO `paper_group` VALUES (1, 'python', '2020-05-06 21:37:56.508361', '2020-05-06 21:40:45.625647');
INSERT INTO `paper_group` VALUES (2, 'Java', '2020-05-06 21:37:56.579358', '2020-05-06 21:40:52.421274');
INSERT INTO `paper_group` VALUES (3, 'c/c++', '2020-05-06 21:38:08.432030', '2020-05-06 21:40:58.976686');
INSERT INTO `paper_group` VALUES (4, 'golang', '2020-05-06 21:41:05.966468', '2020-05-06 21:41:05.966468');
INSERT INTO `paper_group` VALUES (5, 'rust', '2020-05-06 21:41:10.925783', '2020-05-06 21:41:10.925783');

-- ----------------------------
-- Table structure for paper_record
-- ----------------------------
DROP TABLE IF EXISTS `paper_record`;
CREATE TABLE `paper_record`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `employee_no` varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `task_progress` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `tomorrow_task` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `pub_date` date NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `creator_id` int(11) NOT NULL,
  `department_id` int(11) NOT NULL,
  `direction_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `paper_record_creator_id_3d0b28d1_fk_auth_user_id`(`creator_id`) USING BTREE,
  INDEX `paper_record_department_id_0bfb7ad0_fk_paper_department_id`(`department_id`) USING BTREE,
  INDEX `paper_record_direction_id_3f24b4a7_fk_paper_direction_id`(`direction_id`) USING BTREE,
  INDEX `paper_record_group_id_53ed5f41_fk_paper_group_id`(`group_id`) USING BTREE,
  CONSTRAINT `paper_record_creator_id_3d0b28d1_fk_auth_user_id` FOREIGN KEY (`creator_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `paper_record_department_id_0bfb7ad0_fk_paper_department_id` FOREIGN KEY (`department_id`) REFERENCES `paper_department` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `paper_record_direction_id_3f24b4a7_fk_paper_direction_id` FOREIGN KEY (`direction_id`) REFERENCES `paper_direction` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `paper_record_group_id_53ed5f41_fk_paper_group_id` FOREIGN KEY (`group_id`) REFERENCES `paper_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of paper_record
-- ----------------------------
INSERT INTO `paper_record` VALUES (1, '何芬', 'DS1001', '1、编写接口文档\r\n2、参与需求分析，评估工作量\r\n3、工作内容划分，人员任务制定', '1、编写接口文档\r\n2、参与需求分析，评估工作量\r\n3、工作内容划分，人员任务制定', '2020-05-06', '2020-05-06 22:04:32.863262', '2020-05-06 22:09:06.101563', 3, 4, 1, 1);

SET FOREIGN_KEY_CHECKS = 1;