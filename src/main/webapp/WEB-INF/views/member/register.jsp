<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" errorPage="../common/error.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title></title>
<script type="text/javascript" src="/first/resources/js/jquery-3.7.0.min.js"></script>
<style type="text/css">
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

#header {
	width: 100%;
	height: 20%;
	margin: 0px;
}

#main {
	width: 100%;
}

#registerForm {
	width: 460px;
	margin: 50px auto;
}

ul.register_box {
	border: 1px solid #ddd;
	background-color: #fff;
}

.inputInfo, .inputInfo>ul {
	position: relative;
}

.inputInfo>ul>li {
	float: left;
}

.inputInfo>ul>li:first-child {
	width: 80%;
	padding-left: 30px;
	font-weight: 600;
	color: #888;
}

ul>li {
	list-style: none
}

a {
	text-decoration: none;
}

span {
	font-size: 10pt;
	color: red;
}

#comment {
	font-size: 9pt;
	margin-left: 8px;
}

.inputText {
	width: 400px !important;
	border: 1px solid #ddd;
	border-radius: 5px;
	background-color: #fff;
	box-sizing: border-box;
	margin: 10px 0px;
}

.inp_text {
	position: relative;
	margin-top: 10px;
	box-sizing: border-box;
}

.inp_text label {
	margin-left: 8px;
}

.inp_text+.inp_text {
	border-top: 1px solid #ddd;
}

.inp_text input {
	display: block;
	height: 40px;
	font-size: 18px;
	font-family: sans-serif;
	font-weight: 600;
	color: #444444;
	outline: 0;
	-webkit-appearance: none;
	background-color: transparent;
	cursor: pointer;
	padding-left: 6px;
}

.inp_text input::placeholder {
	color: #999999;
}

.clearfix::after {
	content: "";
	display: block;
	clear: both;
	margin-bottom: 10px;
}

.registerComplete {
	margin-top: 15px;
	float: left;
}

.registerComplete>button {
	background: #6DBFF2;
	border-radius: 5px;
	color: white;
	cursor: pointer;
	padding-bottom: 4px;
	border: none;
	width: 460px;
	height: 40px;
	text-align: center;
	font-weight: 600;
	font-size: 12pt;
}

.registerComplete>button:active {
	color: white;
	background: rgb(200, 230, 255);
}

.registerComplete>button:disabled {
	color: #696969;
	background: #DCDCDC;
	cursor: default;
}

.email_div {
    display: inline-block;
    border: 1px solid #ddd;
    border-radius: 5px;
    font-size: 12pt;
    margin-top: 5px;
    width: 400px;
    
}

#email {
    background-color: transparent;
    width: 280px;
    border: 0;
    font-size: 15pt;
    float: left;
}

.btn {
    width: 100px;
    height: 30px;
    background: #6DBFF2;
	border-radius: 5px;
	color: white;
    padding: 3px;
    border: none;
    font-size: 9pt;
    vertical-align: top;
    float: right;
    margin-top: 5px;
    margin-right: 9px;
}
.btn:hover {
    cursor: pointer;
}

.btn:active {
	color: white;
	background: rgb(200, 230, 255);
}
#loginpagezone{
	text-align: center;
	font-family: sans-serif;
	font-weight: 600;
	cursor: pointer;
	color:#41AEF2;
}
</style>

<script type="text/javascript">
function moveMainPage(){
	location.href = "mainPage.do";
}
</script>
<script type="text/javascript">
$(function(){
	$("#userPwd").keyup(function(){
        $("#userpwd_msg").html("");
    });
    
    $("#userPwd2").keyup(function(){
        if($("#userPwd").val() != $("#userPwd2").val()){
            $("#userpwd_msg").html("비밀번호가 일치하지 않습니다");
            $("#userpwd_msg").css("color","red");
            return false;
        }else{
            $("#userpwd_msg").html("비밀번호가 일치합니다.");
            $("#userpwd_msg").css("color","#6DBFF2");
            return true;
        }
    });
    
	$(".btn").click(function() {
        var userEmail = $("#email").val();
        $.ajax({
            url: "checkEmail.do",
            type: "POST",
            data: { email: userEmail },
            success: function(response) {
                if(response === "true") {
                    $("#useremail_msg").html("사용 가능한 이메일입니다.");
                    $("#useremail_msg").css("color","#6DBFF2");
                } else {
                    $("#useremail_msg").html("이미 사용 중인 이메일입니다.");
                    $("#useremail_msg").css("color","red");
                }
            },
            error: function() {
                $("#useremail_msg").html("중복 확인 중 오류가 발생했습니다.");
                $("#useremail_msg").css("color","red");
            }
        });
    });
});
</script>
</head>
<body>
<form action="register.do" method ="post" id="registerForm" onsubmit="return validate();">
	<header>
		<div id="header">
			<c:import url="/WEB-INF/views/common/mainTopbar.jsp"></c:import>
		</div>
	</header>
	<div id="main">
		<ul class="register_box">
			<li class="inputInfo" >
				<ul class="clearfix">
					<li class="inp_text">
						<label for="userName" class="registerText">이름</label><br>
						<input type="text" class="inputText" name="name" placeholder="이름 입력" required>
						<p id="username_msg"></p>
					</li>
				</ul>
			</li>
			<li class="inputInfo">
				<ul class="clearfix">
					<li class="inp_text">
						<label for="userEmail" class="registerText">이메일</label><br>
						<div class="email_div">
							<input type="email" id="email" class="inputEmail" name="email" placeholder="이메일 입력" required>
							<button class="btn">중복확인</button>
						</div>
						<p id="useremail_msg"></p>
					</li>
				</ul>
			</li>
			<li class="inputInfo">
				<ul class="clearfix">
					<li class="inp_text">
						<label for="userEmail" class="registerText">비밀번호 입력
							<p id="comment">비밀번호는 8~20자 영문, 숫자로 입력하세요</p>
						</label>
						<input type="Password" class="inputText" name="pwd" id="userPwd" placeholder="비밀번호 입력" required>
						<input type="Password" class="inputText" id="userPwd2" placeholder="비밀번호 확인" required>
						<font id="userpwd_msg" size="2" color="red"></font>
					</li>
				</ul>
			</li>
			<li class="registerComplete">
				<button id="rgisterComplete_button" type="submit">회원가입 완료</button>
			</li>
		</ul>
	</div>
</form>
<br>
<div id="loginpagezone">
	<a onclick="moveMainPage();">이미가입하셨나요?</a>
</div>
</body>
</html>