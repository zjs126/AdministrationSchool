package com.example.pojo;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.validation.constraints.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Student {
    @NotNull
    private Integer stuId; //学号
    @Pattern(regexp = "^\\S{1,10}$")
    private String name; //姓名
    private String major; //专业
    private String college; //学院
    private String university; //学校
    private Integer className; //班级
    private String password; //密码
    private Integer grand; //年级
}
