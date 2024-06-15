<%@ page import="java.sql.*" %>
<%@ include file="connect_DB.jsp" %>
<%
request.setCharacterEncoding("utf-8");

String email = request.getParameter("email");
String passwd = request.getParameter("password");

ResultSet rs = null;
PreparedStatement pstmt = null;

try {
    String sql = "SELECT email, userID, userName, urlUserImg, urlBackImg, introTxt FROM User WHERE email=? AND passwd=?";
    pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, email);
    pstmt.setString(2, passwd);
    rs = pstmt.executeQuery();
    
    if (rs.next()) {
        String userID = rs.getString("userID");
        String name = rs.getString("userName");
        String profileImage = rs.getString("urlUserImg");
        String backgroundImage = rs.getString("urlBackImg");
        String introduce = rs.getString("introTxt");

        HttpSession sessionObj = request.getSession();
        sessionObj.setAttribute("email", email);
        sessionObj.setAttribute("userID", userID);
        sessionObj.setAttribute("userName", name);
        sessionObj.setAttribute("urlUserImg", profileImage);
        sessionObj.setAttribute("urlBackImg", backgroundImage);
        sessionObj.setAttribute("introTxt", introduce);
        
        response.sendRedirect("../home.do");
    } else {
    	response.sendRedirect("../login.jsp?error=존재하지 않는 회원 정보입니다.");
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
