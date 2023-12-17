package com.example.service.Impl;

import com.example.mapper.CourseMapper;
import com.example.mapper.SelectionMapper;
import com.example.mapper.StudentMapper;
import com.example.pojo.*;
import com.example.pojo.Vo.AuditApply;
import com.example.service.SelectionService;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class SelectionServiceImpl implements SelectionService {

    @Autowired
    private SelectionMapper selectionMapper;
    @Autowired
    private CourseMapper courseMapper;
    @Autowired
    private StudentMapper studentMapper;

    @Override
    public PageBean page(Integer page, Integer pageSize, String courseName, String studentName, String className, String university) {
        List<Integer> courseIds = courseMapper.findCourseByNameIds(courseName, university);
        List<Integer> stuIds = studentMapper.findStudentByNameIds(studentName, university);
        //设置分页参数
        PageHelper.startPage(page, pageSize);
        //执行查询
        List<Score> selectList = selectionMapper.pageList(page, pageSize, courseIds, stuIds, university);
        for (Score score : selectList) {
            Integer stuId = score.getStuId();
            Student student = studentMapper.findStudentByStuId(stuId, university);
            score.setClassName(student.getClassName());
            score.setStudentName(student.getName());

            Integer courseId = score.getCourseId();
            String courseNames = courseMapper.findCourseById(courseId, university).getCourseName();
            score.setCourseName(courseNames);
        }
        Page<Score> p = (Page<Score>) selectList;

        //计算总页数
        Integer pageCount = (int) p.getTotal() % pageSize == 0 ? (int) p.getTotal() / pageSize : (int) p.getTotal() / pageSize + 1;

        //封装pageBean对象
        PageBean pageBean = new PageBean((int) p.getTotal(), p.getResult(), pageCount);
        return pageBean;
    }

    @Override
    public ArrayList<AuditApply> mySelection(Integer id, String university) {
        ArrayList<AuditApply> applies = selectionMapper.mySelection(id,university);
        for(AuditApply apply:applies){
            Course course=courseMapper.findCourseById(apply.getCourseId(),apply.getUniversity());
            apply.setCourseName(course.getCourseName());
        }
        return applies;
    }

    @Override
    public Score getSelection(Integer courseId, Integer stuId, String university) {
        return selectionMapper.getSelection(courseId, stuId, university);
    }

    @Override
    public void delete(Integer courseId, Integer stuId, String university) {
        selectionMapper.delete(courseId, stuId, university);
    }

    @Override
    public void update(Score score) {
        selectionMapper.update(score);
    }
}
