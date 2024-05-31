<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<link href="css/common/header.css?after" rel="stylesheet" type="text/css">

<%!
	String userimgSrc = "img/Header/profileImg.jpg";
%>
<div class="header-main">
	<a class="homeBtn-header" href="home.jsp">
		<img alt="" src="img/Header/btnLogo.png" width="40px" height="" style="margin-right: 10px">
		TasteHub
	</a>
	<form class="searchBar-header" name="searchbar" action="./search.jsp" method="get">
		<input type="text" class="text-searchBar" name="searchTxt" placeholder="검색">
		<input type="submit" class="btnArea-searchBar" style="background-image: url('img/Header/btnSearch.png');">
	</form>
	<div class="btnArea-header">
		<a class="videoBtn-btnArea" href="./studio.jsp">
			<img alt="" src="img/Header/btnVideo.png" width="30px" height="">
		</a>
		<img alt="" src="img/Header/btnAlarm.png" width="26px" height="">
		<a href="login.jsp">
			<img class="profile-btnArea" alt="" src=<%= userimgSrc %>>
		</a>
	</div>
</div>