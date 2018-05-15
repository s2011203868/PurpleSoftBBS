/**

 @Name: Fly社区主入口

 */
 

layui.define(['layer', 'laytpl', 'form', 'element', 'upload', 'util','laypage'], function(exports){
  
  var $ = layui.$
  ,layer = layui.layer
  ,laytpl = layui.laytpl
  ,form = layui.form
  ,element = layui.element
  ,upload = layui.upload
  ,util = layui.util
  ,laypage = layui.laypage
  ,device = layui.device()

  ,DISABLED = 'layui-btn-disabled';
  
  //阻止IE7以下访问
  if(device.ie && device.ie < 8){
    layer.alert('如果您非得使用 IE 浏览器访问紫软社区，那么请使用 IE8+');
  }
  
  
  layui.focusInsert = function(obj, str){
    var result, val = obj.value;
    obj.focus();
    if(document.selection){ //ie
      result = document.selection.createRange(); 
      document.selection.empty(); 
      result.text = str; 
    } else {
      result = [val.substring(0, obj.selectionStart), str, val.substr(obj.selectionEnd)];
      obj.focus();
      obj.value = result.join('');
    }
  };


  //数字前置补零
  layui.laytpl.digit = function(num, length, end){
    var str = '';
    num = String(num);
    length = length || 2;
    for(var i = num.length; i < length; i++){
      str += '0';
    }
    return num < Math.pow(10, length) ? str + (num|0) : num;
  };
  
  var fly = {

    //Ajax
    json: function(url, data, success, options){
      var that = this, type = typeof data === 'function';
      
      if(type){
        options = success
        success = data;
        data = {};
      }

      options = options || {};

      return $.ajax({
        type: options.type || 'post',
        dataType: options.dataType || 'json',
        data: data,
        url: url,
        success: function(res){
          if(res.status === 0) {
            success && success(res);
          } else {
            layer.msg(res.msg || res.code, {shift: 6});
            options.error && options.error();
          }
        }, error: function(e){
          layer.msg('请求异常，请重试', {shift: 6});
          options.error && options.error(e);
        }
      });
    }

    //计算字符长度
    ,charLen: function(val){
      var arr = val.split(''), len = 0;
      for(var i = 0; i <  val.length ; i++){
        arr[i].charCodeAt(0) < 299 ? len++ : len += 2;
      }
      return len;
    }
    
    ,form: {}

    //简易编辑器
    ,layEditor: function(options){
      var html = ['<div class="layui-unselect fly-edit">'
        ,'<span type="face" title="插入表情"><i class="iconfont icon-yxj-expression" style="top: 1px;"></i></span>'
        ,'<span type="picture" title="插入图片：img[src]"><i class="iconfont icon-tupian"></i></span>'
        ,'<span type="href" title="超链接格式：a(href)[text]"><i class="iconfont icon-lianjie"></i></span>'
        ,'<span type="code" title="插入代码或引用"><i class="iconfont icon-emwdaima" style="top: 1px;"></i></span>'
        ,'<span type="hr" title="插入水平线">hr</span>'
        ,'<span type="yulan" title="预览"><i class="iconfont icon-yulan1"></i></span>'
      ,'</div>'].join('');

      var log = {}, mod = {
        face: function(editor, self){ //插入表情
          var str = '', ul, face = fly.faces;
          for(var key in face){
            str += '<li title="'+ key +'"><img src="'+ face[key] +'"></li>';
          }
          str = '<ul id="LAY-editface" class="layui-clear">'+ str +'</ul>';
          layer.tips(str, self, {
            tips: 3
            ,time: 0
            ,skin: 'layui-edit-face'
          });
          $(document).on('click', function(){
            layer.closeAll('tips');
          });
          $('#LAY-editface li').on('click', function(){
            var title = $(this).attr('title') + ' ';
            layui.focusInsert(editor[0], 'face' + title);
          });
        }
        ,picture: function(editor){ //插入图片
          layer.open({
            type: 1
            ,id: 'fly-jie-upload'
            ,title: '插入图片'
            ,area: 'auto'
            ,shade: false
            ,area: '465px'
            ,fixed: false
            ,offset: [
              editor.offset().top - $(window).scrollTop() + 'px'
              ,editor.offset().left + 'px'
            ]
            ,skin: 'layui-layer-border'
            ,content: ['<ul class="layui-form layui-form-pane" style="margin: 20px;">'
              ,'<li class="layui-form-item">'
                ,'<label class="layui-form-label">URL</label>'
                ,'<div class="layui-input-inline">'
                    ,'<input required name="image" placeholder="支持直接粘贴远程图片地址" value="" class="layui-input">'
                  ,'</div>'
                  ,'<button type="button" class="layui-btn layui-btn-primary" id="uploadImg"><i class="layui-icon">&#xe67c;</i>上传图片</button>'
              ,'</li>'
              ,'<li class="layui-form-item" style="text-align: center;">'
                ,'<button type="button" lay-submit lay-filter="uploadImages" class="layui-btn">确认</button>'
              ,'</li>'
            ,'</ul>'].join('')
            ,success: function(layero, index){
              var image =  layero.find('input[name="image"]');
              var userid = $('#hiddenUser').val();
              //执行上传实例
              upload.render({
                elem: '#uploadImg'
                ,url: 'discussUploadImg.action'
                ,size: 200
                ,data: {id:userid}
                ,done: function(res){
                  if(res.status == 0){
                    image.val(res.url);
                  } else {
                    layer.msg(res.msg, {icon: 5});
                  }
                }
              });
              
              form.on('submit(uploadImages)', function(data){
                var field = data.field;
                if(!field.image) return image.focus();
                layui.focusInsert(editor[0], 'img['+ field.image + '] ');
                layer.close(index);
              });
            }
          });
        }
        ,href: function(editor){ //超链接
          layer.prompt({
            title: '请输入合法链接'
            ,shade: false
            ,fixed: false
            ,id: 'LAY_flyedit_href'
            ,offset: [
              editor.offset().top - $(window).scrollTop() + 'px'
              ,editor.offset().left + 'px'
            ]
          }, function(val, index, elem){
            if(!/^http(s*):\/\/[\S]/.test(val)){
              layer.tips('这根本不是个链接，不要骗我。', elem, {tips:1})
              return;
            }
            layui.focusInsert(editor[0], ' a('+ val +')['+ val + '] ');
            layer.close(index);
          });
        }
        ,code: function(editor){ //插入代码
        	var width = window.screen.width;
        	var height = window.screen.height;
        	var left = width/2-450;
        	var top = height/2-300;
          layer.prompt({
            title: '请贴入代码或任意文本'
            ,formType: 2
            ,maxlength: 10000
            ,shade: false
            ,offset: [top, left]
            ,id: 'LAY_flyedit_code'
            ,area: ['800px', '360px']
          }, function(val, index, elem){
            layui.focusInsert(editor[0], '[pre]\n'+ val + '\n[/pre]');
            layer.close(index);
          });
        }
        ,hr: function(editor){ //插入水平分割线
          layui.focusInsert(editor[0], '[hr]');
        }
        ,yulan: function(editor){ //预览
        	
          var content = editor.val();
          
          content = /^\{html\}/.test(content) 
            ? content.replace(/^\{html\}/, '')
          : fly.content(content);

          layer.open({
            type: 1
            ,title: '预览'
            ,shade: false
            ,offset: [0,0]
            ,area: ['100%', '100%']
            ,scrollbar: false
            ,content: '<div class="detail-body" style="margin:20px;">'+ content +'</div>'
          });
        }
      };
      
      layui.use('face', function(face){
        options = options || {};
        fly.faces = face;
        $(options.elem).each(function(index){
          var that = this, othis = $(that), parent = othis.parent();
          parent.prepend(html);
          parent.find('.fly-edit span').on('click', function(event){
            var type = $(this).attr('type');
            mod[type].call(that, othis, this);
            if(type === 'face'){
              event.stopPropagation()
            }
          });
        });
      });
      
    }

    ,escape: function(html){
      return String(html||'').replace(/&(?!#?[a-zA-Z0-9]+;)/g, '&amp;')
      .replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/'/g, '&#39;').replace(/"/g, '&quot;');
    }

    //内容转义
    ,content: function(content){
      //支持的html标签
      var html = function(end){
        return new RegExp('\\n*\\['+ (end||'') +'(pre|hr|div|span|p|table|thead|th|tbody|tr|td|ul|li|ol|li|dl|dt|dd|h2|h3|h4|h5)([\\s\\S]*?)\\]\\n*', 'g');
      };
      content = fly.escape(content||'') //XSS
      .replace(/img\[([^\s]+?)\]/g, function(img){  //转义图片
        return '<img src="' + img.replace(/(^img\[)|(\]$)/g, '') + '">';
      }).replace(/@(\S+)(\s+?|$)/g, '@<a href="javascript:;" class="fly-aite">$1</a>$2') //转义@
      .replace(/face\[([^\s\[\]]+?)\]/g, function(face){  //转义表情
        var alt = face.replace(/^face/g, '');
        return '<img alt="'+ alt +'" title="'+ alt +'" src="' + fly.faces[alt] + '">';
      }).replace(/a\([\s\S]+?\)\[[\s\S]*?\]/g, function(str){ //转义链接
        var href = (str.match(/a\(([\s\S]+?)\)\[/)||[])[1];
        var text = (str.match(/\)\[([\s\S]*?)\]/)||[])[1];
        if(!href) return str;
        var rel =  /^(http(s)*:\/\/)\b(?!(\w+\.)*(sentsin.com|layui.com))\b/.test(href.replace(/\s/g, ''));
        return '<a href="'+ href +'" target="_blank"'+ (rel ? ' rel="nofollow"' : '') +'>'+ (text||href) +'</a>';
      }).replace(html(), '\<$1 $2\>').replace(html('/'), '\</$1\>') //转移HTML代码
      .replace(/\n/g, '<br>') //转义换行   
      return content;
    }
    
    //新消息通知
    /*,newmsg: function(){
      var elemUser = $('.fly-nav-user');
      if(layui.cache.user.uid !== -1 && elemUser[0]){
        fly.json('/message/nums/', {
          _: new Date().getTime()
        }, function(res){
          if(res.status === 0 && res.count > 0){
            var msg = $('<a class="fly-nav-msg" href="javascript:;">'+ res.count +'</a>');
            elemUser.append(msg);
            msg.on('click', function(){
              fly.json('/message/read', {}, function(res){
                if(res.status === 0){
                  location.href = '/user/message/';
                }
              });
            });
            layer.tips('你有 '+ res.count +' 条未读消息', msg, {
              tips: 3
              ,tipsMore: true
              ,fixed: true
            });
            msg.on('mouseenter', function(){
              layer.closeAll('tips');
            })
          }
        });
      }
      return arguments.callee;
    }*/
    
  };

  //签到
  var tplSignin = ['{{# if(d.signed){ }}'
    ,'<button class="layui-btn layui-btn-disabled">今日已签到</button>'
    ,'<span>获得了<cite>{{ d.experience }}</cite>飞吻</span>'
  ,'{{# } else { }}'
    ,'<button class="layui-btn layui-btn-danger" id="LAY_signin">今日签到</button>'
    ,'<span>可获得<cite>{{ d.experience }}</cite>飞吻</span>'
  ,'{{# } }}'].join('')
  ,tplSigninDay = '已连续签到<cite>{{ d.days }}</cite>天'

  ,signRender = function(data){
    laytpl(tplSignin).render(data, function(html){
      elemSigninMain.html(html);
    });
    laytpl(tplSigninDay).render(data, function(html){
      elemSigninDays.html(html);
    });
  }

  ,elemSigninHelp = $('#LAY_signinHelp')
  ,elemSigninTop = $('#LAY_signinTop')
  ,elemSigninMain = $('.fly-signin-main')
  ,elemSigninDays = $('.fly-signin-days');
  
  if(elemSigninMain[0]){
    /*
    fly.json('/sign/status', function(res){
      if(!res.data) return;
      signRender.token = res.data.token;
      signRender(res.data);
    });
    */
  }
/*  $('body').on('click', '#LAY_signin', function(){
    var othis = $(this);
    if(othis.hasClass(DISABLED)) return;

    fly.json('/sign/in', {
      token: signRender.token || 1
    }, function(res){
      signRender(res.data);
    }, {
      error: function(){
        othis.removeClass(DISABLED);
      }
    });

    othis.addClass(DISABLED);
  });*/

  //kiss说明
  elemSigninHelp.on('click', function(){
	var width = window.screen.width;
	var height = window.screen.height;
	var left = width/2-150;
	var top = height/2-250;
    layer.open({
      type: 1
      ,title: '签到说明'
      ,area: '300px'
      ,shade: 0.8
      ,offset:[top,left]
      ,shadeClose: true
      ,content: ['<div class="layui-text" style="padding: 20px;">'
        ,'<blockquote class="layui-elem-quote">“签到”可获得社区kiss，规则如下</blockquote>'
        ,'<table class="layui-table">'
          ,'<thead>'
            ,'<tr><th>连续签到天数</th><th>每天可获飞吻</th></tr>'
          ,'</thead>'
          ,'<tbody>'
            ,'<tr><td>＜5</td><td>5</td></tr>'
            ,'<tr><td>≥5</td><td>10</td></tr>'
            ,'<tr><td>≥15</td><td>15</td></tr>'
            ,'<tr><td>≥30</td><td>20</td></tr>'
          ,'</tbody>'
        ,'</table>'
        ,'<ul>'
          ,'<li>中间若有间隔，则连续天数重新计算</li>'
          ,'<li style="color: #FF5722;">不可利用程序自动签到，否则飞吻清零</li>'
        ,'</ul>'
      ,'</div>'].join('')
    });
  });

  //签到活跃榜
  var tplSigninTop = ['{{# layui.each(d.data, function(index, item){ }}'
    ,'<li>'
      ,'<a href="/u/{{item.uid}}" target="_blank">'
        ,'<img src="{{item.user.avatar}}">'
        ,'<cite class="fly-link">{{item.user.username}}</cite>'
      ,'</a>'
      ,'{{# var date = new Date(item.time); if(d.index < 2){ }}'
        ,'<span class="fly-grey">签到于 {{ layui.laytpl.digit(date.getHours()) + ":" + layui.laytpl.digit(date.getMinutes()) + ":" + layui.laytpl.digit(date.getSeconds()) }}</span>'
      ,'{{# } else { }}'
        ,'<span class="fly-grey">已连续签到 <i>{{ item.days }}</i> 天</span>'
      ,'{{# } }}'
    ,'</li>'
  ,'{{# }); }}'
  ,'{{# if(d.data.length === 0) { }}'
    ,'{{# if(d.index < 2) { }}'
      ,'<li class="fly-none fly-grey">今天还没有人签到</li>'
    ,'{{# } else { }}'
      ,'<li class="fly-none fly-grey">还没有签到记录</li>'
    ,'{{# } }}'
  ,'{{# } }}'].join('');

  elemSigninTop.on('click', function(){
    var loadIndex = layer.load(1, {shade: 0.8});
    fly.json('../json/signin.js', function(res){ //实际使用，请将 url 改为真实接口
      var tpl = $(['<div class="layui-tab layui-tab-brief" style="margin: 5px 0 0;">'
        ,'<ul class="layui-tab-title">'
          ,'<li class="layui-this">最新签到</li>'
          ,'<li>今日最快</li>'
          ,'<li>总签到榜</li>'
        ,'</ul>'
        ,'<div class="layui-tab-content fly-signin-list" id="LAY_signin_list">'
          ,'<ul class="layui-tab-item layui-show"></ul>'
          ,'<ul class="layui-tab-item">2</ul>'
          ,'<ul class="layui-tab-item">3</ul>'
        ,'</div>'
      ,'</div>'].join(''))
      ,signinItems = tpl.find('.layui-tab-item');

      layer.close(loadIndex);

      layui.each(signinItems, function(index, item){
        var html = laytpl(tplSigninTop).render({
          data: res.data[index]
          ,index: index
        });
        $(item).html(html);
      });

      layer.open({
        type: 1
        ,title: '签到活跃榜 - TOP 20'
        ,area: '300px'
        ,shade: 0.8
        ,shadeClose: true
        ,id: 'layer-pop-signintop'
        ,content: tpl.prop('outerHTML')
      });

    }, {type: 'get'});
  });


  //回帖榜
  var tplReply = ['{{# layui.each(d.data, function(index, item){ }}'
    ,'<dd>'
      ,'<a href="/u/{{item.uid}}">'
        ,'<img src="{{item.user.avatar}}">'
        ,'<cite>{{item.user.username}}</cite>'
        ,'<i>{{item["count(*)"]}}次回答</i>'
      ,'</a>'
    ,'</dd>'
  ,'{{# }); }}'].join('')
  ,elemReply = $('#LAY_replyRank');

  if(elemReply[0]){
    /*
    fly.json('/top/reply/', {
      limit: 20
    }, function(res){
      var html = laytpl(tplReply).render(res);
      elemReply.find('dl').html(html);
    });
    */
  };

  //相册
  if($(window).width() > 750){
    layer.photos({
      photos: '.photos'
      ,zIndex: 9999999999
      ,anim: -1
    });
  } else {
    $('body').on('click', '.photos img', function(){
      window.open(this.src);
    });
  }


    
  //搜索
  $('.fly-search').on('click', function(){
	var width = window.screen.width;
	var height = window.screen.height;
	var left = width/2-225;
	var top = height/2-100;
    layer.open({
      type: 1
      ,title: false
      ,closeBtn: false
      ,offset: [top, left]
      ,shadeClose: true
      ,maxWidth: 10000
      ,skin: 'fly-layer-search'
      ,content: ['<form action="http://cn.bing.com/search">'
        ,'<input autocomplete="off" placeholder="搜索内容，回车跳转" type="text" name="q">'
      ,'</form>'].join('')
      ,success: function(layero){
        var input = layero.find('input');
        input.focus();

        layero.find('form').submit(function(){
          var val = input.val();
          if(val.replace(/\s/g, '') === ''){
            return false;
          }
          input.val('site:baidu.com '+ input.val());
      });
      }
    })
  });

  //新消息通知
  /*fly.newmsg();*/

  //发送激活邮件
  /*fly.activate = function(email){
    fly.json('/api/activate/', {}, function(res){
      if(res.status === 0){
        layer.alert('已成功将激活链接发送到了您的邮箱，接受可能会稍有延迟，请注意查收。', {
          icon: 1
        });
      };
    });
  };
  $('#LAY-activate').on('click', function(){
    fly.activate($(this).attr('email'));
  });*/

  //点击@
  $('body').on('click', '.fly-aite', function(){
    var othis = $(this), text = othis.text();
    if(othis.attr('href') !== 'javascript:;'){
      return;
    }
    text = text.replace(/^@|（[\s\S]+?）/g, '');
    othis.attr({
      href: '/PurpleSoftBBS/gohome.action?username='+ text
      ,target: '_blank'
    });
  });
  
  
//根据ip获取城市
  if($('#L_city').val() === ''){
    $.getScript('http://int.dpool.sina.com.cn/iplookup/iplookup.php?format=js', function(){
      $('#L_city').val(remote_ip_info.city||'');
    });
  }

  //上传头像图片
  if($('.upload-img')[0]){
    layui.use('upload', function(upload){
      var avatarAdd = $('.avatar-add');
      var userid = $('#hiddenUser').val();
      upload.render({
        elem: '.upload-img'
        ,url: 'uploadtouxiang.action'
        ,size: 200
        ,data: {id:userid} 
        ,before: function(obj){
        	obj.preview(function(index, file, result){
                $('#touxiangimg').attr('src', result); //图片链接（base64）
            });
        }
        ,done: function(res){
        	var height = (window.screen.height)/2;
        	if(result.statusCode == 200){
  				layer.msg(result.message,{icon:6,offset:height});
  			}else if(result.statusCode == 300){
  				layer.msg(result.message,{icon:5,offset:height});
  			}
        }
        ,error: function(){
        	var height = (window.screen.height)/2;
        	layer.msg('接口请求异常',{icon:0,offset:height});
        }
      });
    });
  }


  //表单提交
  /*form.on('submit(*)', function(data){
    var action = $(data.form).attr('action'), button = $(data.elem);
   
    fly.json(action, data.field, function(res){
      var end = function(){
        if(res.action){
          location.href = res.action;
        } else {
          fly.form[action||button.attr('key')](data.field, data.form);
        }
      };
      if(res.status == 0){
        button.attr('alert') ? layer.alert(res.msg, {
          icon: 1,
          time: 10*1000,
          end: end
        }) : end();
      };
    });
   
    return false;
  });*/
  
  //注册
  form.on('submit(registform)', function(data){
	  	$.ajax({
	  		url:'regist.action',
	  		type:'post',
	  		data:data.field,
	  		success:function(result){
	  			var height = (window.screen.height)/2;
	  			if(result.message =='验证码不正确'){
	  				layer.msg(result.message,{icon:2,offset:height});
	  			}else if(result.message == '邮箱已被注册!'){
	  				layer.msg(result.message,{icon:5,offset:height});
	  			}else if(result.message == '这个昵称似乎已经被占用，请换一个试试吧！'){
	  				layer.msg(result.message,{icon:5,offset:height});
	  			}else if(result.message == '注册失败！'){
	  				layer.msg(result.message,{icon:5,offset:height});
	  			}else if(result.statusCode == 200){
	  				layer.msg(result.message,{icon:6,offset:height})
	  				setTimeout(function(){
	  					location.href = 'login.action';
	  				},2000);
	  			}
	  			
	  		},
	  		error:function(result){
	  			var height = (window.screen.height)/2;
	  			layer.msg("接口请求异常!",{icon:0,offset:height});
	  		}
	  	})
	    return false;
	  });
  //登录
  form.on('submit(loginform)',function(data){
	  $.ajax({
	  		url:'login.action?a='+new Date().getTime(),
	  		type:'post',
	  		data:data.field,
	  		success:function(result){
	  			var height = (window.screen.height)/2;
	  			if(result.message == '邮箱不存在'){
	  				layer.msg(result.message,{icon: 5,offset:height});
	  			}else if(result.message == '密码错误'){
	  				layer.msg(result.message,{icon:2,offset:height});
	  			}else if(result.message == '错误次数过多，请5分钟后再试'){
	  				layer.msg(result.message,{icon:4,offset:height});
	  			}else if(result.message == '验证码错误'){
	  				layer.msg(result.message,{icon:2,offset:height})
	  			}else if(result.message == '账号被禁用'){
	  				layer.msg(result.message,{icon:4,offset:height});
	  			}else if(result.statusCode == 200){
	  				layer.msg('登陆成功',{icon:6,offset:height});
	  				setTimeout(function(){
	  					location.href = 'index.action';
	  				},2000);
	  			}
	  		},
	  		error:function(result){
	  			var height = (window.screen.height)/2;
	  			layer.msg("接口请求异常!",{icon:0,offset:height});
	  		}
	  	})
	    return false;
  });
  
  //监听专栏选择
  form.on('select(classesselect)', function(obj){
    var value = obj.value
    console.log(value)
    ,elemQuiz = $('#LAY_quiz')
    ,tips = {
      tips: 1
      ,maxWidth: 250
      ,time: 10000
    };
    //elemQuiz.addClass('layui-hide');
    if(value == 5){
      layer.tips('只有通过管理员认证才可发布公告哦', obj.othis, tips);
      //elemQuiz.removeClass('layui-hide');
    }else if(value == 6){
      layer.tips('只有通过管理员认证才可发布动态哦', obj.othis, tips);
    }
  });
  
  
  //修改密码
  form.on('submit(replacepassword)',function(data){
	 $.ajax({
	  		url:'replacepassword.action',
	  		type:'post',
	  		data:data.field,
	  		success:function(result){
	  			var height = (window.screen.height)/2;
	  			if(result.statusCode == 200){
	  				layer.msg(result.message,{icon:6,offset:height});
	  			}else if(result.statusCode == 300){
	  				layer.msg(result.message,{icon:5,offset:height});
	  			}
	  		},
	  		error:function(result){
	  			var height = (window.screen.height)/2;
	  			layer.msg('接口请求异常',{icon:0,offset:height});
	  		}
	  	})
	    return false;
 });
  
  //修改我的资料
  form.on('submit(editUserInfo)',function(data){
	  $.ajax({
		  url:'editUserInfo.action',
		  type:'post',
		  data:data.field,
		  success:function(result){
			  var height = (window.screen.height)/2;
			  if(result.statusCode == 200){
	  			 layer.msg(result.message,{icon:6,offset:height});
	  		  }else if(result.statusCode == 300){
	  			 layer.msg(result.message,{icon:5,offset:height});
	  		  }
		  },
		  error:function(result){
			  var height = (window.screen.height)/2;
			  layer.msg('接口请求异常',{icon:0,offset:height});
		  }
	  })
	  return false;
  });
  
  //发送找回密码邮件
  form.on('submit(sendMailFindPassword)',function(data){
	  $.ajax({
		  url:'findPasswordEmail.action',
		  type:'post',
		  data:data.field,
		  success:function(result){
			  var height = (window.screen.height)/2;
			  if(result.statusCode == 200){
	  				layer.msg(result.message,{icon:6,offset:height});
	  			}else if(result.statusCode == 300){
	  				layer.msg(result.message,{icon:5,offset:height});
	  			}
		  },
		  error:function(result){
			  var height = (window.screen.height)/2;
			  layer.msg('接口请求异常',{icon:0,offset:height});
		  }
	  });
	  return false;
  });
  
  //发表新的帖子
  form.on('submit(publishnewdiscuss)',function(data){
	  $.ajax({
		  url:'publishNewDiscuss.action',
		  type:'post',
		  data:data.field,
		  success:function(result){
			  var height = (window.screen.height)/2;
			  if(result.statusCode == 200){
	  				layer.msg(result.message,{icon:6,offset:height});
	  			}else if(result.statusCode == 300){
	  				layer.msg(result.message,{icon:5,offset:height});
	  			}
			  var img = document.getElementById("randomcode_img");
			  img.src = "/PurpleSoftBBS/fly-3.0/volidatecode/validatecode.jsp?a=" + new Date().getTime();  
		  },
		  error:function(result){
			  var height = (window.screen.height)/2;
			  layer.msg('接口请求异常',{icon:0,offset:height})
		  }
	  });
	  return false;
  });
  //编辑帖子
  form.on('submit(eidtDiscussid)',function(data){
	  $.ajax({
		  url:'saveEditDiscuss.action',
		  type:'post',
		  data:data.field,
		  success:function(result){
			  var height = (window.screen.height)/2;
			  if(result.statusCode == 200){
	  				layer.msg(result.message,{icon:6,offset:height});
	  			}else if(result.statusCode == 300){
	  				layer.msg(result.message,{icon:5,offset:height});
	  			}
			  var img = document.getElementById("randomcode_img");
			  img.src = "/PurpleSoftBBS/fly-3.0/volidatecode/validatecode.jsp?a=" + new Date().getTime();  
		  },
		  error:function(result){
			  var height = (window.screen.height)/2;
			  layer.msg('接口请求异常',{icon:0,offset:height})
		  }
	  });
	  return false;
  });
  
  //表单验证
  form.verify({
	  username:function(value){
		  if(!new RegExp('^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{5,16}$').test(value)){
			  return '5-16位字母数字组合';
		  }
	  },
	  pass:function(value){
		  if(value.length<6 || value.length >16){
			  return '6-16个字符';
		  }
	  },
	  repass: function(value,item){
	      if($('#L_pass').val() != value){
	        return '密码不一致';
	      }
	    }
	  });  
  

  //加载特定模块
 /* if(layui.cache.page && layui.cache.page !== 'index'){
    var extend = {};
    extend[layui.cache.page] = layui.cache.page;
    layui.extend(extend);
    layui.use(layui.cache.page);
  }*/
  
  //加载IM
  if(!device.android && !device.ios){
    //layui.use('im');
  }

  //加载编辑器
  fly.layEditor({
    elem: '.fly-editor'
  });

  //手机设备的简单适配
  var treeMobile = $('.site-tree-mobile')
  ,shadeMobile = $('.site-mobile-shade')

  treeMobile.on('click', function(){
    $('body').addClass('site-mobile');
  });

  shadeMobile.on('click', function(){
    $('body').removeClass('site-mobile');
  });

  //获取统计数据
 /* $('.fly-handles').each(function(){
    var othis = $(this);
    $.get('/api/handle?alias='+ othis.data('alias'), function(res){
      othis.html('（下载量：'+ res.number +'）');
    })
  });*/
  
  
  $(function(){
	  //格式化发布时间
	  renderPublishDate();
	  
	  //固定Bar
	  var isLogin = $('#checkisLogin').val();
	  if(isLogin !=""){
		  util.fixbar({
		    bar1: '&#xe642;'
		    ,bgcolor: '#009688'
		    ,click: function(type){
		      if(type === 'bar1'){
		        location.href = 'goadd.action';
		      }
		    }
		  });
	  }
	  
	  setInterval(function(){
		  renderPublishDate();
	  }, 60000);
	  function renderPublishDate(){
		  var publishDate = $("span[name='publishDate']");
		  publishDate.each(function(){
			  var content = util.timeAgo(new Date(Date.parse($(this).attr('time'))).getTime(),true);
			  $(this).text(content)
		  });
	  }
	  
  });

  
  
  
  exports('fly', fly);
  
  
});

