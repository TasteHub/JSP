<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<link href="css/likelist/contents.css?after" rel="stylesheet" type="text/css">

<div class="contents-main">
	<h2 style="width: 100%">좋아요한 동영상</h2>
	<%@ include file ="../process/connect_DB.jsp" %>
	<%
		String title, urlthumbnail, userName, urluserImg, detail;
		long cntView;
		Date createDate, viewDate;
		int videoID, userID;
		
		int input = 1;	//세션에 저장된 userID
		ResultSet rs = null;
		Statement stmt = null;
		try{
			String sql = "SELECT WV.userID, WV.videoID, urlThumbnail, title, userName, cntView, createDate, detail "+
						 "FROM ( SELECT likeDate, V.videoID, V.userID, title, urlThumbnail, cntView, createDate, detail "+
					     "FROM LikeBtn as L, Video as V WHERE L.userID = " + input + " AND V.videoID = L.videoID "+
						 "ORDER BY UNIX_TIMESTAMP(likeDate) desc LIMIT 0,30) as WV, User as U WHERE U.userID = WV.userID;";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while(rs.next()){
				title = rs.getString("title");
				if(title.length()>30)
					title = title.substring(0,30) + "...";
				urlthumbnail = rs.getString("urlthumbnail");
				userName = rs.getString("userName");
				cntView = rs.getLong("cntView");
				createDate = rs.getDate("createDate");
				videoID = rs.getInt("videoID");
				userID = rs.getInt("userID");
				detail = rs.getString("detail");
				if(detail.length()>100)
					detail = detail.substring(0,100) + "...";
	%>
		<div class="content-contents_list">
			<div class="video-content">
				<a href="videoDetailsPage.jsp?videoID=<%=videoID%>">
					<div class="thumbnail-video" style="background-image: url('<%=urlthumbnail%>'); background-color: black;"></div>
				</a>
				<div class="text-video">
					<div class="title-video">
						<a href="videoDetailsPage.jsp?videoID=<%=videoID%>">
							<p class="title-text"><%= title %></p>
						</a>
						<a class="del-btn" href="process/deleteLikelist.jsp?userID=<%=userID%>&videoID=<%=videoID%>">
							<img alt="" src="img/History/btnDeny.png" width="15px" height="">
						</a>
					</div>
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
	%>	
</div>
