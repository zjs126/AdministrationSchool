package com.example.mapper;

import com.example.pojo.ClassroomApply;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.ArrayList;

@Mapper
public interface ClassroomApplyMapper {

    @Insert("insert into classroomapply (courseID, classroom, staff_id, university) values (#{courseID},#{classroom},#{id},#{university}) ")
    void applyChange(Integer id, String university, Integer courseID, String classroom);

    @Select("select * from classroomapply where state!=0")
    ArrayList<ClassroomApply> classroomApply();
}
