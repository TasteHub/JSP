<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
    String userimgSrc = "img/Header/profileImg.jpg";
    String editimgSrc = "img/MyPage/editImg.png";
    String userName = "이름";  
    String userMail = "aaa@bbb.ccc"; 
    String introduce = "자기소개 자기소개 자기소개 자기소개 자기소개 자기소개 자기소개 자기소개 자기소개 자기소개 자기소개 자기소개";
%>
<html>
<head>
    <title>TasteHub - Join</title>
    <style>
        * {
            font-family: "Roboto", "Arial", sans-serif;
            text-decoration: none;
            color: black;
        }
        .profile-container {
            display: flex;
            position: relative;
        }
        .profile-image {
            width: 180px;
            height: 180px;
            border-radius: 50%;
            margin-left: 70px;
            margin-top: 60px;
            cursor: pointer;
        }
        .user-info {
            margin-top: 40px;
            margin-left: 30px;
        }
        .user-info p {
            margin-bottom: 10px;
            font-size: 20px;
        }
        .myPage-hr {
            margin-top: -360px;
            margin-left: 280px;
            margin-bottom: 30px;
            width: 80%;
            height: 1px;
            background-color: #FFAC53;
        }
        .myPage-first {
            text-align: center;
            margin: 0 auto;
        }
        .create-btn {
            font-size: 15px;
            color: white;
            background-color: black;
            border-radius: 15%;
            cursor: pointer;
        }
        .contents-main {
            position: relative;
            z-index: 0;
        }
        .contents-container {
            width: 80%;
            margin-left: 280px;
        }
        textarea {
            border-radius: 10px; 
            border-color: #FFAC53;
        }
        .save-introduce {
            margin-top: 10px;
            background-color: #FFAC53;
            border-radius: 20px;
            color: white;
            border: none;
            width: 60px;
            height: 25px;
            cursor: pointer;
        }
    </style>
</head>
<body style="margin: 0;">
    <%@ include file="./tag_common/header.jsp" %>
    <div style="display: flex;">
        <%@ include file="./tag_common/sidebar.jsp" %>
        <div class="profile-container">
            <label for="file-input">
                <img id="profile-image" class="profile-image" alt="Profile Image" src="<%= userimgSrc %>">
            </label>
            <input id="file-input" type="file" style="display: none;">
            <div class="user-info">
                <p>
                    <strong id="user-name"><%= userName %></strong>
                    <img id="edit-image" src="<%= editimgSrc %>" alt="Edit" style="width: 20px; height: 20px; margin-left: 10px; cursor: pointer;">
                </p>
                <p><%= userMail %></p>
                <textarea id="introduce-text" rows="4" cols="50" maxlength="100"><%= introduce %></textarea>
                <br>
                <button class="save-introduce" id="save-introduce">저장</button>
            </div>
        </div>
    </div>
    <div class="myPage-hr"></div>
    <div class="contents-container">
        <%@ include file="./tag_myPage/contents.jsp" %>
    </div>

    <script>
        document.getElementById('file-input').addEventListener('change', function(event) {
            var file = event.target.files[0];
            var reader = new FileReader();
            reader.onload = function() {
                var img = document.getElementById('profile-image');
                img.src = reader.result;
            };
            reader.readAsDataURL(file);
        });

        document.getElementById('edit-image').addEventListener('click', function() {
            var newName = prompt('새로운 이름을 입력하세요:', '<%= userName %>');
            if (newName !== null) {
                document.getElementById('user-name').textContent = newName;
            }
        });

        document.getElementById('save-introduce').addEventListener('click', function() {
            var introduceText = document.getElementById('introduce-text').value;
            introduceText = introduceText.substring(0, 100);
            alert("Introduction saved: " + introduceText);
        });
    </script>
</body>
</html>
