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
	<h2>JDBC����̹� �׽�Ʈ</h2>

	<%
	Connection conn = null;

	try {
		Context init = new InitialContext();
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/mysql");
		conn = ds.getConnection();
		out.println("���� ����");
	} catch (Exception e) {
		out.println("���� ����");
		out.println(e.getMessage());
	}
	
	conn.close();
	%>
</body>
</html>