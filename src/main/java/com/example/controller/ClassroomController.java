package com.example.controller;

import com.example.pojo.Classroom;
import com.example.pojo.Result;
import com.example.service.ClassroomService;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.annotations.Delete;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;

@RestController
@Slf4j
@RequestMapping("/classroom")
public class ClassroomController {

    @Autowired
    private ClassroomService classroomService;

    //新增教室的方法
    @PostMapping("/add")
    public Result addClassroom(@RequestBody Classroom classroom) {

        log.info("添加教室：{}", classroom.getClassroom());
        int bool = classroomService.addClassroom(classroom);
        if (bool == 0) {
            return Result.error("已存在该教室");
        }
        return Result.success();
    }

    //修改教室信息
    @PostMapping("/update")
    public Result updateClassroom(@RequestBody Classroom classroom) {

        log.info("修改教室信息：{}", classroom.getClassroom());
        classroomService.updateClassroom(classroom);
        return Result.success();
    }

    //查询教室
    @GetMapping("/find")
    public Result findClassroom() {
        log.info("查询教室信息");
        ArrayList<Classroom> classrooms = classroomService.SelectAllClassroom();
        return Result.success(classrooms);
    }

    @DeleteMapping("/delete")
    public Result deleteClassroom(@RequestBody Classroom classroom) {
        log.info("查询指定教室");
        classroomService.deleteClassroom(classroom);
        return Result.success();
    }
}
