<%@page import="jakarta.websocket.Decoder.Text"%>
<%@page import="javax.sql.*"%>
<%@page import="javax.naming.*"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<link href="css/myPage/contents_user.css?after" rel="stylesheet" type="text/css">

<%
	Connection conn_m = null;

	try {
		Context init = new InitialContext();
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/mysql");
		conn_m = ds.getConnection();
	} catch (Exception e) {
		out.println("연결 실패");
		out.println(e.getMessage());
	}
%>
<%
	int userID_m = 0;
	if(session.getAttribute("userID") != null)
		userID_m = Integer.parseInt((String)session.getAttribute("userID"));	//세션에 저장된 userID
	ResultSet rs_m = null;
	Statement stmt_m = null;
	String userName_m = "", urlUserImg_m = "", urlBackImg_m ="", email_m = "";
	String introTxt = "";
	int cntSub_m = 0; 
	
	try{	
		String sql_m = "SELECT userName, email, cntSub, introTxt, urlUserImg, urlBackImg FROM User WHERE userID = " + userID_m;
		stmt_m = conn_m.prepareStatement(sql_m);
		rs_m = stmt_m.executeQuery(sql_m);
		rs_m.next();
		
		userName_m = rs_m.getString("userName");
		email_m = rs_m.getString("email");
		cntSub_m = rs_m.getInt("cntSub");
		introTxt = rs_m.getString("introTxt");
		urlUserImg_m = rs_m.getString("urlUserImg");
		urlBackImg_m = rs_m.getString("urlBackImg");

		if(introTxt == null)
			introTxt = "소개말을 작성해주세요.";
		if(urlUserImg_m == null)
			urlUserImg_m = "img/Header/userIcon.png";
		if(urlBackImg_m == null)
			urlBackImg_m = "img/MyPage/backImg.png";
	}catch(SQLException ex){
		out.println("User table select fail");
		out.println("SQLException: " + ex.getMessage());
	}finally{
		if(stmt_m!=null)
			stmt_m.close();
		if(conn_m!=null)
			conn_m.close();
	}
%>
<div class="contents-myPage">
	<!-- 평상시 MyPage -->
	<div class="userInfo-contents" id="commonMypage">
        <img class="backgroundimg-userInfo" alt="Background Image" src="<%=urlBackImg_m %>">
		<div class="profile-userinfo">
           	<img class="userimg-profile" alt="Profile Image" src="<%= urlUserImg_m %>">
			<div class="detail-profile">
				<div class="text-profile">
					<h1 class="name-profile"><%=userName_m %></h1>
					<p class="email-profile"><%=email_m %></p>
					<p class="cntSub-profile">구독자 <%=cntSub_m%>명
					<pre class="introduce-profile"><%=introTxt %></pre>
				</div>
				<div class="btnArea-profile">
					<button class="btn1-profile" id="btnProfile">수정</button>
				</div>				
			</div>
		</div>
	</div>
	<!-- editMyPage -->
	<form action="process/editUser.jsp" method="post" enctype="multipart/form-data"
	 class="userInfo-contents" id="editMypage" style="display: none;">
	 	<label for="back-file-input">
            <img id="background-image" class="backgroundimg-userInfo" alt="Background Image" src="<%=urlBackImg_m %>">
        </label>
        <input id="back-file-input" type="file" name="backgroundImage" style="display: none;">
		<div class="profile-userinfo">
            <label for="file-input">
                <img id="profile-image" class="userimg-profile" alt="Profile Image" src="<%= urlUserImg_m %>">
            </label>
            <input id="file-input" type="file" name="profileImage" style="display: none;">
			<div class="detail-profile">
				<div class="text-profile">
					<input class="nameEdit-profile" name="userName" value="<%=userName_m%>" autocomplete="off">
					<p class="email-profile"><%=email_m %></p>
					<p class="cntSub-profile">구독자 <%=cntSub_m%>명</p>
					<textarea class="introduceEdit-profile" rows="4" maxlength="60000" name="introTxt"><%=introTxt %></textarea>
				</div>
				<div class="btnArea-profile">
					<button type="submit" class="btn1-profile">저장</button>
					<div class="btn2-profile" id="btnCancel">취소</div>
				</div>				
			</div>
		</div>
	</form>
	<!-- 로딩 이미지 -->
	<div class="loader-contents" style="display: none;" id="loader">
		<div class="dot-spinner">
		    <div class="dot-spinner__dot"></div>
		    <div class="dot-spinner__dot"></div>
		    <div class="dot-spinner__dot"></div>
		    <div class="dot-spinner__dot"></div>
		    <div class="dot-spinner__dot"></div>
		    <div class="dot-spinner__dot"></div>
		    <div class="dot-spinner__dot"></div>
		    <div class="dot-spinner__dot"></div>
		</div>
		<p class="text-loader">Loading...</p>
	</div>
</div>

<script>
/* 이미지 미리보기 */
document.getElementById('back-file-input').addEventListener('change', function(event) {
    var file = event.target.files[0];
    var reader = new FileReader();
    reader.onload = function() {
        var img = document.getElementById('background-image');
        img.src = reader.result;
    };
    reader.readAsDataURL(file);
});
document.getElementById('file-input').addEventListener('change', function(event) {
    var file = event.target.files[0];
    var reader = new FileReader();
    reader.onload = function() {
        var img = document.getElementById('profile-image');
        img.src = reader.result;
    };
    reader.readAsDataURL(file);
});

/* 수정 및 취소버튼 */
const editMypage = document.getElementById('editMypage');
const commonMypage = document.getElementById('commonMypage');

document.getElementById('btnProfile').addEventListener('click', function(event) {
	editMypage.style.display = 'block';
	commonMypage.style.display = 'none';
});
document.getElementById('btnCancel').addEventListener('click', function(event) {
	editMypage.style.display = 'none';
	commonMypage.style.display = 'block';
});

/* 로딩 */
const submitBtn = document.getElementById('editMypage');
const loader = document.getElementById('loader');
submitBtn.addEventListener('submit', function() {
	loader.style.display = 'flex';
});
</script>