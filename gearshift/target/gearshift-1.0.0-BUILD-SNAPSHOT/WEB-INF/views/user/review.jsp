<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>상품리뷰</title>
    <link href="https://fonts.googleapis.com/css2?family=Pretendard&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/user/review/review.css">
    <link rel="stylesheet" href="<c:url value='/resources/css/user/header.css' />">
    <link rel="stylesheet" href="<c:url value='/resources/css/user/footer.css' />">

</head>
<body>
<%
    request.setAttribute("hideSearch", true);
%>
<%-- 헤더 영역 --%>
<%@ include file="/WEB-INF/views/user/include/header.jsp" %>
    <h1 style="text-align:center;">솔직한 이용 후기</h1>
    <br>
    <div class="container">
        <c:forEach var="r" items="${reviews}">
            <div class="card">
                <a href="${pageContext.request.contextPath}/review/${r.reviewId}?page=${paging.page}">
                    <c:choose>
                        <c:when test="${not empty r.imageUrl}">
                            <img src="${pageContext.request.contextPath}${r.imageUrl}" alt="차 리뷰 ${r.reviewId}">
                        </c:when>
                        <c:otherwise>
                            <img src="${pageContext.request.contextPath}/img/di1.jpg" alt="기본 이미지">
                        </c:otherwise>
                    </c:choose>
                </a>

                <a href="${pageContext.request.contextPath}/review/${r.reviewId}?page=${paging.page}"><h3>${r.reviewTitle}</h3></a>
                <p>${r.reviewContent}</p>
            </div>
        </c:forEach>
    </div>
    <br><br>
    <div class="pagination">
        <c:if test="${paging.hasPrev}">
            <a href="?page=${paging.startPage - 1}">&lt;</a>
        </c:if>

        <c:forEach var="i" begin="${paging.startPage}" end="${paging.endPage}">
            <a href="?page=${i}" class="${i == paging.page ? 'active' : ''}">${i}</a>
        </c:forEach>

        <c:if test="${paging.hasNext}">
            <a href="?page=${paging.endPage + 1}">&gt;</a>
        </c:if>
    </div>
    <%@ include file="/WEB-INF/views/user/include/footer.jsp" %>
</body>
</html>