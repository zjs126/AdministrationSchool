package com.example.controller;

import com.example.pojo.Result;
import com.example.pojo.Teacher;
import com.example.service.TeacherService;
import com.example.utils.BCryptPasswordUtils;
import com.example.utils.RedisCache;
import com.example.utils.ThreadLocalUtil;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.Map;

@RestController
@Slf4j
@RequestMapping("/teacher")
public class TeacherController {

    @Autowired
    private TeacherService teacherService;
    @Autowired
    private RedisCache redisCache;

    /**
     * 更新教职工账号密码
     *
     * @param params 新旧密码参数
     * @param token  jwt令牌
     */
    @PatchMapping("/updatePwd")
    public Result updatePassword(@RequestBody Map<String, String> params, @RequestHeader("token") String token) {
        //1. 校验参数
        String oldPwd = params.get("oldPwd");
        String rePwd = params.get("rePwd");
        String newPwd = params.get("newPwd");

        if (!StringUtils.hasLength(oldPwd) || !StringUtils.hasLength(rePwd) || !StringUtils.hasLength(newPwd)) {
            return Result.error(401, "缺少必要参数");
        }

        //原密码是否正确
        Map<String, Object> map = ThreadLocalUtil.get();
        Integer id = (Integer) map.get("id");
        String university = (String) map.get("university");
        Teacher teacher = teacherService.findTeacherByStaffId(id, university);
        if (!BCryptPasswordUtils.matchPassword(oldPwd, teacher.getPassword())) {
            log.info("原密码填写错误");
            return Result.error(401, "原密码填写错误");
        }
        //newPwd和rePwd是否相同
        if (!newPwd.equals(rePwd)) {
            log.info("两次填写的密码不一样");
            return Result.error(401, "两次填写的密码不一样");
        }
        //2. 调用service完成密码更新
        teacherService.updatePassword(id, newPwd, university);

        //删除redis中对应的token
        redisCache.deleteObject(token);

        return Result.success();
    }

    @PostMapping("/update")
    public Result update(@RequestBody @Validated Teacher teacher) {
        Map<String, Object> map = ThreadLocalUtil.get();
        teacher.setUniversity((String) map.get("university"));
        log.info("教职工更新信息:{}", teacher);
        teacherService.update(teacher);
        return Result.success();
    }


    /**
     * 通过发送excel文件，批量导入学生信
     *
     * @param excel
     * @return
     * @throws IOException
     */
    @PostMapping("/StuExcel")
    public Result addByExcel(@RequestParam("file") MultipartFile excel) throws IOException {

        log.info("学生信息excel");

        if (excel == null || excel.isEmpty()) {
            log.info("获取excl文件异常");
            throw new RuntimeException("获取excl文件异常");
        }

        //判断是否是管理员权限
        Map<String, Object> map = ThreadLocalUtil.get();
        Integer id = (Integer) map.get("id");
        String university = (String) map.get("university");
        int permission=teacherService.GetPermission(id,university);
        if (permission!=6){
            return Result.error("权限不够");
        }

        try {
            InputStream inputStream = excel.getInputStream();
            teacherService.addByExcel(inputStream);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("文件上传异常！！！");
        }
        return Result.success();
    }


    /**
     * 老师信息的批量导入
     * @param excel
     * @return
     * @throws IOException
     */
    @PostMapping("/TeaExcel")
    public Result addByExcel2(@RequestParam("file") MultipartFile excel) throws IOException {
        log.info("老师信息excel");

        if (excel == null || excel.isEmpty()) {
            log.info("获取excl文件异常");
            throw new RuntimeException("获取excl文件异常");
        }

        //判断是否是管理员权限
        Map<String, Object> map = ThreadLocalUtil.get();
        Integer id = (Integer) map.get("id");
        String university = (String) map.get("university");
        int permission=teacherService.GetPermission(id,university);
        if (permission!=6){
            return Result.error("权限不够");
        }

        try {
            InputStream inputStream = excel.getInputStream();
            teacherService.addByExcel2(inputStream);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("文件上传异常！！！");
        }
        return Result.success();
    }
}
