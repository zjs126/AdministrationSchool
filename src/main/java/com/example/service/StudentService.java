package com.example.service;


import com.example.pojo.Course;
import com.example.pojo.PageBean;
import com.example.pojo.SC;
import com.example.pojo.Student;

import java.util.ArrayList;

public interface StudentService {
    /**
     * 学生更新密码
     * @param stuId 学号
     * @param password 新密码
     */
    void updatePassword(Integer stuId, String password, String university);

    /**
     * 通过id找学生信息
     * @param stuId 学生id
     * @return 返回学生信息
     */
    Student findStudentByStuId(Integer stuId, String university);

    /**
     * 更新学生账号信息
     * @param student 要更新的学生信息
     */
    void update(Student student);

    /**
     * 查找选课表
     */
    ArrayList<Course> getCourses(String university);

    /**
     * 选择课，更新课表
     * @param sc 课程id
     */
    int selectCourse(SC sc);

    /**
     * 根据id返回课表
     */
    ArrayList<Course> getMyCourses(Integer id, String university);

    /**
     * 根据id退课
     */
    void deleteCourse(Integer courseID,Integer id, String university);

    /**
     * 根据id,university查询一门课的信息
     */
    Course getOneCourse(Integer id,String university);

    PageBean page(Integer page, Integer pageSize, Integer stuId, String name, String major, String college, String university, Integer className, Integer grand);
}
