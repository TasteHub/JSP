<%@page contentType="text/html; charset=utf-8"%>
<%@ include file="connect_DB.jsp" %>
<%
    int userID = Integer.parseInt(request.getParameter("userID"));
    int videoID = Integer.parseInt(request.getParameter("videoID"));
    PreparedStatement pstmt=null;

    try {
        String sql = "INSERT INTO LikeBtn (videoID, userID, likeDate) VALUES (?, ?, NOW());" +
                     "UPDATE Video SET cntLike = (SELECT COUNT(likeID) FROM LikeBtn WHERE LikeBtn.videoID = ?) WHERE videoID = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, videoID);
        pstmt.setInt(2, userID);
        pstmt.setInt(3, videoID);
        pstmt.setInt(4, videoID);
        pstmt.executeUpdate();
    } catch(SQLException ex) {
        out.println("LikeBtn table insert fail");
        out.println("SQLException: " + ex.getMessage());
    } finally {
        if(pstmt != null) pstmt.close();
        if(conn != null) conn.close();
    }
%>
