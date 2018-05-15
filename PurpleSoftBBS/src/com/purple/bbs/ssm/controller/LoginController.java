package com.purple.bbs.ssm.controller;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.shiro.authc.DisabledAccountException;
import org.apache.shiro.authc.ExcessiveAttemptsException;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.UnknownAccountException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.druid.sql.dialect.oracle.ast.stmt.OracleIfStatement.Else;
import com.purple.bbs.ssm.exception.BBSException;
import com.purple.bbs.ssm.pojo.SysUser;
import com.purple.bbs.ssm.service.SysUserService;
import com.purple.bbs.ssm.utils.Result;
import com.purplesoft.util.PurpleSoftUtil;

@Controller
public class LoginController {

	@Autowired
	private SysUserService sysUserService;
	
	
	@RequestMapping("goregist")
	public String toRegist(){
		return "user/reg";
	}
	
	@RequestMapping("goforget")
	public String toForGet(Model model,@RequestParam(value="email",defaultValue="")String email) throws Exception{
	    model.addAttribute("flagPassword","forget");
		return "user/forget";
	}
	
	@RequestMapping("resetPassword")
	public String resetPassword(Model model,@RequestParam(value = "token")String token,@RequestParam(value="key")String key,@RequestParam(value="value")String value) throws Exception{
	    //"http://s2011203868.eicp.net:48583/PurpleSoftBBS/resetPassword.action?token="+token+"&key=email&value="+ email
	    Long sendTime = Long.parseLong(PurpleSoftUtil.decrypt(token));
        Long newTime = System.currentTimeMillis();
        if((newTime - sendTime) > 1800000){
            model.addAttribute("flagPassword","forget");
            model.addAttribute("email", value);
            model.addAttribute("emailMessage", "链接已失效，请重新发送邮件");
        }else{
        	SysUser sysUser = sysUserService.findUserByEmail(value);
        	if(sysUser.getResetToken() == null){
        		sysUserService.updateResetToken(token,value);
        		model.addAttribute("flagPassword","reset");
                model.addAttribute("email", value);
        	}else if(!sysUser.getResetToken().equals(token)){
        		sysUserService.updateResetToken(token,value);
        		model.addAttribute("flagPassword","reset");
                model.addAttribute("email", value);
        	}else{
        		model.addAttribute("flagPassword","forget");
        		model.addAttribute("email", value);
                model.addAttribute("emailMessage", "链接已失效，请重新发送邮件");
        	}
        }
        return "user/forget";
	}
	
	@RequestMapping("regist")
	@ResponseBody
	public String userRegist(HttpServletRequest request,Model model,String pass,String email,String username,String sex)throws Exception{
		
		// 校验验证码
		HttpSession session = ((HttpServletRequest)request).getSession();
		String randomcode = request.getParameter("randomcode");
		String validateCode = (String) session.getAttribute("validateCode");
		if (randomcode!=null && validateCode!=null) {
			if (!randomcode.equals(validateCode)) {
				return Result.error("验证码不正确");
			}
		}
		
		SysUser sysUser = sysUserService.findUserByEmail(email);
		if(sysUser !=null){
			return Result.error("邮箱已被注册!");
		}
		SysUser sysUser2 = sysUserService.findUserByUserName(username);
		if(sysUser2 !=null){
			return Result.error("这个昵称似乎已经被占用，请换一个试试吧！");
		}
		int n = sysUserService.saveSysUser(username,pass,email,sex);
		//发送系统消息
        SysUser user = sysUserService.findUserByEmail(email);
        String replydate = PurpleSoftUtil.dateToStr(new Date(), "yyyy-MM-dd HH:mm:ss");
        sysUserService.sendMessageToByReplyer("2147480000",user.getId()+"","2147480000","系统消息：",replydate);
		if(n>0){
			return Result.ok("注册成功！请登录");
		}else{
			return Result.error("注册失败！");
		}
	}
	
	@RequestMapping("login")	
	public String login(HttpServletRequest request,HttpServletResponse response) throws Exception{
			
		String shiroLoginFailure = (String) request.getAttribute("shiroLoginFailure");
        if(shiroLoginFailure!=null){
            if(shiroLoginFailure.equals(UnknownAccountException.class.getName())){
                throw new BBSException("邮箱不存在");
            }else if (shiroLoginFailure.equals(IncorrectCredentialsException.class.getName())) {
                throw new BBSException("密码错误");
            }else if(shiroLoginFailure.equals(ExcessiveAttemptsException.class.getName())){
                throw new BBSException("错误次数过多，请5分钟后再试");
            }else if(shiroLoginFailure.equals("randomCodeError")){
                throw new BBSException("验证码错误");
            }else if(shiroLoginFailure.equals(DisabledAccountException.class.getName())){
            	throw new BBSException("账号被禁用");
            }else {
                throw new Exception();
            }
        
        }
		//登陆失败
		return "user/login";
	}
}
