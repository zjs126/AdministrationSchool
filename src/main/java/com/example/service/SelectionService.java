package com.example.service;

import com.example.pojo.PageBean;
import com.example.pojo.Score;
import com.example.pojo.Vo.AuditApply;

import java.util.ArrayList;

public interface SelectionService {
    PageBean page(Integer page, Integer pageSize, String courseName, String studentName, String className, String university);

    ArrayList<AuditApply> mySelection(Integer id, String university);

    Score getSelection(Integer courseId, Integer stuId, String university);

    void delete(Integer courseId, Integer stuId, String university);

    void update(Score score);
}
