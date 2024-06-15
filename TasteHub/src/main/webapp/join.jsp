<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<link href="css/join/join.css?after" rel="stylesheet" type="text/css">
<!DOCTYPE html>
<html>
<head>
<title>TasteHub - Join</title>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<style>
	* {
	    font-family: "Roboto", "Arial", sans-serif;
	    text-decoration: none;
	    color: black;
	}
</style>
<script>
    function validateForm() {
    var name = document.getElementById("name").value;
	var email = document.getElementById("email").value;
	var password = document.getElementById("password").value;
	var confirm_password = document.getElementById("confirm_password").value;
	var pattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
	
    if (name === "" || email === "" || password === "" || confirm_password === "") {
        document.getElementById("form-error").innerText = "아직 입력되지 않은 칸이 있습니다!";
        return false;
    } else {
        document.getElementById("form-error").innerText = "";
    }
    
    if (!pattern.test(email)) {
        document.getElementById("email-error").innerText = "이메일 형식에 맞지 않습니다!";
        return false;
    } else {
        document.getElementById("email-error").innerText = "";
    }
    
    if (password !== confirm_password) {
        document.getElementById("password-error").innerText = "비밀번호가 일치하지 않습니다!";
        return false;
    } else {
        document.getElementById("password-error").innerText = "";
    }
	
    Swal.fire({
      title: '감사합니다!',
   	  text: '가입이 완료되었습니다.',
      icon: 'success',
	  confirmButtonText: '확인'
    });
    return true;
    }
</script>
</head>
<body>
	<img alt="" src="img/Login/background.png" width="50%" height="100%"/>
	<h1>Create<br>Your Account<br>Today!</h1>

 	<div class="i-join">
	    <a href="home.jsp" class="homeBtn-join">
	        <img alt="" src="img/Header/btnLogo.png" class="homeBtn-img">
	        <span>TasteHub</span>
	    </a>
	    <p class="word-join">Sign up
		<form action="process/joinHandler.jsp" method="post" onsubmit="return validateForm()">
		<div class="input-join">
		    <label for="name" class="input-word">이름</label>
		    <input class="input" type="text" id="name" name="name" maxlength="10" required><br>
		
            <label for="email" class="input-word">이메일</label>
            <input class="input" type="email" id="email" name="email" required>
            <span id="email-error" style="color: red;"></span><br>
		
		    <label for="password" class="input-word">비밀번호</label>
		    <input class="input" type="password" id="password" name="password" required><br>
		
		    <label for="confirm_password" class="input-word">비밀번호 확인</label>
		    <input class="input" type="password" id="confirm_password" name="confirm_password" required>
		    <span id="password-error" style="color: red;"></span><br> 
		</div>
	<input type="submit" class="join-btn" value="가입하기" onclick="return validateForm()"><br>
	</form>
	<span id="form-error" style="color: red;"></span> 
	
    	<div class="go-login">
		    <p>이미 계정이 있으신가요?
		    <a href="login.jsp" class="go-login-link">
		        로그인하러 가기
		    </a>
	    </div>
	</div>
</body>
</html>