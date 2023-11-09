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

    public SC(Integer id, Integer courseId) {
        this.courseID=courseId;
        this.stuID=id;
    }
}
