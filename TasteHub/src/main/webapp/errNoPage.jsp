<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page isErrorPage="true" %>
<link href="./css/errpage/errNoPage.css?after" rel="stylesheet" type="text/css">
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
<body style="margin: 0; background-image: url('./img/errpage/errPageBack.png');">
	<div class="errpage-container" style="">
		<div class="errpage-contents">
			<a class="title-contents" href="./home.do">
				<img class="logo-title" alt="" src="./img/Header/btnLogo.png" width="40px" height="28px" >
				<p class="text-title">TasteHub</p>
			</a>
			<img class="img-contents" alt="" src="">
			<h2>404 ERROR</h2>
		    <p class="text-contents">요청하신 페이지를 찾을 수 없습니다.</p>
		    <form class="inputGroup" name="searchbar" action="./search.do" method="get">
			    <input type="text" required="" name="searchTxt" autocomplete="off" minlength="2">
			    <label for="name">검색</label>
			</form>
		</div>
	</div>
</body>
</html>