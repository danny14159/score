<!-- <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> -->
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>学生管理</title>
</head>
<body>     		
			
				<div class="panel panel-default">
				
							<div class="panel-body">
			<span class="prompt_text">学生管理</span>
			<div class="toolbg">
			选择
			年级：
			<select id="at_grade">
				<option value="7">大一</option>
				<option value="8">大二</option>
				<option value="9">大三</option>
				<option value="10">大四</option>
			</select>班级：
			<select id="at_class">
			</select>
						<div class="btn-group">
							<button type="button" class="btn btn-default btn-xs dropdown-toggle"
								data-toggle="dropdown">
								班级导出为 <span class="caret"></span>
							</button>
							<ul class="dropdown-menu" role="menu">
								<li><a  onclick="exportFile();">*.xls(Excel文档)</a></li>
								<li><a >*.doc(Word文档)</a></li>
								<li><a >*.png(图像文件)</a></li>
								<li class="divider"></li>
								<li><a >*.pdf(Adobe PDF文件)</a></li>
							</ul>
						</div>
								
			<button class="btn btn-primary btn-xs" onclick="on_add(this);">添加学生</button>
			<button class="btn btn-default btn-xs btn_import" >从Excel导入</button>
			
			<div class="pagerInfo" style="display:none">
				<span class="prompt_text">#{pageNumber}/#{pageCount}页</span>
				<a  onclick="list(#{pageNumber}-1)" class="prev">上一页&lt;&lt;</a>&nbsp;
				<a  onclick="list(#{pageNumber}+1)" class="next">下一页&gt;&gt;</a>&nbsp;
				共#{recordCount}条记录，每页<select class="pageSize" onchange="list();">
				<option value=10>10</option><option value=20>20</option><option value=30>30</option></select>条记录
				<script>
					$('.pageSize').val(parseInt('#{pageSize}'));
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
					<th width="10%">学号</th>
					<th>姓名</th>
					<th width="8%">性别</th>
					<th width="16%">籍贯</th>
					<th width="21%">家庭住址</th>
					<th width="16%">入学年份</th>
					<th width="15%">选项</th>
				</tr>
				</thead>
				<tbody>
				<tr>
					<td>10</td><td>邓雷</td><td>男</td><td>江苏南通</td><td>地球</td><td>2009</td>
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
			<div class="toolbg">
			
						<div class="btn-group">
							<button type="button" class="btn btn-default btn-xs dropdown-toggle"
								data-toggle="dropdown">
								导出为 <span class="caret"></span>
							</button>
							<ul class="dropdown-menu" role="menu">
								<li><a  onclick="$('#customers').tableExport({type:'doc',escape:'false',ignoreColumn:[3]});">*.xls(Excel文档)</a></li>
								<li><a >*.doc(Word文档)</a></li>
								<li><a >*.png(图像文件)</a></li>
								<li class="divider"></li>
								<li><a >*.pdf(Adobe PDF文件)</a></li>
							</ul>
						</div>
								
			<button class="btn btn-primary btn-xs" onclick="on_add(this);">添加学生</button>
			<button class="btn btn-default btn-xs btn_import" >从Excel导入</button>
			
			
			</div>

					
					</div>
				</div>
	

<div style="display:none" class="hidden">
<div class="btn-group">
		<a class="text-danger" onclick="on_modify( this);"><span class="glyphicon glyphicon-edit"></span>修改</a>
		<a class="text-muted" onclick="on_del( this);"><span class="glyphicon glyphicon-remove"></span>删除</a>
	</div>
	<form enctype="multipart/form-data" target="hideWin" action="excel/studentSheet" method="post" id="fm_xls">
		<input type="file" name="excelFile"/>
		<input type="hidden" name="class_id"/>
		<button type="submit" onclick="return on_upload();" class="btn btn-primary btn-xs">开始上传</button>
		<input class="btn btn-default btn-xs" onclick="on_cancel();" type="button" value="取消"/>
	</form>
	<iframe name="hideWin" style="display: none;">
	</iframe>
</div>

</body>
<script type="text/javascript">
</script>
<script type="text/javascript" src="resources/js/student.js"></script>
<script type="text/javascript" src="resources/ajaxfileupload/ajaxfileupload.js"></script>
</html>