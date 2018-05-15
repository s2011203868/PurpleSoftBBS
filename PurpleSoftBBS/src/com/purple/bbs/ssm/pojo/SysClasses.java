package com.purple.bbs.ssm.pojo;

import java.io.Serializable;

public class SysClasses implements Serializable{

    // @Fields serialVersionUID : TODO(用一句话描述这个变量表示什么) 
    private static final long serialVersionUID = 1L;
    private int id;
    private String name;
    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public SysClasses() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    
}
