
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<title>班级管理</title>
<style type="text/css">
#tb_detail {
	text-align: center;
}
</style>
</head>
<body>
	<div class="row" style="margin-right: 15px;">
		<div class="col-md-9">


			<div class="panel panel-default" style='border-right: 0;'>

				<div class="panel-body" style='margin-right: -15px;'>

					<span class="prompt_text">班级管理</span>
					<div class="toolbg">

						选择 年级： <select id="at_grade">
							<option value="7">大一</option>
							<option value="8">大二</option>
							<option value="9">大三</option>
							<option value="10">大四</option>
						</select>

						<button class="btn btn-default btn-xs" onclick="on_add(this);">添加班级</button>
					</div>
					<table
						class="table table-condensed table-striped table-hover table-bordered"
						id="tbmain">
						<thead>
							<tr>
								<th width="10%">班级ID</th>
								<th>班级名称</th>
								<th width="20%">人数</th>
								<th width="20%">班主任</th>
								<th width="20%">选项</th>
							</tr>
						</thead>
						<tbody>

						</tbody>
					</table>
					<div class="toolbg">

						<button class="btn btn-default btn-xs" onclick="on_add(this);">添加班级</button>&nbsp;
					</div>


				</div>
			</div>

		</div>
		<div class="col-md-3">
			<div class="content" style="position: fixed; width: 281px;">
				<div class="contentTitle">
					<span class="prompt_text" id='curr_class'></span>&nbsp;&nbsp;开设课程
				</div>
				<div>
					<small>&nbsp;小提示：单击班级记录以查看开设课程</small>
					<div id="detail" style="display: none">
						<table class="table table-condensed" id="tb_detail">
							<thead>
								<tr>
									<th width="30%">课程名称</th>
									<th width="30%">任课教师</th>
									<th>选项</th>
								</tr>
							</thead>

						</table>
						&nbsp;
						<button class="btn btn-primary btn-xs" onclick='add_subject();'>+添加课程</button>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>
<div style="display: none">
	<div class="btn-group">
		<button type="button" class="btn btn-xs btn-link dropdown-toggle"
			data-toggle="dropdown">
			<span class="caret"></span>
		</button>
		<ul class="dropdown-menu" role="menu">
			<li><a>语文</a></li>
			<li><a>数学</a></li>
		</ul>
	</div>

	<div class="btn-group">
		
		<a class="text-danger" onclick="on_modify( this);"><span class="glyphicon glyphicon-edit"></span>修改</a>
		<a class="text-muted" onclick="on_del( this);"><span class="glyphicon glyphicon-remove"></span>删除</a>
		
	</div>


</div>
<script type="text/javascript">
	var add_subject = function() {
		var classid = $('#curr_class').attr('classid');
		insertRecord($('#tb_detail'), {
			'0' : {
				'prop_name' : 'subjectid',
				'inFormat' : function($td) {
					//这里有一个同步请求
					var ret = "";
					$.ajax({
						'async' : false,
						'type' : 'post',
						'success' : function(data) {
							data = JSON.parse(data);
							ret += "<select>";
							for ( var p in data) {
								ret += "<option value="+data[p].id+">"
										+ data[p].name + "</option>";
							}
							ret += '</select>';
						},
						'url' : getUrl('subject', 'query')
					});
					return ret;
				},
				'outFormat' : function($td) {
					return $td.children('select').val();
				}
			},

		}, function(post_json) {
			post_json['classid'] = classid;
			$.post(getUrl('class', 'addSubject'), post_json, function() {
				list_subject(post_json.classid);
			});
		});

	};
	var del_subject = function(obj) {
		if (confirm("确认取消学科：" + obj.name + "？") == false)
			return;
		var classid = $('#curr_class').attr('classid');
		$.post(getUrl('class', 'delSubject'), {
			'subjectid' : obj.id,
			'classid' : classid
		}, function() {
			list_subject(classid);
		});
	};

	var module = 'class';
	var ADD_PATH = getUrl(module, 'add');
	var DEL_PATH = getUrl(module, 'delete');
	var UPD_PATH = getUrl(module, 'update');
	var LIST_PATH = getUrl(module, 'query');

	var on_del = function(dom) {
		if (confirm("确认删除？") == false)
			return;
		var id = $(dom).closest("tr").children('td:first').text();
		$.post(DEL_PATH, {
			'id' : id
		}, function() {
			list();
		});
	};

	var on_modify = function(dom) {
		editTable($(dom).closest('tr'), {
			'1' : {
				'prop_name' : 'name',
				'validator' : function(value) {
					return [ !value == "", "名称不能空" ];
				}
			},
			'3' : {
				'prop_name' : 'teacher'
			},

		}, function(post_json, $tr) {
			post_json['id'] = $tr.children('td:first').text();
			$.post(UPD_PATH, post_json, function() {
				list();
			});
		});
	};
	var on_add = function(dom) {
		window.utils.alert('请填写班级信息！', "ERROR");
		insertRecord($('#tbmain'), {
			'1' : {
				'prop_name' : 'name',
				'validator' : function(value) {
					
					return [ !value == "", "名称不能空" ];
				}
			},
			'3' : {
				'prop_name' : 'teacher'
			},
			'4' : {
				'prop_name' : 'at_grade',
				'inFormat' : function() {
					var grade = $("#at_grade").val();
					var ch = [ '一', '二', '三' ,'四'];
					var str = "<select>";
					for (var i = 0; i < 4; i++) {
						str += "<option value=" + (7 + i)
								+ ((7 + i + '') == grade ? ' selected' : '')
								+ ">大" + ch[i] + "</option>";
					}
					str += "</select>";
					return str;
				},
				'outFormat' : function($td) {
					return $td.children('select').val();
				}
			},
		}, function(post_json) {
			post_json.at_grade=$('#at_grade').val();
			$.post(ADD_PATH, post_json, function() {
				list();
			});
		});

	};

	var list = function() {
		loadData($('#tbmain'), {
			url : LIST_PATH,
			data : {
				'grade' : $('#at_grade').val()
			}
		}, [ 'id', 'name', "nstu", "teacher", 
				$(".btn-group").eq(1).prop('outerHTML') ], function($table) {
			selectTr($table, function($tr) {
				$('#detail').css('display', 'block');
				$('#curr_class').attr('classid',
						$tr.children('td:first').text()).text(
						getGrade($('#at_grade').val())
								+ $tr.children('td:eq(1)').text());
				list_subject($tr.children('td:first').text());
			});
		});

	};
	var list_subject = function(classid) {
		loadData(
				$('#tb_detail'),
				{
					url : getUrl('class', 'querySubject'),
					data : {
						'classid' : classid
					}
				},
				[
						'name',
						'小明',
						function(d) {
							return '<a  class="glyphicon glyphicon-remove" onclick=del_subject('
									+ JSON.stringify(d) + ');></span>';
						} ]);
	};
	$(function() {
		list();
		$("#at_grade").change(function() {
			list();
		});
	});

	var getGrade = function(i) {
		/* var chn = [ '一', '二', '三', '四', '五', '六' ];
		if (i >= 1 && i <= 6)
			return chn[i - 1] + '年级';
		else if (i >= 7 && i <= 9)
			return '初' + chn[i - 7];
		else if (i >= 10 && i <= 12)
			return '高' + chn[i - 10]; */
		return '';
	};
</script>
</html>