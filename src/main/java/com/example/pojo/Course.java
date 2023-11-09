package com.example.pojo;

import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Course {
    @NotNull
    private Integer courseId;
    @Pattern(regexp = "^\\S{1,10}$")
    private String courseName;
    private Integer teacherId;
    private Integer classroom;
    private Integer time;//'1为早八 2为早十 3为下二 4为下四'
    private Integer date;//'周一到周五'
    private String type;//课程类型
    private String description;//课程描述
    private Integer state;//'1为开设'
    private String university;
}
