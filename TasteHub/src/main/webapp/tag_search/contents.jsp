<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<link href="css/search/contents.css?after" rel="stylesheet"
	type="text/css">

<div class="contents-main">
<%@ include file ="../process/connect_DB.jsp" %>
<%
	String title, urlthumbnail, userName, urluserImg, detail;
	long cntView;
	Date createDate;
	int videoID, userID;
	
	String input = request.getParameter("searchTxt");
	ResultSet rs = null;
	Statement stmt = null;
	try{
		String sql = "SELECT videoID, V.userID, urlThumbnail, title, cntLike, cntView, createDate, detail, urlUserImg, userName"+
				" FROM(SELECT videoID, userID, urlThumbnail, title, cntLike, cntView, createDate, detail FROM Video"+
				" WHERE MATCH(title) AGAINST('" + input + "' IN BOOLEAN MODE) ORDER BY UNIX_TIMESTAMP(createDate) DESC LIMIT 0,30)" +
				" as V, User as U WHERE V.userID = U.userID ORDER BY cntLike DESC";
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
			urluserImg = rs.getString("urluserImg");
			videoID = rs.getInt("videoID");
			userID = rs.getInt("V.userID");
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
				<a class="title-video" href="videoDetailsPage.jsp?videoID=<%=videoID%>">
					<p class="title-text"><%=title%></p>
				</a>
				<p class="etc-text"><%=cntView %>회 · <%=createDate %></p>
				<a class="detail-text" href="channel.jsp?userID=<%=userID%>">
					<div class="userimg-detail" style="background-image: url('<%=urluserImg%>'); background-color: gray;"></div>
					<p class="user-text"> <%=userName %></p>
				</a>
				<p class="exp-text"><%=detail%>
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
