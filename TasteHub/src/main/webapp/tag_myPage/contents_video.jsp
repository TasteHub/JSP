<%@ page import="java.util.List"%>
<%@ page import="mvc.model.VideoDTO"%>
<%@page import="java.sql.Date"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<link href="css/myPage/contents_video.css?after" rel="stylesheet" type="text/css">

<form class="video-myPage" action="./myVideoList.do" method="post">
<%
	List videoList = (List) request.getAttribute("videolist");
	int i = 0;
	for(i = 0; i < videoList.size(); i++){
		VideoDTO video = (VideoDTO) videoList.get(i);
		String title = video.getTitle();
		
		if(title.length()>30)
			title = title.substring(0,30) + "...";
%>
	<div class="content-contents">
		<a href="videoDetailsPage.jsp?videoID=<%=video.getVideoID()%>">
			<div class="video-contents" style="background-image: url('<%=video.getUrlThumbnail()%>'); background-color: black" ></div>
		</a>
		<div class="detail-contents">
			<div class="text-detail">
				<a href="videoDetailsPage.jsp?videoID=<%=video.getVideoID()%>">
					<p class="title-detail"><%=title %></p>
				</a>
				<p class="etc-detail"><%=video.getCntView() %>회 · <%=video.getCreateDate() %></p>
			</div>
		</div>
	</div>
<%
	}
	if(i == 0){
%>
	<div class="noVideo-myPage">
	    <img alt="" src="img/MyPage/myPageImage.jpg" width="130px" height="">
	    <p>원하는 기기에서 콘텐츠를 만드세요<br>
	    <p>집에서는 물론 이동 중에도 녹화하고 업로드할 수<br>있습니다. 공개 상태로 설정한 모든 콘텐츠가 여기<br>에 표시됩니다.<br><br>
	    <a href="studio.jsp">
	   		<input type="button" class="create-btn" value="만들기" id="create-button">
	    </a>
	</div>
<%
	}
%>	
</form>
