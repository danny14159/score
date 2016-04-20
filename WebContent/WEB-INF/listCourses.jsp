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
						<th>老师</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach items="${courses }" var="i">
					<tr>
						<td>${i.name }</td>
						<td>${i.during }</td>
						<td>${i.teacher_name }</td>
						<td><button onclick="deSelCourse(${i.id},'${i.name }');">取消选择</button></td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
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
</script>