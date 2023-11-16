package com.example.controller;

import com.example.pojo.Result;
import com.example.service.AdminService;
import com.example.utils.ThreadLocalUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

/**
 * 管理员特有功能控制层
 */
@RestController
@Slf4j
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private AdminService adminService;

    /**
     * 重置分数
     * @param request
     * @return
     */
    @PatchMapping("/resetScore")
    public Result resetScore(@RequestBody Map<String, Object> request){

        //从request中获取信息
        Integer stuId = (Integer) request.get("stuId");
        Integer courseId = (Integer) request.get("courseId");

        //判断传入参数是否为空
        if (stuId == null || courseId == null){
            return Result.error("传入的参数有空");
        }

        //从ThreadLocal中获取信息
        Map<String, Object> map = ThreadLocalUtil.get();
        Integer userType = (Integer) map.get("userType");
        String university = (String) map.get("university");

        //判断用户是否为管理员
        if (userType != 3){
            return Result.error("此操作需要管理员权限");
        }

        adminService.resetScore(stuId, courseId, university);

        return Result.success();
    }
}
