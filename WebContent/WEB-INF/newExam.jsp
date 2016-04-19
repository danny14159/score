<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<!DOCTYPE html>
<html>
<head>
<title>考试管理</title>
<!-- <link href="resources/datepicker/jquery-ui.min.css" rel="stylesheet" media="screen"> -->
<link href="resources/date_input-master/date_input.css" rel="stylesheet" media="screen">
<style type="text/css">
.select_block{
	margin:2px 0;
	padding:0 12px;
	height:30px;
	line-height:30px;
	display:inline-block;
	border:1px solid #fff;
}
.select_block:hover{
	cursor:pointer;
	border:1px solid #60748b;
}
.checked{
	background-color:#d6dbe0;
}
table input{
	width:auto;
	height:auto;
}
</style>
</head>
<body>
				<div class="panel panel-default">
							
							<div class="panel-body">
			<span class="prompt_text"><a  onclick="back();">考试管理</a>&gt;&gt;<span id="pageTitle">新建考试</span></span>
			<button onclick="back();" class="btn btn-link"><small>返回考试管理</small></button>
					
			<table class='table'>
					<tr><td width="20%">
					考试名称：</td><td><input type="text" id="name"/>
					<tr>
					<tr><td>
					考试时间：</td><td>
					<input type='text' class='selectDate' readonly='readonly' id="time"/>
					</td></tr>
					<tr><td>
					考试安排：</td><td id="subjects">
					
					</td></tr>
					<tr><td>备注：</td><td><textarea cols="100" rows="3" id="remark"></textarea></td></tr>
					<tr><td colspan=2><button class="btn btn-primary" onclick="on_save();">确定</button><button class="btn btn-link">保存为方案...</button></td></tr>
					</table>
					
					</div>
				</div>
	


</body>
<script type="text/javascript">

if(window.modifyid!= -1 ){
	$('#pageTitle').html('查看考试安排');
	
	
	
	//填充考试信息
	$.post(getUrl('test','queryById'),{'id':window.modifyid},function(data){
		data=JSON.parse(data)[0];
		$('#name').val(data.test_name);
		$('#time').val(data.date.slice(0,-9));
		$('#remark').val(data.remark);
		
		
		$.post(getUrl('test','querysubject'),{'testid':window.modifyid},function(data){
			data=JSON.parse(data);
			for(var p in data){
				var brick=$('#subjects div[subjectid="'+data[p]['id']+'"]');
				toggleCheck(brick);
				checkSubject(brick);
//				var span=brick.next().children('select');
// 				var s=new Date(data[p]['start_time']);
// 				var e=new Date(data[p]['end_time']);
// 				span.eq(0).val(s.getHours());
// 				span.eq(1).val(s.getMinutes());
// 				span.eq(2).val(e.getHours());
// 				span.eq(3).val(e.getMinutes());
			}
		});
	});

}


var on_save=function(){
	var name=$('#name').val();
	if(name == "") {
		alert('别忘了输入考试名称');return;
	}
	var subjects=[];
	$('#subjects .checked').each(function(){
		var span=$(this).next().children('select');
		subjects.push({
			'subject_id':$(this).attr('subjectid'),
			//'start_time':$('#time').val()+' '+span.eq(0).val()+':'+span.eq(1).val()+':0',
			//'end_time':$('#time').val()+' '+span.eq(2).val()+':'+span.eq(3).val()+':0',
		});
		
	});
	
	var url="";
	if(window.modifyid!= -1 ){
		//修改
		url=getUrl('test','update');
		console.log({
			'test':JSON.stringify({
				'test_name':name,
				'remark':$('#remark').val(),
				'date':$('#time').val(),
				'id':window.modifyid
			}),
			'subjects':JSON.stringify(subjects)
		});
		$.post(url,{
			'test':JSON.stringify({
				'test_name':name,
				'remark':$('#remark').val(),
				'date':$('#time').val(),
				'id':window.modifyid
			}),
			'subjects':JSON.stringify(subjects)
		},function(){
			back();
		});
	}
	else{
	 	url=getUrl('test','addWith');
	 	$.post(url,{
			'test':JSON.stringify({
				'test_name':name,
				'remark':$('#remark').val(),
				'date':$('#time').val(),
			}),
			'subjects':JSON.stringify(subjects)
		},function(){
			back();
		});
	}
	
	//alert(JSON.stringify(subjects));
	
};

var back=function(){
	loadPage('test/','ajaxData');
};
var toggleCheck=function(dom){
	if(typeof $(dom).attr('chk') == 'undefined' || $(dom).attr('chk')==''){
		$(dom).attr('chk','checked')
		.addClass('checked');
	}
	else {
		$(dom).attr('chk','')
		.removeClass('checked');
	}
};
var checkSubject=function(brick){
	if($(brick).attr('chk')=="checked"){
		var hour="<select>";
		
		for(var i = 0;i<14;i++){
			hour+="<option>"+(i+6)+"</option>";
		}
		var min="<select>";
		for (var i = 0;i<6;i++){
			min+="<option>"+(i*10)+"</option>";
		}
		min+="</select>";
		hour+="</select>";
		$(brick).next('span').html("&nbsp;&nbsp;&nbsp;开始时间："+hour+" 时 "+min+" 分 &nbsp;，&nbsp;结束时间："+hour+" 时 "+min+" 分");
	}
	else{
		$(brick).next('span').html('');
	}
}
var d=new Date();
currentDate=d.getFullYear()+'-'+(d.getMonth()+1)+'-'+d.getDate();
window.new_test_time;
var chMonth=['一','二','三','四','五','六','七','八','九','十','十一','十二'];



var initSubject=function(){
	$.post(getUrl('subject','query'),function(data){
		data=JSON.parse(data);
		var html="";
		for(var p in data){
			html+="<div class=\"select_block\" onclick=\"toggleCheck(this);checkSubject(this);\" subjectid="+data[p].id+">"+data[p].name+"</div><span></span><br/>";			
		}
		$('#subjects').html(html);
	});
};
$(function() {
	initSubject();
	$(".selectDate").date_input(); 
});
</script>
</html>