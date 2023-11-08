package com.example.controller;

import com.example.pojo.Result;
import com.example.pojo.Student;
import com.example.service.StudentService;
import com.example.utils.BCryptPasswordUtils;
import com.example.utils.RedisCache;
import com.example.utils.ThreadLocalUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@Slf4j
@RequestMapping("/student")
public class StudentController {

    @Autowired
    private StudentService studentService;
    @Autowired
    private RedisCache redisCache;

    /**
     * 更新学生账号密码
     * @param params 新旧密码
     * @param token jwt令牌
     */
    @PatchMapping("/updatePwd")
    public Result updatePassword(@RequestBody Map<String,String> params, @RequestHeader("token") String token){
        //1. 校验参数
        String oldPwd = params.get("oldPwd");
        String rePwd = params.get("rePwd");
        String newPwd = params.get("newPwd");

        if (!StringUtils.hasLength(oldPwd) || !StringUtils.hasLength(rePwd) || !StringUtils.hasLength(newPwd)){
            return Result.error(401,"缺少必要参数");
        }

        //原密码是否正确
        Map<String, Object> map = ThreadLocalUtil.get();
        Integer id = (Integer) map.get("id");
        Student student = studentService.findStudentByStuId(id);
        if(!BCryptPasswordUtils.matchPassword(oldPwd, student.getPassword())){
            log.info("原密码填写错误");
            return Result.error(401,"原密码填写错误");
        }
        //newPwd和rePwd是否相同
        if(!newPwd.equals(rePwd)){
            log.info("两次填写的密码不一样");
            return Result.error(401,"两次填写的密码不一样");
        }
        //2. 调用service完成密码更新
        studentService.updatePassword(id, newPwd);

        //删除redis中对应的token
        redisCache.deleteObject(token);

        return Result.success();
    }

    /**
     * 更新学生信息
     * @param student 要更新的学生信息
     */
    @PutMapping("/update")
    public Result<Student> update(@RequestBody @Validated Student student){
        log.info("学生更新信息：{}",student);
        studentService.update(student);
        return Result.success();
    }
}
