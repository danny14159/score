<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="panel panel-default">
	<div class="panel-body">
		<span class="prompt_text">我的课程表</span>
		<div class="toolbg">
			<span>&nbsp;</span>
			<c:if test="${!t }">
			<a id="" class="btn btn-default btn-xs" href="/writeExcel/getCoursesTableExcel">导出课表</a>
			</c:if>
		</div>
		<table
			class="table table-condensed table-striped table-hover table-bordered" id="tbmain">
			<thead>
				<tr>
					<th></th>
					<th>周日</th>
					<th>周一</th>
					<th>周二</th>
					<th>周三</th>
					<th>周四</th>
					<th>周五</th>
					<th>周六</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${subs }" var="item" varStatus="s">
					<tr>
						<td>${part[s.index] }</td>
						<c:forEach items="${item }" var="i">
								<td>
									<p>${i.name }</p><p>${i.location }</p><p>${i.teacher_name }</p>
								</td>
						</c:forEach>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<div class="toolbg">
		</div>
	</div>
</div>
