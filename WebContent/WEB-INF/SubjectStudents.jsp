<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link href="/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen">
<link href="/resources/util.css" rel="stylesheet" media="screen">
<link href="/resources/temp.css" rel="stylesheet" media="screen">
<div class="row" style="margin-right: 15px;">
	<div class="col-md-12">
		<div class="panel panel-default" style='border-right: 0;'>

			<div class="panel-body" style='margin-right: -15px;'>
	
	<div class="toolbg">
				<span class="prompt_text">选课学生</span>
		</div>
				<table
					class="table table-condensed table-striped table-hover table-bordered"
					id="tbmain">
					<thead>
						<tr>
							<th>学号</th>
							<th>姓名</th>
							<th>班级</th>
							<th>性别</th>
							<th>籍贯</th>
							<th>家庭住址</th>
							<th>入学年份</th>
						</tr>
					</thead>
					<tbody>
					<c:forEach items="${list }" var="i">
					<tr>
						<td>${i.id }</td>
						<td>${i.name }</td>
						<td>${i.className }</td>
						<td>${i.sex }</td>
						<td>${i.location }</td>
						<td>${i.address }</td>
						<td>${i.enterYear }</td>
					</tr>
					</c:forEach>
					</tbody>
				</table>
	<div class="toolbg">
		</div>

			</div>
		</div>
	</div>
</div>
