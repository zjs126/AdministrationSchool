package com.example.mapper;

import com.example.pojo.Score;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface SelectionMapper {

    List<Score> pageList(Integer page, Integer pageSize, List<Integer> courseIds, List<Integer> stuIds, String university);
}
