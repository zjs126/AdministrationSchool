package com.example.controller;

import com.example.pojo.Course;
import com.example.pojo.PageBean;
import com.example.pojo.Result;
import com.example.pojo.SC;
import com.example.pojo.Student;
import com.example.service.StudentService;
import com.example.utils.BCryptPasswordUtils;
import com.example.utils.RedisCache;
import com.example.utils.ThreadLocalUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.util.StringUtils;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Map;

@RestController
@Slf4j
@RequestMapping("/student")
public class StudentController {

    @Autowired
    private StudentService studentService;
    @Autowired
    private RedisCache redisCache;

    /**
     * 更新学生账号密码
     * @param params 新旧密码
     * @param token  jwt令牌
     */
    @PatchMapping("/updatePwd")
    public Result updatePassword(@RequestBody Map<String, String> params, @RequestHeader("token") String token) {
        //1. 校验参数
        String oldPwd = params.get("oldPwd");
        String rePwd = params.get("rePwd");
        String newPwd = params.get("newPwd");

        if (!StringUtils.hasLength(oldPwd) || !StringUtils.hasLength(rePwd) || !StringUtils.hasLength(newPwd)) {
            return Result.error(401, "缺少必要参数");
        }

        //原密码是否正确
        Map<String, Object> map = ThreadLocalUtil.get();
        Integer id = (Integer) map.get("id");
        String university = (String) map.get("university");
        Student student = studentService.findStudentByStuId(id, university);
        if (!BCryptPasswordUtils.matchPassword(oldPwd, student.getPassword())) {
            log.info("原密码填写错误");
            return Result.error(401, "原密码填写错误");
        }

        //newPwd和rePwd是否相同
        if (!newPwd.equals(rePwd)) {
            log.info("两次填写的密码不一样");
            return Result.error(401, "两次填写的密码不一样");
        }
        //2. 调用service完成密码更新
        studentService.updatePassword(id, newPwd, university);

        //删除redis中对应的token
        redisCache.deleteObject(token);

        return Result.success();
    }

    /**
     * 更新学生信息
     *
     * @param student 要更新的学生信息
     */
    @PutMapping("/update")
    public Result<Student> update(@RequestBody @Validated Student student) {
        log.info("学生更新信息：{}", student);
        studentService.update(student);
        return Result.success();
    }

    /**
     * 学生信息分页条件查询
     * @param page 第几页
     * @param pageSize 每页展示数量
     * @param stuId 学生学号
     * @param name 学生名字
     * @param major 专业
     * @param college 学院
     * @param className 班级
     * @param grand 年级
     * @return 学生信息列表
     */
    @GetMapping
    public Result<PageBean> page(@RequestParam(defaultValue = "1") Integer page,
                       @RequestParam(defaultValue = "10") Integer pageSize,
                       Integer stuId, String name, String major, String college,
                       Integer className, Integer grand) {
        log.info("分页查询：参数：{},{},{},{},{},{},{},{}", page, pageSize, stuId, name, major, college, className, grand);
        Map<String, Object> map = ThreadLocalUtil.get();
        String university = (String) map.get("university");
        PageBean pageBean = studentService.page(page, pageSize, stuId, name, major, college, university, className, grand);
        return Result.success(pageBean);
    }

//     使用CourseController中的方法查询课程
//    /**
//     * 获取课程信息列表
//     */
//    @GetMapping("/getCourses")
//    public Result<ArrayList<Course>> getCourses() {
//        log.info("学生获取选课列表");
//        Map<String, Object> map = ThreadLocalUtil.get();
//        String university = (String) map.get("university");
//        ArrayList<Course> courses;
//        courses = studentService.getCourses(university);
//        return Result.success(courses);
//    }

    /**
     * 选择课，更新课表
     * @param courseId 课程id
     */
    @GetMapping("/selectCourse")
    public Result selectCourse(@RequestBody Integer courseId) {
        Map<String, Object> map = ThreadLocalUtil.get();
        Integer id = (Integer) map.get("id");
        String university = (String) map.get("university");
        SC sc = new SC(id, courseId,university);
        int i=studentService.selectCourse(sc);
        if(i==0){
            return  Result.error("时间冲突");
        }
        return Result.success();
    }

    /**
     * 根据id返回课表
     */
    @GetMapping("/getMyCourses")
    public Result getMyCourses() {
        Map<String, Object> map = ThreadLocalUtil.get();
        Integer id = (Integer) map.get("id");
        String university = (String) map.get("university");
        ArrayList<Course> courses;
        courses = studentService.getMyCourses(id,university);
        return Result.success(courses);
    }

    /**
     * 退课
     * @param courseId 课程id
     */
    @DeleteMapping("/deleteCourse")
    public Result deleteCourse(@RequestBody Integer courseId) {
        Map<String, Object> map = ThreadLocalUtil.get();
        Integer id = (Integer) map.get("id");
        String university = (String) map.get("university");
        studentService.deleteCourse(courseId,id,university);
        return Result.success();
    }
}
