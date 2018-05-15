<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/fly/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
  <meta charset="utf-8">
  <title>山东紫软档案服务社区</title>
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <meta name="keywords" content="purplesoft,档案社区,AMS社区">
  <meta name="description" content="PurpleSoft社区是基于layui开发的官网档案社区，致力于为客户企业打造一站式帮助社区">
</head>
<body>
<input id="checkisLogin" type="hidden" value = "${sysUser }"/>
<input id = "userid" type ="hidden" value="${sysUser.id }">
<div class="fly-header layui-bg-black">
  <div class="layui-container">
    <a class="fly-logo" href="">
      <img src="/PurpleSoftBBS/fly-3.0/res/images/logo1.png" alt="purpleSoft">
    </a>
    <ul class="layui-nav fly-nav layui-hide-xs">
      <li class="layui-nav-item layui-this">
        <a href="javascript:;"><i class="iconfont icon-jiaoliu"></i>交流</a>
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
              <a href="gomessage.action">消息<span name="message" class="layui-badge"></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
            </li>
            
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

<div class="fly-panel fly-column">
  <div class="layui-container">
    <ul class="layui-clear">
      <li class="layui-hide-xs layui-this"><a href="javascript:;">首页</a></li> 
      <li><a href="index.action?classestype=question">提问</a></li> 
      <li><a href="index.action?classestype=share">分享<span class="layui-badge-dot"></span></a></li> 
      <li><a href="index.action?classestype=discussion">讨论</a></li> 
      <li><a href="index.action?classestype=suggest">建议</a></li> 
      <li><a href="index.action?classestype=notice">公告</a></li> 
      <li><a href="index.action?classestype=news">动态</a></li> 
      
      <c:if test="${sysUser !=null }">
      	<!-- 用户登入后显示 -->
      	<li class="layui-hide-xs layui-hide-sm layui-show-md-inline-block"><span class="fly-mid"></span></li> 
        <li class="layui-hide-xs layui-hide-sm layui-show-md-inline-block"><a href="gousercenter.action">我发表的贴</a></li> 
        <li class="layui-hide-xs layui-hide-sm layui-show-md-inline-block"><a href="gousercenter.action?flag=collection">我收藏的贴</a></li> 
      </c:if>
      
    </ul> 
    <div class="fly-column-right layui-hide-xs">
        <span class="fly-search"><i class="layui-icon"></i></span>
        <c:if test="${sysUser !=null }">
        <a href="goadd.action" class="layui-btn">发表新帖</a>
        </c:if>
    </div>
    <c:if test="${sysUser !=null }">
        <!-- 用户登入后显示 -->
		
		<div class="layui-hide-sm layui-show-xs-block" style="margin-top: -10px; padding-bottom: 10px; text-align: center;">
			<a href="goadd.action" class="layui-btn">发表新帖</a>
		</div>
	</c:if>
  </div>
</div>

<div class="layui-container">
  <div class="layui-row layui-col-space15">
    <div class="layui-col-md8">
      <div class="fly-panel">
        <div class="fly-panel-title fly-filter">
          <a>置顶</a>
          <!-- <a href="#signin" class="layui-hide-sm layui-show-xs-block fly-right" id="LAY_goSignin" style="color: #FF5722;">去签到</a> -->
        </div>
        <ul class="fly-list">
           <c:forEach var="best" items="${bestDiscuss }">
        		<li>
		            <a href="gohome.action?userid=${best.userid }" class="fly-avatar">
		              <img src="/pic/${best.icon }">
		            </a>
		            <h2>
		              <a class="layui-badge">${best.name }</a>
		              <a href="detail.action?discussid=${best.discussid }">${best.title }</a>
		            </h2>
		            <div class="fly-list-info">
		              <a href="gohome.action?userid=${best.userid }" link>
		                <cite>${best.username }</cite>
		                <c:if test="${!empty best.authentication }">
		                  <i class="iconfont icon-renzheng" title="${best.authentication }"></i>
                          <i class="layui-badge fly-badge-vip">${best.authenticatelevel }</i>
		                </c:if>
		                
		              </a>
		              <span name="publishDate" time="<fmt:formatDate value="${best.publishDate }" pattern="yyyy-MM-dd HH:mm:ss"/>"></span>
		              
		              <span class="fly-list-kiss layui-hide-xs" title="悬赏飞吻"><i class="iconfont icon-kiss"></i> ${best.reward }</span>
		              <span class="layui-badge fly-badge-accept layui-hide-xs"><c:if test="${best.discussstatus ==0 }">未结</c:if><c:if test="${best.discussstatus ==1 }">已结</c:if></span>
		              <span class="fly-list-nums"> 
		                <i class="iconfont icon-pinglun1" title="回答"></i> ${best.replyCount }
		              </span>
		            </div>
		            <div class="fly-list-badge">
		              <c:if test="${best.best == 1 }">
                        <span class="layui-badge layui-bg-red">精帖</span>
                      </c:if>
                      <c:if test="${best.topStatus == 1 }">
                        <span class="layui-badge layui-bg-black">置顶</span>
                      </c:if>
		            </div>
		          </li>
           </c:forEach>
          
        </ul>
      </div>
<!-----------------------------------------------------------------------------------------------------------  -->
      <div class="fly-panel " style="margin-bottom: 0;">
        
        <div class="fly-panel-title fly-filter">
          <a href="index.action?status=2" class="layui-this">综合</a>
          <span class="fly-mid"></span>
          <a href="index.action?status=0">未结</a>
          <span class="fly-mid"></span>
          <a href="index.action?status=1">已结</a>
          <span class="fly-mid"></span>
          <a href="index.action?best=1">精华</a>
          <!-- <span class="fly-filter-right layui-hide-xs">
            <a href="index.action" class="layui-this">按最新</a>
            <span class="fly-mid"></span>
            <a href="">按热议</a>
          </span> -->
        </div>

        <ul class="fly-list">          
          <c:forEach var="topTwenty" items="${topTwentyDiscuss }">
        		<li>
		            <a href="gohome.action?userid=${topTwenty.userid }" class="fly-avatar">
		              <img src="/pic/${topTwenty.icon }">
		            </a>
		            <h2>
		              <a class="layui-badge">${topTwenty.name }</a>
		              <a href="detail.action?discussid=${topTwenty.discussid }">${topTwenty.title }</a>
		            </h2>
		            <div class="fly-list-info">
		              <a href="gohome.action?userid=${topTwenty.userid }" link>
		                <cite>${topTwenty.username }</cite>
		                <c:if test="${!empty topTwenty.authentication }">
		                  <i class="iconfont icon-renzheng" title="${topTwenty.authentication }"></i>
                          <i class="layui-badge fly-badge-vip">${topTwenty.authenticatelevel }</i>
		                </c:if>
		              </a>
		              <span name="publishDate" time="<fmt:formatDate value="${topTwenty.publishDate }" pattern="yyyy-MM-dd HH:mm:ss"/>"></span>
		              
		              <span class="fly-list-kiss layui-hide-xs" title="悬赏飞吻"><i class="iconfont icon-kiss"></i> ${topTwenty.reward }</span>
		              <span class="layui-badge fly-badge-accept layui-hide-xs"><c:if test="${topTwenty.discussstatus ==0 }">未结</c:if><c:if test="${topTwenty.discussstatus ==1 }">已结</c:if></span>
		              <span class="fly-list-nums"> 
		                <i class="iconfont icon-pinglun1" title="回答"></i> ${topTwenty.replyCount }
		              </span>
		            </div>
		            <div class="fly-list-badge">
		              <c:if test="${topTwenty.best == 1 }">
                        <span class="layui-badge layui-bg-red">精帖</span>
                      </c:if>
                      <c:if test="${topTwenty.topStatus == 1 }">
                        <span class="layui-badge layui-bg-black">置顶</span>
                      </c:if>
		            </div>
		          </li>
           </c:forEach>
        </ul>
        <div style="text-align: center">
          <div class="laypage-main">
            <a href="index.action?status=2" class="laypage-next">更多求解</a>
          </div>
        </div>

      </div>
    </div>
    <div class="layui-col-md4">

      <div class="fly-panel">
        <h3 class="fly-panel-title">温馨通道</h3>
        <ul class="fly-panel-main fly-list-static">
          <li>
            <a href="javascript:;" target="_blank">欢迎推荐</a>
          </li>
        </ul>
      </div>


     <%-- <c:if test="${! empty sysUser }">
          <div class="fly-panel fly-signin">
        <div class="fly-panel-title">
          签到
          <i class="fly-mid"></i> 
          <a href="javascript:;" class="fly-link" id="LAY_signinHelp">签到说明</a>
          <!-- <i class="fly-mid"></i> 
          <a href="javascript:;" class="fly-link" id="LAY_signinTop">活跃榜<span class="layui-badge-dot"></span></a> -->
          <span class="fly-signin-days">已连续签到<cite>16</cite>天</span>
        </div>
        <div class="fly-panel-main fly-signin-main">
          <button class="layui-btn layui-btn-danger" id="LAY_signin">今日签到</button>
          <!-- <span>可获得<cite>5</cite>飞吻</span> -->
          
          <!-- 已签到状态 -->
          <!--
          <button class="layui-btn layui-btn-disabled">今日已签到</button>
          <span>获得了<cite>20</cite>飞吻</span>
          -->
        </div>
      </div>
     </c:if> --%>

      <div class="fly-panel fly-rank fly-rank-reply" id="LAY_replyRank">
        <h3 class="fly-panel-title">回贴榜</h3>
        <dl>
          <!--<i class="layui-icon fly-loading">&#xe63d;</i>-->
          <c:forEach var="item" items="${replyTopTenUser }">
          	<dd>
             <a href="gohome.action?userid=${item.id }">
               <img src="/pic/${item.icon }"><cite>${item.username }</cite><i>${item.myreplaycount }次回答</i>
             </a>
           </dd>
          </c:forEach>
        </dl>
      </div>

      <dl class="fly-panel fly-list-one">
        <dt class="fly-panel-title">热议榜</dt>
        <c:if test="${! empty weektopten }">
        	<c:forEach var = "item" items="${weektopten }">
        		<dd>
		          <a href="detail.action?discussid=${item.discussid }"">${item.title }</a>
		          <span><i class="iconfont icon-pinglun1"></i>${item.replyCount }</span>
		        </dd>
            </c:forEach>
        </c:if>
        <c:if test="${empty weektopten }">
        	 <div class="fly-none">没有相关数据</div>
        </c:if>
      </dl>
      <div class="fly-panel">
        <div class="fly-panel-title">
                           广告区域
        </div>
        <div class="fly-panel-main">
          <a href="" target="_blank" class="fly-zanzhu" time-limit="2017.09.25-2099.01.01" style="background-color: #5FB878;">虚位以待</a>
        </div>
      </div>
      
      <div class="fly-panel fly-link">
        <h3 class="fly-panel-title">友情链接</h3>
        <dl class="fly-panel-main">
          <dd><a href="https://www.oschina.net/" target="_blank">开源中国</a><dd>
          <dd><a href="https://www.beejson.com/" target="_blank">beejson</a><dd>
          <dd><a href="https://gitee.com/explore" target="_blank">码云</a><dd>
          <dd><a href="https://www.csdn.net/" target="_blank">CSDN</a><dd>
          <!-- <dd><a href="mailto:xianxin@layui-inc.com?subject=%E7%94%B3%E8%AF%B7Fly%E7%A4%BE%E5%8C%BA%E5%8F%8B%E9%93%BE" class="fly-link">申请友链</a><dd> -->
        </dl>
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
		base : '/PurpleSoftBBS/fly-3.0/res/mods/' //这里实际使用时，建议改成绝对路径
	}).extend({
		fly : 'index'
	}).use(['fly','layer','jquery'],function(){
		 var fly = layui.fly,layer = layui.layer,$ = layui.jquery;
		 
		 $(function(){  
			 getMessage();
			 var first = sessionStorage.getItem("first");
			 if(first == "" || first ==null){
				 sessionStorage.setItem("first","true")
				 layer.ready(function(){
			            var width = window.screen.width;
			            var height = window.screen.height;
			            var left = width/2-130;
			            var top = height/2-150;
			             //公告
			            /* layer.open({
			              type: 1
			              ,title: false //不显示标题栏
			              ,closeBtn: false
			              ,area: '250px;'
			              ,shade: 0.8
			              ,offset:[top,left]
			              ,id: 'LAY_layuipro' //设定一个id，防止重复弹出
			              ,btn: ['火速围观']
			              ,btnAlign: 'c'
			              ,moveType: 1 //拖拽模式，0或者1
			              ,content: '<div style="padding: 50px; line-height: 22px; background-color: #393D49; color: #fff; font-weight: 300;">&nbsp;&nbsp;<span style="font-size:21">社区开放时间</span></br></br></br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style="font-size:20">8:30-17:30</span></div>'
			              ,success: function(layero){
			                var btn = layero.find('.layui-layer-btn');
			                btn.find('.layui-layer-btn0').attr({
			                  href: 'http://www.layui.com/'
			                  ,target: '_blank'
			                }); 
			              }
			            }); */
			        });
			 }
		 });
	});
	
	function getMessage(){
		layui.use(['jquery','layer'],function(){
			var $ = layui.jquery,layer = layui.layer;
			var userid = $('#userid').val();
            if(userid !=null && userid !=''){
                $.ajax({
                    url:'getMessage.action',
                    data:{'userid':userid},
                    type:'post',
                    success:function(result){
                    	
                        $('span[name=message]').html(result);
                        setTimeout(function(){
                            getMessage();
                        }, 20000);
                    }
                });
            }
		})
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
</html>