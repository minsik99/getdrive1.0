<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8" errorPage="error.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="KO">
<head>
<meta charset="UTF-8">
<title>main</title>
<script type="text/javascript" src="/getdrive/resources/js/jquery-3.7.0.min.js"></script>
<script type="text/javascript">
$(function(){
	
	// 팀 메인 > 상단 > 알림 갯수 - HomeController 
	$.ajax({
		url: "alarmCountList.do?",
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
				values = "<a href='#'><img src='/getdrive/resources/images/alarmon.png'></a>";
				values += "<div>";
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
	
});  //document ready	

</script>
	
<style type="text/css">

body {
  margin: 0;
  padding: 0;
}


#container {
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

#content {
  width: 800px;
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

#headerTable {
	width : 100% ;
	height : 50px;
	border : 10 px ;
	background : white ;
	
	border-collapse: collapse;
}

#logo {
	margin: 10px;
	width: 150px;
}

</style>

<c:if test="${empty loginMember}">
	<script type="text/javascript">
	window.location.replace('main.do');
	</script>
</c:if> 

<body>
	<%--2024.04.05 kimyh 세션확인용 삭제대상 --%>
	<div align="left">
		## 수신받는 정보 ## <br>
		<!--  로그인세션정보(loginMember) : ${ loginMember } --> 
		세션정보 (loginMember) : 
			번호(accountNo) ${ loginMember.accountNo } | 
			이메일(email) : ${ loginMember.email } |
			이름(name) : ${ loginMember.name } |
			가입일(cdate) : ${ loginMember.cdate } <br>
		팀코드(tNo) : ${ tNo }
	</div>	
		
<table id="headerTable">
<tr><th width=230 align=left>
	<a href="/getdrive/"><img id="logo" alt="getdrive"src="/getdrive/resources/images/logo.png"></a></th>
	<th width=300 >	
		<form id="searchForm" action="searchList.do" method="post">
			<input type="hidden" name="limit" value="10">	
			<input type="search" name="keyword" value="${ keyword }"> &nbsp;
			<input type="submit" value="검색">
		</form>
		</th>	
	<th align="right">
		<div id="alarmCount"></div>
		</th>
</tr>	
</table>

</body>

</html>
