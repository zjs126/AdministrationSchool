package com.example.mapper;

import com.example.pojo.Apply;
import com.example.pojo.Grade;
import com.example.pojo.Score;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.ArrayList;
import java.util.List;

@Mapper
public interface SelectionMapper {

    List<Score> pageList(Integer page, Integer pageSize, List<Integer> courseIds, List<Integer> stuIds, String university);

    @Select("select * from selection where  course_id=#{courseId} and stu_id=#{stuId} and university=#{university}")
    Score getSelection(Integer courseId, Integer stuId, String university);

    @Delete("delete from selection where course_id=#{courseId} and stu_id=#{stuId} and university=#{university}")
    void delete(Integer courseId, Integer stuId, String university);

    @Update("update selection set ordinary=#{ordinary},ending=#{ending},score=#{score} " +
            "where university=#{university} and stu_id=#{stuId} and course_id=#{courseId}")
    void update(Score score);

    @Select("SELECT AVG(score) AS averageScore, ROUND(AVG(CASE WHEN score >= 60 THEN 1.0 ELSE 0 END) * 100) AS passRate FROM selection WHERE university = #{university} AND course_id = #{courseID} GROUP BY year ORDER BY year ASC;")
    List<Grade> gradeAnalysis(Integer courseID, String university);

    @Select("select stu_id,course_id,year,trimesters,university from selection where stu_id=#{id} and university=#{university}")
    ArrayList<Apply> mySelection(Integer id,String university);
}
