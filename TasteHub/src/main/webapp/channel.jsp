<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
    String bellimgSrc = "img/VideoDetail/bell_icon.png";
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
        
        .background-img {
            width: 1060px;
            height: 180px;
            min-height: 180px;
            border-radius: 15px;
            background-color: gray;
        }
        
        .detail-contents {
            display: flex;
            margin-top: 25px;
        }
        
        .userimg-detail {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            margin-right: 12px;
            background-color: gray;
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
            width: 85%; 
            height: 1px;
            min-height: 1px;
            background-color: #FFAC53;
            margin: 0;
            margin-top: 20px;
            margin-bottom: 10px;
        }

        .latest-btn, .popularity-btn, .date-btn {
            width: 70px;
            height: 26px;
            margin-right: 7px;
            color: black;
            background-color: #dee2e6;
            margin-top: 10px;
            border: none;
            border-radius: 10%;
            cursor: pointer;
        }
        
        .active-btn {
            background-color: black;
            color: white;
        }
    </style>           
</head>
<body style="margin: 0; overflow-y: hidden">
    <%@ include file="./tag_common/header.jsp" %>
    <div style="display: flex;">
        <%@ include file="./tag_common/sidebar.jsp" %>
        <div class="content-wrapper">
            <div class="background-img"></div>
            <div class="detail-contents">
                <div class="userimg-detail"></div>
                <div class="profile">
                    <p class="user-detail">닉네임<br></p>
                    <p class="etc-detail">@channel_id · 구독자 20만명 · 동영상 100개</p>
                    <button id="subscribeButton" class="subs-btn"><img src="<%= bellimgSrc %>" alt="Bell Icon" style="width: 20px; height: 20px; margin-right: 5px;"> 구독중</button>
                </div>
            </div>
            <div class="subscribe-hr"></div>
            <div class="btn-container">
                <button id="latestBtn" class="latest-btn active-btn">최신순</button>
                <button id="popularityBtn" class="popularity-btn">인기순</button>
                <button id="dateBtn" class="date-btn">날짜순</button>
            </div>
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

        const buttons = document.querySelectorAll('.btn-container button');
        buttons.forEach(button => {
            button.addEventListener('click', function() {
                buttons.forEach(btn => btn.classList.remove('active-btn'));
                this.classList.add('active-btn');
            });
        });

        document.getElementById('latestBtn').classList.add('active-btn');
    </script>
</body>
</html>
