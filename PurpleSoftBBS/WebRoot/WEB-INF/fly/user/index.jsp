<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/fly/common/common.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>用户中心</title>
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <meta name="keywords" content="purplesoft,档案社区,AMS社区">
  <meta name="description" content="PurpleSoft社区是基于layui开发的官网档案社区，致力于为客户企业打造一站式帮助社区">
</head>
<body>
<input id="checkisLogin" type="hidden" value = "${sysUser }"/>
<input id="usersid" type="hidden" value = "${sysUser.id }"/>
<input id="publishCount" type="hidden" value = "${publishCount }"/>
<input id="storeCount" type="hidden" value = "${storeCount }"/>
<input id = "indexcollection" type="hidden" value="${collection }">
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
  <c:if test="${sysUser.activate == 0 }">
  	<div class="fly-msg" style="margin-top: 15px;">
     	 您的邮箱尚未验证，这比较影响您的帐号安全，<a href="goactivate.action">立即去激活？</a>
    </div>
  </c:if>
  
  <c:if test="${sysUser.activate == 1 }">
  	<div class="fly-msg" style="margin-top: 15px;">
     	Hi，${sysUser.username }，你已是我们的正式社员。
    </div>
  </c:if>
    <div class="layui-tab layui-tab-brief" lay-filter="user">
      <ul class="layui-tab-title" id="LAY_mine">
        <li data-type="mine-jie" lay-id="index" class="layui-this">我发的帖（<span>${publishCount }</span>）</li>
        <li data-type="collection" data-url="" lay-id="collection">我收藏的帖（<span>${storeCount }</span>）</li>
      </ul>
      <div name="content" class="layui-tab-content" style="padding: 20px 0;">
        <div class="layui-tab-item layui-show">
          <ul class="mine-view jie-row" id="publishItem">
            
          </ul>
          <div id="LAY_page"></div>
        </div>
        <div class="layui-tab-item">
          <ul class="mine-view jie-row" id="storeItem">
            
          </ul>
          <div id="LAY_page1"></div>
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
	}).use(['fly','element'],function(){
		var $ = layui.$,element = layui.element;
		$(function(){
		  var indexflag = $('#indexcollection').val();
		  if(indexflag !=null && indexflag !=''){
			  element.tabChange('user', 'collection')
			  /* $("div[name ='content']").find('div').eq(0).removeClass("layui-show");
			  $("div[name ='content']").find('div').eq(3).addClass("layui-show"); */
		  }
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
	
	layui.use(['layer','laypage','util'],function(){
		var $ = layui.$,
		layer = layui.layer,
		laypage = layui.laypage,
		util = layui.util;
		var publishcount = $('#publishCount').val();
		 //获取我的发布帖
         laypage.render({
	           elem: 'LAY_page'
	          ,count: publishcount
	          ,jump: function(obj){
	            $.ajax({
	                url:'findMyPublishDiscussByPage.action',
	                type:'post',
	                data:{'curr':obj.curr,'limit':obj.limit,'userid':$('#usersid').val()},
	                success:function(result){
	                	var str = '';
	                    if(result !=null && result !=''){
	                    	layui.each(result,function(index,item){
	                    		
	                    		str +='<li>';
	                    		str += '<a class="jie-title" href="detail.action?discussid='+item.discussid+'" target="_blank">'+item.title+'</a>';
	                    		str += '<i name="publishDate">'+item.publishDate+'</i>';
	                    		str += '<a class="mine-edit" href="editDiscuss.action?discussid='+item.discussid+'">编辑</a>';
	                    		str += '<em>'+item.readCount+'阅/'+item.replyCount+'回复</em></li>';
	                      	});
	                    }else{
	                    	str+='<div class="fly-none">没有相关数据</div>';
	                    }
	                    document.getElementById('publishItem').innerHTML = str;
	                    renderPublishDate();
	                    setInterval(function(){
	                    	renderPublishDate();
	                    }, 60000);
	                },
	                error:function(result){
	                }
	            });
	            
	        }
	      });
		 
		 var storeCount = $('#storeCount').val();
         //获取我的收藏贴
         laypage.render({
	           elem: 'LAY_page1'
	          ,count: storeCount
	          ,jump: function(obj){
	            $.ajax({
	                url:'findMyStoreDiscussByPage.action',
	                type:'post',
	                data:{'curr':obj.curr,'limit':obj.limit,'userid':$('#usersid').val()},
	                success:function(result){
	                	var str = '';
	                    if(result !=null && result !=''){
	                    	layui.each(result,function(index,item){
	                    		str +='<li>';
	                    		str += '<a class="jie-title" href="detail.action?discussid='+item.discussid+'" target="_blank">'+item.title+'</a>';
	                    		str += '</li>';
	                      	});
	                    }else{
	                    	str+='<div class="fly-none">没有相关数据</div>';
	                    }
	                    document.getElementById('storeItem').innerHTML = str;
	                },
	                error:function(result){
	                }
	            });
	            
	        }
	      });
         
         function renderPublishDate(){
     		  var publishDate = $("i[name='publishDate']");
     		  publishDate.each(function(){
     			  var content = util.timeAgo(new Date(Date.parse($(this).html())).getTime(),true);
     			  $(this).text(content);
     		  });
     	  }
	});
	
</script>

</body>
</html>