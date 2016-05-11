<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="row" style="margin-right: 15px;">
	<div class="col-md-12">
		<div class="panel panel-default" style='border-right: 0;'>

			<div class="panel-body" style='margin-right: -15px;'>

				<span class="prompt_text">我的课程</span>
				<div class="toolbg">
					所有课程
				</div>
				<table
					class="table table-condensed table-striped table-hover table-bordered"
					id="tbmain">
					<thead>
						<tr>
							<th>课程ID</th>
							<th>课程名称</th>
							<th>上课时间</th>
							<th></th>
						</tr>
					</thead>
					<tbody>
					<c:forEach items="${list }" var="i">
					<tr>
						<td>${i.id }</td>
						<td>${i.name }</td>
						<td>${i.weekday } ${i.part }</td>
						<td><a href="/subject/subjectStus?subjectId=${i.id }" target="_blank">查看选课学生</a></td>
					</tr>
					</c:forEach>
					</tbody>
				</table>

				<div class="toolbg">
					所有课程
				</div>

			</div>
		</div>
	</div>
</div>
