<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/fly/common/common.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>用户主页</title>
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <meta name="keywords" content="purplesoft,档案社区,AMS社区">
  <meta name="description" content="PurpleSoft社区是基于layui开发的官网档案社区，致力于为客户企业打造一站式帮助社区">
</head>
<body style="margin-top: 65px;">
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

<div class="fly-home fly-panel" style="background-image: url();">
  <img src="/pic/${userMessage.icon }" alt="${userMessage.username }">
  <c:if test="${! empty userMessage.authentication }">
    <i class="iconfont icon-renzheng" title="认证信息：${userMessage.authentication }"></i>
  </c:if>
  <h1>
    ${userMessage.username }
    <c:if test="${userMessage.sex ==0 }">
    	<i class="iconfont icon-nan"></i>
    </c:if>
    <c:if test="${userMessage.sex ==1 }">
    	<i class="iconfont icon-nv"></i>
    </c:if>
    <c:if test="${! empty userMessage.authenticatelevel }">
      <i class="layui-badge fly-badge-vip">${userMessage.authenticatelevel }</i>
    </c:if>
    <c:if test="${userMessage.authentication eq '管理员' }">
    	<span style="color:#c00;">（管理员）</span>
    </c:if>
    <c:if test="${userMessage.kiss >= 500 && userMessage.kiss < 1000  }">
    	<span style="color:#5FB878;">（社区之光）</span>
    </c:if>
    <c:if test="${userMessage.kiss >= 1000 && userMessage.kiss < 1500  }">
        <span style="color:#5FB878;">（中流砥柱）</span>
    </c:if>
    <c:if test="${userMessage.kiss >= 1500 && userMessage.kiss < 2000  }">
        <span style="color:#5FB878;">（社区元老）</span>
    </c:if>
    <c:if test="${userMessage.kiss >= 2000  }">
        <span style="color:#5FB878;">（社区智尊）</span>
    </c:if>
    <c:if test="${userMessage.status == 2 }">
    	<span>（该号已被封）</span>
    </c:if>
  </h1>
    <c:if test="${! empty userMessage.authentication }">
        <p style="padding: 10px 0; color: #5FB878;">认证信息：${userMessage.authentication }</p>
    </c:if>
  <p class="fly-home-info">
    <i class="iconfont icon-kiss" title="飞吻"></i><span style="color: #FF7200;">${userMessage.kiss } 飞吻</span>
    <i class="iconfont icon-shijian"></i><span>${userMessage.registtime}加入</span>
    <i class="iconfont icon-chengshi"></i><span>
    	<c:if test="${! empty userMessage.city }">
    		${userMessage.city }
    	</c:if>
    	<c:if test="${empty userMessage.city }">
    		中国
    	</c:if>
    </span>
  </p>

  <p class="fly-home-sign">${userMessage.sign }</p>

 <!--  <div class="fly-sns" data-user="">
    <a href="javascript:;" class="layui-btn layui-btn-primary fly-imActive" data-type="addFriend">加为好友</a>
    <a href="javascript:;" class="layui-btn layui-btn-normal fly-imActive" data-type="chat">发起会话</a>
  </div> -->

</div>

<div class="layui-container">
  <div class="layui-row layui-col-space15">
    <div class="layui-col-md6 fly-home-jie">
      <div class="fly-panel">
      	<c:if test="${userMessage.username == sysUser.username }">
      		<h3 class="fly-panel-title">我的最近的提问</h3>
      	</c:if>
      	<c:if test="${userMessage.username != sysUser.username }">
      		<h3 class="fly-panel-title">${userMessage.username } 的最近的提问</h3>
      	</c:if>
        <ul class="jie-row">
            <c:if test="${! empty discusses }">
            	<c:forEach var="discuss" items="${discusses }">
        			  <li>
        			  	<c:if test="${discuss.best == 1 }">
        			  		<span class="fly-jing">精</span>
        			  	</c:if>
			            <a href="detail.action?discussid=${discuss.discussid }" class="jie-title"> ${discuss.title }</a>
			            <span name="publishDate" time="<fmt:formatDate value="${discuss.publishDate }" pattern="yyyy-MM-dd HH:mm:ss"/>"></span>
			            <em class="layui-hide-xs">${discuss.readCount }阅/${discuss.replyCount }回复</em>
			          </li>
        	    </c:forEach>
            </c:if>
        	<c:if test="${empty discusses }">
        		<div class="fly-none" style="min-height: 50px; padding:30px 0; height:auto;"><i style="font-size:14px;">没有发表任何求解</i></div>
        	</c:if>
        </ul>
      </div>
    </div>
    
    <div class="layui-col-md6 fly-home-da">
      <div class="fly-panel">
      	<c:if test="${userMessage.username == sysUser.username }">
      		<h3 class="fly-panel-title">我 最近的回答</h3>
      	</c:if>
      	<c:if test="${userMessage.username != sysUser.username }">
      		<h3 class="fly-panel-title">${userMessage.username } 最近的回答</h3>
      	</c:if>
        <ul class="home-jieda">
        <c:if test="${! empty replyItem }">
            <c:forEach var ="item" items="${replyItem }">
                <li>
		           <p>
		             <span name="publishDate" time="<fmt:formatDate value="${item.replydate }" pattern="yyyy-MM-dd HH:mm:ss"/>"></span>
		                                在<a href="detail.action?discussid=${item.discussid }" target="_blank">${item.title }</a>中回答：
		           </p>
		          <div class="home-dacontent" name = "home-dacontent">
		            ${item.replycontent }
		          </div>
		        </li>
            </c:forEach>
        </c:if>
        <c:if test="${empty replyItem }">
            <div class="fly-none" style="min-height: 50px; padding:30px 0; height:auto;"><span>没有回答任何问题</span></div>
        </c:if>
        </ul>
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
}).use(['fly','face'],function(){
	var fly = layui.fly,$ = layui.jquery,face = layui.face;
	$('div[name = "home-dacontent"]').each(function(){
        var othis = $(this), html = othis.html();
        var content =$(this).html();
        othis.html(fly.content(content));
      });
});

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