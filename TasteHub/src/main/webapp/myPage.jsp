<%@ page errorPage="errInvalidPage.jsp" %>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<title>TasteHub</title>
<link rel="shortcut icon" href="#"/>
<style type="text/css">
*{
font-family: "Roboto", "Arial", sans-serif;
text-decoration: none;
color: black;
}
.contents-main{
	overflow-y: scroll;
	height: calc(100vh - 80px);
	min-width: calc(100% - 310px);
	margin-top: 25px;
	padding-right: 30px;
}
</style>
</head>
<body style="margin: 0; overflow-y: hidden">
	<%@ include file="./tag_common/header.jsp" %>
	<div style="display: flex;">
		<%@ include file="./tag_common/sidebar.jsp" %>
		<div class="contents-main">
			<%@ include file="./tag_myPage/contents_user.jsp" %>
			<%@ include file="./tag_myPage/contents_video.jsp" %>
		</div>
	</div>
</body>
</html>