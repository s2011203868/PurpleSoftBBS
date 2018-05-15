package com.purple.bbs.ssm.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.executor.ErrorContext;

import com.purple.bbs.ssm.pojo.SysDiscuss;
import com.purple.bbs.ssm.pojo.SysMessage;
import com.purple.bbs.ssm.pojo.SysUser;

public interface SysUserMapper {

	int saveSysUser(@Param(value="username")String username,
					@Param(value="password") String password,
					@Param(value="email") String email,@Param("salt")String salt,
					@Param("sex")String sex,@Param("registTime")String registTime,@Param("icon")String icon)throws Exception;

	SysUser findUserByEmail(String email)throws Exception;

	void setLastLoginTime(@Param("nowTime")String nowTime,@Param("id") int id)throws Exception;

	int updateIcon(@Param("icon")String icon,@Param("id")String id)throws Exception;

	int updateUserPassword(@Param("newPassword")String newPassword, @Param("email")String email)throws Exception;

    int editUserInfo(@Param("email")String email, @Param("username")String username, @Param("sex")String sex,@Param("city") String city,@Param("sign") String sign,@Param("userid")String userid)throws Exception;

    int editEmailActivate(@Param("activate")int activate,@Param("userid")String userid)throws Exception;

	void updateActivateToken(@Param("token")String token,@Param("email") String email)throws Exception;

	void updateResetToken(@Param("token")String token,@Param("email") String email);

	SysUser findUserByUserId(String userid)throws Exception;

    int findActiveStatusByUserid(int userid)throws Exception;

	List<SysDiscuss> findMyPublishDiscussByPage(@Param("begin")int begin,@Param("pageSize") int pageSize,@Param("userid") String userid)throws Exception;

	List<SysDiscuss> findMyStoreDiscussByPage(@Param("begin")int begin,@Param("pageSize") int pageSize,@Param("userid") String userid)throws Exception;

	void addReplyCountByUserid(String replyerid)throws Exception;

	SysUser findUserByUserName(String username)throws Exception;

    void sendMessageToByReplyer(@Param("replyerid")String replyerid,@Param("byreplyerid") String byreplyerid,@Param("discid") String discid,@Param("replycontent") String replycontent,
           @Param("replydate") String replydate)throws Exception;

    int findMessageByUserid(String userid)throws Exception;

    int updateMessageStats(String userid)throws Exception;

    List<SysMessage> getUserMessage(String userid)throws Exception;

    void updateUserKiss(@Param("userid")int userid,@Param("reward") int reward)throws Exception;

    void updatePlusUserKiss(@Param("userid")int userid, @Param("kiss")int kiss)throws Exception;

    int findReplyCountInDiscuss(@Param("replyerid")String replyerid,@Param("discid") String discid)throws Exception;

    void setAuthentication(@Param("authentication")String authentication,@Param("authenticatelevel") String authenticatelevel,@Param("email") String email)throws Exception;

}
