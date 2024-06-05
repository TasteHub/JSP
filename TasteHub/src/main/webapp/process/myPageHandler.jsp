<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ include file="connect_DB.jsp" %>
<%
request.setCharacterEncoding("utf-8");

// 세션에서 사용자 ID 가져오기
String userID = (String) session.getAttribute("userID");

// 폼에서 전송된 수정된 정보 가져오기
String newUserName = request.getParameter("name");
String newUrlUserImg = request.getParameter("profileImage");
String newUrlBackImg = request.getParameter("backgroundImage");
String newIntroTxt = request.getParameter("introduce");

PreparedStatement pstmt = null;

try {
    String sql = "UPDATE User SET userName=?, urlUserImg=?, urlBackImg=?, introTxt=? WHERE userID=?";
    pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, newUserName);
    pstmt.setString(2, newUrlUserImg);
    pstmt.setString(3, newUrlBackImg);
    pstmt.setString(4, newIntroTxt);
    pstmt.setString(5, userID);

    int result = pstmt.executeUpdate();
    
    if (result > 0) {
        // 업데이트가 성공하면 세션에도 변경된 정보 업데이트
        HttpSession sessionObj = request.getSession();
        sessionObj.setAttribute("userName", newUserName);
        sessionObj.setAttribute("urlUserImg", newUrlUserImg);
        sessionObj.setAttribute("urlBackImg", newUrlBackImg);
        sessionObj.setAttribute("introTxt", newIntroTxt);
        
        response.sendRedirect("../myPage.jsp");
    } else {
        out.println("Failed to update user information.");
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
