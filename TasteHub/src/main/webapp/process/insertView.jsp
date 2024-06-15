<%@page import="javax.sql.*"%>
<%@page import="javax.naming.*"%>
<%@page import="java.sql.*"%>
<%
	Connection conn_visit = null;

	try {
		Context init = new InitialContext();
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/mysql");
		conn_visit = ds.getConnection();
	} catch (Exception e) {
		out.println("연결 실패");
		out.println(e.getMessage());
	}
%>
<%
	//방문 기록 작성
	int visitUserID = Integer.parseInt((String)session.getAttribute("userID"));
	int visitVideoID = Integer.parseInt(request.getParameter("videoID"));
	PreparedStatement pstmt_visit = null;
	
	try{	
		String sql = "INSERT INTO View(userID, videoID, viewDate) VALUES (?, ?, now()); "+
					 "UPDATE Video SET cntView = (SELECT count(DISTINCT View.userID) FROM View WHERE View.videoID = ?) WHERE videoID = ?;";
		pstmt_visit = conn_visit.prepareStatement(sql);
		pstmt_visit.setInt(1, visitUserID);
		pstmt_visit.setInt(2, visitVideoID);
		pstmt_visit.setInt(3, visitVideoID);
		pstmt_visit.setInt(4, visitVideoID);
		pstmt_visit.executeUpdate();
	}catch(SQLException ex){
		out.println("View table insert fail");
		out.println("SQLException: " + ex.getMessage());
	}finally{
		if(pstmt_visit!=null)
			pstmt_visit.close();
		if(conn_visit!=null)
			conn_visit.close();
	}
%>