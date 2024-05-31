<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<link href="css/search/contents.css?after" rel="stylesheet"
	type="text/css">

<%
String exp = "영상설명 최대치 채우기 영상설명 최대치 채우기 영상설명 최대치 채우기 영상설명 최대치 채우기 영상설명 최대치 채우기 영상설명 최대치 채우기 영상설명 최대치 채우기 ";
String title = "영상제목 최대치 채우기 영상제목 최대치 채우기 영상제목 최대치 채우기 영상제목 최대치 채우기 영상제목 최대치 채우기 영상제목 최대치 채우기 영상제목 최대치 채우기 ";
%>
<div class="contents-main">
	<%
	for (int i = 0; i < 10; i++) {
		if (exp.length() > 60)
			exp = exp.substring(0, 60) + "...";
		if (title.length() > 30)
			title = title.substring(0, 30) + "...";
	%>
	<div class="content-contents_list">
		<div class="video-content">
			<a href="videoDetailsPage.jsp">
				<div class="thumbnail-video" style="background-image: url(''); background-color: gray;"></div>
			</a>
			<div class="text-video">
				<a class="title-video" href="videoDetailsPage.jsp">
					<p class="title-text"><%=title%></p>
				</a>
				<p class="etc-text">000회 · 2개월 전</p>
				<a class="detail-text" href="subscribe_page.jsp">
					<div class="userimg-detail" style="background-image: url(''); background-color: gray;"></div>
					<p class="user-text">닉네임</p>
				</a>
				<p class="exp-text"><%=exp%>
			</div>
		</div>
	</div>
	<%
	}
	%>
</div>
