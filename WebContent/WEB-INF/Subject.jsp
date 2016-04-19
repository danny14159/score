<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
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
							
			<button class="btn btn-default btn-xs" onclick="on_add(this);">添加课程</button>
			</div>	
			<table class="table table-condensed table-striped table-hover table-bordered" id="tbmain">
				<thead>
				<tr>
					<th width="10%">课程ID</th>
					<th>课程名称</th>
					<th width="16%">学分</th>
					
					<th width="25%">选项</th>
				</tr>
				</thead>
				<tbody>
				<!-- <tr>
					<td>10</td><td>语文</td><td>100</td>
					<td>
						
					</td>
				</tr> -->
				</tbody>
			</table>
			
			<div class="toolbg">所有课程
							
			<button class="btn btn-default btn-xs" onclick="on_add(this);">添加课程</button>
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
		<a class="text-danger" onclick="on_modify( this);"><span class="glyphicon glyphicon-edit"></span>修改</a>
		<a class="text-muted" onclick="on_del( this);"><span class="glyphicon glyphicon-remove"></span>删除</a>
	</div>
</div>
</body>

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
			'2':{'prop_name':'points'},
		},
		function(post_json){
			showProp(post_json);
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
		['id','name',100,$(".btn-group").eq(0).prop('outerHTML')],
		function($table){
			selectTr($table, 'red', null);
		}
	);
	

};
list();

</script>
</html>