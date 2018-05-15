package com.purple.bbs.ssm.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.purple.bbs.ssm.pojo.SysClasses;
import com.purple.bbs.ssm.pojo.SysDiscuss;
import com.purple.bbs.ssm.pojo.SysDiscussPlus;
import com.purple.bbs.ssm.pojo.SysProduct;
import com.purple.bbs.ssm.pojo.SysReply;
import com.purple.bbs.ssm.pojo.SysUser;

public interface DiscussMapper {

    List<SysClasses> findClasses()throws Exception;

    List<SysProduct> findProduct()throws Exception;

    int saveDiscuss(@Param(value="sysDiscuss")SysDiscuss sysDiscuss)throws Exception;

	List<SysDiscussPlus> findBestDiscuss()throws Exception;

	List<SysDiscussPlus> findAllDiscuss()throws Exception;

    List<SysDiscussPlus> findTopTwentyDiscuss()throws Exception;

    List<SysDiscussPlus> findtopTwentyOpenDiscuss()throws Exception;

    List<SysDiscussPlus> findtopTwentyCloseDiscuss()throws Exception;

    List<SysDiscussPlus> findtopTwentyBestDiscuss()throws Exception;

    int findOpenDiscussCount()throws Exception;

    int findCloseDiscussCount()throws Exception;

    int findBestDiscussCount()throws Exception;

    List<SysDiscussPlus> findDiscussByPage(@Param("begin")int begin,@Param("pageSize") int pageSize)throws Exception;

	List<SysDiscussPlus> findCloseDiscussByPage(@Param("begin")int begin,@Param("pageSize")int pageSize)throws Exception;

	List<SysDiscussPlus> findOpenDiscussByPage(@Param("begin")int begin,@Param("pageSize")int pageSize)throws Exception;

	List<SysDiscussPlus> findBestDiscussByPage(@Param("begin")int begin,@Param("pageSize")int pageSize)throws Exception;

	int findClassesIdByName(@Param("classestype")String classestype)throws Exception;

	int findAllDiscussCountByClassesId(int classesid)throws Exception;

	int findOpenDiscussCountByClassesId(int classesid)throws Exception;

	int findCloseDiscussCountByClassesId(int classesid)throws Exception;

	int findBestDiscussCountByClassesId(int classesid)throws Exception;

	List<SysDiscussPlus> findClassesDiscussByPage(@Param("begin")int begin,@Param("pageSize")int pageSize,@Param("classesid") int classesid)throws Exception;

	List<SysDiscussPlus> findOpenClassesDiscussByPage(@Param("begin")int begin,@Param("pageSize")int pageSize,@Param("classesid") int classesid)throws Exception;

	List<SysDiscussPlus> findCloseClassesDiscussByPage(@Param("begin")int begin,@Param("pageSize")int pageSize,@Param("classesid") int classesid)throws Exception;

	List<SysDiscussPlus> findBestClassesDiscussByPage(@Param("begin")int begin,@Param("pageSize")int pageSize,@Param("classesid") int classesid)throws Exception;

    SysDiscussPlus findDiscussDetailByDiscussId(String discussid)throws Exception;

    void addDiscussReadCountByDiscussId(@Param("discussid")String discussid)throws Exception;

    int findReadCountByDiscussId(String discussid)throws Exception;

	int findDiscussCountByUserid(int id)throws Exception;

	int updateDiscussByDiscussId(@Param("discussid")int discussid,@Param("sysDiscuss")SysDiscuss sysDiscuss)throws Exception;

	List<SysDiscuss> findTopTenQuestionDiscussByUserid(int id)throws Exception;

	int findIsStoreDiscuss(@Param("discussid")String discussid, @Param("userid")String userid)throws Exception;

	int storeDiscuss(@Param("discussid")String discussid, @Param("userid")String userid)throws Exception;

	int findStoreDiscussCountByUserid(int id)throws Exception;

	int addDiscussReply(@Param("discid")String discid,@Param("replycontent") String replycontent
			, @Param("replyerid")String replyerid,@Param("byreplyerid") String byreplyerid
			,@Param("disuserid")String disuserid,@Param("replydate")String replydate)throws Exception;

	List<SysReply> findReplyContent(String discid)throws Exception;

	List<SysDiscussPlus> findThisWeekTopTenDiscuss()throws Exception;

	void addReplyCountBydiscussid(String disuserid)throws Exception;

	List<SysUser> findTopTenReplyUser()throws Exception;

	int deleteDiscussBydiscussId(String discussid)throws Exception;

	int deleteDiscussReplyBydiscussId(String discussid)throws Exception;

	int acceptReplyByrid(String replyid)throws Exception;

	int updateDiscussAcceptStatus(String discussid)throws Exception;

	int deleteReplyByrid(String replyid)throws Exception;

	int findreplyAccept(String replyid)throws Exception;

	void updateDiscussReplyCountMinus(String discussid)throws Exception;

    List<SysReply> findReplyItemByReperid(int replyid)throws Exception;

}
