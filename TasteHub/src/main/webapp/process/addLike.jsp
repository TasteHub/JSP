<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="connect_DB.jsp" %>
<%
request.setCharacterEncoding("utf-8");

String userIDStr = request.getParameter("userID");
String videoIDStr = request.getParameter("videoID");
int userID = 0;
int videoID = 0;

try {
    if (userIDStr == null || userIDStr.isEmpty() || videoIDStr == null || videoIDStr.isEmpty()) {
        throw new IllegalArgumentException("userID 또는 videoID 매개변수가 없습니다.");
    }

    userID = Integer.parseInt(userIDStr);
    videoID = Integer.parseInt(videoIDStr);
} catch (NumberFormatException ex) {
    out.println("잘못된 userID 또는 videoID 형식: " + ex.getMessage());
    return;
} catch (IllegalArgumentException ex) {
    out.println(ex.getMessage());
    return;
}

PreparedStatement pstmt = null;

try {
    java.util.Date now = new java.util.Date();
    java.sql.Timestamp likeDate = new java.sql.Timestamp(now.getTime());

    String sql = "INSERT INTO LikeBtn (userID, videoID, likeDate) VALUES (?, ?, ?)";
    pstmt = conn.prepareStatement(sql);
    pstmt.setInt(1, userID);
    pstmt.setInt(2, videoID);
    pstmt.setTimestamp(3, likeDate);

    int result = pstmt.executeUpdate();

    if (result > 0) {
        out.println("좋아요가 성공적으로 추가되었습니다.");
    } else {
        out.println("좋아요 추가에 실패했습니다.");
    }

    response.sendRedirect("../videoDetailsPage.jsp?videoID=" + videoID);

} catch (SQLException ex) {
    out.println("좋아요 추가 도중 오류가 발생했습니다: " + ex.getMessage());
} finally {
    if (pstmt != null) try { pstmt.close(); } catch (SQLException ignore) {}
    if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
}
%>
