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
	<div class="searchBar-header">
		<input class="text-searchBar" placeholder="검색">
		<div class="btnArea-searchBar">
			<img alt="" src="img/Header/btnSearch.png" width="20px" height="">
		</div>
	</div>
	<div class="btnArea-header">
		<img alt="" src="img/Header/btnVideo.png" width="30px" height="">
		<img alt="" src="img/Header/btnAlarm.png" width="26px" height="">
		<a href="login.jsp">
    		<img class="profile-btnArea" alt="" src="<%= userimgSrc %>" />
		</a>
	</div>
</div>