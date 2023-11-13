package com.example.service.Impl;

import com.example.mapper.StudentMapper;
import com.example.mapper.TeacherMapper;
import com.example.pojo.Student;
import com.example.pojo.Teacher;
import com.example.service.TeacherService;
import com.example.utils.BCryptPasswordUtils;
import com.example.utils.ExcelRead;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

@Service
@Slf4j
public class TeacherServiceImpl implements TeacherService {

    @Autowired
    private TeacherMapper teacherMapper;
    @Autowired
    private StudentMapper studentMapper;

    @Override
    public Teacher findTeacherByStaffId(Integer staffId, String university) {
        return teacherMapper.findTeacherById(staffId, university);
    }

    @Override
    public void updatePassword(Integer staffId, String password, String university) {
        log.info("对教职工要修改的密码进行进行哈希处理");
        String encode = BCryptPasswordUtils.encodePassword(password);
        teacherMapper.updatePassword(staffId, encode, university);
    }

    @Override
    public void update(Teacher teacher) {
        teacherMapper.update(teacher);
    }

    @Override
    public List<Integer> findTeacherByNameIds(String teacherName, String university) {
        return teacherMapper.findTeacherByNameIds(teacherName, university);
    }

    @Override
    public void addByExcel(InputStream inputStream) {
        ArrayList<Student> excel;
        //方法封装成utils
        ExcelRead excelRead=new ExcelRead();
        excel= excelRead.Read(inputStream);
        for(Student student:excel){
            studentMapper.addStudent(student);
        }
    }

    @Override
    public void addByExcel2(InputStream inputStream) {
        ArrayList<Teacher> excel;
        //方法封装成utils
        ExcelRead excelRead=new ExcelRead();
        excel= excelRead.Read2(inputStream);
        for(Teacher teacher:excel){
            teacherMapper.addTeacher(teacher);
        }
    }

    @Override
    public int GetPermission(Integer id, String university) {
        return teacherMapper.GetPermission(id,university);
    }

}
