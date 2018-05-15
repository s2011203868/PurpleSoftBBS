<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/fly/common/common.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>发表新帖 - 紫软社区</title>
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
    </ul>
  </div>
</div>

<div class="layui-container fly-marginTop">
  <div class="fly-panel" pad20 style="padding-top: 5px;">
    <!--<div class="fly-none">没有权限</div>-->
    <div class="layui-form layui-form-pane">
      <div class="layui-tab layui-tab-brief" lay-filter="user">
        <ul class="layui-tab-title">
          <li class="layui-this">发表新帖<!-- 编辑帖子 --></li>
        </ul>
        <div class="layui-form layui-tab-content" id="LAY_ucm" style="padding: 20px 0;">
          <div class="layui-tab-item layui-show">
            <form action="" method="post">
              <div class="layui-row layui-col-space15 layui-form-item">
                <div class="layui-col-md3">
                  <label class="layui-form-label">所在专栏</label>
                  <div class="layui-input-block">
                    <select lay-verify="required" name="classesid" lay-filter="classesselect"> 
                       <option value=""></option> 
                       <c:forEach var="item" items="${classes }">
                        <option value="${item.id}">${item.name }</option> 
                       </c:forEach>
                       
                    </select>
                  </div>
                </div>
                <div class="layui-col-md9">
                  <label for="L_title" class="layui-form-label">标题</label>
                  <div class="layui-input-block">
                    <input type="text" id="L_title" name="title" required lay-verify="required" autocomplete="off" class="layui-input">
                    <!-- <input type="hidden" name="id" value="{{d.edit.id}}"> -->
                  </div>
                </div>
              </div>
              <div class="layui-row layui-col-space15 layui-form-item" id="LAY_quiz">
                <div class="layui-col-md3">
                  <label class="layui-form-label">所属产品</label>
                  <div class="layui-input-block">
                    <select required lay-verify="required" name="productid">
                      <option value=""></option>
                      <c:forEach var="item" items="${product }">
                        <option value="${item.id}">${item.name }</option> 
                       </c:forEach>
                    </select>
                  </div>
                </div>
                <div class="layui-col-md3">
                  <label class="layui-form-label" for="L_version">版本号</label>
                  <div class="layui-input-block">
                    <input type="text" id="L_version" value="" name="version" autocomplete="off" class="layui-input">
                  </div>
                </div>
                <div class="layui-col-md6">
                  <label class="layui-form-label" for="L_browser">浏览器</label>
                  <div class="layui-input-block">
                    <input type="text" id="L_browser"  value="" name="browser" placeholder="浏览器名称及版本，如：IE 11" autocomplete="off" class="layui-input">
                  </div>
                </div>
              </div>
              <div class="layui-form-item layui-form-text">
                <div class="layui-input-block">
                  <textarea id="L_content" name="content" required lay-verify="required" placeholder="详细描述" class="layui-textarea fly-editor" style="height: 260px;"></textarea>
                </div>
              </div>
              <div class="layui-form-item">
                <div class="layui-inline">
                  <label class="layui-form-label">悬赏飞吻</label>
                  <div class="layui-input-inline" style="width: 190px;">
                    <select name="reward">
                      <option value="10">10</option>
                      <option value="20">20</option>
                      <option value="30">30</option>
                      <option value="40">40</option>
                      <option value="50">50</option>
                    </select>
                  </div>
                  <div class="layui-form-mid layui-word-aux">发表后无法更改飞吻</div>
                </div>
              </div>
              <div class="layui-form-item">
                <label for="L_vercode" class="layui-form-label">人类验证</label>
                <div class="layui-input-inline">
                  <input type="text" id="L_vercode" name="randomcode" required lay-verify="required" placeholder="请输入验证码" autocomplete="off" class="layui-input">
                  <input type="hidden" id ="hiddenUser" name="userid" value="${sysUser.id }"/>
                </div>
                <div class="layui-form-mid">
                  <img onclick="javascript:randomcode_refresh()" id="randomcode_img" src="/PurpleSoftBBS/fly-3.0/volidatecode/validatecode.jsp" alt="" style="cursor:pointer;width:56;height:30; align:'absMiddle'" /> 
                </div>
              </div>
              <div class="layui-form-item">
                <button class="layui-btn" type="button" lay-filter="publishnewdiscuss" lay-submit>立即发布</button>
              </div>
            </form>
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
		version : "3.0.0",
		base : '/PurpleSoftBBS/fly-3.0/res/mods/'
	}).extend({
		fly : 'index'
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
	
	function randomcode_refresh() {  
	    var img = document.getElementById("randomcode_img");  
	    img.src = "/PurpleSoftBBS/fly-3.0/volidatecode/validatecode.jsp?a=" + new Date().getTime();  
	} 
</script>

</body>
</html>