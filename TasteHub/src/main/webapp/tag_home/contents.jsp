<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<link href="css/home/contents.css?after" rel="stylesheet" type="text/css">

<div class="contents-main">
<%
	String title = "영상제목 최대치 채우기 영상제목 최대치 채우기 영상제목 최대치 채우기 영상제목 최대치 채우기 영상제목 최대치 채우기 ";	
%>
<%
	for(int i = 0; i<10; i++){
		if(title.length()>20)
			title = title.substring(0,20) + "...";
%>
	<a class="content-contents" href="#">
		<div class="video-contents" style="background-image: url(''); background-color: gray;" ></div>
		<div class="detail-contents">
			<div class="userimg-detail" style="background-image: url(''); background-color: gray;">
			</div>
			<div class="text-detail">
				<p class="title-detail"><%=title %></p>
				<p class="user-detail">닉네임</p>
				<p class="etc-detail">000회 · 2개월 전</p>
			</div>
		</div>
	</a>
<%
	}
%>
</div>