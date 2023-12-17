package com.example.pojo;

import com.fasterxml.jackson.annotation.JsonFormat;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

/**
 * 缓考申请表实体类
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Apply {
    @NotNull
    private Integer stuId;             // 学号
    @NotNull
    private Integer courseId;          //课程编号
    private Integer situation;         //1为批准  2不通过
    @NotNull
    private Integer administrator;     //审核人id
    private String reason;             //申请原因
    @NotEmpty
    private String university;         //学校
    @NotEmpty
    private String year;               //学年
    private Integer trimesters;        //学期
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime createTime;  //创建时间
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime updateTime;  //修改时间
    private Integer submit;            //2为未提交状态，1为提交状态/记录审核人有没有审核
}
