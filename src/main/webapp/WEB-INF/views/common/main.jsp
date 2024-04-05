<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" errorPage="error.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>getdrive 초기화면</title>

<!-- 2024.04.05 kimyh : 공통 css 처리 -->
<link rel="stylesheet" href="/getdrive/resources/css/common.css">

<!-- 2024.04.05 kimyh : 로그인된 상태시 팀 목록으로 이동 처리 -->
<c:if test="${!empty loginMember}">
	<script type="text/javascript">
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
		<div id="right">
			<c:import url="/WEB-INF/views/member/login.jsp"></c:import>
		</div>
	</div>
	
	<div id="footer">
		<c:import url="/WEB-INF/views/common/login_footer.jsp"></c:import>
	</div>
	
</div>

</body>
</html>