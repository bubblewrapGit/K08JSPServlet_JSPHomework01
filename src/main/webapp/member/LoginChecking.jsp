<%@page import="login.LoginDTO"%>
<%@page import="login.LoginDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
String oracleDriver = application.getInitParameter("OracleDriver");
String oracleURL = application.getInitParameter("OracleURL");
String oracleId = application.getInitParameter("OracleId");
String oraclePwd = application.getInitParameter("OraclePwd");

LoginDAO dao = new LoginDAO(oracleDriver, oracleURL, oracleId, oraclePwd);


String userId = request.getParameter("id");
String userPw = request.getParameter("passwd");

LoginDTO dto = dao.getLoginDTO(userId, userPw);

dao.close();

if(dto.getId() != null){
	session.setAttribute("userId", dto.getId());
	session.setAttribute("userName", dto.getName());
	
	System.out.println("로그인에 성공하였습니다.");
	response.sendRedirect("../board/listT.jsp");
}else{
	request.setAttribute("LoginErrMsg", "아이디를 확인해주세요");
	request.getRequestDispatcher("Login.jsp").forward(request, response);
}
%>
