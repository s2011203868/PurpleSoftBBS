package com.purple.bbs.ssm.pojo;

import java.util.Date;

public class SysMessage extends SysDiscussPlus {

    private int mid;
    private int senderid;
    private int receiverid;
    private int disid;
    private String sendcontent;
    private Date senddate;
    private int readed;
    
    
    public int getMid() {
        return mid;
    }
    public void setMid(int mid) {
        this.mid = mid;
    }
    public int getSenderid() {
        return senderid;
    }
    public void setSenderid(int senderid) {
        this.senderid = senderid;
    }
    public int getReceiverid() {
        return receiverid;
    }
    public void setReceiverid(int receiverid) {
        this.receiverid = receiverid;
    }
    public int getDisid() {
        return disid;
    }
    public void setDisid(int disid) {
        this.disid = disid;
    }
    public String getSendcontent() {
        return sendcontent;
    }
    public void setSendcontent(String sendcontent) {
        this.sendcontent = sendcontent;
    }
    public Date getSenddate() {
        return senddate;
    }
    public void setSenddate(Date senddate) {
        this.senddate = senddate;
    }
    public int getReaded() {
        return readed;
    }
    public void setReaded(int readed) {
        this.readed = readed;
    }
    public SysMessage() {
        super();
        // TODO Auto-generated constructor stub
    }
    
}
