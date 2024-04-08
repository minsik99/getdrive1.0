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
	}
	
	header h2 {
		display: inline-block;
	}
	
	section {
		display: flex;
	}
	
	.functions {
		display: flex;
		justify-content: space-between;
	}
	
</style>
<script type="text/javascript" src="/getdrive/resources/js/jquery-3.7.0.min.js"></script>
<script type="text/javascript">

</script>
</head>
<body>
<c:import url="/WEB-INF/views/common/mainTopbar.jsp" />
<header>
	<div>
		<img id="arrow" src="/getdrive/resources/images/chevron_left.png">
		<h2>드라이브</h2>
	</div>
	<div>
		<input id="search">
	</div>
</header>
<hr>
<section>
	<!-- 사이드 메뉴 -->
	<aside>
		<h3>새 드라이브 생성</h3>
		<img id="add" src="/getdrive/resources/images/add.png"><br>
		<select>
			<option>드라이브 1</option>
			<option>드라이브 2</option>
		</select>
		<select>
			<option>비공개 드라이브 1</option>
			<option>비공개 드라이브 2</option>
		</select>
		<img id="trash" src="/getdrive/resources/images/trash.png">
	</aside>
	<div class="wrapper">
		<div class="wrapper_header">
			<div><span>(드라이브명)</span></div>
			<div class="functions">
				<div>
					<input type="checkbox"><span>전체선택</span>
					<button>새폴더</button>
					<button>업로드</button>
				</div>
				<div>
					<img>
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