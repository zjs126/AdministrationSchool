/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80032
 Source Host           : localhost:3306
 Source Schema         : administration

 Target Server Type    : MySQL
 Target Server Version : 80032
 File Encoding         : 65001

 Date: 19/12/2023 18:15:42
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for apply
-- ----------------------------
DROP TABLE IF EXISTS `apply`;
CREATE TABLE `apply`  (
  `stu_id` int(0) NOT NULL,
  `course_id` int(0) NOT NULL,
  `situation` int(0) NULL DEFAULT NULL COMMENT '1为批准0为不批准',
  `administrator` int(0) NULL DEFAULT NULL COMMENT '审核人id',
  `reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `university` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `year` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `trimesters` int(0) NOT NULL,
  `create_time` datetime(0) NOT NULL ON UPDATE CURRENT_TIMESTAMP(0),
  `update_time` datetime(0) NOT NULL ON UPDATE CURRENT_TIMESTAMP(0),
  `submit` int(0) NOT NULL,
  PRIMARY KEY (`stu_id`, `course_id`) USING BTREE,
  INDEX `stu_id1`(`stu_id`) USING BTREE,
  INDEX `course_id1`(`course_id`) USING BTREE,
  CONSTRAINT `course_id1` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `stu_id1` FOREIGN KEY (`stu_id`) REFERENCES `student` (`stu_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of apply
-- ----------------------------
INSERT INTO `apply` VALUES (202101, 2, 1, 1, '住院生病了，恳请批准', '华中师范大学', '2021-2022', 1, '2023-12-17 21:33:56', '2023-12-17 21:33:56', 1);
INSERT INTO `apply` VALUES (202101, 3, 0, 1, '住院生病了', '华中师范大学', '2021-2022', 1, '2023-12-17 21:33:28', '2023-12-17 21:33:28', 1);

-- ----------------------------
-- Table structure for classroom
-- ----------------------------
DROP TABLE IF EXISTS `classroom`;
CREATE TABLE `classroom`  (
  `classroom` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '教室类型',
  `university` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`classroom`, `university`) USING BTREE,
  INDEX `classroom`(`classroom`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of classroom
-- ----------------------------
INSERT INTO `classroom` VALUES ('8号楼8112', '普通教室', '华中师范大学');
INSERT INTO `classroom` VALUES ('N108', '普通教室', '华中师范大学');
INSERT INTO `classroom` VALUES ('N112', '普通教室', '华中师范大学');
INSERT INTO `classroom` VALUES ('N113', '普通教室', '华中师范大学');
INSERT INTO `classroom` VALUES ('N115', '普通教室', '华中师范大学');
INSERT INTO `classroom` VALUES ('N201', '普通教室', '华中师范大学');
INSERT INTO `classroom` VALUES ('N520', '实验室', '华中师范大学');
INSERT INTO `classroom` VALUES ('N522', '实验室', '华中师范大学');
INSERT INTO `classroom` VALUES ('N524', '实验室', '华中师范大学');
INSERT INTO `classroom` VALUES ('乒羽馆', '乒羽馆', '华中师范大学');

-- ----------------------------
-- Table structure for classroomapply
-- ----------------------------
DROP TABLE IF EXISTS `classroomapply`;
CREATE TABLE `classroomapply`  (
  `courseID` int(0) NOT NULL,
  `classroom` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `staff_id` int(0) NOT NULL,
  `university` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `state` int(0) NOT NULL DEFAULT 0 COMMENT '审核状态',
  `id` int(0) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `staffaafaef`(`staff_id`) USING BTREE,
  INDEX `classroomgsgrwg`(`classroom`) USING BTREE,
  INDEX `courseID`(`courseID`) USING BTREE,
  CONSTRAINT `classroomgsgrwg` FOREIGN KEY (`classroom`) REFERENCES `classroom` (`classroom`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `courseID` FOREIGN KEY (`courseID`) REFERENCES `course` (`course_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `staffaafaef` FOREIGN KEY (`staff_id`) REFERENCES `teacher` (`staff_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of classroomapply
-- ----------------------------
INSERT INTO `classroomapply` VALUES (2, 'N112', 2, '华中师范大学', 1, 6);
INSERT INTO `classroomapply` VALUES (2, 'N112', 2, '华中师范大学', 1, 7);
INSERT INTO `classroomapply` VALUES (2, 'N112', 2, '华中师范大学', 1, 8);
INSERT INTO `classroomapply` VALUES (2, 'N112', 2, '华中师范大学', 1, 9);

-- ----------------------------
-- Table structure for course
-- ----------------------------
DROP TABLE IF EXISTS `course`;
CREATE TABLE `course`  (
  `course_id` int(0) NOT NULL,
  `course_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `teacher_id` int(0) NOT NULL,
  `classroom` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `time` int(0) NOT NULL COMMENT '1为早八 2为早十 3为下二 4为下四',
  `date` int(0) NOT NULL COMMENT '周一到周五',
  `type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `state` int(0) NULL DEFAULT 1 COMMENT '1为开设',
  `university` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `college` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `credit` int(0) NOT NULL COMMENT '学分',
  `volume` int(0) NULL DEFAULT NULL COMMENT '容量',
  PRIMARY KEY (`course_id`, `university`) USING BTREE,
  INDEX `classroom`(`classroom`) USING BTREE,
  INDEX `staff_id`(`teacher_id`) USING BTREE,
  INDEX `course_id`(`course_id`) USING BTREE,
  CONSTRAINT `classroom` FOREIGN KEY (`classroom`) REFERENCES `classroom` (`classroom`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `staff_id` FOREIGN KEY (`teacher_id`) REFERENCES `teacher` (`staff_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of course
-- ----------------------------
INSERT INTO `course` VALUES (1, '云计算', 3, 'N201', 1, 3, '个性发展课', '有关云计算方面的知识，熟悉云端开发', 0, '华中师范大学', '计算机学院', 2, 40);
INSERT INTO `course` VALUES (2, '算法设计与分析', 2, 'N112', 2, 2, '专业必修课', '必修课', 0, '华中师范大学', '计算机学院', 2, 50);
INSERT INTO `course` VALUES (3, '数据结构', 3, 'N201', 3, 3, '通识主干课', '熟悉计算机高级语言中常用的结构', 0, '华中师范大学', '计算机学院', 2, 40);
INSERT INTO `course` VALUES (4, '操作系统原理', 2, 'N520', 4, 2, '专业必修课', '学习操作系统的基本原理以及相关的调度算法', 0, '华中师范大学', '计算机学院', 2, 50);
INSERT INTO `course` VALUES (5, '高等数学', 7, 'N201', 1, 1, '通识主干课', '学习高等数学的基本原理', 0, '华中师范大学', '数学与统计学学院', 6, 40);
INSERT INTO `course` VALUES (6, '大学物理', 11, 'N201', 2, 1, '通识主干课', '学习大学物理的基本知识', 0, '华中师范大学', '物理学院', 2, 50);
INSERT INTO `course` VALUES (7, '化学让生活更美好', 10, '8号楼8112', 3, 1, '通识核心课', '学习生活的化学知识', 0, '华中师范大学', '化学学院', 2, 80);
INSERT INTO `course` VALUES (8, '大学英语', 12, 'N113', 4, 1, '通识主干课', '学习英语', 0, '华中师范大学', '外国语学院', 2, 40);
INSERT INTO `course` VALUES (9, '乒乓球', 8, '乒羽馆', 1, 2, '通识主干课', '学习乒乓球', 0, '华中师范大学', '体育学院', 2, 50);
INSERT INTO `course` VALUES (10, '马克思主义理论', 9, 'N115', 2, 2, '通识主干课', '学习马克思主义理论', 0, '华中师范大学', '马克思主义学院', 2, 80);
INSERT INTO `course` VALUES (11, '离散数学', 3, 'N108', 3, 2, '通识主干课', '学习离散数学', 0, '华中师范大学', '计算机学院', 2, 50);
INSERT INTO `course` VALUES (12, '概率统计', 7, 'N201', 4, 2, '专业必修课', '学习相应知识', 0, '华中师范大学', '计算机学院', 2, 50);
INSERT INTO `course` VALUES (13, '计算机网络', 2, 'N113', 1, 3, '专业必修课', '学习相应知识', 0, '华中师范大学', '计算机学院', 2, 50);
INSERT INTO `course` VALUES (14, '概率统计', 7, 'N201', 1, 1, '通识主干课', '学习高等数学的基本原理', 0, '华中师范大学', '数学与统计学学院', 6, 40);
INSERT INTO `course` VALUES (15, '流体力学', 11, 'N201', 2, 1, '通识主干课', '学习大学物理的基本知识', 0, '华中师范大学', '物理学院', 2, 50);
INSERT INTO `course` VALUES (16, '农药的原理', 10, '8号楼8112', 3, 1, '通识核心课', '学习生活的化学知识', 0, '华中师范大学', '化学学院', 2, 80);
INSERT INTO `course` VALUES (17, '大学英语视听说', 12, 'N113', 4, 1, '通识主干课', '学习英语', 0, '华中师范大学', '外国语学院', 2, 40);
INSERT INTO `course` VALUES (18, '羽毛球', 8, '乒羽馆', 1, 2, '通识主干课', '学习乒乓球', 0, '华中师范大学', '体育学院', 2, 50);
INSERT INTO `course` VALUES (19, '近代史纲要', 9, 'N115', 2, 2, '通识主干课', '学习马克思主义理论', 0, '华中师范大学', '马克思主义学院', 2, 80);
INSERT INTO `course` VALUES (20, '数字逻辑', 3, 'N108', 3, 2, '通识主干课', '学习离散数学', 0, '华中师范大学', '计算机学院', 2, 50);
INSERT INTO `course` VALUES (21, '面向对象程序设计', 7, 'N201', 4, 2, '专业必修课', '学习相应知识', 0, '华中师范大学', '计算机学院', 2, 50);
INSERT INTO `course` VALUES (22, '计算机组成原理', 2, 'N113', 1, 3, '专业必修课', '学习相应知识', 0, '华中师范大学', '计算机学院', 2, 50);
INSERT INTO `course` VALUES (23, '线性代数', 7, 'N201', 1, 1, '通识主干课', '学习高等数学的基本原理', 0, '华中师范大学', '数学与统计学学院', 6, 40);
INSERT INTO `course` VALUES (24, '空气动力学', 11, 'N201', 2, 1, '通识主干课', '学习大学物理的基本知识', 0, '华中师范大学', '物理学院', 2, 50);
INSERT INTO `course` VALUES (25, '有机化学', 10, '8号楼8112', 3, 1, '通识核心课', '学习生活的化学知识', 0, '华中师范大学', '化学学院', 2, 80);
INSERT INTO `course` VALUES (26, '国际文化交流', 12, 'N113', 4, 1, '通识主干课', '学习英语', 0, '华中师范大学', '外国语学院', 2, 40);
INSERT INTO `course` VALUES (27, '乒乓球2', 8, '乒羽馆', 1, 2, '通识主干课', '学习乒乓球', 0, '华中师范大学', '体育学院', 2, 50);
INSERT INTO `course` VALUES (28, '毛泽东思想', 9, 'N115', 2, 2, '通识主干课', '学习马克思主义理论', 0, '华中师范大学', '马克思主义学院', 2, 80);
INSERT INTO `course` VALUES (29, '人工智能', 3, 'N108', 3, 2, '通识主干课', '学习离散数学', 0, '华中师范大学', '计算机学院', 2, 50);
INSERT INTO `course` VALUES (30, '软件工程导论', 7, 'N201', 4, 2, '专业必修课', '学习相应知识', 0, '华中师范大学', '计算机学院', 2, 50);
INSERT INTO `course` VALUES (31, '并行计算', 2, 'N113', 1, 3, '专业必修课', '学习相应知识', 0, '华中师范大学', '计算机学院', 2, 50);
INSERT INTO `course` VALUES (32, '计算机基础', 3, 'N201', 2, 2, '通知主干课', '计算机基础', 0, '华中师范大学', '计算机学院', 2, 50);

-- ----------------------------
-- Table structure for forum
-- ----------------------------
DROP TABLE IF EXISTS `forum`;
CREATE TABLE `forum`  (
  `id` int(0) NOT NULL,
  `userType` int(0) NOT NULL,
  `comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `university` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of forum
-- ----------------------------
INSERT INTO `forum` VALUES (202101, 1, '1111', '学生1', '华中师范大学');
INSERT INTO `forum` VALUES (202101, 1, '111111111', '学生1', '华中师范大学');

-- ----------------------------
-- Table structure for lesson
-- ----------------------------
DROP TABLE IF EXISTS `lesson`;
CREATE TABLE `lesson`  (
  `id` int(0) NOT NULL,
  `class_name` int(0) NULL DEFAULT NULL,
  `grade` int(0) NULL DEFAULT NULL,
  `college` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `university` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`, `university`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for log
-- ----------------------------
DROP TABLE IF EXISTS `log`;
CREATE TABLE `log`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `login_time` datetime(0) NULL DEFAULT NULL COMMENT '登录时间',
  `login_user` int(0) NULL DEFAULT NULL COMMENT '登录人id',
  `user_type` int(0) NULL DEFAULT NULL COMMENT '登录人身份',
  `cost_time` bigint(0) NULL DEFAULT NULL COMMENT '耗时，单位“ms”',
  `login_status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '登录还是登出',
  `university` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 209 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of log
-- ----------------------------
INSERT INTO `log` VALUES (1, '2023-12-13 14:20:16', 1, 4, 2, 'logout', '华中师范大学');
INSERT INTO `log` VALUES (2, '2023-12-13 14:25:10', 1, 4, 245, 'login', '华中师范大学');
INSERT INTO `log` VALUES (3, '2023-12-13 14:26:40', 1, 4, 493, 'login', '华中师范大学');
INSERT INTO `log` VALUES (4, '2023-12-13 14:27:54', 1, 4, 0, 'logout', '华中师范大学');
INSERT INTO `log` VALUES (5, '2023-12-13 14:28:01', 1, 4, 14, 'login', '华中师范大学');
INSERT INTO `log` VALUES (6, '2023-12-13 14:28:15', 1, 4, 158, 'login', '华中师范大学');
INSERT INTO `log` VALUES (7, '2023-12-13 14:29:18', 202101, 1, 0, 'logout', '华中师范大学');
INSERT INTO `log` VALUES (8, '2023-12-13 14:46:19', 202102, 1, 711, 'login', '华中师范大学');
INSERT INTO `log` VALUES (9, '2023-12-13 14:46:37', 202102, 1, 5, 'logout', '华中师范大学');
INSERT INTO `log` VALUES (10, '2023-12-13 14:46:55', 202103, 1, 76, 'login', '华中师范大学');
INSERT INTO `log` VALUES (11, '2023-12-13 14:47:07', 202103, 1, 4, 'logout', '华中师范大学');
INSERT INTO `log` VALUES (12, '2023-12-13 14:47:19', 1, 4, 353, 'login', '华中师范大学');
INSERT INTO `log` VALUES (13, '2023-12-13 21:13:58', 202101, 1, 383, 'login', '华中师范大学');
INSERT INTO `log` VALUES (14, '2023-12-13 21:14:36', 202101, 1, 1, 'logout', '华中师范大学');
INSERT INTO `log` VALUES (15, '2023-12-13 21:14:55', 1, 4, 90, 'login', '华中师范大学');
INSERT INTO `log` VALUES (16, '2023-12-13 21:29:02', 1, 4, 1, 'logout', '华中师范大学');
INSERT INTO `log` VALUES (17, '2023-12-13 21:32:37', 3, 2, 87, 'login', '华中师范大学');
INSERT INTO `log` VALUES (18, '2023-12-13 21:32:58', 3, 2, 0, 'logout', '华中师范大学');
INSERT INTO `log` VALUES (19, '2023-12-13 21:33:05', 202101, 1, 89, 'login', '华中师范大学');
INSERT INTO `log` VALUES (20, '2023-12-13 21:33:13', 202101, 1, 0, 'logout', '华中师范大学');
INSERT INTO `log` VALUES (21, '2023-12-13 21:35:47', 6, 2, 88, 'login', '华中师范大学');
INSERT INTO `log` VALUES (22, '2023-12-13 21:35:54', 6, 2, 0, 'logout', '华中师范大学');
INSERT INTO `log` VALUES (23, '2023-12-13 21:36:15', 5, 3, 85, 'login', '华中师范大学');
INSERT INTO `log` VALUES (24, '2023-12-13 21:36:22', 4, 4, 85, 'login', '华中师范大学');
INSERT INTO `log` VALUES (25, '2023-12-13 21:36:25', 4, 4, 0, 'logout', '华中师范大学');
INSERT INTO `log` VALUES (26, '2023-12-14 10:22:13', 3, 2, 479, 'login', '华中师范大学');
INSERT INTO `log` VALUES (27, '2023-12-14 13:58:45', 3, 2, 2, 'logout', '华中师范大学');
INSERT INTO `log` VALUES (28, '2023-12-14 13:59:05', 1, 4, 127, 'login', '华中师范大学');
INSERT INTO `log` VALUES (29, '2023-12-14 14:00:20', 1, 4, 1, 'logout', '华中师范大学');
INSERT INTO `log` VALUES (30, '2023-12-14 14:00:35', 202101, 1, 88, 'login', '华中师范大学');
INSERT INTO `log` VALUES (31, '2023-12-14 14:01:05', 202101, 1, 1, 'logout', '华中师范大学');
INSERT INTO `log` VALUES (32, '2023-12-14 14:01:24', 3, 2, 88, 'login', '华中师范大学');
INSERT INTO `log` VALUES (33, '2023-12-14 14:21:20', 3, 2, 0, 'logout', '华中师范大学');
INSERT INTO `log` VALUES (34, '2023-12-14 14:21:31', 3, 2, 89, 'login', '华中师范大学');
INSERT INTO `log` VALUES (35, '2023-12-14 14:29:46', 3, 2, 0, 'logout', '华中师范大学');
INSERT INTO `log` VALUES (36, '2023-12-14 14:30:06', 202101, 1, 86, 'login', '华中师范大学');
INSERT INTO `log` VALUES (37, '2023-12-14 14:30:22', 202101, 1, 0, 'logout', '华中师范大学');
INSERT INTO `log` VALUES (38, '2023-12-14 14:30:27', 3, 2, 87, 'login', '华中师范大学');
INSERT INTO `log` VALUES (39, '2023-12-14 15:20:08', 3, 2, 3, 'logout', '华中师范大学');
INSERT INTO `log` VALUES (40, '2023-12-14 15:20:15', 1, 4, 125, 'login', '华中师范大学');
INSERT INTO `log` VALUES (41, '2023-12-14 15:36:20', 1, 4, 2, 'logout', '华中师范大学');
INSERT INTO `log` VALUES (42, '2023-12-14 15:36:28', 3, 2, 116, 'login', '华中师范大学');
INSERT INTO `log` VALUES (43, '2023-12-14 18:27:27', 1, 4, 2, 'logout', '华中师范大学');
INSERT INTO `log` VALUES (44, '2023-12-14 18:27:42', 202101, 1, 437, 'login', '华中师范大学');
INSERT INTO `log` VALUES (45, '2023-12-14 18:27:49', 202101, 1, 1, 'logout', '华中师范大学');
INSERT INTO `log` VALUES (46, '2023-12-14 18:28:44', 202102, 1, 99, 'login', '华中师范大学');
INSERT INTO `log` VALUES (47, '2023-12-14 18:28:50', 202102, 1, 1, 'logout', '华中师范大学');
INSERT INTO `log` VALUES (48, '2023-12-14 18:29:02', 202103, 1, 350, 'login', '华中师范大学');
INSERT INTO `log` VALUES (49, '2023-12-14 18:29:08', 202103, 1, 3, 'logout', '华中师范大学');
INSERT INTO `log` VALUES (50, '2023-12-14 18:29:24', 202104, 1, 101, 'login', '华中师范大学');
INSERT INTO `log` VALUES (51, '2023-12-14 18:29:30', 202104, 1, 0, 'logout', '华中师范大学');
INSERT INTO `log` VALUES (52, '2023-12-14 18:29:35', 1, 4, 358, 'login', '华中师范大学');
INSERT INTO `log` VALUES (53, '2023-12-14 20:46:47', 1, 4, 2, 'logout', '华中师范大学');
INSERT INTO `log` VALUES (54, '2023-12-14 20:46:54', 1, 4, 513, 'login', '华中师范大学');
INSERT INTO `log` VALUES (55, '2023-12-15 01:01:38', 1, 4, 8, 'logout', '华中师范大学');
INSERT INTO `log` VALUES (56, '2023-12-15 01:01:49', 1, 4, 134, 'login', '华中师范大学');
INSERT INTO `log` VALUES (57, '2023-12-15 01:02:10', 1, 4, 1, 'logout', '华中师范大学');
INSERT INTO `log` VALUES (58, '2023-12-15 01:02:15', 2, 2, 292, 'login', '华中师范大学');
INSERT INTO `log` VALUES (59, '2023-12-15 01:02:44', 2, 2, 0, 'logout', '华中师范大学');
INSERT INTO `log` VALUES (60, '2023-12-15 01:03:01', 1, 4, 320, 'login', '华中师范大学');
INSERT INTO `log` VALUES (61, '2023-12-15 01:03:13', 1, 4, 0, 'logout', '华中师范大学');
INSERT INTO `log` VALUES (62, '2023-12-15 01:03:22', 2, 2, 361, 'login', '华中师范大学');
INSERT INTO `log` VALUES (63, '2023-12-15 01:04:15', 2, 2, 0, 'logout', '华中师范大学');
INSERT INTO `log` VALUES (64, '2023-12-15 01:04:26', 202101, 1, 91, 'login', '华中师范大学');
INSERT INTO `log` VALUES (65, '2023-12-15 01:07:54', 202101, 1, 6, 'logout', '华中师范大学');
INSERT INTO `log` VALUES (66, '2023-12-15 01:08:02', 1, 4, 290, 'login', '华中师范大学');
INSERT INTO `log` VALUES (67, '2023-12-15 01:08:34', 1, 4, 2, 'logout', '华中师范大学');
INSERT INTO `log` VALUES (68, '2023-12-15 01:08:41', 202101, 1, 325, 'login', '华中师范大学');
INSERT INTO `log` VALUES (69, '2023-12-15 01:11:33', 202101, 1, 333, 'login', '华中师范大学');
INSERT INTO `log` VALUES (70, '2023-12-15 01:28:00', 202101, 1, 7, 'logout', '华中师范大学');
INSERT INTO `log` VALUES (71, '2023-12-15 01:28:08', 1, 4, 437, 'login', '华中师范大学');
INSERT INTO `log` VALUES (72, '2023-12-15 01:28:21', 1, 4, 0, 'logout', '华中师范大学');
INSERT INTO `log` VALUES (73, '2023-12-15 01:28:31', 202101, 1, 340, 'login', '华中师范大学');
INSERT INTO `log` VALUES (74, '2023-12-15 01:29:10', 202101, 1, 0, 'logout', '华中师范大学');
INSERT INTO `log` VALUES (75, '2023-12-15 01:29:15', 1, 4, 359, 'login', '华中师范大学');
INSERT INTO `log` VALUES (76, '2023-12-15 01:46:41', 1, 4, 8, 'logout', '华中师范大学');
INSERT INTO `log` VALUES (77, '2023-12-15 01:46:54', 202104, 1, 450, 'login', '华中师范大学');
INSERT INTO `log` VALUES (78, '2023-12-15 01:47:33', 202104, 1, 1, 'logout', '华中师范大学');
INSERT INTO `log` VALUES (79, '2023-12-15 01:47:39', 1, 4, 340, 'login', '华中师范大学');
INSERT INTO `log` VALUES (80, '2023-12-15 01:54:01', 1, 4, 2, 'logout', '华中师范大学');
INSERT INTO `log` VALUES (81, '2023-12-15 01:54:10', 202101, 1, 132, 'login', '华中师范大学');
INSERT INTO `log` VALUES (82, '2023-12-15 01:54:18', 202101, 1, 1, 'logout', '华中师范大学');
INSERT INTO `log` VALUES (83, '2023-12-15 01:54:24', 2, 2, 383, 'login', '华中师范大学');
INSERT INTO `log` VALUES (84, '2023-12-15 02:00:58', 2, 2, 2, 'logout', '华中师范大学');
INSERT INTO `log` VALUES (85, '2023-12-15 02:01:03', 1, 4, 351, 'login', '华中师范大学');
INSERT INTO `log` VALUES (86, '2023-12-15 02:01:10', 1, 4, 2, 'logout', '华中师范大学');
INSERT INTO `log` VALUES (87, '2023-12-15 02:01:18', 2, 2, 348, 'login', '华中师范大学');
INSERT INTO `log` VALUES (88, '2023-12-15 02:13:02', 2, 2, 8, 'logout', '华中师范大学');
INSERT INTO `log` VALUES (89, '2023-12-16 19:18:24', 1, 4, 479, 'login', '华中师范大学');
INSERT INTO `log` VALUES (90, '2023-12-16 19:18:49', 1, 4, 2, 'logout', '华中师范大学');
INSERT INTO `log` VALUES (91, '2023-12-16 19:18:55', 202101, 1, 298, 'login', '华中师范大学');
INSERT INTO `log` VALUES (92, '2023-12-16 20:06:21', 202101, 1, 0, 'logout', '华中师范大学');
INSERT INTO `log` VALUES (93, '2023-12-16 20:06:29', 1, 4, 319, 'login', '华中师范大学');
INSERT INTO `log` VALUES (94, '2023-12-16 20:51:50', 1, 4, 0, 'logout', '华中师范大学');
INSERT INTO `log` VALUES (95, '2023-12-16 20:51:57', 202101, 1, 375, 'login', '华中师范大学');
INSERT INTO `log` VALUES (96, '2023-12-16 20:52:22', 202101, 1, 0, 'logout', '华中师范大学');
INSERT INTO `log` VALUES (97, '2023-12-16 20:52:28', 1, 4, 337, 'login', '华中师范大学');
INSERT INTO `log` VALUES (98, '2023-12-16 23:46:13', 1, 4, 0, 'logout', '华中师范大学');
INSERT INTO `log` VALUES (99, '2023-12-16 23:46:17', 1, 4, 97, 'login', '华中师范大学');
INSERT INTO `log` VALUES (100, '2023-12-17 00:40:00', 1, 4, 0, 'logout', '华中师范大学');
INSERT INTO `log` VALUES (101, '2023-12-17 00:40:08', 202101, 1, 94, 'login', '华中师范大学');
INSERT INTO `log` VALUES (102, '2023-12-17 00:40:28', 202101, 1, 0, 'logout', '华中师范大学');
INSERT INTO `log` VALUES (103, '2023-12-17 00:40:32', 1, 4, 361, 'login', '华中师范大学');
INSERT INTO `log` VALUES (104, '2023-12-17 01:15:27', 1, 4, 0, 'logout', '华中师范大学');
INSERT INTO `log` VALUES (105, '2023-12-17 01:15:33', 202101, 1, 298, 'login', '华中师范大学');
INSERT INTO `log` VALUES (106, '2023-12-17 11:30:15', 202101, 1, 0, 'logout', '华中师范大学');
INSERT INTO `log` VALUES (107, '2023-12-17 11:30:49', 1, 4, 486, 'login', '华中师范大学');
INSERT INTO `log` VALUES (108, '2023-12-17 11:31:29', 1, 4, 323, 'login', '华中师范大学');
INSERT INTO `log` VALUES (109, '2023-12-17 11:33:13', 1, 4, 0, 'logout', '华中师范大学');
INSERT INTO `log` VALUES (110, '2023-12-17 11:33:19', 202101, 1, 326, 'login', '华中师范大学');
INSERT INTO `log` VALUES (111, '2023-12-17 11:33:27', 202101, 1, 0, 'logout', '华中师范大学');
INSERT INTO `log` VALUES (112, '2023-12-17 11:33:33', 1, 4, 264, 'login', '华中师范大学');
INSERT INTO `log` VALUES (113, '2023-12-17 11:33:45', 1, 4, 0, 'logout', '华中师范大学');
INSERT INTO `log` VALUES (114, '2023-12-17 11:33:57', 202101, 1, 325, 'login', '华中师范大学');
INSERT INTO `log` VALUES (115, '2023-12-17 12:10:33', 1, 4, 298, 'login', '华中师范大学');
INSERT INTO `log` VALUES (116, '2023-12-17 12:10:45', 202101, 1, 98, 'login', '华中师范大学');
INSERT INTO `log` VALUES (117, '2023-12-17 12:12:05', 1, 4, 340, 'login', '华中师范大学');
INSERT INTO `log` VALUES (118, '2023-12-17 12:12:11', 1, 4, 2, 'logout', '华中师范大学');
INSERT INTO `log` VALUES (119, '2023-12-17 12:12:16', 202101, 1, 346, 'login', '华中师范大学');
INSERT INTO `log` VALUES (120, '2023-12-17 12:13:25', 2, 2, 317, 'login', '华中师范大学');
INSERT INTO `log` VALUES (121, '2023-12-17 12:13:31', 2, 2, 0, 'logout', '华中师范大学');
INSERT INTO `log` VALUES (122, '2023-12-17 12:26:18', 2, 2, 84, 'login', '华中师范大学');
INSERT INTO `log` VALUES (123, '2023-12-17 12:36:00', 2, 2, 430, 'login', '华中师范大学');
INSERT INTO `log` VALUES (124, '2023-12-17 12:40:10', 2, 2, 7, 'logout', '华中师范大学');
INSERT INTO `log` VALUES (125, '2023-12-17 12:40:15', 1, 4, 315, 'login', '华中师范大学');
INSERT INTO `log` VALUES (126, '2023-12-17 13:31:44', 1, 4, 1255, 'login', '华中师范大学');
INSERT INTO `log` VALUES (127, '2023-12-17 14:23:05', 1, 4, 809, 'login', '华中师范大学');
INSERT INTO `log` VALUES (128, '2023-12-17 15:09:39', 1, 4, 15, 'logout', '华中师范大学');
INSERT INTO `log` VALUES (129, '2023-12-17 15:09:46', 202109, 1, 97, 'login', '华中师范大学');
INSERT INTO `log` VALUES (130, '2023-12-17 15:09:48', 202109, 1, 2, 'logout', '华中师范大学');
INSERT INTO `log` VALUES (131, '2023-12-17 15:09:58', 1, 4, 333, 'login', '华中师范大学');
INSERT INTO `log` VALUES (132, '2023-12-17 15:10:43', 1, 4, 303, 'login', '华中师范大学');
INSERT INTO `log` VALUES (133, '2023-12-17 15:13:58', 1, 4, 385, 'login', '华中师范大学');
INSERT INTO `log` VALUES (134, '2023-12-17 15:50:10', 1, 4, 431, 'login', '华中师范大学');
INSERT INTO `log` VALUES (135, '2023-12-17 16:12:26', 2, 2, 363, 'login', '华中师范大学');
INSERT INTO `log` VALUES (136, '2023-12-17 16:12:55', 202101, 1, 239, 'login', '华中师范大学');
INSERT INTO `log` VALUES (137, '2023-12-17 18:17:09', 202101, 1, 1, 'logout', '华中师范大学');
INSERT INTO `log` VALUES (138, '2023-12-17 18:17:33', 202101, 1, 206, 'login', '华中师范大学');
INSERT INTO `log` VALUES (139, '2023-12-17 18:18:25', 202101, 1, 1, 'logout', '华中师范大学');
INSERT INTO `log` VALUES (140, '2023-12-17 18:18:43', 202101, 1, 170, 'login', '华中师范大学');
INSERT INTO `log` VALUES (141, '2023-12-17 18:19:18', 202101, 1, 1, 'logout', '华中师范大学');
INSERT INTO `log` VALUES (142, '2023-12-17 18:19:38', 202101, 1, 213, 'login', '华中师范大学');
INSERT INTO `log` VALUES (143, '2023-12-17 18:20:29', 202101, 1, 1, 'logout', '华中师范大学');
INSERT INTO `log` VALUES (144, '2023-12-17 18:24:47', 1, 4, 1, 'logout', '华中师范大学');
INSERT INTO `log` VALUES (145, '2023-12-17 18:24:52', 1, 4, 235, 'login', '华中师范大学');
INSERT INTO `log` VALUES (146, '2023-12-17 18:32:08', 202101, 1, 275, 'login', '华中师范大学');
INSERT INTO `log` VALUES (147, '2023-12-17 18:33:49', 202101, 1, 178, 'login', '华中师范大学');
INSERT INTO `log` VALUES (148, '2023-12-17 18:36:48', 202101, 1, 1, 'logout', '华中师范大学');
INSERT INTO `log` VALUES (149, '2023-12-17 18:37:08', 202101, 1, 204, 'login', '华中师范大学');
INSERT INTO `log` VALUES (150, '2023-12-17 19:35:52', 202101, 1, 5, 'logout', '华中师范大学');
INSERT INTO `log` VALUES (151, '2023-12-17 19:36:26', 202101, 1, 130, 'login', '华中师范大学');
INSERT INTO `log` VALUES (152, '2023-12-17 19:36:50', 202101, 1, 2, 'logout', '华中师范大学');
INSERT INTO `log` VALUES (153, '2023-12-17 19:36:57', 202102, 1, 109, 'login', '华中师范大学');
INSERT INTO `log` VALUES (154, '2023-12-17 19:37:10', 202102, 1, 2, 'logout', '华中师范大学');
INSERT INTO `log` VALUES (155, '2023-12-17 19:37:16', 202105, 1, 152, 'login', '华中师范大学');
INSERT INTO `log` VALUES (156, '2023-12-17 19:37:57', 202105, 1, 1, 'logout', '华中师范大学');
INSERT INTO `log` VALUES (157, '2023-12-17 19:38:04', 202101, 1, 216, 'login', '华中师范大学');
INSERT INTO `log` VALUES (158, '2023-12-17 19:39:27', 202101, 1, 1, 'logout', '华中师范大学');
INSERT INTO `log` VALUES (159, '2023-12-17 19:39:34', 202101, 1, 109, 'login', '华中师范大学');
INSERT INTO `log` VALUES (160, '2023-12-17 19:53:32', 202101, 1, 12, 'logout', '华中师范大学');
INSERT INTO `log` VALUES (161, '2023-12-17 19:53:52', 202101, 1, 437, 'login', '华中师范大学');
INSERT INTO `log` VALUES (162, '2023-12-17 19:57:05', 202101, 1, 144, 'login', '华中师范大学');
INSERT INTO `log` VALUES (163, '2023-12-17 20:16:50', 202101, 1, 9, 'logout', '华中师范大学');
INSERT INTO `log` VALUES (164, '2023-12-17 20:16:57', 202101, 1, 207, 'login', '华中师范大学');
INSERT INTO `log` VALUES (165, '2023-12-17 20:17:09', 202101, 1, 1, 'logout', '华中师范大学');
INSERT INTO `log` VALUES (166, '2023-12-17 20:17:15', 202102, 1, 104, 'login', '华中师范大学');
INSERT INTO `log` VALUES (167, '2023-12-17 20:17:23', 202102, 1, 2, 'logout', '华中师范大学');
INSERT INTO `log` VALUES (168, '2023-12-17 20:17:29', 202103, 1, 75, 'login', '华中师范大学');
INSERT INTO `log` VALUES (169, '2023-12-17 20:17:37', 202103, 1, 3, 'logout', '华中师范大学');
INSERT INTO `log` VALUES (170, '2023-12-17 20:17:42', 202104, 1, 117, 'login', '华中师范大学');
INSERT INTO `log` VALUES (171, '2023-12-17 20:17:55', 202104, 1, 2, 'logout', '华中师范大学');
INSERT INTO `log` VALUES (172, '2023-12-17 20:20:25', 202101, 1, 211, 'login', '华中师范大学');
INSERT INTO `log` VALUES (173, '2023-12-17 20:23:58', 202101, 1, 4, 'logout', '华中师范大学');
INSERT INTO `log` VALUES (174, '2023-12-17 20:24:28', 202101, 1, 161, 'login', '华中师范大学');
INSERT INTO `log` VALUES (175, '2023-12-17 20:25:23', 202101, 1, 176, 'login', '华中师范大学');
INSERT INTO `log` VALUES (176, '2023-12-17 20:26:16', 202101, 1, 0, 'logout', '华中师范大学');
INSERT INTO `log` VALUES (177, '2023-12-17 20:26:32', 202101, 1, 232, 'login', '华中师范大学');
INSERT INTO `log` VALUES (178, '2023-12-17 20:29:35', 202101, 1, 229, 'login', '华中师范大学');
INSERT INTO `log` VALUES (179, '2023-12-17 20:38:43', 202101, 1, 1, 'logout', '华中师范大学');
INSERT INTO `log` VALUES (180, '2023-12-17 20:39:02', 202101, 1, 91, 'login', '华中师范大学');
INSERT INTO `log` VALUES (181, '2023-12-17 20:39:40', 202101, 1, 1, 'logout', '华中师范大学');
INSERT INTO `log` VALUES (182, '2023-12-17 20:40:05', 202101, 1, 258, 'login', '华中师范大学');
INSERT INTO `log` VALUES (183, '2023-12-17 20:42:58', 202101, 1, 304, 'login', '华中师范大学');
INSERT INTO `log` VALUES (184, '2023-12-17 20:46:41', 202101, 1, 0, 'logout', '华中师范大学');
INSERT INTO `log` VALUES (185, '2023-12-17 20:46:55', 202101, 1, 226, 'login', '华中师范大学');
INSERT INTO `log` VALUES (186, '2023-12-17 20:48:07', 202101, 1, 142, 'login', '华中师范大学');
INSERT INTO `log` VALUES (187, '2023-12-17 20:52:47', 202101, 1, 1, 'logout', '华中师范大学');
INSERT INTO `log` VALUES (188, '2023-12-17 20:53:04', 202101, 1, 238, 'login', '华中师范大学');
INSERT INTO `log` VALUES (189, '2023-12-17 20:54:09', 202101, 1, 363, 'login', '华中师范大学');
INSERT INTO `log` VALUES (190, '2023-12-17 20:59:15', 202101, 1, 2, 'logout', '华中师范大学');
INSERT INTO `log` VALUES (191, '2023-12-17 20:59:28', 202101, 1, 214, 'login', '华中师范大学');
INSERT INTO `log` VALUES (192, '2023-12-17 21:00:35', 202101, 1, 157, 'login', '华中师范大学');
INSERT INTO `log` VALUES (193, '2023-12-17 21:13:55', 202101, 1, 3, 'logout', '华中师范大学');
INSERT INTO `log` VALUES (194, '2023-12-17 21:14:03', 202101, 1, 364, 'login', '华中师范大学');
INSERT INTO `log` VALUES (195, '2023-12-17 21:15:16', 202101, 1, 0, 'logout', '华中师范大学');
INSERT INTO `log` VALUES (196, '2023-12-17 21:15:33', 202101, 1, 167, 'login', '华中师范大学');
INSERT INTO `log` VALUES (197, '2023-12-17 21:16:30', 202101, 1, 288, 'login', '华中师范大学');
INSERT INTO `log` VALUES (198, '2023-12-17 21:28:27', 202101, 1, 1, 'logout', '华中师范大学');
INSERT INTO `log` VALUES (199, '2023-12-17 21:28:48', 202101, 1, 83, 'login', '华中师范大学');
INSERT INTO `log` VALUES (200, '2023-12-17 21:29:10', 202101, 1, 1, 'logout', '华中师范大学');
INSERT INTO `log` VALUES (201, '2023-12-17 21:30:13', 202101, 1, 225, 'login', '华中师范大学');
INSERT INTO `log` VALUES (202, '2023-12-17 21:30:22', 202101, 1, 1, 'logout', '华中师范大学');
INSERT INTO `log` VALUES (203, '2023-12-17 21:30:47', 202101, 1, 347, 'login', '华中师范大学');
INSERT INTO `log` VALUES (204, '2023-12-17 21:30:53', 202101, 1, 0, 'logout', '华中师范大学');
INSERT INTO `log` VALUES (205, '2023-12-17 21:31:08', 202101, 1, 164, 'login', '华中师范大学');
INSERT INTO `log` VALUES (206, '2023-12-17 21:31:45', 202101, 1, 1, 'logout', '华中师范大学');
INSERT INTO `log` VALUES (207, '2023-12-17 21:32:01', 202101, 1, 77, 'login', '华中师范大学');
INSERT INTO `log` VALUES (208, '2023-12-17 21:33:06', 202101, 1, 138, 'login', '华中师范大学');

-- ----------------------------
-- Table structure for selection
-- ----------------------------
DROP TABLE IF EXISTS `selection`;
CREATE TABLE `selection`  (
  `stu_id` int(0) NOT NULL,
  `course_id` int(0) NOT NULL,
  `score` int(0) NULL DEFAULT NULL,
  `year` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '2021-2022' COMMENT '学年',
  `trimesters` int(0) NOT NULL DEFAULT 1 COMMENT '学期',
  `university` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `ordinary` int(0) NULL DEFAULT NULL COMMENT '平时成绩',
  `ending` int(0) NULL DEFAULT NULL COMMENT '期末成绩',
  `status` int(0) NOT NULL DEFAULT 0,
  PRIMARY KEY (`stu_id`, `course_id`) USING BTREE,
  INDEX `course_id`(`course_id`) USING BTREE,
  CONSTRAINT `course_id` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `stu_id` FOREIGN KEY (`stu_id`) REFERENCES `student` (`stu_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of selection
-- ----------------------------
INSERT INTO `selection` VALUES (202101, 2, 80, '2021-2022', 1, '华中师范大学', 80, 80, 1);
INSERT INTO `selection` VALUES (202101, 3, NULL, '2021-2022', 1, '华中师范大学', NULL, NULL, 0);
INSERT INTO `selection` VALUES (202102, 2, 70, '2021-2022', 1, '华中师范大学', 80, 70, 1);
INSERT INTO `selection` VALUES (202103, 2, 60, '2021-2022', 1, '华中师范大学', 60, 60, 1);
INSERT INTO `selection` VALUES (202104, 2, 80, '2021-2022', 1, '华中师范大学', 80, 80, 1);
INSERT INTO `selection` VALUES (202105, 2, 0, '2020-2021', 1, '华中师范大学', 0, 0, 1);
INSERT INTO `selection` VALUES (202106, 2, 50, '2020-2021', 1, '华中师范大学', 50, 50, 1);
INSERT INTO `selection` VALUES (202107, 2, 80, '2020-2021', 1, '华中师范大学', 80, 80, 1);
INSERT INTO `selection` VALUES (202108, 2, 100, '2019-2020', 1, '华中师范大学', 100, 100, 1);
INSERT INTO `selection` VALUES (202109, 2, 50, '2019-2020', 1, '华中师范大学', 60, 50, 1);

-- ----------------------------
-- Table structure for student
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student`  (
  `stu_id` int(0) NOT NULL,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `major` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '专业',
  `college` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '学院',
  `university` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '学校',
  `class` int(0) NULL DEFAULT NULL,
  `password` varchar(63) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '$2a$10$wIqaJ.Ea6KDoS13y32OVL.koo6wI/CO93X6QkzmlCaV9ySf.2eerO',
  `grand` int(0) NULL DEFAULT NULL,
  PRIMARY KEY (`stu_id`, `university`) USING BTREE,
  INDEX `stu_id`(`stu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of student
-- ----------------------------
INSERT INTO `student` VALUES (202101, '学生1', '计算机科学与技术', '计算机学院', '华中师范大学', 2104, '$2a$10$BoYxi4I9QquDkHqoxbaxYebPD6Lohe2FSvf4wNI7t1RvYgOSiMtda', 2021);
INSERT INTO `student` VALUES (202102, '学生2', '计算机科学与技术', '计算机学院', '华中师范大学', 2104, '$2a$10$rM/zd7Ko9oHSuKY/zSTL8OLbO6RXKXVPLVNPEM21eY0kWN4Xfe8eu', 2021);
INSERT INTO `student` VALUES (202103, '学生3', '软件工程', '计算机学院', '华中师范大学', 2104, '$2a$10$OaQdxNa42UpSEnuKAEgct.Z/IELfBCsi10ydOOt/JYLO3McR7Sf4e', 2021);
INSERT INTO `student` VALUES (202104, '学生4', '信息安全', '计算机学院', '华中师范大学', 2103, '$2a$10$h.Z4UAjuKd0OrNUU3BDYRuvgMUPp.uKJQGxsou89RPKehhjuTd/MG', 2021);
INSERT INTO `student` VALUES (202105, '学生5', '软件工程', '计算机学院', '华中师范大学', 2101, '$2a$10$Nh8f2ASB4ffj8zJ5lHSIJu9Cv41MmeeyL24tkg8bnFy.FW5oINKlu', 2021);
INSERT INTO `student` VALUES (202106, '学生6', '物联网工程', '计算机学院', '华中师范大学', 2106, '$2a$10$oU.IUpL6ury9rthAU6VprOB1qWst070gWh8xQyAw.uQCTqWkSuTE.', 2021);
INSERT INTO `student` VALUES (202107, '学生7', '软件工程', '计算机学院', '华中师范大学', 2103, '$2a$10$wIqaJ.Ea6KDoS13y32OVL.koo6wI/CO93X6QkzmlCaV9ySf.2eerO', 2021);
INSERT INTO `student` VALUES (202108, '学生8', '物联网工程', '计算机学院', '华中师范大学', 2201, '$2a$10$wIqaJ.Ea6KDoS13y32OVL.koo6wI/CO93X6QkzmlCaV9ySf.2eerO', 22);
INSERT INTO `student` VALUES (202109, '学生9', '软件工程', '计算机学院', '华中师范大学', 2202, '$2a$10$wIqaJ.Ea6KDoS13y32OVL.koo6wI/CO93X6QkzmlCaV9ySf.2eerO', 22);

-- ----------------------------
-- Table structure for teacher
-- ----------------------------
DROP TABLE IF EXISTS `teacher`;
CREATE TABLE `teacher`  (
  `staff_id` int(0) NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `class` int(0) NULL DEFAULT NULL COMMENT '管理的班级号',
  `permission` int(0) NOT NULL COMMENT '权限 1为教师 2为教秘 4为班主任 3为辅导员 5为管理员',
  `password` varchar(63) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '$2a$10$.BOadyrJ3GxS/03bQXO7demaUGw/tEQSNOh6y7PEzbmt6vYiAdOge',
  `university` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `college` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`staff_id`, `university`) USING BTREE,
  INDEX `staff_id`(`staff_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of teacher
-- ----------------------------
INSERT INTO `teacher` VALUES (1, 'admin', NULL, 5, '$2a$10$.BOadyrJ3GxS/03bQXO7demaUGw/tEQSNOh6y7PEzbmt6vYiAdOge', '华中师范大学', '计算机学院');
INSERT INTO `teacher` VALUES (2, '班主任', 2104, 4, '$2a$10$qvI64sRjwfrxvDVf6RYQxuU5lh2cFz4Y4XSset8YSSp0fFVj.BckC', '华中师范大学', '计算机学院');
INSERT INTO `teacher` VALUES (3, '老师', NULL, 1, '$2a$10$.BOadyrJ3GxS/03bQXO7demaUGw/tEQSNOh6y7PEzbmt6vYiAdOge', '华中师范大学', '计算机学院');
INSERT INTO `teacher` VALUES (4, '教秘', 21, 2, '$2a$10$.BOadyrJ3GxS/03bQXO7demaUGw/tEQSNOh6y7PEzbmt6vYiAdOge', '华中师范大学', '计算机学院');
INSERT INTO `teacher` VALUES (5, '辅导员', 21, 3, '$2a$10$.BOadyrJ3GxS/03bQXO7demaUGw/tEQSNOh6y7PEzbmt6vYiAdOge', '华中师范大学', '计算机学院');
INSERT INTO `teacher` VALUES (6, '老师2', NULL, 1, '$2a$10$.BOadyrJ3GxS/03bQXO7demaUGw/tEQSNOh6y7PEzbmt6vYiAdOge', '华中师范大学', '信息管理学院');
INSERT INTO `teacher` VALUES (7, '老师3', NULL, 1, '$2a$10$.BOadyrJ3GxS/03bQXO7demaUGw/tEQSNOh6y7PEzbmt6vYiAdOge', '华中师范大学', '数学与统计学学院');
INSERT INTO `teacher` VALUES (8, '老师4', NULL, 1, '$2a$10$.BOadyrJ3GxS/03bQXO7demaUGw/tEQSNOh6y7PEzbmt6vYiAdOge', '华中师范大学', '体育学院');
INSERT INTO `teacher` VALUES (9, '老师5', NULL, 1, '$2a$10$.BOadyrJ3GxS/03bQXO7demaUGw/tEQSNOh6y7PEzbmt6vYiAdOge', '华中师范大学', '马克思主义学院');
INSERT INTO `teacher` VALUES (10, '老师6', NULL, 1, '$2a$10$.BOadyrJ3GxS/03bQXO7demaUGw/tEQSNOh6y7PEzbmt6vYiAdOge', '华中师范大学', '化学学院');
INSERT INTO `teacher` VALUES (11, '老师7', NULL, 1, '$2a$10$.BOadyrJ3GxS/03bQXO7demaUGw/tEQSNOh6y7PEzbmt6vYiAdOge', '华中师范大学', '物理学院');
INSERT INTO `teacher` VALUES (12, '老师8', NULL, 1, '$2a$10$.BOadyrJ3GxS/03bQXO7demaUGw/tEQSNOh6y7PEzbmt6vYiAdOge', '华中师范大学', '外国语学院');
INSERT INTO `teacher` VALUES (13, '老师9', NULL, 1, '$2a$10$.BOadyrJ3GxS/03bQXO7demaUGw/tEQSNOh6y7PEzbmt6vYiAdOge', '华中师范大学', '计算机学院');
INSERT INTO `teacher` VALUES (14, '老师10', NULL, 1, '$2a$10$.BOadyrJ3GxS/03bQXO7demaUGw/tEQSNOh6y7PEzbmt6vYiAdOge', '华中师范大学', '计算机学院');
INSERT INTO `teacher` VALUES (15, '老师11', NULL, 1, '$2a$10$.BOadyrJ3GxS/03bQXO7demaUGw/tEQSNOh6y7PEzbmt6vYiAdOge', '华中师范大学', '计算机学院');
INSERT INTO `teacher` VALUES (16, '老师12', NULL, 1, '$2a$10$.BOadyrJ3GxS/03bQXO7demaUGw/tEQSNOh6y7PEzbmt6vYiAdOge', '华中师范大学', '计算机学院');
INSERT INTO `teacher` VALUES (17, '老师13', NULL, 1, '$2a$10$.BOadyrJ3GxS/03bQXO7demaUGw/tEQSNOh6y7PEzbmt6vYiAdOge', '华中师范大学', '计算机学院');
INSERT INTO `teacher` VALUES (18, '老师14', NULL, 1, '$2a$10$bMvWJa0hzT3WOmB2I2Fc7udDagjTqq8hDi2tV3un6BV2EV.LVrcxu', '华中师范大学', '物理学院');

SET FOREIGN_KEY_CHECKS = 1;
