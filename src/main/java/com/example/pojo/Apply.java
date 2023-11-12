package com.example.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 缓考申请表实体类
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Apply {
    private Integer stuId;          // 学号
    private Integer courseId;       //课程编号
    private Integer situation;      // 1为批准 0为不批准
    private Integer administrator;  // 审核人id
    private String reason;          // 申请原因
    private String university;      // 学校
}
