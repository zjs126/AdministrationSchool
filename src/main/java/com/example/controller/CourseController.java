package com.example.controller;

import com.example.pojo.PageBean;
import com.example.pojo.Result;
import com.example.service.CourseService;
import com.example.service.TeacherService;
import com.example.utils.ThreadLocalUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

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
                                          Integer date, String type){
        log.info("课表分页查询，参数：{}，{}，{}，{}，{}，{}，{}", page, pageSize, courseName, teacherName, time, date, type);
        Map<String, Object> map = ThreadLocalUtil.get();
        String university = (String) map.get("university");

        //根据teacherName模糊匹配老师的id列表
        List<Integer> teacherIds = null;
        if (teacherName != null){
            teacherIds = teacherService.findTeacherByNameIds(teacherName, university);
        }

        PageBean pageBean = courseService.page(page, pageSize, courseName, teacherIds, time, date, type, university);
        return Result.success(pageBean);
    }
}
