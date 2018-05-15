<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/fly/common/common.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>帐号设置</title>
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <meta name="keywords" content="fly,layui,前端社区">
  <meta name="description" content="Fly社区是模块化前端UI框架Layui的官网社区，致力于为web开发提供强劲动力">
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
        <a href="index.jsp"><i class="iconfont icon-jiaoliu"></i>交流</a>
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
	          <img id="mytouxiang" src="/pic/${sysUser.icon }">
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

<div class="layui-container fly-marginTop fly-user-main">
  <ul class="layui-nav layui-nav-tree layui-inline" lay-filter="user">
    <li class="layui-nav-item">
      <a href="gohome.action">
        <i class="layui-icon">&#xe609;</i>
        我的主页
      </a>
    </li>
    <li class="layui-nav-item">
      <a href="gousercenter.action">
        <i class="layui-icon">&#xe612;</i>
        用户中心
      </a>
    </li>
    <li class="layui-nav-item layui-this">
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
      <ul class="layui-tab-title" id="LAY_mine">
        <li class="layui-this" lay-id="info">我的资料</li>
        <li lay-id="avatar">头像</li>
        <li lay-id="pass">密码</li>
        <li lay-id="bind">帐号绑定</li>
      </ul>
      <div class="layui-tab-content" style="padding: 20px 0;">
        <div class="layui-form layui-form-pane layui-tab-item layui-show">
          <form method="post">
            <div class="layui-form-item">
              <label for="L_email" class="layui-form-label">邮箱</label>
              <div class="layui-input-inline">
                <input type="text" id="L_email" readonly="" name="email" required lay-verify="email" autocomplete="off" value="${sysUser.email }" class="layui-input">
                <input type="hidden" name="userid" value="${sysUser.id }">
              </div>
              <c:if test="${sysUser.activate == 0 }">
                <div class="layui-form-mid layui-word-aux">您尚未激活，请<a href="goactivate.action" style="font-size: 12px; color: #4f99cf;">激活邮箱</a>，以便找回密码。</div>
              </c:if>
            </div>
            <div class="layui-form-item">
              <label for="L_username" class="layui-form-label">昵称</label>
              <div class="layui-input-inline">
                <input type="text" id="L_username" name="username" required lay-verify="required" autocomplete="off" value="${sysUser.username }" class="layui-input">
              </div>
              <div class="layui-inline">
                <div class="layui-input-inline">
                  <c:if test="${sysUser.sex == 0 }">
                  	<input type="radio" name="sex" value="0" checked title="男">
                    <input type="radio" name="sex" value="1" title="女">
                  </c:if>
                  <c:if test="${sysUser.sex == 1 }">
                  	<input type="radio" name="sex" value="0"  title="男">
                    <input type="radio" name="sex" value="1" checked title="女">
                  </c:if>
                </div>
              </div>
            </div>
            <div class="layui-form-item">
              <label for="L_city" class="layui-form-label">城市</label>
              <div class="layui-input-inline">
                <input type="text" id="L_city" name="city" autocomplete="off" value="${sysUser.city }" class="layui-input">
              </div>
            </div>
            <div class="layui-form-item layui-form-text">
              <label for="L_sign" class="layui-form-label">签名</label>
              <div class="layui-input-block">
                <textarea placeholder="随便写些什么刷下存在感吧" id="L_sign"  name="sign" autocomplete="off" value="" class="layui-textarea" style="height: 80px;">${sysUser.sign }</textarea>
              </div>
            </div>
            <div class="layui-form-item">
              <button class="layui-btn" type="button" key="set-mine" lay-filter="editUserInfo" lay-submit>确认修改</button>
            </div>
          </div>
          
          <div class="layui-form layui-form-pane layui-tab-item">
            <div class="layui-form-item">
              <div class="avatar-add">
                <p>建议尺寸168*168，支持jpg、png、gif，最大不能超过200KB</p>
                <button type="button" class="layui-btn upload-img">
                  <i class="layui-icon">&#xe67c;</i>上传头像
                </button>
                <img id ="touxiangimg" src = "/pic/${sysUser.icon }">
                <span class="loading"></span>
              </div>
            </div>
          </div>
          
          <div class="layui-form layui-form-pane layui-tab-item">
            <form method="post">
              <div class="layui-form-item">
                <label for="L_nowpass" class="layui-form-label">当前密码</label>
                <div class="layui-input-inline">
                  <input type="password" id="L_nowpass" name="nowpass" required lay-verify="required" autocomplete="off" class="layui-input">
                </div>
              </div>
              <div class="layui-form-item">
                <label for="L_pass" class="layui-form-label">新密码</label>
                <div class="layui-input-inline">
                  <input type="hidden"name="email" value="${sysUser.email }">
                  <input type="password" id="L_pass" name="pass" required lay-verify="required|pass" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-form-mid layui-word-aux">6到16个字符</div>
              </div>
              <div class="layui-form-item">
                <label for="L_repass" class="layui-form-label">确认密码</label>
                <div class="layui-input-inline">
                  <input type="password" id="L_repass" name="repass" required lay-verify="required|repass" autocomplete="off" class="layui-input">
                </div>
              </div>
              <div class="layui-form-item">
                <button typle="button" class="layui-btn" key="set-mine" lay-filter="replacepassword" lay-submit>确认修改</button>
              </div>
            </form>
          </div>
		  <input type="hidden" id ="hiddenUser" value="${sysUser.id }"/>
          <div class="layui-form layui-form-pane layui-tab-item">
            <ul class="app-bind">
              <li class="fly-msg app-havebind">
                <span>暂未开放此功能!敬请期待</span>
              </li>
             <!--  <li class="fly-msg app-havebind">
                <i class="iconfont icon-qq"></i>
                <span>已成功绑定，您可以使用QQ帐号直接登录Fly社区，当然，您也可以</span>
                <a href="javascript:;" class="acc-unbind" type="qq_id">解除绑定</a>
                
                <a href="" onclick="layer.msg('正在绑定微博QQ', {icon:16, shade: 0.1, time:0})" class="acc-bind" type="qq_id">立即绑定</a>
                <span>，即可使用QQ帐号登录Fly社区</span>
              </li> -->
              <!-- <li class="fly-msg">
                <i class="iconfont icon-weibo"></i>
                <span>已成功绑定，您可以使用微博直接登录Fly社区，当然，您也可以</span>
                <a href="javascript:;" class="acc-unbind" type="weibo_id">解除绑定</a>
                
                <a href="" class="acc-weibo" type="weibo_id"  onclick="layer.msg('正在绑定微博', {icon:16, shade: 0.1, time:0})" >立即绑定</a>
                <span>，即可使用微博帐号登录Fly社区</span>
              </li> -->
            </ul>
          </div>
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
  version: "2.0.0"
  ,base: '/PurpleSoftBBS/fly-3.0/res/mods/'
}).extend({
  fly: 'index'
}).use('fly');

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