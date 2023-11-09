package com.example.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class SC {
    private Integer stuID;
    private Integer courseID;
    private Integer score;
    private String university;
    public SC(Integer id, Integer courseId,String university) {
        this.courseID=courseId;
        this.stuID=id;
        this.university=university;
    }
}
