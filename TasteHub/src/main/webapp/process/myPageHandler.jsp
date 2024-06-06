<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="connect_DB.jsp" %>
<%
request.setCharacterEncoding("utf-8");

String userID = (String)session.getAttribute("userID");

String userName = request.getParameter("name");
String urlUserImg = request.getParameter("profileImage");
String urlBackImg = request.getParameter("backgroundImage");
String introTxt = request.getParameter("introduce");

// 입력되지 않은 부분이 비어 있는지 확인하고 null로 처리
if (userName == null || userName.trim().isEmpty()) {
    userName = null;
}
if (urlUserImg == null || urlUserImg.trim().isEmpty()) {
    urlUserImg = null;
}
if (urlBackImg == null || urlBackImg.trim().isEmpty()) {
    urlBackImg = null;
}
if (introTxt == null || introTxt.trim().isEmpty()) {
    introTxt = null;
}

PreparedStatement pstmt = null;

try {
    String sql = "UPDATE User SET userName = ?, urlUserImg = ?, urlBackImg = ?, introTxt = ? WHERE userID = ?";
    pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, userName);
    pstmt.setString(2, urlUserImg);
    pstmt.setString(3, urlBackImg);
    pstmt.setString(4, introTxt);
    pstmt.setString(5, userID);

    int rowsAffected = pstmt.executeUpdate();

    if (rowsAffected > 0) {
        out.println("정보 업데이트에 성공했습니다.");
    } else {
        out.println("정보 업데이트에 실패했습니다.");
    }
} catch (SQLException ex) {
    out.println("SQLException: " + ex.getMessage());
} finally {
    try {
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    } catch (SQLException ex) {
        out.println("SQLException in finally: " + ex.getMessage());
    }
}
%>
