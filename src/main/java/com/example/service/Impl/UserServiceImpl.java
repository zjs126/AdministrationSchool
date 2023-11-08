package com.example.service.Impl;

import com.example.mapper.UserMapper;
import com.example.pojo.Student;
import com.example.pojo.Teacher;
import com.example.pojo.User;
import com.example.service.UserService;
import com.example.utils.BCryptPasswordUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Objects;

@Service
@Slf4j
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userMapper;

    @Override
    public void register(Student student) {
        log.info("对密码进行进行哈希处理");
        String encode = BCryptPasswordUtils.encodePassword(student.getPassword());
        student.setPassword(encode);
        userMapper.register(student);
    }

    @Override
    public Integer login(User user) {
        String stuPassword = userMapper.loginStudent(user);
        String staffPassword = userMapper.loginTeacher(user);

        if (stuPassword == null && staffPassword == null) {
            return 0; //用户未找到
        } else {
            //用户提供的未加密密码
            String userPassword = user.getPassword();
            //数据库中存储的加密密码
            String encodePassword = Objects.requireNonNullElse(staffPassword, stuPassword);

            if (BCryptPasswordUtils.matchPassword(userPassword, encodePassword)) {
                return 1; //密码匹配
            } else {
                return 2; //密码不匹配
            }
        }
    }

    @Override
    public void registerTeacher(Teacher teacher) {
        log.info("对密码进行进行哈希处理");
        String encode = BCryptPasswordUtils.encodePassword(teacher.getPassword());
        teacher.setPassword(encode);
        userMapper.registerTeacher(teacher);
    }
}
