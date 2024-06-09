<%@ page import="java.sql.*" %>
<%@ include file="connect_DB.jsp" %>
<%
request.setCharacterEncoding("utf-8");

String userID = (String)session.getAttribute("userID");

String userName = request.getParameter("userName");
String profileImage = request.getParameter("profileImage");
String backgroundImage = request.getParameter("backgroundImage");
String introduce = request.getParameter("introduce");

PreparedStatement pstmt = null;

try {
    String sql = "UPDATE User SET userName = ?, urlUserImg = ?, urlBackImg = ?, introTxt = ? WHERE userID = ?";
    pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, userName);
    pstmt.setString(2, profileImage);
    pstmt.setString(3, backgroundImage);
    pstmt.setString(4, introduce);
    pstmt.setString(5, userID);

    int rowsAffected = pstmt.executeUpdate();

    if (rowsAffected > 0) {
        response.sendRedirect("../myPage.jsp");
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