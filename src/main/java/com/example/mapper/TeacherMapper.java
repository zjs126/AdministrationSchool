package com.example.mapper;

import com.example.pojo.Teacher;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

@Mapper
public interface TeacherMapper {
    /**
     * 根据staffId查询教职工信息
     * @param staffId 教职工编号
     * @return 教职工信息
     */
    @Select("select * from teacher where staff_id=#{staffId}")
    Teacher findTeacherById(Integer staffId);

    /**
     * 更新教职工账号密码
     * @param staffId 教职工编号
     * @param password 更新的密码
     */
    @Update("update teacher set password=#{password} where staff_id=#{staffId}")
    void updatePassword(Integer staffId, String password);

    /**
     * 更新教职工信息
     * @param teacher 更新的教职工信息
     */
    void update(Teacher teacher);
}
