<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
	String path = request.getContextPath();

	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<base href="<%=basePath%>">

<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>${initParam.projectName }</title>
<link href="resources/bootstrap/css/bootstrap.min.css"
	rel="stylesheet" media="screen">
<link href="resources/util.css" rel="stylesheet" media="screen">
<link href="resources/layer/skin/layer.css" rel="stylesheet" media="screen">
<link href="resources/temp.css" rel="stylesheet" media="screen">
</head>
<body>
	<div id="topNav">

		<div class="title">
			<a  class="plane">${initParam.projectName }version 1.0</a>
		</div>

		<div id="loginInfo">
			<a class="plane">Hello,<span class="red" style="background-color: #fff;">&nbsp;${username }&nbsp;</span>[<span id="level"></span>]<small id="userArrow">▼</small></a><br />
			<a onclick="location.reload();">首页</a>&nbsp;&nbsp;<a>|</a>&nbsp;&nbsp;<a >设置</a>
		</div>

		<div id="extra">
			<a >反馈建议</a>&nbsp;&nbsp;<a>|</a>&nbsp;&nbsp;<a >帮助中心</a>&nbsp;&nbsp;<a>|</a>&nbsp;&nbsp;<a
				id="loginOut" href="users/logout">退出</a>
		</div>

	</div>

				<ul id="menu">
					<c:if test="${level eq 1 }">
						<li class="menuItem"><span data-index="0" data-url="class">班级管理</span></li>
						<li class="menuItem"><span data-index="1" data-url="subject">课程管理</span></li>
						<li class="menuItem"><span data-index="2" data-url="student">学生管理</span></li>
					</c:if>
					<c:if test="${level eq 4 }">
						<li class="menuItem"><span data-index="1" data-url="subject/mine">我的课程</span></li>
						<li class="menuItem"><span data-index="1" data-url="student/coursesTable?t=true">查看看表</span></li>
					</c:if>
					<c:if test="${level eq 5 }">
						<li class="menuItem"><span data-index="1" data-url="subject">开设课程</span></li>
						<li class="menuItem"><span data-index="1" data-url="student/listCourses">我的课程</span></li>
						<li class="menuItem"><span data-index="1" data-url="student/coursesTable">查看课表</span></li>
					</c:if>
					<!-- <li class="menuItem"><span data-index="2" data-url="student">学生管理</span></li> -->
					<!-- <li class="menuItem"><span data-index="3" data-url="test">考试管理</span></li> -->
					<!-- <li class="menuItem">
						<span data-index="4">成绩管理</span>
						<ul style="display: none">
							<li><span class="glyphicon glyphicon-search"></span>&nbsp;&nbsp;查询</li>
							<li><span class="glyphicon glyphicon-edit"></span>&nbsp;&nbsp;录入</li>
							<li><span class="glyphicon glyphicon-stats"></span>&nbsp;&nbsp;分析</li>
						</ul>
					</li> -->
					<c:if test="${level eq 1 }">
						<li class="menuItem"><span data-index="5" data-url="user">用户管理</span></li>
					</c:if>
				</ul>
				
			<div id="content">
				<div id="ajaxData">
					<!-- ajaxData里包裹原始内容，即首页内容 -->
					<div id="home">
					<h1><span id="time"></span>好，${username }</h1>
					<hr/>
					<span class="blue">欢迎使用选课系统！</span>
					<!-- <span class="blue">学生：</span>
					<span id="nClass">
						
					</span>
					个班，共<span id="nStudent">
						
					</span>名学生 -->
					<div class="content" style="width:67%;margin-left:0;height:210px;display: none;">
						<div class="contentTitle">快捷入口</div>
						<div class="contentBody">
							<div class="entry prompt_text">
								<img src="resources/img/shortcut/0.png" width="100px" height="100px"><br/>
								班级管理
							</div>
							<div class="entry prompt_text">
								<img src="resources/img/shortcut/1.png" width="100px" height="100px"><br/>
								学生管理
							</div>
							<div class="entry prompt_text">
							<img src="resources/img/shortcut/2.png" width="100px" height="100px"><br/>
								新建考试
							</div>
							<div class="entry prompt_text">
							<img src="resources/img/shortcut/3.png" width="100px" height="100px"><br/>
								成绩录入
							</div>
							<div class="entry prompt_text">
							<img src="resources/img/shortcut/4.png" width="100px" height="100px"><br/>
								成绩查询
							</div>
							<div class="entry prompt_text">
							<img src="resources/img/shortcut/5.png" width="100px" height="100px"><br/>
								用户管理
							</div>
						</div>
					</div>
					</div>
				</div>
				<!-- <div id="content"
					style="height: 230px; width: 80%; margin-top: 20px; display: none;">
					<div id="contentTitle">标题1</div>
					<div id="contentBody">
						
					</div>
				</div> -->
			</div>
			
			<!-- Modal -->
	<div class="modal fade" id="modal_new" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">添加新用户</h4>
				</div>
				<div class="modal-body">
					<div>
						<label>用户名：</label><input type="text" name="username"/>
					</div>
					<div>
						<label>初始密码：</label><input type="text" name="password" value="666666"/>
					</div>
					<div>
						<label>性别：</label>
						<select name="sex">
							<option>男</option>
							<option>女</option>
						</select>
					</div>
					<div>
						<label>电话：</label><input type="text" name="phone"/>
					</div>
					<div>
						<label>邮箱：</label><input type="text" name="email"/>
					</div>
					<div>
						<label>身份：</label>
						<select name="level">
<!-- 							<option value="3">年级主任</option>
 -->							<option value="4">普通教师</option>
						</select>
					</div>
					<button class="btn btn-primary" onclick="submit_user();">提交</button>
				</div>

			</div>
		</div>
	</div>
			
</body>
<script type="text/javascript" src="resources/jquery-1.11.1.min.js"></script>
<!-- <script src="http://g.tbcdn.cn/fi/bui/seed-min.js?t=201404241421"></script>  -->
<script src="resources/bootstrap/js/bootstrap.min.js"></script>
<script src="resources/js/utils.js"></script>
<script src="resources/date_input-master/jquery.date_input.js"></script>
<script src="resources/layer/layer.min.js"></script>
<script type="text/javascript">
	jQuery.extend(DateInput.DEFAULT_OPTS, {
		month_names : [ "一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月",
				"十月", "十一月", "十二月" ],
		short_month_names : [ "一", "二", "三", "四", "五", "六", "七", "八", "九", "十",
				"十一", "十二" ],
		short_day_names : [ "一", "二", "三", "四", "五", "六", "日" ],
		dateToString : function(date) {
			var month = (date.getMonth() + 1).toString();
			var dom = date.getDate().toString();
			if (month.length == 1)
				month = "0" + month;
			if (dom.length == 1)
				dom = "0" + dom;
			return date.getFullYear() + "-" + month + "-" + dom;
		}

	});
	var getTime=function(){
		var h=new Date().getHours();
	
		if(h>=0 && h<11) return '上午';
		else if(h>=11 && h<13) return '中午';
		else if(h>=13 && h<17) return '下午';
		else return '晚上';
	};

	
	$(function() {
		$('#level').text(getIdentity(<%=session.getAttribute("level")%>));
		
		$('#time').text(getTime());
		
		$("#menu>li>span").click(
				function() {
					var self=$(this);
					var index=self.attr('data-index');
					var url=self.attr('data-url');
					if(index == 4){
						//toggle self.next('ul')
						$(self.next('ul').slideToggle(300));
						return ;
					}
					$('#menu').find('span').removeClass("active");
					$('#menu>li>ul>li').removeClass('active');
					self.addClass("active");
					//var urls = [ 'class', 'subject', 'student', 'test', , 'user' ];
					loadPage(url + "/", 'ajaxData');
				}
		);
		$('#menu>li>ul>li').click(function(){
			var self=$(this);
			self.closest('#menu').find('span').removeClass("active");
			self.siblings().removeClass('active');
			self.addClass('active');
			
			var urls = [ 'score', 'score/editScore',  'score/analyseScore'];
			loadPage(urls[self.index()] + "/", 'ajaxData');
		});
		
		//为window对象绑定resize事件
		$(window).resize(function(){
			//设置#menu最小宽度为屏幕高度，如果#ajaxData高度高于屏幕高度，则与其对齐
/*			var _hData=$('#ajaxData').height();
			var _hWindow=this.innerHeight;
			var _hTop=$('#topNav').height();
			if(_hWindow - _hTop > _hData){
				$('#menu').height(_hWindow-_hTop-2);	
			}
			else $('#menu').height(_hData);	
			*/
			var h=$(this).height() - $('#topNav').height();
			$('#menu').height(h);
			$('#content').height(h);
		}).resize();
		//绑定scroll事件
		//滚动式记录上一次的offsetTop。如果上一次的<=0，而这一次的>0，则认为是交界处，执行动画
/*		.scroll(function(){
			var $menu=$('#menu');
			var origin_width=$menu.width();
			
			
			var offsetTop=$('#topNav').get(0).getBoundingClientRect().top+$('#topNav').height();
			
			//console.log(offsetTop,'old='+window.temp);
			if(offsetTop <= 0){
				if($menu.css('position') == "fixed") return;
				$menu.css({
					'position':'fixed',
					'top':0,
					'left':0,
					'height':window.innerHeight,
					'width':origin_width + 15
				});
			}
			else{
				$menu.css({
					'position':'static',
					'width':'auto'
				});
			}
			if(window.temp * offsetTop <=0){
				//$menu.fadeTo(0,0.5).fadeTo(300,1);
			}
			
			window.temp=offsetTop;
		});*/
		
		$('#ajaxData').resize(function(){
			$(window).resize();
		});
		
		
		$('.entry').click(function(){
			var i=$(this).index();
			var shortcut=[0,2,3,4,4,5];
			$('#menu>li').eq(shortcut[i]).children('span').click();
			if(i==2){
				loadPage('test/new','ajaxData');
			}
			else if(i==3) $('#menu>li>ul>li:eq(1)').click();
			else if(i == 4) $('#menu>li>ul>li:eq(0)').click();
		});
		
		/* $.get('class/query',function(data){
			$('#nClass').text(data.length);
		},'json');
		
		$.get('student/query',function(data){
			$('#nStudent').text(100);
		},'json'); */
	});
	var loadPage = function(url, dst_id) {
		
		$.post(url, function(data) {
			$('#' + dst_id).html(data);
			$('#'+dst_id).hide().fadeIn(300);

		});
	};

	/**根据日期"2011-08-05"字符串返回年度和学期对象{'year':'2014-2015','term':1}*/
	var getTerm = function(date) {
		var ds = date.split("-");
		if (ds[1] >= 8 && ds[2] >= 15 || (ds[1] <= 2 && ds[2] <= 14)) {
			return {
				'year' : ds[0] + '-' + (parseInt(ds[0]) + 1),
				'term' : 1
			};
		} else
			return {
				'year' : (parseInt(ds[0]) - 1) + '-' + ds[0],
				'term' : 2
			};
	};
	/**根据年度'2014-2015'和学期1|2，获取日期范围{'date1':'2014-1-1','date2':'2014-2-2'}*/
	//8月到来年1月是上半学期，2月到8月是下半学期
	var getDateRange = function(year, term) {
		var ys = year.split('-');
		if (term == 1)
			return {
				'date1' : ys[0] + '-08-15',
				'date2' : ys[1] + '-02-15'
			};
		else if (term == 2)
			return {
				'date1' : ys[1] + '-02-16',
				'date2' : ys[1] + '-08-14'
			};
	};
	
	
	var getIdentity = function(level){
		var ids = [null,'超级管理员','学校主任','年级主任','教师',"学生"];
		return ids[level];
	}
</script>
</html>