<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>write</title>
<style>

/* 전체 페이지 스타일링 */
body {
    font-family: Arial, sans-serif;
    background-color: #f5f5f5;
    margin: 0;
    padding: 0;
}

.board-container {
    max-width: 800px;
    margin: 20px auto;
    background-color: #fff;
    padding: 20px;
    border-radius: 5px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.board-container h2 {
    margin-top: 0;
}

/* 폼 요소 스타일링 */
.form-group {
    margin-bottom: 20px;
}

label {
    display: block;
    font-weight: bold;
    margin-bottom: 5px;
}

input[type="text"],
input[type="file"],
textarea {
    width: 100%;
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 5px;
    box-sizing: border-box;
}

textarea {
    resize: none;
    height: 200px;
}

/* 버튼 스타일링 */
.pull-right {
    text-align: right;
}

input[type="submit"],
input[type="button"] {
    padding: 10px 20px;
    background-color: #007bff;
    color: #fff;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.3s;
}

input[type="submit"]:hover,
input[type="button"]:hover {
    background-color: #0056b3;
}


</style>
<script type="text/javascript">

</script>
</head>
<body>

<section class="board-container">
	
		<div class="board-container">
		
			<div class="board-box_primary">

						<form id="writeForm" action="binsert.do" method="post" enctype="multipart/form-data">
							<div class="text_box" class="form-group">
								<h2 align="center">게시글 작성</h2>
								
						
							<div class="board-body">
						
								<div id="titleInput" class="form-group">
									<label for="bTitle">제 목</label>
									<input class="form-control" type="text" id="bTitle" name="bTitle" placeholder="제목을 입력하세요..." >
								</div>
								
								<div id="contentInput" class="form-group">
									<label for="bContent">내 용</label>
									<textarea class="form-control" id="bContent" name="bContent" rows="30" 
									placeholder="내용을 입력하세요..." style="resize: none;"></textarea>
								</div>
								
								<!-- 첨부파일 -->
								<div id="fileUp" class="form-group">
									<label for="bFile">첨부파일</label>
									<input type="file" name="upfile">
								</div>
								
								<c:url var="bl" value="bmain.do">
									<c:param name="page" value="1" />
								</c:url>
								
							</div>
								
								<div id="submit" align="center">
									<input type="submit" value="글등록하기">
									<input type="button" value="목록"
									onclick="javascript:location.href='${ bl }'; return false;">
								</div>
							</div>
					</form>


		</div>
	</div>
</section>
</body>
</html>