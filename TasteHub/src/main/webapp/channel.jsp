<%@page import="java.sql.*"%>
<%@page import="javax.naming.*"%>
<%@page import="javax.sql.*"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<link href="css/myPage/contents_user.css?after" rel="stylesheet" type="text/css">

<%
    String bellimgSrc = "img/VideoDetail/bell_icon.png";
%>

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
    int visitingUserID = Integer.parseInt(request.getParameter("userID")); // Get userID from URL parameter
    ResultSet rs_m = null;
    Statement stmt_m = null;
    String userName_m = "", urlUserImg_m = "", urlBackImg_m ="";
    int cntSub_m = 0; 
    
    try{    
        String sql_m = "SELECT userName, cntSub, urlUserImg, urlBackImg FROM User WHERE userID = " + visitingUserID;
        stmt_m = conn_m.prepareStatement(sql_m);
        rs_m = stmt_m.executeQuery(sql_m);
        rs_m.next();
        
        userName_m = rs_m.getString("userName");
        cntSub_m = rs_m.getInt("cntSub");
        urlUserImg_m = rs_m.getString("urlUserImg");
        urlBackImg_m = rs_m.getString("urlBackImg");

        if(urlUserImg_m == null)
            urlUserImg_m = "img/Header/userIcon.png";
        if(urlBackImg_m == null)
            urlBackImg_m = "img/MyPage/backImg.png";
    } catch(SQLException ex){
        out.println("User table select fail");
        out.println("SQLException: " + ex.getMessage());
    } finally {
        if(stmt_m!=null)
            stmt_m.close();
        if(conn_m!=null)
            conn_m.close();
    }
%>
<html>
<head>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <title>TasteHub - VideoDetailsPage</title>
    <style>
        * {
            font-family: "Arial", "Roboto", "sans-serif";
            text-decoration: none;
            color: black;
        }
        
        .background-img {
            min-height: 180px;
        }
        
        .detail-contents {
            display: flex;
            margin-top: 25px;
        }
        
        .userimg-detail {
            margin-right: 12px;
        }
        
        .text-detail {
            flex: 1;
        }
        
        .user-detail {
            font-size: 37px;
            font-weight: 1000;
            margin-top: -3px;
        }
        
        .etc-detail {
            font-size: 13px;
            color: gray;
            margin-top: -35px;
        }
        
        .profile {
            display: flex;
            flex-direction: column;
        }
        
        .content-wrapper {
            display: flex;
            flex-direction: column;
            margin-left: 10px;
            margin-top: 30px;
            overflow-y: scroll;
            height: calc(100vh - 80px);
            min-width: 81%;
        }
        
        .subs-btn {
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
            margin-top: 45px;
            width: 100px;
            background-color: #e9ecef;
            color: black;
            padding-left: 10px;
            padding-right: 10px;
        }
        
        .subs-btn-clicked {
            background-color: black;
            color: white;
            width: 65px;
        }
        
        .subscribe-hr { 
            width: 95%; 
            height: 1px;
            min-height: 1px;
            background-color: #FFAC53;
            margin: 0;
            margin-top: 20px;
            margin-bottom: 10px;
        }

    </style>           
</head>
<body style="margin: 0; overflow-y: hidden">
    <%@ include file="./tag_common/header.jsp" %>
    <div style="display: flex;">
        <%@ include file="./tag_common/sidebar.jsp" %>
        <div class="content-wrapper">
        <div class="background-img">
        	<img src="<%= urlBackImg_m %>" alt="Background Image" style="width: 95%; height: 180px; border-radius: 15px; object-fit: cover; ">
    	</div>
<div class="user-profile-container" style="display: flex; align-items: center; margin-top: 3%;">
    <div class="userimg-detail">
        <img src="<%= urlUserImg_m %>" alt="User Image" style="width: 150px; height: 150px; border-radius: 50%; object-fit: cover;">
    </div>
    <div class="profile" style="margin-left: 20px;;">
        <p class="user-detail"><%= userName_m %><br></p>
        <p class="etc-detail">구독자 <%= cntSub_m %>명 · 동영상 500개</p>
        <button id="subscribeButton" class="subs-btn">
            <img src="<%= bellimgSrc %>" alt="Bell Icon" style="width: 20px; height: 20px; margin-right: 5px;"> 구독중
        </button>
    </div>
</div>
            <div class="subscribe-hr"></div>

            <div class="contents">
                <%@ include file="./tag_channel/contents.jsp" %>
            </div>
        </div>
    </div>
<script>
    document.getElementById('subscribeButton').addEventListener('click', function() {
        var button = this;
        if (button.classList.contains('subs-btn-clicked')) {
            button.classList.remove('subs-btn-clicked');
            button.innerHTML = '<img src="<%= bellimgSrc %>" alt="Bell Icon" style="width: 20px; height: 20px; margin-right: 5px;"> 구독중';
        } else {
            button.classList.add('subs-btn-clicked');
            button.innerHTML = '구독';
        }
    });
</script>

</body>
</html>
