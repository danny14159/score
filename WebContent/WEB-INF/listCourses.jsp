<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="panel panel-default">
	<div class="panel-body">
		<span class="prompt_text">已选课程</span>
		<div class="toolbg">
			<!-- <button id="" class="btn btn-default btn-xs" data-toggle="modal"
				data-target="#modal_new">去选课</button> -->
		</div>
<table
				class="table table-condensed table-striped table-hover table-bordered"
				id="tbmain">
				<thead>
					<tr>
						<th>课程名称</th>
						<th>上课时间</th>
						<th>上课地点</th>
						<th>老师</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach items="${courses }" var="i">
					<tr>
						<td>${i.name }</td>
						<td>${i.weekday } ${i.part }</td>
						<td>${i.location }</td>
						<td>${i.teacher_name }</td>
						<td><button onclick="deSelCourse(${i.id},'${i.name }');">取消选择</button></td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
		<p id="tip" class="text-danger"></p>
		<div class="toolbg">
			<!-- <button id="" class="btn btn-default btn-xs" data-toggle="modal"
				data-target="#modal_new">去选课</button> -->
		</div>
	</div>
</div>
<script>

function deSelCourse(id,name){
	
	if(confirm('确认取消课程'+name+"?")){
		
		$.post('/student/deSelCourse',{
			cid:id
		},function(){
			location.reload();
		});
	}
}
var list = [
<c:forEach items="${courses }" var="i">
{name:'${i.name}',weekday:'${i.weekday}',part:'${i.part}'},
</c:forEach>];

//相当于>
function isLaterThan(ah,am,bh,bm){
	
	if(ah>bh) return true;
	if(ah == bh && am > bm) return true;
	return false;
}

function isBetween(hour,min,t2){
	return !isLaterThan(hour,min,t2.eh,t2.em) && !isLaterThan(t2.bh,t2.bm,hour,min);
}
function isTimeCross(t1,t2){
	//判断时间是否交叉即判断t1的开始时间是否介于t2时间段内或者t2的结束时间是否介于t2的时间段内 [过时]
	//
	//return isBetween(t1.bh,t2.bm,t2) || isBetween(t1.eh,t2.em,t2);
	
	return (t1.weekday == t2.weekday) && (t1.part == t2.part);
}
//a>b
 for(var i = 0;i<list.length-1;i++){
	
	for(var j = i+1;j<list.length;j++){
		
		if(isTimeCross(list[i],list[j])){
			$('#tip').append('<div>'+list[i].name+'，'+list[j].name+'上课时间有冲突，请仔细核对'+'<div>')
		}
	}
} 

</script>