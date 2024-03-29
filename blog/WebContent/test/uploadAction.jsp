<%@page import="com.cos.util.DBClose"%>
<%@page import="java.sql.SQLException"%>
<%@page import="dao.UserDao"%>
<%@page import="com.cos.models.User"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="/blog/js/jquery-3.2.1.min.js"></script>
</head>
<body>
<%

	String path = application.getRealPath("media");
	
	MultipartRequest multi = new MultipartRequest(
		request,
		path,
		1024*1024*2,	// 2MB
		"UTF-8",
		new DefaultFileRenamePolicy() //동일한 파일명이 들어오면 파일명 뒤에 숫자를 붙임.
	);
	String username = multi.getParameter("username");
	System.out.println("uploadAction : username : "+username);
	String filename = multi.getFilesystemName("userProfile");	//정책에 의해서 변경된 이름
	String originFilename = multi.getOriginalFileName("userProfile");
	String contextPath = getServletContext().getContextPath();
	
	String filepath = "media/"+filename;
	
	User user = new User();
	user.setUserProfile(filepath);
	user.setUsername(username);
	System.out.println("filepath : " + filepath);
	
	
	
%>

<img src="<%=filepath %>" width="300px" height="300px"/>

<%
UserDao dao = new UserDao();

int result = dao.updateProfile(user);

if(result == 1){
	System.out.println("good");
}else {
	System.out.println("not good");
}


System.out.println("uploadAction : 세션 등록");
session = request.getSession();

//User 객체 가져오기
user = dao.findByUsername(username);
session.setAttribute("user", user);
System.out.println("loginAction : "+session.toString());

%>

<a class="blog_btn" href="/blog/board?cmd=list&page=1">홈으로</a>
</body>
</html>