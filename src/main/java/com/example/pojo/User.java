package com.example.pojo;

import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 用户信息登录实体类
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class User {
    @NotNull
    private Integer id;
    @NotEmpty
    @Pattern(regexp = "^\\S{1,18}$")
    private String password;
    @NotEmpty
    private String university;
    private Integer userType;// 1为学生，2为老师及班主任，3为教秘，4是辅导员，5是管理员
}
