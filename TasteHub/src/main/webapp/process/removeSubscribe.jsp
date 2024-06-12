<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="connect_DB.jsp" %>
<%
request.setCharacterEncoding("utf-8");

String userIDStr = request.getParameter("userID");
String userSubIDStr = request.getParameter("userSubID");
int userID = 0;
int userSubID = 0;

try {
    if (userIDStr == null || userIDStr.isEmpty() || userSubIDStr == null || userSubIDStr.isEmpty()) {
        throw new IllegalArgumentException("userID 또는 userSubID 매개변수가 없습니다.");
    }

    userID = Integer.parseInt(userIDStr);
    userSubID = Integer.parseInt(userSubIDStr);
} catch (NumberFormatException ex) {
    out.println("잘못된 userID 또는 userSubID 형식: " + ex.getMessage());
    return;
} catch (IllegalArgumentException ex) {
    out.println(ex.getMessage());
    return;
}

PreparedStatement pstmt = null;

try {
    String sql = "DELETE FROM Subscribe WHERE userID = ? AND userSubID = ?;"
   				+"UPDATE User SET cntSub = (SELECT count(DISTINCT Subscribe.userID) FROM Subscribe where userSubID = ?) WHERE userID = ?;";
    pstmt = conn.prepareStatement(sql);
    pstmt.setInt(1, userID);
    pstmt.setInt(2, userSubID);
    pstmt.setInt(3, userSubID);
    pstmt.setInt(4, userSubID);
    
    int result = pstmt.executeUpdate();

    if (result > 0) {
        out.println("구독이 성공적으로 제거되었습니다.");
    } else {
        out.println("구독 제거에 실패했습니다.");
    }
	

} catch (SQLException ex) {
    out.println("구독 제거 도중 오류가 발생했습니다: " + ex.getMessage());
} finally {
	
    if (pstmt != null) try { pstmt.close(); } catch (SQLException ignore) {}
    if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
    
    if (request.getParameter("videoID") != null)
    	response.sendRedirect("../videoDetailsPage.jsp?videoID=" + request.getParameter("videoID")); 
    else if (request.getParameter("state").equals("2"))
    	response.sendRedirect("../subscribe.do"); 
    else if (request.getParameter("state").equals("1"))
    	response.sendRedirect("../channel.jsp?userID=" + request.getParameter("userSubID")); 
    	
}
%>
