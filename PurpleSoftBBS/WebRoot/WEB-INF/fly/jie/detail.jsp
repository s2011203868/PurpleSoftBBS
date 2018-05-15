<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/fly/common/common.jsp"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>${DiscussDetail.title }</title>
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <meta name="keywords" content="purplesoft,档案社区,AMS社区">
  <meta name="description" content="PurpleSoft社区是基于layui开发的官网档案社区，致力于为客户企业打造一站式帮助社区">
</head>
<body>
<input id="checkisLogin" type="hidden" value = "${sysUser }"/>
<input id="userid" type="hidden" value = "${sysUser.id }"/>
<input type="hidden" name= "discussidinput" value="${DiscussDetail.discussid }">
<input type="hidden" id= "discussuserid" value="${DiscussDetail.userid }">
<input type="hidden" id= "byreplyerid" value="">
<div style="display: none;" name="contentdiv">${DiscussDetail.content }</div>
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

<div class="layui-hide-xs">
  <div class="fly-panel fly-column">
    <div class="layui-container">
      <ul class="layui-clear">
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
</div>

<div class="layui-container">
  <div class="layui-row layui-col-space15">
    <div class="layui-col-md8 content detail">
      <div class="fly-panel detail-box">
        <h1>${DiscussDetail.title }</h1>
        <div class="fly-detail-info">
          <!-- <span class="layui-badge">审核中</span> -->
          <span class="layui-badge layui-bg-green fly-detail-column">${DiscussDetail.name }</span>
          <c:if test="${DiscussDetail.discussstatus == 0 }">
            <span class="layui-badge" style="background-color: #999;">未结</span>
          </c:if>
          <c:if test="${DiscussDetail.discussstatus == 1 }">
            <span class="layui-badge" style="background-color: #5FB878;">已结</span>
          </c:if>
          <c:if test="${DiscussDetail.topStatus == 1 }">
            <span class="layui-badge layui-bg-black">置顶</span>
          </c:if>        
          <c:if test="${DiscussDetail.best == 1 }">
            <span class="layui-badge layui-bg-red">精帖</span>
          </c:if> 
          
          
          <div class="fly-admin-box" data-id="123">
            <c:if test="${sysUser.id == DiscussDetail.userid }">
                <span class="layui-btn layui-btn-xs jie-admin" onclick="delthisdiscuss(${DiscussDetail.discussid })" type="del">删除</span>
            </c:if>
            <!-- <span class="layui-btn layui-btn-xs jie-admin" type="set" field="stick" rank="0" style="background-color:#ccc;">取消置顶</span> -->
            <!-- <span class="layui-btn layui-btn-xs jie-admin" type="set" field="status" rank="0" style="background-color:#ccc;">取消加精</span> -->
          </div>
          <span class="fly-list-nums"> 
            <a href="#comment"><i class="iconfont" title="回答">&#xe60c;</i> ${DiscussDetail.replyCount }</a>
            <i class="iconfont" title="人气">&#xe60b;</i> ${DiscussDetail.readCount }
          </span>
        </div>
        <div class="detail-about">
          <a class="fly-avatar" href="gohome.action?userid=${DiscussDetail.userid }">
            <img src="/pic/${DiscussDetail.icon }" alt="${DiscussDetail.username }">
          </a>
          <div class="fly-detail-user">
            <a href="gohome.action?userid=${DiscussDetail.userid }" class="fly-link">
              <cite>${DiscussDetail.username }</cite>
              <c:if test="${! empty DiscussDetail.authentication }">
                <i class="iconfont icon-renzheng" title="认证信息：${DiscussDetail.authentication }"></i>
                <i class="layui-badge fly-badge-vip">${DiscussDetail.authenticatelevel }</i>
              </c:if>
            </a>
            <span name="publishDate" time="<fmt:formatDate value="${DiscussDetail.publishDate }" pattern="yyyy-MM-dd HH:mm:ss"/>"></span>
          </div>
          <div class="detail-hits" id="LAY_jieAdmin" data-id="123">
            <span style="padding-right: 10px; color: #FF7200">悬赏：${DiscussDetail.reward }飞吻</span> 
            <c:if test="${sysUser.id == DiscussDetail.userid }">
                <span class="layui-btn layui-btn-xs jie-admin" type="edit"><a href="editDiscuss.action?discussid=${DiscussDetail.discussid }">编辑此贴</a></span>
            </c:if> 
            <c:if test="${sysUser.id != DiscussDetail.userid }">
                <span class="layui-btn layui-btn-xs jie-admin" type="edit"><a onclick = "storethis(${DiscussDetail.discussid },${sysUser.id})">收藏此贴</a></span>
            </c:if>
          </div>
        </div>
        <!-- 内容区 -->
        <div class="detail-body photos">
        
        </div>
        <!-- 内容区结束 -->
      </div>
	  <!-- 回复区 -->
      <div class="fly-panel detail-box" id="flyReply">
        <fieldset class="layui-elem-field layui-field-title" style="text-align: center;">
          <legend>回帖</legend>
        </fieldset>
        
        <ul class="jieda" id="jieda"></ul>
        
        <div class="layui-form layui-form-pane">
          <form method="post">
            <div class="layui-form-item layui-form-text">
              <a name="comment"></a>
              <div class="layui-input-block">
                <textarea id="L_content" name="content" placeholder="请输入内容"  class="layui-textarea fly-editor" style="height: 150px;"></textarea>
              </div>
            </div>
            <div class="layui-form-item">
              <input type="hidden" name="jid" value="123">
              <button class="layui-btn" type="button" lay-filter="submitreply" lay-submit>提交回复</button>
            </div>
          </form>
        </div>
      </div>
      <!-- 回复区结束 -->
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
          <a href="" target="_blank" class="fly-zanzhu" time-limit="2017.09.25-2099.01.01" style="background-color: #5FB878;">虚位以待</a>
        </div>
      </div>

      <div class="fly-panel" style="padding: 20px 0; text-align: center;">
        <img src="/PurpleSoftBBS/fly-3.0/res/images/gongzhonghao.png" style="max-width: 100%;" alt="layui">
        <p style="position: relative; color: #666;">微信扫码关注公众号</p>
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
	}).use(['fly','face','form','layer'], function() {
		var $ = layui.$, fly = layui.fly,layer = layui.layer,form = layui.form;
		//统计浏览量
		$(function(){
			//增加阅读量
	        $.ajax({url:'addReadCount.action',type:'post',data:{'discussid':$("input[name='discussidinput']").val()}})
	    	//查询回复区内容
	        findReplyContent();
		});
		
		//解析帖子内容。
		$('.detail-body').each(function(){
		  var othis = $(this), html = othis.html();
		  var content =$("div[name='contentdiv']").html();
		  othis.html(fly.content(content));
		});
		
		
		
		//回复帖子
		form.on('submit(submitreply)',function(data){
			var discid = $('input[name="discussidinput"]').val();
			var userid = $('#userid').val();
			var discussuserid = $('#discussuserid').val();
			var byreplyerid = $('#byreplyerid').val();
			byreplyerid = byreplyerid ==='' ? discussuserid : byreplyerid; 
			var contentstr = data.field.content;
			if(contentstr.indexOf('@') == -1){
				byreplyerid = $('#discussuserid').val();
			}
			$.ajax({
				url:'submitreply.action',
				type:'post',
				data:{'discid':discid,'replycontent':data.field.content,'replyerid':userid,'byreplyerid':byreplyerid,'disuserid':discussuserid},
				success:function(result){
					//回复成功要清除被回复者id
					$('#byreplyerid').val('');
					//回复成功把编辑器内容清空
					$('#L_content').val('');
					//更新回复区内容
	                findReplyContent();
	                var height = (window.screen.height)/2;
                    if(result.statusCode == 200){
                        layer.msg(result.message,{icon:1,offset:height});
                    }else if(result.statusCode == 300){
                        layer.msg(result.message,{icon:2,offset:height});
                    }
				},
				error:function(result){
					var height = (window.screen.height)/2;
					layer.msg('接口请求异常',{icon:0,offset:height});
				}
			});
			return false;
		});
		
		 
	});
	
	//收藏帖子
	function storethis(discussid,userid){
		layui.use('layer',function(){
			var $ = layui.$,layer = layui.layer;
			var height = (window.screen.height)/2;
			
			$.ajax({
				url:'storeDiscuss.action',
				data:{'discussid':discussid,'userid':userid},
				type:'post',
				success:function(result){
					var height = (window.screen.height)/2;
					if(result.statusCode == 200){
						layer.msg(result.message,{icon:1,offset:height});
					}else if(result.statusCode == 300){
						layer.msg(result.message,{icon:2,offset:height});
					}
				}
			});
		});	
	};
	
	//删除帖子
	function delthisdiscuss(discussid){
		layui.use('layer',function(){
			var $ = layui.jquery,layer = layui.layer;
			var width = window.screen.width;
			var height = window.screen.height;
			var left = width/2-150;
			var top = height/2-150;
			layer.confirm('确定要删除此帖吗?', {icon: 3, title:'提示',offset:[top,left]}, function(index){
				layer.close(index); 
				$.ajax({
					url:'deleteDiscussBydiscussId.action',
					data:{'discussid':discussid},
					type:'post',
					success:function(result){
						var height = (window.screen.height)/2;
						if(result.statusCode == 200){
							layer.msg(result.message,{icon:1,offset:height});
							setTimeout(function(){
								location.href='index.action';
							}, 2000);
						}else{
							layer.msg(result.message,{icon:2,offset:height});
						}
					 }
				  });
			});
		});
	}
	
	
	//查询回复区内容
	function findReplyContent(){
		layui.use(['fly','util'],function(){
			var $ = layui.jquery,fly = layui.fly,util = layui.util;
			var discid = $('input[name="discussidinput"]').val();
			var discussuserid = $('#discussuserid').val();
			var userid = $('#userid').val();
			$.ajax({
	    		url:'findReplyContentByDiscid.action',
	    		data:{'discid':discid},
	    		type:'post',
	    		success:function(result){
	    			var str = '';
	    			
	    			if(result !=null && result !=''){
	    				layui.each(result,function(index,item){
	                    	str+='<li data-id="'+item.rid+'" class="jieda-daan">';
	                    	str+='<a name="item-1111111111"></a>';
	                    	str+='<div class="detail-about detail-about-reply">';
	                    	str+='<a class="fly-avatar" href="gohome.action?userid='+item.replyerid+'">';
	                    	str+='<img src="/pic/'+item.icon+'" alt="'+item.username+'"></a>';
	                    	str+='<div class="fly-detail-user"><a href="gohome.action?userid='+item.replyerid+'" class="fly-link"><cite>'+item.username+'</cite>';
	                    	if(item.authentication !=null){
	                    		str+='<i class="iconfont icon-renzheng" title="认证信息：'+item.authentication+'"></i><i class="layui-badge fly-badge-vip">'+item.authenticatelevel+'</i>';
	                    	}
	                    	str+='</a>';
	                    	if(item.id == discussuserid){
	                    		str+='<span>(楼主)</span>';
	                    	}
	                    	if(item.authentication === '管理员'){
	                    		str+='<span style="color:#5FB878">(管理员)</span>';
	                    	}
	                    	if(item.kiss >= 500 && item.kiss <1000 ){
	                    		str+='<span style="color:#FF9E3F">（社区之光）</span>';
	                    	}
	                    	if(item.kiss >= 1000 && item.kiss <1500 ){
                                str+='<span style="color:#FF9E3F">（中流砥柱）</span>';
                            }
	                    	if(item.kiss >= 1500 && item.kiss <2000 ){
                                str+='<span style="color:#FF9E3F">（社区元老）</span>';
                            }
	                    	if(item.kiss >= 2000){
                                str+='<span style="color:#FF9E3F">（社区智尊）</span>';
                            }
	                    	if(item.status == 2){
	                    		str+='<span style="color:#999">（该号已被封）</span>';
	                    	}
	                    	str+='</div>';
	                    	str+='<div class="detail-hits"><span name="replydate" time="'+item.replydate+'"></span></div>';
	                    	if(item.accept ==1){
	                    		str+='<i class="iconfont icon-caina" title="最佳答案"></i>';
	                    	}
	                    	str+='</div>';
	                    	str+='<div class="detail-body jieda-body photos"><p>'+item.replycontent+'</p></div>';
	                    	str+='<div class="jieda-reply">';
	                    	str+='<span type="reply" name="reply" value="'+item.id+'"  onclick="autoreply('+item.id+',\''+item.username+'\')"><i class="iconfont icon-svgmoban53" value="'+item.username+'" name="replybutton"></i>回复</span>';
	                    	str+='<div class="jieda-admin">';
	                    	if(userid === discussuserid){
	                    		str+='<span type="del" onclick="deleteReply('+item.rid+','+item.discussid+')">删除</span>';
	                    		if(item.hasAccept === 0){
	                    			str+='<span class="jieda-accept" value="'+item.hasAccept+'" onclick="acceptReply('+item.replyerid+','+item.rid+','+item.discussid+',\''+item.username+'\','+item.byreplyerid+')" type="accept">采纳</span>';
	                    		}
	                    	}
	                    	str+='</div></div></li>';
	                    });
	    			}else{
	    				str+='<div class="fly-none">暂时还没有人回帖</div>';
	    			}
	    			document.getElementById('jieda').innerHTML = str;
	    			$('.jieda-body p').each(function(){
	    			  var othis = $(this), html = othis.html();
	    			  var content =$(this).html();
	    			  othis.html(fly.content(content));
	    			});
	    			
	    			renderreplyDate();
                    function renderreplyDate(){
              		  var replyDate = $("span[name='replydate']");
              		  replyDate.each(function(){
              			  var content = util.timeAgo(new Date(Date.parse($(this).attr('time'))).getTime(),true);
              			  $(this).text(content)
              		  });
              	  }
	    		}
	    	});
		});
	}
	
	//删除评论
	function deleteReply(replyid,discussid){
		layui.use('layer',function(){
			var $ = layui.jquery,layer = layui.layer;
			var width = window.screen.width;
			var height = window.screen.height;
			var left = width/2-150;
			var top = height/2-150;
			layer.confirm('确定要删除此条评论吗?', {icon: 3, title:'提示',offset:[top,left]}, function(index){
				layer.close(index); 
				$.ajax({
					url:'deleteReplyByrid.action',
					data:{'replyid':replyid,'discussid':discussid},
					type:'post',
					success:function(result){
						
						if(result.statusCode == 200){
							findReplyContent();
						}
						if(result.statusCode == 300){
							layer.msg(result.message,{icon:2});
						}
					 }
				  });
			});
		});
	}
	
	//采纳评论
	function acceptReply(replyerid,replyid,discussid,username,byreplyerid){
		layui.use('layer',function(){
			var $ = layui.jquery,layer = layui.layer;
			var width = window.screen.width;
			var height = window.screen.height;
			var left = width/2-150;
			var top = height/2-150;
			layer.confirm('确定要采纳此条评论吗?', {icon: 3, title:'提示',offset:[top,left]}, function(index){
				layer.close(index); 
				$.ajax({
					url:'acceptReplyByrid.action',
					data:{'replyid':replyid,'discussid':discussid,'replyerid':replyerid,'username':username,'byreplyerid':byreplyerid},
					type:'post',
					success:function(result){
						var height = (window.screen.height)/2;
	                    if(result.statusCode == 200){
	                    	findReplyContent();
	                        layer.msg(result.message,{icon:1,offset:height});
	                    }else if(result.statusCode == 300){
	                        layer.msg(result.message,{icon:2,offset:height});
	                    }
					 }
				  });
			});
		});
	}
	
	//自动往文本框输入回复者昵称
	function autoreply(replyerid,username){
		layui.use('jquery',function(){
			var $ = layui.$;
			var name = username;
			var id = replyerid;
			$('#L_content').val('@'+name+' ');
			$('#byreplyerid').val(id);
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