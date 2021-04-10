<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>  
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>  
<c:set var="path" value="${ pageContext.request.contextPath }"/>    

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>북리뷰 글쓰기</title>
    <link rel="stylesheet" href="${ path }/css/board/br_style/brBoardWrite.css" type="text/css">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Source+Sans+Pro&display=swap" rel="stylesheet">
    <script 
    src="https://kit.fontawesome.com/2d323a629b.js" 
    crossorigin="anonymous"
    ></script>
    <script src="${ path }/js/jquery-3.5.1.js"></script>
    <script src="${ path }/ckeditor/ckeditor.js"></script>

</head>
<%@ include file="../../common/header.jsp" %>
	 <div class="wrap">
    	<section class="brboard-write">    
	        <section class = "brboard-top">
	            <div class = "brboard-top-title">
	                <a href="#">북리뷰 게시판</a>
	            </div>
	            <div class = "brboard-top-menu">
	                <li><a href="#">전체</a></li>
	                <li><a href="#">소설</a></li>
	                <li><a href="#">어린이/청소년</a></li>
	                <li><a href="#">경제/경영</a></li>
	                <li><a href="#">인문/사회/역사</a></li>
	                <li><a href="#">종교/역학</a></li>
	                <li><a href="#">자기개발</a></li>
	            </div>
	            <div class = "brboard-top-button">
	                <a href="${path}/board/br_board/brBoardWrite" class="write-button">글쓰기</a>
	            </div>
	            <hr id="line">
	        </section>
	        <section class ="brboard-write-body">
	            <form action="${ path }/board/br_board/brBoardWrite${_csrf.parameterName}=${_csrf.token}" method="post" id="post_form" enctype="multipart/form-data">
	                <p>북리뷰 글쓰기</p>
	                <div class="brboard-write-option">
	                    <p>글제목</p>
	                    <div id="brboard-write-title">
	                        <input type="text" id="title" name="title" required>
	                    </div>
	
	                    <p>책장르</p>
	                    <div id="brboard-write-booktype">
							<input type="radio" id="book-check" value="b1" name="booktype"> <label id="radio_text">소설&nbsp;</label> 
							<input type="radio" id="book-check" value="b2" name="booktype"> <label id="radio_text">어린이/청소년&nbsp;</label> 
							<input type="radio" id="book-check" value="b3" name="booktype"> <label id="radio_text">경제/경영 &nbsp;</label> 
							<input type="radio" id="book-check" value="b4" name="booktype"> <label id="radio_text">인문/사회/역사 &nbsp;</label> 
							<input type="radio" id="book-check" value="b5" name="booktype"> <label id="radio_text">종교/철학 &nbsp;</label> 
							<input type="radio" id="book-check" value="b6" name="booktype"> <label id="radio_text">자기개발 &nbsp;</label> 
						</div>
	
	                    <div id="brboard-write-bookselect">
	                        <span>책선택</span>
								<input id="bookName" value="" type="text">
							    <button id="search">검색</button>
							    <div id="bookdata">
							    	<p id="title"></p>
							    	<p id="bookthumb"></p>
							    </div>
							    <script>
							        $(document).ready(function () {
							            $("#search").click(function () {
							                $.ajax({
							                    method: "GET",
							                    url: "https://dapi.kakao.com/v3/search/book?target=title",
							                    data: { query: $("#bookName").val() },
							                    headers: { Authorization: "KakaoAK 954b12f5b02d89c0024a777f0dab5148" }
							                })
							                    .done(function (msg) {
							                        console.log(msg.documents[0].title);
							                        console.log(msg.documents[0].thumbnail);
							                        $("#title").append("<strong>" + msg.documents[0].title + "</strong>");
							                        $("#bookthumb").append("<img src='" + msg.documents[0].thumbnail + "'/>");
							                    });
							            });
							        });
							    </script>
						  	
 							<!--  <input type="button" value="책검색" onclick="window.open('${path}/board/br_board/bookSearch', '책검색', 'width=500, height=500')">
	                    	<p id="selectedbook"></p>-->
	                    </div>
	                </div>
	                <textarea name="ckeditor" id="ckeditor"></textarea>
	                <script>
					CKEDITOR.replace( "ckeditor", {//해당 이름으로 된 textarea에 에디터를 적용
						height: 1000,
						getUploadUrl: type='image',
						filebrowserUploadUrl: '<c:url value="/board/br_board/brBoardWrite" />?${_csrf.parameterName}=${_csrf.token}' //여기 경로로 파일을 전달하여 업로드 시킨다.
							

					});
					CKEDITOR.editorConfig = function( config ) { config.filebrowserUploadUrl = '/board/br_board/brBoardWrite'; };
					</script>
	                <input type="hidden" name="_csrf" value="${_csrf.token}" name="${_csrf.parameterName}" />
	            </form>
	        </section>
        <section class="brboard-write-bottom">
            <a href="#" id="write-bottom-cancelbtn">취소</a>
            <a href="#" id="write-bottom-enrollbtn">등록</a>
        </section>
    </div>    
    </div>

<%@ include file="../../common/footer.jsp" %>
