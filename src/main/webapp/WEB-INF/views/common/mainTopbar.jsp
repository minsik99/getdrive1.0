<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" errorPage="error.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>getdrive 메인 상단 </title>

<style type="text/css">
#logo {
	margin: 10px;
	width: 150px;
}

#logospace {
	width: 50%;
	float: left;
	height:80px;	
}

#Temporaryspace {
	width: 50%;
	float: right;
	height:80px;	
	text-align: right;
}
</style>

</head>
<body>
	<%--2024.04.05 kimyh 세션확인용 삭제대상 --%>
	<div align="left">
		파일명 : view > common > mainTopbar.jsp <br>
		세션 : ${ loginMember } <br>
		고유번호 : ${ loginMember.getAccountNo() } | 아이디 : ${ loginMember.getName() }, 이름 : ${ loginMember.getEmail() }, 가입일 : ${ loginMember.getCdate() }
	</div>	
	
	<div id="logospace">	
	
		<%-- 2024.04.06 kimyh : 로그인 여부와 상관없이 초기화면으로 이동 처리 --%>
		<a href="${ pageContext.servletContext.contextPath }/main.do">
		<img id="logo" alt="getdrive"src="/getdrive/resources/images/logo.png">
		</a>		
		
	</div>
	
	<%--2024.04.05 kimyh 로그아웃 처리 삭제대상 --%>	
	<div id="Temporaryspace">
		
		<!-- 2024.04.05 kimyh : 로그인된 상태시 노출 -->
		<c:if test="${!empty loginMember}">
			[ <a href="logout.do"> 로그아웃 </a> ]	
		</c:if> 

		
	</div>	
		
</body>
</html>