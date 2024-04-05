<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<style>
	header {
		text-align: center;
	}
	
	section {
		display: flex;
	}
	
	aside {
		margin-top: 6rem;
		width: 10vw;
		text-align: center;
	}
	
	a {
		text-decoration: none;
		color: black;
	}
	
	#member_btn {
		width: 80%;
		background-color: #e6e6e6;
		margin: 0 auto;
		font-size: 1.5rem;
		height: 5rem;
		line-height: 5rem;
	}
	
	#member_btn:hover {
		cursor: pointer;
	} 
	
	#team_btn {
		width: 80%;
		background-color: #6DBFF2;
		color: white;
		margin: 0 auto;
		font-size: 1.5rem;
		height: 5rem;
		line-height: 5rem;
	}
	
	#team_btn:hover {
		cursor: pointer;
	}
	
	.wrapper {
		width: 90vw;
	}
	
	.content {
		width: 50%;
		margin: 0 auto;
	}
	
	input {
		width: 15rem;
	}
	
	button {
		padding: 0 0.2rem;
		color: white;
		background-color: #6DBFF2;
		border-radius: 5px;
		border: none;
		font-weight: bold;
	}
	
	button:hover {
		cursor: pointer;
	}
	
	#submitName {
		width: 3rem;
		color: white;
		background-color: #6DBFF2;
		border-radius: 5px;
		border: none;
		font-weight: bold;
		margin-left: 11rem;
	}
	
	#submitName:hover {
		cursor: pointer;
	}

	/* 모달창 */
	#modalContainer {
	  width: 100%;
	  height: 100%;
	  position: fixed;
	  top: 0;
	  left: 0;
	  display: flex;
	  justify-content: center;
	  align-items: center;
	  background: rgba(0, 0, 0, 0.5);
	}
	
	#modalContent {
	  position: absolute;
	  background-color: #ffffff;
	  width: 300px;
	  height: 150px;
	  padding: 15px;
	}
	
	#modalContainer.hidden {
	  display: none;
	}
	
	#modalCloseButton {
		background-color: #e6e6e6;
		color: black;
	}
	
	.modalButton {
		margin-top: 4rem;
	}
	
</style>
<script type="text/javascript" src="/getdrive/resources/js/jquery-3.7.0.min.js"></script>
<script type="text/javascript">
$(function(){
	// 중복 체크 변수
    var isDuplicate = false;

    // 입력 필드의 값이 변경될 때마다 중복 검사
    $('#newTeamName').on('blur', function(){
        var teamName = $(this).val();
        $.ajax({
            url: "duplicateCheck.do",
            type: "post",
            data: {tName: teamName},
            success: function(response){
                if(response === "duplicate") {
                    isDuplicate = true;
                    alert("이미 사용 중인 팀 이름입니다.");
                } else {
                    isDuplicate = false;
                }
            }
        });
    });

    // 입력된 값으로 팀명 수정
    $('#utname').click(function(event){
        event.preventDefault();
        var newTeamName = $('#newTeamName').val();
        $('#modalTeamName').text("작성하신 팀명으로 변경하시겠습니까?");
        $('#modalContainer').removeClass('hidden');
    });

    // 모달창 확인 버튼
    $('#submitName').click(function(event){
        event.preventDefault();
        
        if(isDuplicate) {
            $('#modalContainer').addClass('hidden');
        } else {
            $('#teamNameForm').submit();
        }
    });

    // 모달창 닫기
    $('#modalCloseButton').click(function(event){
        event.preventDefault();
        $('#modalContainer').addClass('hidden');
    });
    
    // 팀 삭제할 때 비밀번호가 일치하지 않는 경우
    $('#password').on('blur', function(){
        $.ajax({
            url: "pwdchk.do",
            type: "post",
            data: {pwd: $(this).val()},
            success: function(response){
            	if(response === "wrong") {
                    alert("비밀번호가 일치하지 않습니다.");
                    $('#deleteButton').prop('disabled', true);
                } else {
                    $('#deleteButton').prop('disabled', false);
                }
            }
        });
    });
    
    // 팀 삭제
    $('#deleteButton').click(function(){
    	$.ajax({
            url: "dteam.do",
            type: "post",
            data: {tNo: $('#teamNo').val()},
            success: function(response){
            	if(response === "success") {
                    alert("팀이 정상적으로 삭제되었습니다.");
                    location.href = "tmain.do";
                } else {
                	alert("다른 팀원이 존재합니다. 먼저 팀장의 권한을 이양하세요.");
                }
            }
        });
    });
});
</script>
</head>
<body>
<c:import url="/WEB-INF/views/common/mainTopbar.jsp"></c:import>
<hr>
<!-- 헤더 영역 -->
<header>
	<h2>${ team.tName }</h2>
</header>
<hr>
<section>
	<!-- 사이드 메뉴 -->
	<aside>
		<img><br>
		<div id="team_btn">
			<span>팀 관리</span>
		</div>
		<div id="member_btn">
			<c:url var="tinfo" value="tinfo.do">
				<c:param name="tNo" value="${ team.tNo }"/>
			</c:url>
			<a href="${ tinfo }"><span>멤버 관리</span></a>
		</div>
	</aside>
	<div class="wrapper">
		<h2>팀 관리</h2>
		<div class="content">
			<h4>팀 이름 변경</h4>
			<p>새로운 팀 이름</p>
			<form id="teamNameForm" action="uteam.do">
			    <input type="text" id="newTeamName" name="tName" placeholder="새로운 팀 이름을 입력해주세요"> &nbsp;
			    <input type="hidden" id="teamNo" name="tNo" value="${team.tNo}">
			    <button>팀 이름 변경하기</button>
			    <div id="modalContainer" class="hidden">
			        <div id="modalContent">
			            <h4 id="modalTeamName"></h4>
			            <div class="modalButton">
			                <button id="modalCloseButton">취소</button>
			                <input id="submitName" type="submit" value="확인">
			            </div>
			        </div>
			    </div>
			</form>
			<h4>팀 삭제</h4>
			<p style="color: red;">비밀번호 입력</p>
				<input id="password" type="password" name="pwd" placeholder="비밀번호를 입력해주세요"> &nbsp;
				<button id="deleteButton">팀 삭제하기</button>
		</div>
	</div>
</section>
</body>
</html>