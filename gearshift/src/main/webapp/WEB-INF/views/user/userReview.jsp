<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

    <title>리뷰 작성</title>
    <link href="https://fonts.googleapis.com/css2?family=Pretendard&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<c:url value='/resources/css/user/review/userReview.css' />">
    <link rel="stylesheet" href="<c:url value='/resources/css/user/header.css' />">
    <link rel="stylesheet" href="<c:url value='/resources/css/user/footer.css' />">
    <link rel="stylesheet" href="<c:url value='/resources/css/user/sidebar.css' />">
</head>
<body>
<%
    request.setAttribute("hideSearch", true);
%>

<%-- 헤더 영역 --%>
<%@ include file="/WEB-INF/views/user/include/header.jsp" %>
<%-- 사이드바 --%>
<%@ include file="/WEB-INF/views/user/include/sidebar.jsp" %>
<main class="review-main">
    <div class="review-summary">
        <div>리뷰 작성</div>
    </div>

    <div class="product-list">

        <c:forEach var="order" items="${orders}">
            <c:set var="imgPath" value="${empty order.review.imageUrl
                                ? pageContext.request.contextPath += '/img/di1.jpg'
                                : pageContext.request.contextPath += order.review.imageUrl}" />
            <div class="product ${order.reviewStatus == 'Y' ? 'reviewed' : ''}">
                <div class="product-info">
                    <c:choose>
                        <c:when test="${not empty order.carImageUrl}">
                            <img src="${pageContext.request.contextPath}${order.carImageUrl}" alt="${order.modelName} 이미지" class="product-img">
                        </c:when>
                        <c:otherwise>
                            <img src="${pageContext.request.contextPath}/img/di1.jpg" alt="${order.modelName} 이미지" class="product-img" />
                        </c:otherwise>
                    </c:choose>


                    <div class="product-text">
                        <div class="product-name">${order.modelName}</div>
                        <div class="product-date">${order.orderCompletedDate} 배송</div>
                    </div>
                </div>

                <c:choose>
                    <c:when test="${order.reviewStatus == 'Y'}">
                        <div class="button-group">
                            <button class="view-button open-modal-btn"
                                    onclick="openModal(this)"
                                    data-title="${order.review.reviewTitle}"
                                    data-rating="${order.review.rating}"
                                    data-content="${order.review.reviewContent}"
                                    data-date="${order.review.formattedCreatedAt}"
                                    data-img="${imgPath}"
                                    data-comment="${order.review.reviewComment.commentContent}"
                                    data-commentdate="${order.review.reviewComment.formattedCreatedAt}">
                            리뷰 보기
                            </button>
                            <form action="${pageContext.request.contextPath}/user/review/delete/${order.review.reviewId}" method="post">
                                <button class="delete-button">리뷰 삭제</button>
                            </form>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <form action="${pageContext.request.contextPath}/user/review/register" method="post">
                            <input type="hidden" name="orderId" value="${order.orderId}" />
                            <input type="hidden" name="carInfoId" value="${order.carInfoId}" />
                            <input type="hidden" name="modelName" value="${order.modelName}" />
                            <input type="hidden" name="carImageUrl" value="${order.carImageUrl}" />
                            <input type="hidden" name="orderCompletedDate" value="${order.orderCompletedDate}" />
                            <button type="submit" class="review-button">리뷰 작성하기</button>
                        </form>
                    </c:otherwise>
                </c:choose>
            </div>
        </c:forEach>

    </div>

    <!-- 모달창 -->
    <div class="modal-overlay" id="modalOverlay" onclick="closeModal(event)">
        <div class="modal" onclick="event.stopPropagation()">
            <button class="close-btn" onclick="closeModal(event)">×</button>
            <br>
            <div class="image-container">
                <img id="modalImage" src="" alt="리뷰 이미지">
            </div>

            <div class="title" id="modalTitle"></div>

            <div class="stars" id="modalStars"></div>

            <div class="meta-info">
                <span class="timestamp" id="modalDate"></span>
            </div>

            <div class="description" id="modalContent"></div>

            <div id="commentArea" class="comment-section comment-list">
                <div class="comment">
                    <div class="comment-header">
                        <div class="author">관리자</div>
                        <div id="commentTimeArea" class="comment-time meta-info"></div>
                    </div>
                    <div id="commentContent" class="text"></div>
                </div>
            </div>
        </div>
    </div>
</main>

    <script>
        <c:if test="${not empty message}">
            alert("${message}");
        </c:if>

        function openModal(button) {
            const title = button.dataset.title;
            const rating = parseInt(button.dataset.rating || "0");
            const content = button.dataset.content;
            const date = button.dataset.date;
            const img = button.dataset.img;
            const comment = button.dataset.comment;
            const commentdate = button.dataset.commentdate;

            console.log('commentdate: ' + commentdate);
            let stars = '';
            for (let i = 1; i <= 5; i++) {
                stars += i <= rating ? '★' : '☆';
            }

            document.getElementById('modalTitle').textContent = title;
            document.getElementById('modalStars').innerHTML = stars;
            document.getElementById('modalContent').textContent = content;
            document.getElementById('modalDate').textContent = date;
            document.getElementById('modalImage').src = img;
            document.getElementById('commentContent').textContent = comment;
            document.getElementById('commentTimeArea').textContent = commentdate;
            document.getElementById('modalOverlay').style.display = 'flex';

            if(comment === '') {
                document.getElementById('commentArea').style.display = 'none';
            }

        }

        function closeModal(event) {
            document.getElementById('modalOverlay').style.display = 'none';
        }
    </script>
<%@ include file="/WEB-INF/views/user/include/footer.jsp" %>
</body>
</html>
