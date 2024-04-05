<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>chatCreate</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script type="js/bootstrap.js"></script>

<style type="text/css">
nav > ul#button {
	list-style: none;
	position: relative;
	left: 100px;
}
nav > ul#button li {
	float: left;
	width: 120px;
	height: 30px;
	margin-right: 5px;
	padding: 0;
}
nav > ul#button li a {
	text-decoration: none;
	width: 120px;
	height: 30px;
	display: block;
	background: gray;
	color: black;
	text-align: center;
	font-weight: bold;
	margin: 0;
	text-shadow: 1px 1px 2px white;
	padding-top: 5px;
}
nav > ul#button li a:hover {
	text-decoration: none;
	width: 120px;
	height: 30px;
	dispaly: block;
	background: #41AEF2;
	/* color: white; */
	text-align: center;
	font-weight: bold;
	margin: 0;
	/* text-shadow: 1px 1px 2px white; */
	padding-top: 5px;
}
hr { clear: both; }
</style>
</head>

<%-- 멤버 검색 --%>
<%-- ****** 멤버 DB : ajax 배운 뒤 구현 필요******** --%>
<body>
<h2 align="left">채팅 시작하기</h2>
<label>이름 <input type="search" id="username" placeholder="멤버 검색"></label>
<button id="userlist">검색</button>
<p>
<div id="p4" style="width:400px;height:30px;border:1px ;">
	<table id="tblisttop" border="1" cellspacing="0">
		<tr bgcolor="white">
			<th>멤버번호</th>
			<th>이름</th>
		</tr>
	</table>
</div>

<div id="p4" style="width:400px;height:400px;border:1px solid gray;">
<table id="tblist" border="1" cellspacing="0">
<script type="text/javascript">
$(function(){
	$('#userlist').on('click', function(){
		$.ajax({
			url: 'userlist.do',
			type: 'post',
			data: { username: $('#username').val() },
			dataType: "json", 
			success: function(dataObj){
				//json 객체 한개를 받을 때는 바로 출력할 수 있음
				console.log('dataObj : ' + dataObj); //json data : [object Object]
				
				//S1) 파싱 : object => string
				var objStr = JSON.stringify(dataObj);
				//S2) 파싱 : string => parsing : json object
				var jsonObj = JSON.parse(objStr);
				
				var output;
				// var output = $('#tblist').html(); //데이터 쌓는 경우
				
				//json 객체 안의 list 를 하나씩 꺼내서 새로운 행으로 추가 처리				
				for(var i in jsonObj.list){
					output += "<tr><td>" + jsonObj.list[i].cu_no
							+ "</td><td>" + decodeURIComponent(jsonObj.list[i].cu_name).replace(/\+/gi, ' ') //한글 디코딩, 공백 변환
							+ "</td></tr>";
				}
				//테이블에 기록 처리
				$('#tblist').html(output);
			},
			error: function(request, status, errorData){ //실패시 수행할 동작
				console.log("error code : " + request.status
						+ "\nMessage : " + request.responseText
						+ "\nError : " + errorData);
			}
		});
	});  //on
});  //document.ready
</script>
</table>
</div>

<!-- 	<form id="username" class="sform" action="userlist.do" method="post">
	<div class="containner">
		<div class="form-group row pull-right">
	
			<div class="col-xs-8">
				<input name="username" class="form-control" type="text" size="20">
			</div>
			<div class="col-xs-2">
				<button class="btn btn-primary" type="button">검색</button>
			</div>
		</div>
	</div>
	</form>
	
	<table class="table" style="text-align: center; border: 1px solid #dddddd">
		<thead>
			<tr>
				<th style="background-color: #fafafa; text-align: center;">이름</th>
				<th style="background-color: #fafafa; text-align: center;">구분</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>김민식</td>
				<td>팀장</td>
			</tr>
			<tr>
				<td>홍은비</td>
				<td>팀원</td>
			</tr>
			<tr>
				<td>전상우</td>
				<td>팀원</td>
			</tr>
		</tbody>
	</table> -->
	
	
	
	
	<!-- <form id="searchForm">
 	<legend>이름</legend>
	<input type="text" name="searchInput" id="searchInput" placeholder="멤버 검색">
	<button type="submit">검색</button>
 	</form>

<h3>팀 멤버 리스트</h3>
<ul id="userList">
	<c:forEach var="user" items="${users}">
		<li>${user.username}</li>
    </c:forEach>
</ul>

 <script>
        $(document).ready(function() {
            $('#searchForm').submit(function(event) {
                event.preventDefault();
                var searchInput = $('#searchInput').val();

                $.ajax({
                    type: 'GET',
                    url: '/chat/searchUser', // Define your endpoint for searching users
                    data: {
                        searchInput: searchInput
                    },
                    success: function(data) {
                        // Clear previous search results
                        $('#userList').empty();

                        // Append new search results
                        $.each(data, function(index, user) {
                            $('#userList').append('<li>' + user.username + '</li>');
                        });
                    },
                    error: function(xhr, status, error) {
                        console.error('Error searching users:', error);
                    }
                });
            });
        });
    </script>
<br>
-->

<nav>
	<ul id="button">
		<li><a href="${ pageContext.servletContext.contextPath }/.do">취소</a></li>
		<li><a href="${ pageContext.servletContext.contextPath }/chatcreateinfo.do">대화 시작하기</a></li>
	</ul>
</nav>
	
</body>
</html>