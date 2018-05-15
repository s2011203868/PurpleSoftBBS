package com.purple.bbs.ssm.service;

import java.util.List;

import com.purple.bbs.ssm.pojo.SysClasses;
import com.purple.bbs.ssm.pojo.SysDiscuss;
import com.purple.bbs.ssm.pojo.SysDiscussPlus;
import com.purple.bbs.ssm.pojo.SysProduct;
import com.purple.bbs.ssm.pojo.SysReply;
import com.purple.bbs.ssm.pojo.SysUser;

public interface DiscussService {

    List<SysClasses> findClasses()throws Exception;

    List<SysProduct> findProduct()throws Exception;

    int saveDiscuss(SysDiscuss sysDiscuss)throws Exception;

	List<SysDiscussPlus> findBestDiscuss()throws Exception ;

	List<SysDiscussPlus> findAllDiscuss()throws Exception ;

    List<SysDiscussPlus> findtopTwentyDiscuss()throws Exception;

    List<SysDiscussPlus> findtopTwentyOpenDiscuss()throws Exception;

    List<SysDiscussPlus> findtopTwentyCloseDiscuss()throws Exception;

    List<SysDiscussPlus> findtopTwentyBestDiscuss()throws Exception;

    int findOpenDiscussCount()throws Exception;

    int findCloseDiscussCount()throws Exception;

    int findBestDiscussCount()throws Exception;

    String findDiscussByPage(String curr, String limit)throws Exception;

	String findCloseDiscussByPage(String curr, String limit)throws Exception;

	String findOpenDiscussByPage(String curr, String limit)throws Exception;

	String findBestDiscussByPage(String curr, String limit)throws Exception;

	int findClassesIdByName(String classestype)throws Exception;

	int findAllDiscussCountByClassesId(int classesid)throws Exception;

	int findOpenDiscussCountByClassesId(int classesid)throws Exception;

	int findCloseDiscussCountByClassesId(int classesid)throws Exception;

	int findBestDiscussCountByClassesId(int classesid)throws Exception;

	String findClassesDiscussByPage(String curr, String limit, int classesid)throws Exception;

	String findOpenClassesDiscussByPage(String curr, String limit, int classesid)throws Exception;

	String findCloseClassesDiscussByPage(String curr, String limit, int classesid)throws Exception;

	String findBestClassesDiscussByPage(String curr, String limit, int classesid)throws Exception;

    SysDiscussPlus findDiscussDetailByDiscussId(String discussid)throws Exception;

    void addDiscussReadCountByDiscussId(String discussid)throws Exception;

    int findReadCountByDiscussId(String discussid)throws Exception;

	int findDiscussCountByUserid(int id)throws Exception;

	int updateDiscussByDiscussId(int discussid,SysDiscuss sysDiscuss)throws Exception;

	List<SysDiscuss> findTopTenQuestionDiscussByUserid(int id)throws Exception;

	int findIsStoreDiscuss(String discussid, String userid)throws Exception;

	int storeDiscuss(String discussid, String userid)throws Exception;

	int findStoreDiscussCountByUserid(int id)throws Exception;

	int addDiscussReply(String discid, String replycontent, String replyerid, String byreplyerid,String disuserid,String replydate)throws Exception;

	String findReplyContent(String discid)throws Exception;

	List<SysDiscussPlus> findThisWeekTopTenDiscuss()throws Exception;

	void addReplyCountBydiscussid(String disuserid)throws Exception;

	List<SysUser> findTopTenReplyUser()throws Exception;

	int deleteDiscussBydiscussId(String discussid)throws Exception;

	int deleteDiscussReplyBydiscussId(String discussid)throws Exception;

	int acceptReplyByrid(String replyid)throws Exception;

	int updateDiscussAcceptStatus(String discussid)throws Exception;

	int findreplyAccept(String replyid)throws Exception;

	int deleteReplyByrid(String replyid)throws Exception;

	void updateDiscussReplyCountMinus(String discussid)throws Exception;

    List<SysReply> findReplyItemByReperid(int replyid)throws Exception;


}
