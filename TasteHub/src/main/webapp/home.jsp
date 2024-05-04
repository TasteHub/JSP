<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>TasteHub</title>
<link rel="shortcut icon" href="#"/>
<style type="text/css">
*{
font-family: "Roboto", "Arial", sans-serif;
}
</style>
</head>
<body style="margin: 0; overflow-y: hidden">
	<%@ include file="./common/header.jsp" %>
	<div style="display: flex;">
		<%@ include file="./common/sidebar.jsp" %>
		<%@ include file="./home/contents_home.jsp" %>
	</div>
</body>
</html>