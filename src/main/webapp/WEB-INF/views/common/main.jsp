<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" errorPage="error.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title></title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.7.0.js"></script>
<style type="text/css">
#full {
	width: 100%;
	height: 100%;
}

#header {
	width: 100%;
	height: 100px;
}

<!-- 2024.04.05 kimyh : 로그인된 상태시 팀 목록으로 이동 처리 -->
<c:if test="${!empty loginMember}">
	<script type="text/javascript">
		alert("로그인 상태입니다. 팀 목록으로 이동합니다. ");
		window.location.replace('tmain.do');
	</script>
</c:if> 
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
		<div id="footer">
			<c:import url="/WEB-INF/views/common/footer.jsp"></c:import>
		</div>
	</div>
</body>
</html>