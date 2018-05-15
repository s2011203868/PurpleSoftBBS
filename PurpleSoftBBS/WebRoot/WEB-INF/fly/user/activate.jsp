<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/fly/common/common.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
 
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>激活邮箱</title>
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <meta name="keywords" content="purplesoft,档案社区,AMS社区">
  <meta name="description" content="PurpleSoft社区是基于layui开发的官网档案社区，致力于为客户企业打造一站式帮助社区">
</head>
<body>
<input id="checkisLogin" type="hidden" value = "${sysUser }"/>
<div class="fly-header layui-bg-black">
  <div class="layui-container">
    <a class="fly-logo" href="index.action">
      <img src="/PurpleSoftBBS/fly-3.0/res/images/logo1.png" alt="layui">
    </a>
    <ul class="layui-nav fly-nav layui-hide-xs">
      <li class="layui-nav-item layui-this">
        <a href="index.action"><i class="iconfont icon-jiaoliu"></i>交流</a>
      </li>
      <!-- <li class="layui-nav-item">
        <a href="gocase.action"><i class="iconfont icon-iconmingxinganli"></i>案例</a>
      </li> -->
    </ul>
    
    <ul class="layui-nav fly-nav-user">
      <!-- 登入后的状态 -->
      	<li class="layui-nav-item">
        <a class="fly-nav-avatar" href="gousercenter.action">
          <cite class="layui-hide-xs" id="usernameid">${sysUser.username }</cite>
          <c:if test="${!empty sysUser.authentication }">
          	<i class="iconfont icon-renzheng layui-hide-xs" title="认证信息：${sysUser.authentication }"></i>
          	<i class="layui-badge fly-badge-vip layui-hide-xs">${sysUser.authenticatelevel }</i>
          </c:if>
          <img src="/pic/${sysUser.icon }">
        </a>
        <dl class="layui-nav-child">
          <dd><a href="goset.action"><i class="layui-icon">&#xe620;</i>基本设置</a></dd>
          <dd><a href="gomessage.action"><i class="iconfont icon-tongzhi" style="top: 4px;"></i>我的消息</a></dd>
          <dd><a href="gohome.action"><i class="layui-icon" style="margin-left: 2px; font-size: 22px;">&#xe68e;</i>我的主页</a></dd>
          <hr style="margin: 5px 0;">
          <dd><a href="logout.action" style="text-align: center;">退出</a></dd>
        </dl>
      </li>
    </ul>
  </div>
</div>

<div class="layui-container fly-marginTop fly-user-main">
  <ul class="layui-nav layui-nav-tree layui-inline" lay-filter="user">
    <li class="layui-nav-item">
      <a href="gohome.action">
        <i class="layui-icon">&#xe609;</i>
        我的主页
      </a>
    </li>
    <li class="layui-nav-item layui-this">
      <a href="gousercenter.action">
        <i class="layui-icon">&#xe612;</i>
        用户中心
      </a>
    </li>
    <li class="layui-nav-item">
      <a href="goset.action">
        <i class="layui-icon">&#xe620;</i>
        基本设置
      </a>
    </li>
    <li class="layui-nav-item">
      <a href="gomessage.action">
        <i class="layui-icon">&#xe611;</i>
        我的消息
      </a>
    </li>
  </ul>

  <div class="site-tree-mobile layui-hide">
    <i class="layui-icon">&#xe602;</i>
  </div>
  <div class="site-mobile-shade"></div>
  
  <div class="site-tree-mobile layui-hide">
    <i class="layui-icon">&#xe602;</i>
  </div>
  <div class="site-mobile-shade"></div>
  
  
  <div class="fly-panel fly-panel-user" pad20>
    <div class="layui-tab layui-tab-brief" lay-filter="user">
      <ul class="layui-tab-title">
        <li class="layui-this">
          激活邮箱
        </li>
      </ul>
      <div class="layui-tab-content" id="LAY_ucm" style="padding: 20px 0;">
        <ul class="layui-form">
        <c:if test="${! empty activateMessage }">
           <div class="fly-msg">亲爱的${sysUser.email } 用户,${activateMessage }</div>
        </c:if>
          <li class="layui-form-li">
            <label for="activate">您的邮箱：</label>
            <span class="layui-form-text">${sysUser.email }
              <c:if test="${sysUser.activate ==0 }">
              	<em style="color:#c00;">（尚未激活）</em>
              </c:if>
              <c:if test="${sysUser.activate ==1 }">
              	  <em style="color:#999;">（已成功激活）</em>
              </c:if>
            </span>
          </li>
          <c:if test="${sysUser.activate == 0 }">
            <li class="layui-form-li" style="margin-top: 20px; line-height: 26px;">
            <div>
              1. 如果您未收到邮件，或激活链接失效，您可以
              <a class="layui-form-a" style="cursor:pointer;color:#4f99cf;" onclick="sendActivateEmail()">重新发送邮件</a>，或者
              <a class="layui-form-a" style="cursor:pointer;color:#4f99cf;" href="goset.action">更换邮箱</a>；
            </div>
            <div>
              2. 如果您始终没有收到 我们发送的邮件，请注意查看您邮箱中的垃圾邮件；
            </div>
            <div>
              3. 如果你实在无法激活邮件，您还可以联系：15554604611@163.com
            </div>
          </li>
          </c:if>
        </ul>
      </div>
    </div>
  </div>
  <div style="display:none" id="emailid">${sysUser.email }</div>
</div>

<div class="fly-footer">
  <p><a href="javascript:;" target="_blank">PurpleSoft社区</a> 2018 &copy; <a href="http://s2011203868.eicp.net:48583/PurpleSoftBBS/" target="_blank">PurpleSoft 所有</a></p>
  <p>
    <a href="javascript:donate();">捐赠赞赏</a>
  </p>
</div>

<script>
layui.config({
  version: "3.0.0"
  ,base: '/PurpleSoftBBS/fly-3.0/res/mods/'
}).extend({
  fly: 'index'
}).use('fly');

function sendActivateEmail(){
	layui.use('layer',function(){
		var $ = layui.$
		,layer = layui.layer
		,email = $('#emailid').html()
		,username = $('#usernameid').html();
	    $.ajax({
	        url:'activateEmail.action',
	        data:{'email':email,'username':username},
	        type:'post',
	        success:function(result){
	        	var height = (window.screen.height)/2;
	            if(result.statusCode == 200){
	            	layer.msg(result.message,{icon:1,offset:height});
	            }else if(result.statusCode == 300){
	            	layer.msg(result.message,{icon:2,offset:height});
	            }
	        },
	        error:function(result){
	        	var height = (window.screen.height)/2;
	            layer.msg(result.message,{icon:0,offset:height});
	        }
	    });
	});
}


function donate(){
	var width = window.screen.width;
	var height = window.screen.height;
	var left = width/2-225;
	var top = height/2-300;
	layui.use('layer',function(){
		var layer = layui.layer;
		layer.open({
	        title: '',
	        offset: [top, left],
	        shadeClose:true,
	        type: 1,
	        area: ['450px', '450px'], //宽高
	        content: '<img src="/PurpleSoftBBS/fly-3.0/res/images/donate.png">'
	    });
	})
}
</script>

</body>
</html>