<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang= "ko">
<head>
<meta charset="UTF-8">
<title>스케줄 수정페이지</title>

 <c:url var ="clupcn" value="clupview.do">
		<c:param name="clnum" value="${ calendar.calendarNo }"/>
</c:url>

</head>

<style>

table{

  border-style: solid;

  border-color: #CECECE;
}

th{color: white;}

textarea{ border-color: #CECECE; }

input{

	border-style: solid;

  	border-color: #CECECE;
  	
  	font-color : white
}

</style>


<script type="text/javascript" src="/getdrive/resources/js/jquery-3.7.0.min.js"></script>
<script type="text/javascript">

function requestupdatecancel(){
    //스케줄 수정취소 요청 함수
    if(confirm("수정을 취소하시겠습니까?")) {
        location.href = "${clupcn}";
    }
}

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

<script>
  document.addEventListener('DOMContentLoaded', function () {
    var calendarStart = document.getElementsByName('calendarStart')[0];
    var calendarEnd = document.getElementsByName('calendarEnd')[0];

    calendarStart.addEventListener('blur', function() {
      if(this.value < 0 || this.value > 24) {
        alert('시작 시간은 0에서 24 사이의 숫자여야 합니다.');
        this.value = ''; //초기화
      }
    });

    calendarEnd.addEventListener('blur', function() {
      if(this.value < 0 || this.value > 24) {
        alert('종료 시간은 0에서 24 사이의 숫자여야 합니다.');
        this.value = ''; //초기화
      }
    });
  });
</script>
<body>
<h1 align="center">수정</h1>

<form action="clupdate.do" method="post">
<input type="hidden" name="calendarCRUid" value =${ loginMember.accountNo }>
<input type="hidden" name="calendarTid" value =${ tNo }>
<input type="hidden" name="calendarNo" value="${ calendar.calendarNo }">
<input type="hidden" name="year"  id ="year" value="${ calendar.year }" >
<input type="hidden" name="month" id="month" value= "${ calendar.month }">
<input type="hidden" name="day" id="day" value= "${ calendar.day }">



<table align="center" width="500" border="1" cellspacing="0" cellpadding="5">

	<tr> 
		<th style="background-color: #6DBFF2;">날짜</th>
		<td style="background-color: #6DBFF2;">
		<input type="date" name="calendarDate" id="calendarDate" value="${ calendar.calendarDate }">
		</td>
	</tr>
	
	<tr><!-- 숫자는 num -->
		<th style="background-color: #6DBFF2;">시작시간</th>
		<td style="background-color: #6DBFF2;">
		<input type="number" name="calendarStart" value="${ calendar.calendarStart }" min="0" max="24"></td>
	</tr>
	
	<tr>
		<th style="background-color: #6DBFF2;">종료시간</th>
		<td style="background-color: #6DBFF2;">
		 <input type="number" name="calendarEnd" value="${ calendar.calendarEnd }" min="0" max="24"> </td>
	</tr>
	
	<tr>
	<td colspan="2" align="center" style="background-color: #6DBFF2;" ><a href="javascript:void(0);" style="color: #000000;" onclick="openLayerWindow();">장소설정</a>
		<script>
		function openLayerWindow() {
		  window.open("${pageContext.servletContext.contextPath}/clmap.do", "지도창", "width=400, height=400, left=100, top=100");
		}
		</script></td>
	 </tr>
	
	<tr>
		<th style="background-color: #6DBFF2;">제 목</th>
		<td>
		 <input type="text" name="calendarTitle" size="50" value="${ calendar.calendarTitle }"></td>
	</tr>
	
	<tr>
		<th style="background-color: #6DBFF2;">작성자</th>
		<td>
			<input type="text" name="calendarCRUid" readonly 
			value="${ sessionScope.loginMember.name }">
		</td>
	</tr>
	
	<tr>
   	 <th style="background-color: #6DBFF2;">내 용</th>
   	 <td>
        <textarea name="calendarContent" style="width: 400px; height: 200px; resize: none;">${ calendar.calendarContent }</textarea>
   	 </td>
	</tr>

<tr>
	<th colspan="2" style="color: black;">
		<input type="radio" name="calendarCheck" value="Y" checked>공개 &nbsp; 
		<input type="radio" name="calendarCheck" value="N">비공개</th></tr>

	<tr>
		<th colspan="2">
			<input type="submit" value="수정하기" style="color: white; background-color: #6DBFF2"> &nbsp; 
			<input type="reset" value="수정취소" onclick="requestupdatecancel(); return false;" style="color: white; background-color: #6DBFF2"> &nbsp;
			<input type="button" value="이전페이지로 이동" 
			onclick="javascript:history.go(-1); return false;" style="color: white; background-color: #6DBFF2"> &nbsp;
			<input type="button" value="달력" 
			onclick="javascript:location.href='calendar.do';  return false;" style="color: white; background-color: #6DBFF2">
		</th>		
	</tr>
</table>
</form>	
</body>
</html>	