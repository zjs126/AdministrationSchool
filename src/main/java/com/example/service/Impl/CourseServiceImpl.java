package com.example.service.Impl;

import com.example.mapper.CourseMapper;
import com.example.mapper.TeacherMapper;
import com.example.pojo.Course;
import com.example.pojo.PageBean;
import com.example.service.CourseService;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CourseServiceImpl implements CourseService {

    @Autowired
    private CourseMapper courseMapper;
    @Autowired
    private TeacherMapper teacherMapper;

    @Override
    public PageBean page(Integer page, Integer pageSize, String courseName, List<Integer> teacherIds, Integer time,
                         Integer date, String type, String university, String college) {
        //设置分页参数
        PageHelper.startPage(page,pageSize);

        //执行查询
        List<Course> courseList = courseMapper.pageList(courseName, teacherIds, time, date, type, university, college);
        Page<Course> p = (Page<Course>) courseList;

        //计算总页数
        Long pageCount = p.getTotal() / pageSize + 1;

        //封装pageBean对象
        PageBean pageBean = new PageBean(p.getTotal(), p.getResult(), pageCount);
        return pageBean;
    }

    @Override
    public void addCourse(Course course) {
        courseMapper.addCourse(course);
    }

    @Override
    public Course findCourseById(Integer courseId, String university) {
        return courseMapper.findCourseById(courseId, university);
    }

    @Override
    public List<Integer> findTeacherByNameIds(String courseName, String university) {
        return courseMapper.findCourseByNameIds(courseName, university);
    }
}
