<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<link href="css/common/sidebar.css?after" rel="stylesheet" type="text/css">    
<%!
	private String url, page;
	private String[] st;
	private String select_color = "#FFAC5350";
	int length;
%>
<%
	url = request.getRequestURI();
	st = url.split("/");
	length = st.length;
%>    
<div class="sidebar-main">
	<div class="div-sidebar" style="background-color: <%=(st[length-1].equals("home.jsp") ? select_color:"white")%>;">
		<a class="btn-sidebar" href="home.jsp">
			<img alt="" src="img/Sidebar/btnHome.png" width="25px" height="25px">
			<p class="txt-sidebar">홈</p>
		</a>
	</div>
	<div class="div-sidebar" 
	style="background-color: <%=(st[length-1].equals("subscribe_com.jsp")||st[length-1].equals("subscribe_list.jsp") ? select_color:"white")%>">
		<a class="btn-sidebar" href="subscribe_com.jsp">
			<img alt="" src="img/Sidebar/btnSubList.png" width="27px" height="27px">
			<p class="txt-sidebar">구독</p>
		</a>
	</div>
	<hr class="hr-sidebar">
	
	<div class="div-sidebar" style="background-color: <%=(st[length-1].equals("url주소") ? select_color:"white")%>">
		<a class="btn-sidebar" href="index.jsp">
			<img alt="" src="img/Sidebar/btnMypage.png" width="27px" height="27px">
			<p class="txt-sidebar">내 채널</p>
		</a>
	</div>
	<div class="div-sidebar" style="background-color: <%=(st[length-1].equals("history.jsp") ? select_color:"white")%>">
		<a class="btn-sidebar" href="history.jsp">
			<img alt="" src="img/Sidebar/btnVisit.png" width="27px" height="27px">
			<p class="txt-sidebar">방문 기록</p>
		</a>
	</div>
	<div class="div-sidebar" style="background-color: <%=(st[length-1].equals("url주소") ? select_color:"white")%>">
		<a class="btn-sidebar" href="index.jsp">
			<img alt="" src="img/Sidebar/btnLikelist.png" width="27px" height="27px">
			<p class="txt-sidebar">좋아요한 동영상</p>
		</a>
	</div>
	<hr class="hr-sidebar">
	
	<p class="subText-sidebar">구독</p>
	<%
	for(int i = 0; i < 9; i++){
	%>
	<div class="div-sidebar" style="background-color: <%=(st[length-1].equals("url주소") ? select_color:"white")%>
	border-radius: 10px; margin-bottom: 5px; margin-right: 7px">
		<a class="btn-sidebar" href="index.jsp">
			<div class="subImg-btn" style="background-image: url(''); background-color: gray;"></div>
			<p class="txt-sidebar">채널 <%= i+1 %></p>
		</a>
	</div>
	<%
	}
	%>
</div>