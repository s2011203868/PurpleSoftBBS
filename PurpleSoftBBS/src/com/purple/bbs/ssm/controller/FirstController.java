package com.purple.bbs.ssm.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.druid.sql.dialect.oracle.ast.stmt.OracleIfStatement.Else;
import com.purple.bbs.ssm.pojo.SysDiscuss;
import com.purple.bbs.ssm.pojo.SysDiscussPlus;
import com.purple.bbs.ssm.pojo.SysUser;
import com.purple.bbs.ssm.service.DiscussService;
import com.purple.bbs.ssm.service.SysUserService;
import com.purple.bbs.ssm.utils.FunctionUtils;
import com.purple.bbs.ssm.utils.Result;

import jdk.management.resource.internal.TotalResourceContext;

@Controller
public class FirstController {

	@Autowired
	private SysUserService sysUserService;
	@Autowired
	private DiscussService discussService;
	
	@RequestMapping("first")
	@ResponseBody
	public String first(HttpServletResponse response) throws Exception{
		//获取主体
		Subject currentUser = SecurityUtils.getSubject();
		//获取账户信息
		SysUser sysUser = (SysUser) currentUser.getPrincipal();
		String nowTime = FunctionUtils.dateToStr(new Date());
		sysUserService.setLastLoginTime(nowTime,sysUser.getId());
		//放入shiro管理的session域中
		Session session = currentUser.getSession();
		session.setAttribute("sysUser", sysUser);
		return Result.ok("登录成功");
		
	}
	
	@RequestMapping("index")
	public String index(Model model,@RequestParam(value="status",defaultValue="")String status,
	        @RequestParam(value="best",defaultValue="")String best,@RequestParam(value="classestype",defaultValue="")String classestype) throws Exception{
		
		//查询热议榜
	    List<SysDiscussPlus> sysDiscussPluss = discussService.findThisWeekTopTenDiscuss();
	    model.addAttribute("weektopten", sysDiscussPluss);
	    
		if("".equals(classestype)){
			if("".equals(status) && "".equals(best)){
		        //首页
				List<SysDiscussPlus> bestDiscussList = discussService.findBestDiscuss();
		        List<SysDiscussPlus> topTwentyDiscussList = discussService.findtopTwentyDiscuss();
		        List<SysDiscussPlus> topSetList = new ArrayList<SysDiscussPlus>();
		        Iterator<SysDiscussPlus> it = topTwentyDiscussList.iterator();
			    while(it.hasNext()){
			        SysDiscussPlus s = it.next();
			        if(s.getTopStatus() ==1){
			        	topSetList.add(s);
			            it.remove();
			        }
			    }
		        if(topSetList.size() >0){
		            for(int i = 0 ; i<topSetList.size() ; i++){
		               topTwentyDiscussList.add(i, topSetList.get(i)); 
		            }
		        }
		        
		       
			    
			    //查看回帖榜
			    List<SysUser> replyUser = discussService.findTopTenReplyUser();
			    model.addAttribute("replyTopTenUser", replyUser);
		        model.addAttribute("topTwentyDiscuss", topTwentyDiscussList);
		        model.addAttribute("bestDiscuss", bestDiscussList);
		        
		        return "index";
		    }else if("2".equals(status) && "".equals(best)){
	            //综合
	            model.addAttribute("selectType", "status2");
	            return "jie/index";
	        }else if("0".equals(status) && "".equals(best)){
		        //未结帖
	            model.addAttribute("selectType", "status0");
	            return "jie/index";
		    }else if("1".equals(status) && "".equals(best)){
		        //已结帖
	            model.addAttribute("selectType", "status1");
	            return "jie/index";
		    }else if("".equals(status) && "1".equals(best)){
		        //精华帖
	            model.addAttribute("selectType", "best1");
	            return "jie/index";
		    }
		}else{
			model.addAttribute("classestype",classestype );
			if("".equals(status) && "".equals(best)){
	            //综合
	            model.addAttribute("selectType", "status2");
	            return "jie/index";
	        }else if("2".equals(status) && "".equals(best)){
	            //综合
	            model.addAttribute("selectType", "status2");
	            return "jie/index";
	        }else if("0".equals(status) && "".equals(best)){
		        //未结帖
	            model.addAttribute("selectType", "status0");
	            return "jie/index";
		    }else if("1".equals(status) && "".equals(best)){
		        //已结帖
	            model.addAttribute("selectType", "status1");
	            return "jie/index";
		    }else if("".equals(status) && "1".equals(best)){
		        //精华帖
	            model.addAttribute("selectType", "best1");
	            return "jie/index";
		    }
		}
	    
	    return "index";
	}
}
