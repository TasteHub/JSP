
<%@page contentType="text/html; charset=utf-8"%>
<%@ include file ="connect_DB.jsp" %>
<%	
	int userID = Integer.parseInt(request.getParameter("userID"));
	int videoID = Integer.parseInt(request.getParameter("videoID"));
	PreparedStatement pstmt=null;
	
	try{	
		String sql = "DELETE FROM View where videoID = ? AND userID = ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(2, userID);
		pstmt.setInt(1, videoID);
		pstmt.executeUpdate();
	}catch(SQLException ex){
		out.println("View table delete fail");
		out.println("SQLException: " + ex.getMessage());
	}finally{
		if(pstmt!=null)
			pstmt.close();
		if(conn!=null)
			conn.close();
		response.sendRedirect("../history.jsp");
	}
%>