package com.example.service;

import com.example.pojo.Teacher;

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

    void update(Teacher teacher);
}
