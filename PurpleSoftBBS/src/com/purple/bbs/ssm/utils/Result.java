package com.purple.bbs.ssm.utils;
/**
 * @ClassName: ExecuteResult 
 * @Description: 请求响应状态类
 * @author: PurpleSoft@一禅
 * @date: 2018年4月3日 上午9:48:49
 */
public class Result {
	
	public static String json(int statusCode,String message){
		
		return "{\"statusCode\":\""+statusCode+"\",\"message\":\""+message+"\"}";
	}
	
	public static String ok(String message){
		return "{\"statusCode\":\"200\",\"message\":\""+message+"\"}";
	}
	
	public static String error(String message){
		return "{\"statusCode\":\"300\",\"message\":\""+message+"\"}";
	}
	
	public static String uploadOk(String url){
	    return "{\"status\":0,\"msg\":\"上传成功\",\"url\":\""+url+"\"}";
	}
	
	public static String uploadError(){
        return "{\"status\":1,\"msg\":\"上传失败\"}";
    }
	
	public static String timeOutError(String message){
		return "{\"statusCode\":\"301\",\"message\":\""+message+"\"}";
	}
}
