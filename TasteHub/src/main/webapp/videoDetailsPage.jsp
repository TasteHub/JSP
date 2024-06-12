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
    String introTxt = "";
    int upUserID = 0;

    try {
        String sql = "SELECT v.urlVideo, v.title, v.cntView, v.createDate, v.detail, v.userID, u.userName, u.introTxt, u.urlUserImg FROM Video v JOIN User u ON v.userID = u.userID WHERE v.videoID = ?";
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
            introTxt = rs.getString("introTxt");
            upUserID = rs.getInt("userID");
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

<%
    String userID = (String) session.getAttribute("userID");
    boolean substate = false; 

    try {
    	String sql = "SELECT * FROM Subscribe WHERE userSubID = ? AND userID = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(2, userID);
        stmt.setInt(1, upUserID);
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            substate = true;
        }
    } catch (SQLException ex) {
        out.println("구독 정보를 확인하는 도중 오류가 발생했습니다: " + ex.getMessage());
    }
%>

<%
    boolean substateL = false; 

    try {
        String sql = "SELECT * FROM LikeBtn WHERE userID = ? AND videoID = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, userID);
        stmt.setInt(2, videoID);
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            substateL = true;
        }
    } catch (SQLException ex) {
        out.println("좋아요 정보를 확인하는 도중 오류가 발생했습니다: " + ex.getMessage());
    }
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
            margin-top: -35px;
        }
        
        .text-detail {
            flex: 1;
            margin-top: 10px;
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
        
        .introduce-detail {
        	font-size: 14px;
        	color: black;
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

        .subs-btn, .like-btn, .subs-btn-clicked, .like-btn-clicked {
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
            margin-bottom: 50px;
            max-width: 84%;
            background-color: #e9ecef;
            border-radius: 10px;
            padding: 20px;
        }
        
        .view-more-content {
            font-size: 15px;
        }

        .profile {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            margin-right: 10px;
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
                <a href="channel.jsp?userID=<%= upUserID %>" class="userimg-detail">
                	<img src="<%= urlUserImg %>" alt="User Image" style="width: 50px; height: 50px; border-radius: 50%; object-fit: cover;">
                </a>
                <div class="text-detail">
                    <p class="title-detail"><%= title %></p>
                    <p class="user-detail"><%= userName %></p>
                    <p class="etc-detail"><%= cntView %>회 · <%= createDate %></p>
                </div>
            </div>
	        <div class="button-wrapper">         
			    <% if (substate) { %>
			        <a href="process/removeSubscribe.jsp?videoID=<%= videoID %>&userID=<%= userID %>&userSubID=<%= upUserID %>">
			            <button id="subscribeButton" class="subs-btn-clicked">구독중</button>
			        </a>
			    <% } else { %>
			        <a href="process/addSubscribe.jsp?videoID=<%= videoID %>&userID=<%= userID %>&userSubID=<%= upUserID %>">
			            <button id="subscribeButton" class="subs-btn">구독</button>
			        </a>
			    <% } %>
	            
	            <% if (substateL) { %>
		            <a href="process/removeLike.jsp?videoID=<%= videoID %>&userID=<%= logUserID %>">
		            	<button id="likeButton" class="like-btn-clicked">
	                    	<img src="<%= likeAftimgSrc %>" alt="like icon" style="width:20px; height:20px; margin-right:5px;">좋아요
	                	</button>
		        	</a>
	            <% } else { %>
		            <a href="process/addLike.jsp?videoID=<%= videoID %>&userID=<%= logUserID %>">
		                <button id="likeButton" class="like-btn">
	                    	<img src="<%= likeBefimgSrc %>" alt="like icon" style="width:20px; height:20px; margin-right:5px;">좋아요
	                	</button>
		            </a>
	            <% } %>
            </div>
            <div class="view-more-section">
                <div id="viewMoreContent" class="view-more-content">
                    <pre><%= viewMore %></pre>
                </div>
            </div>
        </div>
    </div>
<%
	if(conn!=null){
		conn.close();
	}
%>
</body>
</html>