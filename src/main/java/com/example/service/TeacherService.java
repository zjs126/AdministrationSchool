package com.example.service;

import com.example.pojo.Teacher;

import java.io.InputStream;
import java.util.List;

public interface TeacherService {
    /**
     * 通过id找教职工信息
     * @param staffId 教职工编号
     * @return 教职工信息
     */
    Teacher findTeacherByStaffId(Integer staffId, String university);

    /**
     * 更新密码
     * @param id 教职工编号
     * @param newPwd 新密码
     */
    void updatePassword(Integer id, String newPwd, String university);

    /**
     * 更新教职工信息
     * @param teacher 教职工信息
     */
    void update(Teacher teacher);

    /**
     * 根据教职工信息查询教职工id信息
     * @param teacherName 教职工姓名
     * @param university 学校
     * @return 教职工id列表
     */
    List<Integer> findTeacherByNameIds(String teacherName, String university);

    /**
     * 通过发送excel文件，批量导入学生信息
     * @param inputStream 输入流
     */
    void addByExcel(InputStream inputStream);

    /**
     * 通过发送excel文件，批量导入老师信息
     * @param inputStream
     */
    void addByExcel2(InputStream inputStream);

    /**
     * 根据id和学校获取权限
     * @param id
     * @param university
     * @return
     */
    int GetPermission(Integer id, String university);
}
