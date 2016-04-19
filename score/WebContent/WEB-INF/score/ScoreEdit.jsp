 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 

	
				<div class="panel panel-default">
							
							<div class="panel-body">


			<span class="prompt_text">成绩录入</span>

			<div class="toolbg">	
			选择
			年级：
			<select id="at_grade" onchange="initClass();">
				<option value=7>初一</option>
				<option value=8>初二</option>
				<option value=9>初三</option>
			</select>

			班级：
			<select id="at_class">
			</select>			
			
			
			考试：
			<select id="year"  onchange="initExam();">
				<option>2014-2015</option>
				<option>2013-2014</option>
				<option>2012-2013</option>
			</select>年度
			<select id="term"  onchange="initExam();">
				<option value=1>第一</option>
				<option value=2>第二</option>
			</select>学期
			<select id="exams">
				<option value="1">月考(2014.8.13)</option>
				<option value="2">期中考试(2014.8.15)</option>
			</select>
							
			
			<button class="btn btn-success btn-xs" onclick="begin_input();">开始录入</button>
			<button class="btn btn-default btn-xs btn_import" >从Excel导入成绩</button>
			</div>
			<div style="display: none;" id="fm_xls">
				<div style="margin: 50px;">
					Excel文件范例： <img src="resources/img/xls_demo.png" alt="演示图片"
						class="img-thumbnail">
					<form enctype="multipart/form-data" target="hideWin"
						action="excel/scoreSheet" method="post">
						<input type="file" name="excelFile" /> 
						<input type="hidden" name="class_id" /> 
						<input type="hidden" name="grade_id" /> 
						<input type="hidden" name="test_id" /> 
						
						<button type="submit" onclick="return on_upload();"
							class="btn btn-primary btn-xs">开始上传</button>
						
					</form>
					<iframe name="hideWin" style="display: none;"></iframe>
				</div>
			</div>

			<div id="main" style="display:none"><br/>
			<small class="gray">小提示：编辑时按 Enter 键提交当前行记录；Esc取消前行编辑</small>
			<table class="table table-condensed table-striped table-hover table-bordered" id="tbmain">
				<thead>
				<tr>
					<th width="8%">学号</th>
					<th width="10%">姓名</th>
					<th>语文</th>
					<th>数学</th>
					<th>外语</th>
					
					<th width="15%">选项</th>
				</tr>
				</thead>
				<tbody>
				
				</tbody>
			</table>
<!-- 			<button class="btn btn-primary" onclick="submitAll();">全部提交</button> -->

				</div>	
					</div>
				</div>
				

<script type="text/javascript">

function on_upload(){
	 if(($('#fm_xls input[name=\'excelFile\']').val()=="")) {
	    	alert("请选择文件！");return false;
	   }
	
    $('#fm_xls input[name=\'class_id\']').val($("#at_class").val());
    $('#fm_xls input[name=\'test_id\']').val($("#exams").val());
    $('#fm_xls input[name=\'grade_id\']').val($("#at_grade").val());
   
    return true;
};

$(function(){
	$('.btn_import').click(function(){
		$('#main').hide();
		$('#fm_xls').show();
	});
})

//提交全部
var submitAll=function(){
}

var on_sort=function(){
	$.post(getUrl('scoreStat','sortByClass'),{
		'class_id':$('#at_class').val(),
		'test_id':$('#exams').val()
	});
	
}


var begin_input=function(){
	$('#main').show();
	$('#fm_xls').hide();
	//获取考试id，班级id,根据考试Id获取考试科目
	//根据以上三个条件查询有成绩的学生，单独列出，可修改和删除
	var testid=$('#exams').val();
	console.log('testid='+testid);
	var classid=$("#at_class").val();
	$.post(getUrl('score','inputBefore'),{
		'test_id':testid,
		'class_id':classid
	});
	$.post(getUrl('test','querysubject'),{
			'testid':testid
		},function(data){
		data=JSON.parse(data);
		
		//开始构建th
		$('#tbmain thead tr th:eq(1)').nextUntil('#tbmain thead tr th:last').remove();
		var editObj={};//调用editTable时传入的columns参数
		for(var p in data){
			$('<th></th>').attr('subjectid',data[p].id).html(data[p].name).width(67/data.length+'%').insertBefore('#tbmain thead tr th:last');
			//---editObj
			editObj[parseInt(p)+2]={'prop_name':data[p].id+''};
			
		}
		window.ite=0;
		window.data=data;
		//构建th结束
		var nsub=data.length;
		
		//使用插件读取
/* 		var columns=['id','name'];
		for(var p1 in data){
			//var subjectid=data[p1].id;
			
			function f(d){
				//同步ajax请求取得成绩
				//console.log(window.data[(window.ite++)%(window.data.length)]);
				var ret="";
				$.ajax({
					'url':getUrl('score','query1'),
					'data':{
						'studentid':d.id,
						'testid':testid,
						'subjectid':window.data[(window.ite++)%(window.data.length)].id
					},
					'async':false,
					'success':function(points){
						points=JSON.parse(points);
						if(points==0) ret="";
						else ret=points;
					}
				});
				return ret;
			};
			
			columns.push(f);
			
		} */
		
		var columns = [ function(d) {
			return d.student.id
		}, function(d) {
			return '<span class="blue">'+d.student.name+'</span>';
		}, ];//构建列参数

		window.ite = 0;
		window.data = data;
		for ( var p in data) {
			columns.push(function(d) {
				var point = 
				searchScore(window.data[(window.ite++)
						% (window.data.length)].id, d.subjectScore);
				return (!point && point == "0")?'':point;
			});
		}
/* 		columns.push(function(d) {
			return d.scoreStat.total_score;
		});
		columns.push(function(d) {
			return d.scoreStat.class_order;
		});
		columns.push(function(d) {
			return d.scoreStat.school_order;
		}); */
		
		columns.push('<a  onclick=$(this).closest("tr").find("td:eq(2)").click();>修改</a>');
		loadData(
			$('#tbmain'),
			{'url':getUrl('scoreStat','query'),'data':{'at_grade':$('#at_grade').val(),'class_id':classid,'test_id':testid}},
			columns,
			function($table){
				selectTr(
						$table,
						function($td){
							//编辑列
							$tr=$td.closest('tr');
							
							editTable($tr,editObj,function(post_json,$tr){
								
								//把post_json保存到$tr中，调用submitData函数来提交
								//$tr.data('post_json',post_json);
								for(var i in post_json){
									if(isNaN(post_json[i]) || post_json=="") post_json[i]="0";
									//alert(post_json[i]);
									$.ajax({
										'url':getUrl('score','inputAfter'),
										'data':{
											'subject_id':i,
											'test_id':$('#exams').val(),
											'stu_id':$tr.children('td:first').text(),
											'score':post_json[i]
										},
										'async':false
									});
// 									showProp({
// 										'subject_id':i,
// 										'test_id':$('#exams').val(),
// 										'stu_id':$tr.children('td:first').text(),
// 										'score':parseFloat(post_json[i])
// 									});
								}
								begin_input();
							});
							$td.find('input').focus();
						},
						[nsub+2]
				);
				
				//为表格每一行绑定keyUp事件，按下回车——提交当前数据，编辑下一行数据
				$table.find('tr:gt(0)').not(':last').each(function(){
					$(this).keyup(function(event){
						if(event.which==13){
							//回车事件
							$(this).find('button.utils_save').click();
							window.edit_index=$(this).index();
							$table.find('tr').eq(window.edit_index).click();
						}
						else if(event.which==27){
							$(this).find('button.utils_cancel').click();
						}
					});
				});
				
			}
		);
		
		return;
	/* 	$.post(getUrl('student','query'),{
			'at_class':classid
		},function(_data){
			_data=JSON.parse(_data);
			
			for(var p in _data){
				var $tr=$('<tr></tr>');
				$('<td></td>').html(_data[p].id).appendTo($tr);
				$('<td></td>').html(_data[p].name).appendTo($tr);
				for(var i = 0;i<nsub;i++){
				//	alert('i='+i);
					$tr.append('<td></td>');
				}
				$tr.append('<td><div><div></td>');
				$('#tbmain tbody').append($tr);
				
				
			}
			$('#tbmain').append('<tr><td colspan='+(nsub+3)+'>共'+_data.length+'条记录</td></tr>');
			
			
			selectTr(
					$('#tbmain'),
					function($tr){
						console.log(editObj);
						editTable($tr,editObj,function(post_json){
							showProp(post_json);
						});
					},
					[nsub+2]
			);
					
		}); */
	});
};


var on_del=function(id){
	delid=id;
	$("#showid").text(id);
	$("#modalDel").modal();
}

var on_modify=function(dom){
	window.utils.alert('MODIFY',"SUCCESS");
	editTable(
		$(dom).closest('tr'),
		{
			'2':{'prop_name':'name'},
			'3':{'prop_name':'master'},
			'4':{'prop_name':'master_phone'},
			
		},
		function(post_json){
			showProp(post_json);
		}
	)
}

var initExam=function(){
	$.post(getUrl('test','query'),getDateRange($('#year').val(),$('#term').val()),function(data){
		data=JSON.parse(data);
		data=data['list'];
		$('#exams').empty();
		for(var p in data){
			$('<option></option>').html(data[p].test_name+'('+data[p].date.slice(0,-9)+')').val(data[p].id).appendTo('#exams');
		}
	});
};

var initClass=function(){
	$.post(getUrl('class', 'query'),{grade:$('#at_grade').val()},function(data){
		data=JSON.parse(data);
		var str="";
		for(var p in data){
			str+="<option value="+data[p].id+">"+data[p].name+"</option>";
		}
		$('#at_class').html(str);
		//list();
	});
};
$(function(){
	initClass();
	initExam();	
});


</script>
