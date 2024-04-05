<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>chatCreateInfo</title>
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
<body>
<h2>채팅 정보 설정</h2>
<a href="template.do?uno=1&e_mail=ddd123@naver.com">팀메인 이동 </a>
${ loginMember },  ${ emailMember }
<hr>

<%-- 채팅 정보 설정 --%>
	<form action="${pageContext.request.contextPath}/chat/chatMain" method="post">
        <label for="name">채팅 이름</label>
        <br>
        <input type="text" id="chatname" name="chatname" required>
        <br>
        <label for="description">채팅 설명</label>
        <br>
        <textarea id="description" name="description" required></textarea>
        <br>
        
        <button type="submit">*정보 제출 버튼(아래 확인 버튼으로 변경해야함)</button>
    </form>
<br>

<nav>
	<ul id="button">
		<li><a href="${ pageContext.servletContext.contextPath }/.do">취소</a></li>
		<li><a href="${ pageContext.servletContext.contextPath }/chatmain.do">확인</a></li>
	</ul>
</nav>
</body>
</html>