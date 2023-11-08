package com.example.interceptor;

import com.alibaba.fastjson.JSONObject;
import com.example.pojo.Result;
import com.example.utils.JwtUtils;
import com.example.utils.RedisCache;
import com.example.utils.ThreadLocalUtil;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import java.util.Map;

@Slf4j
@Component
public class LoginCheckInterceptor implements HandlerInterceptor {

    @Autowired
    private RedisCache redisCache;

    @Override //目标资源方法执行前运行，返回true，放行；返回false，不放行
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        response.setHeader("Access-Control-Allow-Origin", "*"); // 设置允许跨域的来源，这里设置为所有来源
        response.setHeader("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS, PATCH"); // 设置允许的请求方法
        response.setHeader("Access-Control-Allow-Headers", "*"); // 设置允许的请求头
        response.setHeader("Access-Control-Max-Age", "3600"); // 设置预检请求的有效期，单位为秒

        // 1.获取请求的url
        String url = request.getRequestURL().toString();
        log.info("请求的url：{}", url);

        // 2.判断请求的url中是否包含login，如果包含，说明是登录操作，放行
        if (url.contains("login")) {
            log.info("登录操作，放行...");
            return true;
        } else if(url.contains("student/register")){
            log.info("学生注册操作，放行...");
            return true;
        }

        // 3.获取请求头中的令牌（token）
        String token = request.getHeader("token");

        //获取redis中的token
        Object redisToken = redisCache.getCacheObject(token);

        // 4.判断令牌是否存在，如果不存在，返回错误结果（未登录）
        if (!StringUtils.hasLength(token) || redisToken == null) {
            log.info("请求头token为空或失效了，返回未登录的信息");
            Result error = Result.error(401,"NOT_LOGIN");
            // 手动转换 对象--JSON --------> 阿里巴巴fastJSON
            String notLogin = JSONObject.toJSONString(error);
            response.getWriter().write(notLogin);
            return false;
        }

        // 5.解析token，如果解析失败，返回错误结果（未登录）
        try {
            Map<String, Object> claims = JwtUtils.parseJWT(token);

            //把业务数据存储到ThreadLocal中
            ThreadLocalUtil.set(claims);
        } catch (Exception e) { //jwt解析失败
            e.printStackTrace();
            log.info("解析令牌失败，返回为登录的错误信息");
            Result error = Result.error(401,"NOT_LOGIN");
            // 手动转换 对象--JSON --------> 阿里巴巴fastJSON
            String notLogin = JSONObject.toJSONString(error);
            response.getWriter().write(notLogin);
            return false;
        }

        // 6.放行
        log.info("令牌合法，放行...");
        return true;
    }

    @Override //目标资源方法运行后运行
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        HandlerInterceptor.super.postHandle(request, response, handler, modelAndView);
    }

    @Override //视图渲染完毕后运行，最后运行
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
        HandlerInterceptor.super.afterCompletion(request, response, handler, ex);
        //清空ThreadLocal中的数据
        ThreadLocalUtil.remove();
    }
}
