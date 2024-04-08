<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WriteForm</title>
<script type="text/javascript" src="/getdrive/resources/js/jquery-3.7.0.min.js"></script>
<script type="text/javascript">
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
	  
	<h1 align="center">새 회의록 등록 페이지</h1>
	<br>
	<!-- form 에서 입력값들과 파일을 함께 전송하려면 반드시 속성을 추가해야 함 : enctype="multipart/form-data" -->
	<form action="minsert.do" method="post" enctype="multipart/form-data" onsubmit="return validateForm();">
	<table align="center" width="500" border="1" cellspacing="0">
	<tr><th>제 목</th><td><input type="text" name="meetingTitle" size="50"></td></tr>
	<tr><th>작성자</th>
		<td><input type="text" name="meetingWriter" readonly 
			value="${ loginMember.name }"></td></tr>
	<tr><th>중요도</th>
		<td><input type="checkbox" name="importance" value="Y"> 중요</td>
	</tr>
	<!-- data type 오류 -->
	<!-- 
	<tr><th>중요도 지정 종료 날짜</th>
		<td><input type="date" id="impEndDate" name="impEndDate"></td>
	</tr>	 
	-->		
	<tr><th>첨부파일</th><td><input type="file" name="ofile"></td></tr>
	<tr><th>내 용</th>
		<td><textarea rows="5" cols="50" name="meetingContent"></textarea></td></tr>
	<tr><th colspan="2">
		<input type="submit" value="등록하기"> &nbsp; 
		<input type="reset" value="작성취소"> &nbsp;
		<input type="button" value="목록" 
			onclick="javascript:history.go(-1); return false;">
	</th></tr>
	</table>
	</form>

  </div>

  <div id="footer">
    <c:import url="/WEB-INF/views/common/teamfooter.jsp" />
  </div>

</div>

</body>
</html>