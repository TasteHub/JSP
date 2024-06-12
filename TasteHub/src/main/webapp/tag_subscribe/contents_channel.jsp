<%@ page import="java.util.List" %>
<%@ page import="mvc.model.VideoDTO" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<link href="css/subscribe/contents_channel.css?after" rel="stylesheet" type="text/css">

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
<form class="contents-main" action="./subscribe.do" method="post">
<%
String userID = (String) session.getAttribute("userID");
    String bellimgSrc = "img/VideoDetail/bell_icon.png";

    List<VideoDTO> subsChannelList = (List<VideoDTO>) request.getAttribute("videolist");
    int i = 0;
    if (subsChannelList != null) {
        for (i = 0; i < subsChannelList.size(); i++) {
            VideoDTO video = subsChannelList.get(i);
            int userSubID1 = video.getUserID(); 
            String urlUserImg = video.getUrlUserImg();
            String userName = video.getUserName();
            String email = video.getEmail();
            String introTxt = video.getIntroTxt();
                
            if (introTxt.length() > 100)
                introTxt = introTxt.substring(0, 100) + "...";
%>

            <div class="channel-content" style="margin-top: 30px;">
                <a href="channel.jsp?userID=<%= userSubID1 %>">
                    <img class="profile" alt="" src="<%= urlUserImg %>" />
                </a>
                <div class="text-channel">
                    <div class="name-channel">
                        <a href="channel.jsp?userID=<%= userSubID1 %>">
                            <p class="user-name"><%= userName %></p>
                        </a>
                        <div class="subs-btn">
                        <a href="process/removeSubscribe.jsp?userID=<%= userID %>&userSubID=<%=userSubID1 %>&state=2" 
                        style="width: 100%; text-align: center;">
                           구독중
                         </a>
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
