<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="connect_DB.jsp" %>

<%
String subID = request.getParameter("channelID"); // 이 부분을 수정하여 request의 채널 ID 파라미터를 가져옵니다.
String userID = request.getParameter("userID");

PreparedStatement pstmt = null;

try {
    String checkQuery = "SELECT * FROM Subscription WHERE subID = ? AND userID = ?";
    pstmt = conn.prepareStatement(checkQuery);
    pstmt.setString(1, subID);
    pstmt.setString(2, userID);
    ResultSet rs = pstmt.executeQuery();

    if (rs.next()) {
        String deleteQuery = "DELETE FROM Subscription WHERE subID = ? AND userID = ?";
        pstmt = conn.prepareStatement(deleteQuery);
        pstmt.setString(1, subID);
        pstmt.setString(2, userID);
        pstmt.executeUpdate();
        
        String updateSubscriberCountQuery = "UPDATE Channel SET userSubID = userSubID - 1 WHERE subID = ?";
        pstmt = conn.prepareStatement(updateSubscriberCountQuery);
        pstmt.setString(1, subID);
        pstmt.executeUpdate();
    } else {
        String insertQuery = "INSERT INTO Subscription (subID, userID) VALUES (?, ?)";
        pstmt = conn.prepareStatement(insertQuery);
        pstmt.setString(1, subID);
        pstmt.setString(2, userID);
        pstmt.executeUpdate();

        String updateSubscriberCountQuery = "UPDATE Channel SET userSubID = userSubID + 1 WHERE subID = ?";
        pstmt = conn.prepareStatement(updateSubscriberCountQuery);
        pstmt.setString(1, subID);
        pstmt.executeUpdate();
    }
} catch (SQLException e) {
    e.printStackTrace();
} finally {
    // 리소스 정리
    if (pstmt != null) {
        try {
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
%>
