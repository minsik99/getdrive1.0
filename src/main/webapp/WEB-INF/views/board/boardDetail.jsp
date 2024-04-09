<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>detail</title>

<!-- 삭제 처리  -->
<c:url var="bdel" value="bdelete.do">
	<c:param name="bNo" value="${ board.bNo }" />
</c:url>

<style type="text/css">


/* 전체 페이지 스타일 */
body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
    background-color: #f8f9fa;
}

h1 {
    text-align: center;
    margin-top: 20px;
}

.board-container {
    margin: 20px auto;
    width: 80%;
}

.board-con-01 {
    padding: 20px;
    border: 1px solid #ced4da;
    border-radius: 10px;
    background-color: #fff;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.board-title {
    margin: 0;
    color: #343a40;
}

.board-body {
    margin-top: 10px;
    padding: 10px;
    border-top: 1px solid #ced4da;
}

.board-footer {
    margin-top: 20px;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

/* 버튼 스타일 */
.btn {
    padding: 10px 20px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.3s;
    font-size: 16px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
}

.btn-primary {
    background-color: #007bff;
    color: #fff;
}

.btn-danger {
    background-color: #dc3545;
    color: #fff;
}

.btn:hover {
    background-color: #0056b3;
}

.img-circle {
    border-radius: 50%;
    margin-right: 10px;
    width: 30px;
}

.username {
    margin-left: 10px;
}




</style>
<script type="text/javascript" src="/getdrive/resources/js/jquery-3.7.0.min.js"></script>
<script type="text/javascript">	

function moveListPage(){
	location.href="bmain.do";
}

//href 이나 a 태그 방식은 무조건 GET 방식이다.
function moveUpdatePage(){
	location.href="bupdate.do";
}

function deletePage(){
	//게시글 원글 삭제 요청 함수
	location.href = "${ bdel }"
}

</script>
</head>
<body>

<h1 align="center"> ${ board.bNo } 번 게시글 상세보기</h1>

<section class="board-container">

<div class="board-con-01">
	
	<div class="board-box_primary">
		
		<div class="board-header with-border">			
			<h3 class="board-title">글제목: ${ board.bTitle }</h3>
		</div>
		
		<div class="board-body" style="height: 400px">
			내용: ${ board.bContent }
		</div>
		
		<!-- 첨부파일 구간 -->
		<div class="board-footer">
			<th width="120"> 첨부파일 </th>
				<c:if test="${ !empty board.bOriginFileName }">
					<c:url var="bdown" value="bdown.do">
						<c:param name="ofile" value="${ board.bOriginFileName }"/>
						<c:param name="rfile" value="${ board.bRenameFileName }"/>
					</c:url>
					<a href="${ bdown }">${ board.bOriginFileName }</a>
				</c:if>
				<c:if test="${ empty board.bOriginFileName }">
				&nbsp;
				</c:if>
				
					<div class="user-block">
						<img class="img-circle" src="/getdrive/resources/images/user.png"  alt="user image">
						<span class="username">
							<a href="#"> ${ board.bName }</a>
						</span>
						<span class="description"><fmt:formatDate pattern="yyyy-MM-dd a HH:mm" value="${ board.bcDate }" />
					</div>
			
		</div>
		
		<div class="board-footer">
			<button  class="btn" onclick="moveListPage();">목록</button>
			<div class="pull-right">
			<!-- 수정 버튼 form 으로 감싸주고 input 태그에 hidden 속성 넣어서 update로 넘겨주니 에러 사라짐 -->
				<form action="bupdate.do">
					<input type="hidden" name="bNo" value="${ board.bNo }">
					<input type="submit" value="수정">
				</form>
				<button class="btn" onclick="deletePage(); return false;"> 삭제 </button>
			</div>
		</div>
	
		</div>
		
	</div>
	
</section>

</body>
</html>
