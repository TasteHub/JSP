<%@ page import="java.util.List"%>
<%@ page import="mvc.model.VideoDTO"%>
<%@page import="java.sql.*"%>

<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    
<link href="css/home/contents.css?after" rel="stylesheet" type="text/css">

<form class="contents-main" action="./Home.do" method="post">
<%
	List videoList = (List) request.getAttribute("videolist");

	for(int i = 0; i < videoList.size(); i++){
		VideoDTO video = (VideoDTO) videoList.get(i);
		String title = video.getTitle();

		if(title.length()>20)
			title = title.substring(0,20) + "...";
%>
	<div class="content-contents">
		<a href="videoDetailsPage.jsp?videoID=<%=video.getVideoID()%>">
			<div class="video-contents" style="background-image: url('<%=video.getUrlThumbnail()%>'); background-color: black" ></div>
		</a>
		<div class="detail-contents">
			<a href="channel.jsp?userID=<%=video.getUserID()%>">
				<div class="userimg-detail" style="background-image: url('<%=video.getUrlUserImg()%>'); background-color: gray;"></div>
			</a>
			<div class="text-detail">
				<a href="videoDetailsPage.jsp?videoID=<%=video.getVideoID()%>">
					<p class="title-detail"><%=title %></p>
				</a>
				<a href="channel.jsp?userID=<%=video.getUserID()%>">
					<p class="user-detail"><%=video.getUserName() %></p>
				</a>
				<p class="etc-detail"><%=video.getCntView() %>회 · <%=video.getCreateDate() %></p>
			</div>
		</div>
	</div>
<%
	}
%>
</form>