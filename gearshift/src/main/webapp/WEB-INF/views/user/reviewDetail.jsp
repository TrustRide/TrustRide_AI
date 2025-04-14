<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>차량리뷰 상세</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/user/review/reviewDetail.css">
</head>
<body>
    <c:set var="r" value="${review}" />
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
                    </div>
                </div>
            </c:if>

            <div>
                <div class="button-wrapper">
                    <a href="${pageContext.request.contextPath}/review?page=${page}"><button class="back-link">← 목록으로 돌아가기</button></a>
                </div>
            </div>
        </div>

    </div>
</body>
</html>
