<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8" errorPage="error.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="KO">
<head>
<meta charset="UTF-8">
<title>teammain</title>
<script type="text/javascript" src="/getdrive/resources/js/jquery-3.7.0.min.js"></script>
<script type="text/javascript">
$(function(){	
 
	/*
	// 팀 메인 > 상단 > 알림 갯수 - HomeController 
	$.ajax({
		url: "alarmCountList.do?tno=${ tNo }&mNo=${ loginMember.accountNo }",
		type: "post",
		dataType: "json",
		success: function(data){
			// 확인
			console.log("알람 success : " + data.list.length);
			
			// object --> string
			var str = JSON.stringify(data);
			
			// string --> json
			var json = JSON.parse(str);
			
			// 확인
			console.log("json : " + str);
			
			var num = 1;			
			
			if (data.list.length > 0) {			
				values = "<img id='openDivImg' src='/getdrive/resources/images/alarmon.png' style='cursor:pointer;'>";
				values += "<div class='myDiv' style='display:none;border:1px solid;'>";
				for(var i in json.list){		
				
					values += "<li><a href='#"+ json.list[i].sno
					+"'>"
					+ decodeURIComponent(json.list[i].stitle).replace(/\+/gi, " ") 
					+ "</a></li>";					
				}
				values += "</div>";
			} else {
				values = "<img src='/getdrive/resources/images/alarmoff.png'>";
			}
			
			$('#alarmCount').html(values);
		}, 
		error: function(jqXHR, textStatus, errorThrown){
			console.log("error : " + jqXHR + ", " + textStatus + ", " + errorThrown);
		}
		
	});  //ajax

	*/	
	
	$(document).ready(function(){
		$("#openDivImg").click(function(){
		  	alert("확인");
			$("#myDiv").slideToggle(); // slideToggle을 사용하여 열기/닫기 효과
		});
	});
	

	
});  //document ready	

</script>
	
	
<style type="text/css">

#teamMainBody {
	margin: 0;
	padding: 0;
	border: 0px solid blue;		
}

#container {
	border: 1px solid red;	
	width: 1100px;
	margin: 0px auto;
	padding: 20px;
}

#teamCalContainer {
	border: 1px solid red;	
	width: 1100px;
	margin: 0px auto;
	padding: 20px;
}

#header {
  padding: 20px;
  margin-bottom: 20px;
  border: 1px solid #bcbcbc;
}

#sidebar {
  width: 200px;
  padding: 20px;
  margin-bottom: 20px;
  float: left;
  border: 1px solid #bcbcbc;
}

/* 본문영역 - 공통 */
#content {
  width: 800px;
  padding: 20px;
  margin-bottom: 20px;
  float: right;
  border: 1px solid #bcbcbc;
}

/* 본문영역 - 캘린더 */
#teamCalContent {
  width: 850px;
  padding: 20px;
  margin-bottom: 20px;
  float: right;
  border: 1px solid #bcbcbc;
}


#footer {
  clear: both;
  padding: 20px;
  border: 1px solid #bcbcbc;
}

/* 헤더영역 */
#teamheaderTable {
  	border: 0px solid red;	
	width : 100% ;
	height : 50px;
	border : 10 px ;
	background : white ;	
	border-collapse: collapse;
}

#teamheaderTable td, #teamheaderTable th {
  border: 0px solid black; 	/* 테이블 데이터와 헤더에 검은색 선 적용 */
  padding: 0px; 			/* 내용과 선 사이의 여백 설정 */
  background : white ;
  height:80px;
}

/* 헤더영역 - 로고이미지 */
#logo {
	border:0px solid red;
	width: 190px;
	position: relative;
	left: 20px;
}

/* 헤더영역 - 알람영역, 팀원아이콘 */
#teamMyTable {
	border:0px solid red;
	width:100px;
}

/* 헤더영역 - 알람영역 */
#teamAlarmCount{
	border: 0px solid red;	
	width : 50px ;
	margin-top: 8px;
}

/* 헤더영역 - 팀원아이콘 */
.clickDown-content{
	display : none;
	position : absolute;
	z-index : 1;
	font-weight: 400;
	background-color: #9BD1F2;
	min-width : 200px;
	border-radius: 90px 500px 25px 25px / 0px 0px 25px 25px;
}

/* 팀원 아이콘 영역  */
.dropdown{
	border:0px solid red;
	cursor: pointer;
	float: right;
	text-align: center;
	right:30px;
}

.dropbtn{ 
	border:0px solid;
  	background-color: #FFFFFF;
  	border-radius: 25px 500px 0px 0px / 25px 25px 25px 0px;
  	color: #6DBFF2;
  	font-weight: 400;
  	padding : 12px;
	/*   width :200px; */
  	cursor : pointer;
  	font-size : 18px;
  	font-weight: 600;
}

.dropdown-content{
  margin-left: -150px;
  display : none;
  position : absolute;
  z-index : 1;
  font-weight: 400;
  background-color: #9BD1F2;
  min-width : 200px;
  border-radius: 90px 500px 25px 25px / 0px 0px 25px 25px;
}

.dropdown-content>#a1{
  display : block;
  text-decoration : none;
  color : white;
  font-size : 18px;
  padding : 0px 10px 10px 10px;
}

.dropdown-content>#a2{
  display : block;
  text-decoration : none;
  color : white;
  font-size : 18px;
  padding : 0px 10px 12px 10px;
  border-radius: 90px 500px 25px 25px / 0px 0px 25px 25px;
}

.dropdown-content a:hover{
  background-color : #C9E2F2;
}

.dropdown:hover .dropdown-content {
  display: block;
}

.dropdown-content {
    display: none;
    opacity: 0; /* 초기에는 투명하게 설정 */
    transition: opacity 0.3s ease; /* opacity 변화에 대한 transition 효과 추가 */
}

.dropdown:hover .dropdown-content {
    display: block;
    opacity: 1; /* 드롭다운 메뉴가 활성화될 때 투명도를 조절하여 부드럽게 보이도록 함 */
}

#user{
	width: 25px;
	position: relative;
	top: 5px;
}

#setting{
	width: 30px;
	position: relative;
	top: 8px;
}

#logout{
	width: 28px;
	position: relative;
	top: 7px;
}

#searchForm input {
    width: 200px;
    height: 30px;
    border: 1px solid #6DBFF2;
}

</style>

<script type="text/javascript">
/* 2024.04.09 kimyh 계정영역  */
function moveAccountSetting(){
	location.href = "accountSettingPage.do";
}
function logout(){
	location.href = "logout.do";
}
</script>

<c:if test="${empty loginMember}">
	<script type="text/javascript">
	window.location.replace('main.do');
	</script>
</c:if> 

<body id="teamMainBody">
	<%--2024.04.05 kimyh 세션확인용 삭제대상 --%>
<%-- 
	<div align="left">
		## 수신받는 정보 ## <br>
		<!--  로그인세션정보(loginMember) : ${ loginMember } --> 
		세션정보 (loginMember) : 
			번호(accountNo) ${ loginMember.accountNo } | 
			이메일(email) : ${ loginMember.email } |
			이름(name) : ${ loginMember.name } <br>
		팀코드(tNo) : ${ tNo }
	</div>	
 --%>
	 
<table id="teamheaderTable">
<tr><td width=260 align=left>
	<a href="/getdrive/"><img id="logo" alt="getdrive"src="/getdrive/resources/images/logo.png"></a></td>
	<td>	
		<form id="searchForm" action="searchList.do" method="post">
			<input type="hidden" name="limit" value="10">
			<input type="hidden" name="tNo" value="${ tNo }">	
			<input type="search" name="keyword" value="${ keyword }"> &nbsp;
			<input type="submit" style="width:100px;" value="통합검색">
		</form>
		</td>	
	<td width=100 align="right">
		
		<table id="teamMyTable">
		<tr valign=middle>
			<Td align="right">
				<!-- 알람 -->
				<div id="teamAlarmCount"></div>
			</Td>
			<td align="right" width="10">
				
				<!-- 내계정관리/로그아웃 -->
				<c:if test="${ !empty sessionScope.loginMember }">
					<div class="dropdown">
				      <button class="dropbtn"><img id="user" alt="user" src="/getdrive/resources/images/user.png">
				        <span class="dropbtn_icon"></span>
				      </button>
				      
				      <div class="dropdown-content">
				        <a id="a1" onclick="moveAccountSetting();"><img id="setting" alt="setting" src="/getdrive/resources/images/setting.png">계정설정</a>
				        <a id="a2" onclick="logout(); kakaoLogout();"><img id="logout" alt="logout" src="/getdrive/resources/images/logout.png">로그아웃</a>
				      </div>
				    </div>				    
			    </c:if>  
			     
	    	</td>
	    </tr>
	    </table>
	</td>
</tr>	
</table>

</body>

</html>
