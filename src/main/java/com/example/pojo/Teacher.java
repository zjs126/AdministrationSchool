package com.example.pojo;

import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 教职工信息实体类
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Teacher {
    @NotNull
    private Integer staffId;
    private String name;
    private Integer className;
    private Integer permission;
    private String password;
    private String university; //学校
    private String college; //学院
}
