<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
    String title = "영상제목 최대치 채우기 영상제목 최대치 채우기 영상제목 최대치 채우기 영상제목 최대치 채우기 영상제목 최대치 채우기 ";  
    String userimgSrc = "img/Header/profileImg.jpg";
%>
<html>
<head>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <title>TasteHub - VideoDetailsPage</title>
    <style>
        * {
            font-family: "Roboto", "Arial", "sans-serif";
            text-decoration: none;
            color: black;
        }
        
        .video-contents {
            width: 1060px;
            height: 500px;
            border-radius: 15px;
            background-color: gray;
        }
        
        .detail-contents {
            display: flex;
            align-items: center;
            margin-top: 10px;
        }
        
        .userimg-detail {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            margin-right: 12px;
            background-color: gray;
        }
        
        .text-detail {
            flex: 1;
        }
        
        .title-detail, .user-detail, .etc-detail {
            margin: 0;
        }
        
        .title-detail {
            font-size: 17px;
            font-weight: 700;
        }
        
        .user-detail, .etc-detail {
            font-size: 13px;
            color: gray;
        }
        
        .content-wrapper {
            display: flex;
            flex-direction: column;
            margin-left: 10px;
            margin-top: 30px;
        }
        
        .subs-btn {
            width: 65px;
            height: 25px;
            font-size: 15px;
            background-color: black;
            border-radius: 10%;
            color: white;
            border: none;
            margin-right: 10px;
            margin-top: 10px;
            cursor: pointer;
        }
        
        .subs-btn-clicked {
            background-color: #FFAC53;
            color: black;
            width: 80px;
        }
        
        .like-btn {
            width: 80px;
            height: 25px;
            font-size: 15px;
            background-color: #FFAC8880;
            border-radius: 10%;
            color: black;
            border: none;
            cursor: pointer;
        }
        
        .like-btn-clicked {
            background-color: #FFAC53;
        }
        
        .comment-section {
            margin-top: 40px;
        }

        .comment-title {
            font-size: 25px;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .comment-form {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }

        .profile {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            margin-right: 10px;
        }

        .comment-input {
            width: 89%;
            padding: 10px;
            font-size: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
            margin-right: 10px;
        }

        .comment-button {
            padding: 10px 20px;
            font-size: 15px;
            background-color: #FFAC53;
            border-radius: 5px;
            color: white;
            border: none;
            cursor: pointer;
        }

        .comments-container {
            width: 85%;
            margin: 0 auto;
            margin-top: 20px;
        }

        .comment {
            display: flex;
            align-items: flex-start;
            margin-top: 20px;
        }

        .comment .profile {
            margin-right: 15px;
        }

        .comment-content {
            background-color: #FFFAF0;
            padding: 10px 15px;
            border-radius: 5px;
            width: 100%;
        }

        .comment-content p {
            margin: 0;
        }
    </style>           
</head>
<body style="margin: 0;">
	<%@ include file="./tag_common/header.jsp" %>
    <div style="display: flex;">
        <%@ include file="./tag_common/sidebar.jsp" %>
        <div class="content-wrapper">
            <div class="video-contents"></div>
            <div class="detail-contents">
                <div class="userimg-detail"></div>
                <div class="text-detail">
                    <p class="title-detail"><%= title %></p>
                    <p class="user-detail">닉네임</p>
                    <p class="etc-detail">000회 · 2개월 전</p>
                </div>
            </div>
            <div class="button-wrapper">
                <button id="subscribeButton" class="subs-btn">구독</button>
                <button id="likeButton" class="like-btn"><i class="fas fa-thumbs-up"></i> 좋아요</button>
            </div>
            <div class="comment-section">
                <p class="comment-title">댓글</p>
                <div class="comment-form">
                    <img class="profile" alt="" src="<%= userimgSrc %>" />
                    <input type="text" id="commentInput" class="comment-input" placeholder="댓글을 입력하세요..." />
                    <button id="commentButton" class="comment-button">등록</button>
                </div>
                <div id="commentsContainer" class="comments-container"></div>
            </div>
        </div>
    </div>

    <script>
        document.getElementById('subscribeButton').addEventListener('click', function() {
            var button = this;
            if (button.classList.contains('subs-btn-clicked')) {
                button.classList.remove('subs-btn-clicked');
                button.innerHTML = '구독';
            } else {
                button.classList.add('subs-btn-clicked');
                button.innerHTML = '구독중';
            }
        });
        
        document.getElementById('likeButton').addEventListener('click', function() {
            var button = this;
            if (button.classList.contains('like-btn-clicked')) {
                button.classList.remove('like-btn-clicked');
            } else {
                button.classList.add('like-btn-clicked');
            }
        });

        document.getElementById('commentButton').addEventListener('click', function() {
            var userImgSrc = '<%= userimgSrc %>';
            var commentInput = document.getElementById('commentInput');
            var commentText = commentInput.value.trim();

            if (commentText) {
                var commentsContainer = document.getElementById('commentsContainer');

                var commentDiv = document.createElement('div');
                commentDiv.classList.add('comment');

                var profileImg = document.createElement('img');
                profileImg.classList.add('profile');
                profileImg.src = userImgSrc;
                commentDiv.appendChild(profileImg);

                var commentContent = document.createElement('div');
                commentContent.classList.add('comment-content');
                var commentParagraph = document.createElement('p');
                commentParagraph.textContent = commentText;
                commentContent.appendChild(commentParagraph);
                commentDiv.appendChild(commentContent);

                commentsContainer.prepend(commentDiv);

                commentInput.value = '';
            } else {
                alert('댓글을 입력해주세요.');
            }
        });
    </script>
</body>
</html>