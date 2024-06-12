<%@ page import="java.sql.*" %>
<%@ include file="connect_DB.jsp" %>
<%
request.setCharacterEncoding("utf-8");

int userID = Integer.parseInt(request.getParameter("userID"));
int videoID = Integer.parseInt(request.getParameter("videoID"));
PreparedStatement pstmt = null;

try {
    String sql = "DELETE FROM LikeBtn WHERE userID = ? AND videoID = ?;"
    			+"UPDATE Video SET cntLike = (SELECT count(DISTINCT LikeBtn.userID) FROM LikeBtn where LikeBtn.videoID = ?) WHERE videoID = ?;";
    pstmt = conn.prepareStatement(sql);
    pstmt.setInt(1, userID);
    pstmt.setInt(2, videoID);
    pstmt.setInt(3, videoID);
    pstmt.setInt(4, videoID);
    
    int result = pstmt.executeUpdate();

    if (result > 0) {
        out.println("좋아요가 성공적으로 취소되었습니다.");
    } else {
        out.println("좋아요 취소에 실패했습니다.");
    }

    response.sendRedirect("../videoDetailsPage.jsp?videoID=" + videoID);

} catch (SQLException ex) {
    out.println("좋아요 취소 도중 오류가 발생했습니다: " + ex.getMessage());
} finally {
    // 자원 해제
    if (pstmt != null) try { pstmt.close(); } catch (SQLException ignore) {}
    if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
}
%>
