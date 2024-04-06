<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="error.jsp" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<titie>스케줄 등록</titie>
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

<h1 align="center">스케줄 등록</h1>

<form action="clinsert.do" method="post">
<input type="text" name="calendarCRUid" value = 1<%-- ${ loginMember.accountNo } --%>>
<input type="text" name="calendarTid" value = 1 <%-- ${ teamcode } --%>>
<input type="text" name="year"   id ="year">
<input type="text" name="month"  id="month">
<input type="text" name="day"  id="day">

<table align="center" width="500" border="1" cellspacing="0" cellpadding="5">

	<tr style= "height: 20PX"> 
		<th style="background-color: #3498DB;">날짜</th>
		<td style="background-color: #3498DB;">
		<input type="date" name="calendarDate" id="calendarDate"></td>
	</tr>
	<tr><!-- 숫자는 num -->
		<th style="background-color: #3498DB;">시작시간</th>
		<td style="background-color: #3498DB;">
			<input type="number" name="calendarStart" ></td>
	</tr>
	<tr>
		<th style="background-color: #3498DB;">종료시간</th>
		<td style="background-color: #3498DB;">
			<input type="number" name="calendarEnd" ></td>
	</tr>
	<tr>
		<th style="background-color: #3498DB;">제 목</th>
		<td style="background-color: #3498DB;">
			<input type="text" name="calendarTitle" size="50"></td>
	</tr>
	<tr>
	<tr>
		<th style="background-color: #3498DB;">내 용</th>
		<td><textarea name="calendarContent" rows="3" cols="50"></textarea></td>
	</tr>
	
	<tr>
		<th  colspan="2">
			<input type="radio" name="calendarCheck" value="Y" checked>공개 &nbsp; 
			<input type="radio" name="calendarCheck" value="N">비공개</th></tr>

	
	<tr>
		<td colspan="2">
			<input type="submit" value="등록"> &nbsp; 
			<input type="reset" value="취소"> &nbsp;
			<input type="button" value="달력" 
			onclick="javascript:location.href='calendar.do'; return false;">
	</td>		
	</tr>
</table>
</form>	
</body>
</html>	