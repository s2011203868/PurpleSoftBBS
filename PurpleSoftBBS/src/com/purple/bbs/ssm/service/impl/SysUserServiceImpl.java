package com.purple.bbs.ssm.service.impl;

import java.text.MessageFormat;
import java.util.Date;
import java.util.List;
import java.util.Properties;

import org.apache.shiro.crypto.hash.Md5Hash;
import org.springframework.beans.factory.annotation.Autowired;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.purple.bbs.ssm.mapper.SysUserMapper;
import com.purple.bbs.ssm.pojo.SysDiscuss;
import com.purple.bbs.ssm.pojo.SysDiscussPlus;
import com.purple.bbs.ssm.pojo.SysMessage;
import com.purple.bbs.ssm.pojo.SysUser;
import com.purple.bbs.ssm.service.SysUserService;
import com.purple.bbs.ssm.utils.FunctionUtils;
import com.purple.bbs.ssm.utils.MailSenderUtil;
import com.purplesoft.util.PurpleSoftUtil;


public class SysUserServiceImpl implements SysUserService{

	@Autowired
	SysUserMapper sysUserMapper;
	@Autowired
    private MailSenderUtil mailSenderUtil;
	
	@Override
	public int saveSysUser(String username, String password, String email,String sex) throws Exception {
		String salt = FunctionUtils.randomSixCharStr();
		Md5Hash md5Hash = new Md5Hash(password, salt, 2);
		// 获取加密后的密码
		String md5HashPassword = md5Hash.toString();
		String registTime = PurpleSoftUtil.dateToStr(new Date(), "yyyy-MM-dd");
		String [] icons = {"9265781b88651b5501c9f439868981fb.jpg","9265781b88651b55d86d6cd9c0bdd386.jpg","9265781b88651b55d148ab531302b39c.jpg",
		        "9265781b88651b550ef410aaf3f75958.jpg","9265781b88651b5584da5bdaa9bf1d55.jpg"};
		int index = (int)Math.round(Math.random()*4);
		String icon = icons[index];
		int n = sysUserMapper.saveSysUser(username,md5HashPassword,email,salt,sex,registTime,icon);
		return n;
	}

	@Override
	public SysUser findUserByEmail(String email) throws Exception {
		SysUser sysUser = sysUserMapper.findUserByEmail(email);
		return sysUser;
	}

	@Override
	public void setLastLoginTime(String nowTime, int id) throws Exception {
		sysUserMapper.setLastLoginTime(nowTime,id);
	}

	@Override
	public int updateIcon(String icon,String id) throws Exception {

		int n = sysUserMapper.updateIcon(icon,id);
		return n;
	}

	@Override
	public int updateUserPassword(String newPassword, String email) throws Exception {
		int n = sysUserMapper.updateUserPassword(newPassword,email);
		return n;
	}

    @Override
    public int editUserInfo(String email, String username, String sex, String city, String sign,String userid) throws Exception {
        int n = sysUserMapper.editUserInfo(email,username,sex,city,sign,userid);
        return n;
    }

    @Override
    public int editEmailActivate(int activate,String userid) throws Exception {
        int n = sysUserMapper.editEmailActivate(activate,userid);
        return n;
    }

    @Override
    public Boolean sendActivateMail(String email,String username) throws Exception {
        
        try {
            Properties props = new Properties();
            props.load(this.getClass().getClassLoader()
                    .getResourceAsStream("email_template.properties"));
            String time = new Date().getTime()+"";
            String token = PurpleSoftUtil.encrypt(time);
            String link = "http://s2011203868.eicp.net:48583/PurpleSoftBBS/activate.action?token="+token+"&key=email&value="+ email;
            String content = "";
            content = props.getProperty("activatecontent");
            content = MessageFormat.format(content,username,link);
            mailSenderUtil.sendMail(email,"紫软社区邮箱激活",content);
        } catch (Exception e) {
        }
        return true;
    }

    @Override
    public boolean sendFindPasswordEmail(String email, String username) throws Exception {
        try {
            Properties props = new Properties();
            props.load(this.getClass().getClassLoader()
                    .getResourceAsStream("email_template.properties"));
            String time = new Date().getTime()+"";
            String token = PurpleSoftUtil.encrypt(time);
            String link = "http://s2011203868.eicp.net:48583/PurpleSoftBBS/resetPassword.action?token="+token+"&key=email&value="+ email;
            String content = "";
            content = props.getProperty("retrievepasswordcontent");
            content = MessageFormat.format(content,username,link);
            mailSenderUtil.sendMail(email,"紫软社区密码重置",content);
        } catch (Exception e) {
        }
        return true;
    }

	@Override
	public void updateActivateToken(String token, String email) throws Exception {
		sysUserMapper.updateActivateToken(token,email);
	}

	@Override
	public void updateResetToken(String token, String email) throws Exception {
		sysUserMapper.updateResetToken(token,email);
	}

	@Override
	public SysUser findUserByUserId(String userid) throws Exception {
		SysUser sysUser = sysUserMapper.findUserByUserId(userid);
		return sysUser;
	}

    @Override
    public int findActiveStatusByUserid(int userid) throws Exception {
        int active = sysUserMapper.findActiveStatusByUserid(userid);
        return active;
    }

	@Override
	public String findMyPublishDiscussByPage(String curr, String limit, String userid) throws Exception {
		 int begin = (Integer.parseInt(curr)-1)*(Integer.parseInt(limit));
	     int pageSize = Integer.parseInt(limit);
	     List<SysDiscuss> discusses = sysUserMapper.findMyPublishDiscussByPage(begin,pageSize,userid);
	     String json = JSON.toJSONString(discusses,SerializerFeature.DisableCircularReferenceDetect,SerializerFeature.WriteDateUseDateFormat); 
		
		 return json;
	}

	@Override
	public String findMyStoreDiscussByPage(String curr, String limit, String userid) throws Exception {
		 int begin = (Integer.parseInt(curr)-1)*(Integer.parseInt(limit));
	     int pageSize = Integer.parseInt(limit);
	     List<SysDiscuss> discusses = sysUserMapper.findMyStoreDiscussByPage(begin,pageSize,userid);
	     String json = JSON.toJSONString(discusses,SerializerFeature.DisableCircularReferenceDetect,SerializerFeature.WriteDateUseDateFormat); 
		
		 return json;
	}

	@Override
	public void addReplyCountByUserid(String replyerid) throws Exception {
		sysUserMapper.addReplyCountByUserid(replyerid);
	}

	@Override
	public SysUser findUserByUserName(String username) throws Exception {
		SysUser sysUser = sysUserMapper.findUserByUserName(username);
		return sysUser;
	}

    @Override
    public void sendMessageToByReplyer(String replyerid, String byreplyerid, String discid, String replycontent,
            String replydate) throws Exception {
        sysUserMapper.sendMessageToByReplyer(replyerid,byreplyerid,discid,replycontent,replydate);
        
    }

    @Override
    public int findMessageByUserid(String userid) throws Exception {
        int n = sysUserMapper.findMessageByUserid(userid);
        return n;
    }

    @Override
    public int updateMessageStats(String userid) throws Exception {
        int n = sysUserMapper.updateMessageStats(userid);
        return n;
    }

    @Override
    public String getUserMessage(String userid) throws Exception {
        List<SysMessage> messages = sysUserMapper.getUserMessage(userid);
        String json = JSON.toJSONString(messages,SerializerFeature.DisableCircularReferenceDetect,SerializerFeature.WriteDateUseDateFormat); 
        return json;
    }

    @Override
    public void updateUserKiss(int userid, int reward) throws Exception {
        sysUserMapper.updateUserKiss(userid,reward);
        
    }

    @Override
    public void updatePlusUserKiss(int userid, int kiss) throws Exception {
        sysUserMapper.updatePlusUserKiss(userid,kiss);
        
    }

    @Override
    public int findReplyCountInDiscuss(String replyerid, String discid) throws Exception {
        int count = sysUserMapper.findReplyCountInDiscuss(replyerid,discid);
        return count;
    }

    @Override
    public void setAuthentication(String string, String string2, String email) throws Exception {
        sysUserMapper.setAuthentication(string,string2,email);
        
    }
}
