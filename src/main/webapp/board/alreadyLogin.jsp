<%@page import="utils.JSFunction"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	if(session.getAttribute("userId") == null){
		JSFunction.alertLocation("로그인 후 이용해주세요.", "../member/Login.jsp", out);
		
		return;
	}
%>