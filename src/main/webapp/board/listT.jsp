<%@page import="board.BoardPage"%>
<%@page import="board.BoardDTO"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./commons/header.jsp" %>
<%
	BoardDAO dao = new BoardDAO(application);

	Map<String, Object> param = new HashMap<String, Object>();
	
	int totalCount = dao.selectCount(param);
	System.out.println("totalCount : " + totalCount);
	
	int pagingTotalCnt = (int)(Math.ceil((double)totalCount / 10));
	System.out.println("listTotalCnt  : " + pagingTotalCnt ); 
	int start = 1;
	int end = pagingTotalCnt;
	int listVolum = 10;
	int pagingVolum = 5;
	
	String pageTemp = request.getParameter("pageNum");
	int pageNum = 1;
	if(pageTemp == null ) pageNum = 1;
	if(pageTemp != null ) pageNum = Integer.parseInt(pageTemp);
	
	int crtListFirst = ((pageNum - 1) * listVolum) + 1;
	int crtListLast = crtListFirst + listVolum - 1;
	
	System.out.println("crtListFirst  : " + crtListFirst ); 
	System.out.println("crtListLast  : " + crtListLast ); 
	
	param.put("crtListFirst", crtListFirst);
	param.put("crtListLast", crtListLast);
	
	List<BoardDTO> boardLists = dao.selectList(param);
	
	dao.close();
%>
<body>
<div class="container">
    <!-- Top영역 -->
    <%@ include file="./commons/top.jsp" %>
    <!-- Body영역 -->
    <div class="row">
        <!-- Left메뉴영역 -->
        <%@ include file="./commons/left.jsp" %>
        <!-- Contents영역 -->
        <div class="col-9 pt-3">
            <h3>게시판 목록 - <small>자유게시판</small></h3>
            <!-- 검색 -->
            <div class="row">
                <form action="">
                    <div class="input-group ms-auto" style="width: 400px;">
                        <select name="" class="form-control">
                            <option value="">제목</option>
                            <option value="">내용</option>
                            <option value="">작성자</option>
                        </select>
                        <input type="text" class="form-control" placeholder="Search" style="width: 200px;">
                        <button class="btn btn-success" type="submit">
                            <i class="bi-search" style="font-size: 1rem; color: white;"></i>
                        </button>
                    </div>
                </form>
            </div>
            <!-- 게시판 리스트 -->
            <div class="row mt-3 mx-1">
                <table class="table table-bordered table-hover table-striped">
                <thead>
                    <tr class="text-center">
                        <th>번호</th>
                        <th>제목</th>
                        <th>작성자</th>
                        <th>작성일</th>
                        <th>조회수</th>
                    </tr>
                </thead>
                <tbody>
                <%
                if(boardLists.isEmpty()){
                %>
	                <tr>
						<td colspan="5" align="center">등록된 게시물이 없습니다.</td>
					</tr>	
				<%
                }else{
				%>	
					
				<%
					// 게시물이 있을때
					int virtualNum = 0; // 게시물의 출력번호
					int countNum = 0;
					for(BoardDTO dto : boardLists){
						virtualNum = totalCount-((pageNum-1) * listVolum)-(countNum++);
				%>
                    <tr class="text-center">
                        <td><%= virtualNum %></td>
                        <td 
                        class="text-start"><a href="viewT.jsp?num=<%= dto.getNum() %>"><%= dto.getTitle() %></a></td>
                        <td><%= dto.getId() %></td>
                        <td><%= dto.getPostdate() %></td>
                        <td><%= dto.getVisitcount() %></td>
                    </tr>
                <%
					}
                }
                %>
                </tbody>
                </table>
            </div>
            <!-- 각종버튼 -->
            <div class="row">
                <div class="col d-flex justify-content-end">
                    <button type="button" class="btn btn-primary" onclick="location.href='writeT.jsp';">글쓰기</button>
                    <button type="button" class="btn btn-warning">목록보기</button>
                </div>
            </div>
            <!-- 페이지 번호 -->
            <div class="row mt-3">
                <div class="col">
                    <ul class="pagination justify-content-center">
                        <%-- <li class='page-item'>
                        	<a class='page-link' href='<%= request.getRequestURI() + '?pageNum=' + start %>'>
                            	<i class='bi bi-skip-backward-fill'></i>
                            </a>
                        </li> --%>
                        
                        <%-- <li class="page-item"><a class="page-link" href="<%= request.getRequestURI() + "?pageNum=" + (pageNum-1) %>"><i class='bi bi-skip-start-fill'></i></a></li> --%>
                        
                        <%= BoardPage.pagingStr(totalCount, listVolum, pagingTotalCnt, pagingVolum, pageNum, request.getRequestURI()) %>
                        
                        <!-- <li class="page-item"><a class="page-link" href="#"><i class='bi bi-skip-end-fill'></i></a></li> -->
                        
                        <%-- <li class="page-item">
                        	<a class="page-link" href="<%= request.getRequestURI() + "?pageNum=" + pagingTotalCnt %>">
                            	<i class='bi bi-skip-forward-fill'></i>
                            </a>
                        </li> --%>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <!-- Copyright영역 -->
    <%@ include file="./commons/copyright.jsp" %>
</div>
</body>
</html>