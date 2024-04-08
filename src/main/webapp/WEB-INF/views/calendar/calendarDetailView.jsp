<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>스케줄 일정보기</title>

 <c:url var ="cldel" value="cldelete.do">
		<c:param name="clnum" value="${ calendar.calendarNo }"/>
</c:url>

 <c:url var ="clup" value="clupview.do">
		<c:param name="clnum" value="${ calendar.calendarNo }"/>
 </c:url>
<script type="text/javascript">
function requestDelete(){
	    //스케줄 삭제 요청 함수
	    if(confirm("삭제하시겠습니까?")) {
	        location.href = "${cldel}";
	    }
	}
	
	function moveUpdatePage(){
	    //스케줄 수정 페이지로 이동 처리 함수
	    location.href = "${clup}";
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
	<h1 align="center">일정보기</h1>

	<table align="center" width="500" border="1" cellspacing="0" cellpadding="5">
	
		
		<tr> 
			<th>날짜</th>
			<td>${ calendar.calendarDate }</td>
		</tr>
		<tr><!-- 숫자는 num -->
			<th>시작시간</th>
			<td>${ calendar.calendarStart }</td>
		</tr>
		<tr>
			<th>종료시간</th>
			<td>${ calendar.calendarEnd } </td>
		</tr>
		<tr>
			<th>제 목</th>
			<td>${ calendar.calendarTitle }</td>
		</tr>
		<tr>
		<tr>
			<th>내 용</th>
			<td>${ calendar.calendarContent }</td>
		</tr>
	
		<tr>
			<th>공개여부</th>
			<td>${ calendar.calendarCheck }</td>
		</tr>
	
		<tr>
			<th colspan="2">
				<input type="submit" value="수정" onclick="moveUpdatePage();"> &nbsp; 
				<input type="reset" value="삭제" onclick="requestDelete(); return false;"> &nbsp;
				<input type="button" value="달력" 
				onclick="javascript:location.href='calendar.do'; return false;">
			</th>		
		</tr>
	</table>
	
  </div>

  <div id="footer">
    <c:import url="/WEB-INF/views/common/teamfooter.jsp" />
  </div>

</div>	
	
</body>
</html>	