<%@ page import="java.util.List" %>
<%@ page import="mvc.model.VideoDTO" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<link href="css/subscribe/contents_channel.css?after" rel="stylesheet" type="text/css">
<form class="contents-main" action="./subscribe.do" method="post">
<style>
	.noSub-contents{
		display: flex;
		flex-direction: column;
		width: 70%;
		height: 600px;
		align-items: center;
		justify-content: center;
		.img-noSub{
			width: 200px;
			margin-bottom: 10px;
		}
		
		.text-noSub{
			text-align: center;
			*{
				color: black;
				margin: 5px;
			}
		}
</style>
<%
    String bellimgSrc = "img/VideoDetail/bell_icon.png";
    String userimgSrc = "img/Header/profileImg.jpg";

    List<VideoDTO> subsChannelList = (List<VideoDTO>) request.getAttribute("subsChannelList");
    int i = 0;
    if (subsChannelList != null) {
        for (i = 0; i < subsChannelList.size(); i++) {
            VideoDTO video = subsChannelList.get(i);
            String userID = video.getTitle(); 
            String urlUserImg = video.getUrlUserImg();
            String userName = video.getUserName();
            String email = video.getEmail();
            String introTxt = video.getIntroTxt();
                
            if (introTxt.length() > 100)
                introTxt = introTxt.substring(0, 100) + "...";
%>

            <div class="channel-content">
                <a href="channel.jsp?userID=<%= userID %>">
                    <img class="profile" alt="" src="<%= userimgSrc %>" />
                </a>
                <div class="text-channel">
                    <div class="name-channel">
                        <a href="channel.jsp?userID=<%= userID %>">
                            <p class="user-name"><%= userName %></p>
                        </a>
                        <div class="subs-btn">
                            <button type="button" class="subs-btn">
                                <img src="<%= bellimgSrc %>" alt="Bell Icon" style="width: 20px; height: 20px; margin-right: 5px;"> 구독중
                            </button>
                        </div>
                    </div>
                    <p class="etc-text"><%= email %></p>
                    <p class="intro-text"><%= introTxt %></p>
                </div>
            </div>
<%
        }
    }
%>

<% 
    if (i == 0) {
%>
    <div class="noSub-contents">
        <img class="img-noSub" alt="" src="img/Subscribe/noSubImg.png">
        <div class="text-noSub">
            <h2>구독한 채널이 없습니다.</h2>
            <p>관심 있는 채널을 구독해보세요!</p>
        </div>
    </div>
<%
    }
%>
</form>
