package com.example.controller;

import com.example.service.ApplyService;
import com.example.service.StudentService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@Slf4j
@RequestMapping("/apply")
public class ApplyController {

    @Autowired
    private ApplyService applyService;

    //学生申请

    //学生查看自己的申请

    //老师搜索申请

    //老师审批
}
