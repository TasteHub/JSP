<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<link href="css/home/contents.css?after" rel="stylesheet" type="text/css">

<div class="contents-main">
<%@ include file="./header_subscribe.jsp" %>

<%@ include file ="../process/connect_DB.jsp" %>

<%
	String title, urlthumbnail, userName, urluserImg;
	long cntView;
	Date createDate;
	int videoID, userID, input = 0;
	
	if(session.getAttribute("userID") != null)
		input = Integer.parseInt((String)session.getAttribute("userID"));	//세션에 저장된 userID
	ResultSet rs = null;
	Statement stmt = null;
	try{
		String sql = "SELECT userID, userName, urluserImg, videoID, urlthumbnail, title, cntView, createDate " +
				"FROM ( SELECT U.userID, userName, urluserImg, videoID, urlthumbnail, title, cntView, createDate " +
				"FROM ( SELECT videoID, V.userID, title, createDate, urlThumbnail, cntView, cntLike " +
				"FROM Subscribe as S, Video as V WHERE S.userID = " + input + " AND userSubID = V.userID ) as VS, User as U " +
				"WHERE U.userID = VS.userID ORDER BY cntLike desc) as VU ORDER BY UNIX_TIMESTAMP(createDate) desc LIMIT 0,30";
		stmt=conn.createStatement();
		rs = stmt.executeQuery(sql);
		while(rs.next()){
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
%>
	<div class="content-contents">
		<a href="videoDetailsPage.jsp?videoID=<%=videoID%>">
			<div class="video-contents" style="background-image: url('<%=urlthumbnail%>'); background-color: black;"></div>
		</a>
		<div class="detail-contents">
			<a href="channel.jsp?userID=<%=userID%>">
				<div class="userimg-detail" style="background-image: url('<%=urluserImg%>'); background-color: gray;"></div>
			</a>
			<div class="text-detail">
				<a href="videoDetailsPage.jsp?videoID=<%=videoID%>">
					<p class="title-detail"><%= title %></p>
				</a>
				<a href="channel.jsp?userID=<%=userID%>">
					<p class="user-detail"><%= userName %></p>
				</a>
				<p class="etc-detail"><%=cntView %>회 · <%=createDate %></p>
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
%>
</div>