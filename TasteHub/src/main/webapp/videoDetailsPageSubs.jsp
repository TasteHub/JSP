<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
    // 데이터베이스 연결
    Connection conn = null;
    try {
        Context initContext = new InitialContext();
        DataSource ds = (DataSource)initContext.lookup("java:comp/env/jdbc/mysql");
        conn = ds.getConnection();
    } catch (Exception e) {
        out.println("데이터베이스 연결 실패: " + e.getMessage());
    }

    String bellimgSrc = "img/VideoDetail/bell_icon.png";
    String likeBefimgSrc = "img/VideoDetail/like_bef.png";
    String likeAftimgSrc = "img/VideoDetail/like_aft.png";
    String closeimgSrc = "img/VideoDetail/close.png";

    int videoID = Integer.parseInt(request.getParameter("videoID"));

    String title = ""; // 제목
    String userName = ""; // 사용자 이름
    int cntView = 0; // 조회수
    String createDate = ""; // 생성일자
    String urlUserImg = ""; // 사용자 이미지 URL
    String viewMore = "";
    String urlVideo = "";

    try {
        String sql = "SELECT v.urlVideo, v.title, v.cntView, v.createDate, v.detail, u.userName, u.urlUserImg FROM Video v JOIN User u ON v.userID = u.userID WHERE v.videoID = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, videoID);
        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            title = rs.getString("title");
            userName = rs.getString("userName");
            cntView = rs.getInt("cntView");
            createDate = rs.getString("createDate");
            urlUserImg = rs.getString("urlUserImg");
            viewMore = rs.getString("detail");
            urlVideo = rs.getString("urlVideo");
        }
    } catch (SQLException ex) {
        out.println("데이터베이스에서 정보를 가져오는 도중 오류가 발생했습니다: " + ex.getMessage());
    }

    String logUserImg = ""; // 로그인한 사용자의 프로필 이미지 URL
    String logUserID = ""; // 로그인한 사용자 ID
    if (request.getSession().getAttribute("userID") != null) {
        logUserID = (String) request.getSession().getAttribute("userID");
        // 여기서 userID를 이용하여 데이터베이스에서 사용자의 프로필 이미지 URL을 가져옵니다.
        try {
            String sql = "SELECT urlUserImg FROM User WHERE userID = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, logUserID);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                logUserImg = rs.getString("urlUserImg");
            }
        } catch (SQLException ex) {
            out.println("데이터베이스에서 로그인한 사용자의 프로필 이미지를 가져오는 도중 오류가 발생했습니다: " + ex.getMessage());
        }
    }
%>
<html>
<head>
    <title>TasteHub - VideoDetailsPageSubs</title>
    <style>
        * {
            font-family: "Roboto", "Arial", "sans-serif";
            text-decoration: none;
            color: black;
        } 
        .body {
        	
        }
         .video-contents {
            width: 87%;
            height: 500px;
            border-radius: 15px;
            background-color: gray;
            min-height: 500px;
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
        
        html, body {
		    height: 100%;
		    margin: 0;
		    padding: 0;
		    overflow: hidden; 
		}
        
        .content-wrapper {
            display: flex;
            position: relative;
            flex-direction: column;
            margin-left: 10px;
            margin-top: 30px;
            width: 85%;
			overflow-y: scroll;
			box-sizing: border-box;
			height: calc(100vh - 80px);
        }
        
        .button-wrapper {
            display: flex;
            align-items: center;
            margin-top: 10px;
        }

        .subs-btn-clicked, .like-btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            height: 25px;
            font-size: 13px;
            border-radius: 20px;
            border: none;
            cursor: pointer;
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
            margin-bottom: 30px;
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
		
		.profile {
			object-fit: cover;
		}
    </style>           
</head>
<body style="margin: 0;">
    <%@ include file="./tag_common/header.jsp" %>
    <div style="display: flex;">
        <%@ include file="./tag_common/sidebar.jsp" %>
        <div class="content-wrapper">
            <div class="video-contents">
                <video width="100%" height="500px"  controls>
        		<source src="<%= urlVideo %>" type="video/mp4">
    			</video>
            </div>
            <div class="detail-contents">
                <div class="userimg-detail">
                	<img src="<%= urlUserImg %>" alt="User Image" style="width: 50px; height: 50px; border-radius: 50%; object-fit: cover;">
                </div>
                <div class="text-detail">
                    <p class="title-detail"><%= title %></p>
                    <p class="user-detail"><%= userName %></p>
                    <p class="etc-detail"><%= cntView %>회 · <%= createDate %></p>
                </div>
            </div>
            <div class="button-wrapper">
            <a href="videoDetailsPage?videoID=<%= videoID %>">
                <button id="subscribeButton" class="subs-btn-clicked">구독중</button>
            </a>
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
                    <img class="profile" alt="" src="<%= logUserImg %>" />
                    <input type="text" id="commentInput" class="comment-input" placeholder="댓글을 입력하세요..." />
                    <button id="commentButton" class="comment-button">등록</button>
                </div>
                <div id="commentsContainer" class="comments-container"></div>
            </div>
        </div>
    </div>

    <script>   
        document.getElementById('commentButton').addEventListener('click', function() {
            var userImgSrc = '<%= logUserImg %>';
            var commentInput = document.getElementById('commentInput');
            var commentText = commentInput.value.trim();

            if (commentText) {
                var commentsContainer = document.getElementById('commentsContainer');

                var commentDiv = document.createElement('div');
                commentDiv.classList.add('comment');

                var profileImg = document.createElement('img');
                profileImg.classList.add('profile');
                profileImg.src = userImgSrc;
                profileImg.style.objectFit = 'cover';
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