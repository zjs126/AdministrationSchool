package com.example.service;

import com.example.pojo.Apply;
import com.example.pojo.PageBean;

import java.util.ArrayList;

public interface SelectionService {
    PageBean page(Integer page, Integer pageSize, String courseName, String studentName, String className, String university);

    ArrayList<Apply> mySelection(Integer id,String university);
}
