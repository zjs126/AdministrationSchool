package com.example.controller;

import com.example.pojo.Apply;
import com.example.pojo.PageBean;
import com.example.pojo.Result;
import com.example.pojo.Score;
import com.example.pojo.Vo.AuditApply;
import com.example.service.SelectionService;
import com.example.utils.ThreadLocalUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.Map;

@RestController
@Slf4j
@RequestMapping("/selection")
public class SelectionController {

    @Autowired
    private SelectionService selectionService;

    @GetMapping("/page")
    public Result<PageBean> page(@RequestParam(defaultValue = "1") Integer page,
                                 @RequestParam(defaultValue = "10") Integer pageSize,
                                 String courseName, String studentName, String className){
        log.info("学生选课分页查询：{}，{}，{}，{}，{}",page,pageSize,courseName,studentName,className);
        Map<String, Object> map = ThreadLocalUtil.get();
        String university = (String) map.get("university");

        PageBean pageBean = selectionService.page(page,pageSize,courseName,studentName,className,university);
        return Result.success(pageBean);
    }

    /**
     * 学生查询自己全部选课
     */
    @GetMapping("/mySelection")
    public Result<Object> mySelection(){
        Map<String, Object> map = ThreadLocalUtil.get();
        String university = (String) map.get("university");
        Integer id = (Integer) map.get("id");

        ArrayList<AuditApply> applies=selectionService.mySelection(id,university);
        return Result.success(applies);
    }

    @GetMapping("/{courseId}/{stuId}")
    public Result<Score> getSelection(@PathVariable(value = "courseId") Integer courseId,
                                      @PathVariable(value = "stuId") Integer stuId){
        log.info("根据课程id和学号查询选课记录：{}，{}",courseId, stuId);

        Map<String, Object> map = ThreadLocalUtil.get();
        String university = (String) map.get("university");

        Score score = selectionService.getSelection(courseId, stuId, university);
        return Result.success(score);
    }

    @DeleteMapping("/{courseId}/{stuId}")
    public Result<Object> delete(@PathVariable(value = "courseId") Integer courseId,
                                 @PathVariable(value = "stuId") Integer stuId){
        log.info("管理员删除选课记录");

        Map<String, Object> map = ThreadLocalUtil.get();
        String university = (String) map.get("university");

        selectionService.delete(courseId, stuId, university);

        return Result.success();
    }

    @PutMapping
    public Result<Object> update(@RequestBody Score score){
        log.info("管理员更新选课记录:{}",score);

        Map<String, Object> map = ThreadLocalUtil.get();
        String university = (String) map.get("university");
        score.setUniversity(university);

        selectionService.update(score);
        return Result.success();
    }
}
