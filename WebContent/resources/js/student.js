/**
 * 学生js
 */

var exportFile=function(){
	window.location=getUrl('writeExcel','getStudentExcel')+"?class_id="+$('#at_class').val()+'&studentItem=[\'学号\',\'姓名\',\'性别\',\'籍贯\',\'家庭住址\',\'入学年份\']';
};

var importXls=function(){
};
var initClass=function(){
	$.post(getUrl('class', 'query'),{grade:$('#at_grade').val()},function(data){
		data=JSON.parse(data);
		var str="";
		for(var p in data){
			str+="<option value="+data[p].id+">"+data[p].name+"</option>";
		}
		$('#at_class').html(str);
		list();
	});
};
$(function() {
	$('.btn_import').click(function(){
		$(this).popover({
			content:$('#fm_xls').prop('outerHTML'),
			html:true
		});
		
	}).click();
	
	initClass();
	$('#at_grade').change(function(){
		initClass();
	});
	
	$("#at_class").change(function(){
		list();
	});
});
function on_upload(){
    $('#fm_xls input[name=\'class_id\']').val($("#at_class").val());
    if(($('#fm_xls input[name=\'excelFile\']').val()=="")) {
    	alert("请选择文件！");return false;
    }
    return true;
};
function on_cancel(){
	$('.btn_import').popover('hide');
};

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
			'0':{
				'prop_name':'id',
				'validator':function(value){
					return [!value=="","学号不能空"];
				}
			},
			'1':{
					'prop_name':'name',
					'validator':function(value){
						return [!value=="","姓名不能为空"];
					}
				},
			'2':{'prop_name':'sex'},
			'3':{
					'prop_name':'location',
					'validator':function(value){
						return [!value=="","籍贯不能为空"];
					}
				},
			'4':{'prop_name':'address'},
			'5':{'prop_name':'enterYear'},
		},
		function(post_json,$tr){
			post_json['id']=$tr.children("td:first").text();
			//showProp(post_json);
			$.post(UPD_PATH,post_json,function(){
				list();
			});
		}
	);
};
var on_add=function(dom){
	window.utils.alert('请填写学生信息',"ERROR");
	insertRecord(
		$('#tbmain'),
		{
			'0':{
					'prop_name':'id',
					'validator':function(value){
						return [!value=="","学号不能空"];
					}
				},
			'1':{
					'prop_name':'name',
					'validator':function(value){
						return [!value=="","姓名不能空"];
					}
				},
			'2':{
					'prop_name':'sex',
					'inFormat':function($td){
						return '<select><option value="男">男</option><option value="女">女</option></select>';
					},
					'outFormat':function($td){
						return $td.children('select').val();
					}
				},
			'3':{'prop_name':'location'},
			'4':{'prop_name':'address'},
			'5':{'prop_name':'enterYear'},
		},
		function(post_json){
			post_json['at_class']=$("#at_class").val();
			$.post(ADD_PATH,post_json,function(){
				list();
			});
		}
	);
	
};




var list=function(pageNumber){
	if(!$("#at_class").val()) return ;
	
	if(typeof pageNumber=="undefined") pageNumber=1;
	loadData(
		$('#tbmain'),
		{url:LIST_PATH+'?atclass='+$("#at_class").val() },
		['id','name','sex','location','address','enterYear',$(".hidden .btn-group").eq(0).prop('outerHTML')],null,
		{
			'pageNumber':pageNumber,
			'pageSize':$('.pageSize').val(),
			'retdom':'.pagerInfo'
		}
	);
};

var module='student';
var ADD_PATH=getUrl(module, 'add');
var DEL_PATH=getUrl(module, 'delete');
var UPD_PATH=getUrl(module, 'update');
var LIST_PATH=getUrl(module, 'queryPage');

