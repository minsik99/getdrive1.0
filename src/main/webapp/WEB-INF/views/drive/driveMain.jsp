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
	
	/* 스타일링 */
	.custom-select {
	    appearance: none;
	    -webkit-appearance: none;
	    -moz-appearance: none;
	    background-color: #f8f9fa;
	    border: 1px solid #ced4da;
	    padding: 0.5rem;
	    border-radius: 0.25rem;
	    font-size: 1rem;
	    width: 9rem;
	    margin-bottom: 2rem 0;
	}

	.custom-select option {
	    background-color: #f8f9fa;
	    color: #495057;
	}
	
	.wrapper {
		width: 87vw;
		margin-left: 2rem;
	}
	
	.functions {
		display: flex;
		justify-content: space-between;
	}
	
</style>
<script type="text/javascript" src="/getdrive/resources/js/jquery-3.7.0.min.js"></script>
<script type="text/javascript">
	$(function(){
		$(".custom-select").change(function() {
            var selectedText = $(this).find("option:selected").text();
            $("#link").text(selectedText);
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
		<h2>드라이브</h2>
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
		    <img id="add" src="/getdrive/resources/images/add.png" style="margin-left: 0.5rem">
		</div>
		<!-- select 태그 -->
		<p>전체 공개</p>
		<select class="custom-select">
		    <!-- option 태그 -->
		    <option value="b1">드라이브 1</option>
		    <option value="b2">드라이브 2</option>
		    <option value="b3">드라이브 3</option>
		</select>
		<br>
		<!-- select 태그 -->
		<p>비공개</p>
		<select class="custom-select">
    		<!-- option 태그 -->
		    <option value="1">1드라이브</option>
		    <option value="2">2드라이브</option>
		    <option value="3">3드라이브</option>
		</select>
		<br>
		<img id="trash" src="/getdrive/resources/images/trash.png">
	</aside>
	<div class="wrapper">
		<div class="wrapper_header">
			<a id="link">(옵션)</a><br>
			<div class="functions">
				<div>
					<input type="checkbox"><span>전체선택</span> &nbsp;
					<button>새폴더</button> &nbsp;
					<button>업로드</button>
				</div>
				<div style="display: flex; align-items: center;">
					<img id="sort" src="/getdrive/resources/images/sort.png">
				</div>
			</div>
		</div>
		<hr>
		<table>
		
		</table>
	</div>
</section>
</body>
</html>