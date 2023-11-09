package com.example.service;


import com.example.pojo.Course;
import com.example.pojo.SC;
import com.example.pojo.Student;

import java.util.ArrayList;

public interface StudentService {
    /**
     * 学生更新密码
     * @param stuId 学号
     * @param password 新密码
     */
    void updatePassword(Integer stuId, String password);

    /**
     * 通过id找学生信息
     * @param stuId 学生id
     * @return 返回学生信息
     */
    Student findStudentByStuId(Integer stuId);

    /**
     * 更新学生账号信息
     * @param student 要更新的学生信息
     */
    void update(Student student);

    /**
     * 查找选课表
     */
    ArrayList<Course> getCourses();

    /**
     * 选择课，更新课表
     * @param sc 课程id
     */
    void selectCourse(SC sc);
}
