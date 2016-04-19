<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<form enctype="multipart/form-data" target="hideWin" action="excel/studentSheet" method="post">
	<input type="file" name="excelFile"/>
	class_id:<input type="text" name="class_id"/>
	<button type="submit">上传</button>
</form>
</body>
</html>