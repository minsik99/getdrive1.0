<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" errorPage="error.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>getdrive 초기화면</title>
<script type="text/javascript" src="/getdrive/resources/js/jquery-3.7.0.min.js"></script>
<link href="/getdrive/resources/main.css" rel="stylesheet" type="text/css" />
</head>

<body>

	<div id="full">
	
		<div id="header">
			<c:import url="/WEB-INF/views/common/mainTopbar.jsp"></c:import>
		</div>
		
		<div id="main">
			<div id="left">
				<c:import url="/WEB-INF/views/common/mainMenu.jsp"></c:import>
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
		
		<div id="footer">
			<c:import url="/WEB-INF/views/common/mainFooter.jsp"></c:import>
		</div>
	
	</div>

</body>
</html>