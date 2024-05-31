<%@ page import="java.sql.*" %>
<%@ include file="connect_DB.jsp" %>
<%
request.setCharacterEncoding("utf-8");

String email = request.getParameter("email");
String passwd = request.getParameter("password");

ResultSet rs = null;
PreparedStatement pstmt = null;

try {
    String sql = "SELECT email, passwd FROM User WHERE email=? AND passwd=?";
    pstmt = conn.prepareStatement(sql);
    out.println(email);
    out.println(passwd);
    pstmt.setString(1, email);
    pstmt.setString(2, passwd);
    rs = pstmt.executeQuery();
    
    if (rs.next()) {
        out.println("login success");
        response.sendRedirect("../home.jsp");
    } else {
        out.println("login fail");
        response.sendRedirect("../login.jsp");
    }
} catch (SQLException ex) {
    out.println("SQLException: " + ex.getMessage());
} finally {
    
    try {
        if (rs != null) rs.close();
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    } catch (SQLException ex) {
        out.println("SQLException in finally: " + ex.getMessage());
    }
}
%>
