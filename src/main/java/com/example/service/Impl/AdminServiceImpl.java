package com.example.service.Impl;

import com.example.mapper.AdminMapper;
import com.example.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AdminServiceImpl implements AdminService {

    @Autowired
    private AdminMapper adminMapper;

    @Override
    public void resetScore(Integer stuId, Integer courseId, String university) {
        adminMapper.resetScore(stuId, courseId, university);
    }

    @Override
    public void addClassToStu(Integer stuId, Integer courseId, String university) {
        adminMapper.addClassToStu(stuId,courseId,university);
    }
}
