/*
 Navicat Premium Data Transfer

 Source Server         : mybatis
 Source Server Type    : MySQL
 Source Server Version : 80031
 Source Host           : localhost:3306
 Source Schema         : administration

 Target Server Type    : MySQL
 Target Server Version : 80031
 File Encoding         : 65001

 Date: 12/12/2023 09:03:59
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
                         `state` int(0) NULL DEFAULT NULL COMMENT '1为开设',
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
                          `password` varchar(63) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '123456',
                          `grand` int(0) NULL DEFAULT NULL,
                          PRIMARY KEY (`stu_id`, `university`) USING BTREE,
                          INDEX `stu_id`(`stu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for teacher
-- ----------------------------
DROP TABLE IF EXISTS `teacher`;
CREATE TABLE `teacher`  (
                          `staff_id` int(0) NOT NULL,
                          `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
                          `class` int(0) NULL DEFAULT NULL COMMENT '管理的班级号',
                          `permission` int(0) NOT NULL COMMENT '权限 1为教师 2为教秘 4为班主任 3为辅导员 5为管理员',
                          `password` varchar(63) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '123456',
                          `university` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
                          `college` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
                          PRIMARY KEY (`staff_id`, `university`) USING BTREE,
                          INDEX `staff_id`(`staff_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
