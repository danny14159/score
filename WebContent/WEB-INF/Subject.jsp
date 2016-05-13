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
					
					<th>上课时间</th>
					
					<th>上课地点</th>
					<th>任课老师</th>
					<th	>选项</th>
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
function genOptions(begin,end,unit,cls){
	var sel = $('<select>').addClass(cls);
	for (var i=begin;i<=end; i++){
		sel.append($('<option>').val(i).html(i+unit));
	}
	return sel.get(0).outerHTML;
}
function get7days(){
	var arr = ['日','一','二','三','四','五','六'];
	var sel = $('<select>').addClass('week');
	for(var i in arr){
		sel.append($('<option>').html('周'+arr[i]));
	}
	return sel.get(0).outerHTML;
}
function getPart(){
	return $('<select class="part">')
	.append($('<option>').html('一二节'))
	.append($('<option>').html('三四节'))
	.append($('<option>').html('五六节'))
	.append($('<option>').html('七八节'))
	.append($('<option>').html('九十节')).get(0).outerHTML;
}
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
			'2':{'prop_name':'during',inFormat:function(){
				return get7days() + getPart();
			},outFormat:function($td){
				return [$td.find('.week').val(),$td.find('.part').val(),];
			}},
			3:{'prop_name':'location'},
			4:{
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
		function(json){
			json.weekday=json.during[0];
			json.part=json.during[1];
			
			/* if(!isLaterThan(json.end_hour,json.end_min,json.begin_hour,json.begin_min)){
				delFirstRow($('#tbmain'));
				alert('下课时间不能在上课时间之前');return;
			} */
			console.log(json)
			 $.post(ADD_PATH,json,function(data){
				if(data.ok){
					list();
				}
				else{
					delFirstRow($('#tbmain'));
					alert(json.weekday+json.part+'该老师有课，请重新安排。');
				}
			},'json');
		}
	);
}

function delFirstRow(table){
	table.find("tbody tr:eq(0)").remove();
}
function isLaterThan(ah,am,bh,bm){
	
	if(ah>bh) return true;
	if(ah == bh && am > bm) return true;
	return false;
}


var list=function(){
	
	loadData(
		$("#tbmain"),
		{url:LIST_PATH},
		['id','name',function(data){
			return data.weekday+' '+data.part;
		},'location','teacher_name',$(".btn-group").eq(0).prop('outerHTML')],
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
		alert(data.msg)
	},'json');
}
</script>
</html>