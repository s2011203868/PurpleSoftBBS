<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/fly/common/common.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
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

<div class="fly-header layui-bg-black">
  <div class="layui-container">
    <a class="fly-logo" href="index.action">
      <img src="/PurpleSoftBBS/fly-3.0/res/images/logo1.png" alt="purpleSoft">
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
	          	<i class="iconfont icon-renzheng layui-hide-xs" title="${sysUser.authentication }"></i>
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
<input type="hidden" name="selectType" value="${selectType }" />
<input type="hidden" name="classesType" value="${classestype }" />
<div class="fly-panel fly-column">
  <div class="layui-container">
    <ul class="layui-clear" name="classesName">
      <li class="layui-hide-xs"><a href="index.action">首页</a></li> 
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
        <li class="layui-hide-xs layui-hide-sm layui-show-md-inline-block"><a href="gousercenter.action#collection">我收藏的贴</a></li> 
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
      <div class="fly-panel" style="margin-bottom: 0;">
        
        <div class="fly-panel-title fly-filter" name="typeName">
          <a href="index.action?status=2&classestype=${classestype }">综合</a>
          <span class="fly-mid"></span>
          <a href="index.action?status=0&classestype=${classestype }">未结</a>
          <span class="fly-mid"></span>
          <a href="index.action?status=1&classestype=${classestype }">已结</a>
          <span class="fly-mid"></span>
          <a href="index.action?best=1&classestype=${classestype }">精华</a>
          <!-- <span class="fly-filter-right layui-hide-xs">
            <a href="" class="layui-this">按最新</a>
            <span class="fly-mid"></span>
            <a href="">按热议</a>
          </span> -->
        </div>

        <ul class="fly-list" id = "discussItem">          
          <%-- <c:forEach var="topTwenty" items="${topTwentyDiscuss }">
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
           </c:forEach> --%>
        </ul>
        
        <!-- <div class="fly-none">没有相关数据</div> -->
    
        <!-- <div style="text-align: center">
          <div class="laypage-main"><span class="laypage-curr">1</span><a href="/jie/page/2/">2</a><a href="/jie/page/3/">3</a><a href="/jie/page/4/">4</a><a href="/jie/page/5/">5</a><span>…</span><a href="/jie/page/148/" class="laypage-last" title="尾页">尾页</a><a href="/jie/page/2/" class="laypage-next">下一页</a></div>
        </div> -->
        <!-- 分页部分 -->
        <div style="text-align: center">
        <div id="jieindexLayPage"></div>
        </div>
      </div>
    </div>
    <div class="layui-col-md4">
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
          <a href="" target="_blank" class="fly-zanzhu" style="background-color: #393D49;">虚席以待</a>
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
  version: "3.0.0"
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

layui.use(['layer','laypage','util'],function(){
	var $ = layui.$,
	layer = layui.layer,
	laypage = layui.laypage,
	util = layui.util;
	selectType();
	selectClasses();
	//选中状态
	function selectType(){
        var type = $("input[name='selectType']").val() ;
        if(type === 'status2'){
            $("div[name ='typeName']").find('a').eq(0).addClass("layui-this")
        }
        if(type === 'status0'){
            $("div[name ='typeName']").find('a').eq(1).addClass("layui-this")
        }
        if(type === 'status1'){
            $("div[name ='typeName']").find('a').eq(2).addClass("layui-this")
        }
        if(type === 'best1'){
            $("div[name ='typeName']").find('a').eq(3).addClass("layui-this")
        }
    }
	//选中类别
	function selectClasses(){
        var classesType = $("input[name='classesType']").val() ;
        if(classesType === 'question'){
            $("ul[name ='classesName']").find('li').eq(1).addClass("layui-this")
        }
        if(classesType === 'share'){
            $("ul[name ='classesName']").find('li').eq(2).addClass("layui-this")
        }
        if(classesType === 'discussion'){
            $("ul[name ='classesName']").find('li').eq(3).addClass("layui-this")
        }
        if(classesType === 'suggest'){
            $("ul[name ='classesName']").find('li').eq(4).addClass("layui-this")
        }
        if(classesType === 'notice'){
            $("ul[name ='classesName']").find('li').eq(5).addClass("layui-this")
        }
        if(classesType === 'news'){
            $("ul[name ='classesName']").find('li').eq(6).addClass("layui-this")
        }
    }
	
	//根据选中状态查询该状态所有条目数
	var count = 0;
	$.ajax({
        url:'findDiscussCount.action',
        type:'post',
        data:{"type":$("input[name='selectType']").val(),"classestype":$("input[name='classesType']").val()},
        success:function(result){
            count = result.count;
            laypage.render({
  	          elem: 'jieindexLayPage'
  	          ,count: count
  	          ,jump: function(obj){
  	            $.ajax({
  	                url:'findDicussByPage.action',
  	                type:'post',
  	                data:{'curr':obj.curr,'limit':obj.limit,'type':$("input[name='selectType']").val(),'classestype':$("input[name='classesType']").val()},
  	                success:function(result){
  	                	var str = '';
  	                    if(result !=null && result !=''){
  	                    	layui.each(result,function(index,item){
  	                      		str += '<li><a href="gohome.action?userid='+item.userid+'" class="fly-avatar">';
  	                      		str+= '<img src="/pic/'+item.icon+'" alt="'+item.username+'"></a><h2>';
  	                      		str+='<a class="layui-badge">'+item.name+'</a><a href="detail.action?discussid='+item.discussid+'">'+item.title+'</a></h2><div class="fly-list-info"><a href="gohome.action?userid='+item.userid+'" link>';
  	                      		str+='<cite>'+item.username+'</cite>';
  	                      		if(item.authentication !=null){
  	                      			str+='<i class="iconfont icon-renzheng" title="认证信息：'+item.authentication+'"></i><i class="layui-badge fly-badge-vip">'+item.authenticatelevel+'</i>';
  	                      		}
  	                      		str+='</a><span name="publishDate" time="'+item.publishDate+'"></span><span class="fly-list-kiss layui-hide-xs" title="悬赏飞吻"><i class="iconfont icon-kiss"></i>'+item.reward+'</span>';
  	                      		if(item.discussstatus == 0){
  	                      			str +='<span class="layui-badge fly-badge-accept layui-hide-xs">未结</span>';
  	                      		}
  	                      		if(item.discussstatus == 1){
  	                      			str +='<span class="layui-badge fly-badge-accept layui-hide-xs">已结</span>';
  	                      		}
  	                      		str+='<span class="fly-list-nums"><i class="iconfont icon-pinglun1" title="回答"></i> '+item.replyCount+'</span></div><div class="fly-list-badge">';
  	                      		if(item.best == 1){
  	                      			str +='<span class="layui-badge layui-bg-red">精帖</span>';
  	                      		}
  	                      		if(item.topStatus ==1){
  	                      			str+='<span class="layui-badge layui-bg-black">置顶</span>';
  	                      		}
  	                      		str+='</div></li>';
  	                      	});
  	                    }else{
  	                    	str+='<div class="fly-none">没有相关数据</div>';
  	                    }
  	                    document.getElementById('discussItem').innerHTML = str;
  	                    renderPublishDate();
  	                    function renderPublishDate(){
  	              		  var publishDate = $("span[name='publishDate']");
  	              		  publishDate.each(function(){
  	              			  var content = util.timeAgo(new Date(Date.parse($(this).attr('time'))).getTime(),true);
  	              			  $(this).text(content)
  	              		  });
  	              	  }
  	                },
  	                error:function(result){
  	                }
  	            });
  	            
  	        }
  	      });
        },
        error:function(result){
        }
    });
});

</script>

</body>
</html>