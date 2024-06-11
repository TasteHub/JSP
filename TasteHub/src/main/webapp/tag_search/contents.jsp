<%@ page import="java.util.List"%>
<%@ page import="mvc.model.VideoDTO"%>
<%@page import="java.sql.Date"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<link href="css/search/contents.css?after" rel="stylesheet"
	type="text/css">

<form class="contents-main" action="./search.do" method="post">
<%	
	List videoList = (List) request.getAttribute("videolist");
	int i = 0;
	for(i = 0; i < videoList.size(); i++){
		VideoDTO video = (VideoDTO) videoList.get(i);
		String title = video.getTitle();
		String detail = video.getDetail();
		
		if(title.length()>30)
			title = title.substring(0,30) + "...";
		if(detail.length()>100)
			detail = detail.substring(0,100) + "...";
%>
	<div class="content-contents_list">
		<div class="video-content">
			<a href="videoDetailsPage.jsp?videoID=<%=video.getVideoID()%>">
				<div class="thumbnail-video" style="background-image: url('<%=video.getUrlThumbnail()%>'); background-color: black;"></div>
			</a>
			<div class="text-video">
				<a class="title-video" href="videoDetailsPage.jsp?videoID=<%=video.getVideoID()%>">
					<p class="title-text"><%=title%></p>
				</a>
				<p class="etc-text"><%=video.getCntView() %>회 · <%=video.getCreateDate() %></p>
				<a class="detail-text" href="channel.jsp?userID=<%=video.getUserID()%>">
					<div class="userimg-detail" style="background-image: url('<%=video.getUrlUserImg()%>'); background-color: gray;"></div>
					<p class="user-text"> <%=video.getUserName() %></p>
				</a>
				<p class="exp-text"><%=detail%>
			</div>
		</div>
	</div>
<%
	}
	if(i == 0){
%>
	<div class="noResult-contents">
		<img class="img-noResult" alt="" src="./img/Search/noresIcon.png">
		<div class="text-noResult">
			<p class="query-text">'<%=request.getAttribute("query")%>'</p>
			<p class="info-text"> 에 대한 검색 결과가 없습니다.</p>
		</div>
		<p class="etc-noResult">비슷한 다른 검색어를 입력해보세요.</p>
	</div>
<%
	} 
%>
</form>
