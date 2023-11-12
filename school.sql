CREATE TABLE `student` (
`stu_id` int(11) NOT NULL,
`name` varchar(50) NOT NULL,
`major` varchar(50) NOT NULL COMMENT '专业',
`college` varchar(50) NOT NULL COMMENT '学院',
`university` varchar(50) NOT NULL COMMENT '学校',
`class` int(5) NULL,
`password` varchar(20) NOT NULL DEFAULT 123456,
`grand` int(4) NULL,
PRIMARY KEY (`stu_id`, `university`) 
);
CREATE TABLE `course` (
`course_id` int(11) NOT NULL,
`course_name` varchar(255) NOT NULL,
`teacher_id` int(11) NOT NULL,
`classroom` int(5) NULL,
`time` int(2) NOT NULL COMMENT '1为早八 2为早十 3为下二 4为下四',
`date` int(2) NOT NULL COMMENT '周一到周五',
`type` varchar(50) NOT NULL,
`description` varchar(255) NULL,
`state` int(2) NULL COMMENT '1为开设',
`university` varchar(50) NOT NULL,
`college` varchar(50) NOT NULL,
PRIMARY KEY (`course_id`, `university`) 
);
CREATE TABLE `teacher` (
`staff_id` int(11) NOT NULL,
`name` varchar(255) NOT NULL,
`class` int(5) NULL COMMENT '管理的班级号',
`permission` int(2) NOT NULL COMMENT '权限 1为教师 2为教秘 3为任课老师 4为班主任 5为辅导员 6为管理员',
`password` int(11) NOT NULL DEFAULT 123456,
`university` varchar(50) NOT NULL,
`college` varchar(50) NOT NULL,
PRIMARY KEY (`staff_id`, `university`) 
);
CREATE TABLE `selection` (
`stu_id` int(11) NOT NULL,
`course_id` int(11) NOT NULL,
`score` int(3) NULL,
`year` int(4) NOT NULL COMMENT '学年',
`trimesters` int(2) NOT NULL COMMENT '学期',
`university` varchar(50) NOT NULL,
PRIMARY KEY (`stu_id`, `course_id`) 
);
CREATE TABLE `classroom` (
`classroom` int(5) NOT NULL,
`type` varchar(50) NOT NULL COMMENT '教室类型',
`situation` varchar(50) NULL,
`university` varchar(50) NOT NULL,
PRIMARY KEY (`classroom`, `university`) 
);
CREATE TABLE `apply` (
`stu_id` int(11) NOT NULL,
`course_id` int(11) NOT NULL,
`situation` int(1) NULL COMMENT '1为批准0为不批准',
`administrator` int NULL COMMENT '审核人id',
`reason` varchar(255) NULL,
`university` varchar(50) NOT NULL,
`year` int(4) NOT NULL,
`trimesters` int(2) NOT NULL,
`create_time` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
`update_time` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
PRIMARY KEY (`stu_id`, `course_id`) ,
INDEX `stu_id1` (`stu_id` ASC)
);

ALTER TABLE `selection` ADD CONSTRAINT `stu_id` FOREIGN KEY (`stu_id`) REFERENCES `student` (`stu_id`) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE `selection` ADD CONSTRAINT `course_id` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE `course` ADD CONSTRAINT `classroom` FOREIGN KEY (`classroom`) REFERENCES `classroom` (`classroom`) ON DELETE SET NULL ON UPDATE CASCADE;
ALTER TABLE `course` ADD CONSTRAINT `staff_id` FOREIGN KEY (`teacher_id`) REFERENCES `teacher` (`staff_id`) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE `apply` ADD CONSTRAINT `stu_id1` FOREIGN KEY (`stu_id`) REFERENCES `student` (`stu_id`) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE `apply` ADD CONSTRAINT `course_id1` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`) ON DELETE CASCADE ON UPDATE CASCADE;

