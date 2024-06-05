<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Logout</title>
</head>
<body>
<%
    HttpSession currentSession = request.getSession(false); 
    if (currentSession != null) {
        currentSession.invalidate(); 
    }
    
    response.sendRedirect("home.jsp");
%>
</body>
</html>

