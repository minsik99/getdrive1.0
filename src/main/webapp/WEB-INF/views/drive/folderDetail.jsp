<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<style type="text/css">

	header {
		display: flex;
		justify-content: space-between;
		align-items: center;
	}
	
	header h2 {
		display: inline-block;
	}
	
	img#arrow {
		width: 3rem;
		height: 3rem;
	}
	
	img#arrow:hover {
		cursor: pointer;
	}
	
	img#add {
		width: 1rem;
		height: 1rem;
	}
	
	img#add:hover {
		cursor: pointer;
	}
	
	img#trash {
		width: 2rem;
		height: 2rem;
		margin-top: 15rem;
	}
	
	img#trash:hover {
		cursor: pointer;
	}
	
	img#sort {
		width: 1.5rem;
		height: 1.5rem;
	}
	
	img#sort:hover {
		cursor: pointer;
	}
	
	section {
		display: flex;
	}
	
	aside {
		width: 13vw;
		padding: 1rem 0 1rem 2.5rem;
		background-color: #6DBFF2;
		color: white;
	}
	
	.wrapper {
		width: 87vw;
		margin-left: 2rem;
	}
	
	.functions {
		display: flex;
		justify-content: space-between;
	}
	
	/* 드라이브 생성 모달창 */
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
	  width: 20rem;
	  height: 10rem;
	  padding: 1.5rem;
	}
	
	#modalContainer.hidden {
	  display: none;
	}
	
	#modalCloseButton {
		background-color: #e6e6e6;
		color: black;
	}
	
</style>
<script type="text/javascript" src="/getdrive/resources/js/jquery-3.7.0.min.js"></script>
<script type="text/javascript">
    $(function(){
        
         // 새 드라이브 생성 모달창
        $('#add').click(function() {
            $('#modalContainer').removeClass('hidden');
        });
        // 모달창 확인 버튼
        $('#submitDriveName').click(function(event){
            event.preventDefault();
            $('#driveNameForm').submit();
        });
        // 모달창 닫기
        $('#modalCloseButton').click(function(event){
            event.preventDefault();
            $('#modalContainer').addClass('hidden');
        });
        
        // 이전 버튼
        $('#arrow').click(function(){
        	history.back();
        });
    });
    
</script>
</head>
<body>
<c:import url="/WEB-INF/views/common/mainTopbar.jsp" />
<hr>
<header>
    <div style="display: flex; align-items: center;">
        <img id="arrow" src="/getdrive/resources/images/chevron_left.png">
        <h2>${ selectedFolder.fdName } 폴더 </h2>
    </div>
    <div>
        <input id="search" placeholder="파일 검색">
    </div>
</header>
<section>
    <!-- 사이드 메뉴 -->
    <aside>
        <div style="display: flex; align-items: center;">
            <p style="font-weight: bold; margin-bottom: 1rem;">새 드라이브 생성</p>
            <img id="add" src="/getdrive/resources/images/add.png" style="margin-left: 0.5rem;">
        </div>
        <img id="trash" src="/getdrive/resources/images/trash.png">
    </aside>
    <div class="wrapper">
        <div class="wrapper_header">
            <p>${ selectedFolder.fdName }</p>
            <div class="functions">
                <div>
                    <input type="checkbox"><span>전체선택</span> &nbsp;
                    <form action="upload.do" method="post" enctype="multipart/form-data">
                		<input type="hidden" name="flTID" value="${ selectedFolder.fdTID }">
                		<input type="hidden" name="flDID" value="${ selectedFolder.fdDID }">
                		<input type="hidden" name="flFDID" value="${ selectedFolder.fdNo }">
                		<input type="hidden" name="flCRUID" value="${ loginMember.accountNo }">
				        <input type="file" name="file" id="file">
				        <input type="submit">
				    </form>
                </div>
                <div style="display: flex; align-items: center;">
                    <img id="sort" src="/getdrive/resources/images/sort.png">
                </div>
            </div>
        </div>
        <hr>
        <!-- 파일이 있다면 출력 -->
        <ul>
        	<c:forEach items="${ list }" var="file">
        		<li>
        			<span>${ file.flName }</span> &nbsp;
		        	<!-- 파일 다운로드 링크 -->
		            <a href="fdown.do?fileId=${file.flNo}" download>다운로드</a>
        		</li>
        	</c:forEach>
        </ul>
    </div>
</section>
<!-- 새 드라이브 생성 모달창 -->
<form id="driveNameForm" action="idrive.do">
    <div id="modalContainer" class="hidden">
        <div id="modalContent">
            <h4>새 드라이브 생성</h4>
            <div style="margin-top: 3rem;">
                <input name="dName" type="text" placeholder="새 드라이브 이름을 입력하세요."><br>
                <input name="tNo" type="hidden" value="${ folder.fdTID }">
                <button id="modalCloseButton">취소</button> &nbsp;
                <input id="submitDriveName" type="submit" value="확인">
            </div>
        </div>
    </div>
</form>
</body>
</html>
