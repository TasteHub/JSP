<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<link href="css/subscribe/contents_list.css?after" rel="stylesheet" type="text/css">

<div class="contents-main">
<%@ include file="./header_subscribe.jsp" %>
<%@ include file ="../process/connect_DB.jsp" %>

<%
	int index = 0;

	String title, urlthumbnail, userName, urluserImg, detail;
	long cntView;
	Date createDate;
	int videoID, userID, input = 0;
	
	if(session.getAttribute("userID") != null)
		input = Integer.parseInt((String)session.getAttribute("userID"));	//세션에 저장된 userID
	ResultSet rs = null;
	Statement stmt = null;
	try{
		String sql = "SELECT userID, userName, urluserImg, videoID, urlthumbnail, title, cntView, createDate, detail " +
				"FROM ( SELECT U.userID, userName, urluserImg, videoID, urlthumbnail, title, cntView, createDate, detail " +
				"FROM ( SELECT videoID, V.userID, title, createDate, urlThumbnail, cntView, cntLike, detail " +
				"FROM Subscribe as S, Video as V WHERE S.userID = " + input + " AND userSubID = V.userID ) as VS, User as U " +
				"WHERE U.userID = VS.userID ORDER BY cntLike desc) as VU ORDER BY UNIX_TIMESTAMP(createDate) desc LIMIT 0,30";
		stmt=conn.createStatement();
		rs = stmt.executeQuery(sql);
		while(rs.next()){
			index++;
			title = rs.getString("title");
			if(title.length()>30)
				title = title.substring(0,30) + "...";
			urlthumbnail = rs.getString("urlthumbnail");
			userName = rs.getString("userName");
			cntView = rs.getLong("cntView");
			createDate = rs.getDate("createDate");
			urluserImg = rs.getString("urluserImg");
			videoID = rs.getInt("videoID");
			userID = rs.getInt("userID");
			detail = rs.getString("detail");
			if(detail.length()>100)
				detail = detail.substring(0,100) + "...";
%>
	<div class="content-contents_list">
		<a class="user-content" href="channel.jsp?userID=<%=userID%>">
			<div class="userimg-user" style="background-image: url('<%=urluserImg%>'); background-color: gray;">
			</div>
			<p class="name-user"><%= userName %></p>
		</a>
		<div class="video-content">
			<a href="videoDetailsPage.jsp?videoID=<%=videoID%>">
				<div class="thumbnail-video" style="background-image: url('<%=urlthumbnail%>'); background-color: black;"></div>
			</a>
			<div class="text-video">
				<a href="videoDetailsPage.jsp?videoID=<%=videoID%>">
					<p class="title-text"><%= title %></p>
				</a>
				<div class="detail-text">
					<a href="channel.jsp?userID=<%=userID%>">
						<p class="user-text"><%= userName %></p>
					</a>
					<p class="etc-text"> · <%=cntView %>회 · <%=createDate %></p>
				</div>
				<p class="exp-text"><%= detail %> 
			</div>
		</div>
	</div>
<%	
}
		}catch(SQLException ex){
			out.println("Video table Select fail");
			out.println("SQLException: " + ex.getMessage());
		}finally{
			if(stmt!=null)
				stmt.close();
			if(conn!=null)
				conn.close();
		}
	if(index==0){
%>
	<div class="noSub-contents">
		<img class="img-noSub" alt="" src="img/Subscribe/noSubImg.png">
		<div class="text-noSub">
			<h2>구독한 채널이 없습니다.</h2>
			<p>관심 있는 채널을 구독해보세요!
		</div>
	</div>
<%
	}
%>
</div>
