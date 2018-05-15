<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/fly/common/common.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>找回密码/重置密码</title>
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
      
      <c:if test="${sysUser ==null }">
      	  <!-- 未登入的状态 -->
	      <li class="layui-nav-item">
	        <a class="iconfont icon-touxiang layui-hide-xs" href="javascript:;"></a>
	      </li>
	      <li class="layui-nav-item">
	        <a href="login.action">登入</a>
	      </li>
	      <li class="layui-nav-item">
	        <a href="goregist.action">注册</a>
	      </li>
      </c:if>
      <c:if test="${sysUser !=null }">
	        <!-- 登入后的状态 -->
	      	<li class="layui-nav-item">
	        <a class="fly-nav-avatar" href="gousercenter.action">
	          <cite class="layui-hide-xs">${sysUser.username }</cite>
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
      </c:if>
    </ul>
  </div>
</div>

<div class="layui-container fly-marginTop">
  <div class="fly-panel fly-panel-user" pad20>
    <div class="layui-tab layui-tab-brief" lay-filter="user">
      <ul class="layui-tab-title">
        <li><a href="login.action">登入</a></li>
        <c:if test="${flagPassword eq 'forget' }">
        	<li class="layui-this">找回密码</li>
        </c:if>
        <c:if test="${flagPassword eq 'reset' }">
        	<li class="layui-this">重置密码</li>
        </c:if>
      </ul>
      <div class="layui-form layui-tab-content" id="LAY_ucm" style="padding: 20px 0;">
        <c:if test="${! empty emailMessage }">
            <div class="fly-msg">亲爱的${email } 用户,${emailMessage }</div>
        </c:if>
        <div class="layui-tab-item layui-show">
        	<!--找回密码  -->
           <c:if test="${flagPassword eq 'forget' }">
          	<div class="layui-form layui-form-pane">
            <form method="post">
              <div class="layui-form-item">
                <label for="L_email" class="layui-form-label">邮箱</label>
                <div class="layui-input-inline">
                  <input type="text" id="L_email" name="email" required lay-verify="required" autocomplete="off" class="layui-input">
                </div>
              </div>
              <div class="layui-form-item">
                <label for="L_vercode" class="layui-form-label">人类验证</label>
                <div class="layui-input-inline">
                  <input type="text" id="L_vercode" name="randomcode" required lay-verify="required" placeholder="请输入验证码" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-form-mid">
                  <img onclick="javascript:randomcode_refresh()" id="randomcode_img" src="/PurpleSoftBBS/fly-3.0/volidatecode/validatecode.jsp" alt="" style="cursor:pointer;width:56;height:30; align:'absMiddle'" /> 
                </div>
              </div> 
              <div class="layui-form-item">
                <button class="layui-btn" type="button" lay-filter="sendMailFindPassword" lay-submit>提交</button>
              </div>
            </form>
          </div>
          </c:if>
          <!-- 重置密码 -->
          <c:if test="${flagPassword eq 'reset' }">
	          <div class="fly-msg">${email }，请重置您的密码</div>
	          <div class="layui-form layui-form-pane"  style="margin-top: 30px;">
	            <form method="post">
	              <div class="layui-form-item">
	                <label for="L_pass" class="layui-form-label">密码</label>
	                <div class="layui-input-inline">
	                  <input type="password" id="L_pass" name="pass" required lay-verify="required" autocomplete="off" class="layui-input">
	                  <input type="hidden" id="L_email" name="email">
	                </div>
	                <div class="layui-form-mid layui-word-aux">6到16个字符</div>
	              </div>
	              <div class="layui-form-item">
	                <label for="L_repass" class="layui-form-label">确认密码</label>
	                <div class="layui-input-inline">
	                  <input type="password" id="L_repass" name="repass" required lay-verify="required" autocomplete="off" class="layui-input">
	                </div>
	              </div>
	              <div class="layui-form-item">
                  <label for="L_vercode" class="layui-form-label">人类验证</label>
					<div class="layui-input-inline">
						<input type="text" id="L_vercode" name="randomcode" required
							lay-verify="required" placeholder="请输入验证码"
							autocomplete="off" class="layui-input">
					</div>
					<div class="layui-form-mid">
						<img onclick="javascript:randomcode_refresh()"
							id="randomcode_img"
							src="/PurpleSoftBBS/fly-3.0/volidatecode/validatecode.jsp"
							alt=""
							style="cursor: pointer; width: 56; height: 30; align: 'absMiddle'" />
					</div>
				  </div>
	              <div class="layui-form-item">
	                <input type="hidden" name="email" value="${email }">
	                <button class="layui-btn" type="button" lay-filter="replacepassword" lay-submit>提交</button>
	              </div>
	            </form>
	          </div>
          </c:if>
        </div>
      </div>
    </div>
  </div>
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

function randomcode_refresh() {  
    var img = document.getElementById("randomcode_img");  
    img.src = "/PurpleSoftBBS/fly-3.0/volidatecode/validatecode.jsp?a=" + new Date().getTime();  
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