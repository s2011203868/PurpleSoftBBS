package com.purple.bbs.ssm.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.purple.bbs.ssm.mapper.DiscussMapper;
import com.purple.bbs.ssm.pojo.SysClasses;
import com.purple.bbs.ssm.pojo.SysDiscuss;
import com.purple.bbs.ssm.pojo.SysDiscussPlus;
import com.purple.bbs.ssm.pojo.SysProduct;
import com.purple.bbs.ssm.pojo.SysReply;
import com.purple.bbs.ssm.pojo.SysUser;
import com.purple.bbs.ssm.service.DiscussService;

import net.sf.json.JSONArray;

public class DiscussServiceImpl implements DiscussService{

    @Autowired
    DiscussMapper discussMapper;
    
    @Override
    public List<SysClasses> findClasses() throws Exception {
        List<SysClasses> list = discussMapper.findClasses();
        return list;
    }

    @Override
    public List<SysProduct> findProduct() throws Exception {
        List<SysProduct> list = discussMapper.findProduct();
        return list;
    }

    @Override
    public int saveDiscuss(SysDiscuss sysDiscuss) throws Exception {
        int n = discussMapper.saveDiscuss(sysDiscuss);
        return n;
    }

	@Override
	public List<SysDiscussPlus> findBestDiscuss() throws Exception {
		List<SysDiscussPlus> list = discussMapper.findBestDiscuss();
		return list;
	}

	@Override
	public List<SysDiscussPlus> findAllDiscuss() throws Exception {
		List<SysDiscussPlus> list = discussMapper.findAllDiscuss();
		return list;
	}

    @Override
    public List<SysDiscussPlus> findtopTwentyDiscuss() throws Exception {
        List<SysDiscussPlus> list = discussMapper.findTopTwentyDiscuss();
        return list;
    }

    @Override
    public List<SysDiscussPlus> findtopTwentyOpenDiscuss() throws Exception {
        List<SysDiscussPlus> list = discussMapper.findtopTwentyOpenDiscuss();
        return list;
    }

    @Override
    public List<SysDiscussPlus> findtopTwentyCloseDiscuss() throws Exception {
        List<SysDiscussPlus> list = discussMapper.findtopTwentyCloseDiscuss();
        return list;
    }

    @Override
    public List<SysDiscussPlus> findtopTwentyBestDiscuss() throws Exception {
        List<SysDiscussPlus> list = discussMapper.findtopTwentyBestDiscuss();
        return list;
    }

    @Override
    public int findOpenDiscussCount() throws Exception {
        int n = discussMapper.findOpenDiscussCount();
        return n;
    }

    @Override
    public int findCloseDiscussCount() throws Exception {
        int n = discussMapper.findCloseDiscussCount();
        return n;
    }

    @Override
    public int findBestDiscussCount() throws Exception {
        int n = discussMapper.findBestDiscussCount();
        return n;
    }

    @Override
    public String findDiscussByPage(String curr, String limit) throws Exception {
        int begin = (Integer.parseInt(curr)-1)*(Integer.parseInt(limit));
        int pageSize = Integer.parseInt(limit);
        List<SysDiscussPlus> discussPlusList = discussMapper.findDiscussByPage(begin,pageSize);
        String json = JSON.toJSONString(discussPlusList,SerializerFeature.DisableCircularReferenceDetect,SerializerFeature.WriteDateUseDateFormat); 
        return json;
    }

	@Override
	public String findCloseDiscussByPage(String curr, String limit) throws Exception {
		int begin = (Integer.parseInt(curr)-1)*(Integer.parseInt(limit));
        int pageSize = Integer.parseInt(limit);
        List<SysDiscussPlus> discussPlusList = discussMapper.findCloseDiscussByPage(begin,pageSize);
        String json = JSON.toJSONString(discussPlusList,SerializerFeature.DisableCircularReferenceDetect,SerializerFeature.WriteDateUseDateFormat); 
		return json;
	}

	@Override
	public String findOpenDiscussByPage(String curr, String limit) throws Exception {
		int begin = (Integer.parseInt(curr)-1)*(Integer.parseInt(limit));
        int pageSize = Integer.parseInt(limit);
        List<SysDiscussPlus> discussPlusList = discussMapper.findOpenDiscussByPage(begin,pageSize);
        String json = JSON.toJSONString(discussPlusList,SerializerFeature.DisableCircularReferenceDetect,SerializerFeature.WriteDateUseDateFormat); 
		return json;
	}

	@Override
	public String findBestDiscussByPage(String curr, String limit) throws Exception {
		int begin = (Integer.parseInt(curr)-1)*(Integer.parseInt(limit));
        int pageSize = Integer.parseInt(limit);
        List<SysDiscussPlus> discussPlusList = discussMapper.findBestDiscussByPage(begin,pageSize);
        String json = JSON.toJSONString(discussPlusList,SerializerFeature.DisableCircularReferenceDetect,SerializerFeature.WriteDateUseDateFormat); 
		return json;
	}

	@Override
	public int findClassesIdByName(String classestype) throws Exception {
		int n = discussMapper.findClassesIdByName(classestype);
		return n;
	}

	@Override
	public int findAllDiscussCountByClassesId(int classesid) throws Exception {
		int n = discussMapper.findAllDiscussCountByClassesId(classesid);
		return n;
	}

	@Override
	public int findOpenDiscussCountByClassesId(int classesid) throws Exception {
		int n = discussMapper.findOpenDiscussCountByClassesId(classesid);
		return n;
	}

	@Override
	public int findCloseDiscussCountByClassesId(int classesid) throws Exception {
		int n = discussMapper.findCloseDiscussCountByClassesId(classesid);
		return n;
	}

	@Override
	public int findBestDiscussCountByClassesId(int classesid) throws Exception {
		int n = discussMapper.findBestDiscussCountByClassesId(classesid);
		return n;
	}

	@Override
	public String findClassesDiscussByPage(String curr, String limit, int classesid) throws Exception {
		int begin = (Integer.parseInt(curr)-1)*(Integer.parseInt(limit));
        int pageSize = Integer.parseInt(limit);
        List<SysDiscussPlus> discussPlusList = discussMapper.findClassesDiscussByPage(begin,pageSize,classesid);
        String json = JSON.toJSONString(discussPlusList,SerializerFeature.DisableCircularReferenceDetect,SerializerFeature.WriteDateUseDateFormat); 
		return json;
	}

	@Override
	public String findOpenClassesDiscussByPage(String curr, String limit, int classesid) throws Exception {
		int begin = (Integer.parseInt(curr)-1)*(Integer.parseInt(limit));
        int pageSize = Integer.parseInt(limit);
        List<SysDiscussPlus> discussPlusList = discussMapper.findOpenClassesDiscussByPage(begin,pageSize,classesid);
        String json = JSON.toJSONString(discussPlusList,SerializerFeature.DisableCircularReferenceDetect,SerializerFeature.WriteDateUseDateFormat); 
		return json;
	}

	@Override
	public String findCloseClassesDiscussByPage(String curr, String limit, int classesid) throws Exception {
		int begin = (Integer.parseInt(curr)-1)*(Integer.parseInt(limit));
        int pageSize = Integer.parseInt(limit);
        List<SysDiscussPlus> discussPlusList = discussMapper.findCloseClassesDiscussByPage(begin,pageSize,classesid);
        String json = JSON.toJSONString(discussPlusList,SerializerFeature.DisableCircularReferenceDetect,SerializerFeature.WriteDateUseDateFormat); 
		return json;
	}

	@Override
	public String findBestClassesDiscussByPage(String curr, String limit, int classesid) throws Exception {
		int begin = (Integer.parseInt(curr)-1)*(Integer.parseInt(limit));
        int pageSize = Integer.parseInt(limit);
        List<SysDiscussPlus> discussPlusList = discussMapper.findBestClassesDiscussByPage(begin,pageSize,classesid);
        String json = JSON.toJSONString(discussPlusList,SerializerFeature.DisableCircularReferenceDetect,SerializerFeature.WriteDateUseDateFormat); 
		return json;
	}

    @Override
    public SysDiscussPlus findDiscussDetailByDiscussId(String discussid) throws Exception {
        SysDiscussPlus discussPlus = discussMapper.findDiscussDetailByDiscussId(discussid);
        return discussPlus;
    }

    @Override
    public void addDiscussReadCountByDiscussId(String discussid) throws Exception {
        discussMapper.addDiscussReadCountByDiscussId(discussid);
        
    }

    @Override
    public int findReadCountByDiscussId(String discussid) throws Exception {
        int count = discussMapper.findReadCountByDiscussId(discussid);
        return count;
    }

	@Override
	public int findDiscussCountByUserid(int id) throws Exception {
		int n = discussMapper.findDiscussCountByUserid(id);
		return n;
	}

	@Override
	public int updateDiscussByDiscussId(int discussid,SysDiscuss sysDiscuss) throws Exception {
		int n = discussMapper.updateDiscussByDiscussId(discussid,sysDiscuss);
		return n;
	}

	@Override
	public List<SysDiscuss> findTopTenQuestionDiscussByUserid(int id) throws Exception {
		List<SysDiscuss> list = discussMapper.findTopTenQuestionDiscussByUserid(id);
		return list;
	}

	@Override
	public int findIsStoreDiscuss(String discussid, String userid) throws Exception {
		int n = discussMapper.findIsStoreDiscuss(discussid,userid);
		return n;
	}

	@Override
	public int storeDiscuss(String discussid, String userid) throws Exception {
		int n = discussMapper.storeDiscuss(discussid, userid);
		return n;
	}

	@Override
	public int findStoreDiscussCountByUserid(int id) throws Exception {
		int n = discussMapper.findStoreDiscussCountByUserid(id);
		return n;
	}

	@Override
	public int addDiscussReply(String discid, String replycontent, String replyerid, String byreplyerid,String disuserid,String replydate)
			throws Exception {
		int n = discussMapper.addDiscussReply(discid,replycontent,replyerid,byreplyerid,disuserid,replydate);
		return n;
	}

	@Override
	public String findReplyContent(String discid) throws Exception {
		List<SysReply> replies = discussMapper.findReplyContent(discid);
		String json = JSON.toJSONString(replies,SerializerFeature.DisableCircularReferenceDetect,SerializerFeature.WriteDateUseDateFormat); 
		return json;
	}

	@Override
	public List<SysDiscussPlus> findThisWeekTopTenDiscuss() throws Exception {
		List<SysDiscussPlus> discussPluss = discussMapper.findThisWeekTopTenDiscuss();
		return discussPluss;
	}

	@Override
	public void addReplyCountBydiscussid(String disuserid) throws Exception {
		discussMapper.addReplyCountBydiscussid(disuserid);
	}

	@Override
	public List<SysUser> findTopTenReplyUser() throws Exception {
		List<SysUser> users = discussMapper.findTopTenReplyUser();
		return users;
	}

	@Override
	public int deleteDiscussBydiscussId(String discussid) throws Exception {
		int n = discussMapper.deleteDiscussBydiscussId(discussid);
		return n;
	}

	@Override
	public int deleteDiscussReplyBydiscussId(String discussid) throws Exception {
		int n = discussMapper.deleteDiscussReplyBydiscussId(discussid);
		return n;
	}

	@Override
	public int acceptReplyByrid(String replyid) throws Exception {
		int n = discussMapper.acceptReplyByrid(replyid);
		return n;
	}

	@Override
	public int updateDiscussAcceptStatus(String discussid) throws Exception {
		int n = discussMapper.updateDiscussAcceptStatus(discussid);
		return n;
	}

	@Override
	public int findreplyAccept(String replyid) throws Exception {
		int n = discussMapper.findreplyAccept(replyid);
		return n;
	}

	@Override
	public int deleteReplyByrid(String replyid) throws Exception {
		int n = discussMapper.deleteReplyByrid(replyid);
		return n;
	}

	@Override
	public void updateDiscussReplyCountMinus(String discussid) throws Exception {
		discussMapper.updateDiscussReplyCountMinus(discussid);
		
	}

    @Override
    public List<SysReply> findReplyItemByReperid(int replyid) throws Exception {
        List<SysReply> replies = discussMapper.findReplyItemByReperid(replyid);
        return replies;
    }

}
