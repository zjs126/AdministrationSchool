package com.example.mapper;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Update;

@Mapper
public interface AdminMapper {
    /**
     * 重置分数
     *
     * @param stuId      学号
     * @param courseId   课程编号
     * @param university 学校
     */
    @Update("update selection set ordinary=null, ending=null, score=null, status=0 where stu_id=#{stuId} and course_id=#{courseId} and university=#{university}")
    void resetScore(Integer stuId, Integer courseId, String university);

    /**
     * 加课
     *
     * @param stuId
     * @param courseId
     * @param university
     */
    @Insert("insert into selection (stu_id, course_id,university) values(#{stuId},#{courseId},#{university}) ")
    void addClassToStu(Integer stuId, Integer courseId, String university);
}
