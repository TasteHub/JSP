<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<link href="css/home/contents.css?after" rel="stylesheet" type="text/css">

<div class="contents-main">
<%
	for(int i = 0; i<10; i++){
%>
	<div class="content-contents">
		<div class="video-contents" style="background-image: url(''); background-color: gray;"></div>
		<div class="detail-contents">
			<div class="userimg-detail" style="background-image: url(''); background-color: gray;">
			</div>
			<div class="text-detail">
				<p class="title-detail">영상 제목</p>
				<p class="user-detail">닉네임</p>
				<p class="etc-detail">000회 · 2개월 전</p>
			</div>
		</div>
	</div>
<%
	}
%>
</div>