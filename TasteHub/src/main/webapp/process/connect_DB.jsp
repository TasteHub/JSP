<%@page import="javax.sql.*"%>
<%@page import="javax.naming.*"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<h2>JDBC드라이버 테스트</h2>

	<%
	Connection conn = null;

	try {
		Context init = new InitialContext();
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/mysql");
		conn = ds.getConnection();
		out.println("연결 성공");
	} catch (Exception e) {
		out.println("연결 실패");
		out.println(e.getMessage());
	}
	
	conn.close();
	%>
</body>
</html>