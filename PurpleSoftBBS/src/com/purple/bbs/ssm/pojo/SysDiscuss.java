package com.purple.bbs.ssm.pojo;

import java.util.Date;

public class SysDiscuss{

    private int discussid;
    private int classesid;
    private String title;
    private int productid;
    private String version;
    private String browser;
    private int reward;
    private Date publishDate;
    private int status;
    private int topStatus;
    private int userid;
    private String content;
    private int best;
    private int replyCount;
    private String icon;
    private int readCount;
    private int hasAccept;
    
    
    
    public int getHasAccept() {
		return hasAccept;
	}
	public void setHasAccept(int hasAccept) {
		this.hasAccept = hasAccept;
	}
	public int getReadCount() {
		return readCount;
	}
	public void setReadCount(int readCount) {
		this.readCount = readCount;
	}
	public String getIcon() {
		return icon;
	}
	public void setIcon(String icon) {
		this.icon = icon;
	}
	public int getReplyCount() {
		return replyCount;
	}
	public void setReplyCount(int replyCount) {
		this.replyCount = replyCount;
	}
	public int getBest() {
		return best;
	}
	public void setBest(int best) {
		this.best = best;
	}
	public String getContent() {
        return content;
    }
    public void setContent(String content) {
        this.content = content;
    }
    public int getDiscussid() {
        return discussid;
    }
    public void setDiscussid(int discussid) {
        this.discussid = discussid;
    }
    public int getClassesid() {
        return classesid;
    }
    public void setClassesid(int classesid) {
        this.classesid = classesid;
    }
    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }
    public int getProductid() {
        return productid;
    }
    public void setProductid(int productid) {
        this.productid = productid;
    }
    public String getVersion() {
        return version;
    }
    public void setVersion(String version) {
        this.version = version;
    }
    public String getBrowser() {
        return browser;
    }
    public void setBrowser(String browser) {
        this.browser = browser;
    }
    
    public int getReward() {
        return reward;
    }
    public void setReward(int reward) {
        this.reward = reward;
    }
    public Date getPublishDate() {
        return publishDate;
    }
    public void setPublishDate(Date publishDate) {
        this.publishDate = publishDate;
    }
    public int getStatus() {
        return status;
    }
    public void setStatus(int status) {
        this.status = status;
    }
    public int getTopStatus() {
        return topStatus;
    }
    public void setTopStatus(int topStatus) {
        this.topStatus = topStatus;
    }
    public int getUserid() {
        return userid;
    }
    public void setUserid(int userid) {
        this.userid = userid;
    }
    public SysDiscuss() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    
}
