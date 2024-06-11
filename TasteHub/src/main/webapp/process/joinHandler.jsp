<%@ page import="java.sql.*" %>
<%@ include file="connect_DB.jsp" %>
<%
request.setCharacterEncoding("utf-8");

String userName = request.getParameter("name");
String email = request.getParameter("email");
String password = request.getParameter("password");

PreparedStatement pstmt = null;

try {
    String sql = "INSERT INTO User (userName, email, passwd, urlUserImg) VALUES (?, ?, ?, ?)";
    pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, userName);
    pstmt.setString(2, email);
    pstmt.setString(3, password);
    pstmt.setString(4, "img/Header/defaultIcon.png");
    
    int rowsAffected = pstmt.executeUpdate();
    
    if (rowsAffected > 0) {
        response.sendRedirect("../login.jsp");
    } else {
        out.println("회원가입에 실패했습니다.");
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
