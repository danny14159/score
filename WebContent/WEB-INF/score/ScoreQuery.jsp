
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<style>

#good,#bad,#common{
	font-size:12px;
}

#setting{
	width:50%;
}
#setting input{
	width:80%;
	border-top:none;
	border-left:none;
	border-right:none;
	border-bottom:1px solid #999; 
	background-color:transparent;
}
table{
	margin-bottom:20px!important;
	margin-top:0;
}
#anchors{
	margin-top:20px;
	margin-left:10px;
	margin-bottom:10px;
}
#anchors a{
	margin-right:8px;
}


#export_tool li{
	display:inline-block; 
	margin: 10px 0;
}
</style>
	<div class="panel panel-default">
		<div class="panel-body">

			<div class="btn-group">
				<span class="prompt_text">成绩查看</span>

			</div>
			<br />
			<div class="toolbg">
				选择 年级： <select id="at_grade" onchange="initClass();">
					<option value=7>初一</option>
					<option value=8>初二</option>
					<option value=9>初三</option>
				</select> <!-- 隐藏的班级元素 -->
			<select id="at_class" style="display: none">
			</select>	
				 考试： <select id="year" onchange="initExam();">
					<option>2014-2015</option>
					<option>2013-2014</option>
					<option>2012-2013</option>
					
				</select>年度 <select id="term" onchange="initExam();">
					<option value=1>第一</option>
					<option value=2>第二</option>
				</select>学期 <select id="exams">
					<option value="1">月考(2014.8.13)</option>
					<option value="2">期中考试(2014.8.15)</option>
				</select>

				<select id="sortBy">
					<option value=1>按学号排序</option>
					<option value=2>按班级排名排序</option>
				</select>


			<button type="button" class="btn btn-success btn-xs" onclick="showScore($('#sortBy').val())">开始查询</button>




		</div>

			<div id="main" style="display: none">
					
					<ul  id="export_tool">
						<li><button class="btn btn-default btn-xs" onclick="exportScore(1)">导出该班成绩</button></li>
						<li><button class="btn btn-default btn-xs" onclick="exportScore(2);">导出年级成绩</button></li>
						<li><button class="btn btn-danger btn-xs" onclick="updateRank()">更新排名</button></li>
					</ul>

				
				
				<table
					class="table table-condensed table-striped table-hover table-bordered"
					id="tbmain" style="display: none">
					<thead>
						<tr>

						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
				
				<div class="toolbg"></div>
			</div>
		</div>
		<div id="no_record" style="display: none;text-align: center;">
			<img src="resources/img/404.jpg" style="margin: 150px 0"/>没有查询到成绩，试试
					<button class="btn btn-link btn-xs"
						onclick="loadPage('score/editScore','ajaxData');">成绩录入</button>
		</div>

	</div>

<script type="text/javascript">
window._t = {};

//更新排名按钮的操作
var updateRank = function(){
	layer.load("排名中，请稍后...",0);
	var class_id = [];
	$('.tabs>li>a>span').each(function(){
		class_id.push($(this).attr('data-id'));
	});
	$.post(getUrl('scoreStat','sort'),{
		'class_id':JSON.stringify(class_id),
		'test_id':$('#exams').val(),
		'at_grade':$('#at_grade').val()
	},function(data){
		layer.closeAll();
		layer.msg(data,1,1);
		//alert(0);
		//window._t.click_index=$('.tabs>li').has('a.active').index();
		showScore($('#sortBy').val());
		
	})
}

var exportAnalysis=function(){
	var lines=[];
	var flag=true;
	$('#setting').find('tr:gt(0)').each(function(){
		var $tr=$(this);
		var subjectid=$tr.find('td:first span').attr('subjectid');
		
		var line=[];
		$tr.children('td:gt(0)').each(function(){
			var num=$(this).children('input').val();
			if(isNaN(num)){
				alert('分数线必须为数字！');flag=false; return false;
			}
			if(num==""){
				alert('请填写分数线！'); flag=false;return false;
			}
			line.push(num);
		});
		var obj={};
		obj[subjectid]=line;
		lines.push(obj);
	});
	
	if(!flag)
		return;
	
	window.location=getUrl('writeExcel','getScoreAnalysisExcel')+'?'+json2Url({
		'class_id':$('#at_class').val(),
		'test_id':$('#exams').val(),
		'analysisSet':JSON.stringify({'lines':lines}),
		'schoolTopx':$('#schoolTopx').val(),
		'classTopx':$('#classTopx').val()
	});
};

var beginAnalyse=function(){
	$('#result').show();
	$('#classTop10').show();
	
	$('#schoolTop10').show();
	
	var lines=[];
	var flag=true;
	$('#setting').find('tr:gt(0)').each(function(){
		var $tr=$(this);
		var subjectid=$tr.find('td:first span').attr('subjectid');
		
		var line=[];
		$tr.children('td:gt(0)').each(function(){
			var num=$(this).children('input').val();
			if(isNaN(num)){
				alert('分数线必须为数字！');flag=false; return false;
			}
			if(num==""){
				alert('请填写分数线！'); flag=false;return false;
			}
			line.push(num);
		});
		var obj={};
		obj[subjectid]=line;
		lines.push(obj);
	});
	//console.log(lines);
	
	if(!flag)
		return;
	
	$.ajax({
		'url':getUrl('scoreAnalysis','rate'),
		'data':{
			'class_id':$('#at_class').val(),
			'test_id':$('#exams').val(),
			'analysisSet':JSON.stringify({'lines':lines}),
			'schoolTopx':$('#schoolTopx').val(),
			'classTopx':$('#classTopx').val()
		},
		'contentType': false, 

		'processData': true,
		'success':function(ret){
			
			alert('分析结果已生成');
			ret=JSON.parse(ret);
			
			//学校前10
			var $schoolTop10=$('#schoolTop10');
			$schoolTop10.find('tr:gt(0)').remove();
			var schoolTop10=ret.schoolTopX;
			for(var p in schoolTop10){
				var e=schoolTop10[p];
				$('<tr></tr>').append('<td>'+e.stu_id+'</td>').append('<td><span class=blue>'+e.stu_name+'</span></td>').append('<td>'+e.total_score+'</td>')
				.append('<td>'+e.school_order+'</td>').appendTo($schoolTop10);
			}
			$("#schoolTop10Num").text(schoolTop10.length);
			$('#schoolTopX').text($('#schoolTopx').val());
			
			//班级前10
			var $classTop10=$('#classTop10');
			$classTop10.find('tr:gt(0)').remove();
			var classTop10=ret.classTopX;
			for(var p in classTop10){
				var e=classTop10[p];
				$('<tr></tr>').append('<td>'+e.stu_id+'</td>').append('<td><span class=blue>'+e.stu_name+'</span></td>').append('<td>'+e.total_score+'</td>')
				.append('<td>'+e.class_order+'</td>').appendTo($classTop10);
			}
			$("#classTop10Num").text(classTop10.length);
			$('#classTopX').text($('#classTopx').val());
			
			//班级整体情况
			var $result=$('#result');$result.find('tr:gt(0)').remove();
			var result=ret.rates;
			
			for(var i in result){
				var e =result[i];
				for(var j in e){
					$('<tr></tr>').append('<td>'+getSubjectName(j)+'</td>').append('<td>'+formatRate(e[j][0])+'</td>')
					.append('<td>'+formatRate(e[j][1])+'</td>').append('<td>'+formatRate(e[j][2])+'</td>').
					appendTo($result);
				}
			};
			
			location.hash="anchor_r";
		},
		'type':'get',
		'cache':false
	});
	
};

var formatRate=function(f){
	var str= (f.toFixed(3)).slice(2)+"";
	//str
	var last=str.charAt(str.length-1);
	str=str.slice(0, -1)+'.'+last+'%';
	
	return str.replace(/(0)+/,'');
}


var getSubjectName=function(subjectid){
	for(var p in window.data){
		if(subjectid==window.data[p].id) return window.data[p].name;
	}
	return "";
};

var AnalyseScore=function(back){
	var analyse=$('#analyse');
	
	if(back===true){
		$('#tbmain').show();
		analyse.hide();return;
	}
	
	//开始分析结果
	var subjects=window.data;

	$('#setting').find('tr:gt(0)').remove();
	for(var p in subjects){
		$('<tr>').append('<td><span subjectid='+subjects[p].id+'>'+subjects[p].name+'</span></td>')
		.append('<td><input type="text" value="90" class="good" style="font-size:12px;" size=3 /></td>')
		.append('<td><input type="text" value="60" class="common" style="font-size:12px;" size=3 /></td>')
		.append('<td><input type="text" value="30" class="bad" style="font-size:12px;" size=3 /></td>').appendTo($('#setting'));
		
	}
	
	$('#tbmain').hide();
	
	analyse.show();
	$('#result').hide();
	$('#classTop10').hide();
	$('#schoolTop10').hide();
};

	var exportScore = function(i) {
		var class_id=$(".TabView>.tabs a.active span").attr('data-id');
		if (i == 1) {
			window.location = getUrl('writeExcel', 'getClassScoreExcel')
					+ "?class_id=" + class_id + "&test_id="
					+ $('#exams').val();
		} else if (i == 2) {
			window.location = getUrl('writeExcel', 'getSchoolScoreExcel')
					+ "?at_grade=" + $('#at_grade').val() + "&test_id="
					+ $('#exams').val();
		}
	};

	var initExam = function() {
		$.post(getUrl('test', 'query'),
			getDateRange($('#year').val(),$('#term').val())
		,function(data) {
			data = JSON.parse(data);
			data = data['list'];
			$('#exams').empty();
			for ( var p in data) {
				$('<option></option>').html(
						data[p].test_name + '(' + data[p].date.slice(0, -9)
								+ ')').val(data[p].id).appendTo('#exams');
			}
		});
	};

	var initClass = function() {
		$.post(getUrl('class', 'query'), {
			grade : $('#at_grade').val()
		}, function(data) {
			data = JSON.parse(data);
			var str = "<option value='all'>所有班级</option>";
			for ( var p in data) {
				str += "<option value="+data[p].id+">" + data[p].name
						+ "</option>";
			}
			$('#at_class').html(str);
		});
	};

	var showScore2 = function(orderby) {

		if (typeof orderby == "undefined") {
			orderby = 'id';
		}
		//$('#main').show();
		//获取考试id，班级id,根据考试Id获取考试科目
		//根据以上三个条件查询有成绩的学生，单独列出，可修改和删除
		var testid = $('#exams').val();
		//alert('testid='+testid);
		var classid = $("#at_class").val();

		$.post(getUrl('test', 'querysubject'), {
			'testid' : testid,
			'orderby' : orderby
		}, function(data) {
			data = JSON.parse(data);

			//====开始构建th
			//$('#tbmain thead tr th:eq(1)').nextUntil('#tbmain thead tr th:last').remove();
			//var editObj={};//调用editTable时传入的columns参数

			var totalCol = data.length;
			var eachWidth = 100 / totalCol + '%';
			$('#tbmain thead tr').empty();
			$('<th></th>').html('学号').width(eachWidth).appendTo(
					'#tbmain thead tr');
			$('<th></th>').html('姓名').width(eachWidth).appendTo(
					'#tbmain thead tr');
			for ( var p in data) {
				$('<th></th>').attr('subjectid', data[p].id).html(data[p].name)
						.width(eachWidth).appendTo('#tbmain thead tr');

				
			}
			$('<th></th>').html('总分').width(eachWidth).appendTo(
					'#tbmain thead tr');
			$('<th></th>').html('班级排名').width(eachWidth).appendTo(
					'#tbmain thead tr');
			$('<th></th>').html('年级排名').width(eachWidth).appendTo(
					'#tbmain thead tr');

			//====构建th结束
			var nsub = data.length;

			window.ite = 0;
			window.data = data;				//将学科保存到全局
			//使用插件读取
			var columns = [ 'id', 'name' ];
			for ( var p1 in data) {
				//var subjectid=data[p1].id;

				function f(d) {
					//同步ajax请求取得成绩
					//console.log(window.data[(window.ite++)%(window.data.length)]);
					var ret = "";
					$.ajax({
						'url' : getUrl('score', 'query1'),
						'data' : {
							'studentid' : d.id,
							'testid' : testid,
							'subjectid' : window.data[(window.ite++)
									% (window.data.length)].id
						},
						'async' : false,
						'success' : function(points) {
							points = JSON.parse(points);
							if (points == 0)
								ret = "";
							else
								ret = points;
						}
					});
					return ret;
				}
				;

				columns.push(f);

			}

			//		columns.push('<a >修改</a>');
			columns.push(function(d) {
				return getStat(d.id)['total_score'];
			});
			columns.push(function(d) {
				return getStat(d.id)['class_order'];
			});
			columns.push(function(d) {
				return getStat(d.id)['school_order'];
			});

			loadData($('#tbmain'), {
				'animation':false,
				'url' : getUrl('student', 'query'),
				'data' : {
					'at_class' : classid
				}
			}, columns);
		});
	};

	var _gData = {};//用于存储全局的成绩统计信息变量

	var getStat = function(studentid) {
		if (studentid in _gData)
			;
		else {
			$.ajax({
				'url' : getUrl('scoreStat', 'queryById'),
				'data' : {
					'student_id' : studentid,
					'test_id' : $('#exams').val()
				},
				'async' : false,
				'success' : function(_data) {
					_data = JSON.parse(_data);
					_gData[studentid] = _data;
				}
			});
		}
		if (_gData[studentid] == null)
			return {
				'total_score' : 0,
				'class_order' : 0,
				'school_order' : 0
			};
		return _gData[studentid];
	};

	//根据科目id搜索数组中的某一科成绩，return分数
	var searchScore = function(subjectid, scores) {
		for ( var i in scores) {
			if (scores[i].subject_id == subjectid)
				return scores[i].score;
		}
		return 0;
	};

	var showScore = function(orderby) {
		$('#main').show();
		$('#tbmain').show();
		$('#no_record').hide();
		$('#analyse').hide();

		if (typeof orderby == "undefined") {
			orderby = 1;
		}

		var testid = $('#exams').val();
		//alert('testid='+testid);

		//构建表格
		//首先查询考试科目，然后查成绩
		$.post(getUrl('test', 'querysubject'), {
			'testid' : testid,
			'orderby' : orderby
		}, function(data) {
			data = JSON.parse(data);
			//====开始构建th
			//$('#tbmain thead tr th:eq(1)').nextUntil('#tbmain thead tr th:last').remove();
			//var editObj={};//调用editTable时传入的columns参数

			var totalCol = data.length + 5;
			var eachWidth = 100 / totalCol + '%';
			$('#tbmain thead tr').empty();
			$('<th></th>').html('学号').width(eachWidth).appendTo(
					'#tbmain thead tr');
			$('<th></th>').html('姓名').width(eachWidth).appendTo(
					'#tbmain thead tr');
			for ( var p in data) {
				$('<th></th>').attr('subjectid', data[p].id).html(data[p].name)
						.width(eachWidth).appendTo('#tbmain thead tr');
				//---editObj
				//editObj[parseInt(p)+2]={'prop_name':data[p].id+''};
			}
			$('<th></th>').html('总分').width(eachWidth).appendTo(
					'#tbmain thead tr');
			$('<th></th>').html('班级排名').width(eachWidth).appendTo(
					'#tbmain thead tr');
			$('<th></th>').html('年级排名').width(eachWidth).appendTo(
					'#tbmain thead tr');

			//====构建th结束

			//===开始填充表格数据
			var columns = [ function(d) {
				return d.student.id
			}, function(d) {
				return '<span class="blue">'+d.student.name+'</span>';
			}, ];//构建列参数

			window.ite = 0;
			window.data = data;
			for ( var p in data) {
				columns.push(function(d) {
					return searchScore(window.data[(window.ite++)
							% (window.data.length)].id, d.subjectScore)
				});
			}
			columns.push(function(d) {
				return d.scoreStat.total_score;
			});
			columns.push(function(d) {
				return d.scoreStat.class_order;
			});
			columns.push(function(d) {
				return d.scoreStat.school_order;
			});

			var url = "";
			if (orderby == 1)
				url = "query";
			else if (orderby == 2)
				url = "queryByClassOrder";
			
			//加载数据.选择的“全部班级”
			//if(classid==null){
				$('#tbmain').hide();
				var tabview=new TabView();
				window.$classes=$('#at_class option:gt(0)');
				$classes.each(function(){
					tabview.add({
						title:'<span data-id="'+$(this).val()+'">'+$(this).html()+'</span>',
						content:function(){
							var data_id=$(this).children('span').attr('data-id');
							return $('#tbmain').clone().attr('id','tb'+data_id).show();
						},
						callback:function(tabview){
							var $a=$(this);
							//console.log($(this));
							var class_id=$(this).children('span').attr('data-id');
							window.class_id = class_id;
							
							$('#tb'+class_id).find('tr:gt(0)').remove();//清除表格原来的数据
							
							//ajax获取表格数据
							loadData($('#tb'+class_id), {
								'animation':false,
								'url' : getUrl('scoreStat', url),
								'data' : {
									'class_id' : class_id,
									'test_id' : $('#exams').val(),
									'at_grade' : $('#at_grade').val()
								}
							}, columns, function($table, data) {
								if (data.length == 0 ) {
									//$('#no_record').show();
									//$('#main').hide();
								}
								
								tabview.restore($a);
								tabview.resize();
								
							});
						},
						cache:true
					});
				});
				
				
				//在before之前，先删除原来的TabView
				$('div#main div.TabView').remove();
				
				tabview.element($('div#main')).insertBefore($('div#main .toolbg:last'));
				
				//tabview.cacheAll();
				tabview.clickFirst();
				tabview.resize();
				
				return;
				//在表格前构建跳转到表格的锚点
				var anchor="跳转到=>";
				//alert(location);
				$('#at_class option:gt(0)').each(function(index){
					anchor+="<a href='"+location+"#_aClassid"+index+"'>"+$(this).html()+"</a>";
				});
				$("<div id='anchors'></div>").html(anchor).insertBefore('#tbmain');
				
				window.$classes=$('#at_class option:gt(0)');
			
				$classes.each(function(index){
					//克隆主表格，填充表格数据
					$('#tbmain').clone().attr('id','tbmain'+index).insertBefore('#tbmain');
					
					var self=this;
					loadData($('#tbmain'+index), {
						'animation':false,
						'url' : getUrl('scoreStat', url),
						'data' : {
							'class_id' : $(this).val(),
							'test_id' : testid,
							'at_grade' : $('#at_grade').val()
						}
					}, columns, function($table, data) {
						$table.before('<div class="contentTitle" id="_aClassid'+index+'">'+$(self).html()+'</div>').css('margin-top',-5);
						
					});
				});
				$('#tbmain').hide();
				
			//}
			//之前要清除元素
			$('#tbmain').siblings('table').remove();
			//在before之前，先删除原来的TabView
			$('div#main div.TabView').remove();
			
			loadData($('#tbmain'), {
				'animation':false,
				'url' : getUrl('scoreStat', url),
				'data' : {
					'class_id' : classid,
					'test_id' : testid,
					'at_grade' : $('#at_grade').val()
				}
			}, columns, function($table, data) {
				if (data.length == 0 ) {
					$('#no_record').show();
					$('#main').hide();
				}
			});
			//===数据填充结束
		});
	};

	$(function() {
		initClass();
		initExam();
		
	});
</script>
