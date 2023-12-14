package com.example.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ClassroomApply {
    private int id;
    private String classroom;
    private Integer courseID;
    private Integer staff_id;
    private String university;
}
