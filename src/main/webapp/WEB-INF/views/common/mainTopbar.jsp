<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" errorPage="error.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title></title>
<style type="text/css">
#logo {
	margin: 10px;
	width: 150px;
}
#logospace {
	margin: 10px;
	width: 180px;
	cursor: pointer;
}
</style>
<script type="text/javascript">
function moveMainPage(){
	location.href = "mainPage.do";
}
</script>
</head>
<body>
	<div id="logospace">
		<a onclick="moveMainPage();">
		<img id="logo" alt="getdrive"src="/getdrive/resources/images/logo.png">
		</a>
	</div>
</body>
</html>