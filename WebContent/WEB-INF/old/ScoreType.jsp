<!-- <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> -->
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="resources/bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen">
<title></title>
<style type="text/css">
body{
	font-family:'微软雅黑';
}
</style>
</head>
<body>
<div class="container">
	<div class="row">
		<div class="col-md-6 col-md-offset-3">
			<h2 class="page-header">考试管理</h2>
			<button class="btn btn-success" onclick="on_add();"><span class="glyphicon glyphicon-plus"></span>添加新考试...</button>
			<table class="table table-condensed table-striped table-hover table-bordered" id="tbmain">
				<tr><th width="51px">编号</th><th>名称</th><th>备注</th><th>选项</th></tr>
				<tr>
					<td>10</td><td>期中考试</td><td>日期：2014.8.15</td>
					<td>
						<div class="btn-group">
						  <button type="button" class="btn btn-xs btn-link dropdown-toggle" data-toggle="dropdown">
						     <span class="caret"></span>
						  </button>
						  <ul class="dropdown-menu" role="menu">
						 	 <li><a  onclick="on_modify( 1 );">修改</a></li>
						    <li class="divider"></li>
						     <li><a   onclick="on_del( 1 );"><span class="glyphicon glyphicon-remove"></span>删除</a></li>
						  </ul>
						</div>
					</td>
				</tr>
				
				
			</table>
		</div>
	</div>
	
</div>

<!-- Modal ADD-->
<div class="modal fade" id="modalAdd" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
        <h4 class="modal-title" id="modalLabel"></h4>
      </div>
      <div class="modal-body">
			   <form class="form-horizontal" role="form">
			  <div class="form-group">
			    <label for="inputName" class="col-sm-2 control-label">名称</label>
			    <div class="col-sm-10">
			      <input type="email" class="form-control" id="inputName" placeholder="考试名称">
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="inputRemark" class="col-sm-2 control-label">备注</label>
			    <div class="col-sm-10">
			      <textarea class="form-control" id="inputRemark" placeholder="备注（如日期等）"></textarea>
			    </div>
			  </div>
			 
			</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button type="submit" class="btn btn-primary" onclick="add();">提交</button>
      </div>
    </div>
  </div>
</div>

<!-- Modal DELETE-->
<div class="modal fade" id="modalDel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
        <h4 class="modal-title" id="myModalLabel">询问</h4>
      </div>
      <div class="modal-body">
        确定删除id为<span id="showid"></span>的考试？
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
        <button type="button" class="btn btn-primary" onclick="del();">确定</button>
      </div>
    </div>
  </div>
</div>


</body>
<script type="text/javascript" src="resources/jquery-2.1.0.min.js"></script>
<script src="resources/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript">
var ADD_PATH="add";
var DEL_PATH="delete";
var UPD_PATH="update";
var LIST_PATH="listById";

var delid,modid;



var on_del=function(id){
	delid=id;
	$("#showid").text(id);
	$("#modalDel").modal();
}
var del=function(){
	$("#modalDel").modal('hide');
	$.post(DEL_PATH,{
		'id':delid
	},function(){
		list();
	});
}
var on_modify=function(id){
//	alert(id);
	$("button[type='submit']").attr("onclick","modify();");
	modid=id;
	$.post(LIST_PATH,{
		'id':modid
	},function(data){
		data=JSON.parse(data);
		data=data[0];
		$("#inputName").val(data.score_name);
		$("#inputRemark").val(data.remark);
	});
	$("#modalLabel").text("修改考试信息");
	$("#modalAdd").modal();
}
var modify=function(){
	$("#modalAdd").modal('hide');
	$.post(UPD_PATH,{
		'score_name':$("#inputName").val(),
		'remark':$("#inputRemark").val(),
		'id':modid
	},function(){
		list();
	})
}
var on_add=function(){
	$("button[type='submit']").attr("onclick","add();");
	$("#inputName").val('');
	$("#inputRemark").val('');
	$("#modalLabel").text("新建考试");
	$("#modalAdd").modal();
}
var add=function(){
	$("#modalAdd").modal('hide');
	
	$.post(ADD_PATH,{
		'score_name':$("#inputName").val(),
		'remark':$("#inputRemark").val()
	},function(){
		list();
	})
}

var list=function(){
	
	$.post(LIST_PATH,{},function(data){
//		alert(data);
		data=JSON.parse(data);
		var html="";
//		data=[{'id':'1','score_name':'期末考试','remark':'备注'},{'id':'2','score_name':'期末考试','remark':'备注2'}];
		for(var p in data){
			html+="<tr><td>"+data[p].id+"</td><td>"+data[p].score_name+"</td><td>"+data[p].remark+"</td>";
			html+="<td><div class=\"btn-group\">"+
			 ' <button type="button" class="btn btn-xs btn-link dropdown-toggle" data-toggle="dropdown">'+
		     '<span class="caret"></span> </button><ul class="dropdown-menu" role="menu"> <li><a  onclick="on_modify( '+data[p].id+' );">修改</a></li>'+
		    ' <li class="divider"></li><li><a   onclick="on_del( '+data[p].id+' );"><span class="glyphicon glyphicon-remove"></span>删除</a></li> </ul></div></td>';
			html+='</tr>';
		}
		
		$("#tbmain tr:gt(0)").remove();
		$("#tbmain").append(html);
	})
}
list();
</script>
</html>