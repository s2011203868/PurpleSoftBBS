<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/fly/common/common.jsp"%>

<!DOCTYPE html>
<html style="background-color: #e2e2e2;">
<head>
  <meta charset="utf-8">
  <meta name="keywords" content="{{ lay.base.keywords }}">
  <meta name="description" content="{{ lay.base.description }}">
  <meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <title>紫软档案客户案例</title>
  <style>
  .header{border-bottom: 1px solid #404553; border-right: 1px solid #404553;}
  </style>
</head>
<body class="fly-full">
<input id="checkisLogin" type="hidden" value = "${sysUser }"/>
<div class="fly-header layui-bg-black">
  <div class="layui-container">
    <a class="fly-logo" href="">
      <img src="/PurpleSoftBBS/fly-3.0/res/images/logo1.png" alt="purpleSoft">
    </a>
    <ul class="layui-nav fly-nav layui-hide-xs">
      <li class="layui-nav-item">
        <a href="index.action"><i class="iconfont icon-jiaoliu"></i>交流</a>
      </li>
      <li class="layui-nav-item layui-this">
        <a href="javascript:;"><i class="iconfont icon-iconmingxinganli"></i>案例</a>
      </li>
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

<div class="fly-case-header">
  <p class="fly-case-year">2017</p>
  <a href="/case/{{ year }}/">
    <img class="fly-case-banner" src="../../res/images/case.png" alt="发现 Layui 年度最佳案例">
  </a>
  <div class="fly-case-btn">
    <a href="javascript:;" class="layui-btn layui-btn-big fly-case-active" data-type="push">提交案例</a>
    <a href="" class="layui-btn layui-btn-primary layui-btn-big">我的案例</a>
    
    <a href="http://fly.layui.com/jie/11996/" target="_blank" style="padding: 0 15px; text-decoration: underline">案例要求</a>
  </div>
</div>

<div class="fly-main" style="overflow: hidden;">

  <div class="fly-tab-border fly-case-tab">
    <span>
      <a href="" class="tab-this">2017年度</a>
      <a href="">2016年度</a>
    </span>
  </div>
  <div class="layui-tab layui-tab-brief">
    <ul class="layui-tab-title">
      <li class="layui-this"><a href="">按提交时间</a></li>
      <li><a href="">按点赞排行</a></li>
    </ul>
  </div>

  <ul class="fly-case-list">
    <li data-id="123">
      <a class="fly-case-img" href="http://fly.layui.com/" target="_blank" >
        <img src="../../res/images/fly.jpg" alt="Fly社区">
        <cite class="layui-btn layui-btn-primary layui-btn-small">去围观</cite>
      </a>
      <h2><a href="http://fly.layui.com/" target="_blank">Fly社区</a></h2>
      <p class="fly-case-desc">Fly 社区是 layui 的官方社区，全站的前端层面基于 Layui 风格编写，轻量而简洁，并且模版已经开源，可用于极简社区模板。</p>
      <div class="fly-case-info">
        <a href="../user/home.html" class="fly-case-user" target="_blank"><img src="https://tva1.sinaimg.cn/crop.0.0.118.118.180/5db11ff4gw1e77d3nqrv8j203b03cweg.jpg"></a>
        <p class="layui-elip" style="font-size: 12px;"><span style="color: #666;">贤心</span> 2017-11-30</p>
        <p>获得<a class="fly-case-nums fly-case-active" href="javascript:;" data-type="showPraise" style=" padding:0 5px; color: #01AAED;">666</a>个赞</p>
        <button class="layui-btn layui-btn-primary fly-case-active" data-type="praise">点赞</button>
        <!-- <button class="layui-btn  fly-case-active" data-type="praise">已赞</button> -->
      </div>
    </li>
    <li data-id="123">
      <a class="fly-case-img" href="http://fly.layui.com/" target="_blank" >
        <img src="../../res/images/fly.jpg" alt="Fly社区">
        <cite class="layui-btn layui-btn-primary layui-btn-small">去围观</cite>
      </a>
      <h2><a href="http://fly.layui.com/" target="_blank">Fly社区</a></h2>
      <p class="fly-case-desc">Fly 社区是 layui 的官方社区，全站的前端层面基于 Layui 风格编写，轻量而简洁，并且模版已经开源，可用于极简社区模板。</p>
      <div class="fly-case-info">
        <a href="../user/home.html" class="fly-case-user" target="_blank"><img src="https://tva1.sinaimg.cn/crop.0.0.118.118.180/5db11ff4gw1e77d3nqrv8j203b03cweg.jpg"></a>
        <p class="layui-elip" style="font-size: 12px;"><span style="color: #666;">贤心</span> 2017-11-30</p>
        <p>获得<a class="fly-case-nums fly-case-active" href="javascript:;" data-type="showPraise" style=" padding:0 5px; color: #01AAED;">666</a>个赞</p>
        <button class="layui-btn  fly-case-active" data-type="praise">已赞</button>
      </div>
    </li>
    <li data-id="123">
      <a class="fly-case-img" href="http://fly.layui.com/" target="_blank" >
        <img src="../../res/images/fly.jpg" alt="Fly社区">
        <cite class="layui-btn layui-btn-primary layui-btn-small">去围观</cite>
      </a>
      <h2><a href="http://fly.layui.com/" target="_blank">Fly社区</a></h2>
      <p class="fly-case-desc">Fly 社区是 layui 的官方社区，全站的前端层面基于 Layui 风格编写，轻量而简洁，并且模版已经开源，可用于极简社区模板。</p>
      <div class="fly-case-info">
        <a href="../user/home.html" class="fly-case-user" target="_blank"><img src="https://tva1.sinaimg.cn/crop.0.0.118.118.180/5db11ff4gw1e77d3nqrv8j203b03cweg.jpg"></a>
        <p class="layui-elip" style="font-size: 12px;"><span style="color: #666;">贤心</span> 2017-11-30</p>
        <p>获得<a class="fly-case-nums fly-case-active" href="javascript:;" data-type="showPraise" style=" padding:0 5px; color: #01AAED;">666</a>个赞</p>
        <button class="layui-btn layui-btn-primary fly-case-active" data-type="praise">点赞</button>
        <!-- <button class="layui-btn  fly-case-active" data-type="praise">已赞</button> -->
      </div>
    </li>
    <li data-id="123">
      <a class="fly-case-img" href="http://fly.layui.com/" target="_blank" >
        <img src="../../res/images/fly.jpg" alt="Fly社区">
        <cite class="layui-btn layui-btn-primary layui-btn-small">去围观</cite>
      </a>
      <h2><a href="http://fly.layui.com/" target="_blank">Fly社区</a></h2>
      <p class="fly-case-desc">Fly 社区是 layui 的官方社区，全站的前端层面基于 Layui 风格编写，轻量而简洁，并且模版已经开源，可用于极简社区模板。</p>
      <div class="fly-case-info">
        <a href="../user/home.html" class="fly-case-user" target="_blank"><img src="https://tva1.sinaimg.cn/crop.0.0.118.118.180/5db11ff4gw1e77d3nqrv8j203b03cweg.jpg"></a>
        <p class="layui-elip" style="font-size: 12px;"><span style="color: #666;">贤心</span> 2017-11-30</p>
        <p>获得<a class="fly-case-nums fly-case-active" href="javascript:;" data-type="showPraise" style=" padding:0 5px; color: #01AAED;">666</a>个赞</p>
        <button class="layui-btn layui-btn-primary fly-case-active" data-type="praise">点赞</button>
        <!-- <button class="layui-btn  fly-case-active" data-type="praise">已赞</button> -->
      </div>
    </li>
    <li data-id="123">
      <a class="fly-case-img" href="http://fly.layui.com/" target="_blank" >
        <img src="../../res/images/fly.jpg" alt="Fly社区">
        <cite class="layui-btn layui-btn-primary layui-btn-small">去围观</cite>
      </a>
      <h2><a href="http://fly.layui.com/" target="_blank">Fly社区</a></h2>
      <p class="fly-case-desc">Fly 社区是 layui 的官方社区，全站的前端层面基于 Layui 风格编写，轻量而简洁，并且模版已经开源，可用于极简社区模板。</p>
      <div class="fly-case-info">
        <a href="../user/home.html" class="fly-case-user" target="_blank"><img src="https://tva1.sinaimg.cn/crop.0.0.118.118.180/5db11ff4gw1e77d3nqrv8j203b03cweg.jpg"></a>
        <p class="layui-elip" style="font-size: 12px;"><span style="color: #666;">贤心</span> 2017-11-30</p>
        <p>获得<a class="fly-case-nums fly-case-active" href="javascript:;" data-type="showPraise" style=" padding:0 5px; color: #01AAED;">666</a>个赞</p>
        <button class="layui-btn layui-btn-primary fly-case-active" data-type="praise">点赞</button>
        <!-- <button class="layui-btn  fly-case-active" data-type="praise">已赞</button> -->
      </div>
    </li>
    <li data-id="123">
      <a class="fly-case-img" href="http://fly.layui.com/" target="_blank" >
        <img src="../../res/images/fly.jpg" alt="Fly社区">
        <cite class="layui-btn layui-btn-primary layui-btn-small">去围观</cite>
      </a>
      <h2><a href="http://fly.layui.com/" target="_blank">Fly社区</a></h2>
      <p class="fly-case-desc">Fly 社区是 layui 的官方社区，全站的前端层面基于 Layui 风格编写，轻量而简洁，并且模版已经开源，可用于极简社区模板。</p>
      <div class="fly-case-info">
        <a href="../user/home.html" class="fly-case-user" target="_blank"><img src="https://tva1.sinaimg.cn/crop.0.0.118.118.180/5db11ff4gw1e77d3nqrv8j203b03cweg.jpg"></a>
        <p class="layui-elip" style="font-size: 12px;"><span style="color: #666;">贤心</span> 2017-11-30</p>
        <p>获得<a class="fly-case-nums fly-case-active" href="javascript:;" data-type="showPraise" style=" padding:0 5px; color: #01AAED;">666</a>个赞</p>
        <button class="layui-btn layui-btn-primary fly-case-active" data-type="praise">点赞</button>
        <!-- <button class="layui-btn  fly-case-active" data-type="praise">已赞</button> -->
      </div>
    </li>
    <li data-id="123">
      <a class="fly-case-img" href="http://fly.layui.com/" target="_blank" >
        <img src="../../res/images/fly.jpg" alt="Fly社区">
        <cite class="layui-btn layui-btn-primary layui-btn-small">去围观</cite>
      </a>
      <h2><a href="http://fly.layui.com/" target="_blank">Fly社区</a></h2>
      <p class="fly-case-desc">Fly 社区是 layui 的官方社区，全站的前端层面基于 Layui 风格编写，轻量而简洁，并且模版已经开源，可用于极简社区模板。</p>
      <div class="fly-case-info">
        <a href="../user/home.html" class="fly-case-user" target="_blank"><img src="https://tva1.sinaimg.cn/crop.0.0.118.118.180/5db11ff4gw1e77d3nqrv8j203b03cweg.jpg"></a>
        <p class="layui-elip" style="font-size: 12px;"><span style="color: #666;">贤心</span> 2017-11-30</p>
        <p>获得<a class="fly-case-nums fly-case-active" href="javascript:;" data-type="showPraise" style=" padding:0 5px; color: #01AAED;">666</a>个赞</p>
        <button class="layui-btn layui-btn-primary fly-case-active" data-type="praise">点赞</button>
        <!-- <button class="layui-btn  fly-case-active" data-type="praise">已赞</button> -->
      </div>
    </li>
    <li data-id="123">
      <a class="fly-case-img" href="http://fly.layui.com/" target="_blank" >
        <img src="../../res/images/fly.jpg" alt="Fly社区">
        <cite class="layui-btn layui-btn-primary layui-btn-small">去围观</cite>
      </a>
      <h2><a href="http://fly.layui.com/" target="_blank">Fly社区</a></h2>
      <p class="fly-case-desc">Fly 社区是 layui 的官方社区，全站的前端层面基于 Layui 风格编写，轻量而简洁，并且模版已经开源，可用于极简社区模板。</p>
      <div class="fly-case-info">
        <a href="../user/home.html" class="fly-case-user" target="_blank"><img src="https://tva1.sinaimg.cn/crop.0.0.118.118.180/5db11ff4gw1e77d3nqrv8j203b03cweg.jpg"></a>
        <p class="layui-elip" style="font-size: 12px;"><span style="color: #666;">贤心</span> 2017-11-30</p>
        <p>获得<a class="fly-case-nums fly-case-active" href="javascript:;" data-type="showPraise" style=" padding:0 5px; color: #01AAED;">666</a>个赞</p>
        <button class="layui-btn layui-btn-primary fly-case-active" data-type="praise">点赞</button>
        <!-- <button class="layui-btn  fly-case-active" data-type="praise">已赞</button> -->
      </div>
    </li>
  </ul>
  
  <!-- <blockquote class="layui-elem-quote layui-quote-nm">暂无数据</blockquote> -->

  <div style="text-align: center;">
    <div class="laypage-main">
      <span class="laypage-curr">1</span>
      <a href="">2</a><a href="">3</a>
      <a href="">4</a>
      <a href="">5</a>
      <span>…</span>
      <a href="" class="laypage-last" title="尾页">尾页</a>
      <a href="" class="laypage-next">下一页</a>
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