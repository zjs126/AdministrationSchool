package com.example;

import com.example.utils.ScheduleUtils;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@SpringBootTest
class AdministrationSchoolApplicationTests {

    /**
     * 测试日期映射函数
     */
    @Test
    void scheduleTest1(){
        // 示例：多个date和time组合
        Integer date = 123;
        Integer time = 123;
        String combinedScheduleString = ScheduleUtils.schedule(date, time);
        System.out.println(combinedScheduleString);
    }

    @Test
    void scheduleTest2(){
        // 示例：多个date和time组合
        Integer date = 12;
        Integer time = 12;
        String combinedScheduleString = ScheduleUtils.scheduleTable(date, time);
        System.out.println(combinedScheduleString);
    }

    /**
     * 生成JWT
     */
    @Test
    public void testGetJWT() {
        Map<String, Object> claims = new HashMap<>();
        claims.put("id", 1);
        claims.put("name", "tom");

        String jwt = Jwts.builder()
                .signWith(SignatureAlgorithm.HS256, "itheima") //签名算法
                .setClaims(claims) //自定义内容（载荷）
                .setExpiration(new Date(System.currentTimeMillis() + 3600 * 1000)) //设置有效期为1h
                .compact();
        System.out.println(jwt);
    }

    /**
     * 解析JWT
     */
    @Test
    public void testParseJwt(){
        Claims claims = Jwts.parser()
                .setSigningKey("itheima")
                .parseClaimsJws("eyJhbGciOiJIUzI1NiJ9.eyJuYW1lIjoidG9tIiwiaWQiOjEsImV4cCI6MTY5NzI4OTYyMX0.A74rC9Dq-JLDB_9WJ_Y-GBIuZ-PxAbIhiiqc8khCffw")
                .getBody();
        System.out.println(claims);
    }

}
