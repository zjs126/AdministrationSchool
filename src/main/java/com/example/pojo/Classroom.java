package com.example.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Classroom {
    private Integer classroom;
    private String type;//教室类型
    private String situation;//教室状态
    private String university;//学校
}
