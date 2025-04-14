<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>리뷰관리</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/user/review/reviewDetail.css">
</head>
<body>
    <!-- 헤더 포함 -->
    <jsp:include page="include/header.jsp"/>

    <!-- 사이드바 포함 -->
    <jsp:include page="include/sidebar.jsp"/>

    <c:set var="r" value="${review}" />
    <!-- 본문 컨텐츠 -->
    <main class="content">
        <h2>리뷰관리</h2>

        <div class="container">
            <div class="image-container">
                <c:choose>
                    <c:when test="${not empty r.imageUrl}">
                        <img src="${pageContext.request.contextPath}${r.imageUrl}" alt="차량리뷰 이미지">
                    </c:when>
                    <c:otherwise>
                        <img src="${pageContext.request.contextPath}/img/di1.jpg" alt="기본 이미지">
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="title-row">
                <div class="title">${r.reviewTitle}</div>
                <div class="stars">
                    <c:forEach var="i" begin="1" end="5">
                        <c:choose>
                            <c:when test="${i <= r.rating}">★</c:when>
                            <c:otherwise>☆</c:otherwise>
                        </c:choose>
                    </c:forEach>
                </div>
            </div>

            <div class="meta-info">
                <span class="writer">${r.userName}</span>
                <span class="timestamp">${r.formattedCreatedAt}</span>
            </div>

            <div class="description">
                ${r.reviewContent}
            </div>

            <div class="comment-section">

                <c:if test="${not empty r.reviewComment}">
                    <div class="comment-list">
                        <div class="comment">
                            <div class="comment-header">
                                <div class="author">관리자</div>
                                <div class="comment-time meta-info">${r.reviewComment.formattedCreatedAt}</div>
                            </div>
                            <div class="text">${r.reviewComment.commentContent}</div>
                            <div class="button-wrapper">
                                <button type="button" class="button delete-button" onclick="deleteComment(${r.reviewComment.reviewCommentId})">삭제하기</button>
                            </div>
                        </div>
                    </div>
                </c:if>


                <!-- 댓글이 없는 경우: 작성 폼 -->
                <c:if test="${empty r.reviewComment}">
                    <div class="comment-list">
                        <div class="comment">
                            <input type="hidden" id="reviewId" name="reviewId" value="${r.reviewId}" />

                            <div class="comment-header">
                                <div class="author">관리자</div>
                                <div class="comment-time meta-info"></div>
                            </div>

                            <div class="text">
                                <textarea id="commentContent" name="commentContent" class="comment-textarea" placeholder="관리자 댓글을 입력하세요" required></textarea>
                            </div>

                            <div class="button-wrapper">
                                <button type="button" class="button submit-button" onclick="submitComment()">등록하기</button>
                            </div>
                        </div>
                    </div>
                </c:if>


                <div>
                    <div class="button-wrapper">
                        <a href="${pageContext.request.contextPath}/admin/review?page=${page}"><button class="back-link">← 목록으로 돌아가기</button></a>
                    </div>
                </div>
            </div>

        </div>

    </main>

    <script>
        function submitComment() {
            const reviewId = document.getElementById("reviewId").value;
            const commentContent = document.getElementById("commentContent").value;

            fetch("${pageContext.request.contextPath}/admin/review/comment", {
                method: "POST",
                headers: {
                    "Content-Type": "application/json"
                },
                body: JSON.stringify({
                    reviewId: reviewId,
                    commentContent: commentContent
                })
            })
            .then(response => {
                if (response.ok) {
                    alert("댓글이 등록되었습니다.");
                    location.reload(); // 혹은 상세 페이지로 리디렉트
                } else {
                    alert("등록 실패");
                }
            });
        }

        function deleteComment(reviewCommentId) {
            fetch("${pageContext.request.contextPath}/admin/review/comment/delete", {
                method: "POST",
                headers: {
                    "Content-Type": "application/json"
                },
                body: JSON.stringify(reviewCommentId)
            })
                .then(response => {
                    if (response.ok) {
                        alert("댓글이 삭제되었습니다.");
                        location.reload();
                    } else {
                        alert("삭제 실패");
                    }
                });
        }
    </script>
</body>
</html>
