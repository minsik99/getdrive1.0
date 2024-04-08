<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" errorPage="../common/error.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title></title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.7.0.js"></script>
<style type="text/css">
#full{
	width: 100%;
	height: 100%;
	background-color: #E1F5FE;
}
#passwordFindZone{
	width :	500px;
	margin : auto;
	position: relative;
	top : 200px;
	margin-bottom: 0px;
	padding : 30px;
	border: 1px solid #ddd;
	background-color: white;
	border-radius: 5px;
	font-weight: 600;
}
.inputText {
	width: 360px;
	height: 40px;
	border: 1px solid #ddd;
	border-radius: 5px;
	background-color: #fff;
	box-sizing: border-box;
	margin: 10px 0px;
	font-weight: 600;
}
.button {
	background: #6DBFF2;
	border-radius: 5px;
	color: white;
	cursor: pointer;
	padding-bottom: 4px;
	border: none;
	width: 120px;
	height: 40px;
	text-align: center;
	font-weight: 600;
	font-size: 12pt;
	margin-left: 5px;
}
.button:hover {
	color: white;
	background: rgb(200, 230, 255);
}

.button:disabled {
	color: #696969;
	background: #DCDCDC;
	cursor: default;
}
#comment {
	font-size: 9pt;
	margin: 0px;
	font-weight: 0;
}
</style>
<script type="text/javascript">
function emailCheck(){
	$.ajax({
		url: "idchk.do",
		type: "post",
		data: { email: $('.inputEmail').val() },
		success: function(data){
			console.log("success : " + data);
			if(data == "ok"){
				$('.fail').hide();
				$('.inputEmail').focus();
			}else{
				$('.fail').show();
				$('.inputEmail').select();
			}
			checkForm();
		},
		error: function(jqXHR, textStatus, errorThrown){
			console.log("error : " + jqXHR + ", " + textStatus + ", " + errorThrown);
		}
	});
}
</script>
<script type="text/javascript">
$(document).ready(function() {
    // 이메일 인증하기 버튼에 클릭 이벤트 리스너 추가
    $("#sendCall").on("click", function(event) {
        // 기본 동작 중지
        event.preventDefault();
    });
});
</script>
<script type="text/javascript">
//회원가입 버튼 활성화/비활성화 함수
function checkForm() {
  var passwordValid = checkPassword(); // 비밀번호 조건 체크 결과

  // 이메일 중복 확인 결과와 비밀번호 조건 체크 결과가 모두 true이면 버튼 활성화
  if (passwordValid) { // 비밀번호 조건을 만족하는 경우
      $("#passwordSettingButton").prop("disabled", false); // 버튼 활성화
  } else { // 비밀번호 조건을 만족하지 않는 경우
      $("#passwordSettingButton").prop("disabled", true); // 버튼 비활성화
  }
}

function checkPassword() {
    var password = $("#userPwd").val();
    var confirmPassword = $("#userPwd2").val();

    var empty = password.trim() === '';
    var length = password.length >= 8 && password.length <= 20;
    var alphabet = /[a-zA-Z]/.test(password);
    var digit = /\d/.test(password);
    var special = /[!@#$%^&*]/.test(password);
    var match = password === confirmPassword;

    // 각 조건을 검사하고 메시지를 표시
    $(".empty").toggle(empty);
    $("#terms").toggle(!empty && (!length || !alphabet || !digit || !special));
    $("#mismatch").toggle(!empty && !match && !$("#terms").is(":visible")); 
    $("#match").toggle(match && !empty && !$("#terms").is(":visible") && !$("#mismatch").is(":visible"));

    // 비밀번호가 조건을 모두 충족하는지 확인하여 회원가입 버튼 활성화/비활성화
    var passwordTerms = !empty && length && alphabet && digit && special && match;
  
    return passwordTerms;
}

// 문서 로드 후 실행되는 함수
$(function() {
    // 폼 체크 함수 호출하여 버튼 상태 설정
    checkForm();

    // 비밀번호 입력란에 입력이 발생할 때마다 폼 체크 함수 호출
    $("#userPwd, #userPwd2").on("input", function() {
        checkForm();
        checkPassword(); // 비밀번호 조건 확인
    });

    // 문서 로딩 시에도 비밀번호 조건 확인 및 버튼 상태 설정
    checkPassword();
    checkForm();
});
</script>
</head>
<body id="full">
	<form action="passwordFind.do" method ="post" id="passwordFindForm" >
		<div id="passwordFindZone">
			<div class="emailInput">
				<label for="userEmail" class="registerText">이메일</label><br>
						<form id="emailInput" action="passwordFind.do">
							<input type="email" id="email" class="inputText" name="email" placeholder="이메일 입력" required>
							<button id="sendCall" class="button">인증메일전송</button>
						<div class="fail" style="display: none; color: red">가입되지 않은 이메일입니다</div>
						</form>
						<form class="authorization">
							<input type="text" id="authorization" class="inputText" name="authorization" placeholder="인증번호 입력" required>
							<button id="sendCall" class="button" type="submit">인증번호확인</button>
						</form>
			</div>
				<label class="subtitle">새 비밀번호</label><br>
				<p id="comment">비밀번호는 8~20자 영문, 숫자, 특수문자로 입력하세요</p>
				<input type="Password" class="inputText" name="pwd" id="userPwd" placeholder="새 비밀번호 입력" ><br>
				<label class="subtitle">새 비밀번호 확인</label><br>
             	<input type="Password" class="inputText" id="userPwd2" placeholder="새 비밀번호 확인"><br>
             			<div class="terms" id="terms" style="display: none;color: red" >비밀번호 입력 조건과 일치하지 않습니다</div>
               			<div class="terms" id="mismatch" style="display: none; color: red">비밀번호가 일치하지 않습니다</div>
               			<div class="terms" id="match" style="display: none; color: #6DBFF2">비밀번호가 일치합니다.</div><br>
             	<button id="passwordSettingButton" class="button" type="submit">비밀번호 변경</button>
             	<br>
			</div>
	</form>
</body>
</html>