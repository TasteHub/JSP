<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<link href="css/history/contents.css?after" rel="stylesheet" type="text/css">

<%
	String query = request.getParameter("query");
	if(query == null)
		query = "";
	else
		query = query.replace('\\', ' ').trim();
	String sql_search = "";
%>
<div class="contents-main">
	<%@ include file ="../process/connect_DB.jsp" %>
	<h2 style="width: 100%; min-width: 140px;">방문 기록</h2>
	<form action="history.jsp" method="get" class="group">
		<img alt="" src="img/Header/btnSearch.png" class="icon">
	    <input name="query" placeholder="방문 기록 검색" autocomplete="off" type="search" class="input" value=<%=query %>>
	</form>
<%
	
	if(!query.trim().isEmpty()){
		sql_search = " AND MATCH(title) AGAINST('"+ query +"' IN BOOLEAN MODE) ";
	}
	
	SimpleDateFormat date = new SimpleDateFormat("M월 d일");
	String dateFm, dateFm_pre = "init";
	
	String title, urlthumbnail, userName, urluserImg, detail;
	long cntView;
	Date createDate, viewDate;
	int videoID, userID;
	
	int input = 1;	//세션에 저장된 userID
	ResultSet rs = null;
	Statement stmt = null;
	try{
		String sql = "SELECT WV.userID, WV.videoID, urlThumbnail, title, userName, cntView, createDate, detail, viewDate " +
					 "FROM ( SELECT viewDate, V.videoID, V.userID, title, urlThumbnail, cntView, createDate, detail " +
				     "FROM View as W, Video as V WHERE W.userID = " + input + " AND V.videoID = W.videoID " + sql_search +
					 "ORDER BY UNIX_TIMESTAMP(viewDate) desc LIMIT 0,30) as WV, User as U WHERE U.userID = WV.userID "+
				     "GROUP BY videoID";
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
			viewDate = rs.getDate("viewDate");
			if(detail.length()>100)
				detail = detail.substring(0,100) + "...";
			
			dateFm = date.format(viewDate);
			if(!dateFm_pre.equals(dateFm) && !dateFm_pre.equals("init")){
				%>	
				</div>
				<%
			}
			if(!dateFm_pre.equals(dateFm)){
				dateFm_pre = dateFm;
				
				%>
				<div class="oneday-contents">
					<div class="date-content">
						<p class="text-date"><%=dateFm %></p>
					</div>
				<%
			}
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
						<a class="del-btn" href="process/deleteHistory.jsp?userID=<%=userID%>&videoID=<%=videoID%>">
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
