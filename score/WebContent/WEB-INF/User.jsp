<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style type="text/css">
#add {
	margin-top: 5px;
}
#modal_new label{
	width:30%;
	text-align: right;
	margin-right: 20px;
	height:2em;
}
</style>

	<div class="panel panel-default">
		<div class="panel-body">
			<span class="prompt_text">用户管理</span>
			<div class="toolbg">
				<button id="add" class="btn btn-default btn-xs" data-toggle="modal"
					data-target="#modal_new">添加用户</button>
			</div>
			<table
				class="table table-condensed table-striped table-hover table-bordered"
				id="tbmain">
				<thead>
					<tr>
						<th width="10%">编号</th>
						<th width="15%">用户名</th>
						<th width="6%">性别</th>
						<th width="16%">电话号码</th>
						
						<th>邮箱</th>
						<th>身份</th>
						<th width="15%">选项</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>111</td>
						<td>abc</td>
						<td>男</td>
						<td>13999999999</td>
						<td>abc@qq.com</td>
						<td></td>
					</tr>
				</tbody>
			</table>
			<div class="toolbg">
				<button id="add" class="btn btn-default btn-xs" data-toggle="modal"
					data-target="#modal_new">添加用户</button>
			</div>
		</div>
	</div>

	<div style="display: none" class="hidden">
		<div class="btn-group">
			<a class="text-danger" onclick="on_modify( this);"><span
				class="glyphicon glyphicon-edit"></span>修改</a> <a class="text-muted"
				onclick="on_del( this);"><span
				class="glyphicon glyphicon-remove"></span>删除</a>
		</div>
	</div>

	

<script type="text/javascript">
	var module = 'user';
	var ADD_PATH = getUrl(module, 'add');
	var DEL_PATH = getUrl(module, 'delete');
	var UPD_PATH = getUrl(module, 'update');
	var LIST_PATH = getUrl(module, 'queryall');
	var list = function() {
		loadData($('#tbmain'), {
			url : LIST_PATH
		}, [ 'id', 'username', 'sex', 'phone', 'email',function(d){return getIdentity(d.level)},
				$(".hidden .btn-group").eq(0).prop('outerHTML') ], null

		);
	};
	function add() {
		$("#modal_new").modal('show');
	};

	$(function() {
		list();
	});

	
	
	var on_del = function(dom) {
		if (confirm("确认删除？") == false)
			return;
		var id = $(dom).closest("tr").children('td:first').text();
		$.get(DEL_PATH, {
			'id' : id
		}, function() {
			list();
		});
	};

	var on_modify = function(dom) {
		editTable($(dom).closest('tr'), {
			'1' : {
				'prop_name' : 'username',
				'validator' : function(value) {
					return [ !value == "", "用户名不能为空" ];
				}
			},
			'2' : {
				'prop_name' : 'sex'
			},
			'3' : {
				'prop_name' : 'phone',
				'validator' : function(value) {
					return [ !value == "", "电话号码不能为空" ];
				}
			},
			'4' : {
				'prop_name' : 'email'
			},
		}, function(post_json, $tr) {
			post_json['id'] = $tr.children("td:first").text();
			$.post(UPD_PATH, post_json, function() {
				list();
			});
		});
	};
	
	
	var submit_user = function(){
		$.post(getUrl('user','add'),{
			username:$('input[name="username"]').val(),
			password:$('input[name="password"]').val(),
			phone:$('input[name="phone"]').val(),
			email:$('input[name="email"]').val(),
			level:$('select[name="level"]').val(),
			sex:$('select[name="sex"]').val(),
		},function(){
			$("#modal_new").modal('hide');
			list();
		});
	};
</script>
