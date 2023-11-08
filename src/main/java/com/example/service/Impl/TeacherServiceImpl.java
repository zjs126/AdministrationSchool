package com.example.service.Impl;

import com.example.mapper.TeacherMapper;
import com.example.pojo.Teacher;
import com.example.service.TeacherService;
import com.example.utils.BCryptPasswordUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
@Slf4j
public class TeacherServiceImpl implements TeacherService {

    @Autowired
    private TeacherMapper teacherMapper;

    @Override
    public Teacher findTeacherByStaffId(Integer staffId) {
        return teacherMapper.findTeacherById(staffId);
    }

    @Override
    public void updatePassword(Integer staffId, String password) {
        log.info("对教职工要修改的密码进行进行哈希处理");
        String encode = BCryptPasswordUtils.encodePassword(password);
        teacherMapper.updatePassword(staffId, encode);
    }

    @Override
    public void update(Teacher teacher) {
        teacherMapper.update(teacher);
    }

}
