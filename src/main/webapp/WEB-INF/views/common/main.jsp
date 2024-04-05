<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" errorPage="error.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title></title>
<style type="text/css">
#full {
	width: 100%;
	height: 100%;
}

#header {
	width: 100%;
	height: 20%;
}

#main {
	width: 100%;
	height: 650px;
}

#left {
	width: 50%;
	height: 650px;
	float: left;
}

#right {
	width: 49.9%;
	height: 650px;
	float: right;
	border-left: 1px solid #999999;
	text-align: center;
}

#footer {
	margin: 10px 0px 0px;
	width: 100%;
	height: 90px;
	text-align: center;
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
				<c:import url="/WEB-INF/views/member/login.jsp"></c:import>
			</div>
		</div>
		<div id="footer">
			<c:import url="/WEB-INF/views/common/footer.jsp"></c:import>
		</div>
	</div>
</body>
</html>