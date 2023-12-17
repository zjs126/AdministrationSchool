package com.example.pojo.Vo;

import com.example.pojo.Apply;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class AuditApply extends Apply {
    private String courseName;         //课程姓名
    private String studentName;        //学生姓名
}
