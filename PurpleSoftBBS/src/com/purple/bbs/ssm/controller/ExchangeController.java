package com.purple.bbs.ssm.controller;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.purple.bbs.ssm.pojo.SysClasses;
import com.purple.bbs.ssm.pojo.SysDiscuss;
import com.purple.bbs.ssm.pojo.SysDiscussPlus;
import com.purple.bbs.ssm.pojo.SysProduct;
import com.purple.bbs.ssm.pojo.SysUser;
import com.purple.bbs.ssm.service.DiscussService;
import com.purple.bbs.ssm.service.SysUserService;
import com.purple.bbs.ssm.utils.FunctionUtils;
import com.purple.bbs.ssm.utils.Result;
import com.purplesoft.util.PurpleSoftUtil;

import net.sf.ezmorph.object.MapToDateMorpher;

@Controller
public class ExchangeController {

    @Autowired
    private DiscussService discussService;
    @Autowired
    private SysUserService sysUserService;
	/**
	* @Title: goAdd  
	* @Description: 发表文章页面 
	* @param @return    设定文件  
	* @return String    返回类型  
	* @throws
	 */
	@RequestMapping("goadd")
	public String goAdd(Model model) throws Exception{
	    List<SysClasses> listClasses = discussService.findClasses();
	    List<SysProduct> listProduct = discussService.findProduct();
	    model.addAttribute("classes", listClasses);
	    model.addAttribute("product", listProduct);
		return "jie/add";
	}
	
	/**
	* @Title: discussUploadImg  
	* @Description: 上传发表帖子中的图片 
	* @param @param id
	* @param @param file
	* @param @return
	* @param @throws IllegalStateException
	* @param @throws IOException    设定文件  
	* @return String    返回类型  
	* @throws
	 */
	@RequestMapping("discussUploadImg")
	@ResponseBody
	public String discussUploadImg(String id,MultipartFile file) throws IllegalStateException, IOException{
	    try {
	        String picName = FunctionUtils.genImageName();
	        String oriName = file.getOriginalFilename();
	        String extName = oriName.substring(oriName.lastIndexOf("."));
	        File file2 = new File("D:\\BBS\\discuss\\image\\");
	        if(!file2.exists()){
	            file2.mkdirs();
	        }
	        file.transferTo(new File("D:\\BBS\\discuss\\image\\" + picName + extName));
	        String name = picName+extName;
	        String url = "\\\\discuss\\\\image\\\\"+name+"";
	        return Result.uploadOk(url);
        } catch (Exception e) {
            // TODO: handle exception
        }
	    return Result.uploadError();
	}
	
	/**
	* @Title: publishNewDiscuss  
	* @Description:发布新帖
	* @param @param request
	* @param @param model
	* @param @param sysDiscuss
	* @param @return
	* @param @throws Exception    设定文件  
	* @return String    返回类型  
	* @throws
	 */
	@RequestMapping(value = "publishNewDiscuss",method=RequestMethod.POST)
	@ResponseBody
	public String publishNewDiscuss(HttpServletRequest request,Model model,SysDiscuss sysDiscuss) throws Exception{
	    // 校验验证码
        HttpSession session = ((HttpServletRequest)request).getSession();
        String randomcode = request.getParameter("randomcode");
        String validateCode = (String) session.getAttribute("validateCode");
        if (randomcode!=null && validateCode!=null) {
            if (!randomcode.equals(validateCode)) {
                return Result.error("验证码不正确");
            }
        }
        
        //邮箱激活后才可发帖
        Subject currentUser = SecurityUtils.getSubject();
        Session shirosession = currentUser.getSession();
        SysUser sysUser = (SysUser) shirosession.getAttribute("sysUser");
        if(sysUser.getActivate() == 0){
            return Result.error("您尚未开启发帖功能，请去激活邮箱");
        }
        if(sysDiscuss.getClassesid() == 5||sysDiscuss.getClassesid() == 6){
            if(!"管理员".equals(sysUser.getAuthentication())){
                return Result.error("只有完成管理员认证才可发布公告或动态哦！");
            }
        }
        SysUser user = sysUserService.findUserByUserId(sysDiscuss.getUserid()+"");
        if(user.getKiss()<sysDiscuss.getReward()){
            return Result.error("您的飞吻已不足，快去回帖赚飞吻吧");
        }
        if(sysDiscuss.getVersion() == null){
            sysDiscuss.setVersion("");
        }
        if(sysDiscuss.getBrowser() == null){
            sysDiscuss.setBrowser("");
        }
        sysDiscuss.setPublishDate(new Date());
        int n = discussService.saveDiscuss(sysDiscuss);
        sysUserService.updateUserKiss(sysDiscuss.getUserid(),sysDiscuss.getReward());
        if(n>0){
            return Result.ok("发表成功");     
        }else {
            return Result.error("发表失败，请联系社区管理员"); 
        }
	}
	
	/**
	* @Title: saveEditDiscuss  
	* @Description: 修改帖子
	* @param @param request
	* @param @param model
	* @param @param sysDiscuss
	* @param @return
	* @param @throws Exception    设定文件  
	* @return String    返回类型  
	* @throws
	 */
	@RequestMapping("saveEditDiscuss")
	@ResponseBody
	public String saveEditDiscuss(HttpServletRequest request,Model model,SysDiscuss sysDiscuss) throws Exception{
		
		 // 校验验证码
        HttpSession session = ((HttpServletRequest)request).getSession();
        String randomcode = request.getParameter("randomcode");
        String validateCode = (String) session.getAttribute("validateCode");
        if (randomcode!=null && validateCode!=null) {
            if (!randomcode.equals(validateCode)) {
                return Result.error("验证码不正确");
            }
        }
        if(sysDiscuss.getVersion() == null){
            sysDiscuss.setVersion("");
        }
        if(sysDiscuss.getBrowser() == null){
            sysDiscuss.setBrowser("");
        }
        sysDiscuss.setPublishDate(new Date());
        int discussid = sysDiscuss.getDiscussid();
        int n = discussService.updateDiscussByDiscussId(discussid,sysDiscuss);
        if(n>0){
            return Result.ok("修改成功");     
        }else {
            return Result.error("修改失败，请联系社区管理员"); 
        }
	}
	
	
	/**
	 * @throws Exception 
	* @Title: findDiscussCount  
	* @Description:获取不同状态帖子总数  
	* @param @param type
	* @param @return    设定文件  
	* @return String    返回类型  
	* @throws
	 */
	@RequestMapping("findDiscussCount")
	@ResponseBody
    public String findDiscussCount(@RequestParam(value="type")String type,@RequestParam(value="classestype",defaultValue="")String classestype) throws Exception{
	    if("".equals(classestype)){
	    	if("status2".equals(type)){
		        //获取所有帖子总数
		        int count = discussService.findAllDiscuss().size();
		        return "{\"count\":"+count+"}";
		    }else if("status0".equals(type)){
		        //获取未结帖的帖子总数
		        int count = discussService.findOpenDiscussCount();
		        return "{\"count\":"+count+"}";
		    }else if("status1".equals(type)){
		        //获取已结贴的帖子总数
		        int count = discussService.findCloseDiscussCount();
		        return "{\"count\":"+count+"}";
		    }else if("best1".equals(type)){
		        //获取精华帖的帖子总数
		        int count = discussService.findBestDiscussCount();
		        return "{\"count\":"+count+"}";
		    }
	    }else{
	    	int classesid = discussService.findClassesIdByName(classestype);
	    	if("status2".equals(type)){
		        //获取分类下所有帖子总数
		        int count = discussService.findAllDiscussCountByClassesId(classesid);
		        return "{\"count\":"+count+"}";
		    }else if("status0".equals(type)){
		        //获取分类下未结帖的帖子总数
		        int count = discussService.findOpenDiscussCountByClassesId(classesid);
		        return "{\"count\":"+count+"}";
		    }else if("status1".equals(type)){
		        //获取分类下已结贴的帖子总数
		        int count = discussService.findCloseDiscussCountByClassesId(classesid);
		        return "{\"count\":"+count+"}";
		    }else if("best1".equals(type)){
		        //获取分类下精华帖的帖子总数
		        int count = discussService.findBestDiscussCountByClassesId(classesid);
		        return "{\"count\":"+count+"}";
		    }
	    }
        return "{\"count\":0}";
    }
	
	/**
	 * @throws Exception 
	* @Title: findDicussByPage  
	* @Description: 分页查询各种状态的所有帖子
	* @param @return    设定文件  
	* @return String    返回类型  
	* @throws
	 */
	@RequestMapping("findDicussByPage")
	@ResponseBody
	public String findDicussByPage(@RequestParam(value="curr")String curr,@RequestParam(value="limit")String limit
			,@RequestParam(value="type")String type,@RequestParam(value="classestype",defaultValue="")String classestype) throws Exception{
	    if("".equals(classestype)){
	    	if("status2".equals(type)){
	            //获取所有帖子数据
		        String json = discussService.findDiscussByPage(curr,limit);
	            return json;
	        }else if("status0".equals(type)){
	            //获取未结帖的帖子数据
	            String json = discussService.findOpenDiscussByPage(curr,limit);
	            return json;
	        }else if("status1".equals(type)){
	            //获取已结贴的帖子数据
	        	String json = discussService.findCloseDiscussByPage(curr,limit);
	            return json;
	        }else if("best1".equals(type)){
	            //获取精华帖的帖子数据
	        	String json = discussService.findBestDiscussByPage(curr,limit);
	            return json;
	        }
	    }else{
	    	int classesid = discussService.findClassesIdByName(classestype);
	    	if("status2".equals(type)){
	            //获取分类下所有帖子数据
		        String json = discussService.findClassesDiscussByPage(curr,limit,classesid);
	            return json;
	        }else if("status0".equals(type)){
	            //获取分类下未结帖的帖子数据
	            String json = discussService.findOpenClassesDiscussByPage(curr,limit,classesid);
	            return json;
	        }else if("status1".equals(type)){
	            //获取分类下已结贴的帖子数据
	        	String json = discussService.findCloseClassesDiscussByPage(curr,limit,classesid);
	            return json;
	        }else if("best1".equals(type)){
	            //获取分类下精华帖的帖子数据
	        	String json = discussService.findBestClassesDiscussByPage(curr,limit,classesid);
	            return json;
	        }
	    }
        return "";
	}
	
	/**
	 * @throws Exception 
	* @Title: detail  
	* @Description:帖子详情页
	* @param @param discussid
	* @param @return    设定文件  
	* @return String    返回类型  
	* @throws
	 */
	@RequestMapping("detail")
	public String detail(Model model,@RequestParam(value="discussid")String discussid) throws Exception{
	    SysDiscussPlus discussPlus = discussService.findDiscussDetailByDiscussId(discussid);
	    //查询本周热议
	    List<SysDiscussPlus> sysDiscussPluss = discussService.findThisWeekTopTenDiscuss();
	    model.addAttribute("weektopten", sysDiscussPluss);
	    model.addAttribute("DiscussDetail", discussPlus);
        return "jie/detail";
	}
	
	/**
	* @Title: addReadCount  
	* @Description:统计阅读量 
	* @param @param discussid
	* @param @return
	* @param @throws Exception    设定文件  
	* @return String    返回类型  
	* @throws
	 */
	@RequestMapping("addReadCount")
	@ResponseBody
	public String addReadCount(@RequestParam(value="discussid")String discussid) throws Exception{
	    //int count = discussService.findReadCountByDiscussId(discussid);
	    discussService.addDiscussReadCountByDiscussId(discussid);
        return "";
	}
	
	
	/**
	* @Title: editDiscuss  
	* @Description: 去编辑帖子页面
	* @param @param model
	* @param @param discussid
	* @param @return
	* @param @throws Exception    设定文件  
	* @return String    返回类型  
	* @throws
	 */
	@RequestMapping("editDiscuss")
	public String editDiscuss(Model model,@RequestParam(value="discussid")String discussid) throws Exception{
	    
	    SysDiscussPlus discussPlus = discussService.findDiscussDetailByDiscussId(discussid);
	    List<SysClasses> listClasses = discussService.findClasses();
	    List<SysProduct> listProduct = discussService.findProduct();
	    model.addAttribute("classes", listClasses);
	    model.addAttribute("product", listProduct);
	    model.addAttribute("DiscussDetail", discussPlus);
        return "jie/edit";
	}
	
	/**
	* @Title: storeDiscuss  
	* @Description: TODO(这里用一句话描述这个方法的作用)  
	* @param @param discussid
	* @param @param userid
	* @param @return
	* @param @throws Exception    设定文件  
	* @return String    返回类型  
	* @throws
	 */
	@RequestMapping("storeDiscuss")
	@ResponseBody
	public String storeDiscuss(@RequestParam(value="discussid")String discussid,@RequestParam(value="userid",defaultValue="")String userid)throws Exception{
		
		if("".equals(userid)){
			return Result.error("请先登录，再收藏");
		}
		int n = discussService.findIsStoreDiscuss(discussid,userid);
		if(n>0){
			return Result.error("您已收藏此帖，请到用户中心我收藏的贴中查看");
		}
		int m = discussService.storeDiscuss(discussid,userid);
		SysDiscussPlus sysDiscussPlus = discussService.findDiscussDetailByDiscussId(discussid);
		int kiss = 10;
		sysUserService.updatePlusUserKiss(sysDiscussPlus.getUserid(),kiss);
		if(m>0){
			return Result.ok("收藏成功");
		}else{
			return Result.error("收藏失败,请联系社区管理员");
		}
	}
	
	/**
	* @Title: submitreply  
	* @Description: 回复帖子 
	* @param @return    设定文件  
	* @return String    返回类型  
	* @throws
	 */
	@RequestMapping("submitreply")
	@ResponseBody
	public String submitreply(@RequestParam(value="discid")String discid,@RequestParam(value = "replycontent")String replycontent
			,@RequestParam(value="replyerid",defaultValue="")String replyerid,@RequestParam(value="byreplyerid")String byreplyerid
			,@RequestParam(value="disuserid")String disuserid)throws Exception{
		
		//判断用户是否登录后回复帖子
		if("".equals(replyerid)){
			return Result.error("请先登录再回复");
		}
		if("".equals(replycontent)){
			return Result.error("您似乎没回复任何内容，您再想想？");
		}
		int count = sysUserService.findReplyCountInDiscuss(replyerid,discid);
		String replydate = PurpleSoftUtil.dateToStr(new Date(), "yyyy-MM-dd HH:mm:ss");
		int n = discussService.addDiscussReply(discid,replycontent,replyerid,byreplyerid,disuserid,replydate);
		//往回复表中插入相应回复数据
		if(n>0){
			
			//给回复者回复数+1
			sysUserService.addReplyCountByUserid(replyerid);
			//给帖子回复数+1
			discussService.addReplyCountBydiscussid(discid);
			//通知被回复者
			sysUserService.sendMessageToByReplyer(replyerid,byreplyerid,discid,replycontent,replydate);
			
			//从未回复过
			if(count <1 && !replyerid.equals(byreplyerid)){
			    sysUserService.updatePlusUserKiss(Integer.parseInt(replyerid), 2);
			    return Result.ok("回复成功,kiss+2");
			}else{
			    return Result.ok("回复成功");
			}
		}else{
			return Result.error("回复失败，请联系社区管理员");
		}
		
	}
	
	/**
	* @Title: findReplyContent  
	* @Description:查询评论区内容  
	* @param @param discid
	* @param @return
	* @param @throws Exception    设定文件  
	* @return String    返回类型  
	* @throws
	 */
	@RequestMapping("findReplyContentByDiscid")
	@ResponseBody
	public String findReplyContent(@RequestParam(value="discid")String discid)throws Exception{
		String json = discussService.findReplyContent(discid);
		return json;
	}
	
	/**
	 * @throws Exception 
	* @Title: deleteDiscussBydiscussId  
	* @Description: 删除帖子 
	* @param @param discussid
	* @param @return    设定文件  
	* @return String    返回类型  
	* @throws
	 */
	@RequestMapping("deleteDiscussBydiscussId")
	@ResponseBody
	@Transactional(propagation=Propagation.REQUIRED)
	public String deleteDiscussBydiscussId(@RequestParam(value="discussid")String discussid) throws Exception{
		
		int n = discussService.deleteDiscussBydiscussId(discussid);
		int m = discussService.deleteDiscussReplyBydiscussId(discussid);
		if(n>0 && m>=0){
			return Result.ok("删除成功");
		}
		return Result.error("删除失败，请联系社区管理员");
	}
	
	/**
	 * @throws Exception 
	* @Title: acceptReplyByrid  
	* @Description:采纳评论
	* @param @return    设定文件  
	* @return String    返回类型  
	* @throws
	 */
	@RequestMapping("acceptReplyByrid")
	@ResponseBody
	@Transactional(propagation = Propagation.REQUIRED)
	public String acceptReplyByrid(@RequestParam(value="replyerid")String replyerid,@RequestParam(value="replyid")String replyid
	        ,@RequestParam("discussid")String discussid,@RequestParam(value="username")String username,@RequestParam(value="byreplyerid")String byreplyerid) throws Exception{
		int n = discussService.acceptReplyByrid(replyid);
		int m = discussService.updateDiscussAcceptStatus(discussid);
		if(!replyerid.equals(byreplyerid) && n>0 && m>0){
		  //给回复者kiss+10
	       sysUserService.updatePlusUserKiss(Integer.parseInt(replyerid), 20);
	       return Result.ok("采纳成功，["+username+"]kiss+20");
		}
		
		if (n>0 && m>0) {
			return Result.ok("采纳成功");
		}
		return Result.error("采纳失败，请联系社区管理员");
	}
	
	/**
	 * @throws Exception 
	* @Title: deleteReplyByrid  
	* @Description: 删除评论 
	* @param @return    设定文件  
	* @return String    返回类型  
	* @throws
	 */
	@RequestMapping("deleteReplyByrid")
	@ResponseBody
	public String deleteReplyByrid(@RequestParam("replyid")String replyid,@RequestParam(value="discussid")String discussid) throws Exception{
		int accept = discussService.findreplyAccept(replyid);
		if(accept == 1){
			return Result.error("被采纳的评论无法被删除");
		}
		int n = discussService.deleteReplyByrid(replyid);
		//回复数-1
		discussService.updateDiscussReplyCountMinus(discussid);
		if(n>0){
			return Result.ok("删除成功");
		}
		return Result.error("删除失败，请联系社区管理员");
		
	}
}
