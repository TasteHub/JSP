<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<link href="css/common/header.css?after" rel="stylesheet" type="text/css">

<%
    String defaultProfileImg = "img/Header/profileImg.jpg"; 
    String logoutImg = "img/Header/logoutimgSrc.png"; 
	String searchTxt = request.getParameter("searchTxt");
	if(searchTxt==null)
		searchTxt = "";
%>

<div class="header-main">
    <a class="homeBtn-header" href="home.jsp">
        <img alt="" src="img/Header/btnLogo.png" width="40px" height="" style="margin-right: 10px">
        TasteHub
    </a>
    <form class="searchBar-header" name="searchbar" action="./search.jsp" method="get">
        <input type="text" class="text-searchBar" name="searchTxt" placeholder="검색">
        <input type="submit" class="btnArea-searchBar" style="background-image: url('img/Header/btnSearch.png');">
    </form>
    <div class="btnArea-header">
        <a class="videoBtn-btnArea" href="./studio.jsp">
            <img alt="" src="img/Header/btnVideo.png" width="30px" height="">
        </a>
        <img alt="" src="img/Header/btnAlarm.png" width="26px" height="">
        <a href="#" id="profileLink">
            <img class="profile-btnArea" alt="" src="<%= defaultProfileImg %>" id="profileImg"> 
        </a>
        
    </div>
</div>

<script>
    document.getElementById("profileLink").addEventListener("click", function(event) {
        event.preventDefault(); 

        var profileImg = document.getElementById("profileImg");

        var isLoggedIn = <%= session.getAttribute("userID") != null %>;

        if (isLoggedIn) {
            window.location.href = "logout.jsp";
        } else {
            window.location.href = "login.jsp";
        }
    });

    window.onload = function() {
        var profileImg = document.getElementById("profileImg");
        var isLoggedIn = <%= session.getAttribute("userID") != null %>;

        if (isLoggedIn) {
            profileImg.src = "<%= logoutImg %>";
        } else {
            profileImg.src = "<%= defaultProfileImg %>";
        }
    };
</script>
=======
	<a class="homeBtn-header" href="home.jsp">
		<img alt="" src="img/Header/btnLogo.png" width="40px" height="" style="margin-right: 10px">
		TasteHub
	</a>
	<form class="searchBar-header" name="searchbar" action="./search.jsp" method="get">
		<input type="text" class="text-searchBar" name="searchTxt" placeholder="검색" autocomplete="off" minlength="2"
		 value=<%=searchTxt %>>
		<input type="submit" class="btnArea-searchBar" style="background-image: url('img/Header/btnSearch.png');">
	</form>
	<div class="btnArea-header">
		<a class="videoBtn-btnArea" href="./studio.jsp">
			<img alt="" src="img/Header/btnVideo.png" width="30px" height="">
		</a>
		<img alt="" src="img/Header/btnAlarm.png" width="26px" height="">
		<a href="login.jsp">
			<img class="profile-btnArea" alt="" src=<%= userimgSrc %>>
		</a>
	</div>
</div>
>>>>>>> refs/remotes/origin/database
