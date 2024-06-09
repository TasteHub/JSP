<%@page import="javax.sql.*"%>
<%@page import="javax.naming.*"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<link href="css/common/header.css?after" rel="stylesheet" type="text/css">

<%
	int loginID = 0;
    String defaultProfileImg = "img/Header/profileImg.jpg"; 
    String logoutImg = "img/Header/logoutimgSrc.png"; 
	String searchTxt = request.getParameter("searchTxt");
	if(searchTxt == null)
		searchTxt = "";
	if(session.getAttribute("userID") == null)
		response.sendRedirect("./login.jsp");
	else
		loginID = Integer.parseInt((String)session.getAttribute("userID"));
%>
<%
	Connection conn_h = null;

	try {
		Context init = new InitialContext();
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/mysql");
		conn_h = ds.getConnection();
	} catch (Exception e) {
		out.println("연결 실패");
		out.println(e.getMessage());
	}
%>
<%
	ResultSet rs_h = null;
	Statement stmt_h = null;
	String userName_h = "", urlUserImg_h = "", email_h = "";
	int cntSub_h = 0; 
	
	try{	
		String sql_h = "SELECT userName, urlUserImg, email, cntSub FROM User WHERE userID = " + loginID;
		stmt_h = conn_h.prepareStatement(sql_h);
		rs_h = stmt_h.executeQuery(sql_h);
		rs_h.next();
		userName_h = rs_h.getString("userName");
		urlUserImg_h = rs_h.getString("urlUserImg");
		if(urlUserImg_h == null)
			urlUserImg_h = "img/Header/userIcon.png";
		email_h = rs_h.getString("email");
		cntSub_h = rs_h.getInt("cntSub");
	}catch(SQLException ex){
		out.println("User table select fail");
		out.println("SQLException: " + ex.getMessage());
	}finally{
		if(stmt_h!=null)
			stmt_h.close();
		if(conn_h!=null)
			conn_h.close();
	}
%>
<div class="header-main">
    <a class="homeBtn-header" href="home.jsp">
        <img alt="" src="img/Header/btnLogo.png" width="40px" height="" style="margin-right: 10px">
        TasteHub
    </a>
    <form class="searchBar-header" name="searchbar" action="./search.jsp" method="get">
        <input type="text" class="text-searchBar" name="searchTxt" placeholder="검색" autocomplete="off">
        <input type="submit" class="btnArea-searchBar" style="background-image: url('img/Header/btnSearch.png');">
    </form>
    <div class="btnArea-header">
        <a class="videoBtn-btnArea" href="./studio.jsp">
            <img alt="" src="img/Header/btnVideo.png" width="30px" height="">
        </a>
        <img alt="" src="img/Header/btnAlarm.png" width="26px" height="">
        <div class="profile-btnArea" id="profileImg" style="background-image: url('<%=urlUserImg_h%>');"></div>
    </div>
    <div class="modal-header" id="modalHeader" style="display:none;">
		<div class="userInfo-modal">
			<img class="img-userInfo" alt="" src="<%=urlUserImg_h%>">
			<div class="text-userInfo">
				<p class="name-text"><%=userName_h %>
				<p class="email-text"><%=email_h %>
				<P class="cntSub-text">구독자 <%=cntSub_h %>명
			</div>
		</div>
		<div class="logout-modal" id="logoutBtn">
			<div class="img-logout" style="background-image: url('img/Header/btnLogout.png');"></div>
			<p class="text-logout">로그아웃
		</div>
	</div>
</div>


<script>
    document.getElementById("logoutBtn").addEventListener("click", function(event) {
        event.preventDefault(); 
        var isLoggedIn = <%= session.getAttribute("userID") != null %>;

        if (isLoggedIn) {
            window.location.href = "logout.jsp";
        } else {
            window.location.href = "login.jsp";
        }
    });
	
    const modalHeader = document.getElementById('modalHeader');
    const profileImg = document.getElementById('profileImg');

    let isModalOpen = false;

    function toggleProfile(event) {
      event.stopPropagation();
      isModalOpen ? closeModal() : openModal();
    }

    function openModal() {
      isModalOpen = true;
      modalHeader.style.display = 'block';
    }

    function closeModal() {
      isModalOpen = false;
      modalHeader.style.display = 'none';
    }

    profileImg.addEventListener('click', toggleProfile);

    function handleClickOutside(event) {
      if (isModalOpen && !modalHeader.contains(event.target)) {
        closeModal();
      }
    }
    document.addEventListener('click', handleClickOutside);

</script>