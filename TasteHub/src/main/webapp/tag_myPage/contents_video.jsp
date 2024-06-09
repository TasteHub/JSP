<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<link href="css/myPage/contents_video.css?after" rel="stylesheet" type="text/css">

<div class="video-myPage">
<%@ include file ="../process/connect_DB.jsp" %>
<%
	int index = 0;
	
	String title, urlthumbnail;
	long cntView;
	Date createDate;
	int videoID, input = 0;
	if(session.getAttribute("userID") != null)
		input = Integer.parseInt((String)session.getAttribute("userID"));	//세션에 저장된 userID
	ResultSet rs = null;
	Statement stmt = null;
	try{
		String sql = "SELECT videoID, title, cntView, createDate, urlThumbnail FROM Video WHERE userID =" + input;
		stmt = conn.createStatement();
		rs = stmt.executeQuery(sql);
		while(rs.next()){
			index++;
			title = rs.getString("title");
			if(title.length()>30)
				title = title.substring(0,30) + "...";
			urlthumbnail = rs.getString("urlthumbnail");
			cntView = rs.getLong("cntView");
			createDate = rs.getDate("createDate");
			videoID = rs.getInt("videoID");
%>
	<div class="content-contents">
		<a href="videoDetailsPage.jsp?videoID=<%=videoID%>">
			<div class="video-contents" style="background-image: url('<%=urlthumbnail%>'); background-color: black" ></div>
		</a>
		<div class="detail-contents">
			<div class="text-detail">
				<a href="videoDetailsPage.jsp?videoID=<%=videoID%>">
					<p class="title-detail"><%=title %></p>
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
	if(index == 0){
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
</div>
