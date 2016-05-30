 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<style>

#setupLine{
}
#setupLine >div{
	margin-left: 100px;
	width:60%;
}
#setupLine input{
	border:0;
	border-bottom: 1px solid #999;
}
#setupLine table td{
	text-align: center;
}
#setupLine button{
	padding-left: 40px;
	padding-right: 40px;
}
#analyseResult table{
	margin:0 0 20px 15px;
}
#analyseResult table caption{
	font-size:16px;
	line-height: 2em;
	font-weight: bold;
}
.tb_rate caption{
	color: blue;
}
.tb_order caption{
	color:red;
}
#pageContent{
	width:inherit;
}
#top_setting .ListItem{
	margin-bottom: 10px;
}
#top_setting .ListItem li{
	margin: 4px 50px;
}
#top_setting .ListItem button.btn_del{
	margin:0;
}
hr{
	height:2px;
	background: #f8b551;
	margin:10px 0;
}
div.TabView{
	margin-top:15px;
}
</style>
<div class="panel panel-default">
	<div class="panel-body">
		<span class="prompt_text">成绩分析</span>
			<div class="toolbg">
				选择 年级： <select id="at_grade" onchange="initClass();">
					<option value=7>初一</option>
					<option value=8>初二</option>
					<option value=9>初三</option>
				</select>  考试： <select id="year" onchange="initExam();">
					<option>2014-2015</option>
					<option>2013-2014</option>
					<option>2012-2013</option>
					
				</select>年度 <select id="term" onchange="initExam();">
					<option value=1>第一</option>
					<option value=2>第二</option>
				</select>学期 <select id="exams" onchange="nextStep();">
					<option value="1">月考(2014.8.13)</option>
					<option value="2">期中考试(2014.8.15)</option>
				</select>
			</div>
			
			
				<div id="setupLine"><h4>设置分析参数</h4><hr/>
					<div>1、设置各科分数线
					<table class="table table-bordered table-condensed table-striped" id="tb_lines">
						<tr><th>科目/分数线</th><th class="blue">优秀线</th><th class="gray">及格线</th><th class="red">差分线</th></tr>
					</table>2、显示年级<div id="top_setting"></div>
					<button class="btn btn-default" onclick="beginAnalyse();"><strong>开始分析</strong></button>
					</div>
				</div>
				<div id='analyseResult'><h4><img src="resources/img/ok.gif" style="width:30px;height:30px;">&nbsp;分析结果已生成<small>&nbsp;单击左侧选项卡查看详情</small></h4><hr/>
					<button class="btn btn-xs btn-default" onclick="exportAllClasses();">批量导出各班分析结果</button>
					<button class="btn btn-xs btn-default" onclick="exportGrade();">导出年级分析结果</button>
					<button class="btn btn-xs btn-link" onclick="backToSetting();">&lt;&lt;返回分数线设置</button>
					<br/>
					<div style="display: none">
					<table class="table table-striped table-condensed table-bordered tb_rate">
						<caption>成绩分析表</caption>
						<tr><th>科目</th><th class="blue">优秀率</th><th class="blue">优秀人数</th><th class="gray">及格率</th><th class="gray">及格人数</th>
							<th class="red">差分率</th><th class="red">差分人数</th><th>平均分</th></tr>
					</table>
					<table class="table table-striped table-condensed table-bordered tb_top">
						<caption>名次人数分布表</caption>
						<tr></tr>
					</table>
					<table class="table table-striped table-condensed table-bordered tb_rate_grade">
						<caption>名次人数分布表</caption>
						<tr><th>班级</th><th class="blue">优秀率</th><th class="blue">优秀人数</th><th class="gray">及格率</th><th class="gray">及格人数</th>
						<th class="red">差分率</th><th class="red">差分人数</th><th>平均分</th></tr>
					</table>
					<table class="table table-striped table-condensed table-bordered tb_top_grade">
						<caption>年级各班名次人数分布</caption>
						<tr><th>班级</th></tr>
					</table>
					</div>
				</div>
			
	</div>
	
</div>
<script type="text/javascript">
	//ths:[string] 
	//returns 
	var genTableHead=function(ths){
		
	}
	var loadContent=function(dom_id){
		var all_ids=['setupLine','analyseResult'];
		
		for(var p in all_ids){
			if(all_ids[p] == dom_id){
				$('#'+all_ids[p]).show();
			}
			else $('#'+all_ids[p]).hide();
		}
	};
	
	var backToSetting=function(){
		//将结果中的TabView删除，再跳转到设置页面
		$('div#analyseResult>div.TabView').remove();
		loadContent('setupLine');
	};
	var querySubject = function() {
		
	};
	var initClass = function(callback) {
		$.post(getUrl('class', 'query'), {
			grade : $('#at_grade').val()
		}, function(data) {
			data = JSON.parse(data);
			window.classInfo = data;
			if(callback) callback(data);
		});
	};
	var nextStep = function() {
		backToSetting();
		
		//查询考试科目 填充设置分数线 表格
		$.post(getUrl('test', 'querysubject'), {
			'testid' : $('#exams').val(),
		}, function(data) {
			data = JSON.parse(data);
			window.subjectInfo=data;
			
			$('#tb_lines tr:gt(0)').remove();
			for(var p in data){
				var $tr=$('<tr>');
				$tr.append('<td><span data-id='+data[p].id+'>'+data[p].name+'</span></td>');
				
				$tr.append('<td><input type="text" value="90"/></td>');
				$tr.append('<td><input type="text" value="60" /></td>');
				$tr.append('<td><input type="text" value="30" /></td>');
				
				$('#tb_lines').append($tr);
			}
		});
	};
	
	//获取分析参数的函数
	function getAnalysis(){
		//首先记录下分析参数
		var lines=[];
		$('#tb_lines tr:gt(0)').each(function(){
			var tds=$(this).children("td");
			var line={};
			line[tds.eq(0).children('span').attr('data-id')]=[tds.eq(1).children('input').val(),tds.eq(2).children('input').val(),tds.eq(3).children('input').val()];
			lines.push(line);
		});
		//lines=JSON.stringify(lines);
		
		var topx=[];
		$('div#top_setting>div.ListItem ul.items li').children('.topx').each(function(){
			var x=$(this).val();
			if( x=="" || isNaN(x) || x<0  || x==null) return;
			for(var p in topx){
				if(x == topx[p] ) return;
			}
			topx.push(x);
		});
		//topx=JSON.stringify(topx);
		
		return {
			'lines':lines,
			'topx':topx,
			'at_grade':$('#at_grade').val(),
			'test_id':$('#exams').val(),
		}
	}
	
	var processNull = function(result){
		if(!result) {
			alert("未返回查询结果。可能有同学成绩没有录入。");
			layer.close(window.lindex);
			backToSetting();
			return false;
		}
		return true;
	};
	
	var beginAnalyse = function() {
		
		var analysis = getAnalysis();
		var lines = analysis.lines;
		var topx = analysis.topx;
		
		//获取TAB中的内容
		var tabContent=function(by){
			if(by ==  'class'){
				return function(){
					//conext =dom a
					
					var self=$(this);
					
					var class_name=$('#at_grade option:selected').text() + self.children('span').text()+'&nbsp;'  ;
					
					var tb_top=$('#analyseResult > div > table.tb_top').clone().removeClass('tb_top').attr('id','tb_top');
					tb_top.children('caption').prepend('<span class="blue">'+class_name+"</span>");
					for(var p in topx){
						tb_top.find('tr').append('<th>'+'年级前&nbsp;'+topx[p]+'</th>');
					}
					
					var tb_rate=$('#analyseResult > div > table.tb_rate').clone().removeClass('tb_rate').attr('id','tb_rate');
					tb_rate.children('caption').prepend('<span class="blue">'+class_name+"</span>");
					
					
					return tb_rate.get(0).outerHTML + (topx.length == 0 ? "" : tb_top.get(0).outerHTML) ;
				};
			}
			else if(by == 'grade'){
				return '';
			}
		};
		//alert(JSON.stringify(lines));
		
		//显示分析结果，并提供导出功能
		var view=new TabView();
		initClass(function(classz){
			loadContent('analyseResult');
			view.add({
				title:'年级情况',
				content:tabContent('grade'),
				callback:function(tabview){
					
					var tb_rate_grade=$('#analyseResult > div > table.tb_rate_grade').clone().removeClass('tb_rate_grade');
					var tb_top_grade=$('#analyseResult > div > table.tb_top_grade').clone().removeClass('tb_top_grade');
					
					//根据科目来渲染表格
					window.lindex = layer.load("正在分析...",0);
					$.ajax({
						dataType:'json',
						type:'post',
							'url':getUrl('scoreAnalysis','getResult'),
						data:	{
						param:JSON.stringify({
							at_grade:$('#at_grade').val(),
							test_id:$('#exams').val(),
							type:'grade',
						}),
						'lines':JSON.stringify(lines)/* .slice(1,JSON.stringify(lines).length-1) */,
						'topx':JSON.stringify(topx),
					},
					error:function(){
						processNull();
						
					},
					success:function(result){
						if(!processNull(result)) return ;
						//result={Rate:{"语文":[["一班","20%",50,"20%",50,"20%",50,85.5]]},"Top":[["一班",10,20,30,]]};
						
						var rate=result.Rate;
						var top=result.Top;
						
						for(var prop in rate){
							//每一个属性都对应一张rate表格
							var obj=rate[prop];
							var _t_rate_grade=tb_rate_grade.clone();
							_t_rate_grade.find('caption').text(prop);
							
							loadData(_t_rate_grade,{
								fill_data:obj,
								animation:false,
								bottomRow:false
							},[0,1,2,3,4,5,6,7]);
							tabview.content.append(_t_rate_grade);
						}
						
						
						var col=[];
						for(var i = 0;i <= topx.length;i++){
							col.push(i);
						}
						for(var p in topx){
							tb_top_grade.find('tr:first').append('<td>年级前 ' + topx[p] + '</td>');
						}
						loadData(tb_top_grade,{
							fill_data:top,
							animation:false,
							bottomRow:false
						},col);
						
						tabview.content.append(tb_top_grade);
						layer.close(lindex);
					}
					});
				}
			});
			for(var p in classz){
				view.add({
					title:'<span data-id='+classz[p].id+' >'+classz[p].name+'</span>',
					content:tabContent('class'),
					callback:function(tabview){
						var tb_rate=tabview.content.find('#tb_rate');
						var class_id=this.children('span').attr('data-id');
						
						var tb_top=tabview.content.find('#tb_top');
						var col=[];
						for(var i = 0;i < topx.length;i++){
							col.push(i);
						}
						$.post(getUrl('scoreAnalysis','getResult'),{
							param:JSON.stringify({
								at_grade:$('#at_grade').val(),
								test_id:$('#exams').val(),
								'class_id':class_id,
								type:'class',
							}),
							'lines':JSON.stringify(lines),
							'topx':JSON.stringify(topx),
						},function(result){
							loadData(tb_rate, {
								fill_data:result.TableRateRecord,
								animation:false,
								bottomRow:false
							}, [0,1,2,3,4,5,6,7]);
							
							loadData(tb_top, {
								fill_data:[result.TableTopRecord],
								animation:false,
								bottomRow:false
							}, col);
							
						},'json');
					},
				});
			};
			view.appendTo('analyseResult');
			view.resize();
		});
	};
	var initExam = function() {
	
	$.post(getUrl('test', 'query'), getDateRange($('#year').val(), $('#term').val()), function(data) {
			data = JSON.parse(data);
			data = data['list'];
			$('#exams').empty();
			for ( var p in data) {
				$('<option></option>').html(
						data[p].test_name + '(' + data[p].date.slice(0, -9)
								+ ')').val(data[p].id).appendTo('#exams');
			}
			nextStep();
		});
	};
	
	$(function() {
		initExam();
		
		window.list=new ListItem('top_setting');
		list.appendTo();
		list.addItem('前<select  class="topx"><option>10</option><option>20</option><option>30</option><option>40</option></select>名');
		list.addItem('前<select  class="topx"><option>10</option><option selected>20</option><option>30</option><option>40</option></select>名');
		list.addItem('前<select  class="topx"><option>10</option><option >20</option><option>30</option><option>40</option><option selected>50</option></select>名');
		list.addItem('前<select  class="topx"><option>10</option><option >20</option><option>30</option><option>40</option><option selected>100</option></select>名');

		
		list.onNewItem(function(){
			this.addItem('前<input type="text" size="5"  class="topx" value=""/>名');
		});
	});
	
	var exportAllClasses = function(){
		var analysis = getAnalysis();
		analysis.topx = JSON.stringify(analysis.topx);
		analysis.lines = JSON.stringify(analysis.lines);
		var p={
				param:JSON.stringify(analysis)
		};
		window.location = getUrl('writeExcel','getAllClassesAnalysis')+'?'+$.param(p);
	}
	var exportGrade = function(){
		var analysis = getAnalysis();
		analysis.topx = JSON.stringify(analysis.topx);
		analysis.lines = JSON.stringify(analysis.lines);
		var p={
				param:JSON.stringify(analysis)
		};
		window.location = getUrl('writeExcel','getGrageAnalysis')+'?'+$.param(p);
	}
</script>