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

<%@page contentType="text/html; charset=utf-8"%>
<%	
	Region region = Region.AP_NORTHEAST_2;
	AwsBasicCredentials awsCreds = AwsBasicCredentials.create("accessKey",
			"secretKey");
	String bucketname = "bucket-tastehub";
	S3Client client = S3Client.builder().region(region)
            .credentialsProvider(StaticCredentialsProvider.create(awsCreds))
            .build();

	MultipartRequest multi = new MultipartRequest(request, "C:\\upload", 5 * 1024 * 1024,
			"utf-8", new DefaultFileRenamePolicy());
	
	Enumeration <?>files = multi.getFileNames();
	while(files.hasMoreElements()){
		String name = (String)files.nextElement();
		String keyname = "studio/" + UUID.randomUUID() + multi.getOriginalFileName(name);
		File file = multi.getFile(name);
		
		PutObjectRequest requestb = PutObjectRequest.builder()
				.bucket(bucketname).key(keyname).acl("public-read").build();
		
		client.putObject(requestb, RequestBody.fromFile(file));
	}
	response.sendRedirect("../myPage.jsp");
%>