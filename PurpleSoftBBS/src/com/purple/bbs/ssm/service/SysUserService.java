package com.purple.bbs.ssm.service;

import com.purple.bbs.ssm.pojo.SysUser;

public interface SysUserService {

	int saveSysUser(String username, String password, String email,String sex)throws Exception;

	SysUser findUserByEmail(String email)throws Exception;

	void setLastLoginTime(String nowTime, int id)throws Exception;

	int updateIcon(String string,String id)throws Exception;

	int updateUserPassword(String newPassword, String email)throws Exception;

    int editUserInfo(String email, String username, String sex, String city, String sign,String userid)throws Exception;

    int editEmailActivate(int i,String userid)throws Exception;

    Boolean sendActivateMail(String email,String username)throws Exception;

    boolean sendFindPasswordEmail(String email, String username)throws Exception;

	void updateActivateToken(String token, String value)throws Exception;

	void updateResetToken(String token, String value)throws Exception;

	SysUser findUserByUserId(String userid)throws Exception;

    int findActiveStatusByUserid(int userid)throws Exception;

	String findMyPublishDiscussByPage(String curr, String limit, String userid)throws Exception;

	String findMyStoreDiscussByPage(String curr, String limit, String userid)throws Exception;

	void addReplyCountByUserid(String replyerid)throws Exception;

	SysUser findUserByUserName(String username)throws Exception;

    void sendMessageToByReplyer(String replyerid, String byreplyerid, String discid, String replycontent,
            String replydate)throws Exception;

    int findMessageByUserid(String userid)throws Exception;

    int updateMessageStats(String userid)throws Exception;

    String getUserMessage(String userid)throws Exception;

    void updateUserKiss(int userid, int reward)throws Exception;

    void updatePlusUserKiss(int userid, int kiss)throws Exception;

    int findReplyCountInDiscuss(String replyerid, String discid)throws Exception;

    void setAuthentication(String string, String string2, String email)throws Exception;

}
