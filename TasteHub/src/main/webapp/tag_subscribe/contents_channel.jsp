<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Calendar" %>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" %>
<link href="css/subscribe/contents_channel.css?after" rel="stylesheet" type="text/css">

<%
    String userName = "이름";  
    String introduce = "자기소개 자기소개 자기소개 자기소개 자기소개 자기소개 자기소개 자기소개 자기소개 자기소개 자기소개 자기소개 자기소개 자기소개 자기소개 자기소개 자기소개 자기소개";
    String bellimgSrc = "img/VideoDetail/bell_icon.png";
    String userimgSrc = "img/Header/profileImg.jpg";
%>

<div class="contents-main">
    <% for (int i = 0; i < 10; i++) { %>  
        <div class="content-contents_list">
            <div class="channel-content">
                <a href="channel.jsp">
                    <img class="profile" alt="" src="<%= userimgSrc %>" />
                </a>
                <div class="text-channel">
                    <div class="name-channel">
                        <a href="channel.jsp">
                            <p class="user-name"><%= userName %></p>
                        </a>
                        <div class="subs-btn">
                            <button id="subscribeButton" class="subs-btn"><img src="<%= bellimgSrc %>" alt="Bell Icon" style="width: 20px; height: 20px; margin-right: 5px;"> 구독중</button>
                        </div>
                    </div>
                    <p class="etc-text">@abcde · 구독자 100.0만명</p>
                    <p class="intro-text"><%= introduce %></p>
                </div>
            </div>
        </div>
    <% } %>  
</div>

<script>
    document.querySelectorAll('.subs-btn').forEach(button => {
        button.addEventListener('click', function() {
            if (this.classList.contains('subs-btn-clicked')) {
                this.classList.remove('subs-btn-clicked');
                this.innerHTML = '<img src="<%= bellimgSrc %>" alt="Bell Icon" style="width: 20px; height: 20px; margin-right: 5px;"> 구독중';
            } else {
                this.classList.add('subs-btn-clicked');
                this.innerHTML = '구독';
            }
        });
    });
</script>
