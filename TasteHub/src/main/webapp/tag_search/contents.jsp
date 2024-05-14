<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<link href="css/search/contents.css?after" rel="stylesheet" type="text/css">

<%
	String exp = "영상설명 최대치 채우기 영상설명 최대치 채우기 영상설명 최대치 채우기 영상설명 최대치 채우기 영상설명 최대치 채우기 영상설명 최대치 채우기 영상설명 최대치 채우기 ";
	String title = "영상제목 최대치 채우기 영상제목 최대치 채우기 영상제목 최대치 채우기 영상제목 최대치 채우기 영상제목 최대치 채우기 영상제목 최대치 채우기 영상제목 최대치 채우기 ";
%>
<div class="contents-main">
	<%
		for(int i = 0; i<10; i++){
		if(exp.length()>60)
			exp = exp.substring(0,60) + "...";
		if(title.length()>30)
			title = title.substring(0,30) + "...";
	%>
		<a class="content-contents_list" href="#">
			<div class="video-content">
				<div class="thumbnail-video" style="background-image: url(''); background-color: gray;"></div>
				<div class="text-video">
					<div class="title-video">
						<p class="title-text"><%= title %></p>
					</div>
					<p class="etc-text">000회 · 2개월 전</p>
					<div class="detail-text">
						<div class="userimg-detail" style="background-image: url(''); background-color: gray;"></div>
						<p class="user-text">닉네임</p>
					</div>
					<p class="exp-text"><%= exp %> 
				</div>
			</div>
		</a>
	<%	
		}
	%>	
	</div>
</div>
