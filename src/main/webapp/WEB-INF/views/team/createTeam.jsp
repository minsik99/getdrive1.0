<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<style>
	
	body {
		font-size: 1.5rem;
	}
	
	center {
		margin-bottom: 3rem;
	}
	
	p {
		margin-top: 10rem;
	}
	
	input {
		border-radius: 5px;
		padding: 0.5rem;
		width: 12%;
	}

	#tmain {
		background-color: #6DBFF2;
		color: white;
		font-size: 1.5rem;
		border-radius: 5px;
		border: none;
		padding: 0.5rem 1rem;
		margin-top: 10rem;
	}
	
	#tmain:hover {
		cursor: pointer;
	}
	
</style>
<script type="text/javascript">
	
</script>
</head>
<body>
<c:import url="/WEB-INF/views/common/mainTopbar.jsp"></c:import>
<hr>
<center>
<h2>팀 생성</h2>
<form action="iteam.do" method="post">
	<p>새로운 팀 이름</p>
	<input name="tName" type="text" placeholder="새로운 팀명을 입력해주세요.">
	<br>
	<input type="submit" id="tmain" value="생성하기">
</form>
</center>
<hr>
</body>
</html>