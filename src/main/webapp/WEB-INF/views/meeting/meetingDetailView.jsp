<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>      
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>first</title>

<%-- 아래의 자바스크립트 함수에서 사용하는 url 요청 처리를 별도로 변수화 시킴 --%>
<!-- 수정페이지 이동 -->
<c:url var="mup" value="mmoveup.do">
	<c:param name="meetingId" value="${ meeting.meetingId }" />
</c:url>

<!-- 삭제 -->
<c:url var="mdel" value="mdelete.do">
	<c:param name="meetingId" value="${ meeting.meetingId }" />
	<c:param name="rfile" value="${ meeting.meetingRenameFileName }" />
</c:url>

<script type="text/javascript">
//게시글(원글, 댓글) 수정 페이지로 이동 처리 함수
function moveUpdatePage(){
	location.href = "${ mup }";
}

//게시글(원글, 댓글) 삭제 요청 함수
function requestDelete(){
	location.href = "${ mdel }";
}
</script>
</head>

<body>
<c:import url="/WEB-INF/views/common/top.jsp" />
<hr>
<h2 align="center">${ meeting.meetingId } 번 회의글 상세보기</h2>
<br>
<table align="center" width="500" border="1" cellspacing="0" 
 cellpadding="5">
<tr><th>제 목</th><td>${ meeting.meetingTitle }</td></tr>
<tr><th>작성자</th><td>${ meeting.meetingWriter }</td></tr>
<tr><th>등록날짜</th><td><fmt:formatDate value="${ meeting.meetingDate }" pattern="yyyy-MM-dd" /></td></tr>
<tr><th>중요도</th><td>${ meeting.importance }</td></tr>
<tr><th>첨부파일</th>
   <td>
   		<c:if test="${ !empty meeting.meetingOriginalFileName }">
   			<c:url var="nfd" value="mfdown.do">
   				<c:param name="ofile" value="${meeting.meetingOriginalFileName}" />
   				<c:param name="rfile" value="${meeting.meetingRenameFileName}" />
   			</c:url>
   			<a href="${ nfd }">${meeting.meetingOriginalFileName}</a>
   		</c:if>
   			<c:if test="${ empty meeting.meetingOriginalFileName }">&nbsp;	</c:if>
   </td>
</tr>
<tr><th>내 용</th>
<td>${ meeting.meetingContent }</td></tr>

<tr>
	<th colspan="2">
		<%-- 로그인한 경우 : 본인 글 상세보기 일때는 수정페이지로 이동과 삭제 버튼 표시함 --%>
		<c:if test="${ !empty loginMember }">
			<c:if test="${ loginMember.name eq meeting.meetingWriter }">
				<button onclick="moveUpdatePage(); return false;">수정페이지로 이동</button> &nbsp;
				<button onclick="requestDelete(); return false;">글삭제</button> &nbsp;
			</c:if>
		</c:if>
		     
		 <button onclick="javascript:history.go(-1);">목록</button> 
	</th>		
</tr>


</table>
<hr>
</body>
</html>