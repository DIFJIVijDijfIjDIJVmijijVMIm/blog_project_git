<%@page import="java.io.PrintWriter"%>
<%@page import="com.cos.util.SHA256"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	//code 값 받기
	String code = request.getParameter("code");

	//return code 값이랑 send code 값을 비교해서 동일하면 정상
	boolean rightCode = SHA256.getEncrypt("smtlsska@naver.com", "cos").equals(code) ? true : false;
	
	PrintWriter script = response.getWriter();
	if(rightCode == true){
		//DB에 칼럼 emailCheck(number) 1 = 인증, 0 = 미인증     1을 update 해준다.
		script.println("<script>");
		script.println("alert('이메일 인증에 성공하였습니다.')");
		script.println("location.href='logintest.jsp'");
		script.println("</script>");
	} else{
		//DB에 칼럼 emailCheck(number) 1 = 인증, 0 = 미인증     1을 update 해준다.
		script.println("<script>");
		script.println("alert('이메일 인증을 실패하였습니다.')");
		script.println("location.href='errortest.jsp'");
		script.println("</script>");
	}

	
	//인증완료 로그인 페이지 이동
	
	//미인증 error 페이지 이동

%>