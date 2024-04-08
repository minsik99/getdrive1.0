<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" errorPage="error.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title></title>
<style type="text/css">
#footer-content{
	width : 100%;
 	text-align:center; 
 	height: 100px;
 	vertical-align: middle;
 	padding: 3px 0px;
 	
} 
p{
	font-size: 14px;
}
</style>
</head>
<body>
	<footer>
		<div id="footer-content">
			<p>SingleThread 주식회사 | 대표이사 : 빛나보자 | 사업자등록번호 : 123-45-678910 | 사업자 정보확인
				통신판매업 | 신고 : 2000-서울강남-0515 | 사업장주소 : 서울특별시 강남구 강남대로 1234번길 56, 10층)
				| 호스팅서비스사업자 : SingleThread | 대표번호 : 02-1234-5678 | 제품/서비스/멤버십:
				1588-1234 <br> 개별 판매자 판매 상품의 경우 SingleThread(주)는 통신판매중개업자로서
				통신판매의 당사자가 아니므로, 개별 판매자가 등록한 상품, 거래정보 및 거래 등에 대해 책임을 지지 않습니다. <br>

				소비자분쟁해결기준 본 사이트의 컨텐츠는 저작권법의 보호를 받는 바 무단 전재, 복사, 배포 등을 금합니다.<br>
				Copyright © 1995-2024 SingleThread. All Rights Reserved..

			<%--2024.04.05 kimyh 세션확인용 삭제대상 --%>				
			<div align="left" style="color:red;">
				## 수신받는 정보 ## <br>
				<!--  로그인세션정보(loginMember) : ${ loginMember } -->
				로그인세션정보 (loginMember) : 고유번호(accountNo) ${ loginMember.accountNo } |
				이메일(email) : ${ loginMember.email } | 이름(name) : ${ loginMember.name }
				| 가입일(cdate) : ${ loginMember.cdate }
			</div>
		</div>
	</footer>
</body>
</html>