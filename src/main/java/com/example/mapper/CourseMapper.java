package com.example.mapper;

import com.example.pojo.Course;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface CourseMapper {

    /**
     * 分页查询课表信息
     * @param courseName 课程名称
     * @param teacherIds 课程老师id列表
     * @param time 1为早八 2为早十 3为下二 4为下四
     * @param date 周一到周五
     * @param type 必修课，选修课
     * @param university 学校
     * @param college 学院
     * @return 课程列表信息
     */
    List<Course> pageList(String courseName, List<Integer> teacherIds, Integer time, Integer date, String type,
                          String university, String college);

    /**
     * 导入课程（教秘的功能）
     * @param course 课程信息
     */
    @Insert("insert into course(course_id, course_name, teacher_id, classroom, time, date, type, description, state, university, college)" +
            "values(#{courseId},#{courseName},#{teacherId},#{classroom},#{time},#{date},#{type},#{description},#{state},#{university},#{college})")
    void addCourse(Course course);

    @Select("select * from course where course_id=#{courseId} and university=#{university}")
    Course findCourseById(Integer courseId, String university);
}