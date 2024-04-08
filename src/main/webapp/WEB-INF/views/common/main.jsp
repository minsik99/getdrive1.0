<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" errorPage="error.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>getdrive 초기화면</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.7.0.js"></script>

<!-- 2024.04.05 kimyh : 공통 css 처리 -->
<link rel="stylesheet" href="/getdrive/resources/css/common.css">

<style type="text/css">
#full {
	width: 100%;
	height: 100%;
}

#header {
	width: 100%;
	height: 100px;
}
</style>
</head>

<body>
<div id="full">
	<div id="header">
		<c:import url="/WEB-INF/views/common/mainTopbar.jsp"></c:import>
	</div>
	<hr>
	
	<div id="main">
		<div id="left">
			<c:import url="/WEB-INF/views/common/commonMenu.jsp"></c:import>
		</div>
		<div id="right">
			<c:if test="${ empty sessionScope.loginMember }">
				<c:import url="/WEB-INF/views/member/login.jsp"></c:import>
			</c:if>
			<c:if test="${ !empty sessionScope.loginMember }">
				<c:import url="/WEB-INF/views/member/loginComplete.jsp"></c:import>
			</c:if>
		</div>
	</div>
	<hr>
	
	<div id="footer">
		<c:import url="/WEB-INF/views/common/footer.jsp"></c:import>
	</div>

</div>

</body>
</html>