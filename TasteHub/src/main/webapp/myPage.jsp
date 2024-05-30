<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
    String userimgSrc = "img/Header/profileImg.jpg";
    String editimgSrc = "img/MyPage/editImg.png";
    String userName = "이름";  
    String userMail = "aaa@bbb.ccc"; 
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
            </div>
        </div>
    </div>
    <div class="myPage-hr"></div>
    <div class="myPage-first">
        <img alt="" src="img/MyPage/myPageImage.jpg" width="130px" height="">
        <p>원하는 기기에서 콘텐츠를 만드세요<br>
        <p>집에서는 물론 이동 중에도 녹화하고 업로드할 수<br>있습니다. 공개 상태로 설정한 모든 콘텐츠가 여기<br>에 표시됩니다.<br><br>
        <input type="button" class="create-btn" value="만들기" id="create-button">
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

        document.getElementById('create-button').addEventListener('click', function() {
            window.location.href = "studio.jsp";
        });
    </script>
</body>
</html>

