<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file ="../process/connect_DB.jsp" %>

<%
    int videoID = Integer.parseInt(request.getParameter("videoID"));
    int userID = Integer.parseInt(request.getParameter("userID"));
    try {
        String sql = "SELECT * FROM LikeBtn WHERE userID=? AND videoID=?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userID);
            stmt.setInt(2, videoID);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    sql = "DELETE FROM LikeBtn WHERE userID=? AND videoID=?";
                } else {
                    sql = "INSERT INTO LikeBtn (userID, videoID, likeDate) VALUES (?, ?, NOW())";
                }
            }
        }
        
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userID);
            stmt.setInt(2, videoID);
            stmt.executeUpdate();
        }
        response.setStatus(200);
    } catch (SQLException ex) {
        response.setStatus(500);
        ex.printStackTrace();
    }
%>
