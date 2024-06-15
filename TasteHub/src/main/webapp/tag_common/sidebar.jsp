<%@page import="javax.sql.*"%>
<%@page import="javax.naming.*"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<link href="css/common/sidebar.css?after" rel="stylesheet" type="text/css">    
<%!
	private String url, page;
	private String[] st;
	private String select_color = "#FFAC5350";
	int length,sidebarID;
%>
<%
	Connection conn_s = null;

	try {
		Context init = new InitialContext();
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/mysql");
		conn_s = ds.getConnection();
	} catch (Exception e) {
		out.println("연결 실패");
		out.println(e.getMessage());
	}
%>
<%
	url = request.getRequestURI();
	st = url.split("/");
	length = st.length;
%>    
<div class="sidebar-main">
	<div class="div-sidebar" style="background-color: <%=(st[length-1].equals("home.jsp") ? select_color:"white")%>;">
		<a class="btn-sidebar" href="home.do">
			<img alt="" src="img/Sidebar/btnHome.png" width="25px" height="25px">
			<p class="txt-sidebar">홈</p>
		</a>
	</div>
	<div class="div-sidebar" 
	style="background-color: <%=(st[length-1].equals("subscribe_com.jsp")||st[length-1].equals("subscribe_list.jsp") ? select_color:"white")%>">
		<a class="btn-sidebar" href="subscribe1.do">
			<img alt="" src="img/Sidebar/btnSubList.png" width="27px" height="27px">
			<p class="txt-sidebar">구독</p>
		</a>
	</div>
	<hr class="hr-sidebar">
	
	<div class="div-sidebar" style="background-color: <%=(st[length-1].equals("myPage.jsp") ? select_color:"white")%>">
		<a class="btn-sidebar" href="myVideoList.do">
			<img alt="" src="img/Sidebar/btnMypage.png" width="27px" height="27px">
			<p class="txt-sidebar">내 채널</p>
		</a>
	</div>
	<div class="div-sidebar" style="background-color: <%=(st[length-1].equals("history.jsp") ? select_color:"white")%>">
		<a class="btn-sidebar" href="history.do">
			<img alt="" src="img/Sidebar/btnVisit.png" width="27px" height="27px">
			<p class="txt-sidebar">방문 기록</p>
		</a>
		
	</div>
	<div class="div-sidebar" style="background-color: <%=(st[length-1].equals("likelist.jsp") ? select_color:"white")%>">
		<a class="btn-sidebar" href="likeList.do">
			<img alt="" src="img/Sidebar/btnLikelist.png" width="27px" height="27px">
			<p class="txt-sidebar">좋아요한 동영상</p>
		</a>
	</div>
	<hr class="hr-sidebar">
	
	
	<p class="subText-sidebar">구독</p>
	<%
	if(session.getAttribute("userID") != null)
		sidebarID = Integer.parseInt((String)session.getAttribute("userID"));
	ResultSet rs_s = null;
	Statement stmt_s = null;
	String userName_s = "", urlUserImg_s = "";
	int userSubID = 0;
	try{	
		String sql_s = "SELECT userSubID, userName, urlUserImg FROM Subscribe as s, User as u" 
				+ " WHERE userSubID = u.userID and s.userID = " + sidebarID;
		stmt_s = conn_s.prepareStatement(sql_s);
		rs_s = stmt_s.executeQuery(sql_s);
		while(rs_s.next()){
		userSubID = rs_s.getInt("userSubID");
		userName_s = rs_s.getString("userName");
		urlUserImg_s = rs_s.getString("urlUserImg");
%>
	<div class="div-sidebar" style="border-radius: 10px; margin-bottom: 5px; margin-right: 7px">
		<a class="btn-sidebar" href="channel.jsp?userID=<%=userSubID%>">
			<div class="subImg-btn" style="background-image: url('<%=urlUserImg_s %>'); background-color: gray;"></div>
			<p class="txt-sidebar"><%= userName_s %></p>
		</a>
	</div>
	<%
		}
	}catch(SQLException ex){
		out.println("User table select fail");
		out.println("SQLException: " + ex.getMessage());
	}finally{
		if(stmt_s!=null)
			stmt_s.close();
		if(conn_s!=null)
			conn_s.close();
	}
	%>
	<a class="btn-sidebar" href="subscribe.do" style="border-radius: 10px; margin-bottom: 5px; margin-right: 7px">
		<img alt="" src="img/Subscribe/btnList.png" width="27px" height="27px">
		<p class="txt-sidebar">모든 구독</p>
	</a>
</div>