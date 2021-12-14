<%@page import="board.BoardDTO"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./alreadyLogin.jsp" %>
    <%
    	String num = request.getParameter("num");	
    
    	BoardDAO dao = new BoardDAO(application);
    	
    	/* BoardDTO dto = dao. */
    %>
<%@ include file="./commons/header.jsp" %>
<script>
	function validateForm(form){
		if(form.title.value==""){
			alert("글 제목을 입력하세요")
			form.title.focus();
			return false;
		}else if(form.content.value==""){
			alert("글 내용을 입력하세요")
			form.content.focus();
			return false;	
		}else{
			
		}
	}
</script>
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
            <h3>게시판 수정 - <small>자유게시판</small></h3>
            <!-- 
	            form태그에 아래 인코딩안하겟다는 속성이 붙었을때는 값이 전송되지 않는 이슈 발생
	            	enctype="multipart/form-data" 
            -->
            <form action="EditProcess.jsp" method="post" name="writeFrm" onsubmit="return validateForm(this);">
                <table class="table table-bordered">
                <colgroup>
                    <col width="20%"/>
                    <col width="*"/>
                </colgroup>
                <tbody>
                    <tr>
                        <th class="text-center" 
                            style="vertical-align:middle;">작성자</th>
                        <td>
                            <input type="text" class="form-control" 
                                style="width:100px;" value="<%= session.getAttribute("userId") %>" disabled />
                        </td>
                    </tr>
                    <tr>
                        <th class="text-center" 
                            style="vertical-align:middle;">제목</th>
                        <td>
                            <input type="text" class="form-control" name="title" value=""/>
                        </td>
                    </tr>
                    <tr>
                        <th class="text-center" 
                            style="vertical-align:middle;">내용</th>
                        <td>
                            <textarea rows="5" class="form-control" name="content"></textarea>
                        </td>
                    </tr>
                </tbody>
                </table>

                <!-- 각종버튼 -->
                <div class="row mb-3">
                    <div class="col d-flex justify-content-end">
                        <button type="button" class="btn btn-warning" onclick="location.href='listT.jsp';">목록보기</button>
                        <button type="submit" class="btn btn-danger">완료하기</button>
                        <button type="reset" class="btn btn-dark">다시쓰기</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
    <!-- Copyright영역 -->
    <%@ include file="./commons/copyright.jsp" %>
</div>
</body>
</html>