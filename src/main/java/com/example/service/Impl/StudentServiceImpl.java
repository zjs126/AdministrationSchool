package com.example.service.Impl;

import com.example.mapper.StudentMapper;
import com.example.pojo.Course;
import com.example.pojo.PageBean;
import com.example.pojo.SC;
import com.example.pojo.Student;
import com.example.service.StudentService;
import com.example.utils.BCryptPasswordUtils;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;


@Service
@Slf4j
public class StudentServiceImpl implements StudentService {

    @Autowired
    private StudentMapper studentMapper;

    @Override
    public void updatePassword(Integer stuId, String password, String university) {
        log.info("对学生要修改的密码进行进行哈希处理");
        String encode = BCryptPasswordUtils.encodePassword(password);
        studentMapper.updatePassword(stuId, encode, university);
    }

    @Override
    public Student findStudentByStuId(Integer stuId, String university) {
        return studentMapper.findStudentByStuId(stuId, university);
    }

    @Override
    public void update(Student student) {
        studentMapper.update(student);
    }

    @Override
    public ArrayList<Course> getCourses(String university) {
        return studentMapper.getCourses(university);
    }

    @Override
    public Integer selectCourse(SC sc) {
        Integer courseID = sc.getCourseID();
        Integer stuID = sc.getStuID();
        String university = sc.getUniversity();

        ArrayList<Course> hasChoosed = getMyCourses(stuID, university);
        Course thisCourse = getOneCourse(courseID, university);

        int number=studentMapper.findSelected(courseID,university);//查询选课的数量，对比课程容量
        if(number==thisCourse.getVolume()){
            return -1;
        }
        for (Course course : hasChoosed) {
            //遍历已经选的课程，对比选课时间，有冲突返回0
            if (course.getDate().equals(thisCourse.getDate()) && course.getTime().equals(thisCourse.getTime())) {
                return 0;
            }
        }
        studentMapper.selectCourse(sc);
        return 1;
    }

    @Override
    public ArrayList<Course> getMyCourses(Integer id, String university) {
        return studentMapper.getMyCourses(id, university);
    }

    @Override
    public void deleteCourse(Integer courseID, Integer id, String university) {
        studentMapper.deleteCourse(courseID, id, university);
    }

    @Override
    public Course getOneCourse(Integer id, String university) {
        return studentMapper.getOneCourse(id, university);
    }

    @Override
    public PageBean page(Integer page, Integer pageSize, Integer stuId, String name, String major, String college, String university, Integer className, Integer grand) {
        //设置分页参数
        PageHelper.startPage(page, pageSize);

        //执行查询
        List<Student> empList = studentMapper.pageList(stuId, name, major, college, university, className, grand);
        Page<Student> p = (Page<Student>) empList;

        //计算总页数
        Long pageCount = p.getTotal() / pageSize + 1;

        //封装pageBean对象
        PageBean pageBean = new PageBean(p.getTotal(), p.getResult(), pageCount);
        return pageBean;
    }
}
