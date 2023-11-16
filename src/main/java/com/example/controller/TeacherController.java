package com.example.controller;

import com.example.pojo.Result;
import com.example.pojo.SC;
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
            return Result.error("缺少必要参数");
        }

        //原密码是否正确
        Map<String, Object> map = ThreadLocalUtil.get();
        Integer id = (Integer) map.get("id");
        String university = (String) map.get("university");
        Teacher teacher = teacherService.findTeacherByStaffId(id, university);
        if (!BCryptPasswordUtils.matchPassword(oldPwd, teacher.getPassword())) {
            log.info("原密码填写错误");
            return Result.error("原密码填写错误");
        }
        //newPwd和rePwd是否相同
        if (!newPwd.equals(rePwd)) {
            log.info("两次填写的密码不一样");
            return Result.error("两次填写的密码不一样");
        }
        //2. 调用service完成密码更新
        teacherService.updatePassword(id, newPwd, university);

        //删除redis中对应的token
        redisCache.deleteObject(token);

        return Result.success();
    }

    /**
     * 更新教职工信息
     * @param teacher 教职工信息
     */
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
     * @param excel 表格信息
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
     * @param excel 表格信息
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

    /**
     * 老师打分
     * @param request 请求参数体
     * -stuId 学号
     * -university 学校
     * -courseId 课程编号
     * -ordinary 平时分
     * -ending 期末分
     * -score 总成绩
     */
    @PatchMapping("/scoring")
    public Result scoring(@RequestBody Map<String, Object> request){

        //从request中获取分数信息
        Integer ordinary = (Integer) request.get("ordinary");
        Integer ending = (Integer) request.get("ending");
        Integer score = (Integer) request.get("score");
        Integer courseId = (Integer) request.get("courseId");
        Integer stuId = (Integer) request.get("stuId");

        //验证参数是否有空
        if (ordinary == null || ending == null || score == null || courseId == null){
            return Result.error("必须参数有空");
        }

        //从ThreadLocal线程获取信息
        Map<String, Object> map = ThreadLocalUtil.get();
        String university = (String) map.get("university");
        Integer userType = (Integer) map.get("userType");

        //判断用户身份是否为老师
        if (userType == 1){
            return Result.error("学生用户没有权限");
        }

        //检查是否已经打过分
        Integer status = teacherService.checkScored(stuId, university, courseId);
        if (status == 1){
            return Result.error("已经打过分，无法重复打分");
        }

        teacherService.scoring(stuId, university, courseId,  ordinary, ending, score);
        return Result.success();
    }
}
