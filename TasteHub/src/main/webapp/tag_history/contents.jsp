<%@ page import="java.util.List"%>
<%@ page import="mvc.model.VideoDTO"%>
<%@page import="java.sql.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<link href="css/history/contents.css?after" rel="stylesheet"
	type="text/css">

<%
String query = request.getParameter("searchTxt");
if (query == null)
	query = "";
%>
<form class="contents-main" action="history.do" method="post">
	<h2 style="width: 100%; min-width: 140px;">방문 기록</h2>
	<div class="group">
		<img alt="" src="img/Header/btnSearch.png" class="icon"> 
		<input name="searchTxt" placeholder="방문 기록 검색" autocomplete="off" type="search" class="input" value=<%=query%>>
	</div>
	<%
	String dateFm, dateFm_pre = "init";

	List videoList = (List) request.getAttribute("videolist");
	int i = 0;
	for (i = 0; i < videoList.size(); i++) {
		VideoDTO video = (VideoDTO) videoList.get(i);
		String title = video.getTitle();
		String detail = video.getDetail();
		Date viewDate = video.getViewDate();

		if (title.length() > 30)
			title = title.substring(0, 30) + "...";
		if (detail.length() > 100)
			detail = detail.substring(0, 100) + "...";

		dateFm = viewDate.toString().substring(0, 10);
		if (!dateFm_pre.equals(dateFm) && !dateFm_pre.equals("init")) {
	%>
	</div>
	<%
	}
	if (!dateFm_pre.equals(dateFm)) {
	dateFm_pre = dateFm;
	%>
	<div class="oneday-contents">
		<div class="date-content">
			<p class="text-date"><%=dateFm%></p>
		</div>
		<%
		}
		%>
		<div class="content-contents_list">
			<div class="video-content">
				<a href="videoDetailsPage.jsp?videoID=<%=video.getVideoID()%>">
					<div class="thumbnail-video"
						style="background-image: url('<%=video.getUrlThumbnail()%>'); background-color: black;"></div>
				</a>
				<div class="text-video">
					<div class="title-video">
						<a href="videoDetailsPage.jsp?videoID=<%=video.getVideoID()%>">
							<p class="title-text"><%=title%></p>
						</a> <a class="del-btn"
							href="delHistory.do?videoID=<%=video.getVideoID()%>"> <img
							alt="" src="img/History/btnDeny.png" width="15px" height="">
						</a>
					</div>
					<div class="detail-text">
						<a href="channel.jsp?userID=<%=video.getUserID()%>">
							<p class="user-text"><%=video.getUserName()%></p>
						</a>
						<p class="etc-text"> · <%=video.getCntView()%>회 · <%=video.getCreateDate()%></p>
					</div>
					<p class="exp-text"><%=detail%>
				</div>
			</div>
		</div>
		<%
		}
		if (i == 0) {
		%>
		<div class="noResult-contents">
			<img class="img-noResult" alt="" src="./img/Search/noresIcon.png">
			<div class="text-noResult">
				<p class="query-text">'<%=request.getParameter("query")%>'</p>
				<p class="info-text">에 대한 검색 결과가 없습니다.</p>
			</div>
			<p class="etc-noResult">비슷한 다른 검색어를 입력해보세요.</p>
		</div>
		<%
		}
		%>
	
</form>
