<%@page import="java.util.UUID"%>
<%@page import="software.amazon.awssdk.auth.credentials.StaticCredentialsProvider"%>
<%@page import="software.amazon.awssdk.auth.credentials.AwsBasicCredentials"%>
<%@page import="software.amazon.awssdk.regions.Region"%>
<%@page import="software.amazon.awssdk.core.sync.RequestBody"%>
<%@page import="software.amazon.awssdk.services.s3.model.PutObjectRequest"%>
<%@page import="software.amazon.awssdk.services.s3.S3Client"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.*" %>
<%@page import="java.sql.*" %>

<%@page contentType="text/html; charset=utf-8"%>
<%
	String[] url = new String[3];
	int index = 0;
%>
<%	
	Region region = Region.AP_NORTHEAST_2;

	//git에 키값이 안올라가서 임의로 부여(사용시 변경해야함)
	AwsBasicCredentials awsCreds = AwsBasicCredentials.create("AccessKey",
			"PrivateKey");
	String bucketname = "bucket-tastehub";
	S3Client client = S3Client.builder().region(region)
            .credentialsProvider(StaticCredentialsProvider.create(awsCreds))
            .build();

	MultipartRequest multi = new MultipartRequest(request, "C:\\upload", 512 * 1024 * 1024,
			"utf-8", new DefaultFileRenamePolicy());
	
	Enumeration <?>files = multi.getFileNames();
	while(files.hasMoreElements()){
		String name = (String)files.nextElement();
		File file = multi.getFile(name);
		if(file != null){
			//S3 bucket에 파일 넣기
			String keyname = "myPage/" + UUID.randomUUID() + multi.getOriginalFileName(name);
			
			PutObjectRequest requestb = PutObjectRequest.builder()
					.bucket(bucketname).key(keyname).acl("public-read").build();
			
			client.putObject(requestb, RequestBody.fromFile(file));
			
			//넣은 후 링크 저장(넣을 파일이 2개여서 순차적으로 저장)
			if(name.equals("backgroundImage")){
				url[1] = new String();
				url[1] = "https://bucket-tastehub.s3.ap-northeast-2.amazonaws.com/" + keyname;
			}
			else if(name.equals("profileImage")){
				url[0] = new String();
				url[0] = "https://bucket-tastehub.s3.ap-northeast-2.amazonaws.com/" + keyname;
			}
		}
	}
%>
<%@ include file ="connect_DB.jsp" %>
<%
	int userID = Integer.parseInt((String)session.getAttribute("userID"));
	String userName = multi.getParameter("userName");
	String introTxt = multi.getParameter("introTxt");	

	PreparedStatement pstmt=null;
	String sql_back = "";
	if(url[1] != null){
		sql_back = ", urlBackImg = '" + url[1] + "'";
	}
	String sql_user = "";
	if(url[0] != null){
		sql_user = ", urlUserImg = '" + url[0] + "'";
	}
	try{	
		String sql = "UPDATE User SET userName = ?, introTxt = ?" + sql_back + sql_user+" WHERE userID = " + userID;

		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, userName);
		pstmt.setString(2, introTxt);
		
		pstmt.executeUpdate();
	}catch(SQLException ex){
		out.println("User table insert fail");
		out.println("SQLException: " + ex.getMessage());
	}finally{
		if(pstmt!=null)
			pstmt.close();
		if(conn!=null)
			conn.close();
		response.sendRedirect("../myVideoList.do");
	}
%>