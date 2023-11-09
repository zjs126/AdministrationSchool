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
    public ArrayList<Course> getCourses(String university) {
        return studentMapper.getCourses(university);
    }

    @Override
    public int selectCourse(SC sc) {
        Integer courseID=sc.getCourseID();
        Integer stuID=sc.getStuID();
        String university=sc.getUniversity();

        ArrayList<Course> hasChoosed=getMyCourses(stuID,university);
        Course thisCourse = getOneCourse(courseID,university);
        for(Course course:hasChoosed){
            //遍历已经选的课程，对比选课时间，有冲突返回0
            if(course.getDate().equals(thisCourse.getDate())&&course.getTime().equals(thisCourse.getTime())){
                return 0;
            }
        }
        studentMapper.selectCourse(sc);
        return 1;
    }

    @Override
    public ArrayList<Course> getMyCourses(Integer id, String university) {
        return studentMapper.getMyCourses(id,university);
    }

    @Override
    public void deleteCourse(Integer courseID,Integer id,String university) {
        studentMapper.deleteCourse(courseID,id,university);
    }

    @Override
    public Course getOneCourse(Integer id, String university) {
        return studentMapper.getOneCourse(id,university);
    }
}
