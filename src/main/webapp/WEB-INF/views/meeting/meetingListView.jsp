<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="currentLimit" value="${ requestScope.limit }" />
<c:set var="nowpage" value="1" />
<c:if test="${ !empty requestScope.currentPage }">
    <c:set var="nowpage" value="${ requestScope.currentPage }" />
</c:if>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회의록</title>

<style type="text/css">
 fieldset#ss {
    /*  width: 98%; */
     /* position: absolute; */
     /* top: 14%; */
     /* left: 50%; */
     /* transform: translate(-50%, -50%); */
     text-align: center; /* 가운데 정렬 */
 }

 form fieldset {
     /* width: 600px; */
     margin: auto; /* 가운데 정렬 */
 }

 form.sform {
     background: #6DBFF2;
     width: 650px;
     margin: auto; /* 가운데 정렬 */
     display: none; /* 안 보이게 함 */
 }

/* 2024.04.07 kimyh : 팀공통 상단영역과 충돌하여 수정함  */
 #mettingList {
     width: 100%;
     margin: auto; /* 가운데 정렬 */
     border-collapse: collapse;
 }

 #mettingList th, #mettingList td {
     border: 1px solid #dddddd;
     text-align: center;
     padding: 8px;
 }

 #mettingList th {
     background-color: #f2f2f2;
 }

 #mettingList tr:nth-child(even) {
     background-color: #f2f2f2;
 }

 a {
     text-decoration: none;
     color: #0000EE;
 }

 a:hover {
     color: #ff4500;
 }

 img {
     vertical-align: middle;
 }
</style>

<script type="text/javascript" src="/getdrive/resources/js/jquery-3.7.0.min.js"></script>
<script type="text/javascript">
 //클릭 표시
 $(function () {
     //input 태그의 name 이 item 의 값이 바뀌면(change) 작동되는 이벤트 핸들러 작성
     $('input[name=item]').on('change', function () {
         //여러 개의 태그 중에서 체크표시가 된 태그를 선택
         $('input[name=item]').each(function (index) {
             //선택된 radio 순번대로 하나씩 checked 인지 확인함
             if ($(this).is(':checked')) {
                 //체크 표시된 아이템에 대한 폼이 보여지게 처리함
                 $('form.sform').eq(index).css('display', 'block');
             } else {
                 //체크 표시 안된 아이템의 폼은 안 보이게 처리함
                 $('form.sform').eq(index).css('display', 'none');
             }
         });  //each
     });  //on
 });  //document ready

 function changeLimit(limit) {
     //alert(limit);
     location.href = "${ pageContext.servletContext.contextPath }/mlist.do?page=1&limit=" + limit;
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
	
	<h1 align="center">회의록</h1>
	<br>
	<center>
		<button onclick="javascript:location.href='${ pageContext.servletContext.contextPath }/mlist.do?page=1';">목록</button>
		&nbsp; &nbsp;
		<button onclick="javascript:location.href='${ pageContext.servletContext.contextPath }/movewrite.do';">회의록 등록</button>
	</center>
	<br>
	
	<fieldset id="ss">
	    <legend>검색할 항목을 선택하세요.</legend>
	    <input type="radio" name="item" id="title"> 제목 &nbsp;
	    <input type="radio" name="item" id="content2"> 내용 &nbsp;
	    <input type="radio" name="item" id="date"> 등록날짜 &nbsp;
	    <b>출력할 목록 갯수를 선택하세요 : </b>
	    <select id="limit" onchange="changeLimit(this.value);">
	        <c:if test="${ currentLimit eq 10 }">
	            <option value="10" selected>10개씩 출력</option>
	        </c:if>
	        <c:if test="${ currentLimit ne 10 }">
	            <option value="10">10개씩 출력</option>
	        </c:if>
	        <c:if test="${ currentLimit eq 15 }">
	            <option value="15" selected>15개씩 출력</option>
	        </c:if>
	        <c:if test="${ currentLimit ne 15 }">
	            <option value="15">15개씩 출력</option>
	        </c:if>
	        <c:if test="${ currentLimit eq 20 }">
	            <option value="20" selected>20개씩 출력</option>
	        </c:if>
	        <c:if test="${ currentLimit ne 20 }">
	            <option value="20">20개씩 출력</option>
	        </c:if>
	    </select>
	</fieldset>
	<br>
	
	<!-- 검색 항목별 값 입력 전송용 폼 만들기 -->
	<!-- 제목 검색 폼 -->
	<form id="titleform" class="sform" action="msearchTitle.do" method="get">
	    <input type="hidden" name="action" value="title">
	    <input type="hidden" name="limit" value="${ currentLimit }">
	    <fieldset>
	        <legend>검색할 제목을 입력하세요.</legend>
	        <input type="search" name="keyword" size="50"> &nbsp;
	        <input type="submit" value="검색">
	    </fieldset>
	</form>
	
	<!-- 내용 검색 폼 -->
	<form id="contentform" class="sform" action="msearchContent.do" method="get">
	    <input type="hidden" name="action" value="content">
	    <input type="hidden" name="limit" value="${ currentLimit }">
	    <fieldset>
	        <legend>검색할 내용을 입력하세요.</legend>
	        <input type="search" name="keyword" size="50"> &nbsp;
	        <input type="submit" value="검색">
	    </fieldset>
	</form>
	
	<!-- 등록날짜 검색 폼 -->
	<form id="dateform" class="sform" action="msearchDate.do" method="get">
	    <input type="hidden" name="action" value="date">
	    <input type="hidden" name="limit" value="${ currentLimit }">
	    <fieldset>
	        <legend>검색할 등록날짜를 선택하세요.</legend>
	        <input type="date" name="begin"> ~ <input type="date" name="end"> &nbsp;
	        <input type="submit" value="검색">
	    </fieldset>
	</form>
	
	<!-- 조회된 회의록 목록 출력 -->
	<table id=mettingList>
	    <tr>
	        <th>번호</th>
	        <th>회의제목</th>
	        <th>작성자</th>
	        <th>중요여부</th>
	        <th>첨부파일</th>
	        <th>조회수</th>
	        <th>등록날짜</th>
	    </tr>
	
	    <!-- 회의글 출력 -->
	    <c:forEach items="${ requestScope.list }" var="m">
	        <tr>
	            <!-- 번호 -->
	            <td>${ m.meetingId }</td>
	
	            <!-- 회의제목 -->
	            <td>
	                <a href="${ pageContext.servletContext.contextPath }/mdetail.do?no=${ m.meetingId }">
	                    ${ m.meetingTitle }
	                </a>
	            </td>
	
	            <!-- 작성자 -->
	            <td>${ m.meetingWriter }</td>
	
	            <!-- 중요여부 -->
	            <td>
	                <c:if test="${ m.importance eq 'Y'}">
	                    <img src="${ pageContext.servletContext.contextPath }/resources/images/importance.png" width="15" height="15">
	                </c:if>
	                <c:if test="${ m.importance eq 'N' }">-</c:if>
	            </td>
	
	            <!-- 첨부파일 여부 -->
	            <td>
	                <c:if test="${ !empty m.meetingOriginalFileName }">◎</c:if>
	                <c:if test="${ empty m.meetingRenameFileName }">-</c:if>
	            </td>
	
	            <!-- 조회수 -->
	            <td>${ m.readCount }</td>
	
	            <!-- 등록날짜 -->
	            <td>
	                <fmt:formatDate value="${ m.meetingDate }" pattern="yyyy-MM-dd" />
	            </td>
	        </tr>
	    </c:forEach>
	</table>
	<br>

  </div>

  <div id="footer">
    <c:import url="/WEB-INF/views/common/teamfooter.jsp" />
  </div>

</div>

</body>
</html>
