package com.example.mapper;

import com.example.pojo.Student;
import com.example.pojo.Teacher;
import com.example.pojo.User;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface UserMapper {

    /**
     * 学生注册
     * @param student 学生信息
     */
    @Insert("insert into student(stu_id, name, major, college, university, class, password, grand) " +
            "values (#{stuId},#{name},#{major},#{college},#{university},#{className},#{password},#{grand})")
    void register(Student student);

    /**
     * 查询登录是否为学生
     * @param user 用户信息
     * @return 密码
     */
    @Select("select password from student where stu_id=#{id} and university=#{university}")
    String loginStudent(User user);

    /**
     * 查询登录是否为教职工
     * @param user 用户信息
     * @return 密码
     */
    @Select("select password from teacher where staff_id=#{id} and university=#{university}")
    String loginTeacher(User user);

    /**
     * 教职工注册
     * @param teacher 教职工信息
     */
    @Insert("insert into teacher(staff_id, name, class, permission, password, university, college) " +
            "values (#{staffId},#{name},#{className},#{permission},#{password},#{university},#{college})")
    void registerTeacher(Teacher teacher);
}