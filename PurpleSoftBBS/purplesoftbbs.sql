/*
SQLyog Ultimate v12.4.3 (64 bit)
MySQL - 5.0.18-nt : Database - purplesoftbbs
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`purplesoftbbs` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci */;

USE `purplesoftbbs`;

/*Table structure for table `classes` */

DROP TABLE IF EXISTS `classes`;

CREATE TABLE `classes` (
  `id` int(11) NOT NULL COMMENT '专栏id',
  `name` varchar(255) collate utf8_unicode_ci default NULL COMMENT '专栏名',
  `namecode` varchar(255) collate utf8_unicode_ci default NULL COMMENT '名称代码',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `classes` */

insert  into `classes`(`id`,`name`,`namecode`) values 
(1,'提问','question'),
(2,'分享','share'),
(3,'讨论','discussion'),
(4,'建议','suggest'),
(5,'公告','notice'),
(6,'动态','news');

/*Table structure for table `discuss` */

DROP TABLE IF EXISTS `discuss`;

CREATE TABLE `discuss` (
  `discussid` int(11) NOT NULL auto_increment COMMENT 'id',
  `classesid` int(11) default NULL COMMENT '所属专栏',
  `title` varchar(255) collate utf8_unicode_ci default NULL COMMENT '标题',
  `productid` int(11) default NULL COMMENT '所属产品',
  `version` varchar(255) collate utf8_unicode_ci default NULL COMMENT '版本号',
  `browser` varchar(255) collate utf8_unicode_ci default NULL COMMENT '浏览器',
  `reward` int(11) default NULL COMMENT '悬赏',
  `publishdate` datetime default NULL COMMENT '发表时间',
  `discussstatus` int(11) default NULL COMMENT '0 正常 1已结',
  `topstatus` int(11) default NULL COMMENT '0 正常 1置顶',
  `userid` int(11) default NULL COMMENT '作者',
  `content` varchar(20000) collate utf8_unicode_ci default NULL COMMENT '内容',
  `best` int(11) NOT NULL default '0' COMMENT '0普通帖 1精华帖',
  `replycount` int(11) NOT NULL default '0' COMMENT '回复数',
  `readcount` int(11) NOT NULL default '0' COMMENT '阅读数',
  `hasaccept` int(11) unsigned NOT NULL default '0' COMMENT '0未有采纳回复;其他值为被采纳者id',
  PRIMARY KEY  (`discussid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `discuss` */

insert  into `discuss`(`discussid`,`classesid`,`title`,`productid`,`version`,`browser`,`reward`,`publishdate`,`discussstatus`,`topstatus`,`userid`,`content`,`best`,`replycount`,`readcount`,`hasaccept`) values 
(1,1,'测试提问1',1,'1.0','IE',20,'2018-04-19 14:23:47',1,0,1,'img[\\discuss\\image\\1524118998409760.jpg] [hr]face[生病] face[右哼哼] face[委屈] 哈哈',1,2,6,1),
(2,1,'测试提问2',1,'1.0','IE',20,'2018-04-19 14:27:06',1,0,1,'img[\\discuss\\image\\1524118998409760.jpg] [hr]face[生病] face[右哼哼] face[委屈] 哈哈',1,1,10,1),
(3,1,'测试提问3',1,'','',20,'2018-04-19 14:55:41',1,0,1,'img[\\discuss\\image\\1524120818894631.jpg] ',1,1,3,1),
(4,2,'测试分享1',0,'','',20,'2018-04-15 21:37:12',0,0,1,'img[\\discuss\\image\\1524136811173694.jpg] ',0,0,0,0),
(5,2,'测试分享2',1,'1.0','',20,'2018-04-16 21:37:08',0,0,1,'img[http://bpic.588ku.com/element_origin_min_pic/18/04/04/7823fb38de755bd8f4abc244f95750e8.jpg] ',0,0,1,0),
(6,2,'测试分享3',1,'','火狐',20,'2018-04-17 21:37:03',0,0,1,'[pre]\n<c:if test=\"${sysUser !=null }\">\n	        <!-- 登入后的状态 -->\n	      	<li class=\"layui-nav-item\">\n	        <a class=\"fly-nav-avatar\" href=\"gousercenter.action\">\n	          <cite class=\"layui-hide-xs\">${sysUser.username }</cite>\n	          <c:if test=\"${!empty sysUser.authentication }\">\n	          	<i class=\"iconfont icon-renzheng layui-hide-xs\" title=\"${sysUser.authentication }\"></i>\n	          	<i class=\"layui-badge fly-badge-vip layui-hide-xs\">${sysUser.authenticatelevel }</i>\n	          </c:if>\n	          <img src=\"/pic/${sysUser.icon }\">\n	        </a>\n	        <dl class=\"layui-nav-child\">\n	          <dd><a href=\"goset.action\"><i class=\"layui-icon\">&#xe620;</i>基本设置</a></dd>\n	          <dd><a href=\"gomessage.action\"><i class=\"iconfont icon-tongzhi\" style=\"top: 4px;\"></i>我的消息</a></dd>\n	          <dd><a href=\"gohome.action\"><i class=\"layui-icon\" style=\"margin-left: 2px; font-size: 22px;\">&#xe68e;</i>我的主页</a></dd>\n	          <hr style=\"margin: 5px 0;\">\n	          <dd><a href=\"logout.action\" style=\"text-align: center;\">退出</a></dd>\n	        </dl>\n	      </li>\n      </c:if>\n[/pre]',0,0,3,0),
(7,3,'测试讨论1',1,'1.0','火狐',20,'2018-04-18 21:36:41',0,0,1,'[pre]\n<c:if test=\"${sysUser !=null }\">\n	        <!-- 登入后的状态 -->\n	      	<li class=\"layui-nav-item\">\n	        <a class=\"fly-nav-avatar\" href=\"gousercenter.action\">\n	          <cite class=\"layui-hide-xs\">${sysUser.username }</cite>\n	          <c:if test=\"${!empty sysUser.authentication }\">\n	          	<i class=\"iconfont icon-renzheng layui-hide-xs\" title=\"${sysUser.authentication }\"></i>\n	          	<i class=\"layui-badge fly-badge-vip layui-hide-xs\">${sysUser.authenticatelevel }</i>\n	          </c:if>\n	          <img src=\"/pic/${sysUser.icon }\">\n	        </a>\n	        <dl class=\"layui-nav-child\">\n	          <dd><a href=\"goset.action\"><i class=\"layui-icon\">&#xe620;</i>基本设置</a></dd>\n	          <dd><a href=\"gomessage.action\"><i class=\"iconfont icon-tongzhi\" style=\"top: 4px;\"></i>我的消息</a></dd>\n	          <dd><a href=\"gohome.action\"><i class=\"layui-icon\" style=\"margin-left: 2px; font-size: 22px;\">&#xe68e;</i>我的主页</a></dd>\n	          <hr style=\"margin: 5px 0;\">\n	          <dd><a href=\"logout.action\" style=\"text-align: center;\">退出</a></dd>\n	        </dl>\n	      </li>\n      </c:if>\n[/pre]',0,0,0,0),
(8,3,'测试讨论2',1,'','',20,'2018-04-05 21:36:38',0,0,1,'[pre]\n<c:if test=\"${sysUser !=null }\">\n	        <!-- 登入后的状态 -->\n	      	<li class=\"layui-nav-item\">\n	        <a class=\"fly-nav-avatar\" href=\"gousercenter.action\">\n	          <cite class=\"layui-hide-xs\">${sysUser.username }</cite>\n	          <c:if test=\"${!empty sysUser.authentication }\">\n	          	<i class=\"iconfont icon-renzheng layui-hide-xs\" title=\"${sysUser.authentication }\"></i>\n	          	<i class=\"layui-badge fly-badge-vip layui-hide-xs\">${sysUser.authenticatelevel }</i>\n	          </c:if>\n	          <img src=\"/pic/${sysUser.icon }\">\n	        </a>\n	        <dl class=\"layui-nav-child\">\n	          <dd><a href=\"goset.action\"><i class=\"layui-icon\">&#xe620;</i>基本设置</a></dd>\n	          <dd><a href=\"gomessage.action\"><i class=\"iconfont icon-tongzhi\" style=\"top: 4px;\"></i>我的消息</a></dd>\n	          <dd><a href=\"gohome.action\"><i class=\"layui-icon\" style=\"margin-left: 2px; font-size: 22px;\">&#xe68e;</i>我的主页</a></dd>\n	          <hr style=\"margin: 5px 0;\">\n	          <dd><a href=\"logout.action\" style=\"text-align: center;\">退出</a></dd>\n	        </dl>\n	      </li>\n      </c:if>\n[/pre][hr]img[\\discuss\\image\\1524140828955565.jpg] ',0,0,1,0),
(11,5,'测试公告1',1,'1.0','',20,'2018-04-18 21:36:26',0,0,1,'[hr]img[\\discuss\\image\\1524141127880197.jpg] [hr][pre]\nform.on(\'submit(publishnewdiscuss)\',function(data){\n	  $.ajax({\n		  url:\'publishNewDiscuss.action\',\n		  type:\'post\',\n		  data:data.field,\n		  success:function(result){\n			  layer.alert(result.message);\n			  var img = document.getElementById(\"randomcode_img\");\n			  var vercode = $(\'#L_vercode\'); \n			  vercode.val(\'\')\n			  img.src = \"/PurpleSoftBBS/fly-3.0/volidatecode/validatecode.jsp?a=\" + new Date().getTime();  \n		  },\n		  error:function(result){\n			  layer.alert(result.message);\n		  }\n	  });\n	  return false;\n  });\n[/pre]',0,1,8,0),
(12,5,'测试公告2',1,'1.0','',20,'2018-04-17 21:36:23',0,0,1,'face[嘻嘻] face[嘻嘻] face[哈哈] ',0,0,2,0),
(13,6,'测试动态1',3,'1.0','',20,'2018-04-18 21:36:20',0,0,1,'face[嘻嘻] face[嘻嘻] face[哈哈] ',0,0,2,0),
(14,6,'测试动态2',3,'1.0','',20,'2018-04-17 21:36:15',0,0,1,'img[https://img03.sogoucdn.com/app/a/100520024/b2aab00016bc908341a96edea3fb5887] ',0,1,3,0),
(15,1,'测试发帖',2,'1.0','',20,'2018-04-21 17:31:31',0,0,1,'face[哈哈] face[嘻嘻] face[汗] ',0,7,127,0),
(16,1,'我是来测试的',1,'','',20,'2018-04-20 09:52:30',0,0,2,'face[嘻嘻] face[嘻嘻] face[哈哈] ',0,1,6,0),
(17,1,'测试表情解析',1,'','',20,'2018-04-21 10:22:10',0,0,1,'face[微笑] face[可爱] ',0,1,3,0),
(18,1,'测试发帖内容',2,'12','',20,'2018-04-21 14:18:53',1,1,1,'人生，其实就是一场盛大的遇见，你若懂得，在遇见时，就一定要感激，就一定要珍惜。\n\n　　有时候，这个世界很大，大到我们一辈子都没有机会遇见；有时候，这个世界又很小，小到你一抬头就可以看到那个笑脸。\n\n　　遇见是很美很温暖的事，每一天，都期待着每一个遇见，遇见更美的自己，遇见跟好的自己，遇见更好的你。遇见，每一天，每一个人都会频频的发生，小的时候，儿时的玩伴，老师同学，走出校园，更是会遇见形形色色的人，走入职场，领导、同事等等都是我们一定会遇见的。我感谢我的每一次遇见，因为，每一次的遇见都会带给我很多，比如快乐、感动、感激等等。所以，在遇见时一定要感激，在一起时，一定要珍惜，挥别时一定要微笑，与他们的遇见不是无缘无故的，他们，或多或少都会教会我们一些东西。\n\n　　人的一生，总会遇上一些人，一些事，不早，也不晚，就在某个不经意间，某个随意的地点，就这么遇上了，没有邀约，没有预约，就这样，不经意的相逢在了一起，演绎了一场没有经过排练的故事。\n\n　　在岁月这条漫漫长路上，我们都按照自己的方式走着，在经历了一些人，一些事以后，我们就长大了，伴随着成长中的欣喜和一些烦恼，我们慢慢的融入到了一些新的群体中，开启了新的旅程，就是在这个时候，我们会遇见很多很多人和事，他们，不断影响着我们的思维、世界观，改变着我们的生活轨迹，就是这些遇见，不经意间，一个转身，就改变了我们的生活。但，何尝不说，遇见，就是幸福。\n\n　　以前，我从没有觉得跟一个人遇见会带给自己什么，有时候只会觉得，遇见带给自己欣喜高兴开心的时候也带给了自己忧伤和寂寞，这个时候，就会抱怨，为什么会遇见，为什么要遇见，可是，长大了，渐渐懂得，遇见，不光是带给我们欣喜和繁华，还有思索和感悟。有些人，是来教会我们成长的，教会了我们一些东西，然后又转身离去，仿佛从来就没有出现过一样。所以，不要害怕遇见，遇见，其实就是寻觅幸福的过程，漫漫人生路，不就是寻觅着，然后，幸福着。\n\n　　渐渐懂得，\n\n　　人生，有太多遇见，适逢其会，触不及防\n\n　　擦肩而过，是一种遇见，\n\n　　刻骨铭心，也是一种遇见。\n\n　　很多时候，\n\n　　看见的，看不见了；\n\n　　记住的，遗忘了。\n\n　　无论是在对的时间遇见错的人，\n\n　　还是，在错的时间遇见对的人，\n\n　　这，都是最美的遇见！\n\n　　我想，人生，也不过如此，回首过往，曾经是阴云密布，但是，当现在的我们回过头去看时，却是一片清明，随之不禁莞尔一笑，因为，懂得了，遇见就是最美。\n\n　　这繁华世间所有的相遇都是久别的重逢，是最美的晨语。有些故事，注定了没有结局，但却是最美的生活写意……\n\n　　遇见了，就请感激；遇见了，就请珍惜。因为，有了这些遇见。唯美了我们的整个曾经。经年过后，终是不悔这一场倾心的相遇。[hr]img[\\discuss\\image\\1524291511362496.jpg] ',0,9,15,1),
(19,1,'测试发帖内容',1,'','',20,'2018-04-21 14:22:15',0,1,1,'[pre]\n人生，其实就是一场盛大的遇见，你若懂得，在遇见时，就一定要感激，就一定要珍惜。\n\n　　有时候，这个世界很大，大到我们一辈子都没有机会遇见；有时候，这个世界又很小，小到你一抬头就可以看到那个笑脸。\n\n　　遇见是很美很温暖的事，每一天，都期待着每一个遇见，遇见更美的自己，遇见跟好的自己，遇见更好的你。遇见，每一天，每一个人都会频频的发生，小的时候，儿时的玩伴，老师同学，走出校园，更是会遇见形形色色的人，走入职场，领导、同事等等都是我们一定会遇见的。我感谢我的每一次遇见，因为，每一次的遇见都会带给我很多，比如快乐、感动、感激等等。所以，在遇见时一定要感激，在一起时，一定要珍惜，挥别时一定要微笑，与他们的遇见不是无缘无故的，他们，或多或少都会教会我们一些东西。\n\n　　人的一生，总会遇上一些人，一些事，不早，也不晚，就在某个不经意间，某个随意的地点，就这么遇上了，没有邀约，没有预约，就这样，不经意的相逢在了一起，演绎了一场没有经过排练的故事。\n\n　　在岁月这条漫漫长路上，我们都按照自己的方式走着，在经历了一些人，一些事以后，我们就长大了，伴随着成长中的欣喜和一些烦恼，我们慢慢的融入到了一些新的群体中，开启了新的旅程，就是在这个时候，我们会遇见很多很多人和事，他们，不断影响着我们的思维、世界观，改变着我们的生活轨迹，就是这些遇见，不经意间，一个转身，就改变了我们的生活。但，何尝不说，遇见，就是幸福。\n\n　　以前，我从没有觉得跟一个人遇见会带给自己什么，有时候只会觉得，遇见带给自己欣喜高兴开心的时候也带给了自己忧伤和寂寞，这个时候，就会抱怨，为什么会遇见，为什么要遇见，可是，长大了，渐渐懂得，遇见，不光是带给我们欣喜和繁华，还有思索和感悟。有些人，是来教会我们成长的，教会了我们一些东西，然后又转身离去，仿佛从来就没有出现过一样。所以，不要害怕遇见，遇见，其实就是寻觅幸福的过程，漫漫人生路，不就是寻觅着，然后，幸福着。\n\n　　渐渐懂得，\n\n　　人生，有太多遇见，适逢其会，触不及防\n\n　　擦肩而过，是一种遇见，\n\n　　刻骨铭心，也是一种遇见。\n\n　　很多时候，\n\n　　看见的，看不见了；\n\n　　记住的，遗忘了。\n\n　　无论是在对的时间遇见错的人，\n\n　　还是，在错的时间遇见对的人，\n\n　　这，都是最美的遇见！\n\n　　我想，人生，也不过如此，回首过往，曾经是阴云密布，但是，当现在的我们回过头去看时，却是一片清明，随之不禁莞尔一笑，因为，懂得了，遇见就是最美。\n\n　　这繁华世间所有的相遇都是久别的重逢，是最美的晨语。有些故事，注定了没有结局，但却是最美的生活写意……\n\n　　遇见了，就请感激；遇见了，就请珍惜。因为，有了这些遇见。唯美了我们的整个曾经。经年过后，终是不悔这一场倾心的相遇。\n[/pre]',0,6,22,0),
(20,1,'测试发帖内容2',1,'','',20,'2018-04-21 14:25:48',1,1,1,'[pre]\n/**\n	* @Title: replacePassword  \n	* @Description: 修改密码  \n	* @param @param nowpass\n	* @param @param pass\n	* @param @param email\n	* @param @return\n	* @param @throws Exception    设定文件  \n	* @return String    返回类型  \n	* @throws\n	 */\n	@RequestMapping(\"replacepassword\")\n	@ResponseBody\n	public String replacePassword(HttpServletRequest request,@RequestParam(value=\"nowpass\",defaultValue=\"\")String nowpass,String pass,String email) throws Exception{\n		if(!nowpass.equals(\"\")){\n			//修改密码\n			SysUser sysUser = sysUserService.findUserByEmail(email);\n			String oldPassword = sysUser.getPassword();\n			String salt = sysUser.getSalt();\n			Md5Hash md5Hash = new Md5Hash(nowpass, salt, 2);\n			String md5HashPassword = md5Hash.toString();\n			if(!md5HashPassword.equals(oldPassword)){\n				return Result.error(\"原密码不正确\");\n			}else{\n				Md5Hash newMd5 = new Md5Hash(pass, salt, 2);\n				String newPassword = newMd5.toString();\n				int n = sysUserService.updateUserPassword(newPassword,email);\n				if(n > 0){\n					return Result.ok(\"密码修改成功\");\n				}else{\n					return Result.error(\"密码修改失败\");\n				}\n			}\n		}else{\n		    //重置密码\n		    // 校验验证码\n	        HttpSession session = ((HttpServletRequest)request).getSession();\n	        String randomcode = request.getParameter(\"randomcode\");\n	        String validateCode = (String) session.getAttribute(\"validateCode\");\n	        if (randomcode!=null && validateCode!=null) {\n	            if (!randomcode.equals(validateCode)) {\n	                return Result.error(\"验证码不正确\");\n	            }\n	        }\n	        SysUser sysUser = sysUserService.findUserByEmail(email);\n	        String salt = sysUser.getSalt();\n	        Md5Hash newMd5 = new Md5Hash(pass, salt, 2);\n            String newPassword = newMd5.toString();\n            int n = sysUserService.updateUserPassword(newPassword,email);\n            if(n > 0){\n                return Result.ok(\"密码重置成功\");\n            }else{\n                return Result.error(\"密码重置失败\");\n            }\n		}\n	}\n[/pre]',0,6,101,1),
(21,1,'水一帖',1,'1','',10,'2018-04-24 10:31:14',1,0,1,'face[挖鼻] ',0,2,13,1),
(22,1,'测试飞吻系统',1,'','',10,'2018-04-24 13:10:31',0,0,17,'看看飞吻系统好使不face[嘻嘻] ',0,3,1,0),
(23,1,'再测',1,'','',50,'2018-04-24 13:21:32',0,0,17,'face[挖鼻] ',0,2,5,0);

/*Table structure for table `discussstore` */

DROP TABLE IF EXISTS `discussstore`;

CREATE TABLE `discussstore` (
  `storeid` int(11) NOT NULL auto_increment COMMENT '主键',
  `uid` int(11) default NULL COMMENT '用户ID',
  `disid` int(11) default NULL COMMENT '帖子id',
  PRIMARY KEY  (`storeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `discussstore` */

insert  into `discussstore`(`storeid`,`uid`,`disid`) values 
(1,1,16),
(2,1,15),
(3,1,23);

/*Table structure for table `message` */

DROP TABLE IF EXISTS `message`;

CREATE TABLE `message` (
  `mid` int(11) NOT NULL auto_increment COMMENT '主键id',
  `senderid` int(11) NOT NULL COMMENT '发消息者id',
  `receiverid` int(11) default NULL COMMENT '接收消息者id',
  `disid` int(11) default NULL COMMENT '消息所属帖子id',
  `sendcontent` varchar(20000) collate utf8_unicode_ci default NULL COMMENT '发送的消息内容',
  `senddate` datetime default NULL COMMENT '发送消息时间',
  `readed` int(11) default '0' COMMENT '0未读 1已读',
  PRIMARY KEY  (`mid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `message` */

insert  into `message`(`mid`,`senderid`,`receiverid`,`disid`,`sendcontent`,`senddate`,`readed`) values 
(1,2,1,19,'我是来测试消息系统的face[心] face[害羞] face[心] ','2018-04-23 10:57:55',1),
(2,2,1,19,'再来测试异步消息推送','2018-04-23 11:49:46',1),
(3,2,1,19,'我又来测消息推送了face[可爱] ','2018-04-23 12:47:16',1),
(4,2,1,18,'这次再不成功 我他妈删库跑路face[怒] face[怒] ','2018-04-23 14:33:34',1),
(5,2,1,18,'哈哈 成功推送消息face[太开心] face[太开心] ','2018-04-23 14:34:23',1),
(6,2,1,18,'这是个bug满天飞的时代 face[挖鼻] face[挖鼻] ','2018-04-23 14:36:22',1),
(7,2,1,18,'这次我回复的是作者，而不是自己','2018-04-23 14:44:04',1),
(8,2,2,18,'@s15554604611 这次回复的是155','2018-04-23 14:44:34',1),
(9,2,1,18,'回复楼主','2018-04-23 14:44:51',1),
(10,2,1,18,'再回复楼主','2018-04-23 14:45:06',1),
(11,2,1,18,'再回复','2018-04-23 14:45:14',1),
(12,1,2,16,'你测试结果咋样，可以告诉我嘛face[嘻嘻] ','2018-04-23 16:50:32',0),
(13,1,1,21,'回复你','2018-04-24 10:32:01',1),
(14,1,1,21,'回复你','2018-04-24 10:59:25',1),
(17,2147480000,17,2147480000,'系统消息：','2018-04-24 12:43:54',0),
(18,1,17,23,'测飞吻','2018-04-24 14:02:17',0),
(19,1,17,23,'测飞吻','2018-04-24 14:06:54',0),
(20,1,17,23,'测飞吻','2018-04-24 14:11:34',0),
(21,1,17,23,'再回复','2018-04-24 14:12:50',0),
(22,1,1,11,'回复','2018-04-24 14:20:35',1),
(23,1,17,22,'回复','2018-04-24 14:20:53',0),
(24,1,17,22,'再回复','2018-04-24 14:21:00',0),
(25,1,17,22,'你再回复系统也不会给你kiss了face[哈哈] face[哈哈] face[哈哈] ','2018-04-24 14:21:32',0),
(26,17,1,20,'我是来要kiss的','2018-04-24 14:23:44',1),
(27,17,1,21,'我要kiss','2018-04-24 14:25:56',1),
(28,17,1,3,'我要kiss','2018-04-24 14:28:22',1),
(29,17,1,2,'我要kiss','2018-04-24 14:31:23',1),
(30,1,1,1,'回复我自己再采纳得飞吻face[嘻嘻] face[嘻嘻] ','2018-04-24 14:39:17',1),
(31,1,1,1,'你骗我 face[右哼哼] face[右哼哼] ','2018-04-24 14:39:59',1),
(33,2147480000,19,2147480000,'系统消息：','2018-04-24 15:16:21',0),
(34,2147480000,20,2147480000,'系统消息：','2018-04-24 15:21:15',0),
(35,2147480000,21,2147480000,'系统消息：','2018-04-24 17:34:15',0);

/*Table structure for table `product` */

DROP TABLE IF EXISTS `product`;

CREATE TABLE `product` (
  `id` int(11) NOT NULL COMMENT '产品id',
  `name` varchar(255) collate utf8_unicode_ci default NULL COMMENT '产品名',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `product` */

insert  into `product`(`id`,`name`) values 
(1,'档案管理综合考评系统'),
(2,'档案管理系统（网络版）'),
(3,'档案管理系统（单机版）'),
(4,'文档管理系统（企业版）'),
(5,'TH-OCR 2009数据录入工厂（网络版）'),
(6,'IT-Scan 图档易扫通（专业版）'),
(7,'Colortrac SmartLF SC Xpress 系列 工程图纸扫描仪'),
(8,'虹光3750SU高速文档扫描仪'),
(9,'虹光AV3200SU高速文档扫描仪');

/*Table structure for table `reply` */

DROP TABLE IF EXISTS `reply`;

CREATE TABLE `reply` (
  `rid` int(11) NOT NULL auto_increment COMMENT 'id',
  `discid` int(11) default NULL COMMENT '对应discuss表id',
  `replycontent` varchar(20000) collate utf8_unicode_ci default NULL COMMENT '回复内容',
  `replyerid` int(11) default NULL COMMENT '回复者id',
  `disuserid` int(11) default NULL COMMENT '发帖者id',
  `byreplyerid` int(11) default NULL COMMENT '被回复者id',
  `accept` int(11) default '0' COMMENT '0未被采纳1被采纳',
  `replydate` datetime default NULL COMMENT '回复时间',
  PRIMARY KEY  (`rid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `reply` */

insert  into `reply`(`rid`,`discid`,`replycontent`,`replyerid`,`disuserid`,`byreplyerid`,`accept`,`replydate`) values 
(1,15,'终于可以回复帖子了face[哈哈] face[哈哈] ',1,1,1,0,'2018-04-22 12:16:11'),
(2,15,'再回复一个复杂的试试face[太开心] face[太开心] [hr]img[\\discuss\\image\\1524370680465474.png]face',1,1,1,0,'2018-04-22 12:18:51'),
(3,14,'再回复一个复杂的试试face[太开心] face[太开心] [hr]img[\\discuss\\image\\1524370680465474.png]face',1,1,1,0,'2018-04-22 12:41:28'),
(4,15,'终于可以显示回复列表了',1,1,1,0,'2018-04-22 14:06:28'),
(5,20,'回复一个试试face[嘻嘻] ',1,1,1,0,'2018-04-22 14:30:59'),
(7,15,'我又来测试了',1,1,1,0,'2018-04-22 14:36:10'),
(8,15,'其他账号开车来回复你贴了face[哈哈] ',2,1,1,0,'2018-04-22 15:11:27'),
(9,15,'@s15554604611 我不仅可以回复楼主，还可以回复其他人了face[哈哈] face[太开心] ',1,1,2,0,'2018-04-22 16:13:40'),
(10,15,'@s15554604611 再试一次 上次不成功',1,1,2,0,'2018-04-22 16:20:51'),
(12,5,'马上就五一了face[太开心] face[太开心] face[太开心] ',1,1,1,0,'2018-04-22 20:25:05'),
(13,20,'我又来测试了，孜孜不倦face[哈哈] face[哈哈] ',1,1,1,1,'2018-04-22 21:30:34'),
(15,18,'这美女好漂亮face[色] face[色] ',1,1,1,1,'2018-04-22 21:42:41'),
(16,20,'妈的 评论又出bug了 再来测试face[抓狂] face[抓狂] ',1,1,1,0,'2018-04-22 21:55:29'),
(17,19,'真是一篇美文啊face[嘻嘻] face[嘻嘻] face[色] face[色] ',1,1,1,0,'2018-04-22 21:56:42'),
(18,19,'看bug还在吗face[困] ',1,1,1,0,'2018-04-22 22:03:04'),
(19,20,'@s2011203868 测试通过face[哈哈] face[哈哈] ',2,1,1,0,'2018-04-22 22:16:13'),
(20,17,'face[微笑] ',2,1,1,0,'2018-04-22 22:35:29'),
(22,20,'我又来测试了face[嘘] face[睡] ',1,1,1,0,'2018-04-22 22:48:24'),
(23,19,'这已经是我第无数次读这篇美文了face[爱你] face[爱你] ',1,1,1,0,'2018-04-23 10:16:37'),
(24,19,'我是来测试消息系统的face[心] face[害羞] face[心] ',2,1,1,0,'2018-04-23 10:57:55'),
(25,19,'再来测试异步消息推送',2,1,1,0,'2018-04-23 11:49:46'),
(26,19,'我又来测消息推送了face[可爱] ',2,1,1,0,'2018-04-23 12:47:16'),
(27,18,'这次再不成功 我他妈删库跑路face[怒] face[怒] ',2,1,1,0,'2018-04-23 14:33:34'),
(28,18,'哈哈 成功推送消息face[太开心] face[太开心] ',2,1,2,0,'2018-04-23 14:34:23'),
(29,18,'这是个bug满天飞的时代 face[挖鼻] face[挖鼻] ',2,1,1,0,'2018-04-23 14:36:22'),
(30,18,'这次我回复的是作者，而不是自己',2,1,1,0,'2018-04-23 14:44:04'),
(31,18,'@s15554604611 这次回复的是155',2,1,2,0,'2018-04-23 14:44:34'),
(32,18,'回复楼主',2,1,1,0,'2018-04-23 14:44:51'),
(33,18,'再回复楼主',2,1,1,0,'2018-04-23 14:45:06'),
(34,18,'再回复',2,1,1,0,'2018-04-23 14:45:14'),
(35,16,'你测试结果咋样，可以告诉我嘛face[嘻嘻] ',1,2,2,0,'2018-04-23 16:50:32'),
(37,21,'回复你',1,1,1,0,'2018-04-24 10:59:25'),
(40,23,'测飞吻',1,17,17,0,'2018-04-24 14:11:34'),
(41,23,'再回复',1,17,17,0,'2018-04-24 14:12:50'),
(42,11,'回复',1,1,1,0,'2018-04-24 14:20:35'),
(43,22,'回复',1,17,17,0,'2018-04-24 14:20:53'),
(44,22,'再回复',1,17,17,0,'2018-04-24 14:21:00'),
(45,22,'你再回复系统也不会给你kiss了face[哈哈] face[哈哈] face[哈哈] ',1,17,17,0,'2018-04-24 14:21:32'),
(46,20,'我是来要kiss的',17,1,1,0,'2018-04-24 14:23:44'),
(47,21,'我要kiss',17,1,1,1,'2018-04-24 14:25:56'),
(48,3,'我要kiss',17,1,1,1,'2018-04-24 14:28:22'),
(49,2,'我要kiss',17,1,1,1,'2018-04-24 14:31:23'),
(50,1,'回复我自己再采纳得飞吻face[嘻嘻] face[嘻嘻] ',1,1,1,1,'2018-04-24 14:39:17'),
(51,1,'你骗我 face[右哼哼] face[右哼哼] ',1,1,1,0,'2018-04-24 14:39:59');

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id` int(11) NOT NULL auto_increment COMMENT 'ID',
  `username` varchar(255) collate utf8_unicode_ci default NULL COMMENT '昵称',
  `email` varchar(255) collate utf8_unicode_ci default NULL COMMENT '邮箱',
  `password` varchar(255) collate utf8_unicode_ci default NULL COMMENT '密码',
  `sex` int(11) default NULL COMMENT '性别 0男 1女',
  `sign` varchar(1000) collate utf8_unicode_ci default NULL COMMENT '签名',
  `phone` int(11) default NULL COMMENT '手机',
  `icon` varchar(255) collate utf8_unicode_ci default NULL COMMENT '头像地址',
  `salt` varchar(255) collate utf8_unicode_ci default NULL COMMENT '密码盐',
  `registtime` date default NULL COMMENT '注册日期',
  `lastlogintime` datetime default NULL COMMENT '最后一次登录时间',
  `status` int(11) default NULL COMMENT '状态1正常2被禁用',
  `authentication` varchar(255) collate utf8_unicode_ci default NULL COMMENT '认证信息',
  `authenticatelevel` varchar(255) collate utf8_unicode_ci default NULL COMMENT '认证等级',
  `city` varchar(255) collate utf8_unicode_ci default NULL COMMENT '城市',
  `activate` int(11) default '0' COMMENT '激活状态 0未激活1激活',
  `resettoken` varchar(255) collate utf8_unicode_ci default NULL COMMENT '重置密码token',
  `activatetoken` varchar(255) collate utf8_unicode_ci default NULL COMMENT '邮箱激活token',
  `kiss` int(11) default NULL COMMENT '飞吻',
  `myreplycount` int(11) default '0' COMMENT '我的回复数',
  `storecount` int(11) default NULL COMMENT '每日收藏次数',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `user` */

insert  into `user`(`id`,`username`,`email`,`password`,`sex`,`sign`,`phone`,`icon`,`salt`,`registtime`,`lastlogintime`,`status`,`authentication`,`authenticatelevel`,`city`,`activate`,`resettoken`,`activatetoken`,`kiss`,`myreplycount`,`storecount`) values 
(1,'s2011203868','395078618@qq.com','3980e4044675f6339248ee0c735c7d72',1,'我是来玩耍的',NULL,'1524107640613956.jpg','123456','2018-04-17','2018-04-24 17:28:45',1,'管理员','VIP1','济南',1,NULL,NULL,1004,31,NULL),
(2,'s15554604611','15554604611@163.com','79d5577c29c60089ccd84c73f79c3f4d',0,NULL,NULL,'1524195221304137.png','3ae02a','2018-04-17','2018-04-23 17:26:00',1,NULL,NULL,NULL,1,'80ff9ea8b7943abcf7bdeba09d5ca652','99b62c73530c0440bca0afa005735b46',NULL,14,NULL),
(3,'ceshi123','123@qq.com','33776887f3a7503df674087e0437e5b6',0,NULL,NULL,'9265781b88651b5584da5bdaa9bf1d55.jpg','6ea855','2018-04-20','2018-04-20 09:50:32',1,NULL,NULL,NULL,1,NULL,NULL,NULL,0,NULL),
(17,'s32413','1@qq.com','8d1d2b2f83ef42c4d1fc993c15ded134',0,NULL,NULL,'9265781b88651b55d148ab531302b39c.jpg','87abf7','2018-04-24','2018-04-24 14:23:03',1,NULL,NULL,NULL,1,NULL,NULL,80,4,NULL),
(20,'s2341','2@qq.com','c0df5e9750979e9d1b337fb4a49e0400',0,NULL,NULL,'9265781b88651b55d148ab531302b39c.jpg','4bcbc2','2018-04-24','2018-04-24 17:00:26',1,NULL,NULL,NULL,0,NULL,NULL,100,0,NULL),
(21,'liuwt123','liuwt@purple-soft.com','ab8b7e8c15055fa312d9e72a2df097f1',0,NULL,NULL,'9265781b88651b55d148ab531302b39c.jpg','c5b3db','2018-04-24',NULL,1,NULL,NULL,NULL,0,NULL,NULL,100,0,NULL),
(22,'liuwt123','liuwt@purple-soft.com','ec0d0345809767c0569baa9b8f62ae21',0,NULL,NULL,'9265781b88651b55d86d6cd9c0bdd386.jpg','4d28fe','2018-04-24',NULL,1,NULL,NULL,NULL,0,NULL,NULL,100,0,NULL);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
