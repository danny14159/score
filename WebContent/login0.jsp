<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<title>登录成绩管理系统</title>
<%
	String path = request.getContextPath();

	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="resources/reset.css" rel="stylesheet" media="screen">
<style type="text/css">
body{
	font-family: '微软雅黑','宋体'
}
#header{
	height: 62px;
	border-bottom: 1px solid #d6dfea;
	background: #eff4fa; 
}
#header h1{
	color:#225592;
	line-height: 62px;
	margin-left: 15em;
	font-size: 16px;
}
#footer{
	position: fixed;
	left:0;
	bottom: 0;
	color:#868686;
	background-color: #eff4fa;
	border-top:1px solid #d6dfea;
	clear:both;
	height:34px;
	width:100%;
	
	line-height: 34px;
	text-align: center;
	font-size: 12px;
}
#content{
	width:960px;
	margin:0 auto;
	padding:0 32px;
	height:500px;
	margin-top: 72px;
}
#content .advert{
	height:372px;
	width: 530px;
	margin-left: 25px;
	margin-bottom: 60px;
	float: left;
}
#content .login_wrapper{
	float:right;
	height:322px;
	border:1px solid #a0b1c4;
	width: 334px;
	background-color: #fff;
	position: relative;
	padding: 0px;
	margin: 0 20px 0 0;
	border-radius: 5px;
	overflow: hidden;
}
.login_wrapper .header{
	height:50px;
	border-bottom: 1px solid #c0cdd9;
	background-color: #f9fbfe;
	position: relative;
}
#content .loginTips{
	height: 28px;
	padding-top: 4px;
	width:282px;
	line-height: 28px;
	font-size: 12px;
	color:red;
}
#content .header{
	color: #333;
	display: inline-block;
	height: 45px;
	line-height: 45px;
	width:100%;
	padding-left: 15px;
}
#content .inputOuter{
	border: 1px solid #ccc;
	height: 38px;
	width: 282px;
	border-radius: 2px;
	margin:10px auto;
	margin-top: 0;
}
#content .inputOuter>input{
	top: 0px;
	padding: 10px 40px 10px 10px;
	left: 0px;
	border-radius: 3px;
	width: 232px;
	position: relative;
	height: 18px;
	line-height: 18px;
	border: 0;
	background: 0;
	color: #333;
	font-size: 16px;
}
#content .inputOuter>input:focus{
	background:#fffaf3; 
	border:1px solid #F90; 
	box-shadow: 0 0 6px 0 rgba(0, 0, 0, 0.15);
}
#btn_submit{
	background-color: #5a98de;
	outline: none;
	border-radius: 3px;
	
	border:none;
	height: 40px;
	line-height: 40px;
	width: 100%;
	
	color:#fff;
	font-size:16px;
	font-weight:bold;
	width: 282px;
	margin-top:10px;
}
#btn_submit:hover{
	cursor:pointer;
	background-color: rgb(106,162,224);
}
#btn_submit:active{
	background-color: #5a98de;
}
#content .form_wrapper{
	width:282px;
	margin:0 auto;
}
#content .bottom{
	margin-bottom: 12px;
	width: 282px;
	bottom: 2px;
	font-size: 12px;
	text-align: right;
	color: #bfbfbf;
	position: absolute;
}
#content .bottom a{
	color: #225592;
	text-decoration: none;
}
#content .bottom a:hover{
	text-decoration: underline;
}
</style>
</head>
<body>
<div id="header">
	<h1>欢迎登录&nbsp;&nbsp;成绩管理系统</h1>
</div>
<div id="content">
	<div class="advert">
	</div>
	<div class="login_wrapper">
		<div class="header">
			<span>请输入用户名和密码</span>
		</div>
		
		<div class="form_wrapper">
		
			<div class="loginTips"></div>
			
			<div class="inputOuter" >
				<input type="text" placeholder="用户名" id="username"/>
			</div>
			
			<div class="inputOuter">
				<input type="password" placeholder="密码" id="password"/>
			</div>
			
			<button id="btn_submit">登 录</button>
			
			<div class="bottom">
				<a href="#">忘了密码？</a>&nbsp;&nbsp;|&nbsp;&nbsp; 
				<a href="#">意见反馈</a>
			</div> 
		</div>
	</div>
</div>

<div id="footer">
	All Rights Reserved
</div>
</body>
<script type="text/javascript" src="resources/jquery-2.1.0.min.js"></script>
<script type="text/javascript">

var showTip=function(msg){
	$('#content div.loginTips').html(msg);
}
$(function(){
	//按钮绑定事件
	$('#btn_submit').click(function(){
		var username=$('#username').val();
		var password=$('#password').val();
		if(!username){
			showTip('您还没有输入帐号！')
			return;
		}
		if(!password){
			showTip('您还没有输入密码！');return;
		}
		
		$.post("users/login?d="+new Date().getTime(), 
				{
			"username" : username,
			"password" : password
		}, function(data) {
			
			if(data.ok){
				window.location.href="test2/";
			}
			else{
				showTip(data.msg);
			}
		},'json');

	});
	
	$('#username').focus(function(){
		showTip('');
	});
	$('#password').focus(function(){
		showTip('');
	});
});
</script>
</html>
