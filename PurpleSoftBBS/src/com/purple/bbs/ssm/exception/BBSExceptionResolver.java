package com.purple.bbs.ssm.exception;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.Date;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.DisabledAccountException;
import org.apache.shiro.authc.ExcessiveAttemptsException;
import org.apache.shiro.authz.UnauthorizedException;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;

import com.purple.bbs.ssm.utils.Result;

/**
 * 
 * @ClassName: AMSExceptionResolver 
 * @Description: TODO
 * @author: PurpleSoft@一禅
 * @date: 2018年4月3日 上午9:50:02
 */
public class BBSExceptionResolver implements HandlerExceptionResolver {

	@Override
	public ModelAndView resolveException(HttpServletRequest request,
			HttpServletResponse response, Object handler, Exception ex) {
		//输出异常
		ex.printStackTrace();
		
		//统一异常处理代码
		//异常信息
		String message = null;
		BBSException bbsException = null;
		//如果ex是系统 自定义的异常，直接取出异常信息
		if(ex instanceof BBSException){
			bbsException = (BBSException)ex;
		}else if(ex instanceof UnauthorizedException){
		    //没有操作权限
			bbsException = new BBSException("您没有操作权限");
		}else{
			bbsException = new BBSException("未知错误,请联系管理员");
		}
		
		//错误 信息
		message = bbsException.getMessage();
		
		try {
			response.setContentType("application/json; charset=utf-8");  
	        response.setCharacterEncoding("UTF-8");  
			response.getWriter().write(Result.error(message));
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return new ModelAndView();
	}
}
