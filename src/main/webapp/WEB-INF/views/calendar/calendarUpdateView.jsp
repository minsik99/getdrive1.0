<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang= "ko">
<head>
<meta charset="UTF-8">
<title>스케줄 수정페이지</title>
</head>

<script type="text/javascript" src="/getdrive/resources/js/jquery-3.7.0.min.js"></script>
<script type="text/javascript">
$(function() {
	
	//날짜 입력 필드에서 변경이 감지되면 실행됩니다
	$('#calendarDate').change(function() {
		  
			// 입력 필드의 값을 가져옵니다.
		    var input = $(this).val();
			
		    // 입력된 값을 Date 객체로 변환합니다.
		    var date = new Date(input);
		
		    // Date 객체에서 년, 월, 일을 추출합니다.
		    var year = date.getFullYear();
		    var month = date.getMonth() + 1; // getMonth()는 0부터 시작하므로 +1을 해줍니다.
		    var day = date.getDate();
		
		    // 추출한 년, 월, 일을 다른 입력 필드에 적용합니다.
		    $('#year').val(year);
		    $('#month').val(month);
		    $('#day').val(day);
	    
	});
});
</script>
<body>

<div id="container">

  <div id="jb-header">      
	<c:import url="/WEB-INF/views/common/teamtop.jsp" />        
  </div>
  
  <div id="sidebar">
	<c:import url="/WEB-INF/views/common/teamleft.jsp" />
  </div>
  
  <div id="content">
		
		<h1 align="center">수정</h1>
		
		<form action="clupdate.do" method="post">
		<input type="text" name="calendarNo" value="${ calendar.calendarNo }">
		<input type="text" name="year"  id ="year" value="${ calendar.year }" >
		<input type="text" name="month" id="month" value= "${ calendar.month }">
		<input type="text" name="day" id="day" value= "${ calendar.day }">
		
		
		<table align="center" width="500" border="1" cellspacing="0" cellpadding="5">
		
			<tr> 
				<th>날짜</th>
				<td>
				<input type="date" name="calendarDate" id="calendarDate" value="${ calendar.calendarDate }"></td>
			</tr>
			
			<tr><!-- 숫자는 num -->
				<th>시작시간</th>
				<td>
				<input type="number" name="calendarStart" value="${ calendar.calendarStart }"></td>
			</tr>
			
			<tr>
				<th>종료시간</th>
				<td>
				 <input type="number" name="calendarEnd" value="${ calendar.calendarEnd }"> </td>
			</tr>
			
			<tr>
				<th>제 목</th>
				<td>
				 <input type="text" name="calendarTitle" size="50" value="${ calendar.calendarTitle }"></td>
			</tr>
			
			<tr>
				<th>내 용</th>
				<td>
				<textarea name="calendarContent" rows="3" cols="50">${ calendar.calendarContent }</textarea></td>
			</tr>
		
		<tr>
			<th colspan="2">
				<input type="radio" name="calendarCheck" value="Y" checked>공개 &nbsp; 
				<input type="radio" name="calendarCheck" value="N">비공개</th></tr>
		
			<tr>
				<th colspan="2">
					<input type="submit" value="수정하기"> &nbsp; 
					<input type="reset" value="수정취소"> &nbsp;
					<input type="button" value="이전페이지로 이동" 
					onclick="javascript:history.go(-1); return false;"> &nbsp;
					<input type="button" value="달력" 
					onclick="javascript:location.href='calendar.do';  return false;">
				</th>		
			</tr>
		</table>
		</form>	
		
		
  </div>

  <div id="footer">
    <c:import url="/WEB-INF/views/common/teamfooter.jsp" />
  </div>

</div>			
</body>
</html>	