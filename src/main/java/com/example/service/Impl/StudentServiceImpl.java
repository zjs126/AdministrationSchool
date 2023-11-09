package com.example.service.Impl;

import com.example.mapper.StudentMapper;
import com.example.pojo.Course;
import com.example.pojo.SC;
import com.example.pojo.Student;
import com.example.service.StudentService;
import com.example.utils.BCryptPasswordUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;


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
    public ArrayList<Course> getCourses() {
        return studentMapper.getCourses();
    }

    @Override
    public void selectCourse(SC sc) {
        studentMapper.selectCourse(sc);
    }

    @Override
    public ArrayList<Course> getMyCourses(Integer id) {
        return studentMapper.getMyCourses(id);
    }

    @Override
    public void deleteCourse(Integer id) {
        studentMapper.deleteCourse(id);
    }
}
