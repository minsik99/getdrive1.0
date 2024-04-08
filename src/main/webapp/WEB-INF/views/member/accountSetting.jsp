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
#accountSettingZone{
	width :	27%;
	margin : auto;
	top : 50px;
	margin-bottom: 0px;
}

#profile{
	width : 90%;
	height: 170px;
	padding : 0px 30px;
	border: 1px solid #ddd;
	background-color: white;
	
}

#profileImage{
	width: 10%;
	float: left;
	margin: 2px;
	
}
#profileImage{
	width: 100px;
}
#profileInfo{
	margin: 4%;
	width: 65%;
	float: right;
}
summary{
	list-style: none
}

#profile_name{
	font-size : 20px;
	font-weight: 600;
	color : #444444;
}
#profile_email{
	font-size : 15px;
	font-weight: 600;
	color : #999999;
}
.settingZone{
	width : 90%;
	padding : 30px;
	border: 1px solid #ddd;
	background-color: white;
	cursor: pointer;
}
.settingZone:not(:last-child) {
    border-bottom: 1px solid #ddd; /* 마지막 항목을 제외한 모든 항목에 가로 선 추가 */
}

.settingTitle{
	font-size : 20px;
	font-weight: 600;
	color : #444444;
}
.settingZone:hover {
            background-color: #F6F6F6;
        }
        
.subzone{
	margin : 20px;
	transition: max-height 0.2s ease-out;
}
#accuntQuitTitle{
	color : #EF5350;
}
.subtitle{
	font-size : 15px;
	font-weight: 600;
	color : #444444;
}
.inputText {
	width: 95%;
	height : 40px;
	border: 1px solid #ddd;
	border-radius: 5px;
	background-color: #fff;
	box-sizing: border-box;
	margin: 15px 0px;
	font-weight: 600;
	padding-left: 10px;
}

.inp_text {
	font-weight: 600;
}

.inp_text input {
	display: block;
	font-size: 20px;
	font-family: sans-serif;
	font-weight: 600;
	color: #444444;
	outline: 0;
	-webkit-appearance: none;
	background-color: transparent;
	cursor: pointer;
	padding-left: 15px;
}

.inp_text input::placeholder {
	color: #999999;
	font-weight: 600;
}

.terms {
	font-size: 13px;
	font-weight: 600;
}

#pointer{
	float: right;
	width:20px;
}
#pointer:active{
	opacity : 0.5;
}

#comment {
	font-size: 9pt;
	margin: 0px;
}
.commonButton {
	background: #6DBFF2;
	border-radius: 5px;
	border: none;
	color: white;
	cursor: pointer;
	width: 120px;
	height: 45px;
	text-align: center;
	font-size: 12pt;
	font-weight: 600;
	float: right;
	position: relative;
	right:20px;
}

.commonButton:active {
	color: white;
	background: rgb(200, 230, 255);
	border:none;
}
.commonButton:disabled {
	color: #696969;
	background: #DCDCDC;
	cursor: default;
	border: none;
}

#teamQuitButton{
	background: #EF5350;
	position: relative;
	right:40px;
}

#teamQuitButton:active{
	background: #EF9A9A;
}

#accountDeleteButton{
	background: #EF5350;
	position: relative;
	left: 2px;
}

#accountDeleteButton:active{
	background: #EF9A9A;
}

.commentzone{
	width: 95%;
	border: 1px solid #ddd;
	border-radius: 5px;
	background-color: #fff;
	box-sizing: border-box;
	margin: 15px 0px;
	font-size : 15px;
	font-weight: 600;
	color : #444444;
	padding :10px;
}
.accountDeletCheck{
	list-style: none;
	font-size:14px;
	font-weight: 600;
}

input.chkAll{
    font-size: 1em;
    width: 1.25em; 
    height: 1.25em; 
    accent-color: rgb(0, 146, 255);
    float: right;
    position: relative;
    right: 14px;
    bottom: 20px;
}
input.chkAll + label{
    font-size: 1.125em;
    vertical-align: middle;
    accent-color: rgb(0, 146, 255);
}
</style>
<!-- 다른 페이지가 펼쳐지면 나머지는 접히게 하는 스크립트 -->
<script>
  function collapse(summaryElement) {
    const detailsElements = document.querySelectorAll('details');
    detailsElements.forEach(detailsElement => {
      if (detailsElement.querySelector('summary') !== summaryElement) {
        detailsElement.removeAttribute('open');
      }
    });
  }
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

function pwdCheck() {
    $.ajax({
        url: "pwdchk2.do",
        type: "post",
        data: { nowpwd: $('#nowPwd').val() },
        success: function(data) {
            console.log("success : " + data);
            if (data == "ok") {
                $('#fail').hide();
                $('#nowPwd').focus();
            } else {
                $('#fail').show();
                $('#nowPwd').select();
            }
            checkForm();
        },
        error: function(jqXHR, textStatus, errorThrown) {
            console.log("error : " + jqXHR + ", " + textStatus + ", " + errorThrown);
        }
    });
}
</script>
</head>
<body id="full" onload="collapse()">
<div id="accountSettingZone">
	<div id="profile">
		<h3>프로필</h3>
		<div id="profileImage">
			<img id="profileImage" alt="profileImage"src="/getdrive/resources/images/profileImage.png">
		</div>
		<div id="profileInfo">
			<span id="profile_name">${ sessionScope.loginMember.name }</span><br>
			<span id="profile_email">${ sessionScope.loginMember.email }</span>
		</div>
	</div>
	<div id="passwordSetting" class="settingZone">
	<form action="pwdchk2.do">
		<details>
		<summary id="passwordSettingTitle" class="settingTitle"  onclick="collapse(this)">비밀번호 변경하기<img alt="pointer" id="pointer" src="/getdrive/resources/images/pointer.png"></summary>
			<div markdown="1" class="subzone">
				<label class="subtitle">현재 비밀번호</label><br>
				<input type="Password" class="inputText" id="nowPwd" name="nowPwd" placeholder="현재 비밀번호 입력" required><br>
				<div class="terms" id="fail">현재 비밀번호와 일치하지 않습니다.</div>
				<label class="subtitle">새 비밀번호</label><br>
				<p id="comment">비밀번호는 8~20자 영문, 숫자, 특수문자로 입력하세요</p>
				<input type="Password" class="inputText" name="pwd" id="userPwd" placeholder="새 비밀번호 입력" ><br>
				<label class="subtitle">새 비밀번호 확인</label><br>
             	<input type="Password" class="inputText" id="userPwd2" placeholder="새 비밀번호 확인"><br>
             			<div class="terms" id="terms" style="display: none;color: red" >비밀번호 입력 조건과 일치하지 않습니다</div>
               			<div class="terms" id="mismatch" style="display: none; color: red">비밀번호가 일치하지 않습니다</div>
               			<div class="terms" id="match" style="display: none; color: #6DBFF2">비밀번호가 일치합니다.</div>
             	<button id="passwordSettingButton" class="commonButton" type="submit">비밀번호 변경</button>
             	<br>
			</div>
		</details>
	</form>
	</div>
	<div id="teamQuit" class="settingZone">
	<form action="teamQuit.do">
		<details>
		<summary id="teamQuitTitle" class="settingTitle"  onclick="collapse(this)">팀 탈퇴<img alt="pointer" id="pointer" src="/getdrive/resources/images/pointer.png"></summary>
			<div markdown="1" class="subzone"> 
				<div class="commentzone"> 
					<li>이 팀을 탈퇴하면 더 이상 이 팀에 남겨진 메시지 또는 파일에 접근할 수 없습니다.</li><br>
					<li>또한 현재 팀 멤버들은 사용자님이 남긴 메시지 또는 파일에 계속해서 접근할 수 있습니다.</li><br>
					<li>정말로 팀 탈퇴를 원하시면 아래의 "팀 탈퇴하기" 버튼을 눌러주세요.</li>
				</div>   
			</div>
			<button id="teamQuitButton" class="commonButton" type="submit">팀 탈퇴하기</button>
			<br><br>
		</details>
	</form>
	</div>
	<div id="accountDelete" class="settingZone">
	<form action="accountDelete.do">
		<details>
		<summary id="accuntQuitTitle" class="settingTitle"  onclick="collapse(this)">계정삭제<img alt="pointer" id="pointer" src="/getdrive/resources/images/pointer.png"></summary>
			<div markdown="1" class="subzone">     
			<label class="subtitle">현재 비밀번호</label><br>
				<input type="Password" class="inputText" id="nowPwd" name="nowPwd" placeholder="현재 비밀번호 입력" required><br>
				<div class="commentzone">
					<li>Classgetdrive 계정을 삭제하면 참여 중인 모든 팀에서 탈퇴됩니다.</li><br>
					<li>Classgetdrive 내에서 작성한 메시지와 파일은 자동 삭제되지 않으며, 팀 멤버들은 사용자님의 메시지와 파일에 계속해서 접근할 수 있습니다.</li><br>
					<li>Classgetdrive에 재가입해도 이전의 팀 리스트, 메시지, 파일은 복구되지 않습니다.</li>
				</div>
				<li class="accountDeletCheck">위 유의사항을 모두 확인하였으며 계정 삭제에 동의합니다.</li>
					<li class="accountDeletCheck">
						<input type="checkbox" name="chkAll" id="chk" class="chkAll" >
						<label for="chk"></label>
					</li>
					<br>
				<button id="accountDeleteButton" class="commonButton" type="submit">계정 삭제하기</button>
				<br>
			</div>
		</details>
	</form>
	</div>
</div>
</body>
</html>