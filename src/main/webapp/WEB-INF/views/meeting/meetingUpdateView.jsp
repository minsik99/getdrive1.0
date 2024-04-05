<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>first</title>
</head>
<body>
<c:import url="/WEB-INF/views/common/top.jsp" />
<hr>
<h1 align="center">
${ meeting.meetingId } 번 회의글 수정 페이지</h1>
<br>
<!-- form 에서 입력값들과 파일을 함께 전송하려면 반드시 속성을 추가해야 함 : enctype="multipart/form-data" -->
<form action="mupdate.do" method="post" enctype="multipart/form-data">

<input type="hidden" name="meetingId" value="${ meeting.meetingId }">	
<input type="hidden" name="meetingOriginalFileName" value="${meeting.meetingOriginalFileName }">
<input type="hidden" name="meetingRenameFileName" value="${meeting.meetingRenameFileName }">

<table align="center" width="500" border="1" cellspacing="0" cellpadding="5">
<tr><th>제 목</th>
<td><input type="text" name="meetingTitle" size="50" 
	value="${ meeting.meetingTitle }"></td></tr>
<tr><th>작성자</th>
	<td><input type="text" name="meetingWriter" readonly 
		value="${ sessionScope.loginMember.name }"></td></tr>
<tr><th>중요도</th>
	<td>
		<c:if test="${ !empty meeting.importance and meeting.importance eq 'Y' }">
			<input type="checkbox" name="importance" value="Y" checked> 중요
		</c:if>
		<c:if test="${ !empty meeting.importance and meeting.importance eq 'N' }">
			<input type="checkbox" name="importance" value="N"> 중요
		</c:if>
	</td>
</tr>

<!-- data type 오류 -->
<%-- <tr><th>중요도 지정 종료 날짜</th>
	<td><input type="date" name="impEndDate" value="${ notice.impEndDate }"></td>
</tr>	 --%>	

<tr>
	<th>첨부파일</th>
	<td>
   		<c:if test="${ !empty meeting.meetingOriginalFileName }">
			${ meeting.meetingOriginalFileName } &nbsp; 
			<input type="checkbox" name="deleteFlag" value="yes"> 
			파일삭제 <br>
			변경 : <input type="file" name="upfile">
		</c:if>
		<c:if test="${ empty meeting.meetingOriginalFileName }">
			첨부된 파일 없음 <br>
			추가 : <input type="file" name="upfile">	
		</c:if>		
		
	</td>
</tr>
<tr><th>내 용</th>
	<td><textarea rows="5" cols="50" name="meetingContent">${ meeting.meetingContent }</textarea></td></tr>
<tr><th colspan="2">
	<input type="submit" value="수정하기"> &nbsp; 
	<input type="reset" value="수정취소"> &nbsp;
	<input type="button" value="이전페이지로 이동" 
		onclick="javascript:history.go(-1); return false;"> &nbsp;
	<input type="button" value="목록" 
		onclick="javascript:location.href='mlist.do'; return false;">
</th></tr>
</table>
</form>
<br>
<hr>
</body>
</html>