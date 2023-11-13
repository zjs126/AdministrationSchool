package com.example.controller;

import com.example.pojo.Course;
import com.example.pojo.PageBean;
import com.example.pojo.Result;
import com.example.service.CourseService;
import com.example.service.TeacherService;
import com.example.utils.ThreadLocalUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@Slf4j
@RequestMapping("/course")
public class CourseController {

    @Autowired
    private CourseService courseService;
    @Autowired
    private TeacherService teacherService;

    /**
     * 分页查询课表信息
     * @param courseName 课程名称
     * @param teacherName 课程老师名称
     * @param time 1为早八 2为早十 3为下二 4为下四
     * @param date 周一到周五
     * @param type 必修课，选修课
     * @return 课程列表信息
     */
    @GetMapping
    public Result<PageBean> getCoursePage(@RequestParam(defaultValue = "1") Integer page,
                                          @RequestParam(defaultValue = "10") Integer pageSize,
                                          String courseName, String teacherName, Integer time,
                                          Integer date, String type, String college){
        log.info("课表分页查询，参数：{}，{}，{}，{}，{}，{}，{}, {}", page, pageSize, courseName, teacherName, time, date, type, college);
        Map<String, Object> map = ThreadLocalUtil.get();
        String university = (String) map.get("university");

        //根据teacherName模糊匹配老师的id列表
        List<Integer> teacherIds = null;
        if (teacherName != null){
            teacherIds = teacherService.findTeacherByNameIds(teacherName, university);
        }
        PageBean pageBean = courseService.page(page, pageSize, courseName, teacherIds, time, date, type, university, college);
        return Result.success(pageBean);
    }

    /**
     * 导入课程（教秘的功能）
     * @param course 课程信息
     */
    @PostMapping
    public Result addCourse(@RequestBody Course course){
        log.info("导入课程：{}", course);
        Map<String, Object> map = ThreadLocalUtil.get();
        course.setUniversity((String) map.get("university"));
        //课表信息是否已存在
        Course cou = courseService.findCourseById(course.getCourseId(), course.getUniversity());
        if (cou == null){
            courseService.addCourse(course);
        } else{
            return Result.error(401, "课程信息已存在");
        }
        return Result.success();
    }

}
