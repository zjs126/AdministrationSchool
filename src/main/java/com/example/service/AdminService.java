package com.example.service;

import com.example.pojo.Course;

public interface AdminService {
    /**
     * 重置分数
     * @param stuId 学号
     * @param courseId 课程编号
     * @param university 学校
     */

    void resetScore(Integer stuId, Integer courseId, String university);

    /**
     * 教秘给学生加课
     * @param stuId
     * @param courseId
     * @param university
     */

    int addClassToStu(Integer stuId, Integer courseId, String university);

    /**
     * 修改课程信息：时间 教室等
     * @param course
     */
    void resetClass(Course course);
}
