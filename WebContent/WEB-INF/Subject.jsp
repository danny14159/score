<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>课程管理</title>

</head>
<body>		
<div class="row" style="margin-right:15px;">
<div class="col-md-12">
				<div class="panel panel-default" style='border-right:0;'>
							
							<div class="panel-body" style='margin-right:-15px;'>
			
			<span class="prompt_text">课程管理</span>
			<div class="toolbg">所有课程
			<c:if test="${level eq 1 }">		
				<button class="btn btn-default btn-xs" onclick="on_add(this);">添加课程</button>
			</c:if>	
			</div>	
			<table class="table table-condensed table-striped table-hover table-bordered" id="tbmain">
				<thead>
				<tr>
					<th width="10%">课程ID</th>
					<th>课程名称</th>
					<th width="16%">上课时间</th>
					<th width="16%">任课老师</th>
					<th width="25%">选项</th>
				</tr>
				</thead>
				<tbody>
				</tbody>
			</table>
			
			<div class="toolbg">所有课程
			<c:if test="${level eq 1 }">
			<button class="btn btn-default btn-xs" onclick="on_add(this);">添加课程</button>
			</c:if>
			</div>	
					
					</div>
				</div>
</div>	
<!-- <div class="col-md-4">
	<div class="content">
		<div class="contentTitle"><span class="prompt_text">语文</span>&nbsp;&nbsp;课程详情</div>
		<div>
			<table class="table">
				<tr><td style="text-align:right">课程名称：</td><td>语文</td></tr>
				<tr><td style="text-align:right">授课教师：</td><td>A老师，B老师，C老师</td></tr>
				<tr><td style="text-align:right">备注：</td><td>(无)</td></tr>
			</table>
		</div>
	</div>
</div> -->
</div>	

<div style="display:none">
<div class="btn-group">
<c:if test="${level eq 1 }">
		<!-- <a class="text-danger" onclick="on_modify( this);"><span class="glyphicon glyphicon-edit"></span>修改</a> -->
		<a class="text-muted" onclick="on_del( this);"><span class="glyphicon glyphicon-remove"></span>删除</a>
		</c:if>
		<c:if test="${level eq 5 }">
			<a class="text-danger" onclick="on_select( this);"><span class="glyphicon glyphicon-edit"></span>选课</a>
		</c:if>
	</div>
</div>
</body>

<div id="tplallteachers" class="hidden">
<select>
	<c:forEach items="${allteachers }" var="i">
		<option value="${i.id }">${i.username }</option>
	</c:forEach>
</select>
</div>

<script type="text/javascript">
var module='subject';
var ADD_PATH=getUrl(module, 'add');
var DEL_PATH=getUrl(module, 'delete');
var UPD_PATH=getUrl(module, 'update');
var LIST_PATH=getUrl(module, 'query');

var on_del=function(dom){
	if(confirm("确认删除？")==false) return;
	var id=$(dom).closest("tr").children('td:first').text();
	$.post(DEL_PATH,{'id':id},function(){
		list();
	});
};

var on_modify=function(dom){
	editTable(
		$(dom).closest('tr'),
		{
			'1':{'prop_name':'name'},
			'2':{'prop_name':'points'},
			
		},
		function(post_json,$tr){
			post_json['id']=$tr.children('td:first').text();
			$.post(UPD_PATH,post_json,function(){
				list();
			});		
		}
	);
};
var on_add=function(dom){
	window.utils.alert('请输入新课程信息','ERROR');
	insertRecord(
		$('#tbmain'),
		{
			'1':{
					'prop_name':'name',
					'validator':function(value){
						return [!value=="","课程名称不能为空！"];
					}
				},
			'2':{'prop_name':'during'},
			3:{
				'prop_name' : 'teacher_id',
				'inFormat' : function() {
					return $('#tplallteachers').html();
				},
				'outFormat' : function($td) {
					return $td.children('select').val();
				}
			}
			/* '4':{'prop_name':'points'}, */
		},
		function(post_json){
			$.post(ADD_PATH,post_json,function(){
				list();
			});
		}
	);
}


var list=function(){
	
	loadData(
		$("#tbmain"),
		{url:LIST_PATH},
		['id','name','during','teacher_name',$(".btn-group").eq(0).prop('outerHTML')],
		function($table){
			selectTr($table, 'red', null);
		}
	);

};
list();

function on_select(dom){
	
	var id=$(dom).closest('tr').find('td:eq(0)').html();
	$.post('/student/selCourse',{
		cid:id
	},function(data){
		if(data){
			alert('选课成功，到“我的课程”查看');
		}
		else{
			alert('抱歉，该课程已经选过了。')
		}
	});
}
</script>
</html>