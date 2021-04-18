<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>    
<c:set var="path" value="${ pageContext.request.contextPath }"/>    
<security:authentication property="principal" var="user"/>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>북리뷰 상세보기</title>
    <link rel="stylesheet" href="${ path }/css/board/br_style/brReviewDetail.css" type="text/css">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Source+Sans+Pro&display=swap" rel="stylesheet">
    <script src="js/jquery-3.5.1.js"></script>
    <script 
    src="https://kit.fontawesome.com/2d323a629b.js" 
    crossorigin="anonymous"
    ></script>
    
</head>
<body>
<%@ include file="../../common/header.jsp" %>
	<div class="wrap">
        <section class="brboard-body">    
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
            <section class="brboard-review">
                <div class="brboard-review-header">
                	<p style="display:none">${board.brNo}</p>
                    <p id="reviewheader-bookclass">${board.brBookType}</p>
                    <p id="reviewheader-reviewtitle">${board.brTitle}</p>
                    <p id="reviewheader-reviewwriter">${board.userNname}</p>
                    <p id="reviewheader-reviewdate">${board.brCreateDate}</p>
                </div>
                <hr>
                <div class="review-book-bookscrap">
                		<a class="scrap-button" id="scrap-icon1"><img src="${ path }/images/scrap_0.png" class="scrapicon">스크랩하기</a>
                		<a class="scrap-button" id="scrap-icon2"><img src="${ path }/images/scrap_1.png" class="scrapicon">스크랩취소</a>
                </div>
                <div class="brboard-review-book">
                    <div class="review-book-cover">
                        <a href="#" name="thumbnailbox" id="thumbnailbox"></a>
                    </div>    
                    <div class="review-book-description">
                        <div class="book-description">
                        	<p id="review-bookisbn" style="display:none" value="${board.brIsbn}"/>
                            <p id="book-description-booktitle"><a href="#"></a></p>
                            <p id="book-description-bookwriter"></p>
                            <p id="book-description-bookpublisher"></p>
                            <p id="book-description-bookpublish"></p>
                            <p id="book-description-bookstarrate">${board.brRating}</p>
                            <p id="book-description-bookcontents"></p>
                         <!--    <p id="book-description-bookreviewcount"></p>--> 
                        </div>
                    </div>
                </div>    
                <hr>
                <div class="brboard-review-content">
                 	<c:out value="${board.brContent}" escapeXml="false"/>
                </div>
                <div class="brboard-review-contentlower">
                    <span id="review-recommend-btn">
                        <a href="#" class="recommend-button"><img src="${ path }/images/heart.png" class="recoicon" id="recommend-icon1"></a>
                        <a href="#" class="recommend-button"><img src="${ path }/images/redheart.png" class="recoicon" id="recommend-icon2"></a>
                        <span id="review-recommend-btn">추천 ${board.brLike}</span>
                    </span>
                    <span id="review-edit-btn">
                        <a href="#" id="edit-button">수정</a>
                        <a href="#" id="delete-button">삭제</a>
                    </span>
                </div>
                <hr>
                <!--  
                <div class="brboard-review-comment">
                    <article class="propose-read-article-1th">
                        <div class="board_title">
                            <p class="view_title">댓글 테스트</p>
                        </div>
                        <div class="board_summary">
                            <div class="left">
                                <div class="avatar">
                                    <img alt="프로필 이미지" src="https://cdn.imweb.me/thumbnail/20161214/5850d6a2c09a8.jpg" class="avatar-image">
                                </div>
                                <div class="author">
                                    <div class="write">김동민</div>
                                </div>
                            </div>
                            <div class="board_txt_area">
                                <p>
                                 댓글입니다~
                                </p>
                            </div>
                            -->
			<div class="container">
					<form id="commentListForm" name="commentListForm" method="post">
						<div id="commentList"></div>
					</form>
				</div>
				<div class="comment_textarea">
                        <form id="commentForm" name="commentForm" method="post" class="comment_form">
                            <div class="custom-textarea">
                                <textarea class="comment_body" style="border: 0px; width: auto; outline: none;" name="comContent" id="comContent" rows="1" placeholder="댓글을 남겨주세요"></textarea>
                                <div class="write_button_wrap">
                                    <div class="none"></div>
                                    <div class="write_button">
                                        <a href='#' id="commentBtn" class="btn pull-right btn-success">등록</a>
                                    </div>
                                </div>
                            </div>
                            <input type="hidden" id="b_code" name="b_code" value="${result.code }" /> 
                        </form>
                    </div>
                </div>    
            </section>
            <hr>
            <section class="brboard-review-bottom">
                <article class="propose-list-section-3th">
                    <div class="reviewbot-list-head">북리뷰글 목록</div>
                    <table>
                        <thead style="border-top: 2px solid rgb(241, 241, 241);">
                            <th>번호</th>
                            <!-- <th style="display: none;">카테고리</th> -->
                            <th>제목</th>
                            <th>작성자</th>
                            <th id="blind">작성일</th>
                            <th id="blind">조회수</th>
                        </thead>
                        <tbody style="border-bottom: 1px solid rgb(241, 241, 241); border-top: 1px solid rgb(241, 241, 241);">
                            <tr>
                                <td>1</td>
                                <td>
                                    <a>네이버/페이스북/카카오톡등 SNS로그인 가능합니다!</a>
                                </td>
                                <td>대표 관리자</td>
                                <td id="blind">2019-04-15</td>
                                <td id="blind">19</td>
                            </tr>
                        </tbody>
                    </table>
                    <section class="brboard-bot">
                        <div class="brboard-pagination">
                            <a href="#">&laquo;</a>
                            <a href="#">1</a>
                            <a href="#">2</a>
                            <a href="#">3</a>
                            <a href="#">4</a>
                            <a href="#">5</a>
                            <a href="#">6</a>
                            <a href="#">&raquo;</a>
                        </div>
                <!--http://ecudemo121656.cafe24.com/ 참고하기-->
                    </section>
                </article>
            </section>
        </section>    
    </div>
</body>

	<script>
	    $(document).ready(function(){
	            
	            /*추천 버튼 눌렀을때*/
	            /*웹페이지 열었을 때*/
	            $("#recommend-icon1").show();
	            $("#recommend-icon2").hide();
	            /*img1을 클릭했을 때 img2를 보여줌*/
	            $("#recommend-icon1").click(function(){
	                $("#recommend-icon1").hide();
	                $("#recommend-icon2").show();
	            });
	            /*img2를 클릭했을 때 img1을 보여줌*/
	            $("#recommend-icon2").click(function(){
	                $("#recommend-icon1").show();
	                $("#recommend-icon2").hide();
	            });
	            
	            
	        });
	</script>
	<script>
	    $(document).ready(function() {
	        $('.comment_body').on('keyup', function(e) {
	            $(this).css('height', 'auto');
	            $(this).height(this.scrollHeight);
	        });
	        $('.comment_body').keyup();
	    })
	</script>
	<script>
	 $(document).ready(function () {
             $.ajax({
                 method: "GET",
                 url: "https://dapi.kakao.com/v3/search/book?target=isbn",
                 data: { query: ${board.brIsbn} },
                 headers: { Authorization: "KakaoAK 954b12f5b02d89c0024a777f0dab5148" },
             })
                 .done(function (msg) {
                     console.log(msg.documents[0].title);
                     console.log(msg.documents[0].thumbnail);
                     console.log(msg.documents[0].datetime);
                     console.log(msg.documents[0].authors);
                     console.log(msg.documents[0].publisher);
                     console.log(msg.documents[0].contents);
                     $("#thumbnailbox").append("<img src='" + msg.documents[0].thumbnail + "'/>");
                     $("#book-description-booktitle").append(msg.documents[0].title);
                     $("#book-description-bookwriter").append(msg.documents[0].authors);
                     $("#book-description-bookpublisher").append(msg.documents[0].publisher);
                     $("#book-description-bookpublish").append(msg.documents[0].datetime);
                     $("#book-description-bookcontents").append(msg.documents[0].contents);
                 });
     });
	</script>
	<script>
	$(document).ready(function(){
	function getComments() {
		var recipeNo = $("#recipeNo").data("recipeno");

		$.ajax({
			type: "GET",
			url: "/api/recipes/" + recipeNo + "/comments",
			dataType: "json",
			contentType: "application/json; charset=utf-8",
			success: function (result) {
				var content = `<div class="comment-option">
									<h3 id="comment-title">댓글<span class="badge">${result.length}</span></h3>
								</div>`;
				$.each(result, function (index, item) {

					content += `<li class="list-group-item">
									<p><strong>${item.commentWriter}</strong></p>
									<p>${item.commentContent}</p>`;

					// 삭제 댓글인지 아닌지를 확인하기 위함
					if (item.commentStatus != "N") {
						content += `<p><span>최종 수정일: ${item.fullDate} </span><span><button type="button" class="btn-reply">답글쓰기</button>`
					}

					// 댓글작성자이면 수정 삭제가 가능하게 하기 위함
					if (item.commentStatus != "N" && item.role == "w") {
						content += `<button class="btn-update">수정</button><button class="btn-delete">삭제</button>`;
					}
					content += `</span></p></li></ul>`;

				})
				$("#comment-show").empty().append(content);
				// 댓글 등록 활성화
				saveComment();
				// 답변하기 Add 창 활성화
				attachReplyDiv();
				// 자신의 댓글 수정버튼 누를시 수정창으로 바뀌는 것 활성화
				changeCommentDiv();
				// 자신 댓글 삭제 기능 활성화
				deleteComment();
			}
		})
	}

	/*
	 * 댓글 삭제 
	 */
	function deleteComment() {
		$(".btn-delete").off().on('click', function () {

			var commentNo = $(this).closest("ul").data("comment-no")
			var recipeNo = $("#recipeNo").data("recipeno");
			$.ajax({
				method: "DELETE",
				url: "/api/recipes/" + recipeNo + "/comments/" + commentNo
			}).done(function () {
				alert("삭제가 완료되었습니다.");
				getComments();
			}).fail(function () {
				alert("알수 없는 오류가 발생하였습니다.")
				location.href = "/recipes/" + recipeNo;
			})
		})
	}

	/*
	 * 새 댓글을 등록한다.
	 */
	function saveComment() {
		var recipeNo = $("#recipeNo").data("recipeno");
		var nickName = $("#nickname").data("user-nickname");

		$(".attach-comment").off().on('click', function () {
			var data = {}

			var content = $(this).closest("#comment-writer").find("textarea").val();

			if (content == null) {

				content = $(this).closest("#comment-reply").find("textarea").val();
				data.commentParentNo = $(this).closest("ul").data("comment-no");
				$(this).closest("#comment-reply").find("textarea").val("");

			} else {
				$(this).closest("#comment-writer").find("textarea").val("");
			}
			if (content.trim().length < 15) {
				alert("현재 타이핑수: " + content.trim().length + " 최소 타이핑 수는 15 이상입니다.");
				return;
			}
			data.commentContent = content;
			data.recipeNo = recipeNo;
			data.commentWriter = nickName;

			$.post("/api/recipes/" + recipeNo + "/comments", data, function () {
				getComments();
				alert("댓글이 등록되었습니다.");
			}).fail(function () {
				alert("알수없는 오류가 발생하였습니다");
			})
		})
	}
	
	});
	</script>

	

<%@ include file="../../common/footer.jsp" %>
