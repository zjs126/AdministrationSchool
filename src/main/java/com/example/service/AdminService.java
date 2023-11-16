package com.example.service;

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
    void addClassToStu(Integer stuId, Integer courseId, String university);
}
