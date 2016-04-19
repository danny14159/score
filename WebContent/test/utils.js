//销毁之前的表格，填充ajax请求到的新数据
window.utils={};
/**
 * $.post(url,data,callback)
 * colums=[
 * 	'attr1','attr2',format(d)
 *	]
 * index表示对应td的index
 * 传入字符串表示取得对应属性的值
 * 传入函数表示自定义的值
 * 	·函数参数d表示该行js返回对象
 * 	·format函数应该返回字符串作为表格的渲染
 * 
 * callback($table,data)渲染完成后的回调函数，不管是否返回数据都会执行,loadData返回callback函数的返回值
 * fPager:分页对象。其中包含分页信息pageNumber(1~x),pageSize，用于装载返回数据的DOM(retdom),
 * 		检测#{pageNumber}类似的数据进行替换
 * 返回的数据中list为数据,分页信息新增pageCount,recordCount,
 */

var loadData=function($table,params,columns,callback,fPager){
	if(typeof params.data == "undefined") params.data={};
	if('object' == typeof fPager){
		params.data['pageNumber']=fPager['pageNumber'];
		params.data['pageSize']=fPager['pageSize'];
	}
	
	var nths=$table.find("tr").children("th").size();
	
	/**ajax函数的返回数据应该是一个对象数组[{...}...]*/
	$.ajax({
			'beforeSend':function(){
				//销毁表格
				$table.find("tr:gt(0)").remove();
				$table.append('<tr><td colspan='+nths+' style=\'text-align:center;color:#888;\'><img src="resources/img/onload.gif">正在加载，请稍后...</div></div></td></tr>');
			},
			'error':function(){
				//错误时调用的函数
				alert('loadData请求发生错误');
			},
			'complete':function(){
			},
			'url':params.url,
			'data':params.data,
			'success':function(data){
				if(data=="") {
					alert('错误的返回类型');return;
				}
				
		if(data!=null)
			data=JSON.parse(data);
		
		
		if(data==null || data.length == 0){
			
			$table.find("tr:gt(0)").remove();
			//构建表格
			$table.append("<tr><td colspan="+nths+" style='text-align:center;color:#888;'>暂无数据</td></tr>");
			if('undefined'!=typeof callback && callback!= null) return callback($table,data);
			else return;
		}
		
		//分页处理
		if('object' == typeof fPager && 'undefined' != typeof fPager['retdom']){
			var pager=data['pager'];
			data=data['list'];
			$(fPager['retdom']).each(function(){
				//实现时要现在dom中存一个隐藏的副本，然后再执行替换显示
				var domObj=$(this);
				
				if(typeof domObj.data('originHTML') == "undefined"){
					domObj.data('originHTML',domObj.html());
				}
				else {
					domObj.html(domObj.data('originHTML'));
				}
				
				domObj.html(replaceAttr(domObj.html(),pager)).show();
			});
			//$(fPager['retdom']).html(replaceAttr(str,pager));
			
		};
		
		//普通表格渲染
		var tbody="";
		for(var p in data){
			tbody+="<tr>";
			//tbody+="<td></td>";
			for(var i in columns){
				tbody+="<td>";
				if(columns[i] in data[p]){
					tbody+=data[p][columns[i]];
				}
				else if(typeof columns[i] == "function"){
					var ret=columns[i](data[p]);
					tbody+=(typeof ret=="undefined"?"":ret);
				}
				else tbody+=columns[i];
				tbody+="</td>";
			}
			tbody+="</tr>";
		}
		tbody+="<tr><td colspan="+nths+" style='text-align:center;color:#888;'>共"+data.length+"条记录</td></tr>";
		
		$table.find("tr:gt(0)").remove();
		//$table.find('thead tr').prepend('<th width=8px></th>');
		//构建表格
		//$table.css('display','none');
		$table.append(tbody).fadeIn(300);
		
		if('undefined'!=typeof callback && callback!= null) return callback($table,data);
		}
	}
	);
};

/**
 * 使该行表格可编辑，函数在列最后一个td中，隐藏先前元素，并加入ok,cancel表示提交或者撤销操作
 * 	$tr表示要编辑的tr对象
 * 	columns数组对象{'0':{'prop_name','inFormat':function($td){return string},'outFormat','validator'},'2':...,'4':...,...},键值对，key:td所在的索引,value:对象
 * prop_name:对应json对象的属性名称
 * validator:function(string value){return [boolean,msg]}
 * 	callback:function(post_json,$tr){}---用于点击OK时的回调函数
 */
//window.utils.fEdit=false;//保存是否处于编辑状态
var editTable=function($tr,columns,callback,fAdd){
	if($tr.data('fEdit')===true){
		return;
		//window.utils.alert('===你有尚未保存的内容，请先保存！===', "ERROR" );
	}
	else{
		$tr.data('fEdit',true);
	}
	//window.utils.fEdit=true;
	//函数中要把值用隐藏内容的<div>包裹起来，点取消的时候可以unwrap
	for(var p in columns){
		var $td=$tr.children("td").eq(p);
		var str_append="";
		if(typeof columns[p].inFormat =="function"){
			str_append=columns[p].inFormat($td);
		}
		else{
			//$td.css('padding',0);//所有有input的td的padding都为0
			var width=$td.width();
			var font_size=$("body").css('font-size').slice(0,-2);
			//console.log(font_size);
			var size=width/font_size;
			str_append='<input type="text" size="'+size+'" value="'+$td.html()+'" class="util_input"/>';
		}
		if($td.contents().size()==0){
			$td.html('<div style="display:none" class="util_wrapper"></div>');
		}else{
			$td.contents().wrap('<div style="display:none" class="util_wrapper"></div>');
		}
		$td.append(str_append);
	}
	var str_btn = "<button class='btn btn-primary btn-xs utils_save'><span class='glyphicon glyphicon-ok'></span>确定</button>"
		+ "<button class='btn btn-danger btn-xs utils_cancel'><span class='glyphicon glyphicon-remove'></span>取消</button>";
	$tr.children("td").last().contents().wrap('<div style="display:none"></div>');
	$tr.children("td").last().append(str_btn);
	
	$tr.filter(':has(input.util_input)').css('height',28).css('over-flow','hidden');
	//使第一个input获取焦点
	//$tr.find('input:first').focus();
	//动画
//	$tr.hide().show(200,function(){
//		$tr.fadeTo(200,0.5,function(){
//			$tr.fadeTo(200,1);
//		});
//	});
	
	//点击cancel的调用
	$tr.find(".utils_cancel").click(function(){
		$tr.data('fEdit',false);
		if(fAdd===true){
			//如果是add操作，点取消时会删除新加的行
			$tr.remove();
			return;
		}
		for(var p in columns){
			var $td=$tr.children("td").eq(p);
			$td.children('div.util_wrapper:last').nextAll().remove();
			var cont=$td.children('div.util_wrapper').contents();
			if(cont.size()!=0)
				cont.unwrap();
			else $td.children('div.util_wrapper').remove();
		}
		
		$tr.children("td").last().find('button.utils_cancel').remove();
		$tr.children("td").last().find('button.utils_save').remove();
		$tr.children("td").last().children('div').contents().unwrap();
	});
	//点击确定的操作
	$tr.find(".utils_save").bind("click",[callback,$tr,columns],function(d){
		$tr.data('fEdit',false);
		
		if(typeof d.data[0]=='undefined') return;//如果没有回调函数则直接返回
		_$tr=d.data[1];
		_columns=d.data[2];
		
		//开始做验证
		var result=[];//验证结果
		for(var p in _columns){
			var _$td=$tr.children("td").eq(p);
			
			if(typeof _columns[p].validator =="function"){
				var value="";
				if(typeof _columns[p].prop_name == "string"){
					if(typeof _columns[p].outFormat == "function"){
						value=_columns[p].outFormat(_$td);
					}else{
						value=_$td.children('input.util_input').val();
					}
				}
				var ret=_columns[p].validator(value);
				if(ret[0]===false){
					result.push(ret[1]);
				}
			}
		}
		if(result.length!=0){
			alert('===Sorry!您输入的数据存在以下问题：===\n\n\t'+result.join('\n\t')+'\n\n===未能完成提交===');
			return;
		}
		
		//开始封装数据
		var post_json={};
		for(var p in _columns){
			var _$td=$tr.children("td").eq(p);
			
			if(typeof _columns[p].prop_name == "string"){
				if(typeof _columns[p].outFormat == "function"){
					post_json[_columns[p].prop_name]=_columns[p].outFormat(_$td);
				}else{
					post_json[_columns[p].prop_name]=_$td.children('input.util_input').val();
				}
			}
			_$td.children('div.util_wrapper:last').nextAll().remove();
			var cont=_$td.children('div.util_wrapper').contents();
			if(cont.size()!=0)
				cont.unwrap();
			else _$td.children('div.util_wrapper').remove();
		}
		$tr.children("td").last().find('button.utils_cancel').remove();
		$tr.children("td").last().find('button.utils_save').remove();
		$tr.children("td").last().children('div').contents().unwrap();
		
		d.data[0](post_json,_$tr);
	});
};

/**插入一条记录
 * */
var insertRecord=function($table,columns,callback){
	
	var fEdit;
	$table.find('tr').each(function(){
		if($(this).data('fEdit')) {
			alert('===你有尚未保存的内容，请先保存！===');fEdit=true;
		}
	});
	if(fEdit===true) return;
	
	var ntds=$table.find('tr:first th').size();
	var str_new_tr="<tr>";
	for(var i=0;i<ntds;i++) str_new_tr+="<td></td>";
	str_new_tr+="</tr>";
	
	$table.prepend(str_new_tr);
	
	var newtr=$table.find('tr:eq(1)');
	editTable(newtr,columns,callback,true);
	
	
	
};

var showProp=function(obj){
	var str="";
	for(var p in obj){
		str+=p+"="+obj[p]+",";
	}
	alert(str);
};


/**
 * 弹出信息框函数
 * 	msg_html:信息文本
 * duration:持续时间对象{show:..,during:..fade:..}单位:ms，有默认值
 *	type:类型 'ERROR','SUCCESS','WARNING','INFO'..或者自己传入颜色值'#rgb'
 */
window.utils.anim_id=0;
window.utils.c=[];
window.utils.alert=function(msg_html,type,duration){
	if(type=="SUCCESS"){
		type="alert-success";
	}
	else if(type=="ERROR") type="alert-danger";
	else if(type=="WARNING") type="alert-warning";
	else type="alert-info";
	
	if($('#util_alert_box').size()==0)
	{
		var str_div='<div id="util_alert_box" style="margin:0 auto;position:fixed; bottom:0px;width:100%;text-align:center;line-height:2em;"></div>';
		$('body').append(str_div);
		$("#util_alert_box").slideToggle(0);
	}
	$("#util_alert_box").attr('class','alert '+type);
	
	//执行动画
	var id=window.utils.anim_id++;
	$("#util_alert_box").html(msg_html).stop().slideToggle(500);
	window.utils.c[id]=setInterval('$("#util_alert_box").stop().slideToggle(500);window.clearInterval(window.utils.c['+id+']);',3500);
};


var getUrl=function(module,sub){
	var pathname=window.location.pathname;
	
	var parts=[];
	//alert(pathname.split('/').length);	
	var backs=pathname.split('/').length-2;
	
	if(backs==0) parts.push(undefined);
	else{
		for(var i = 0;i<backs;i++) parts.push('..');
	}
	
	if(typeof module!="undefined"){
		parts.push(module);
	}
	if(typeof sub!="undefined"){
		parts.push(sub);
	}
	else parts.push(undefined);
	
	
	//return parts.join("/");
	return module+"/"+sub;
	
};

/**选中一行数据(为表格的行绑定单击事件)
 * 无奈耦合两个css样式.currtr .selecttr
 * $table : 标准表格格式
 * selected_color:
 * callback($td):点击单元格事触发的事件
 * escape:[]避免单击事件的列*/
var selectTr=function($table,callback,escape){
	$table.find('tr:gt(0)').not(':last').each(function(i){
		$tr=$(this);
		$tr.mouseover(function(){
			$(this).children('td').addClass('selecttr');
		});
		$tr.mouseout(function(){
			$(this).children('td').removeClass('selecttr');
		});
		if(typeof escape != "undefined"){
			$tr.children('td').each(function(index){
				
				if(!(inArray(index, escape))){
					$(this).click(function(){
						_$tr=$(this).closest('tr');
						_$tr.siblings().children('td').removeClass('currtr');
						_$tr.children('td').addClass('currtr');
						//alert($(this).find('input').val());
						if('undefined' != typeof callback)
							callback($(this));
					});
				}
			});
			return;
		}
		else{
			$tr.click(function(){
				_$tr=$(this);
				_$tr.siblings().children('td').removeClass('currtr');
				_$tr.children('td').addClass('currtr');
				if('undefined' != typeof callback)
					callback(_$tr);
			});
		}
	});

	
};

//这个函数的功能是将str中满足${attr}替换成obj中对应的属性，如果不存在替换成 -1 
var replaceAttr=function(str,obj){
	if('object' !=typeof obj) obj={};
	
	var r=/\#{[A-z|0-9]*}/g;
	
	return str.replace(r,function(word){
		word=word.slice(2,-1);
		if(word in obj) return obj[word];
		return '-1';
	});
};

var inArray=function(ele,array){
	for(var p in array){
		if(ele===array[p]) {
			return true; break;
		}
	}
	return false;
};

var json2Url=function(jsonObj){
	var str="";
	for(var o in jsonObj){
		str+=(o+'='+jsonObj[o]+'&');
	}
	return str;
};

//resize of div 
(function($, h, c) { 
var a = $([]), 
e = $.resize = $.extend($.resize, {}), 
i, 
k = "setTimeout", 
j = "resize", 
d = j + "-special-event", 
b = "delay", 
f = "throttleWindow"; 
e[b] = 250; 
e[f] = true; 
$.event.special[j] = { 
setup: function() { 
if (!e[f] && this[k]) { 
return false; 
} 
var l = $(this); 
a = a.add(l); 
$.data(this, d, { 
w: l.width(), 
h: l.height() 
}); 
if (a.length === 1) { 
g(); 
} 
}, 
teardown: function() { 
if (!e[f] && this[k]) { 
return false; 
} 
var l = $(this); 
a = a.not(l); 
l.removeData(d); 
if (!a.length) { 
clearTimeout(i); 
} 
}, 
add: function(l) { 
if (!e[f] && this[k]) { 
return false; 
} 
var n; 
function m(s, o, p) { 
var q = $(this), 
r = $.data(this, d); 
r.w = o !== c ? o: q.width(); 
r.h = p !== c ? p: q.height(); 
n.apply(this, arguments); 
} 
if ($.isFunction(l)) { 
n = l; 
return m; 
} else { 
n = l.handler; 
l.handler = m; 
} 
} 
}; 
function g() { 
i = h[k](function() { 
a.each(function() { 
var n = $(this), 
m = n.width(), 
l = n.height(), 
o = $.data(this, d); 
if (m !== o.w || l !== o.h) { 
n.trigger(j, [o.w = m, o.h = l]); 
} 
}); 
g(); 
}, 
e[b]); 
} 
})(jQuery, this); 



//创建一个TabView对象
//
var TabView=function(){
	this.view=$('<div class="TabView"></div>');
	this.tabs=$('<ul class="tabs"></ul>');
	this.content=$('<div class="content"></div>');
};
TabView.b=22;//类属性

//实例方法
/**添加一个标签页tab:{
	title:'',
	content:function(TabView){return [obj string]|[obj jQuery]} | [obj string]|[obj jQuery], //这个函数的context为 dom a元素
	callback:function(TabView){};//渲染完成后的回调函数,context=dom a
	cache:boolean //标记是否缓存，如果缓存则callback函数只调用一次
}
*/
TabView.prototype.add=function(tab){
	var li=$('<li>');
	var a=$('<a>');
	li.html(a.html(tab.title));
	this.tabs.append(li);
	
	var self=this;
	//给a标签设置单击事件
	a.click(function(){
//		if(typeof tab.content == "function"){
//			if(/*tab.cache*/false){
//				if(!this.content.data('called'))
//					self.content.html(tab.content.call(this,self));
//				this.content.data('called',true);
//			}
//			else
//				self.content.html(tab.content.call(this,self));
//		}
//		else self.content.html(tab.content);
//		
//		if(tab.callback) {
//				tab.callback.call(this,self);
//		}
		$a=$(this);
		function init(){
			if(typeof tab.content == "function"){
				self.content.html(tab.content.call($a,self));
			}
			else if(typeof tab.content == "string"){
				self.content.html(tab.content);
			}
			else {
				self.content.html("");throw new Exception('参数类型错误');
			}
		}
		function call_back(){
			if(tab.callback) {
				tab.callback.call($a,self);
			}
		}
		if(tab.cache){
			if(!$(this).data('called')){
				//1.渲染到内容，回调
				init();call_back();
				//2.called设置为true
				$(this).data('called',true);
			}
			else{
				//将缓存渲染到内容，缓存放在$a对象(即此处的$(this)中
				self.content.html($(this).data('content'));
				self.resize();//计算尺寸
			}
		}
		else {
			init();call_back();
		}
		
		$(this).closest('.TabView').find('a').removeClass('active');
		$(this).addClass('active');
	});
	
	
};

//获取该tab的jQuery对象,参数container用于传入父容器对象
TabView.prototype.element=function(container){
	
	//通过父元素计算tab和content元素的宽度
	
	var _pPaddingL=container.css('padding-left').slice(0,-2);//父元素的补白
	var _pPaddingR=container.css('padding-right').slice(0,-2);
	
	this.tabWidth=0;//标签的宽度，需要计算
	
	
	var _tview=this.view.empty().append(this.tabs).append(this.content).clone();
	_tview.appendTo(container);
	this.tabWidth=_tview.children('ul').width();
	//alert(container.width() +',' +tabWidth  );
	
	_tview.remove();
	
	
	this.content.css('left',this.tabWidth + 4).width(container.width() - _pPaddingL - _pPaddingR- this.tabWidth -5 );
	
	return this.view;
};

//将html元素append到指定id的dom元素
TabView.prototype.appendTo=function(dst_id){
	
	var $dst=$('#'+dst_id);
	this.element($dst).appendTo($dst);
	
	
	//默认第一个标签是被点击的
	this.tabs.find('a:first').click();
};

//单击第一个a元素
TabView.prototype.clickFirst=function(){
	this.tabs.find('a:first').click();
};

//解决绝对定位中高度不能撑开父元素的问题
TabView.prototype.resize=function(){
	var ch=this.content.height();
	var th=this.tabs.height();
	var height=( ch > th ? ch : th ) + 30;
	//alert(height);
	this.view.height(height);
};

//缓存所有数据
TabView.prototype.cacheAll=function(){
	this.tabs.find('a').click();
};

//存储当前content内容到相应的jq a对象中，参数为对应的$a
TabView.prototype.restore=function($a){
	
	//store innerHTML
	$a.data('content',this.content.html());
};


//Begin definition of ListItem
var ListItem=function(parent_id){
	//this.items=[];//items以字符数组或者返回字符串的函数形式存在
	this.$ul=$('<ul class="items">');
	this.$btn_add=$('<button>添加</button>');
	this.parent_id=parent_id;
};

//items:[obj string]|function(){return [obj str]}
ListItem.prototype.addItem=function(item){
	//this.items.push(item);
	
	var btn=$('<button>×</button>');
	
	var $li=$('<li>');
	if(typeof item == "function"){
		$li.append(item()).append(btn).appendTo(this.$ul).hide().fadeIn(300).show();
	}
	else if(typeof item == "string"){
		$li.append(item).append(btn).appendTo(this.$ul);
	}
	
	
	btn.bind('click',function(){
		$(this).closest('li').hide(300,function(){
			this.remove();
		});
	});
};
ListItem.prototype.appendTo=function(){
	//构造ListItem
	var $ul=this.$ul;
	$('<div class="ListItem">').append($ul).append(this.$btn_add).appendTo($('#'+this.parent_id));
};

//点击添加按钮的事件，传入一个函数，函数的context为ListItem对象
ListItem.prototype.onNewItem=function(f){
	var self=this;
	
	this.$btn_add.bind('click',function(){
		alert(0);
		f.call(self);
	});
};

//End definition