<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/fly/common/common.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>我的消息</title>
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <meta name="keywords" content="purplesoft,档案社区,AMS社区">
  <meta name="description" content="PurpleSoft社区是基于layui开发的官网档案社区，致力于为客户企业打造一站式帮助社区">
</head>
<body>
<input id="checkisLogin" type="hidden" value = "${sysUser }"/>
<input id = "userid" type ="hidden" value="${sysUser.id }">
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
    <li class="layui-nav-item">
      <a href="goset.action">
        <i class="layui-icon">&#xe620;</i>
        基本设置
      </a>
    </li>
    <li class="layui-nav-item layui-this">
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
	  <div class="layui-tab layui-tab-brief" lay-filter="user" id="LAY_msg" style="margin-top: 15px;">
	    <button class="layui-btn layui-btn-danger" onclick="clearAllMessage()" id="LAY_delallmsg">清空全部消息</button>
	    <div  id="LAY_minemsg" style="margin-top: 10px;">
        <ul id="mime-msg" class="mine-msg">
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
}).use(['fly','jquery','util'],function(){
    var fly = layui.fly,$ = layui.$,util = layui.util;
    var userid = $('#userid').val();
    $(function(){
    	getMessage();
    });
});

function getMessage(){
	layui.use(['fly','jquery','util'],function(){
		var fly = layui.fly,$ = layui.$,util = layui.util;
	    var userid = $('#userid').val();
		$.ajax({
            url:'getUserMessage.action',
            data:{'userid':userid},
            type:'post',
            success:function(result){
                var str = '';
                if(result !=null && result !=''){
                    layui.each(result,function(index,item){
                        str+='<li data-id="'+item.mid+'">';
                        str+='<blockquote class="layui-elem-quote">';
                        if(item.senderid != '2147480000'){
                           str+='<a href="gohome.action?userid='+item.senderid+'" target="_blank"><cite>'+item.username+'</cite></a>在<a target="_blank" href="detail.action?discussid='+item.disid+'"><cite>'+item.title+'</cite>中回复了您</a>';
                        }else{
                        	str+='<span><cite>'+item.sendcontent+'</cite></span><cite style="">欢迎您来到<span style="color:#800080">紫软社区</span>，系统已将100kiss放入您账号，</cite><a  href="gohome.action?userid='+item.receiverid+'"><cite>点击我查看</cite></a></br></br>';
                        	str+='<div><cite style="text-align:center;">kiss系统规则说明（一切只为激励发帖回帖，如发现互刷盗刷将永久封号）</cite>';
                        	str+='<table class="layui-table"><thead><tr><th>规则</th><th>kiss数量</th></tr></thead><tbody>';
                        	str+='<tr><td>发布新帖</td><td>-10，-20，-30，-40，-50</td></tr>';
                        	str+='<tr><td>首次回复帖子</td><td>+2</td></tr>';
                        	str+='<tr><td>帖子被人收藏</td><td>+10</td></tr>';
                        	str+='<tr><td>被采纳最佳答案</td><td>+20</td></tr>';
                        	str+='<tr><td>帖子被系统加精</td><td>+30</td></tr>';
                        	str+='</tbody></table></div>'
                        	
                        	str+='<div><cite style="text-align:center;">社区认证称号系统</cite>';
                            str+='<table class="layui-table"><thead><tr><th>规则</th><th>称号</th></tr></thead><tbody>';
                            str+='<tr><td>100<=kiss<500</td><td>无称号</td></tr>';
                            str+='<tr><td>500<=kiss<1000</td><td>社区之光</td></tr>';
                            str+='<tr><td>1000<=kiss<1500</td><td>中流砥柱</td></tr>';
                            str+='<tr><td>1500<=kiss<2000</td><td>社区元老</td></tr>';
                            str+='<tr><td>kiss>=2000</td><td>社区智尊<i class="iconfont icon-renzheng"></i>认证<i class="layui-badge fly-badge-vip">VIP1</i></td></tr>';
                            str+='<tr><td>kiss>=3000</td><td>社区智尊<i class="iconfont icon-renzheng"></i>认证<i class="layui-badge fly-badge-vip">VIP2</i></td></tr>';
                            str+='<tr><td>kiss>=4000</td><td>社区智尊<i class="iconfont icon-renzheng"></i>认证<i class="layui-badge fly-badge-vip">VIP3</i></td></tr>';
                            str+='</tbody></table></div>'
                        }
                        str+='</blockquote>';
                        str+='<p><span name="messagedate" time="'+item.senddate+'"></span></p></li>';
                    })
                    document.getElementById('mime-msg').innerHTML = str;
                    rendermessageDate();
                    function rendermessageDate(){
                      var messageDate = $("span[name='messagedate']");
                      messageDate.each(function(){
                          var content = util.timeAgo(new Date(Date.parse($(this).attr('time'))).getTime(),true);
                          $(this).text(content)
                      });
                    }
                }else {
                    str+'<div class="fly-none">您暂时没有最新消息</div>';
                    document.getElementById('LAY_minemsg').innerHTML = str;
                }
            }
        }); 
	})
}

function clearAllMessage(){
	layui.use('jquery',function(){
		var $ = layui.jquery,userid = $('#userid').val();
		$.ajax({
	        url:'updateMessageStats.action',
	        data:{'userid':userid},
	        type:'post',
	        success:function(result){
	        	getMessage();
	        }
	    });
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