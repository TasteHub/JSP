<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
    String title = "영상제목 최대치 채우기 영상제목 최대치 채우기 영상제목 최대치 채우기 영상제목 최대치 채우기 영상제목 최대치 채우기 ";  
    String viewMore = "더보기 더보기 더보기 더보기 더보기 더보기 더보기 더보기 더보기 더보기 더보기 더보기 더보기 더보기 더보기 더보기 더보기 더보기 더보기 더보기 더보기 더보기 더보기 더보기 더보기 더보기 더보기 더보기 더보기 더보기 더보기 더보기 더보기 더보기 더보기 더보기 더보기 더보기 더보기 "; 
    String userimgSrc = "img/Header/profileImg.jpg";
    String bellimgSrc = "img/VideoDetail/bell_icon.png";
    String likeBefimgSrc = "img/VideoDetail/like_bef.png";
    String likeAftimgSrc = "img/VideoDetail/like_aft.png";
    String closeimgSrc = "img/VideoDetail/close.png";
%>
<html>
<head>
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
            width: 85%;
        }
        
        .button-wrapper {
            display: flex;
            align-items: center;
            margin-top: 10px;
        }

        .subs-btn, .like-btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            height: 25px;
            font-size: 13px;
            border-radius: 20px;
            border: none;
            cursor: pointer;
            transition: width 0.3s;
            margin-right: 20px;
        }

        .subs-btn {
            width: 65px;
            background-color: black;
            color: white;
        }
        
        .subs-btn-clicked {
            background-color: #e9ecef;
            color: black;
            width: 100px;
        }
        
        .like-btn {
            width: 100px;
            background-color: #e9ecef;
            color: black;
        }
        
        .like-btn-clicked {
            background-color: #e9ecef;
            width: 100px;
        }
        
        .view-more-section {
            margin-top: 20px;
            max-width: 84%;
            background-color: #e9ecef;
            border-radius: 10px;
            padding: 20px;
        }
        
        .view-more-content {
            font-size: 15px;
        }
        
        .view-more-button {
            display: inline-block;
            font-size: 13px;
            background-color: #e9ecef;
            font-weight: bold;
            border: none;
            cursor: pointer;
            color: #007bff;
            margin-top: 5px;
        }
        
        .comment-section {
            max-width: 90%;
            margin-top: 30px;
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
            font-size: 13px;
            background-color: white;
            font-weight: bold;
            border: none;
            cursor: pointer;
        }

        .comments-container {
            margin: 0 auto;
            margin-top: 20px;
        }

        .comment {
            display: flex;
    		position: relative;
            display: relative;
            align-items: flex-start;
            margin-top: 20px;
            margin-bottom: 10px;
        }

        .comment .profile {
            margin-right: 15px;
        }

        .comment-content {
            padding: 10px 15px;
            position: relative;
            flex: 1; 
        }

        .comment-content p {
            margin: 0;
        }

		.close-button {
		    position: absolute;
		    top: 0;
		    right: 30;
		    width: 20px;
		    height: 20px;
		    background: url('<%= closeimgSrc %>') no-repeat center center;
		    background-size: contain;
		    border: none;
		    cursor: pointer;
		    margin-left: auto;
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
                <button id="likeButton" class="like-btn">
                    <img src="<%= likeBefimgSrc %>" alt="like icon" style="width:20px; height:20px; margin-right:5px;">좋아요
                </button>
            </div>
            <div class="view-more-section">
                <div id="viewMoreContent" class="view-more-content">
                    <%= viewMore.length() > 80 ? viewMore.substring(0, 80) + "..." : viewMore %>
                </div>
                <% if (viewMore.length() > 80) { %>
                    <button id="viewMoreButton" class="view-more-button">더보기</button>
                <% } %>
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
                button.innerHTML = '<img src="<%= bellimgSrc %>" alt="bell icon" style="width:25px; height:25px; margin-right:5px;">구독중';
            }
        });
        
        document.getElementById('likeButton').addEventListener('click', function() {
            var button = this;
            if (button.classList.contains('like-btn-clicked')) {
                button.classList.remove('like-btn-clicked');
                button.innerHTML = '<img src="<%= likeBefimgSrc %>" alt="like icon" style="width:20px; height:20px; margin-right:5px;">좋아요';
            } else {
                button.classList.add('like-btn-clicked');
                button.innerHTML = '<img src="<%= likeAftimgSrc %>" alt="like icon" style="width:20px; height:20px; margin-right:5px;">좋아요';
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

                var closeButton = document.createElement('button');
                closeButton.classList.add('close-button');
                closeButton.addEventListener('click', function() {
                    commentsContainer.removeChild(commentDiv);
                });
                commentContent.appendChild(closeButton);

                commentsContainer.prepend(commentDiv);

                commentInput.value = '';
            } 
        });

        document.getElementById('viewMoreButton').addEventListener('click', function() {
            var viewMoreContent = document.getElementById('viewMoreContent');
            var viewMoreButton = document.getElementById('viewMoreButton');
            if (viewMoreButton.innerText === '더보기') {
                viewMoreContent.innerText = '<%= viewMore %>';
                viewMoreButton.innerText = '접기';
            } else {
                viewMoreContent.innerText = '<%= viewMore.length() > 80 ? viewMore.substring(0, 80) + "..." : viewMore %>';
                viewMoreButton.innerText = '더보기';
            }
        });
    </script>
</body>
</html>
