package com.purple.bbs.ssm.test;

import java.util.ArrayList;
import java.util.List;

import org.junit.Test;

public class BBSTest {

	@Test
	public void Md5Test(){
	    List<String> list=new ArrayList<String>();
	    list.add("保护环境");     //向列表中添加数据
	    list.add("爱护地球");     //向列表中添加数据
	    list.add("从我做起");        //向列表中添加数据
	    list.add(0,"从我做起");     //在第1+1个元素的位置添加数据
	    //通过循环输出列表中的内容
	    for(int i=0;i<list.size();i++){
	     System.out.println(i+":"+list.get(i));
	    }
	   
	}
}
