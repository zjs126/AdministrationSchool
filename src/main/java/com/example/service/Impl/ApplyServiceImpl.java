package com.example.service.Impl;

import com.example.mapper.ApplyMapper;
import com.example.mapper.CourseMapper;
import com.example.mapper.StudentMapper;
import com.example.pojo.Apply;
import com.example.pojo.Course;
import com.example.pojo.PageBean;
import com.example.pojo.Vo.AuditApply;
import com.example.service.ApplyService;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Service
public class ApplyServiceImpl implements ApplyService {

    @Autowired
    private ApplyMapper applyMapper;
    @Autowired
    private CourseMapper courseMapper;
    @Autowired
    private StudentMapper studentMapper;

    @Override
    public Apply findApplyById(Integer stuId, Integer courseId, String university, String year) {
        return applyMapper.findApplyById(stuId, courseId, university, year);
    }

    @Override
    public void addApply(Apply apply) {
        apply.setCreateTime(LocalDateTime.now());
        apply.setUpdateTime(LocalDateTime.now());
        apply.setSituation(2);
        apply.setSubmit(1);
        applyMapper.addApply(apply);
    }

    @Override
    public PageBean page(Integer page, Integer pageSize, LocalDateTime begin, LocalDateTime end, String year,
                         Integer trimesters, List<Integer> courseIds, String university, Integer stuId, Integer staffId, Integer situation) {
        //设置分页参数
        PageHelper.startPage(page,pageSize);

        //执行查询
        List<AuditApply> applyList = applyMapper.pageList(begin, end, year, trimesters, courseIds, university, stuId, staffId, situation);
        for (AuditApply apply : applyList) {
            Integer courseId = apply.getCourseId();
            apply.setCourseName(courseMapper.findCourseById(courseId, university).getCourseName());

            apply.setStudentName(studentMapper.findStudentByStuId(apply.getStuId(), university).getName());
        }
        Page<AuditApply> p = (Page<AuditApply>) applyList;

        //计算总页数
        Integer pageCount = (int)p.getTotal() % pageSize == 0 ? (int)p.getTotal() / pageSize : (int)p.getTotal() / pageSize + 1;

        //封装pageBean对象
        PageBean pageBean = new PageBean((int)p.getTotal(), p.getResult(), pageCount);
        return pageBean;
    }

    @Override
    public void updateApply(Apply apply) {
        apply.setUpdateTime(LocalDateTime.now());
        applyMapper.updateApply(apply);
    }

    @Override
    public void deleteApply(Integer courseId, String year, Integer stuId, String university) {
        applyMapper.deleteApply(courseId, year, stuId, university);
    }

    @Override
    public void changeSubmit(Integer courseId, String year, Integer stuId, String university) {
        applyMapper.changeSubmit(courseId, year, stuId, university);
    }

    @Override
    public void audit(Integer courseId, String year, Integer situation, String university, Integer stuId, Integer trimesters) {
        applyMapper.audit(courseId, year, situation, university, stuId, trimesters);
    }

    @Override
    public ArrayList<AuditApply> getMyApply(Integer stuId, String university) {
        ArrayList<AuditApply>applies= applyMapper.getMyApply(stuId,university);
        for(AuditApply apply:applies){
            Course course=courseMapper.findCourseById(apply.getCourseId(),apply.getUniversity());
            apply.setCourseName(course.getCourseName());
        }
        return applies;
    }

    @Override
    public void submit(Apply apply) {
        applyMapper.submit(apply);
    }

}
