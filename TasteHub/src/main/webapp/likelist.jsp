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
text-decoration: none;
color: black;
}
</style>

</head>

<body style="margin: 0; overflow-y: hidden">
	<%@ include file="./tag_common/header.jsp" %>
	<div style="display: flex;">
		<%@ include file="./tag_common/sidebar.jsp" %>
		<%@ include file="./tag_likelist/contents.jsp" %>
	</div>
</body>
</html>
