package com.purple.bbs.ssm.controller;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.crypto.hash.Md5Hash;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.async.DeferredResult;
import org.springframework.web.multipart.MultipartFile;

import com.purple.bbs.ssm.pojo.SysDiscuss;
import com.purple.bbs.ssm.pojo.SysReply;
import com.purple.bbs.ssm.pojo.SysUser;
import com.purple.bbs.ssm.service.DiscussService;
import com.purple.bbs.ssm.service.SysUserService;
import com.purple.bbs.ssm.utils.FunctionUtils;
import com.purple.bbs.ssm.utils.Result;
import com.purplesoft.util.PurpleSoftUtil;

@Controller
public class SysUserController {

	@Autowired
	private SysUserService sysUserService;
	@Autowired
    private DiscussService discussService;
	private DeferredResult<String> dr;
	
	@RequestMapping("goset")
	public String goSet(){
		return "user/set";
	}
	
	@RequestMapping("gomessage")
	public String goMessage(){
		return "user/message";
	}
	
	@RequestMapping("gohome")
	public String goHome(HttpServletRequest request,@RequestParam(value="userid",defaultValue = "")String userid,@RequestParam(value="username",defaultValue="")String username) throws Exception{
		if("".equals(userid) && "".equals(username)){
			SysUser sysUser = (SysUser) request.getSession().getAttribute("sysUser");
			List<SysDiscuss> discusses = discussService.findTopTenQuestionDiscussByUserid(sysUser.getId());
			List<SysReply> replies = discussService.findReplyItemByReperid(sysUser.getId());
			request.setAttribute("replyItem", replies);
			request.setAttribute("userMessage", sysUser);
			request.setAttribute("discusses", discusses);
		}else if(!"".equals(userid)){
			SysUser sysUser = sysUserService.findUserByUserId(userid);
			int id = Integer.parseInt(userid);
			List<SysDiscuss> discusses = discussService.findTopTenQuestionDiscussByUserid(id);
			List<SysReply> replies = discussService.findReplyItemByReperid(id);
            request.setAttribute("replyItem", replies);
			request.setAttribute("userMessage", sysUser);
			request.setAttribute("discusses", discusses);
		}else{
			SysUser sysUser = sysUserService.findUserByUserName(username);
			List<SysDiscuss> discusses = discussService.findTopTenQuestionDiscussByUserid(sysUser.getId());
			List<SysReply> replies = discussService.findReplyItemByReperid(sysUser.getId());
            request.setAttribute("replyItem", replies);
			request.setAttribute("userMessage", sysUser);
			request.setAttribute("discusses", discusses);
		}
		return "user/home";
	}
	
	/**
	* @Title: goUserCenter  
	* @Description: 用户中心 
	* @param @return    设定文件  
	* @return String    返回类型  
	* @throws
	 */
	@RequestMapping("gousercenter")
	public String goUserCenter(HttpServletRequest request,Model model,@RequestParam(value="flag",defaultValue="")String flag)throws Exception{
		if(!"".equals(flag)){
			model.addAttribute("collection","collection");
		}
		Subject currentUser = SecurityUtils.getSubject();
        Session shirosession = currentUser.getSession();
        SysUser sysUser = (SysUser) shirosession.getAttribute("sysUser");
		//查询我发的贴数量
        if(sysUser !=null){
            int publishCount = discussService.findDiscussCountByUserid(sysUser.getId());
            int storeCount = discussService.findStoreDiscussCountByUserid(sysUser.getId());
            model.addAttribute("publishCount", publishCount);
            model.addAttribute("storeCount", storeCount);
        }
		return "user/index";
	}
	
	@RequestMapping("goactivate")
	public String goActivate(){
		return "user/activate";
	}
	
	/**
	* @Title: Activate  
	* @Description: 激活邮箱
	* @param @param request
	* @param @param model
	* @param @param token
	* @param @param key
	* @param @param value
	* @param @return
	* @param @throws Exception    设定文件  
	* @return String    返回类型  
	* @throws
	 */
	@RequestMapping("activate")
	public String Activate(HttpServletRequest request,Model model,String token,String key,String value) throws Exception{
	    //激活邮件处理token=1524034802388&key=email&value=15554604611@163.com
	    Long sendTime = Long.parseLong(PurpleSoftUtil.decrypt(token));
	    Long newTime = System.currentTimeMillis();
	    if((newTime - sendTime) > 1800000){
	        model.addAttribute("activateMessage", "激活链接已失效，请重新发送激活链接");
	        SysUser newSysUser = sysUserService.findUserByEmail(value);
	        model.addAttribute("sysUser", newSysUser);
	    }else{
	        SysUser sysUser = sysUserService.findUserByEmail(value);
	        if(sysUser.getActivateToken() ==null){
	        	sysUserService.editEmailActivate(1, sysUser.getId()+"");
	        	sysUserService.updateActivateToken(token,value);
		        SysUser newSysUser = sysUserService.findUserByEmail(value);
		        model.addAttribute("sysUser", newSysUser);
	        }else if(!sysUser.getActivateToken().equals(token)){
	        	sysUserService.editEmailActivate(1, sysUser.getId()+"");
	        	sysUserService.updateActivateToken(token,value);
		        SysUser newSysUser = sysUserService.findUserByEmail(value);
		        model.addAttribute("sysUser", newSysUser);
	        }else{
	        	model.addAttribute("activateMessage", "链接已失效");
		        SysUser newSysUser = sysUserService.findUserByEmail(value);
		        model.addAttribute("sysUser", newSysUser);
	        }
	    } 
	    return "user/activate";
	}
	
	/**
	 * 
	* @Title: uploadTouXiang  
	* @Description: 上传头像
	* @param @param items
	* @param @param picture
	* @param @return
	* @param @throws Exception    设定文件  
	* @return String    返回类型  
	* @throws
	 */
	@RequestMapping(value="/uploadtouxiang",method={RequestMethod.POST,RequestMethod.GET})
	@ResponseBody
	public String uploadTouXiang(String id,MultipartFile file) throws Exception {
	    String picName = FunctionUtils.genImageName();
	    String oriName = file.getOriginalFilename();
	    String extName = oriName.substring(oriName.lastIndexOf("."));
	    File file2 = new File("D:\\BBS\\touxiang\\");
	    if(!file2.exists()){
	        file2.mkdirs();
	    }
	    file.transferTo(new File("D:\\BBS\\touxiang\\" + picName + extName));
	    String name = picName+extName;
	    int n = sysUserService.updateIcon(name,id);
	    if(n>0){
	    	return Result.ok("上传成功，下次登录更新头像");     
	    }else {
			return Result.error("上传失败"); 
		}
	}
	
	/**
	* @Title: replacePassword  
	* @Description: 修改密码  
	* @param @param nowpass
	* @param @param pass
	* @param @param email
	* @param @return
	* @param @throws Exception    设定文件  
	* @return String    返回类型  
	* @throws
	 */
	@RequestMapping("replacepassword")
	@ResponseBody
	public String replacePassword(HttpServletRequest request,@RequestParam(value="nowpass",defaultValue="")String nowpass,String pass,String email) throws Exception{
		if(!nowpass.equals("")){
			//修改密码
			SysUser sysUser = sysUserService.findUserByEmail(email);
			String oldPassword = sysUser.getPassword();
			String salt = sysUser.getSalt();
			Md5Hash md5Hash = new Md5Hash(nowpass, salt, 2);
			String md5HashPassword = md5Hash.toString();
			if(!md5HashPassword.equals(oldPassword)){
				return Result.error("原密码不正确");
			}else{
				Md5Hash newMd5 = new Md5Hash(pass, salt, 2);
				String newPassword = newMd5.toString();
				int n = sysUserService.updateUserPassword(newPassword,email);
				if(n > 0){
					return Result.ok("密码修改成功");
				}else{
					return Result.error("密码修改失败");
				}
			}
		}else{
		    //重置密码
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
	        String salt = sysUser.getSalt();
	        Md5Hash newMd5 = new Md5Hash(pass, salt, 2);
            String newPassword = newMd5.toString();
            int n = sysUserService.updateUserPassword(newPassword,email);
            if(n > 0){
                return Result.ok("密码重置成功");
            }else{
                return Result.error("密码重置失败");
            }
		}
	}
	
	/**
	 * @throws Exception 
	* @Title: editUserInfo  
	* @Description: 修改用户资料  
	* @param @return    设定文件  
	* @return String    返回类型  
	* @throws
	 */
	@RequestMapping("editUserInfo")
	@ResponseBody
	@Transactional(propagation=Propagation.REQUIRED)
	public String editUserInfo(@RequestParam(value="email")String email,@RequestParam(value="username")String username
	        ,@RequestParam(value="sex")String sex,@RequestParam(value="city")String city
	        ,@RequestParam(value="sign",defaultValue="")String sign,@RequestParam(value="userid")String userid) throws Exception{
	    
		SysUser sUser = sysUserService.findUserByUserName(username);
		if(sUser !=null && !email.equals(sUser.getEmail())){
		    return Result.error("这个昵称似乎已经被占用，请换一个试试吧！");
		}
		
	    Subject currentUser = SecurityUtils.getSubject();
	    Session session = currentUser.getSession();
	    SysUser sysUser = (SysUser) session.getAttribute("sysUser");
	    if(email.equals(sysUser.getEmail())){
	       int n =  sysUserService.editUserInfo(email, username, sex, city, sign,userid);
	       if(n > 0){
               return Result.ok("资料修改成功");
           }else{
               return Result.error("资料修改失败");
           }
	    }else{
	        int n = sysUserService.editUserInfo(email, username, sex, city, sign,userid);
	        int m = sysUserService.editEmailActivate(0,userid);
	        if(n > 0 && m>0){
                return Result.ok("资料修改成功");
            }else{
                return Result.error("资料修改失败");
            }
	    }
	}
	
	/**
	* @Title: activateEmail  
	* @Description: 发送邮箱激活邮件 
	* @param @param email
	* @param @param username
	* @param @return
	* @param @throws Exception    设定文件  
	* @return String    返回类型  
	* @throws
	 */
	@RequestMapping("activateEmail")
	@ResponseBody
	public String activateEmail(@RequestParam(value = "email")String email,@RequestParam(value="username")String username) throws Exception{
	    
	    Boolean b = sysUserService.sendActivateMail(email,username);
	    if(b){
	        return Result.ok("已成功将激活链接发送到了您的邮箱，接收可能会稍有延迟，请注意查收") ;
	    }
        return Result.error("邮件发送失败");
	}
	
	/**
	 * @throws Exception 
	* @Title: findPasswordEmail  
	* @Description: 发送找回密码邮件 
	* @param @return    设定文件  
	* @return String    返回类型  
	* @throws
	 */
	@RequestMapping("findPasswordEmail")
	@ResponseBody
	public String findPasswordEmail(HttpServletRequest request,@RequestParam(value="email")String email) throws Exception{
	    
	    SysUser sysUser = sysUserService.findUserByEmail(email);
        if(sysUser == null){
            return Result.error("邮箱不存在");
        }
	   // 校验验证码
        HttpSession session = ((HttpServletRequest)request).getSession();
        String randomcode = request.getParameter("randomcode");
        String validateCode = (String) session.getAttribute("validateCode");
        if (randomcode!=null && validateCode!=null) {
            if (!randomcode.equals(validateCode)) {
                return Result.error("验证码不正确");
            }
        }
	    
	    boolean b = sysUserService.sendFindPasswordEmail(email,sysUser.getUsername());
	    if(b){
	        return Result.ok("已将重置密码的链接发送至您的邮箱，请注意查收");
	    }else{
	        return Result.error("邮件发送失败");
	    }
	}
	
	
	/**
	 * @throws Exception 
	* @Title: findMyPublishDiscuss  
	* @Description: 查询我发的贴 
	* @param @return    设定文件  
	* @return String    返回类型  
	* @throws
	 */
	@RequestMapping("findMyPublishDiscussByPage")
	@ResponseBody
	public String findMyPublishDiscussByPage(@RequestParam("curr")String curr,@RequestParam(value="limit")String limit,
			@RequestParam("userid")String userid) throws Exception{
		
		String json = sysUserService.findMyPublishDiscussByPage(curr,limit,userid);
		return json;
		
	}
	
	/**
	* @Title: findMyStoreDiscussByPage  
	* @Description: 查询我收藏的帖
	* @param @param curr
	* @param @param limit
	* @param @param userid
	* @param @return
	* @param @throws Exception    设定文件  
	* @return String    返回类型  
	* @throws
	 */
	@RequestMapping("findMyStoreDiscussByPage")
	@ResponseBody
	public String findMyStoreDiscussByPage(@RequestParam("curr")String curr,@RequestParam(value="limit")String limit,
			@RequestParam("userid")String userid)throws Exception{
		
		String json = sysUserService.findMyStoreDiscussByPage(curr,limit,userid);
		return json;
	}
	
	/**
	 * @throws Exception 
	* @Title: receiveMessage  
	* @Description:异步发送消息
	* @param @return    设定文件  
	* @return String    返回类型  
	* @throws
	 */
	@RequestMapping("getMessage")
	@ResponseBody
	public DeferredResult<String> receiveMessage(@RequestParam("userid")String userid) throws Exception{
	    dr = new DeferredResult<String>();
	    int count = sysUserService.findMessageByUserid(userid);
        if(count > 0){
            dr.setResult(""+count);
        }
        dr.setResult("0");
        return dr;
	}
	
	/**
	* @Title: getUserMessage  
	* @Description:查询用户消息  列表
	* @param @param userid
	* @param @return
	* @param @throws Exception    设定文件  
	* @return String    返回类型  
	* @throws
	 */
	@RequestMapping("getUserMessage")
	@ResponseBody
	public String getUserMessage(@RequestParam(value="userid")String userid)throws Exception{
	    
	    String json= sysUserService.getUserMessage(userid);
        return json;
	}
	
	/**
	 * @throws Exception 
	* @Title: updateMessageStats  
	* @Description:清除所有消息
	* @param @return    设定文件  
	* @return String    返回类型  
	* @throws
	 */
	@RequestMapping("updateMessageStats")
	@ResponseBody
	public String updateMessageStats(@RequestParam(value = "userid")String userid) throws Exception{
	    
	    int n = sysUserService.updateMessageStats(userid);
	    if(n >0){
	        return Result.ok("消息状态更新成功");
	    }
	    return Result.error("消息状态更新失败");  
	}
	
}
