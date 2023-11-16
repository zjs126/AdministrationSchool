CREATE TABLE `apply` (
`stu_id` int NOT NULL,
`course_id` int NOT NULL,
`situation` int NULL DEFAULT NULL COMMENT '1为批准0为不批准',
`administrator` int NULL DEFAULT NULL COMMENT '审核人id',
`reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
`university` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
`year` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
`trimesters` int NOT NULL,
`create_time` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
`update_time` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
`submit` int NOT NULL,
PRIMARY KEY (`stu_id`, `course_id`) ,
INDEX `stu_id1` (`stu_id` ASC) USING BTREE,
INDEX `course_id1` (`course_id` ASC) USING BTREE
)
ENGINE = InnoDB
AUTO_INCREMENT = 0
AVG_ROW_LENGTH = 0
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
KEY_BLOCK_SIZE = 0
MAX_ROWS = 0
MIN_ROWS = 0
ROW_FORMAT = Dynamic;
CREATE TABLE `classroom` (
`classroom` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
`type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '教室类型',
`university` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
PRIMARY KEY (`classroom`, `university`) ,
INDEX `classroom` (`classroom` ASC) USING BTREE
)
ENGINE = InnoDB
AUTO_INCREMENT = 0
AVG_ROW_LENGTH = 0
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
KEY_BLOCK_SIZE = 0
MAX_ROWS = 0
MIN_ROWS = 0
ROW_FORMAT = Dynamic;
CREATE TABLE `course` (
`course_id` int NOT NULL,
`course_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
`teacher_id` int NOT NULL,
`classroom` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
`time` int NOT NULL COMMENT '1为早八 2为早十 3为下二 4为下四',
`date` int NOT NULL COMMENT '周一到周五',
`type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
`description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
`state` int NULL DEFAULT NULL COMMENT '1为开设',
`university` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
`college` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
`credit` int NOT NULL COMMENT '学分',
`volume` int NULL DEFAULT NULL COMMENT '容量',
PRIMARY KEY (`course_id`, `university`) ,
INDEX `classroom` (`classroom` ASC) USING BTREE,
INDEX `staff_id` (`teacher_id` ASC) USING BTREE,
INDEX `course_id` (`course_id` ASC) USING BTREE
)
ENGINE = InnoDB
AUTO_INCREMENT = 0
AVG_ROW_LENGTH = 0
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
KEY_BLOCK_SIZE = 0
MAX_ROWS = 0
MIN_ROWS = 0
ROW_FORMAT = Dynamic;
CREATE TABLE `selection` (
`stu_id` int NOT NULL,
`course_id` int NOT NULL,
`score` int NULL DEFAULT NULL,
`year` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '2021-2022' COMMENT '学年',
`trimesters` int NOT NULL DEFAULT 1 COMMENT '学期',
`university` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
`ordinary` int NULL DEFAULT NULL COMMENT '平时成绩',
`ending` int NULL DEFAULT NULL COMMENT '期末成绩',
`status` int NOT NULL DEFAULT 0,
PRIMARY KEY (`stu_id`, `course_id`) ,
INDEX `course_id` (`course_id` ASC) USING BTREE
)
ENGINE = InnoDB
AUTO_INCREMENT = 0
AVG_ROW_LENGTH = 0
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
KEY_BLOCK_SIZE = 0
MAX_ROWS = 0
MIN_ROWS = 0
ROW_FORMAT = Dynamic;
CREATE TABLE `student` (
`stu_id` int NOT NULL,
`name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
`major` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '专业',
`college` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '学院',
`university` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '学校',
`class` int NULL DEFAULT NULL,
`password` varchar(63) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '123456',
`grand` int NULL DEFAULT NULL,
PRIMARY KEY (`stu_id`, `university`) ,
INDEX `stu_id` (`stu_id` ASC) USING BTREE
)
ENGINE = InnoDB
AUTO_INCREMENT = 0
AVG_ROW_LENGTH = 0
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
KEY_BLOCK_SIZE = 0
MAX_ROWS = 0
MIN_ROWS = 0
ROW_FORMAT = Dynamic;
CREATE TABLE `teacher` (
`staff_id` int NOT NULL,
`name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
`class` int NULL DEFAULT NULL COMMENT '管理的班级号',
`permission` int NOT NULL COMMENT '权限 1为教师 2为教秘 3为任课老师 4为班主任 5为辅导员 6为管理员',
`password` varchar(63) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '123456',
`university` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
`college` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
PRIMARY KEY (`staff_id`, `university`) ,
INDEX `staff_id` (`staff_id` ASC) USING BTREE
)
ENGINE = InnoDB
AUTO_INCREMENT = 0
AVG_ROW_LENGTH = 0
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
KEY_BLOCK_SIZE = 0
MAX_ROWS = 0
MIN_ROWS = 0
ROW_FORMAT = Dynamic;

ALTER TABLE `apply` ADD CONSTRAINT `course_id1` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE `apply` ADD CONSTRAINT `stu_id1` FOREIGN KEY (`stu_id`) REFERENCES `student` (`stu_id`) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE `course` ADD CONSTRAINT `classroom` FOREIGN KEY (`classroom`) REFERENCES `classroom` (`classroom`) ON DELETE SET NULL ON UPDATE CASCADE;
ALTER TABLE `course` ADD CONSTRAINT `staff_id` FOREIGN KEY (`teacher_id`) REFERENCES `teacher` (`staff_id`) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE `selection` ADD CONSTRAINT `course_id` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE `selection` ADD CONSTRAINT `stu_id` FOREIGN KEY (`stu_id`) REFERENCES `student` (`stu_id`) ON DELETE CASCADE ON UPDATE CASCADE;