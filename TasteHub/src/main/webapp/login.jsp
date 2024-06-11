<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<link href="css/login/login.css?after" rel="stylesheet" type="text/css">
<!DOCTYPE html>
<html>
<head>
<title>TasteHub - Login </title>
<style>
	* {
	    font-family: "Roboto", "Arial", sans-serif;
	    text-decoration: none;
	    color: black;
	}
</style>
</head>
<body>
	<img alt="" src="img/Login/background.png" width="50%" height="100%"/>
	<h1>Welcome<br>Back!</h1>

 	<div class="i-login">
	    <div class="homeBtn-login">
	        <img alt="" src="img/Header/btnLogo.png" class="homeBtn-img">
	        <span>TasteHub</span>
	    </div>
	    <p class="word-login">Login
		<form action="process/loginHandler.jsp" method="post">
        <div class="input-login">
            <label for="email" class="input-word">이메일 </label>
            <input class="input" type="email" id="email" name="email" required><br>
        
            <label for="password" class="input-word">비밀번호</label>
            <input class="input" type="password" id="password" name="password" required><br>
        </div>
        <input type="submit" class="login-btn" value="로그인">
    	</form>
    	<div class="go-join">
		    <p>아직 계정이 없으신가요?
		    <a href="join.jsp" class="go-join-link">
		        가입하러 가기
		    </a>
	    </div>
    </div>
</body>
</html>
