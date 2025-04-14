<%@ page contentType="text/html;charset=UTF-8" language="java" session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>내 찜 목록</title>
    <link href="https://fonts.googleapis.com/css2?family=Pretendard&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<c:url value='/resources/css/user/header.css' />">
    <link rel="stylesheet" href="<c:url value='/resources/css/user/footer.css' />">
    <link rel="stylesheet" href="<c:url value='/resources/css/user/sidebar.css' />">
    <link rel="stylesheet" href="<c:url value='/resources/css/user/myWishlist.css' />">
</head>
<body>
<%
    request.setAttribute("hideSearch", true);
%>
<%-- 헤더 영역 --%>
<%@ include file="/WEB-INF/views/user/include/header.jsp" %>
<%-- 사이드바 --%>
<%@ include file="/WEB-INF/views/user/include/sidebar.jsp" %>

<main class="wishlist-main">
    <section class="wishlist-header">
    <h1>❤️ 내 찜 목록</h1>
    <c:if test="${empty wishlistCars}">
        <p style="text-align: center; font-size: 18px;">찜한 차량이 없습니다.</p>
    </c:if>
    </section>
    <section class="wishlist-grid-section">
    <div class="wishlist-grid">
        <c:forEach var="car" items="${wishlistCars}">
            <div class="car-card">
                <a href="/gearshift/carDetail?carInfoId=${car.carInfoId}">
                    <c:choose>
                        <c:when test="${not empty car.thumbnailUrl}">
                            <img src="${pageContext.request.contextPath}${car.thumbnailUrl}" alt="Car Image" />
                        </c:when>
                        <c:otherwise>
                            <img src="${pageContext.request.contextPath}/resources/img/자동차7.png" alt="기본 이미지" />
                        </c:otherwise>
                    </c:choose>

                </a>
                <div class="car-info">
                    <h2>${car.modelName}</h2>
                    <p>${car.manufactureYear}년식 · ${car.mileage}km · ${car.fuelType}</p>
                    <p class="price"><fmt:formatNumber value="${car.carPrice}" type="number" />만원</p>

                    <!-- 찜 해제 버튼 -->
                    <form class="unwish-form" method="post" action="${pageContext.request.contextPath}/user/wishlist/remove2">
                        <input type="hidden" name="carInfoId" value="${car.carInfoId}" />
                        <button title="찜 해제">❤️</button>
                    </form>
                </div>
            </div>
        </c:forEach>
    </div>
    </section>
</main>
<%@ include file="/WEB-INF/views/user/include/footer.jsp" %>

</body>
</html>
