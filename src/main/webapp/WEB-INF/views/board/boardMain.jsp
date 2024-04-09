<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:set var="nowpage" value="1" />
<c:if test="${ !empty requestScope.currentPage }">
	<c:set var="nowpage" value="${ requestScope.currentPage }" />
</c:if>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Main List</title>
<style type="text/css">

#writeBtn:hover {
	background-color: #45a049; /* 호버 시 배경색 변경 */
}
</style>

<script type="text/javascript"
	src="/getdrive/resources/js/jquery-3.7.0.min.js"></script>
<script type="text/javascript">
	$(function() {
		//input 태그의 name 이 item 의 값이 바뀌면(change) 작동되는 이벤트 핸들러 작성
		$('input[name=item]').on('change', function() {
			//여러 개의 태그 중에서 체크표시가 된 태그를 선택
			$('input[name=item]').each(function(index) {
				//선택된 radio 순번대로 하나씩 checked 인지 확인!
				if ($(this).is(':checked')) {
					//체크 표시된 아이템에 대한 폼이 보여지게 처리함
					$('form.sform').eq(index).css('display', 'block');
				} else {
					//체크 표시 안된 아이템의 폼은 안보이게 처리한다.
					$('form.sform').eq(index).css('display', 'none');
				}
			}); //each
		}); //on
	}); //document ready

	function moveWritePage() {

		location.href = "bwrite.do";
	}
</script>
</head>
<body>

	<div id="container">

		<div id="jb-header">
			<c:import url="/WEB-INF/views/common/teamtop.jsp" />
		</div>

		<div id="sidebar">
			<c:import url="/WEB-INF/views/common/teamleft.jsp" />
		</div>

		<div id="content">
		
			<div width="100%">

				<h2 class="board-title" align="center">게시글 목록</h2>

				<!-- 항목별 검색 기능 추가 -->
				<fieldset id="ss">
					<legend>검색할 항목을 선택하세요.</legend>
					<input type="radio" name="item" id="title"> 제 목 &nbsp; 
					<input type="radio" name="item" id="writer"> 작 성 자 &nbsp; 
					<input type="radio" name="item" id="date"> 등록날짜 &nbsp;
				</fieldset>
				<br>

				<!-- 제목 검색  -->
				<form id="titleform" class="sform" action="bsearchTitle.do"	method="post">
					<input type="hidden" name="action" value="title">
					<fieldset>
						<legend>제목으로 검색</legend>
						<input type="search" name="keyword"> &nbsp; 
						<select	name="limit">
							<option value="5" selected>5</option>
						</select> &nbsp; 
						<input type="submit" value="검색">
					</fieldset>
				</form>

				<!-- 작성자 검색 -->
				<form id="wirterform" class="sform" action="bsearchWriter.do" method="post">
					<input type="hidden" name="action" value="writer">
					<fieldset>
						<legend>작성자로 검색</legend>
						<input type="search" name="keyword"> &nbsp; 
						<select	name="limit">
							<option value="5" selected>5</option>
						</select> &nbsp; 
						<input type="submit" value="검색">
					</fieldset>
				</form>

				<!-- 등록날짜 검색 -->
				<form id="dateform" class="sform" action="bsearchDate.do"
					method="post">
					<input type="hidden" name="action" value="date">
					<fieldset>
						<legend>검색할 등록 날짜를 선택하시오.</legend>
						<input type="date" name="begin"> ~ <input type="date" name="end"> &nbsp; 
							<select name="limit">
							<option value="5" selected>5</option>
							</select> &nbsp; 
						<input type="submit" value="검색">
					</fieldset>
				</form>
			</div>

			<!-- 여기까지 게시글 목록 타이틀 -->

			<!-- 목록 밑에 게시글 리스트 정렬 파트 -->
			<div align="center">
				<table id="board_list" class="table-bodered" width="100%">
				<tbody>
				<tr><th style="width: 30px">번호</th>
					<th>제목</th>
					<th style="width: 100px">작성자</th>
					<th style="width: 60px">생성날짜</th>
					<th style="width: 150px">첨부파일</th>
				</tr>
				
				<!--  forEach 문으로 DB 리스트 불러오기 -->
				<c:forEach items="${ list }" var="b">
					<tr><td>${ b.bNo}</td>
					<c:url var="bdetail" value="bdetail.do">
						<c:param name="bNo" value="${ b.bNo }" />
						<c:param name="page" value="${ nowpage }" />
					</c:url>	
					<td align="center"><a href="${ bdetail }">${ b.bTitle  }</a></td>
					<td align="center">${ b.bName }</td>
					<td align="center">${ b.bcDate }</td>
					<td align="center">
						<c:if test="${ !empty b.bOriginFileName }">	▣ </c:if> 
						<c:if test="${ empty b.bOriginFileName }">&nbsp;</c:if>
					</td></tr>
				</c:forEach>
						
				</tbody>
				</table>
				<br>
				<button class="btn"	onclick="javascript:location.href='bwrite.do?tNo=${ tNo }';">글쓰기</button>

			</div>

			<c:import url="/WEB-INF/views/common/pagingView.jsp" />


		</div>

		<div id="footer">
			<c:import url="/WEB-INF/views/common/teamfooter.jsp" />
		</div>

	</div>


</body>
</html>