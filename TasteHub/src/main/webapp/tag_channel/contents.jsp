<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    
<link href="css/channel/contents.css?after" rel="stylesheet" type="text/css">

<div class="contents-main">
<%@ include file ="../process/connect_DB.jsp" %>
<%
    String title, urlthumbnail, userName, urluserImg;

    long cntView;
    Date createDate;
    int videoID, userID;
    
    ResultSet rs = null; 
    Statement stmt = null;
    
    try{
        // URL에서 userID 가져오기
        String userIDParam = request.getParameter("userID");
        int targetUserID = 0; // 기본값 설정
        if (userIDParam != null) {
            targetUserID = Integer.parseInt(userIDParam);
        }
        
        String sql = "SELECT userID, userName, urluserImg, videoID, urlthumbnail, title, cntView, createDate FROM "+
        	    "( SELECT U.userID, userName, urluserImg, videoID, urlthumbnail, title, cntView, createDate, cntLike FROM "+
        	    "Video as V, User as U WHERE U.userID = V.userID AND U.userID = "+ targetUserID +" ORDER BY UNIX_TIMESTAMP(createDate) DESC LIMIT 0,30)"+
        	    " as VU ORDER BY createDate DESC";

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
			<div class="video-contents" style="background-image: url('<%=urlthumbnail%>'); background-color: black; background-size: contain;
			background-repeat: no-repeat;
			background-position: center; margin-bottom: -20px; " ></div>
		</a>
		<div class="detail-contents">
			<a href="channel.jsp?userID=<%=userID%>">
				<img src="<%= urluserImg %>" alt="User Image" style="width: 37px; height: 37px; border-radius: 50%;  margin-right: 10px; margin-top: 9px; object-fit: cover;">
			</a>
			<div class="text-detail">
				<a href="videoDetailsPage.jsp?videoID=<%=videoID%>">
					<p class="title-detail"><%=title %></p>
				</a>
				<a href="channel.jsp?userID=<%=userID%>">
					<p class="user-detail"><%=userName %></p>
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
