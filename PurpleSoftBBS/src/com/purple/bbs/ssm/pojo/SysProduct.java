package com.purple.bbs.ssm.pojo;

import java.io.Serializable;

public class SysProduct implements Serializable{

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
    public SysProduct() {
        super();
        // TODO Auto-generated constructor stub
    }
    
}
