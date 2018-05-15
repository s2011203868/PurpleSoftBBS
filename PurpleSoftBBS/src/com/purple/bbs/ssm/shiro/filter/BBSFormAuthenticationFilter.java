package com.purple.bbs.ssm.shiro.filter;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.shiro.web.filter.authc.FormAuthenticationFilter;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * 
 * @ClassName: AMSFormAuthenticationFilter 
 * @Description: 自定义验证码校验及账号校验过滤器
 * @author: PurpleSoft@一禅
 * @date: 2018年3月16日 上午11:25:52
 */
public class BBSFormAuthenticationFilter extends FormAuthenticationFilter {
	
	@Override
	protected boolean onAccessDenied(ServletRequest request, ServletResponse response, Object mappedValue) throws Exception {
		
		// 校验验证码
		// 从session获取正确的验证码
		HttpSession session = ((HttpServletRequest)request).getSession();
		//页面输入的验证码
		String randomcode = request.getParameter("randomcode");
		//从session中取出验证码
		String validateCode = (String) session.getAttribute("validateCode");
		if (randomcode!=null && validateCode!=null) {
			if (!randomcode.equals(validateCode)) {
				// randomCodeError表示验证码错误 
				request.setAttribute("shiroLoginFailure", "randomCodeError");
				//拒绝访问，不再校验账号和密码 
				return true; 
			}
		}
		return super.onAccessDenied(request, response, mappedValue);
	}

}
