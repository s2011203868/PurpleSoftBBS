package com.purple.bbs.ssm.pojo;

import java.io.Serializable;

public class SysUser implements Serializable {

	// @Fields serialVersionUID : TODO(用一句话描述这个变量表示什么) 
	private static final long serialVersionUID = 1L;
	private int id;
	private String email;
	private String username;
	private String password;
	private String icon;
	private int status;
	private int phone;
	private int sex;
	private String sign;
	private String salt;
	private String registtime;
	private String lastlogintime;
	private String authentication;
	private String authenticatelevel;
	private String city;
	private int activate;
	private String activateToken;
	private String resetToken;
	private int kiss;
	private int myreplaycount;
	
	
	public int getMyreplaycount() {
		return myreplaycount;
	}
	public void setMyreplaycount(int myreplaycount) {
		this.myreplaycount = myreplaycount;
	}
	public int getKiss() {
		return kiss;
	}
	public void setKiss(int kiss) {
		this.kiss = kiss;
	}
	public String getActivateToken() {
		return activateToken;
	}
	public void setActivateToken(String activateToken) {
		this.activateToken = activateToken;
	}
	public String getResetToken() {
		return resetToken;
	}
	public void setResetToken(String resetToken) {
		this.resetToken = resetToken;
	}
	public int getActivate() {
		return activate;
	}
	public void setActivate(int activate) {
		this.activate = activate;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getAuthentication() {
		return authentication;
	}
	public void setAuthentication(String authentication) {
		this.authentication = authentication;
	}
	public String getAuthenticatelevel() {
		return authenticatelevel;
	}
	public void setAuthenticatelevel(String authenticatelevel) {
		this.authenticatelevel = authenticatelevel;
	}
	public int getSex() {
		return sex;
	}
	public void setSex(int sex) {
		this.sex = sex;
	}
	public String getSign() {
		return sign;
	}
	public void setSign(String sign) {
		this.sign = sign;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getIcon() {
		return icon;
	}
	public void setIcon(String icon) {
		this.icon = icon;
	}
	public int getPhone() {
		return phone;
	}
	public void setPhone(int phone) {
		this.phone = phone;
	}
	
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public String getSalt() {
		return salt;
	}
	public void setSalt(String salt) {
		this.salt = salt;
	}
	public String getRegisttime() {
		return registtime;
	}
	public void setRegisttime(String registtime) {
		this.registtime = registtime;
	}
	public String getLastlogintime() {
		return lastlogintime;
	}
	public void setLastlogintime(String lastlogintime) {
		this.lastlogintime = lastlogintime;
	}

	
	public SysUser() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	
}
