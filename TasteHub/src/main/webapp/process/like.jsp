<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file ="../process/connect_DB.jsp" %>

<%
    int videoID = Integer.parseInt(request.getParameter("videoID"));
    int userID = Integer.parseInt(request.getParameter("userID"));
    try {
        // 좋아요 버튼 상태를 확인하여 추가 또는 제거
        String sql = "SELECT * FROM LikeBtn WHERE userID=? AND videoID=?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userID);
            stmt.setInt(2, videoID);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    // 이미 좋아요한 경우, 좋아요 취소
                    sql = "DELETE FROM LikeBtn WHERE userID=? AND videoID=?";
                } else {
                    // 좋아요하지 않은 경우, 좋아요 추가
                    sql = "INSERT INTO LikeBtn (userID, videoID, likeDate) VALUES (?, ?, NOW())";
                }
            }
        }
        
        // 쿼리 실행
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userID);
            stmt.setInt(2, videoID);
            stmt.executeUpdate();
        }
        // 변경 사항을 적용했으므로 성공 상태 코드 전송
        response.setStatus(200);
    } catch (SQLException ex) {
        // 오류가 발생한 경우 500 상태 코드 전송
        response.setStatus(500);
        ex.printStackTrace();
    }
%>
