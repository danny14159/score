<!-- <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> -->
<!DOCTYPE html>
<html>
<head>

</head>
<body>			
			<div class="panel panel-default">
							<div class="panel-body">
			<span class="prompt_text">考试管理</span>
			<div class="toolbg">
			选择		
			<select id="year" onchange="list();">
				<option>2014-2015</option>
				<option>2013-2014</option>
				<option>2012-2013</option>
				<option>2011-2012</option>
			</select>年度
			<select id="term" onchange="list();">
				<option value=1>第一</option>
				<option value=2>第二</option>
			</select>
			学期
							
			<button class="btn btn-success btn-xs" onclick="on_add(this);">新建考试</button>
			
			<div class="pagerInfo" style="display:none">
				<span class="prompt_text">#{pageNumber}/#{pageCount}页</span>
				<a  onclick="list(#{pageNumber}-1)" class="prev">&lt;&lt;上一页</a>&nbsp;
				<a  onclick="list(#{pageNumber}+1)" class="next">下一页&gt;&gt;</a>&nbsp;
				共#{recordCount}条记录，每页<select id="pageSize" onchange="list();">
				<option value=10>10</option><option value=20>20</option><option value=30>30</option></select>条记录
				<script>
					$('#pageSize').val(parseInt('#{pageSize}'));
					if('#{pageNumber}' == '#{pageCount}' || '#{pageCount}' == '0') {
						$('.next').hide();
					}
					else $('.next').show();
					if('#{pageNumber}' == '1'){
						$('.prev').hide();
					}
					else $('.prev').show();
				</script>
			</div>
			</div>		
			<table class="table table-condensed table-striped table-hover table-bordered" id="tbmain">
				<thead>
				<tr>
					<th width="10%">考试ID</th>
					<th>考试名称</th>
					<th width="16%">考试日期</th>
					<th width="16%">考试安排</th>
					<th width="16%">备注</th>
					<th width="15%">选项</th>
				</tr>
				</thead>
				<tbody>
				<tr>
					<td>10</td><td>月考</td>
					<td>2009.8.12</td><td><a >查看</a></td><td>备注一</td>
					<td>
						<div class="btn-group">
						  <button type="button" class="btn btn-xs btn-link dropdown-toggle" data-toggle="dropdown">
						     <span class="caret"></span>
						  </button>
						  <ul class="dropdown-menu" role="menu">
						 	 <li><a  onclick="on_modify( this);">修改</a></li>
						    <li class="divider"></li>
						     <li><a   onclick="on_del( 1 );"><span class="glyphicon glyphicon-remove"></span>删除</a></li>
						  </ul>
						</div>
					</td>
				</tr>		
				
				</tbody>
			</table>
			<div class="toolbg">&nbsp;
			<button class="btn btn-success btn-xs" onclick="on_add(this);">新建考试</button>
			<div class="pagerInfo" style="display:none">
				<span class="prompt_text">#{pageNumber}/#{pageCount}页</span>
				<a  onclick="list(#{pageNumber}-1)" class="prev">&lt;&lt;上一页</a>&nbsp;
				<a  onclick="list(#{pageNumber}+1)" class="next">下一页&gt;&gt;</a>&nbsp;
				共#{recordCount}条记录，每页#{pageSize}条记录
				<script>
					if('#{pageNumber}' == '#{pageCount}' || '#{pageCount}' == '0') {
						$('.next').hide();
					}
					else $('.next').show();
					if('#{pageNumber}' == '1'){
						$('.prev').hide();
					}
					else $('.prev').show();
				</script>
			</div>
			</div>	

					
					</div>
				</div>

</body>

<script type="text/javascript">
window.modifyid= -1;

var module='test';
var ADD_PATH=getUrl(module, 'add');
var DEL_PATH=getUrl(module, 'delete');
var UPD_PATH=getUrl(module, 'update');
var LIST_PATH=getUrl(module, 'query');


var initTerm=function(){
	var d=new Date();
	var M=d.getMonth()+1;
	var year=d.getFullYear();
	if(M == 1 || M>=8){
		$('#term').val(1);
		year=year+'-'+(parseInt(year)+1);
	}
	else if(M>=2 && M<=7){
		$('#term').val(2);
		year=parseInt(year)-1+'-'+year;
	}
	$('#year').val(year);
};
$(function(){
	initTerm();
});

var on_del=function(id){
	delid=id;
	$("#showid").text(id);
	$("#modalDel").modal();
}

var on_modify=function(dom){
	editTable(
			$(dom).closest('tr'),
			{
				'1':{
						'prop_name':'test_name',
						'validator':function(value){
							return [!value=="","姓名不能为空"];
						}
					},
				'4':{'prop_name':'remark'}
			},
			function(post_json,$tr){
				post_json['id']=$tr.children("td:first").text();
				$.post(UPD_PATH,post_json,function(){
					list();
				});
			}
		);
};
var on_add=function(dom){
	loadPage('test/new','ajaxData');	
};

var on_del=function(dom){
	if(confirm("确认删除？")==false) return;
	var id=$(dom).closest("tr").children('td:first').text();
	$.post(DEL_PATH,{'id':id},function(){
		list();
	});
};

var look_arrange=function(dom){
	modifyid=$(dom).closest("tr").children('td:first').text();
	loadPage('test/new','ajaxData');	
}

var list=function(pageNumber){
	if(typeof pageNumber=="undefined") pageNumber=1;
	loadData(
		$('#tbmain'),
		{url:LIST_PATH,data:getDateRange($('#year').val(),$('#term').val())},
		['id','test_name',function(value){
			return value['date'].slice(0,-9);
		},'<a  onclick="look_arrange(this)">查看</a>','remark','<a  onclick="on_modify(this);">修改基本信息</a>&nbsp;&nbsp;<a   onclick="on_del(this);"><span class="glyphicon glyphicon-remove"></span></a>'],null,
		{
			'pageNumber':pageNumber,
			'pageSize':$('#pageSize').val(),
			'retdom':'.pagerInfo'
		}
	);
};
list();

</script>
</html>