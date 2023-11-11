package com.example.mapper;

import com.example.pojo.Course;
import org.apache.ibatis.annotations.Mapper;

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
     * @return 课程列表信息
     */
    List<Course> pageList(String courseName, List<Integer> teacherIds, Integer time, Integer date, String type, String university);
}
