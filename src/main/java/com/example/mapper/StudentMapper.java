package com.example.mapper;

import com.example.pojo.Course;
import com.example.pojo.SC;
import com.example.pojo.Student;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.ArrayList;

@Mapper
public interface StudentMapper {
    /**
     * 学生更新密码
     * @param stuId 学号
     * @param password 新密码
     */
    @Update("update student set password=#{password} where stu_id=#{stuId}")
    void updatePassword(Integer stuId, String password);

    /**
     * 通过id找学生信息
     * @param stuId 学号
     * @return 返回学生信息
     */
    @Select("select * from student where stu_id=#{stuId}")
    Student findStudentByStuId(Integer stuId);

    /**
     * 更新学生账号信息
     * @param student 更新的学生信息
     */
    void update(Student student);

    /**
     * 查找所有选课课程
     */
    @Select("Select * from course")
    ArrayList<Course> getCourses();

    /**
     * 向选课表中插入选择的课
     */
    @Insert("insert into selection(stu_id, course_id) values (#{stuID},#{courseID})")
    void selectCourse(SC sc);

    /**
     *从选课表中先查出选的课程id,再根据id查课程
     */
    @Select("select * from course where course_id in (select course_id from selection where stu_id=#{id})")
    ArrayList<Course> getMyCourses(Integer id);
}
