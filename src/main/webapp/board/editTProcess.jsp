<%@page import="utils.JSFunction"%>
<%@page import="board.BoardDTO"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String num = request.getParameter("num");
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	System.out.println("num : " + num);
	System.out.println("title : " + title);
	System.out.println("content : " + content);
	BoardDTO dto = new BoardDTO();
	
	dto.setNum(num);
	dto.setTitle(title);
	dto.setContent(content);
	
	BoardDAO dao = new BoardDAO(application);
	int result = dao.updateEdit(dto);
	dao.close();
	
	if(result == 1){
		// 수정 성공
		response.sendRedirect("viewT.jsp?num="+dto.getNum());
	}else{
		// 수정 실패
		JSFunction.alertBack("수정 실패하였습니다(editTProcess.jsp)", out);
	}
%>