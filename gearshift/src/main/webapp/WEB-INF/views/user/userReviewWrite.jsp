<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>리뷰 작성하기</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/user/review/userReviewWrite.css">
</head>
<body>
    <div class="container">

        <div class="product-info-box">
            <c:choose>
                <c:when test="${not empty carImageUrl}">
                    <img src="${pageContext.request.contextPath}${carImageUrl}" alt="${modelName} 이미지">
                </c:when>
                <c:otherwise>
                    <img src="${pageContext.request.contextPath}/img/di1.jpg" alt="기본 이미지">
                </c:otherwise>
            </c:choose>

            <div class="product-text">
                <div class="product-name">${modelName}</div>
                <div class="product-date">${orderCompletedDate} 배송</div>
            </div>
        </div>

        <h2>리뷰 작성하기</h2>

        <form action="${pageContext.request.contextPath}/user/review/register/${orderId}" method="post" enctype="multipart/form-data">
            <input type="hidden" name="carInfoId" value="${carInfoId}" />

            <label for="title">제목</label>
            <input type="text" id="title" name="reviewTitle" placeholder="제목을 입력하세요" required>

            <div class="rating">
                <label class="rating-title">별점</label>
                <div class="stars">
                    <input type="radio" id="star5-${order.orderId}" name="rating" value="5"><label for="star5-${order.orderId}">★</label>
                    <input type="radio" id="star4-${order.orderId}" name="rating" value="4"><label for="star4-${order.orderId}">★</label>
                    <input type="radio" id="star3-${order.orderId}" name="rating" value="3"><label for="star3-${order.orderId}">★</label>
                    <input type="radio" id="star2-${order.orderId}" name="rating" value="2"><label for="star2-${order.orderId}">★</label>
                    <input type="radio" id="star1-${order.orderId}" name="rating" value="1"><label for="star1-${order.orderId}">★</label>
                </div>
            </div>

            <label for="content">내용</label>
            <textarea id="content" name="reviewContent" placeholder="내용을 입력하세요" required></textarea>

            <label for="image">사진 첨부</label>
            <div class="file-wrap">
                <label for="image" class="file-label">파일 선택</label>
                <input type="file" id="image" name="image" accept="image/*" style="display:none;">
                <span class="file-name" id="fileName">선택된 파일 없음</span>
            </div>

            <div class="button-group">
                <button type="submit" class="submit-button">등록하기</button>
                <button type="button" class="cancel-button" onclick="history.back()">등록 취소</button>
            </div>

        </form>
    </div>
    <script>
        document.getElementById('image').addEventListener('change', function () {
            const fileName = this.files.length > 0 ? this.files[0].name : '선택된 파일 없음';
            document.getElementById('fileName').textContent = fileName;
        });

        document.querySelector('form').addEventListener('submit', function (e) {
            const checkedRating = document.querySelector('input[name="rating"]:checked');
            if (!checkedRating) {
                alert("별점을 선택해주세요.");
                e.preventDefault();
            }
        });
    </script>
</body>
</html>
