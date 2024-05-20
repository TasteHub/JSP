<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<link href="css/history/contents.css?after" rel="stylesheet" type="text/css">

<%
	String exp = "영상설명 최대치 채우기 영상설명 최대치 채우기 영상설명 최대치 채우기 영상설명 최대치 채우기 영상설명 최대치 채우기 영상설명 최대치 채우기 영상설명 최대치 채우기 ";
	String title = "영상제목 최대치 채우기 영상제목 최대치 채우기 영상제목 최대치 채우기 영상제목 최대치 채우기 영상제목 최대치 채우기 영상제목 최대치 채우기 영상제목 최대치 채우기 ";
	Calendar day = Calendar.getInstance();
	SimpleDateFormat date = new SimpleDateFormat("M월 d일");
	String dateFm;
%>
<div class="contents-main">
	<h2 style="width: 100%; min-width: 140px;">방문 기록</h2>
<%
	for(int j = 0; j < 10; j++){
		day.add(Calendar.DATE, -1);
		dateFm = date.format(day.getTime());
%>
	<div class="oneday-contents">
		<div class="date-content">
			<p class="text-date"><%=dateFm %></p>
		</div>
	<%
		for(int i = 0; i<10; i++){
		if(exp.length()>40)
			exp = exp.substring(0,40) + "...";
		if(title.length()>20)
			title = title.substring(0,20) + "...";
	%>
		<div class="content-contents_list">
			<div class="video-content">
				<div class="thumbnail-video" style="background-image: url(''); background-color: gray;"></div>
				<div class="text-video">
					<div class="title-video">
						<p class="title-text"><%= title %></p>
						<div class="del-btn">
							<img alt="" src="img/History/btnDeny.png" width="15px" height="">
						</div>
					</div>
					<div class="detail-text">
						<p class="user-text">닉네임</p>
						<p class="etc-text"> · 000회 · 2개월 전</p>
					</div>
					<p class="exp-text"><%= exp %> 
				</div>
			</div>
		</div>
	<%	
		}
	%>	
	</div>
<%
	} 
%>
</div>
