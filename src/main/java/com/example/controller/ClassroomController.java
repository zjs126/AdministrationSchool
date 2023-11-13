package com.example.controller;

import com.example.pojo.Classroom;
import com.example.pojo.Result;
import com.example.service.ClassroomService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@Slf4j
@RequestMapping("/classroom")
public class ClassroomController {

    @Autowired
    private ClassroomService classroomService;

    //新增教室的方法
    @PostMapping("/add")
    public Result addClassroom(@RequestBody Classroom classroom) {

        return Result.success();
    }

    //修改教室信息

    //查询教室
}
