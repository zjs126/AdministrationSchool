package com.example.service.Impl;

import com.example.mapper.StudentMapper;
import com.example.pojo.Student;
import com.example.service.StudentService;
import com.example.utils.BCryptPasswordUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service
@Slf4j
public class StudentServiceImpl implements StudentService {

    @Autowired
    private StudentMapper studentMapper;

    @Override
    public void updatePassword(Integer stuId, String password) {
        log.info("对学生要修改的密码进行进行哈希处理");
        String encode = BCryptPasswordUtils.encodePassword(password);
        studentMapper.updatePassword(stuId, encode);
    }

    @Override
    public Student findStudentByStuId(Integer stuId) {
        return studentMapper.findStudentByStuId(stuId);
    }

    @Override
    public void update(Student student) {
        studentMapper.update(student);
    }
}
