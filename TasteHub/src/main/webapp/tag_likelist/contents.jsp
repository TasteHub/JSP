<%@ page import="java.util.List"%>
<%@ page import="mvc.model.VideoDTO"%>
<%@page import="java.sql.Date"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<link href="css/likelist/contents.css?after" rel="stylesheet" type="text/css">

<form class="contents-main" action="./likeList.do" method="post">
	<h2 style="width: 100%">좋아요한 동영상</h2>
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
					<div class="title-video">
						<a href="videoDetailsPage.jsp?videoID=<%=video.getVideoID()%>">
							<p class="title-text"><%= title %></p>
						</a>
						<a class="del-btn" href="delLikeList.do?videoID=<%=video.getVideoID()%>">
							<img alt="" src="img/History/btnDeny.png" width="15px" height="">
						</a>
					</div>
					<div class="detail-text">
						<a href="channel.jsp?userID=<%=video.getUserID()%>">
							<p class="user-text"><%= video.getUserName() %></p>
						</a>
						<p class="etc-text"> · <%=video.getCntView() %>회 · <%=video.getCreateDate() %></p>
					</div>
					<p class="exp-text"><%= detail %> 
				</div>
			</div>
		</div>
<%
	}
	if(i == 0){
%>
	<div class="noSub-contents">
		<img class="img-noSub" alt="" src="img/LikeList/noLikeImg.png">
		<div class="text-noSub">
			<h2>좋아요한 동영상이 없습니다.</h2>
			<p>다시 보고싶은 동영상에 좋아요를 눌러보세요!
		</div>
	</div>
<%
	}
%>	
</form>
