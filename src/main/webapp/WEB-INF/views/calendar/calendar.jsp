<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="error.jsp" %>

<%@ page import = "java.util.*"  %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
		int action = 0; //up(1) down(0)
		int year = 0;
		int month = 0;  // 0 ~ 11
	
	// 년도, 월 중 하나라도 지정(넘겨져 오지)되지 않으면 오늘날짜 기준으로 월달력 출력
	if(request.getParameter("year") == null || request.getParameter("month") == null) {
		Calendar today = Calendar.getInstance();
		year = today.get(Calendar.YEAR);
		month = today.get(Calendar.MONTH);
	} else {
		// 출력하고자 하는 달력의 년도와 월
		year = Integer.parseInt(request.getParameter("year")); // 2022..
		month = Integer.parseInt(request.getParameter("month")); // 0 ~ 11
		
		// 이전달 클릭 year, month-1 / 다음달 클릭 year, month+1
		// -1 -> 11,year--  12 -> 0,year++
		if(month == -1) {
			month = 11;
			year = year-1;
		}
		if(month == 12) {
			month = 0;
			year = year+1;
		}
	}	
		
	// 출력하고자 달의 1일 객체 + 1일 요일 + 마지막 날짜
	Calendar firstDate = Calendar.getInstance();
	firstDate.set(Calendar.YEAR, year);
	firstDate.set(Calendar.MONTH, month);
	firstDate.set(Calendar.DATE, 1);
	int firstDay = firstDate.get(Calendar.DAY_OF_WEEK); // 1일의 요일 정보(1일,2월,....,7토)
	int lastDate = firstDate.getActualMaximum(Calendar.DATE);
	
	// 출력 알고리즘(td의 개수 구하기)
	int startMoveCnt = firstDay - 1;
	int endMoveCnt = 0;
	if((startMoveCnt+lastDate)%7 != 0) {
		endMoveCnt = 7 - (startMoveCnt+lastDate) % 7;
	}
	int tdCnt = startMoveCnt + lastDate + endMoveCnt;
	
%>
<!DOCTYPE html>
<html>
		<meta charset="UTF-8">
		<title>달력</title>	
		
		   <style>
        .modal{
            position:absolute;
            display:none;
            
            justify-content: center;
            top:0;
            left:0;

            width:100%;
            height:100%;

            

            background-color: rgba(0,0,0,0.4);
        }
    </style>
		
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.7.0.min.js"></script>	

<script type="text/javascript">		

$(function(){
	
	//조회 출력 처리 테스트
	$.ajax({
		url: "cllist.do",
		type: "post",
		data: { year: <%=year%>, month: <%=month+1%>},
		dataType: "json",
		success: function(data){
			console.log("success : " + data);
			
			//object --> string
			var str = JSON.stringify(data);
			
			//string --> json
			var json = JSON.parse(str);
			
			values = "";			
			for(var i in json.list){
															//상세보기
				values = "&middot; <a href='cldetail.do?clnum=" + json.list[i].clnum 
						+ "''>" + decodeURIComponent(json.list[i].cltitle).replace(/\+/gi, " ") 
						+ "</a><br>";
	
				$('#clnum'+ json.list[i].clday).append(values)	;
				
				values = "";
				
			}
			
		},
		error: function(jqXHR, textStatus, errorThrown){
			console.log("error : " + jqXHR + ", " + textStatus + ", " + errorThrown);
		}
	});  //ajax	

});  //document ready		
	
</script>
		<style>
			 html, body{ 
			 	height:100%;
			 	margin:0px;
			 }
			 td{
			 	width:100px;
			 	height:100px;
			 }
			 th{
			 	height:100px;
			 	font-weight: normal;
			 }
		</style>	
				
		
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

		<!-- 달력 -->
		<div class="container mt-3">
			<div class="mt-3 mb-3 p-3 d-flex justify-content-between">
				<span> <a class="btn btn-outline-dark btn-sm"
					href="calendar.do?year=<%=year%>&month=<%=month-1%>">[이전달]</a>
				</span> <span class="fw-bold fs-3"><%=year%>년 <%=month+1%>월</span> <span>
					<a class="btn btn-outline-dark btn-sm"
					href="calendar.do?year=<%=year%>&month=<%=month+1%>"> [다음달] </a>
				</span>
			</div>
			
			<div>			
		  				
			    <button onclick="javascript:location.href='clinsertform.do?tNo=${tNo}';" 
			    class="btn-open-modal">등록</button>	
			    
				<table class="table text-left table-bordered">
					<tr class="table-light text-center fs-5 tr-h">
						<th class="text-danger">일</th>
						<th>월</th>
						<th>화</th>
						<th>수</th>
						<th>목</th>
						<th>금</th>
						<th class="text-primary">토</th>
					</tr>
					<tr>
						<% 
						for(int i=1; i<=tdCnt; i++) {
					%>
						<td onclick="#"> 
								<%
									if(i>startMoveCnt && i<=startMoveCnt+lastDate) {
										if(i%7 == 0) { //토요일 파란날 표시
								%>
											<span class="text-primary"><%=i-startMoveCnt%></span>
											<div id="clnum<%=i-startMoveCnt%>"   style="border: 1px solid white;"></div>
								<%			
										} else if(i%7 == 1) { //일요일 빨간날 표시
								%>
											<span class="text-danger"><%=i-startMoveCnt%></span>
											<div id="clnum<%=i-startMoveCnt%>"   style="border: 1px solid white;"></div>
								<%																
										}else { //평일 표시
								%>
											<%=i-startMoveCnt%>
											
											<div id="clnum<%=i-startMoveCnt%>"   style="border: 1px solid white;"></div>
	
								<%			
										}	
									} else {	//빈칸
								%>
										&nbsp;
								<%
									}
								%>		
							</td>
	
						<%	
							if(i!=tdCnt && i%7 == 0) {
					%>
					</tr>
					<tr>
						<%			
							}
						}
					%>
					</tr>	
				</table>
				
			</div>

		</div>
		<!-- 달력 -->	
  </div>

  <div id="footer">
    <c:import url="/WEB-INF/views/common/teamfooter.jsp" />
  </div>

</div>


</body>
</html>