package com.example.service.Impl;

import com.example.mapper.ClassroomMapper;
import com.example.mapper.CourseMapper;
import com.example.service.ClassroomService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ClassroomServiceImpl implements ClassroomService {

    @Autowired
    private ClassroomMapper classroomMapper;

}
